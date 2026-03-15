# CLAUDE.md

本文件为 Claude Code (claude.ai/code) 在此代码库中工作时提供指导。

## 项目概述

这是一个 **JIRA Monkey 测试自动化系统** - 一个完整的端到端解决方案，用于自动化处理 Monkey 测试结果，包括数据解析、相似度匹配、智能决策和 JIRA 操作。系统支持 Tinno 和 Transsion 两个 JIRA 环境。

## 常用开发命令

### 环境设置
```bash
# 创建并激活虚拟环境
python -m venv jira_automation_env
source jira_automation_env/bin/activate  # Linux/Mac
# 或
jira_automation_env\Scripts\activate  # Windows

# 安装依赖
pip install -r requirements.txt
```

### 数据库设置
```bash
# 方式1：Docker（推荐）
docker-compose -f docker-compose.postgres.yml up -d

# 方式2：手动设置 PostgreSQL
sudo ./scripts/setup_postgresql.sh

# 验证 PostgreSQL 连接
docker-compose -f docker-compose.postgres.yml exec postgres pg_isready -U jira_user -d jira_automation
```

### 运行应用程序
```bash
# 解析 Excel 文件
python src/main.py --excel "data.xls" --action parse

# 数据标准化
python src/main.py --excel "data.xls" --action normalize

# 处理数据（完整流程）
python src/main.py --excel "data.xls" --action process

# 执行 JIRA 操作（试运行）
python src/main.py --excel "data.xls" --action execute --dry-run

# 执行 JIRA 操作（正式运行）
python src/main.py --excel "data.xls" --action execute

# 使用 PostgreSQL 替代 SQLite
python src/main.py --excel "data.xls" --db-type postgresql
```

### 测试命令
```bash
# 测试 PostgreSQL 功能
python scripts/test_postgresql.py

# 测试 Tinno JIRA 集成
python src/modules/test_jira_Tinno.py

# 测试 Transsion JIRA 集成
python src/modules/test_jira_Transsion_out.py

# 测试 Excel 处理
python src/modules/test_excel_to_jira_tinno_batch_create.py
python src/modules/test_excel_to_jira_transsion_batch_create.py
```

### JIRA 标题更新器（独立工具）
```bash
# 单个问题更新
python src/modules/jira_title_updater.py --issue VFFBA-2621 --title "[自动化][V551A][Total Number 47][V551A-15-250808V39][MonkeyAEE]com.android.launcher3发生Java (JE)"

# 从文本文件批量更新
python src/modules/jira_title_updater.py --batch example_title_updates.txt

# 从 Excel 批量更新
python src/modules/jira_title_updater.py --excel issues.xlsx

# 交互模式
python src/modules/jira_title_updater.py --interactive
```

### Docker 命令
```bash
# 构建并运行所有服务
docker-compose up --build

# 仅运行 PostgreSQL
docker-compose -f docker-compose.postgres.yml up -d

# 查看日志
docker-compose logs -f app

# 停止服务
docker-compose down
```

## 架构概述

### 核心组件

1. **ExcelParser** (`src/modules/`) - 解析 Monkey 测试 Excel 文件并提取结构化数据
2. **DataNormalizer** - 标准化和规范化提取的数据以确保一致性处理
3. **LarkIntegration** - 与飞书集成，用于配置管理和过滤
4. **DatabaseManager** - 处理 SQLite 和 PostgreSQL 数据库操作
5. **DecisionEngine** - 使用 PostgreSQL pg_trgm 实现相似度匹配以检测重复问题
6. **JIRASynchronizer** - 管理 Tinno 和 Transsion 环境的 JIRA API 连接
7. **JIRAExecutor** - 执行 JIRA 操作，具有批处理和重试逻辑

### 数据库架构

系统使用 PostgreSQL 配合 pg_trgm 扩展进行模糊匹配：

- **jira_issues_main** - 存储所有 JIRA 问题的主要表
- **pending_issues** - 等待处理的新问题临时表
- **system_config** - 配置管理
- **operation_logs** - 所有操作的审计跟踪

关键索引使用 GIN 和 pg_trgm 进行高效的相似度搜索：
- test_environment（测试环境）
- raw_caused_by（原始原因）  
- normalized_summary（标准化摘要）

### 配置管理

- **环境变量**：数据库连接、JIRA 凭据
- **JSON 配置**：`config/monkey_config.json` - 详细的自动化设置
- **数据库配置**：相似度阈值、存储在 system_config 表中的决策规则

### 决策逻辑

系统使用三层相似度匹配：
1. **环境相似度**（阈值：0.99）
2. **根因相似度**（阈值：0.90）  
3. **摘要相似度**（阈值：0.85）

基于相似度分数的操作：
- ≥0.95：合并到现有问题
- ≥0.90：向现有问题添加评论
- <0.90：创建新问题

## 关键文件和目录

- `src/main.py` - 主应用程序入口点
- `src/modules/` - 核心应用程序模块
- `src/config/schema.sql` - 数据库架构定义
- `config/monkey_config.json` - 自动化配置
- `scripts/` - 设置和测试的实用脚本
- `tests/` - 数据库导出和查询工具
- `requirements.txt` - Python 依赖
- `docker-compose.yml` - 完整堆栈部署
- `docker-compose.postgres.yml` - 仅 PostgreSQL 部署

## 开发注意事项

### 数据库选择
- **SQLite**：默认，适合开发和测试
- **PostgreSQL**：推荐用于生产环境，支持高级相似度匹配

### JIRA 集成
- 支持 Tinno (https://jira.tinno.com) 和 Transsion (http://jira-ex.transsion.com:6001)
- 在配置中定义自定义字段映射
- 处理不同的项目键和工作流

### 错误处理
- 具有重试逻辑的全面错误处理
- 详细记录到控制台和文件
- 当 JIRA 服务不可用时优雅降级

### 性能考虑
- 大数据集的批处理
- 可配置的批处理大小和工作线程
- 为相似度搜索优化的数据库索引
- 数据库操作的连接池