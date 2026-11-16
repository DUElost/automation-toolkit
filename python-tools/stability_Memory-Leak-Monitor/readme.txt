内存泄漏监测（Android agent 主机侧，adb 驱动，只观测）
========================================================

版本锚点
--------
主脚本 memleak_monitor_2d.py：sha256 前缀 c70ccc22，1502 行，为 v11。
前一版 v10（307f43b6，1495 行）已移入 archive/memleak_monitor_2d_261116_v10.py。
再前一版 v8（4bf9136e，1471 行）在 archive/memleak_monitor_2d_261102_v8.py。
在跑版本不等于本文件：2026-11-16 逐台 sha 实测 fleet 20 台仍跑 v10（307f43b6，
窗口至 2026-11-18 18:00）。v11 只入库未下发；下发要按「使用」节重启监测，而重启会
清零档位与批次计时（见已知限制 6），必须等窗口收口或另行决策后再做。
改脚本必须同步改本节版本号；行为变更必须新增版本并把上一版移入 archive/，不得原地替换不留档。

它解决什么问题
--------------
Monkey 长跑专项中，system_server 的堆会缓慢爬坡直到打满（实测 growth limit 512MB），
引发 OOM 崩溃 / JE 报错 / 整机异常。本工具周期性读取 dumpsys meminfo，按堆占比分档，
在崩溃之前主动抓 hprof，把"事后可归因"变成"事中留证据"。

监控对象与判据（v10）
----------------------
四路目标：system_server、com.android.launcher3、com.android.systemui、com.android.settings。

机型范围（v10 新增，硬约束）：只监测 535 族，按序列号前缀白名单过滤——
    AHFFNX / ATHTNX（MLD-NX2）、ASEBNX / AZ6QNX（MLD-NX3-Claro）、AT7QNX / AW8QNX（MLD-NX3）
    前缀取自 fleet 全部 20 台主机的实测序列号枚举，不得凭印象增删。
    非 535 族（现场实测存在：A2WENX、AVCGNX → MLY-LX2/LX3；AS4XNX → MOD-LX3）必须跳过：
    它们不属于本专项，纳入只会带来成百上千条 ERROR 与无谓的轮次耗时。
    换机型复用时可用 MEMLEAK_SERIAL_PREFIXES="A,B,…" 临时覆盖，不必改源码。

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
    meminfo_heap_apps.txt       systemui/settings 合用一份，v9 起每行带 proc=<pkg>、
                                节流按 (设备, 文件, 进程) 分列，两进程各自成行
    行格式约束（v11 明确并加测试锁定）：proc= 只出现在多进程合写的 apps 文件里，
    且取值为全限定包名；单进程文件（meminfo_heap.txt / meminfo_heap_launcher.txt）
    行内不带 proc=，与 v9 起的历史曲线保持同一解析口径。
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
config.json.example            判据/路径的只读参考样例——注意：主脚本不读此文件，改判据必须改源码常量
archive/                       历史版本（_<YYMMDD>_<ver>.py 命名，沿用仓库既有惯例）
MonkeyTest.sh                  设备侧压测启动器；本工具默认不调用它（见下）

使用
----
    cd /home/android/memleak
    export DURATION=$(( $(date -d "2026-11-12 18:00:00" +%s) - $(date +%s) ))
    bash run_2d.sh                     # 打印 STARTED/deadline，并写 deadline_epoch、started_at
    bash stop_2d.sh                    # 需要提前收口时

环境变量：MEMLEAK_MONKEY（默认 0）、MEMLEAK_STAGING、MEMLEAK_HOT_FILE、
          MEMLEAK_SERIAL_PREFIXES（默认取 535 族六个前缀）。

压力来源约定
------------
MEMLEAK_MONKEY 默认为 0：本工具只观测，Monkey 压力由测试平台的专项负责提供。
不得在这里拉起或清理 monkey 进程，会与平台专项互相干扰（这是踩过的坑：
平台 job 数为 0 时设备侧仍可能残留 monkey 进程，属平台侧遗留，不得由本工具代删）。

已知限制
--------
1. 设备普遍无 NTP、钟差可达 12–41 小时。一切设备侧时间戳（AEE aee_ts、dropbox、
   logcat、mobilelog 目录名）换算成主机钟后才可比，否则会把 11-06 的发作读成 11-03。
2. 共享盘上 AEE 文件属 root(0640)，用 cp/rsync 不加 sudo 会静默产出空目录；
   hprof 镜像走 root 通道并做字节校验（脚本内已处理，人工归集时同样要注意）。
3. 设备中途从 adb 消失时，本轮会记 ERROR 并跳过该设备，恢复后自动继续。
4. 主机盘剩余低于 10GB 时跳过 dump（只记日志）；共享盘低于 20GB 时不写远端、保留本地镜像。
5. 主脚本按主机全部 adb 在线设备枚举，因此一台主机上若同时挂着多个专项的设备，
   非 535 族自 v10 起会被过滤跳过；但同一主机上其它 535 项目的设备仍会一并纳入观测，
   这是有意取舍（宁可多看，不可漏看）。
6. 重启监测会清零档位状态与批次计时，泄漏观测须重新计数；非必要不得在窗口中途重启。

变更记录
--------
v11 2026-11-16  `proc=` 字段收回多进程文件。v10 把日志文案用的 label 同时当作 proc= 入参，
                launcher 曲线被写成「… | proc=launcher3 heap=…」，既与上面「行格式约束」的
                文档口径不符，也让同一文件里出现两种行格式（11-02 起的 v8/v9 曲线无该字段）；
                apps 侧的短名/全名并存（launcher3 vs com.android.systemui）随之消失。
                判据、触发逻辑、节流键 (设备, 文件, 进程) 与产物路径均未变。
                动因：PR #28 独立复核 P2-1/N4。新增 test_proc_field_is_limited_to_multi_process_file
                ——该例在 v10 字节上必失败（实测 1 failed, 9 passed），在 v11 上通过。
v10 2026-11-16  监测限定 535 族：get_connected_devices 按序列号前缀白名单过滤，
                非 535 设备只记一条 INFO 并跳过；新增 MEMLEAK_SERIAL_PREFIXES 覆盖口子。
                线上动因：4 台主机单日累计 ERROR 1493/1135/536/453 条，全部来自非 535
                设备反复插拔（A2WENX/AVCGNX/AS4XNX），与泄漏无关却淹没日志。
v9  2026-11-16  _append_heap_series 节流键由 (设备, 文件) 改为 (设备, 文件, 进程)，
                应用侧曲线补 proc=<pkg> 字段。修复前 systemui 会吃掉 settings 的高水位行
                （现场实证：settings 实测 89%，文件里峰值只有 15%）。
v8 2026-11-02  在 system_server + launcher3 基础上增加 systemui、settings 两路，
               判据与触发逻辑不变（launcher 通道泛化为按包参数复用）。
v7 2026-10-27  新增 launcher3 监控（堆时序独立文件、早期信号仅 ≥60% 补抓）。
v6 2026-10-21  触发线改为 85%/95% 各上穿 dump 一次；Monkey 移交平台专项，默认停用。
v5 2026-10-19  改用堆占比分档 + 30 秒加密轮询 + 本地/共享盘双写；system_server 纳入监控。
