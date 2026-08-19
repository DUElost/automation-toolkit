# 第二阶段：scan_result 汇总与去重设计

日期：2026-08-05
状态：待用户审阅
前置：第一阶段验收完成（`stability_Monkey-Log-Scan-GT&SPRD` V1.0，问题包数据集就绪）

## 背景与输入

第一阶段产出**问题包**（每问题一个文件夹，研发直接访问），第二阶段对问题包做
**汇总 + 去重**，生成**去重前/去重后两份 Excel**，交付后续 jira 自动化提交流水线
（第三阶段，不在本阶段范围）。

输入（只读，以 `data/phase1_dataset_v2` 为基准形态）：

```
problems/{device}_{type}_{ts}/
├─ summary.txt                        # 主输入：基础信息+堆栈+关键信息
├─ detail.txt                        # dropbox 详情（ExpType/Process 字段来源）
├─ anr_trace.txt / tombstone.txt     # CausedBy 提取补充
└─ uniview/（tar.gz）                 # 可选：解包 exp_main 增强 Detail（本阶段做）
```

## 目标输出

**两份 Excel**（每问题一行，12 列对齐 Y 盘金标准）：

| 列 | 来源 |
|---|---|
| Path | 问题包 summary.txt 路径 |
| Version | 设备版本（`{版本}/{设备}` 目录层级） |
| ExpTime | 问题时间（`YYYY-MM-DD-HHMMSS`） |
| ExpType | dropbox 类型名（`system_app_crash` 等；uniview 独有类型用 event_name） |
| CurProcess | 进程/包名 |
| Package | 包名（app 场景） |
| Detail | summary 全文（或摘要） |
| CausedBy | 堆栈关键行（按类型提取） |
| extraTag | 附加标签（预留） |
| sum | 去重后该条目代表的重复问题数 |
| snNum | 设备序列号 |
| ExpClass | 问题分类（ANR/JE/NE/KE/SWT/Jank/SR…） |

## 字段提取规则

| 字段 | 提取 |
|---|---|
| ExpType | detail.txt 条目行 `YYYY-MM-DD HH:MM:SS {type}`；summary 类型字段兜底 |
| Package | detail `Process:` 行；summary 进程包兜底 |
| CausedBy | JE：`Caused by:` 行；NE：`signal N (NAME)` 行；ANR：`Subject:` 行；SWT：watchdog 关键行；KP：panic 行 |
| ExpClass | 类型映射表（见下） |
| Version/snNum | 目录层级解析（`{save}/{version}/{device}/problems/...`） |

**ExpClass 映射表**（反编译 data_fill 语义 + 官方对照表）：

| ExpType 关键字 | ExpClass |
|---|---|
| `_anr` / ANR | ANR |
| `_crash`（非 native） | JE |
| `_native_crash` / SYSTEM_TOMBSTONE / tombstones | NE |
| system_server_watchdog / SWT | SWT |
| KERNEL_PANIC / FATAL.NE | KE |
| SYSTEM_RESTART / SYSTEM_BOOT / Reboot | SR |
| Jank | Jank |
| Assert / WCN | Assert / WCN |
| MODEM/SUBSYS_SILENT_PANIC | MSP / SSP |

## 去重算法

- **相似度**：difflib `SequenceMatcher`（参照反编译 `compare_Similarity`，原版用 quick_ratio/ratio）
- **比较对象**：`CausedBy + Package + ExpClass`（问题根因指纹）
- **阈值校准**：用 Y 盘金标准（all_data 33 条 → all_compare 12 条，去重率 63.6%）验证——
  同 CausedBy/同包问题（如 camera2 19 条跨设备 JE）应合并为一组
- **合并规则**：相似组保留代表条目（时间最早的），`sum` 记组内数量；非同组保留原样
- **组间比较**：组与组之间继续比较（相似组再合并），参照原版 compare_Similarity_all_data 语义

## 决策（推荐，待确认）

1. **输出格式**：**xlsx 为主**（openpyxl，jira 流水线友好）+ 可选 `--csv` 双输出（对齐反编译产物）
2. **工程位置**：**独立新工程** `stability_Scan-Result-GT`（第一阶段工程内加子模块会耦合；
   参照 MTK Start-Log-Scan 独立工具模式；第一阶段工程只负责采集）
3. **去重校准**：实现后先用 Y 盘金标准复现（33→12 组合同样合并），再在 phase1_dataset_v2 上跑

## 非目标

- 不做 jira 提交（第三阶段流水线）
- 不重构第一阶段采集
- 不保证与 Y 盘原版逐行一致（行为对齐：同因合并、分类一致）

## 验证

1. 单元测试：字段提取（各类型 CausedBy/ExpClass）、去重分组（构造相似/不相似问题对）
2. 金标准复现：Y 盘 33 条 → 去重后 12 条组合对齐
3. 端到端：phase1_dataset_v2 → 两份 Excel（内容抽查：camera2 类同因问题合并、ExpClass 正确）
4. 输出 Excel 打开验证（openpyxl 读回断言）
