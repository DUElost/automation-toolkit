# stability_Scan-Result-GT

第二阶段：问题包**汇总与去重**（第一阶段问题包 → 去重前/去重后两份 .xls，对齐 MTK 工具），
交付后续 jira 自动化提交流水线。

## 与 LogInsight 的关系

本模块**不是** LogInsight 桌面工具的替代品，而是稳定性测试流水线的第二阶段：

```
第一阶段（Monkey-Log-Scan-GT&SPRD）采集问题包
        ↓
本工具汇总、字段提取、去重
        ↓
MTK 格式 Excel → 第三阶段 Jira 自动化
```

| 维度 | LogInsight / ABPS | 本工具 |
|------|-------------------|--------|
| 规则来源 | `ABPS/_internal/config/config.xml` | `modules/caused_by_rules.py`（默认与 ABPS 对齐）+ `config.json` 可覆盖 |
| 产物 | ABPS HTML 分析报告、故障树 | **MTK 格式 Excel**（`Result_*_MonkeyAEE_SPRD_*.xls`，表名 `aeeexp`） |
| 粒度 | 可多报告、交互分析 | 每问题包一行；去重前/后各一份 |
| extraTag | ABPS 写入 ANR 子类型等 | **恒空**；ANR 子类型、SWT half 等写入 **Detail** 附录 |

字段提取（`CausedBy` / `Detail` / ExpClass 映射）与 ABPS 规则**已对齐**；差异为产品边界，详见
[`docs/abps_collect_migration.md`](docs/abps_collect_migration.md)。

## 用法

```bash
python scan_result.py -d <第一阶段保存根目录> [--threshold 0.9]
```

| 参数 | 说明 |
|---|---|
| `-d` | 第一阶段保存根目录（含 `{version}/{device}/{type}_{ts}/`）；产物 .xls 生成在此 |
| `--threshold` | 去重相似度阈值（默认 0.9，覆盖 config；NE 类用 pc 指纹硬匹配，不受阈值影响） |

## 输出（生成在 -d 目录下）

- `Result_None_None_MonkeyAEE_SPRD_{时间戳}.xls`：去重后（每组代表一行，Count=组内条数）
- `Result_None_None_MonkeyAEE_SPRD_{时间戳}_org.xls`：去重前（每问题一行，Count=1）

15 列（MTK 格式，表名 aeeexp）：`Id / Path / Version / ExpTime / ExpClass / ExpType / CurProcess / Package / Detail / CausedBy / extraTag / Count / Activity / DeviceCount / Rom_Ram`

## 字段提取

| 字段 | 来源 |
|---|---|
| ExpType | 问题包名类型段（`system-app-crash` → `system_app_crash`） |
| ExpClass | 类型映射（`config.json expclass_map`）；Jank/Assert/WCN/SR 的 CurProcess/Package 填类型名 |
| Package | detail `Process:` / anr_trace `Cmd line:` / unievent_info proc / summary，路径型统一 `/` |
| Detail | MTK 识别报告模板：Device_id / 解析库版本 / 手机版本 / 异常包名（含应用版本）/ 异常进程 / pid / Backtrace（根因行+栈帧）+ 类型附加现场段 |
| CausedBy | NE：backtrace 首帧 pc（去重指纹）；JE：`Caused by:`/异常行；ANR：main 栈顶帧；SWT：`Blocked in` 详情；SR/无根因：MTK 兜底（随机串防误合并） |
| Rom_Ram | 设备级 `rom_ram.json`（第一阶段采集，SN 对应）优先，聚合包 SYS_* 提取兜底 |
| DeviceCount | 去重组内不同设备数（跨设备归并） |

## 去重规则

- 前置：ExpClass + Package 相同
- **NE**：CausedBy 提取 pc 地址指纹，同 pc 才合并（不同 pc 的 backtrace 首帧相似度高会被误并，实测修复）
- 其他类型：difflib `SequenceMatcher` 比较 CausedBy（**比较前清洗：去数字/0x 地址/@ 符号**，对齐 MTK
  `get_str_similar(format_str)`——阻塞秒数/行号等动态值不干扰归并）
- 空 CausedBy：同秒视为同一事件（uniview + dropbox 双写）
- SWT 无阻塞详情（仅 Searching 行/压力统计）：CausedBy 走 MTK 兜底（随机串，各自保留不误并）
- 组内保留 ExpTime 最早的代表条目，`Count` = 组内条数；`DeviceCount` = 组内设备数
- **跨设备归并**：同根因问题跨设备合并为 1 条（DeviceCount>1），Rom_Ram 组内多配置以 `/` 拼接
  （如 `64GB+4GB/128GB+4GB`）

## 测试

```bash
python -m pytest test/ -v
```

45 passed（classify / collect / dedup / export / caused_by_rules / ylog_enrich）。

## 验证状态（真机 Z2581/MyOS16，2026-08 验收）

- 单设备 + 多设备（两版本）+ 多版本验证通过；跨设备归并 DeviceCount=2 实测确认
- Detail 全统一 Device_id 模板（37 行无残留）；CausedBy 空 0；Rom_Ram `/` 0
- 手动触发数据集（JE/NE/FATAL.NE/SWT/ANR/Reboot）报表核对通过

## 目录结构

```
scan_result.py            # 主入口（-d 输出）
config.json               # ExpClass 映射 / 去重阈值 / 输出配置（15 列 / 文件名模板）
modules/collect.py        # 问题包扫描 + 字段提取（MTK Detail 模板 / pid / Rom_Ram）
modules/classify.py       # ExpClass 映射
modules/dedup.py          # pc 指纹 + 清洗 SequenceMatcher 去重
modules/export.py         # xlwt .xls 导出（MTK 样式/列宽）
modules/caused_by_rules.py # CausedBy/Detail 规则（默认对齐 ABPS config.xml）
test/                     # pytest
docs/abps_collect_migration.md  # ABPS → collect 规则对照与结项状态
docs/superpowers/         # spec 与实施计划
```
