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
| `-b` | 指定扫描往前第几天的日志，-1 表示所有 | `-1` |
| `-del` | 删除不提交的 log 目录 | 无参数 |

### 扫描模式

| 模式 | 说明 |
|------|------|
| 0 | AEE + TNE |
| 1 | 仅 AEE |
| 2 | 仅 TNE |
| 3 | Fans |
| 4 | Usic |
| 5 | Platform Monkey |
| 6 | Daily |
| 7 | Jenkins |
| 8 | HWAsan |

## 使用示例

```bash
# 扫描 2025-12-22 目录下的 AEE 日志
python start_log_scan.py -m 1 -d 2025-12-22 -p SH

# 扫描所有 AEE 和 TNE 日志
python start_log_scan.py -m 0 -d 2025-12-22 -p SH

# 跳过解压步骤（已解压的日志）
python start_log_scan.py -m 1 -d 2025-12-22 -p SH -s
```

## 输出文件

报告生成在 `-d` 参数指定的目录下：

- `Result_{jira}_{reporter}_MonkeyAEE_{place}_{YYYYMMDD}_{HHMMSS}_org.xls` - 原始结果
- `Result_{jira}_{reporter}_MonkeyAEE_{place}_{YYYYMMDD}_{HHMMSS}.xls` - 去重后结果

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
A: 使用 `-b` 参数指定天数，如 `-b 0` 表示今天，`-b 1` 表示昨天。

### Q: Excel 文件被锁定无法写入？
A: 关闭已打开的 Excel 文件，或等待工具自动添加时间戳后缀。

## 许可证

内部工具，仅供内部使用。
