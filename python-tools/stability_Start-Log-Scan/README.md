# 日志扫描工具 (Log Scan Tool)

版本：V2.1.1（反编译修复版；版本历史见 `modules/common/Version.py`）

## 简介

本工具用于扫描和分析 MTK 平台的 AEE (Android Exception Engine) 和 TNE 日志文件，自动识别各类异常并生成 Excel 报告。

## 环境要求

- Python 3.7 或 3.8
- Windows 操作系统

## 安装依赖

`-match_issues` 只需标准库；扫描与测试需要以下依赖（`modules/common/Db.py` 导入 pymysql）：

```bash
pip install xlwt xlrd pymysql
```

## 基本用法

```bash
python start_log_scan.py -m <模式> -d <日志目录> -p <地点>
```

## 参数说明

| 参数 | 说明 | 示例 |
|------|------|------|
| `-m` | 扫描模式 | 0, 1, 2 |
| `-d` | 待扫描日志目录（相对路径） | `2025-12-22` |
| `-d_abs` | 待扫描日志目录（绝对路径） | `D:\logs\2025-12-22` |
| `-p` | 扫描地点标识 | `SH` |
| `-s` | 跳过所有解压步骤 | 无参数 |
| `-sz` | 跳过解压 zip 文件 | 无参数 |
| `-inc` | 增量扫描：全量写 `_org.xls`，去重报告仅保留相对上次 `_org.xls` 的新增 Path | 无参数 |
| `-b` | 指定扫描往前第几天的日志，-1 表示所有 | `-1` |
| `-del` | 删除不提交的 log 目录 | 无参数 |
| `-merge_files` | 合并多个已生成的 xls（`_org.xls` 或去重 xls） | `a_org.xls b_org.xls` |
| `-merge_files_list` | 从文件读取待合并 xls 列表（一行一个，追加在 `-merge_files` 之后） | `files.txt` |
| `-match_issues` | 对已有问题代表做归并匹配（只读，配合 `-o`），见「成员关系与问题匹配」 | `req.json -o out.json` |

### 扫描模式

| 模式 | 说明 |
|------|------|
| 0 | AEE + TNE |
| 1 | 仅 AEE |
| 2 / `tne` | TNE 汇总去重（扫描 .tne、解析、org/final 去重出表） |
| 3 | Fans |
| 4 | Usic |
| 5 | Platform Monkey |
| 6 | Daily |
| 7 | Jenkins |
| 8 | HWAsan |
| 23 / `transsion` | Transsion：CausedBy 使用 SYS_ANDROID_LOG 中的 BIHash |

## 使用示例

```bash
# 扫描 2025-12-22 目录下的 AEE 日志
python start_log_scan.py -m 1 -d 2025-12-22 -p SH

# 扫描所有 AEE 和 TNE 日志
python start_log_scan.py -m 0 -d 2025-12-22 -p SH

# 跳过解压步骤（已解压的日志）
python start_log_scan.py -m 1 -d 2025-12-22 -p SH -s

# Transsion 模式：CausedBy 填 BIHash（可用 -m 23 或 -m transsion）
python start_log_scan.py -m transsion -d_abs "D:\logs\test" -p SH -s

# TNE 汇总去重（可用 -m 2 或 -m tne；默认模式与 transsion 不变）
python start_log_scan.py -m tne -d .\test2\ -p SH -s

# Monkey 长稳每隔若干天增量扫（防同一 Path 重复提单）
python3 start_log_scan.py -d /path/to/MonkeyAEEinfo/ -sz -inc
```

## 增量扫描（`-inc`）

用于 Monkey 多日测试、每隔几天扫描并提单的场景：避免同一物理 dump（同一 Path）重复进入去重报告。

### 行为

| 输出 | 内容 |
|------|------|
| `*_org.xls` | 始终全量 |
| `*.xls`（去重） | 仅「本次 org Path − 同目录最新一份 `*_org.xls` 的 Path」，再走原有去重 |
| `*_summary.json` | 含 `incremental` 字段（基准 org、差集数量等） |

### 差集规则

- 基准：结果目录中文件名时间戳**最新**的 `*_org.xls`（本次写出之前已存在的那份）
- 比较键：Excel 中的 **Path** 列（精确字符串匹配）
- 只挡同一 Path；同类问题的新 dump / 新机器仍会进入去重报告
- 无历史 `*_org.xls` 时：与不加 `-inc` 相同（全量去重）
- 第 N 次只需对比最新一份全量 org：因每次 org 都是全量，已包含此前所有 Path，效果等价于排除历史已扫过的 Path

### 使用注意

1. 需要作为基准的报告必须保留标准命名的 `*_org.xls`；改名或删除后不会被当作基准。
2. 若某次中间结果不想参与后续差集，可将该次 `*_org.xls` 改名（例如加后缀 `AAA`），工具只会认仍符合 `*_org.xls` 命名的文件。
3. 两次扫描的 Path 形态需一致（同一路径视角，如都是 Linux `/home/...`）；`-b` 按日期过滤**不能**替代 `-inc`。
4. summary 中可核对：`incremental.prev_org_excel`、`prev_path_count`、`delta_org_count`、`aee_result_final_count`。

### 示例时间线

```text
第1次（可不加 -inc）：生成 ..._20261016_113849_org.xls + 去重报告 → 提单
第2次 -inc：相对最新 *_org.xls 做 Path 差集 → 只提新增
第3次 -inc：相对第2次全量 org 做差集（其中已含第1次 Path）→ 只提相对第2次的新增
```

## 离线 org 去重

当工具已经生成 `*_org.xls` 后，可以直接对该文件做离线去重，不需要重新扫描日志。

```bash
# 默认使用 shanghai 规则
python start_log_scan.py -dedup_org "F:\path\Result_xxx_org.xls"

# 可选 factory 规则
python start_log_scan.py -dedup_org "F:\path\Result_xxx_org.xls" -side factory
```

说明：

- `-dedup_org` 传入单个 `*_org.xls` 文件路径
- `-side` 可选，默认值为 `shanghai`
- `-side factory` 时使用工厂侧配置
- 输出文件与输入文件同目录，命名格式为 `*_org_dedup_org_YYYYMMDD_HHMMSS.xls`

## 输出文件

报告生成在 `-d` 参数指定的目录下：

- `Result_{jira}_{reporter}_MonkeyAEE_{place}_{YYYYMMDD}_{HHMMSS}_org.xls` - 原始结果（全量；`-inc` 时仍为全量）
- `Result_{jira}_{reporter}_MonkeyAEE_{place}_{YYYYMMDD}_{HHMMSS}.xls` - 去重后结果（`-inc` 时为 Path 差集后再去重，用于提单）
- `Result_{jira}_{reporter}_MonkeyAEE_{place}_{YYYYMMDD}_{HHMMSS}_summary.json` - 扫描摘要

## 成员关系与问题匹配（V2.1.0 起）

供 STP 平台读取问题归并结果。合并规则只在工具端维护（`modules/dedup/aee_rule.py`），平台不复刻比较逻辑。

### 去重规则（rule `mtk-aee-dedup` v1）

- **singleton**：Path 含 `fatal` 且 CausedBy 含 `detailToBeDone`，直接成为新组代表，自身不比较；后续行仍可并入它。
- **similarity**：ExpClass 完全相等，Package 完全相等，CausedBy 相似度 ≥ `ratio_std_aee`（默认 90）；按去重列表顺序取首个命中。
  - 相似度为 `difflib.SequenceMatcher.quick_ratio() × 100`，比较前去掉 `0x…`、`@…` 与所有数字；CausedBy 先截断到 10000 字符。
- **filtered**：白名单、关键字等过滤，不进入去重表。

### 成员关系文件 `*_members.json`

每次 AEE 扫描（`ScanAeeTne` 路径）与 `-dedup_org` 都在报表旁写一份，前缀与 `_org.xls` 相同。xls 格式不变。

- `rows[]`：org.xls 每行一条，`org_row`（= Id + 1，即数据行序号）、`path`（Path 列原文）、`branch`、`filter_reason`、`group`、`is_representative`、`similarity_to_rep`、签名 hash；
- `groups[]`：`final_row`（去重表行号）、`representative_row`、`member_rows`、`count`、`device_ids`、代表签名原文；
- `meta`：工具版本与 commit、解析库版本、规则 id/version/参数、白名单 sha256、两份 xls 的文件名与 sha256；
- schema：`stp.scan_membership` 1.0；`filter_reason` 新增取值只增不改。

`-inc` 下，未进入差集的行记为 `filtered` / `incremental_prev_path`。

### 对已有问题匹配 `-match_issues`

```bash
python start_log_scan.py -match_issues req.json -o result.json
```

- 只依赖标准库，在加载扫描依赖前分流；不联网、不写 `report_history`；Python 3.7+。
- 输入 `stp.issue_match_request`：`existing[]`（`issue_id`、`exp_class`、`package`、`caused_by`）与 `rows[]`（`ref`、`exp_class`、`package`、`caused_by`、`path`），顺序由调用方固定。
- 每行先依次比 `existing`，未命中再比本次新开的组，仍未命中则开新组 `n{k}`；singleton 行不比较，总是新组。
- 输出 `stp.issue_match_result`：`results[]` 含 `matched_issue_id` 或 `new_group`、`similarity`、`branch`，以及与 sidecar 相同的 `meta`。
- 退出码：0 成功，2 输入不合法，1 内部错误。

### 发布

- tag：`start-log-scan/vX.Y.Z`，与 `Version.py` 的 `VERSION = "VX.Y.Z_YYYYMMDD"` 一致；
- `python release/make_release.py --tag start-log-scan/vX.Y.Z --out <dist>` 导出到 `<dist>/X.Y.Z/` 并写 `release.json`（commit、文件 sha256）；
- 已发布版本不可原地修改；规则语义变化必须提升 `aee_rule.RULE_VERSION`；
- `tests/test_aee_dedup_golden.py` 保证去重输出与基线逐字节一致，改动规则时需同时更新基线并说明原因。

### 解压失败 dbg 的设备号（V2.1.1 起）

解压失败的 dbg 会生成兜底行，其 DeviceId 与 Detail 中的 `Device_id:` 按以下规则取值：

- 串号取 dbg 路径中 `aee_exp` 或 `vendor_aee_exp` 目录的上一级目录（取离 dbg 最近的一个），与扫描根布局无关。Owner 于 2026-11-05 核对 78,014 行历史 MTK 数据，均满足这条规则。
- 该目录名须匹配 `^[A-Za-z0-9]{6,32}$` 且不是纯数字。路径中没有 `aee_exp` / `vendor_aee_exp`，或上一级形态不符时，记为 `unknown_device_id`，此时不读任何 `SYS_PROPERTIES`。不再从路径任意位置用正则兜底取值。
- `SYS_PROPERTIES` 只在该串号目录内查找。其中 `ro.serialno` 与路径串号不一致时，记为 `discard_device_id`；`ro.build.display.id` 照常使用。

### 外部工具自检（V2.1.1 起）

Linux 上扫描开始前只检查文件存在且可执行（不以退出码判断；`aee_extract` 退出码 255 是常态，成败以 `.DEC` 是否生成为准）：`tools/aee_extract/aee_extract`、`tools/decompress/linux/tne_decompress`、`tools/expdb/p-new-db`。任一不满足时，以非 0 退出（`EXIT_CODE_INVALID_ENV`），不生成报表，也不进入 failed-dbg 兜底。这三个文件在 git 中的模式为 `100755`；`release.json` 的 `files_mode` / `executables` 记录模式，导出时按模式设置权限。

## 支持的异常类型

| 类型 | 说明 | CausedBy 格式 |
|------|------|---------------|
| Java (JE) | Java 异常 | Java 异常信息行 |
| Native (NE) | Native 崩溃 | Native 堆栈信息 |
| ANR | 应用无响应 | CPU info + 线程 dump |
| Kernel (KE) | 内核异常 | PC/LR + 内核堆栈 |
| Kernel API Dump | 内核 API 异常 | `class:[xxx] process:[xxx] detail info:[xxx]` |
| System API Dump | 系统 API 异常 | 堆栈信息 |
| External (EE) combo | 外部异常-combo | ASSERT 信息 |
| External (EE) modem | 外部异常-modem | 随机字符串 |
| External (EE) scp | 外部异常-scp | 随机字符串 |
| SWT | 系统看门狗超时 | 随机字符串 |
| HWT | 硬件看门狗超时 | 随机字符串 |
| HANG_DETECT | 挂起检测 | 随机字符串 |
| OCP reboot | OCP 重启 | 随机字符串 |
| Hardware Reboot | 硬件重启 | WDT 状态信息 |

## 目录结构

```
start_log_scan_source/
├── start_log_scan.py          # 主入口
├── config/                    # 配置文件目录
│   ├── config_aee_tne.json   # AEE/TNE 扫描配置
│   ├── pkglist.txt           # 包白名单
│   └── blacklist.txt         # 黑名单
├── modules/
│   ├── analyse/              # 分析模块
│   │   ├── aee/             # AEE 分析
│   │   │   ├── AnalyseAee.py
│   │   │   ├── recognize_exception.py
│   │   │   └── files/       # 文件解析器
│   │   └── tne/             # TNE 分析
│   ├── common/              # 公共模块
│   │   ├── Logger.py
│   │   ├── Utils.py
│   │   └── Path.py
│   └── mode/                # 扫描模式
│       ├── BaseScan.py
│       ├── ScanAeeTne.py
│       └── ...
├── tools/                   # 工具目录
│   ├── aee_extract/        # AEE 解压工具
│   ├── decompress/         # TNE 解压工具
│   └── unzip/              # 解压工具
└── recognize_except.py     # 异常识别模块
```

## 修改说明（相对于原始 exe）

### 1. 网络功能禁用
- 所有网络上报功能已禁用
- Jira 提交功能已禁用
- 飞书通知功能已禁用

### 2. 反编译修复
- 修复了 UTF-16 编码问题
- 修复了 `__init__.py` 中的 return 语句错误
- 修复了切片语法错误
- 修复了 if-elif 逻辑错误

### 3. CausedBy 列格式修复
- JE 类型：正确提取 Java 异常信息
- Kernel API Dump：使用正确的格式
- External (EE) modem/scp：使用随机字符串格式
- SWT/HWT/HANG_DETECT/OCP reboot：使用随机字符串格式

## 配置文件

### config_aee_tne.json

```json
{
  "default": {
    "aee_similar_ratio": 90,
    "tne_similar_ratio": 90,
    "dedup_type": "shanghai",
    "scan_place": "上海AEE",
    "pkglist_file": "pkglist.txt",
    "to_recognize_except": true
  }
}
```


## 常见问题

### Q: 解压失败怎么办？
A: 使用 `-s` 参数跳过解压步骤，确保日志已手动解压到 `.DEC` 目录。

### Q: 如何只扫描特定日期的日志？
A: 使用 `-b` 参数指定天数，如 `-b 0` 表示今天，`-b 1` 表示昨天。注意：`-b` 只选「往前第 N 天」单日，不能解决多日测试每隔几天扫描时的重复提单问题；该场景请用 `-inc`。

### Q: 每隔两天扫一次会不会重复提单？
A: 加 `-inc`，用同目录上一份 `*_org.xls` 做 Path 差集。去重报告只含新增 Path。勿删/误改仍需作为基准的 `*_org.xls`。

### Q: Excel 文件被锁定无法写入？
A: 关闭已打开的 Excel 文件，或等待工具自动添加时间戳后缀。

## 许可证

内部工具，仅供内部使用。
