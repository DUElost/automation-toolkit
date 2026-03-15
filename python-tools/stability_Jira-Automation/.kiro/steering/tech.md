# Tech Stack

## 语言与运行时

- Python 3.10+
- SQLite（本地数据库，无需额外服务）

## 核心依赖

| 库 | 用途 |
|----|------|
| pandas | Excel 数据处理 |
| openpyxl | Excel 文件读写 |
| jira | JIRA REST API 客户端 |
| lark-oapi | 飞书 API 集成 |
| python-dotenv | 环境变量管理 |
| requests | HTTP 请求 |
| cryptography | P12 证书处理 |

## 常用命令

```bash
# 环境初始化
python -m venv jira_automation_env
source jira_automation_env/bin/activate  # Linux/Mac
jira_automation_env\Scripts\activate     # Windows
pip install -r requirements.txt

# Phase 1: 仅同步 JIRA 数据
python src/main.py --action sync --max-sync 100

# Phase 1+2: 同步 + 预处理
python src/main.py --action preprocess --excel data/monkey.xlsx --output data/

# Phase 3+4: 决策执行（跳过同步）
python src/main.py --action execute --excel data/preprocessed.xlsx --skip-sync

# Phase 3+4: 试运行模式
python src/main.py --action execute --excel data/monkey.xlsx --skip-sync --dry-run

# 完整流程 Phase 1-4
python src/main.py --action full --excel data/monkey.xlsx

# 运行测试
python -m unittest discover tests -p "test_*.py"
```

## 认证方式

- API Token（标准 JIRA）
- P12 证书（Motorola edart）
- Session Cookie（备用）

## 相似度阈值

| 类型 | 阈值 |
|------|------|
| 环境相似度 | 0.99 |
| 原因相似度 | 0.90 |
| 摘要相似度 | 0.85 |
