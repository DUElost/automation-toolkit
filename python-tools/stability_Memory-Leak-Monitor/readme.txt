内存泄漏监测（Android agent 主机侧，adb 驱动，只观测）
========================================================

版本锚点
--------
主脚本 memleak_monitor_2d.py：sha256 前缀 c873d067，1544 行，为 v12。
前一版 v11（8a6c1541，1516 行）已移入 archive/memleak_monitor_2d_261119_v11.py。
再前一版 v10（307f43b6，1495 行）在 archive/memleak_monitor_2d_261116_v10.py；
v8（4bf9136e，1471 行）在 archive/memleak_monitor_2d_261102_v8.py。
在跑版本不等于本文件，且必须逐台 sha 回读才算数（现态经 2026-11-19 20:06 逐台复测）：
· 现态：**fleet 无进程在跑**。Owner 于 2026-11-19 14:13 提前收口，20 台 `stop_2d.sh`
  全部返回 `MONITOR_EXITED`，`STOP_REQUESTED` 标记在位；`deadline_epoch` 仍为
  1795341600（11-22 18:00）未改动，随时可按「使用」节重开——重开会清零档位与批次计时
  （见已知限制 6）。
· 停前版本：20/20 = v11（8a6c1541，本次已归档
  archive/memleak_monitor_2d_261119_v11.py）。下发于 2026-11-18 18:04:07–18:35:13
  批次串行完成（3 台无 535 族设备的主机在 14:12–14:17 先做金丝雀），逐台 sha 回读一致；
  换版本期间单台空窗 4.2–35.3 分钟。此前 11-16 至 11-18 两天里 main 已是 v11 而 20 台
  仍跑 v10（307f43b6）——「已合并」不等于「已生效」。
· 停前实测：adb 在线 258 台 / 535 族 210 台、堆曲线 630 份（210×3）；四日窗口
  （11-16 17:48 起）在中心存储累计 130 份 hprof ≈ 30.6GB，**system_server 四日零触发**
  （当日最高堆占比 49.5%），抓取全部来自 launcher3 / settings 侧。
· 未回收：主机本地暂存 241 份 ≈ 60.2GB（均为已镜像到中心存储的副本，删除前必须逐份
  字节比对）。
· 停止或重启前必须逐台读 `/proc/<pid>/environ` 确认 `MEMLEAK_MONKEY` 未置 1：
  `stop_2d.sh` 触发的收尾会停设备上的 monkey 并删设备侧文件（本役 20/20 均为停用）。
· v12（c873d067，1544 行）只入库未下发：Owner 于 2026-11-19 决定本工具不再下发新版本，
  fleet 停在 v11 二进制。若日后改主意，按「使用」节重启会清零档位、批次计时与当日重复
  门槛（见已知限制 6、8），必须另行决策后再做。
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
    当日重复门槛（v12 新增，只管「早期信号补抓」）：同一 (设备, 进程) 当天已抓过后，
        补抓需堆占比再涨 DUMP_REPEAT_MIN_PCT_GAIN = 5（百分点）才放行，否则只记一条 INFO 跳过。
        上穿档（L1/L2）**不受该门槛约束**——档位上穿本身就是新信息，且堆跌破 35% 复位后重新
        爬上 L1 也必须抓，否则会丢掉「同日第二次发作」的证据；但上穿成功后会把当日峰值抬到
        max(旧值, 本次占比)，于是随后的平台期补抓会被同一门槛收住。
        RSS 触发不带堆占比：既不受闸，也不抬峰值（不拿无法比较的量去压触发）。
        顺序：冷却在先（应用 30 分钟 / system_server 2 小时）→ 门槛在后，两道闸相互独立。
        可用 MEMLEAK_DUMP_REPEAT_GAIN 覆盖，设 0 即关闭门槛（退回 v11 行为）。

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
hot_devices.txt                常驻 30 秒加密盯防名单（每行一个序列号，# 注释）。
                               改文件后必须重启监测进程才生效——名单只在启动时读一次
                               （HOT_DEVICE_SERIALS 在 import 时求值，轮询里不重读）。
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
7. 盯防名单与「不得中途重启」（见 6）互相牵制：改 hot_devices.txt 必须重启才生效，
   而重启又清零档位。要加名单就随下一次计划内的重启一起做，别为它单独重启。
8. 当日重复门槛的状态（每设备每进程当天已 dump 的最高占比）只存内存：重启即清零，
   清零后第一次补抓不受门槛约束。被拦下时每个冷却周期留 1 条 INFO（应用侧最坏≈48 条/日/
   主机），这是「为什么没抓到第二份」的留痕，不是新的噪声类别。上穿档不受该门槛约束（见
   判据节），因此单设备单日的份数上界由「档位次数 + RSS 次数 + 达标补抓」决定，而不是 1 份。

变更记录
--------
v12 2026-11-19  当日重复 dump 门槛（唯一判据变更，只减产物、不减覆盖）。
                · 范围收敛（Owner 选 C）：初版把四个带堆占比的触发点全部纳入门槛，自查发现
                  会连带挡掉「同日第二次发作」——堆跌破 35% 复位后重新爬上 L1 时，本次占比
                  低于当日峰值，增幅为负 → 只记 INFO 不产 hprof。现改为门槛**只作用于早期
                  信号补抓**，上穿档以 gate_repeat=False 一定放行但仍抬峰值，复位后的再爬升
                  必然经上穿档出证据，丢证据的风险不存在。
                · 动因（现场实测，非推测）：11-18 全 fleet 只出 8 个 (设备,进程) 键的 38 份
                  hprof，其中 AZ6QNX6A06000008/com.android.launcher3 一台占 30 份 / 9164MB
                  （当日总量 10570MB 的 87%）；11-19 同键再出 23 份 / 7252MB，且当天再无
                  其它设备触发。堆体量已在平台期（328MB 上下反复），重复份没有新增信息。
                · 改法：_trigger_hprof_dump 增 heap_pct 与 gate_repeat 形参；补抓路径传
                  heap_pct=ratio*100 受闸，上穿路径传 heap_pct + gate_repeat=False（放行 + 抬峰值），
                  RSS 路径两者都不传。同日同键增幅 <DUMP_REPEAT_MIN_PCT_GAIN 个百分点即 INFO 跳过；
                  抓取成功后状态取 max 上移，门槛键含当日日期，跨日互不影响。
                · 覆盖度：11-18 的 8 个键各留当日首份即覆盖当日全部问题类别，重复的 30 份
                  （该台 29 + 另一台 1）可省 9013MB / 当日 10570MB；11-19 的 1 个键重复 22 份，
                  可省 6937MB / 当日 7252MB。爬坡继续抬升（含复位后重新上穿）一律照抓。
                · 新增 test/test_dump_repeat_gate.py 13 例：单元层 9 例（当日首份放行、增幅不足
                  跳过且不回写状态、增幅达标放行并上移、按 (设备,进程) 分键、跨日不残留、无占比
                  不受闸、门槛可置 0 关闭、冷却与门槛两道独立闸、readme 门槛值与源码常量同轴）
                  + 调用点层 4 例（走真实 check_launcher_heap：上穿低于当日峰值仍放行、补抓在
                  平台期被拦、上穿先播峰值再收住后续补抓、readme 写明哪些路径受闸）。
                回归：v12 字节 32 passed；同一测试集跑在 v11 字节上 19 passed + 13 errors
                （全部 AttributeError：v11 无 last_dump_pct_by_day 状态，新例无法在旧行为下成立）。
v11 2026-11-16  三条 PR #28 复核整改。判据、触发逻辑、产物路径、节流窗口均未动：
                · P2-1/N4  `proc=` 字段收回多进程文件。v10 把日志文案用的 label 同时当作 proc= 入参，
                  launcher 曲线被写成「… | proc=launcher3 heap=…」，既与「行格式约束」的口径不符，
                  也让同一文件里并存两种行格式（11-02 起的 v8/v9 曲线无该字段）；apps 侧短名/全名
                  并存（launcher3 vs com.android.systemui）随之消失。launcher 的节流键退回
                  (设备, 文件, "")，与 v9 行为一致。新增调用方视角的
                  test_proc_field_is_limited_to_multi_process_file（两路各写一行 + 共用行格式正则）。
                · N6  非 535 跳过日志按序列号去重：每台只在首轮记 1 条 INFO，之后转 DEBUG。
                  v10 每轮逐台重复打印——`.58` 当日 2098 行日志里 214 行是这条跳过 INFO（10.2%）、
                  16 台唯一设备（外推日增≈1600 行/host），与泄漏无关的行刷成日志主体。
                  去重键取大写序列号，大小写异常不重复计。
                  口径注意：TEST_LOGGER 常驻 INFO 级别（Logger.setDebugMode 全文无调用点，
                  实测当日日志 DEBUG 行数 0），所以生产上每台就是「只留首轮 1 行」，不是每行都
                  可查；要逐轮留痕必须给 logger 接 debug 开关（本次未做，属日志级别策略另案）。
                  新增 test_non_535_skip_is_logged_once_per_serial、
                  test_skip_notice_dedup_is_case_insensitive（断言调用层级，不宣称落盘）。
                · N3  文档纠错（无代码行为变更）：本节与源码注释原写「hot 名单下一轮生效」，实际
                  get_hot_device_set() 只在 import 时被调用一次（全文仅 2 处：定义 + 赋值），轮询里
                  零调用，改文件必须重启进程才生效。本轮生产新增的 9 台 hot 之所以生效，纯属 v10
                  部署恰好重启了进程，不是「下一轮」的功劳。已知限制补第 7 条说明它与「不得中途重启」
                  的牵制。
                回归：新例在 v10 字节上 3 failed / 16 passed，在 v8 字节上 9 failed / 10 passed；
                本版本 19 passed。
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
