内存泄漏监测（Android agent 主机侧，adb 驱动，只观测）
========================================================

版本锚点
--------
主脚本 memleak_monitor_2d.py：sha256 前缀 4bf9136e，1471 行，11-10 起为 v8。
入库时与生产 fleet 全部 agent 主机在跑的副本逐字节一致（sha256 已逐台核对）。
改脚本必须同步改本节版本号。

它解决什么问题
--------------
Monkey 长跑专项中，system_server 的堆会缓慢爬坡直到打满（实测 growth limit 512MB），
引发 OOM 崩溃 / JE 报错 / 整机异常。本工具周期性读取 dumpsys meminfo，按堆占比分档，
在崩溃之前主动抓 hprof，把"事后可归因"变成"事中留证据"。

监控对象与判据（v8）
--------------------
四路目标：system_server、com.android.launcher3、com.android.systemui、com.android.settings。

堆占比 = Dalvik Heap(max Pss, Rss) ÷ 上限
    system_server 的上限取 dalvik.vm.heapsize（512MB）
    其余三个应用取 dalvik.vm.heapgrowthlimit（256MB）

    L1 85% / L2 95%：各自上穿时 dump 一次（一次爬坡内 85/95 各只抓一次）
    <35% 复位：跌破复位线重新武装，允许下一轮爬坡再次触发
    RSS ≥ 976MB（1000000KB）：独立触发，与堆占比无关
    ≥75% 进入 30 秒加密轮询：避免 5 分钟采样跨越档位漏抓冲高
    logcat 早期信号（blocking GC / Clamp / OOM / LOW MEMORY）：system_server 即时补抓；
        三个应用仅在堆占比 ≥60% 时补抓（压应用侧噪声）
    dump 冷却：system_server 2 小时，应用 30 分钟（dumpheap 会触发 Full GC，代价大）

读到的 pct 可以超过 100%（实测最高 190%），这不是 bug：分子取 max(Pss,Rss)，含共享与映射页，
而 OOM 由 target footprint 决定（崩溃日志实证 target footprint = growth limit = 536870912）。
跨目标比较曲线前先确认口径。

产物
----
时序（随战役目录按日滚动）：
    meminfo_heap.txt            system_server 堆占比序列
    meminfo_heap_launcher.txt   launcher3 独立序列
    meminfo_heap_apps.txt       systemui/settings 合用一份（按文件节流，同文件内两进程会互占）
    meminfo_rss_top.txt         "system=…; launcher=…; settings=…; systemui=…" 四目标 RSS
触发样本：
    leak_<pkg>_<时间戳>.hprof  → 先 pull 到主机本地暂存，再镜像中心共享盘，两边做字节校验
目录命名由设备属性派生：<ro.product.name>_<段2>_<buildtoken>_<YYMMDD>_Systeminfo
（generate_device_log_folder_name_components 负责解析两种 display id 形态，见 test/）

文件
----
memleak_monitor_2d.py          主脚本
run_2d.sh                      启动器：nohup + timeout 到点自停 + 拉起看门狗。
                               DURATION 环境变量控制窗口长度（默认 172800 秒）
stop_2d.sh                     唯一允许的手动提前停止方式（精确 PID + cmdline 白名单，不用 pkill -f）
watchdog.sh                    只管 15.4 挂载存活与容量水位；不重启监控进程（避免批次计时清零造成全量重拉）
mount_sonic_tinno.template.sh  CIFS 挂载模板【无凭据】，复制为 mount_sonic_tinno.sh 后现场填写
hot_devices.txt                常驻 30 秒加密盯防名单（每行一个序列号，# 注释，下一轮生效）
config.json.example            判据/路径的只读参考样例——注意：主脚本不读此文件，改判据要改源码常量
MonkeyTest.sh                  设备侧压测启动器；本工具默认不调用它（见下）

使用
----
    cd /home/android/memleak
    export DURATION=$(( $(date -d "2026-11-12 18:00:00" +%s) - $(date +%s) ))
    bash run_2d.sh                     # 打印 STARTED/deadline，并写 deadline_epoch、started_at
    bash stop_2d.sh                    # 需要提前收口时

环境变量：MEMLEAK_MONKEY（默认 0）、MEMLEAK_STAGING、MEMLEAK_HOT_FILE。

压力来源约定
------------
MEMLEAK_MONKEY 默认为 0：本工具只观测，Monkey 压力由测试平台的专项负责提供。
不要在这里拉起或清理 monkey 进程，会与平台专项互相干扰（这是踩过的坑：
平台 job 数为 0 时设备侧仍可能残留 monkey 进程，属平台侧遗留，不应由本工具代删）。

已知限制
--------
1. 设备普遍无 NTP、钟差可达 12–41 小时。一切设备侧时间戳（AEE aee_ts、dropbox、
   logcat、mobilelog 目录名）换算成主机钟后才可比，否则会把 11-06 的发作读成 11-03。
2. 共享盘上 AEE 文件属 root(0640)，用 cp/rsync 不加 sudo 会静默产出空目录；
   hprof 镜像走 root 通道并做字节校验（脚本内已处理，人工归集时同样要注意）。
3. 设备中途从 adb 消失时，本轮会记 ERROR 并跳过该设备，恢复后自动继续。
4. 主机盘剩余低于 10GB 时跳过 dump（只记日志）；共享盘低于 20GB 时不写远端、保留本地镜像。

变更记录
--------
v8 2026-11-02  在 system_server + launcher3 基础上增加 systemui、settings 两路，
               判据与触发逻辑不变（launcher 通道泛化为按包参数复用）。
v7 2026-10-27  新增 launcher3 监控（堆时序独立文件、早期信号仅 ≥60% 补抓）。
v6 2026-10-21  触发线改为 85%/95% 各上穿 dump 一次；Monkey 移交平台专项，默认停用。
v5 2026-10-19  改用堆占比分档 + 30 秒加密轮询 + 本地/共享盘双写；system_server 纳入监控。
