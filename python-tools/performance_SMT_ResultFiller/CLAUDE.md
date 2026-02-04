# Performance SMT Result Filler

[根目录](../../CLAUDE.md) > [python-tools](../) > **performance_SMT_ResultFiller**

---

> SMT 性能测试结果自动填充 Excel 工具
> 版本：v2.0 | 更新时间：2026-02-04 19:23:02

---

## 变更记录 (Changelog)

| 日期 | 变更内容 |
|------|----------|
| 2026-02-04 19:23:02 | 初始化模块 CLAUDE.md 文档 |

---

## 模块职责

自动化从测试数据源目录读取性能测试结果，并填写到目标 Excel 模板文件中：

1. **动效丢帧数据填充**：读取源目录中的 `trace_analyse_result.xlsx`，提取总丢帧数并填充到目标文件
2. **滑动丢帧数据填充**：读取 FrameOver33ms、FrameOver50ms 数据并填充
3. **多设备支持**：同时支持测试机和竞品机数据
4. **用例等级筛选**：支持按 L1/L2/L3 等级筛选处理

---

## 入口与启动

### 主程序

- **文件**: `main.py`
- **运行方式**:
  ```bash
  # 交互式批量模式（推荐）
  python main.py -b -i

  # 直接批量模式
  python main.py -b

  # 单模式
  python main.py
  ```

### 快捷启动

- **Windows**: 双击 `Start.bat`
- **根目录**: `.\toolkit.ps1 run-perf-filler`

---

## 对外接口

### 命令行参数 (CLI)

| 参数 | 简写 | 说明 | 默认值 |
|------|------|------|--------|
| `--batch` | `-b` | 批量模式：自动处理所有设备和数据类型 | - |
| `--interactive` | `-i` | 交互式模式：提示输入源目录和其他选项 | - |
| `--device` | `-d` | 设备类型：test/competitor/both/all | both |
| `--data-type` | - | 数据类型：animation/sliding/both/all | both |
| `--source` | `-s` | 测试机动效丢帧源目录 | 环境变量/config |
| `--sliding-source` | - | 测试机滑动丢帧源目录 | 环境变量/config |
| `--source-comp` | - | 竞品机动效丢帧源目录 | 环境变量/config |
| `--sliding-source-comp` | - | 竞品机滑动丢帧源目录 | 环境变量/config |
| `--level` | `-l` | 用例等级筛选（L1/L2/L3） | 不筛选 |
| `--target` | `-t` | 目标Excel文件路径 | 从模板生成 |
| `--no-backup` | - | 不创建备份文件 | 创建备份 |
| `--no-template` | - | 不使用模板，直接使用目标文件 | 使用模板 |
| `--verbose` | `-v` | 详细输出模式 | 关闭 |

### 核心 API（模块化调用）

```python
from excel_data_transfer import (
    process_folder_transfer,    # 动效丢帧转移
    process_sliding_transfer,   # 滑动丢帧转移
    batch_process               # 批量处理
)
```

---

## 关键依赖与配置

### Python 依赖

| 包名 | 版本 | 用途 |
|------|------|------|
| pandas | >=2.0.0 | Excel 读取与数据处理 |
| openpyxl | >=3.1.0 | Excel 写入 |
| xlrd | >=2.0.0 | 旧版 Excel 读取 |
| python-dotenv | >=1.0.0 | 环境变量加载 |

### 配置文件

1. **`.env`**：环境变量配置（优先级最高）
   ```env
   SOURCE_DIR=W:\KN5项目\静态模型\KN5\动效丢帧
   SOURCE_DIR_SLIDING=W:\KN5项目\静态模型\KN5\滑动丢帧
   SOURCE_DIR_COMPETITOR=W:\三星A07\动效丢帧
   SOURCE_DIR_SLIDING_COMPETITOR=W:\三星A07\滑动丢帧
   ```

2. **`excel_data_transfer/config.py`**：代码默认配置
   - 支持通过环境变量覆盖
   - 包含列名、Sheet 名称等常量定义

---

## 数据模型

### 输入数据结构

**源文件**: `trace_analyse_result.xlsx`

| Sheet | 列名 | 说明 |
|-------|------|------|
| TraceAnalyseResult | 总丢帧数 | 动效丢帧数值 |
| TraceAnalyseResult | FrameOver33ms | 滑动33ms丢帧计数 |
| TraceAnalyseResult | FrameOver50ms | 滑动50ms丢帧计数 |
| TraceAnalyseResult | 总丢帧数 | 滑动丢帧总数 |

### 输出数据结构

**目标文件**: `静态模型 - V2.0 - KN8.xlsx`

| Sheet | 列结构 | 说明 |
|-------|--------|------|
| 动效丢帧 | Tcid, 用例等级, 测试机1-10, 竞品机1-10 | 动效丢帧数据 |
| 滑动连续丢帧 | Tcid, 用例等级, Purpose, 测试机1(丢帧总数+33ms次数+50ms次数)... | 滑动丢帧数据 |

---

## 测试与质量

### 测试状态

- **测试框架**: pytest
- **测试文件**: 无
- **覆盖率**: 未配置

### CI/CD

- **Workflow**: `.github/workflows/python-tools.yml`
- **Lint**: flake8（非阻塞）
- **Test**: pytest（非阻塞）

---

## 常见问题 (FAQ)

### Q1: 找不到源目录怎么办？

检查以下项：
1. 网络驱动器（如 W: 盘）是否已连接
2. `.env` 文件中的路径配置是否正确
3. 使用 `--source` 参数直接指定路径

### Q2: 数据匹配不准确怎么办？

1. 首次使用必须与手动填充数据进行比对
2. 检查源文件夹命名是否符合规则（如 `1短信启动`）
3. 检查目标 Excel 模板列名是否与配置一致
4. 发现问题联系工具开发者：dai.lv@tinno.com

### Q3: 如何只处理特定用例等级？

使用 `--level` 参数：
```bash
python main.py -b -l L1
```

---

## 相关文件清单

### 核心代码

| 文件路径 | 行数 | 说明 |
|----------|------|------|
| `main.py` | 581 | 主程序入口、CLI 解析、交互式界面 |
| `excel_data_transfer/config.py` | 123 | 配置常量、环境变量加载 |
| `excel_data_transfer/transfer.py` | 735 | 核心转移逻辑、批量处理 |
| `excel_data_transfer/excel_reader.py` | 239 | Excel 读取模块 |
| `excel_data_transfer/excel_writer.py` | 429 | Excel 写入模块 |

### 配置与文档

| 文件路径 | 说明 |
|----------|------|
| `.env` | 环境变量配置 |
| `requirements.txt` | Python 依赖 |
| `README.md` | 项目说明 |
| `01-性能模块静态模型数据填写工具使用指南.md` | 详细使用指南 |
| `Start.bat` | Windows 快捷启动脚本 |

### 数据文件

| 文件/目录 | 说明 |
|-----------|------|
| `backup/静态模型 - V2.0 - KN8.xlsx` | Excel 模板文件 |
| `data_transfer.log` | 运行日志 |

---

## 重要提示

> **警告：工具执行依赖预设的代码逻辑进行数据回填，结果不一定 100% 正确！**
>
> 首次使用时，请务必执行验证步骤：
> 1. 运行工具生成结果文件
> 2. 与手动填充的数据进行逐项比对
> 3. 确认数据准确性后再进行后续使用
