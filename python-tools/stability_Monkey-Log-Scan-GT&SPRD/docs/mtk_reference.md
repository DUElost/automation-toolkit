# MTK 平台参照与日志类型对比

日期：2026-08-05
参照源：
- `F:\automation-toolkit\python-tools\stability_Offline-MonkeyTestTool\MonkeyAEEinfo_260622.py`（MTK 第一阶段工具，3281 行）
- `Y:\sonic_tinno\X6726B-OP_15.1.2.175_162209_SU_monkey_MonkeyAEEinfo`（该工具运行产物，29 台设备）
- `F:\automation-toolkit\python-tools\stability_Start-Log-Scan`（MTK 离线扫描工具，异常识别引擎）

## 1. MTK 设备日志画像（X6726B monkey 压测）

### 1.1 目录结构（每设备）

```
{device}/
├─ aee_exp/                          # AEE 异常数据库
│   └─ 2026_0519_214530_596_db.00.JE/  # {时间戳}_db.{序号}.{类型}
│       ├─ BUILD_INFO
│       ├─ db.00.JE.dbg (4MB)        # 异常数据库（exp_main 等解析源）
│       └─ ZZ_INTERNAL
├─ correlated_bugreports/            # 关联 bugreport（时间戳前缀对齐）
│   └─ 2026_0519_214530_596_bugreport.zip.partial.zip (11MB)
└─ correlated_mobilelogs/            # 关联 mobilelog 段（时间窗）
    └─ kernel_log_12__2026_0519_175313 (63MB)
```

### 1.2 异常量级（29 台 × 1299 异常）

| 类型 | 数量 | 占比 |
|---|---|---|
| JE | 1052 | 81% |
| ANR | 237 | 18% |
| NE | 10 | 1% |

## 2. MTK 工具机制要点（MonkeyAEEinfo_260622.py）

| 机制 | 实现要点 | GT 侧落地 |
|---|---|---|
| 异常检测 | 轮询 AEE 目录（/data/aee_exp + /data/vendor/aee_exp）增量 db 目录 | dropbox 计数增量（GT 等价） |
| **bugreport 关联导出** | 异常时间戳命名 `{ts}_bugreport.zip`；临时 `.partial` + 原子改名；已存在跳过；冷却 `cooldown_event_types=["ANR","CRASH"]` 白名单 | ✅ 已实施（条目关联命名 + partial + 白名单） |
| **mobilelog 时间窗** | `export_correlated_mobilelogs`：解析分段名时间段 → 异常后第一段 → 前后各 2 段 | ✅ 已实施（ylog ap 分段同款逻辑） |
| 设备双路径 | aee_paths 双路径扫描 | GT：dropbox + 平台源 |
| 运维健壮性 | CIFS 健康探测、心跳、磁盘检查、线程池管理、超时恢复 | 未实施（按需引入） |
| db 解密 | db.dbg → 文本（_decrypt_aee_log） | GT 无对应（dropbox 即文本） |
| Monkey 管理 | process_name/restart_command 配置化 + 保活 | GT 已解耦（独立触发） |

## 3. 日志类型对比（MTK vs GT/SPRD）

### 3.1 异常类型

| 语义 | MTK（AEE/TNE） | GT/SPRD（本会话） | 对应 |
|---|---|---|---|
| Java 崩溃 | JE / fatal_JE / OOM_JE | FC → JE（dropbox *_crash） | 同构 |
| Native 崩溃 | NE / fatal_ne | FC(native)/System_Server → NE（*_native_crash/TOMBSTONE/tombstones） | 同构 |
| 无响应 | ANR / hang_detect / HANG | ANR / TS | 同构 |
| 内核崩溃 | KE | KP → KE（KERNEL_PANIC/lastkernel） | 同构 |
| 系统看门狗 | SWT / watchdogTimeout / HWT | System_Server(watchdog) → SWT | 同构 |
| 系统重启 | HW_Reboot / hw_reboot | SR（SYSTEM_RESTART/SYSTEM_BOOT/fwreboot） | 同构 |
| 卡 logo | stucklogo | TS（定屏） | GT 无专门信号 |
| 功耗/其他 | OCP reboot / EE | - | MTK 特有 |
| 特殊 API 缺陷 | KernelAPI / SystemAPI | - | MTK db 特有 |
| modem 类 | mdlog（debuglogger） | MSP/SSP/CD（/data/ylog/modem） | 同构 |
| 厂商 code | 0x00160002 等 | - | MTK 特有 |

### 3.2 日志源路径

| 展锐 GT | MTK |
|---|---|
| /data/ylog/ap | /data/vendor/aplogd |
| ylog SYSDUMP + sysdumpdb | /data/aee_exp |
| /data/ylog/modem（slogmodem） | /data/debuglogger/mdlog1 |
| /data/tombstones | /data/tombstones |
| /data/anr | /data/anr |
| /data/ylog/last*.log | /data/vendor/dontpanic |
| dropbox（dumpsys） | AEE db（aee_exp） |

## 4. 第二阶段参照（MTK 离线扫描工具）

`stability_Start-Log-Scan` 的架构（第二阶段汇总去重的参照）：

- **模式驱动**：ScanAeeDaily/ScanAeeMTBF/ScanAeePlatform/MergeExcels/DedupOrgExcel 等 mode 类，每模式一个 config json
- **识别引擎**：recognize_except.py（40KB）解析 AEE db → 异常分类（NE/JE/ANR/EE/KE/SWT/HANG/OCP/HW_Reboot/HWT）
- **产出**：Excel 报告（xlwt/xlrd）+ 去重（DedupOrgExcel）+ 合并（MergeExcels）
- 与 GT 反编译产物（all_data.csv 去重前 / all_compare_data.csv 去重后 + ExpClass 分类）语义一致
