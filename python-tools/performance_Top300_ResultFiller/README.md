# Top300 Result Filler

自动化处理Top300应用启动时间测试数据并回填到目标Excel文件。

## 功能特性

- 读取空载/负载测试报告文件
- 自动识别有效sheet页（按表头匹配）
- 计算非首轮平均启动时间
- 在目标文件中创建新sheet页并写入数据
- 自动回填测试结果sheet页
- 支持创建备份文件

## 安装依赖

```bash
cd python-tools/performance_Top300_ResultFiller
pip install -r requirements.txt
```

## 使用方法

### 运行工具

```bash
python main.py
```

### 交互式输入

程序会依次提示输入：

1. 空载标准（默认：`/`）
2. 负载标准（默认：`/`）
3. 空载测试报告文件路径（如：`test_report_空载.xlsx`）
4. 负载测试报告文件路径（如：`test_report_负载.xlsx`）
5. 目标Excel文件路径（如：`目标文件.xlsx`）
6. 是否创建备份文件（默认：是）

## 数据处理逻辑

### 1. Sheet页识别

识别包含以下表头的sheet页：
```
测试APK | 时间类型 | 平均启动时间 | 最大启动时间 | 最小启动时间 | 跳变次数 | Round_1 | Round_2 | Round_3 | Round_4 | Round_5 | Round_6 | Round_7 | Round_8
```

### 2. 新Sheet页命名

- 空载文件：`空载1'0078`、`空载2'0001`（后4位取自原sheet名）
- 负载文件：`负载1'0078`、`负载2'0001`

### 3. 数据处理

1. 筛选 `时间类型=AM` 的数据
2. 统计 `平均启动时间=0` 的个数
3. 筛选 `平均启动时间≠0` 的数据
4. 添加 `非首轮平均启动时间` 列（Round_2到Round_8的平均值）
5. 计算列平均值

### 4. 测试结果回填

在 `测试结果` sheet中：
- `标准` 列：填入用户输入的标准值
- `#1`、`#2` 列：填入各sheet计算出的平均值
- `均值` 列：自动计算 `(#1 + #2) / 2`

## 目录结构

```
performance_Top300_ResultFiller/
├── main.py                    # 主程序入口
├── top300_processor/
│   ├── __init__.py           # 模块初始化
│   ├── config.py             # 配置常量
│   ├── excel_reader.py       # Excel读取
│   ├── data_processor.py     # 数据处理
│   ├── excel_writer.py       # Excel写入
│   └── result_filler.py      # 结果回填协调
├── requirements.txt          # 依赖声明
├── README.md                 # 本文件
└── top300_filler.log         # 运行日志
```

## 注意事项

1. 确保输入的Excel文件格式正确
2. 目标文件会直接被修改，建议使用备份功能
3. 程序会在当前目录生成日志文件 `top300_filler.log`
