# Excel数据转移工具

自动化从源目录读取测试数据并填写到目标Excel文件的命令行工具。

## 功能特性

- 支持动效丢帧和滑动丢帧两种数据类型
- 支持测试机和竞品机两种设备类型
- 批量模式：同时处理多种设备和数据类型组合
- 从backup文件夹的模板自动生成新的Excel文件
- 用例等级筛选（L1/L2/L3）
- 交互式模式和命令行参数模式

## 目录结构

```
autotest/
├── main.py                           # 主程序入口
├── excel_data_transfer/
│   ├── __init__.py
│   ├── config.py                     # 配置文件（路径、列名等常量）
│   ├── transfer.py                   # 数据转移核心逻辑
│   ├── excel_reader.py               # Excel读取模块
│   └── excel_writer.py               # Excel写入模块
├── backup/
│   └── 静态模型 - V2.0 - KN8.xlsx    # 模板文件
└── data_transfer.log                 # 日志文件
```

## 安装依赖

```bash
pip install openpyxl pandas
```

## 配置说明

### 方式一：环境变量配置（推荐）

复制 `.env.example` 为 `.env`，然后修改路径：

```bash
cp .env.example .env
```

在 `.env` 文件中配置路径：

```env
# 测试机源目录
SOURCE_DIR=W:\KN5项目\静态模型\KN5\动效丢帧
SOURCE_DIR_SLIDING=W:\KN5项目\静态模型\KN5\滑动丢帧

# 竞品机源目录
SOURCE_DIR_COMPETITOR=W:\三星A07\动效丢帧
SOURCE_DIR_SLIDING_COMPETITOR=W:\三星A07\滑动丢帧

# 目标文件和备份目录（可选，默认使用相对路径）
# TARGET_FILE=./data/静态模型 - V2.0 - KN8.xlsx
# BACKUP_DIR=./backup
```

### 方式二：命令行参数

直接在命令行指定路径：

```bash
python main.py -b -s "源目录路径" --sliding-source "滑动源目录路径"
```

### 方式三：修改配置文件

在 `excel_data_transfer/config.py` 中修改默认值。

## 使用方法

### 1. 交互式批量模式（推荐）

使用交互式界面逐步选择参数：

```bash
python main.py -b -i
```

交互流程：
1. 选择设备类型（测试机/竞品机/全选/跳过）
2. 选择数据类型（动效丢帧/滑动丢帧/全选/跳过）
3. 输入测试机源目录（动效丢帧、滑动丢帧）
4. 输入竞品机源目录（动效丢帧、滑动丢帧）
5. 选择用例等级（L1/L2/L3/不筛选）

### 2. 命令行批量模式

使用命令行参数直接执行：

```bash
# 处理所有设备和数据类型（使用默认路径）
python main.py -b

# 只处理测试机的动效丢帧数据
python main.py -b -d test --data-type animation

# 处理所有设备，筛选L1用例
python main.py -b -d both --data-type both -l L1

# 自定义源目录
python main.py -b -s "W:\自定义\动效丢帧" --sliding-source "W:\自定义\滑动丢帧"
```

### 3. 单模式（逐个处理）

不带参数运行，进入单模式交互界面：

```bash
python main.py
```

## 命令行参数

| 参数 | 简写 | 说明 |
|------|------|------|
| `--batch` | `-b` | 批量模式：自动处理所有设备和数据类型 |
| `--interactive` | `-i` | 交互式模式：提示输入源目录和其他选项 |
| `--device` | `-d` | 设备类型：test/competitor/both/all |
| `--data-type` | | 数据类型：animation/sliding/both/all |
| `--source` | `-s` | 测试机动效丢帧源目录 |
| `--sliding-source` | | 测试机滑动丢帧源目录 |
| `--source-comp` | | 竞品机动效丢帧源目录 |
| `--sliding-source-comp` | | 竞品机滑动丢帧源目录 |
| `--level` | `-l` | 用例等级筛选（L1/L2/L3） |
| `--target` | `-t` | 目标Excel文件路径 |
| `--no-backup` | | 不创建备份文件 |
| `--no-template` | | 不使用模板，直接使用目标文件 |
| `--verbose` | `-v` | 详细输出模式 |

## 使用示例

### 示例1：完整批量处理

处理测试机和竞品机的所有数据类型：

```bash
python main.py -b
```

### 示例2：只处理L1用例的滑动丢帧数据

```bash
python main.py -b --data-type sliding -l L1
```

### 示例3：自定义源目录路径

```bash
python main.py -b \
  -s "W:\项目\测试机\动效丢帧" \
  --sliding-source "W:\项目\测试机\滑动丢帧" \
  --source-comp "W:\项目\竞品机\动效丢帧" \
  --sliding-source-comp "W:\项目\竞品机\滑动丢帧"
```

### 示例4：交互式选择所有参数

```bash
python main.py -b -i
```

## 输出说明

### 生成的文件

- 从backup模板生成新的Excel文件到当前目录
- 文件名格式：`静态模型 - V2.0 - KN8_YYYYMMDD_HHMMSS.xlsx`

### 日志文件

- 运行日志保存在 `data_transfer.log`

### 处理结果

```
============================================================
批量数据转移完成
============================================================
[模板] 已从模板生成新文件
目标文件: ./data/静态模型 - V2.0 - KN8_20260204_153045.xlsx
[OK] 全部处理成功
  成功处理: 4 项
  失败: 0 项

详细结果:
  [OK] 动效丢帧 - 测试机
       处理文件夹: 36/36
  [OK] 动效丢帧 - 竞品机
       处理文件夹: 36/36
  [OK] 滑动丢帧 - 测试机
       处理文件夹: 36/36
  [OK] 滑动丢帧 - 竞品机
       处理文件夹: 36/36
============================================================
```

## 数据处理规则

### 动效丢帧
- 按文件夹索引顺序匹配Tcid
- 读取 `trace_analyse_result.xlsx` 中的 `总丢帧数` 列
- 填写到目标Excel的"动效丢帧"sheet

### 滑动丢帧
- 按文件夹名称匹配Purpose列
- 读取 `trace_analyse_result.xlsx` 中的 `FrameOver33ms`、`FrameOver50ms` 列
- 填写到目标Excel的"滑动连续丢帧"sheet
- 33ms次数：值>0写1，=0写0，None写"None"
- 50ms次数：值>0写1，=0写0，None写"None"

## 故障排除

### 问题：找不到源目录

确保config.py中配置的源目录路径正确存在。

### 问题：Excel文件被占用

关闭可能打开的Excel文件后再运行。

### 问题：编码错误

日志文件已使用UTF-8编码，如仍有问题，请检查终端编码设置。

## 版本历史

- v1.0 - 初始版本
- v2.0 - 添加批量模式、支持竞品机、模板生成功能
