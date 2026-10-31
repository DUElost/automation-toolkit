# 日志扫描工具 (Log Scan Tool)

版本：V2.0.9_20240509（反编译修复版）

## 简介

本工具用于扫描和分析 MTK 平台的 AEE (Android Exception Engine) 和 TNE 日志文件，自动识别各类异常并生成 Excel 报告。

## 环境要求

- Python 3.7 或 3.8
- Windows 操作系统

## 安装依赖

```bash
pip install xlwt xlrd
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
