# Project Structure

```
├── src/
│   ├── main.py                 # 主入口，分阶段执行流水线
│   └── modules/                # 核心模块
│       ├── config_loader.py    # 配置加载器
│       ├── excel_parser.py     # Excel 解析器
│       ├── data_normalizer.py  # 数据标准化
│       ├── database_manager.py # SQLite 数据库管理
│       ├── jira_synchronizer.py# JIRA 数据同步
│       ├── decision_engine.py  # 决策引擎（相似度计算）
│       ├── jira_executor.py    # JIRA 操作执行器
│       ├── lark_integration.py # 飞书集成
│       └── version_utils.py    # 版本比较工具
│
├── config/
│   ├── monkey_config.json      # 包名映射、模块配置、严重等级规则
│   └── comment_templates.json  # 备注模板、状态关键字、回归验证配置
│
├── db/                         # SQLite 数据库文件
│   ├── tinno_VCAME.db
│   ├── tinno_VFFBA.db
│   └── motorola_EKLAMUC.db
│
├── data/                       # 输入/输出 Excel 文件
├── scripts/                    # 工具脚本（验证、调试、状态管理）
├── tests/                      # 测试用例与离线仿真
├── logs/                       # 日志文件
├── .env                        # 环境变量（凭据）
└── requirements.txt            # Python 依赖
```

## 核心模块职责

| 模块 | 职责 |
|------|------|
| ExcelParser | 解析 Monkey 报告 Excel |
| DataNormalizer | 字段标准化、包名映射、严重等级计算 |
| DatabaseManager | SQLite CRUD、问题状态管理 |
| JIRASynchronizer | JIRA 认证、数据同步 |
| DecisionEngine | 相似度计算、决策判定 |
| JIRAExecutor | 执行创建/更新/评论/重开/回归 PASS |
| LarkIntegration | 飞书获取过滤配置、经办人分配 |

## 数据库命名规则

`db/{jira_host}_{project_key}.db`

示例：
- `db/tinno_VCAME.db`
- `db/motorola_EKLAMUC.db`
