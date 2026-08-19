# ABPS config.xml → collect.py 迁入规则对照表

来源：`LogInsight_V1.4/prebuilt/tools/ABPS1.1/ABPS/_internal/config/config.xml`  
目标：`stability_Scan-Result-GT/modules/collect.py` + `modules/caused_by_rules.py`  
日期：2026-08-18（状态更新：2026-08-19）

## 与 LogInsight 的关系

| 维度 | LogInsight / ABPS | 本工具（第二阶段） |
|------|-------------------|-------------------|
| 定位 | 交互式日志分析桌面工具 | 稳定性测试流水线：汇总 + 去重 → Jira 输入 |
| 规则来源 | `config.xml` keywords / stabinfos / sysinfos | `caused_by_rules.py` 默认集 + `config.json` 覆盖 |
| 产物 | ABPS HTML 分析报告、故障树、keyline | **MTK 格式 Excel**（`Result_*_MonkeyAEE_SPRD_*.xls`），表名 `aeeexp` |
| 粒度 | 可多报告 / 多轮分析 | **一包一行**（去重前 `_org` / 去重后各一份） |
| extraTag | ANR 子类型等写入列 | **恒空**；ANR 子类型 / SWT half 写入 **Detail** 附录 |

**结论**：字段提取与 CausedBy 规则与 ABPS **对齐**；不生成 ABPS 报告，属产品边界而非待办缺口。详见根目录 `README.md`「与 LogInsight 的关系」。

## 使用说明

| 列 | 含义 |
|----|------|
| **迁入字段** | `CausedBy`（去重主键）、`extraTag`（ABPS 原设计；本工具多改写入 Detail）、`Detail`（现场附录，不参与去重） |
| **优先级** | P0=直接影响去重；P1=补全提取成功率；P2=仅丰富 Detail |
| **状态** | 已实现 / 已实现（Detail）/ 已实现（ylog_enrich）/ 未实现 / 不建议迁入 |

**去重前置条件不变**：`ExpClass + Package` 相同后，才比较 `CausedBy`（见 `dedup.py`）。

**uniview 聚合包内日志文件映射**（ABPS `log_type` → tar 内路径）：

| ABPS log_type | uniview tar 内对应 |
|---------------|-------------------|
| `SYS_ANDROID_LOG` | `*/SYS_ANDROID_LOG` |
| `SYS_KERNEL_LOG` | `*/SYS_KERNEL_LOG` |
| `SYS_SGM_LOG` | `*/SYS_SGM_LOG` |
| `dump_report.txt` | `*/dump_report.txt` |
| `exp_main.txt` / `exp_detail.txt` | 包根（事件描述/现场） |
| `crash.log` / `events.log` / `system.log` | 多为 ylog 解压后的命名；uniview 包优先读 `exp_detail` + `SYS_*` |
| `/fwreboot/` + `android.log` | 第一阶段 `ylog/fwreboot/*/android.log`；第二阶段 `ylog_enrich` 时间窗补充 |

---

## 一、`<keywords>` → CausedBy / extraTag

| ABPS first_name | ABPS second_name | 匹配串 | 建议 ExpClass | 迁入字段 | collect.py 动作 | 优先级 | 状态 |
|-----------------|------------------|--------|---------------|----------|-----------------|--------|------|
| ANR | InputDispatchTimeout | `Input dispatching timed out` | ANR | extraTag → **Detail** | `ANR子类型: InputDispatchTimeout`（`caused_by_rules.anr_subtypes`） | P1 | 已实现（Detail） |
| ANR | ServiceTimeout | `executing service` | ANR | Detail | 同上 | P1 | 已实现（Detail） |
| ANR | BroadcastTimeout | `Broadcast of Intent` | ANR | Detail | 同上 | P1 | 已实现（Detail） |
| ANR | ContentProvider | `ContentProvider not responding` | ANR | Detail | 同上 | P1 | 已实现（Detail） |
| ANR | ForegroundServiceTimeout | `did not then call Service.startForeground` | ANR | Detail | 同上 | P1 | 已实现（Detail） |
| ANR | FailToCompleteStartTimeout | `failed to complete startup` | ANR | Detail | 同上 | P1 | 已实现（Detail） |
| ANR | NoResponseTimeout | `No response to` | ANR | Detail | 同上 | P1 | 已实现（Detail） |
| AndroidWdg | — | `watchdog: Blocked in` | SWT | CausedBy | `_extract_caused_by_swt` 含此模式 | P0 | 已实现 |
| FDEReboot | — | `Just asked init to shut down class main` | SR | Detail | 不写入 CausedBy（SR 故意不合并） | P2 | 不建议迁入 CausedBy |
| VendorInterfaceIncompatible | — | `Vendor interface is incompatible` | JE/NE | extraTag | 未做 | P2 | 未实现 |
| NativeHang | — | `Native hang monitor trigger` | KE | CausedBy | KE 分支优先于泛 `panic` | P1 | 已实现 |

**已实现（ANR）**：main 线程 `at` 顶帧 → CausedBy；`Subject:` 兜底。  
**已实现（SWT）**：`Blocked in` / `WATCHDOG KILLING` / `watchdog: Blocked in` → CausedBy。

---

## 二、`<stabinfos>` → CausedBy 提取（稳定性主类）

| ABPS type | 匹配串 | log_type | → ExpClass | CausedBy 提取规则 | 去重意义 | 优先级 | 状态 |
|-----------|--------|----------|------------|-------------------|----------|--------|------|
| javacrash | `FATAL EXCEPTION IN SYSTEMPROCESS:` | crash.log | JE | `Caused by:` > 异常类行 | 高 | P0 | 已实现 |
| javacrash | `FATAL EXCEPTION:` | crash.log | JE | 同上 | 高 | P0 | 已实现 |
| javacrash | `am_crash:` | events.log | JE | 解析异常类（`am_crash:` 方括号内） | 中 | P1 | 已实现 |
| nativecrash | `libc    : Fatal signal` | crash.log | NE | 检测用；CausedBy 取 backtrace `#00 pc` | 高 | P0 | 已实现 |
| nativecrash | `DEBUG   : Native Crash TIME:` | crash.log | NE | 定位现场；CausedBy 仍用 tombstone | 低 | P2 | 仅 Detail |
| watchdog | `WATCHDOG KILLING SYSTEM PROCESS:` | crash.log | SWT | CausedBy 整行 / `Blocked in` 段 | 高 | P0 | 已实现 |
| watchdog | `Blocked in` | events.log | SWT | CausedBy 整行 | 高 | P0 | 已实现 |
| watchdog | `Watchdog: WAITED_HALF` | system.log | SWT | 不作 CausedBy；Detail 写 `half watchdog` | P1 | 已实现（Detail） |
| anr | `am_anr` | events.log | ANR | 检测用；CausedBy 仍用 trace main `at` | 高 | P0 | 已实现 |
| poweroff | `shutdown the device` 等 | system/kernel.log | SR | 不合并；MTK 随机串兜底 | — | — | 已实现（不合并） |
| reboot | `reboot the device` / `RescueParty` 等 | system.log | SR | 不合并 | — | — | 已实现 |
| androidcommon | `am_proc_start` 等 | events/system.log | — | 仅 Detail 上下文 | 无 | P2 | 不建议 |
| kernelcommon | `killed by signal` 等 | kernel.log | KE | `panic` 优先；`killed by signal` 兜底 | 中 | P1 | 已实现 |

**stabinfos 未覆盖、但 config 有 sysinfo 的：**

| ABPS sysinfo type | 匹配串 | → ExpClass | 迁入建议 | 状态 |
|-------------------|--------|------------|----------|------|
| stab_cpassert | `Modem Assert` / `WCN-CP2-EXCEPTION` / `Gnss Assert` 等 | Assert/MSP/WCN | Detail 附录 `--- Assert/Modem 现场 ---` | 已实现（Detail） |
| stab_watchdog (fwreboot) | `Blocked in` / `WATCHDOG KILLING` | SWT | `ylog_enrich` 读 `fwreboot/*/android.log` 补 CausedBy/Detail | 已实现（ylog_enrich） |

---

## 三、`<sysinfos>` uniview 专项 → Detail / 辅助 CausedBy

| ABPS type | 匹配串 | log_type | 用途 | 迁入字段 | 优先级 | 状态 |
|-----------|--------|----------|------|----------|--------|------|
| uniview_aosp_cpuinfo | `ActivityManager: ANR in` | SYS_ANDROID_LOG | 定位 ANR 时间段 | Detail | P2 | 未实现 |
| uniview_sprd_cpuinfo | `ActivityManager:` | SYS_ANDROID_LOG | SPRD CPU 快照 | Detail | P2 | 未实现（可选） |
| uniview_lmk | `lowmemorykiller: Kill` | SYS_ANDROID_LOG | 内存压力上下文 | Detail | P2 | 已实现 |
| uniview_oom | `Out of memory: Killed process` | SYS_KERNEL_LOG | OOM 上下文 | Detail | P2 | 已实现 |
| uniview_io_error | `I/O error` / `CMD17 Error` 等 | SYS_KERNEL_LOG | 存储异常上下文 | Detail | P2 | 已实现 |
| uniview_thermal_kernel | `cpu0 temp:` | SYS_KERNEL_LOG | 温控上下文 | Detail | P2 | 未实现（可选） |
| stab_javacrash | `FATAL EXCEPTION` | SYS_ANDROID_LOG | JE CausedBy 兜底 | CausedBy | P1 | 已实现 |
| stab_nativecrash | `libc    : Fatal signal` | SYS_ANDROID_LOG | 引导读 tombstone | CausedBy 间接 | P1 | 已实现 |
| stab_watchdog | `Blocked in` / `WATCHDOG` | SYS_ANDROID_LOG | SWT CausedBy 兜底 | CausedBy | P0 | 已实现 |
| NativeHang (keyword) | `Native hang monitor trigger` | dump_report.txt | KE 重启类 | CausedBy | P1 | 已实现 |

---

## 四、按 ExpClass 汇总：CausedBy 读取顺序（当前实现）

### ANR

```
1. anr_trace.txt → main 线程首条 at/# 行          [已实现] → CausedBy
2. tar DATA_ANR_TRACES/*                         [已实现] → 同 1
3. detail.txt → Subject:                          [已实现] → CausedBy 兜底
4. SYS_ANDROID_LOG → 7 种子类型关键字             [已实现] → Detail（ANR子类型，非 extraTag）
5. 无 → 空 → 同秒双写 / MTK 随机串                 [已实现]
```

### JE

```
1. detail.txt → Caused by:                        [已实现] → CausedBy
2. detail.txt → xxxException 行                   [已实现] → CausedBy
3. exp_detail / SYS_ANDROID_LOG → FATAL EXCEPTION [已实现] → CausedBy
4. SYS_ANDROID_LOG / events → am_crash: 解析      [已实现] → CausedBy 兜底
```

### NE（含 FATAL.NE / native_crash / SYSTEM_TOMBSTONE）

```
1. detail.txt / tombstone.txt → backtrace #00 pc   [已实现] → CausedBy
2. tar DATA_TOMBSTONES/tombstone_*（多份按 pid/时间匹配）[已实现] → CausedBy
3. signal 行                                      [已实现] → CausedBy 弱兜底
4. Package：tombstone Cmdline 优先于 unievent proc [已实现]
5. FATAL.NE：uniview 源目录 / summary 场景 FATAL  [已实现] → ExpClass=FATAL.NE（去重仍走 NE 族 pc 指纹）
```

> `config.json`：`FATAL.NE` → ExpClass `FATAL.NE`（逻辑族 `NE`，与 ABPS nativecrash 提取链一致）。

### SWT

```
1. detail.txt → Blocked in / Subject:            [已实现] → CausedBy
2. exp_detail.txt → Blocked in / WATCHDOG       [已实现] → CausedBy
3. SYS_ANDROID_LOG → Blocked in / watchdog:       [已实现] → CausedBy
4. keywords AndroidWdg → watchdog: Blocked in     [已实现] → CausedBy
5. half（WAITED_HALF）→ Detail 说明               [已实现]；CausedBy 空 → 随机串不合并
6. ylog/fwreboot/android.log（时间窗）            [已实现（ylog_enrich）]
```

### KE

```
1. detail / SYS_KERNEL_LOG → panic 行             [已实现] → CausedBy
2. dump_report.txt → Native hang monitor trigger  [已实现] → CausedBy
3. killed by signal 弱兜底                        [已实现]
```

### SR / Jank / Assert / WCN

```
CausedBy → _fallback_caused_by 随机串（故意不合并）  [已实现]
stab_cpassert 关键字 → Detail 附录                  [已实现]
```

---

## 五、config.json 扩展结构（已落地）

规则默认在 `modules/caused_by_rules.py`（`DEFAULT_RULES`），`config.json` 的 `caused_by_rules` 块可覆盖局部字段（如 JE `am_crash_sources`、KE `patterns`）。

```json
{
  "caused_by_rules": {
    "JE": { "am_crash_sources": ["SYS_ANDROID_LOG", "events.log"] },
    "KE": {
      "patterns": ["Native hang monitor trigger", "panic", "killed by signal"],
      "kernel_sources": ["SYS_KERNEL_LOG"]
    }
  }
}
```

---

## 六、迁入实施记录（2026-08-19 结项）

| 步骤 | 内容 | 状态 |
|------|------|------|
| 1 | `FATAL.NE` → ExpClass `FATAL.NE`（NE 族去重） | ✅ 已完成 |
| 2 | NE：tombstone `Cmdline` + pid/时间选包 | ✅ 已完成 |
| 3 | SWT：exp_detail / SYS_ANDROID_LOG / fwreboot enrich | ✅ 已完成 |
| 4 | ANR：7 子类型 → **Detail**（非 extraTag，产品定稿） | ✅ 已完成 |
| 5 | JE：SYS_ANDROID_LOG + am_crash | ✅ 已完成 |
| 6 | Assert/MSP/WCN：stab_cpassert → Detail | ✅ 已完成 |

**未纳入结项范围（P2 可选）**：VINTF extraTag、thermal/vmstat 附录、`ActivityManager: ANR in` 时间段定位。

---

## 七、明确不建议迁入为 CausedBy 的规则

| ABPS 规则 | 原因 |
|-----------|------|
| `reboot` / `poweroff` 全系 | SR 按 MTK 语义每条独立，不按原因合并 |
| `androidcommon` / `kernelcommon` 泛日志 | 无稳定根因签名，易误并 |
| `vmstat` / `meminfo` / `thermal` 等 sysinfo | 仅系统态，适合 Detail 附录（thermal 尚未做） |
| `am_crash:` 单独作 CausedBy（不解析异常类） | 行内容随进程变化，去重噪音 |
| `libc : Fatal signal` 单独作 CausedBy | 太粗，应用 backtrace pc |

---

## 八、与 ABPS 分析报告字段的对应

| ABPS 分析报告字段 | 本工具字段 |
|-------------------|------------|
| `signal` / `backtrace #00` | `CausedBy`（NE） |
| `process` / `pid` | `Package` / Detail 头 |
| `keyline` | 并入 `CausedBy` 或 Detail Backtrace |
| 故障树 `signal11` | 近似 NE CausedBy，但缺 pc 库名，**不能替代** pc 指纹 |
| `UniviewAndroidWdg` | 对应 SWT；落到 `Blocked in` 文本才有去重意义 |
| ABPS HTML 报告全文 | **不生成**；见 MTK 格式 Excel `Detail` 列 |
