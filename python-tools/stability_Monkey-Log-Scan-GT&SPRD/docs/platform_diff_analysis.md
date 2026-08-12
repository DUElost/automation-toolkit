# 平台差异分析与 SPRD 额外日志源设计

日期：2026-08-05
状态：已确认（设计文档 + 实现随附）

## 1. 背景

`stability_Monkey-Log-Scan-GT&SPRD` 当前按 config 驱动采集 dropbox 14 类问题。本会话在
真实 SPRD（展锐 UMS9230 / MyOS16）设备上的实测发现：**dropbox 条目在各平台行为不一致**，
且存在 dropbox 之外的关键日志源。为确保采集广度（第一阶段定位），需按平台补充额外源。

## 2. 平台差异实测依据（SPRD 设备，2026-08-04/05）

官方依据：`展锐平台异常类型Log对照表.xlsx` + 《Android 13~16 YLog抓取指南 V1.7》（docs/ 下，展锐官方）。

### 2.1 异常类型 × 日志源对照（官方）

| 异常类型 | 必需日志源 | 采集状态 |
|---|---|---|
| ANR | Aplog/Bugreport/ANR(/data/anr)/Dropbox/meminfo | ✅ 全采（meminfo 待联动） |
| TS 卡死/无响应 | + Sysdump + Tombstones + pstore | ✅ 补全（Sysdump 源已加） |
| FC | Aplog/Bugreport/Tombstones/Dropbox/meminfo | ✅ |
| KP Kernel Panic | Aplog/Sysdump/Dropbox/pstore(lastkernel) | ✅ |
| System_Server | Aplog/Bugreport/Tombstones/Dropbox/meminfo | ✅ |
| SR 系统重启 | Aplog/Bugreport/Sysdump/Dropbox/meminfo/pstore | ✅ |
| MSP modem panic | Aplog/Modem_Dump/Modem_Log/Dropbox | ✅ 补全（modem 源已加） |
| SSP subsys panic | + Sysdump | ✅ |
| CD Crash Dump | Aplog/Modem_Log/Dropbox | ✅ |

### 2.2 日志源路径（SPRD 官方）与采集状态

| 日志源 | 官方路径 | 采集 |
|---|---|---|
| YLog(AP) Aplog | `/data/ylog/ap`（poweron 子目录） | ⚠️ 体积大默认关（源可加） |
| Bugreport | `adb bugreport` | ✅ 新增（间隔 360min 可配，`interval_minutes`） |
| Sysdump/Minidump | `ylog/ap/SYSDUMP/` | ✅ 新增（事件生成，无目录自动跳过） |
| Modem_Dump(ramdump) | `ylog/modem` dump | ✅ 新增（同上） |
| Modem_Log(mdlog) | `/data/ylog/modem`（slogmodem） | ✅ 新增 |
| Tombstones | `/data/tombstones` | ✅ |
| ANR | `/data/anr` | ✅ |
| Dropbox | `/data/system/dropbox`（dumpsys 读） | ✅ |
| pstore/lastlog | `/data/ylog/last*.log` + `/blackbox` | ✅（blackbox 待加） |
| dumpsys meminfo | 异常时快照 | ❌ 事件联动（后续） |

### 2.3 MTK 路径对照（未来 qcom/mtk 平台配置依据）

| 展锐 | MTK |
|---|---|
| /data/ylog/ap | /data/vendor/aplogd |
| ylog SYSDUMP + sysdumpdb | /data/aee_exp |
| /data/ylog/modem | /data/debuglogger/mdlog1 |
| /data/tombstones | /data/tombstones |
| /data/anr | /data/anr |
| /data/ylog/last*.log | /data/vendor/dontpanic |

## 3. 平台差异实测依据（SPRD 设备实测，2026-08-04/05）

| 维度 | SPRD（实测） | 预期其他平台 | 影响 |
|---|---|---|---|
| ANR 记录 | **只写 `/data/anr/` trace，不写 dropbox `*_anr` 条目**（launcher half-ANR 实测） | MTK/QC 通常写 dropbox 条目 | SPRD 上 4 类 ANR 全量漏采 |
| SYSTEM_TOMBSTONE | **不写 dropbox 条目**（HAL 崩溃、system_server SIGSEGV 实测均无条目） | 通常写 | SPRD 上 native 崩溃漏采 |
| native tombstone | `/data/tombstones/` 8 个真实样本（tombstone_00..07） | 同（debuggerd 标准） | 补充源 |
| 内核日志框架 | `/data/ylog/`：lastkernel.log、dmesg.log、fwreboot/*/{android,kernel}.log、dropbox 副本、ap/*.ylog | MTK: mtklog/aee_exp；QC: diag_logs/slog | 内核级问题与重启原因记录 |
| `/sdcard/Logs/AP_Logs` | **不存在**（1.sh 引用但非 SPRD 路径；归属不确定，疑似 MTK 遗留） | 待确认 | 不做依赖 |
| dropbox 详情头 | Process/PID/UID/Frozen/Flags 等 | 同 | 无差异 |

## 3. 设计：platform 配置节 + 通用采集器

延续 config 驱动风格，**不硬拆代码目录**：公共层（dropbox/monkey/logcat/状态/CLI）不变，
平台层以 `config.json -> platform.<name> -> sources[]` 声明额外日志源。

```json
"platform": {
  "sprd": {
    "sources": [
      {"name": "anr_traces",      "device_path": "/data/anr",            "dest_folder": "data_anr",         "wrap": "anr"},
      {"name": "tombstones",      "device_path": "/data/tombstones",     "dest_folder": "sys_native_crash", "wrap": "tombstone"},
      {"name": "ylog_lastkernel", "device_path": "/data/ylog/lastkernel.log", "dest_folder": "ylog",        "wrap": "raw"},
      {"name": "ylog_dmesg",      "device_path": "/data/ylog/dmesg.log", "dest_folder": "ylog",             "wrap": "raw"},
      {"name": "ylog_fwreboot",   "device_path": "/data/ylog/fwreboot",  "dest_folder": "ylog/fwreboot",    "wrap": "raw", "recursive": true}
    ]
  }
}
```

### 3.1 源类型语义

| wrap | 处理 | 落盘形态 |
|---|---|---|
| `anr` | `/data/anr/` 下 `*_half`/`*.txt`/`*.trace` 文件；解析头部（`Subject:`/`Cmd line:`/`----- dumping pid:`/`----- pid .. at ..`）构造 dropbox 条目包装（条目头 + `====` + Process/PID/Timestamp/Subject + trace 全文） | `{save}/{version}/{device}/data_anr/{device}_{pkg}_data-app-anr_{ts}.txt`（pkg 取自 Cmd line，ts 取自文件名/头部；无法解析时用 `unknown`/文件 mtime） |
| `tombstone` | `/data/tombstones/` 下 `tombstone_*`（跳过 `.pb`）；解析 `Cmdline:`/`pid:`/`Timestamp:` 构造包装（tag=SYSTEM_TOMBSTONE） | `{save}/{version}/{device}/sys_native_crash/{device}_{pkg}_SIGSEGV_{ts}.txt` |
| `raw` | 原样复制（单文件或目录递归） | `{save}/{version}/{device}/ylog/...` |

包装形态与上游 dropbox 条目一致 → 下游 `scan_result_GT` 的
`sys_ANR_Report`/`SYSTEM_TOMBSTONE_Report` 可直接消费（已用真实 trace/tombstone 验证）。

### 3.2 增量与去重

- 状态文件 `output_{device}_platform.json`（`{save}/{version}/` 下）记录每源已处理文件
  指纹：`{name}:{size}:{mtime}`（设备端 `ls -la` 获取）；指纹相同则跳过。
- ANR 文件名用 trace 内时间戳（失败时用文件名 `pid_XXX_YYYY-MM-DD-HH-MM-SS` 或 mtime）。
- tombstone 按文件名序号天然单调，指纹去重即可（同名同大小跳过）。

### 3.3 平台探测

- CLI `--platform <sprd|qcom|mtk|none>`（默认 `auto`）：
  - auto：`adb shell ls /data/ylog` 存在 → `sprd`；否则无额外源（后续平台再扩展）。
- 平台配置缺失时静默跳过（`platform: {}`）。

### 3.4 落盘目录（与 dropbox 采集共用）

`{save}/{version}/{device}/{data_anr|sys_native_crash|ylog/...}`——ANR 与 tombstone 与
dropbox 采集同目录，命名规则对齐（`{device}_{pkg}_{tag}_{ts}.txt`），下游无感知。

## 4. 已知限制

- `auto` 探测依赖 `/data/ylog` 存在性；其他平台（qcom/mtk）的源清单待有设备后补充。
- ANR 包装的 `Timestamp` 若解析失败用 mtime（精度秒），logcat 对应段可能不精确；
  本采集器不追加 logcat（与 dropbox 采集不同）——trace/tombstone 本身即完整现场。
- ylog `ap/*.ylog`（1.4GB 级）默认不采集（体积），仅拉 lastkernel/dmesg/fwreboot。

---

## 4. 事件驱动采集体系（2026-08-05 增补）

第一阶段定位：定期扫描 + 报错检测 + **按报错类型按需导出对应日志** + 每报错一份汇总 txt。

### 4.1 事件检测（信号 → 官方场景）

| 信号（增量机制） | 场景 |
|---|---|
| dropbox 14 类计数新增（状态文件对比） | ANR/FC/System_Server/KP/MSP/SSP/SR |
| /data/anr 新文件（平台源指纹） | ANR |
| /data/tombstones 新文件 | FC/System_Server(native) |
| fwreboot 新目录 / lastkernel 变化 | SR/KP |
| dropbox SYSTEM_RESTART/SYSTEM_BOOT | SR |

场景映射：config events.scene_map（信号关键字 → 场景）。

### 4.2 按需导出（事件触发，后台线程不阻塞轮询）

| 动作 | 说明 |
|---|---|
| dropbox 详情 | 每条目采集时（无 ylog 分段覆盖则舍弃） |
| bugreport | 条目关联命名 `{device}_{type}_{ts}_bugreport.zip`；临时文件+原子改名；冷却白名单 `cooldown_event_types`（白名单内受 `cooldown_minutes` 限制，白名单外每次触发都导）；已存在跳过 |
| meminfo 快照 | `{device}/meminfo/meminfo_{ts}.txt` |
| ylog ap 时间窗段 | 解析 ap 分段名（`MMdd_HHmmss`，当年补全）→ 异常时间后第一段 → 前后各 2 段 → `{device}/ylog/correlated_ap/`（参照 MTK correlated_mobilelogs） |

### 4.3 每报错汇总 txt（第二阶段输入）

`{device}/summary/{device}_{type}_{ts}_summary.txt`：
- 基础信息（类型/场景/时间/设备/进程包/信号源）
- 堆栈（按场景：JE 栈 / NE backtrace / ANR 主线程栈 / KP panic / SR 重启）
- 关键信息（CausedBy/signal/导出文件）

实现：`modules/analyse/summary_builder.py`；由 dropbox 条目采集后自动生成。

### 4.4 已知约束

- 冷启动（首次部署）只拉存量不触发场景动作（避免误报）
- 平台源按文件独立指纹去重（修复早期单指纹 bug）
- adb 命令必须列表参数形式（Windows shell=True 会截获管道）

---

## 5. 展锐 uniview 异常监控机制（2026-08-05 实测发现）

### 5.1 定位：展锐的 AEE 等价物

MTK 平台有 AEE（Android Exception Engine）常驻监控：ANR/crash 时主动生成 dbg 日志并聚合各类信息。
**展锐平台等价物为 uniview**（ylog 守护进程内置，init.svc.ylog），路径 /data/ylog/uniview_exception/。

### 5.2 机制（实测）

| 能力 | 实现 |
|---|---|
| 异常检测（9 类 FAULT） | /data/ylog/uniview_exception/{类型}.{event_id}/：ANR.103000005 / JE.103000004 / NE.103000003 / FATAL.NE.103100003 / SWT.103000006 / Reboot.103000002 / Jank.102200004 / Assert.109000001 / WCN.109000003 |
| 时间点（毫秒级） | unievent_info JSON：kick_datetime（含毫秒）+ pid + proc + 	ag；与实测触发完全对应（SWT 17-21-44.946 / NE 17-19-14.538 / JE 17-13-10.262 / FATAL.NE 09-12-30） |
| 主动聚合 | 每次异常一个 {seq}-{ts}.tar.gz（2-6MB）：exp_main.txt / exp_detail.txt（命名与 MTK AEE 一致）+ 30+ 项系统状态（SYS_ANDROID_LOG / SYS_KERNEL_LOG / SYS_BINDER_INFO / SYS_MEMORY_INFO / SYS_PROPERTIES / SYS_PROCESSES_AND_THREADS / SYS_CPU_INFO / PROCESS_STATE / PROCESS_OOM_SCORE 等） |
| 事件元信息 | event_id / event_type=FAULT / event_level / event_name + 设备信息（sn/software_version/soc_model/branch） |

### 5.3 与现有采集体系的关系（接入探究中）

- uniview **比 dropbox 更可靠**：MyOS16 dropbox 漏 ANR 条目，uniview 全记录（ANR.103000005）；时间点毫秒级
- uniview 异常包 ≈ 现成问题包（与 MTK aee_exp 同构）
- 事件时间点（kick_datetime）可驱动 bugreport/ap/meminfo 关联导出
- 原实现（dropbox 采集 / 平台源 / 问题包 / summary）保留策略见接入方案

### 5.4 uniview 接入实现（2026-08-05 已实施）

- **平台源**：config platform.sprd.sources 新增 {"name":"uniview","wrap":"uniview"}（/data/ylog/uniview_exception）
- **增量检测**：每类型目录 unievent_info 的事件行（含 kick_datetime/event_time/reboot_reason）按 seen 计数增量；事件行过滤（设备信息行/类型行不算事件）
- **事件信号**：新事件的 	ag + event_name 加入信号 → scene_map 匹配（含 1030000xx event_id 关键字与 Jank/Assert/WCN 场景）
- **归档**：tar.gz 按时间戳精确匹配（原始格式 17-21-44 / 压缩格式 172144 双变体）落盘 {device}/{type}_{ts}/（**不解包**，exp_main 提取留第二阶段）；无对应 tar 的事件跳过归档
- **时间戳归一**：kick_datetime 兼容 - 与 : 分隔（watchdog 用连字符、Jank/Assert/Reboot 用冒号），统一为问题包 ts 规范 YYYY-MM-DD-HHMMSS
- **问题包合并**：同秒对齐——dropbox 先建包（类型名沿用），uniview tar 补充进包；uniview 独有类型（Jank/Assert/WCN/Boot Category）以类型目录名建包
- **主从关系（实测定稿）**：uniview 为主（事件检测+毫秒时间点+聚合包），dropbox 为辅（SYSTEM_TOMBSTONE 等补充类型 + 详情 + 旧数据兼容）
- 验证：7 个 uniview 聚合包与 dropbox 问题包同秒对齐归档；26 tests passed

### 5.5 half 事件处理（2026-08-06 增补）

**现象**：ANR 类型目录无 tar.gz，只有 	mp/sub_event_{pid}/pre_logs/{SYS_ANDROID_LOG,SYS_KERNEL_LOG}
（half ANR：半程 ANR 只完成 pre_logs 收集，未触发打包；且无 unievent_info 记录）。

**处理**：uniview 源对无事件记录但有 	mp/ 的类型目录（half 事件）兜底补采 pre_logs
到同类型最新问题包（包根）（子串匹配，如 ANR → data-app-anr 包）。
实测：launcher half-ANR 的 SYS_ANDROID_LOG（4.6MB）+ SYS_KERNEL_LOG（1.5MB）已归档。

### 5.6 同秒问题包合并（2026-08-06 实施，以 uniview 为准）

**问题**：同一事件（如 17:19:14 sensors）被三个来源各自建包（uniview native-crash / 平台源 tombstone / dropbox SYSTEM_TOMBSTONE）→ 同一问题多个文件夹。

**方案（参照 MTK MonkeyAEEinfo 时间戳对齐关联 + 演进为物理合并）**：
1. 扫描顺序：platform 源中 uniview 排最前 → tombstone/anr 随后 → dropbox 最后（uniview 先建包）
2. 同秒匹配：_resolve_package_dir 检查设备目录下 *_{ts} 同秒包 → 存在则复用（补充 detail/tombstone），否则新建
3. 实体类型名：uniview 事件类型（native-crash 等）；dropbox/tombstone 内容全部补充进包

**效果**：一个事件一个文件夹（uniview 聚合包 + tombstone + dropbox detail + summary），v10 数据集 36 包无重复。

### 5.7 uniview tar 导出修复（2026-08-06，review 驱动）

review 发现导出缺口（设备 18 个 tar 仅导出 7 个），3 个工具根因已修复：

1. **时间戳变体不全**：kick_datetime 用 `:`（`2026-05-24_15:56:53`）而 tar 名用 `-`（`15-56-53`）——匹配失败漏 10 个（Reboot×7/Assert/Jank/WCN）。修复：变体集合加入 `replace(":","-")`（tar 名格式）。
2. **seen 提前推进**：无 tar/pull 失败也记已处理 → 永久漏（JE 003）。修复：逐事件推进——仅 tar 成功拉取（ok）或确认设备无对应包（none，同日无 tar）才推进；设备有同日 tar 但匹配失败（nomatch）不推进，下次重试。
3. **bugreport .partial 命名**：adb bugreport 实际生成 `<path>.zip`——temp 命名改为 `.partial.zip` 并兜底 glob 重命名。

验证：v11 数据集 18/18 tar 全量导出；Reboot 7 包含聚合包；27 tests passed。

### 5.8 dropbox 补充包取舍规则（2026-08-07 实验确认，待落地）

**背景**：dropbox 报错若无可查日志上下文则无意义。实验（v12 真机数据 40 包）：
- uniview 实体（tar 聚合包/事件记录）= 完整上下文，无条件保留（25 包）
- 纯 dropbox 包：logcat 有效（60s 内）或 ylog ap 分段覆盖事件时间点 → 保留（12 包）
- 无 logcat 且 ap 窗口外（07-01 老数据，ylog 已轮转丢失）→ 舍弃（3 包：SYSTEM-TOMBSTONE 07-01 121711/121732/121741）

**规则（2026-08-07 已落地 dropbox_monitor.write_problem；logcat 已从第一阶段移除——logd 环形缓冲对历史事件无效，上下文只认 ylog ap 分段）**：
1. 同秒 uniview 实体 → 并入（现有逻辑，聚合包即上下文）
2. 查设备 ap/ 分段（一次 adb ls）事件时间在窗口内 → 建包 + 导出该分段到共享 {version}/ylog/（已存在则跳过，包内写 ylog.txt 引用）
3. 窗口外 → 舍弃（日志记录不建包）

**注意事项**：ap 分段设备仅保留约 15 段（08-04 起）；分段名 {seq}-{MMdd_HHmmss}--{MMdd_HHmmss}（MMdd 无年份，跨年需容错）；082 段带 _poweron 后缀不影响解析。
**空壳事件包（2026-08-07 追加）**：uniview 事件无对应 tar 时（连环 crash 设备只留首个包），
包内除 unievent_info/summary 元信息外无任何现场文件（tombstone/detail/prelogs）且无 ylog
分段覆盖 -> 舍弃（如 07-01 NE 121733/121742）。有同秒 tombstone 的事件由 tombstone 源独立
建包保留（tombstone 含 Abort message + backtrace + BuildId，可定位源码行）。
### 6. 多设备联调（2026-08-12，模拟验证 + 代码修复）

**现状**：单设备实测完成；多设备真机需第 2 台设备（待提供）。

**模拟验证发现并修复 3 个多设备隐患**：
1. **ylog 跨设备冲突**：ap 分段/raw 日志原共享 {version}/ylog/（两台设备同名段互相覆盖）——已修复为按设备子目录 {version}/ylog/{device}/（platform_sources._dest_dir、_link_ap_segment、dropbox_monitor._ylog_dir、_prune_event_shell 同步）
2. **第二阶段 snNum 单设备假设**：_find_problem_dirs 的 meta 只记录首设备，多设备时全部记录 snNum 错——已修复为从包路径层级推导（{root}/{version}/{device}/{pkg}）
3. **去重误并（关键）**：不同 pc 的 backtrace 首帧因公共前后缀占比高（实测 ratio 0.947 >= 0.9）被误合并——已修复为 NE 类提取 pc 地址指纹硬匹配（同 pc 才合并），无指纹类型保持 SequenceMatcher

**模拟验证结果**：2 设备 6 包 -> 去重后 3 组（F1 跨设备 Count=3 DeviceCount=2 ✓、F2 Count=2 DeviceCount=2 ✓、独占 Count=1）；Rom_Ram 按设备对应（64GB+8GB / 128GB+8GB）
**真实数据复核**：v13 报表 25 -> 28 条（3 处误并拆开）；NE 组按 pc+进程正确归并（同 pc 不同进程分开）
测试：第一阶段 31 passed / 第二阶段 21 passed
### 6.2 多设备真机验证（2026-08-12）

设备：6R0A57SSAE6000218（MyOS16.0.0_Z2581_GEN_AF，64GB+4GB）+ 6R0A77SSDE6000033（MyOS16.0.1_Z2582_AE，128GB+4GB，userdebug）

验证结果：
1. 主入口 ThreadPoolExecutor 自动发现两设备并行扫描 ✓
2. 版本目录隔离（MyOS16.0.0 / MyOS16.0.1）+ 设备目录 + ylog 归设备（{version}/{device}/ylog/，同版本多设备不混；存量包 ylog.txt 引用已批量重建）✓
3. rom_ram 按设备采集（64GB vs 128GB）✓
4. 新设备手动触发 NE（kill -SEGV systemui）/JE（am crash）/SWT（am hang）/FATAL.NE（kill -SEGV system_server）全部记录 ✓
5. 跨设备归并：JE shell-induced 组 Count=2 DeviceCount=2；NE dfe08 systemui 组 Count=4 DeviceCount=2、system_server 组 Count=6 DeviceCount=2（同 pc+同进程跨设备合并）✓
6. 报表：去重后 39 条（28 原 + 新设备 11）✓
### 6.3 ylog 迁移缺失恢复（2026-08-12）

ylog 迁移 {version}/ylog -> {version}/{device}/ylog 后，ap 段未随 raw 源重拉（ap 段为事件驱动导出，非 raw 指纹源）：
- 补拉 2 段（设备端仍存在：101-0811_193924--0812_005001.ylog 53.5MB、114-0811_202246.ylog 92MB）
- 引用归一 3 包（101 无 end 旧名 -> 带 end 现名，同一段）
- 删除 18 包失效引用（082/084/098 段设备端已轮转，ap 仅保留约 15 段；包保留，ylog.txt 移除）
- 校验：失效引用 0；报表 39 条不变
注意：ap 段设备端轮转约 15 段（约 5-7 天窗口），超窗报错的 ylog 上下文不可恢复（取舍规则已覆盖）
### 6.4 报表排查修复（2026-08-12，review 驱动）

1. **Detail 模板统一**：_build_detail 缺 SWT 分支（无 tar 但有 detail.txt 的 SWT 包 Detail 回退 summary）——已加 SWT 分支（detail.txt 提取 Subject: Blocked in + 栈帧）；且 header 恒输出，无现场包也输出 Device_id 模板（不再回退 summary）
2. **去重数字清洗**（对齐 MTK get_str_similar format_str）：SequenceMatcher 比较前去除数字/0x 地址/@ 符号——141439（for 365s）与 141606（for 31s）仅阻塞秒数不同，清洗后归并（同阻塞模式 Count=4）；NE 类 pc 指纹不受影响
3. **SWT 无阻塞详情兜底**：仅 Searching 行/压力统计（无 Subject: Blocked in）的 SWT CausedBy 走 MTK 兜底（random 各自保留，不误并）——对齐 MTK SWT 强制默认格式语义
验证：Detail 全模板（SUMMARY 残留 0）、SWT 5 组（210108 组 Count=4 + 4 个兜底）、报表 37 条；23 passed（第二阶段）
### 6.5 采集机制对齐 MTK MonkeyAEEinfo（2026-08-12）

| 项 | 调整前 | 调整后（对齐 MTK） |
|---|---|---|
| 轮询间隔 | 60s 固定 | 180s（config polling_interval_seconds） |
| 轮询方式 | 固定 sleep | 补齐式：sleep_time = 180 - 扫描耗时 |
| 连续失败 | 异常等 2×interval | 连续 5 次失败 -> 等 60s（config max_consecutive_failures/failure_wait_seconds） |
| 异常等待 | 同上 | 30s（config exception_wait_seconds） |
| 心跳 | 无 | 不引入（单机轮询工具，adb 在线检查 + adb 命令超时 30s 已覆盖；心跳为服务型健康检测） |
| 多设备并发 | max_workers=设备数 | min(max_thread_pool_workers=4, 设备数) |

实机验证：首轮扫描后进入 180s 补齐等待，无频繁轮询；31 passed