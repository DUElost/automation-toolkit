# Repository Guidelines

## Project Structure & Module Organization
`src/main.py` 负责 Monkey ➜ Jira 主流程，所有可复用能力放在 `src/modules/` 供 CLI 与独立脚本直接引用。环境变量与连接信息集中在 `config/`（如 `monkey_config.json`、`.env*`），示例表格、基线输出和排查材料分别放在 `data/`、`information/`、`logs/`。辅助脚本位于 `scripts/`，离线回归与仿真工具放在 `tests/`。若需要新增数据库脚本或临时工具，请在 `scripts/` 内按功能子目录分类，并同步更新 `CLAUDE.md` 以利其他代理查阅。

## Build, Test, and Development Commands
```bash
python -m venv jira_automation_env && source jira_automation_env/bin/activate
pip install -r requirements.txt
python src/main.py --excel data/sample_monkey.xlsx --action process        # full pipeline without Jira writes
python src/main.py --excel data/sample_monkey.xlsx --action execute --dry-run
```

**注意：系统仅支持 SQLite 数据库**，无需额外配置数据库服务。数据库文件按项目隔离存储在 `db/` 目录下。

### main.py 分阶段执行

系统支持分阶段执行，可根据需求选择执行特定阶段：

| 动作 | 阶段 | 说明 | 是否需要 Excel |
|------|------|------|----------------|
| `sync` | Phase 1 | 仅同步 JIRA 数据到本地 | 否 |
| `preprocess` | Phase 1+2 | 同步 + 预处理（输出预处理报告） | 是（原始报告） |
| `execute` | Phase 1+2+3+4 | 同步 + 预处理 + 决策执行 + 回归验证 | 是（原始报告） |
| `full` | Phase 1-4 | 完整流程（同 execute） | 是（原始报告） |

**注意**：`execute` 和 `full` 默认都会执行 Phase 1 同步，确保本地数据库与 JIRA 保持同步。如需跳过同步，请使用 `--skip-sync` 参数。

### main.py 命令行参数

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `--action`, `-a` | 执行动作：`sync`/`preprocess`/`execute`/`full` | `full` |
| `--excel`, `-e` | Excel 文件路径（sync 动作不需要） | - |
| `--output`, `-o` | 预处理报告输出路径（preprocess 动作使用） | - |
| `--dry-run` | 试运行模式，不实际写入 JIRA | `False` |
| `--db-path` | 数据库路径（默认根据 JIRA URL 和项目自动生成） | 自动 |
| `--skip-sync` | 跳过 JIRA 同步步骤 | `False` |
| `--max-sync` | 最大同步数量 | `100` |
| `--title-keywords` | 标题筛选关键字（覆盖配置文件） | 从配置读取 |
| `--jira-url` | 覆盖 JIRA 服务器地址 | `.env` |
| `--jira-project-key` | 覆盖项目 Key | `.env` |
| `--log-level` | 日志级别：`DEBUG`/`INFO`/`WARNING`/`ERROR` | `INFO` |

**示例**：
```bash
# Phase 1: 仅同步 JIRA 数据（无需 Excel）
python src/main.py --action sync --max-sync 100

# Phase 1+2: 同步 + 预处理，输出预处理报告
python src/main.py --action preprocess --excel data/monkey.xlsx --output data/

# Phase 1+2: 跳过同步，仅预处理
python src/main.py --action preprocess --excel data/monkey.xlsx --output data/ --skip-sync

# Phase 3+4: 决策执行（跳过同步，使用已有数据库）
python src/main.py --action execute --excel data/preprocessed.xlsx --skip-sync

# Phase 3+4: 决策执行（试运行模式）
python src/main.py --action execute --excel data/monkey.xlsx --skip-sync --dry-run

# 完整流程 Phase 1-4
python src/main.py --action full --excel data/monkey.xlsx

# 指定标题关键字
python src/main.py --action sync --title-keywords "[自动化]" "[V551A]"
```

**典型工作流**：
1. 先执行 `--action sync` 同步 JIRA 数据
2. 执行 `--action preprocess` 生成预处理报告，人工检查调整
3. 执行 `--action execute --skip-sync` 使用调整后的报告执行决策

## Coding Style & Naming Conventions
代码基于 Python 3.10，统一使用 4 空格缩进；函数/变量使用 `snake_case`，类使用 `PascalCase`，常量使用 `UPPER_SNAKE`。鼓励 typed dict 或 dataclass，并在模块级补充类型注解（参考 `src/main.py`）。配置加载器保持纯函数特性并复用公共 `logging`，输出格式建议沿用 `setup_logging()` 的时间戳+模块名。可执行脚本必须加 `if __name__ == "__main__":` 保护，并将参数解析逻辑封装为独立函数以便单测复用。

## Testing Guidelines
测试体系基于标准库 `unittest` 与 pandas 固件，可通过 `python -m unittest discover tests -p "test_*.py"` 执行全量用例；针对特定连接器可单独运行 `src/modules/test_excel_to_jira_tinno_batch_create.py` 等脚本。保证 Jira/Lark 调用被 mock，优先重复使用仓库内示例 Excel，覆盖创建、更新、评论三种决策路径，并在 PR 中说明任何有意跳过的场景。需要长耗时外部依赖时，请在测试中使用 `@unittest.skipUnless` 条件控制，避免 CI 超时。

## Commit & Pull Request Guidelines
当前快照无 Git 历史，提交时遵循 Conventional Commits（如 `feat(monkey): add Tinno regression guard`、`fix(db): handle pg_trgm error`），并在正文引用对应 Jira 任务。Excel、配置与代码改动保持同一个提交，以便评审追踪。PR 描述需包含问题背景、改动前后行为、验证命令及更新的示例数据/SQL；涉及浏览器或可视化脚本时附带截图，并链接批准该需求的 Jira 或飞书讨论。若改动需要运维协同（如证书更新），请在 PR 模板中新增"运维同步"勾选项。

## Security & Configuration Tips
凭据仅允许写入 `.env`，通过 `ConfigLoader` 读取；禁止将账号复制到 Notebook 或表格。TLS 证书（`client.crt`、`client.key`）需设置严格权限，并与 Feishu/Jira Token 同步轮换。提交配置或日志前务必检查 `config/monkey_config.json`、`logs/` 是否含敏感字段，必要时脱敏后再分享。对外部 API 的临时密钥可放入 `.env.local` 并在 `.gitignore` 中确认忽略状态。

## Architecture Overview
系统按"Excel 解析 → 数据标准化 → 决策引擎 → Jira 执行"四段流水线构建：ExcelParser 解析 Monkey 报告，DataNormalizer 统一字段与模块命名，DecisionEngine 借助 Python 实现的相似度计算决定是创建、合并还是评论，最终由 JIRAExecutor 调用远端 API。DatabaseManager 使用 SQLite 存储本地数据，JIRASynchronizer 封装多环境凭据，LarkIntegration 用于获取实时过滤配置。引入新阶段时，应保持幂等接口并更新 `process_data()` 或 `execute_jira_operations()` 的调用链。

### 数据库说明

系统**仅支持 SQLite**，适用于单用户本地工具场景：
- 零配置，无需额外数据库服务
- 单文件存储，易于备份和迁移
- 相似度计算由 Python 实现（DecisionEngine），无需 pg_trgm 扩展


## Complete Workflow (完整工作流)

### 数据库隔离策略

本地数据库按 **JIRA 系统 + 项目库** 进行隔离，确保不同项目的数据互不干扰：

| JIRA 系统 | 项目库 | 本地数据库文件 |
|-----------|--------|----------------|
| jira.tinno.com | VCAME | `db/tinno_VCAME.db` |
| jira.tinno.com | VFFBA | `db/tinno_VFFBA.db` |
| jira.motorola.com | EKLAMUC | `db/motorola_EKLAMUC.db` |

数据库命名规则：`db/{jira_host}_{project_key}.db`

### 工作流阶段

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Phase 1: 初始化阶段                               │
├─────────────────────────────────────────────────────────────────────────┤
│ 1.1 解析配置 → 获取目标 JIRA 系统 URL 和项目库 Key                        │
│ 1.2 数据库定位 → 根据 {jira_host}_{project_key} 查找/创建本地数据库        │
│ 1.3 JIRA 连接 → 建立与目标 JIRA 系统的认证连接                            │
│ 1.4 数据同步 → 从 JIRA 拉取符合条件的 Bug 单到本地数据库                   │
│     - 筛选条件：标题包含指定关键字（如 [自动化]、[V551A]、[MonkeyAEE]）     │
│     - 同步字段：jira_key, status, summary, resolution, fix_version 等    │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                        Phase 2: 数据预处理阶段                           │
├─────────────────────────────────────────────────────────────────────────┤
│ 2.1 Excel 解析 → ExcelParser 读取 Monkey 报告                            │
│ 2.2 数据标准化 → DataNormalizer 统一字段格式                              │
│     - 包名映射、模块识别、严重等级计算                                     │
│     - 生成 normalized_summary、jira_summary、jira_description            │
│ 2.3 经办人分配 → LarkIntegration 根据模块获取负责人                        │
│ 2.4 待处理队列 → 将标准化数据写入 pending_issues 表                        │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                        Phase 3: 决策执行阶段                             │
├─────────────────────────────────────────────────────────────────────────┤
│ 3.1 候选匹配 → DecisionEngine 计算相似度，匹配数据库中的历史问题           │
│     - 环境相似度阈值：0.99                                                │
│     - 原因相似度阈值：0.90                                                │
│     - 摘要相似度阈值：0.85                                                │
│ 3.2 决策判定 → 根据匹配结果和问题状态确定操作类型                          │
│ 3.3 JIRA 执行 → JIRAExecutor 执行创建/更新/评论/重开等操作                │
│ 3.4 本地同步 → 将执行结果同步到本地数据库                                  │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                        Phase 4: 回归验证阶段                             │
├─────────────────────────────────────────────────────────────────────────┤
│ 4.1 候选筛选 → 查询已解决状态且标题符合条件的问题                          │
│ 4.2 匹配检查 → 排除本次已处理的问题                                       │
│ 4.3 PASS 记录 → 对未匹配问题记录回归 PASS                                 │
│     - 第 1 次：添加"已回归验证1个版本PASS"备注                            │
│     - 第 2 次：添加"已回归验证2个版本PASS"备注并关单                       │
└─────────────────────────────────────────────────────────────────────────┘
                                    ↓
┌─────────────────────────────────────────────────────────────────────────┐
│                        Phase 5: 收尾阶段                                 │
├─────────────────────────────────────────────────────────────────────────┤
│ 5.1 数据持久化 → 保存所有变更到本地数据库                                  │
│ 5.2 连接关闭 → 关闭 JIRA 连接和数据库连接                                 │
│ 5.3 结果汇总 → 输出本轮执行统计                                           │
│     - 处理数、创建数、更新数、失败数、回归关闭数                           │
│     - 详细变更列表（jira_key, action, status）                           │
└─────────────────────────────────────────────────────────────────────────┘
```

### 初始化阶段详细逻辑

```python
# 伪代码示例
def initialize_workflow(jira_url: str, project_key: str, title_filter: List[str]):
    """
    初始化工作流
    
    Args:
        jira_url: JIRA 系统 URL，如 "https://jira.tinno.com"
        project_key: 项目库 Key，如 "VCAME"
        title_filter: 标题筛选关键字，如 ["[自动化]", "[V551A]", "[MonkeyAEE]"]
    """
    # 1. 解析 JIRA 主机名
    jira_host = urlparse(jira_url).netloc.split('.')[0]  # "tinno"
    
    # 2. 构建数据库路径
    db_path = f"db/{jira_host}_{project_key}.db"
    
    # 3. 检查数据库是否存在
    if not os.path.exists(db_path):
        # 创建新数据库
        db = DatabaseManager({"type": "sqlite", "path": db_path})
        db.initialize_tables()
    else:
        # 连接现有数据库
        db = DatabaseManager({"type": "sqlite", "path": db_path})
    
    # 4. 建立 JIRA 连接
    jira_sync = JIRASynchronizer({
        "url": jira_url,
        "project_key": project_key,
        ...
    })
    
    # 5. 同步 JIRA 数据到本地（使用 AND 连接关键字，必须同时包含所有关键字）
    jql = f'project = {project_key} AND type = Bug'
    for keyword in title_filter:
        jql += f' AND summary ~ "{keyword}"'
    
    issues = jira_sync.search_issues(jql)
    for issue in issues:
        db.upsert_issue(issue)  # 插入或更新，包含 resolution 字段
    
    return db, jira_sync
```

### 标题关键字筛选规则

同步时使用 **AND** 逻辑连接所有关键字，只有标题**同时包含所有关键字**的问题才会被同步：

```
JQL: project = VCAME AND type = Bug 
     AND summary ~ "[自动化]" 
     AND summary ~ "[V551A]" 
     AND summary ~ "[MonkeyAEE]"
```

如果数据库中存在不符合条件的历史数据，可使用 `scripts/cleanup_invalid_issues.py` 清理。


## Decision Scenarios (决策场景)

系统支持 7 种决策场景，由 `JIRAExecutor` 根据问题状态和匹配结果自动处理：

| 场景 | 触发条件 | 操作 | 备注模板 |
|------|----------|------|----------|
| CREATE | 数据库中无匹配问题 | 创建新 JIRA 问题 | - |
| UPDATE | 匹配到 Open/Reopened 状态问题 | 更新计数，添加备注 | CONTINUE |
| COMMENT | 匹配到已解决(问题不修改/Won't Do)状态问题 | 仅添加备注 | WONT_FIX |
| REOPEN | 匹配到已解决(完成)状态，版本晚于修复版本 | 重新打开问题 | REOPEN |
| IGNORE | 匹配到已关闭状态问题，且解决结果为问题不修复 | 不做任何操作 | - |
| RECREATE | 匹配到已关闭状态问题，但解决结果不是问题不修复 | 重新提单（创建新问题） | - |
| REGRESSION_PASS | 已解决问题未被匹配，标题含指定关键字 | 记录回归 PASS | REGRESSION_PASS_1/2 |

### Resolution 字段说明

`resolution`（解决结果）字段用于区分 COMMENT、REOPEN、IGNORE 和 RECREATE 场景：

| 状态 | Resolution | 决策场景 |
|------|------------|----------|
| 已解决 | 完成 | REOPEN（版本晚于修复版本时） |
| 已解决 | 问题不修改 | COMMENT (Won't Fix) |
| 已解决 | Won't Do | COMMENT (Won't Fix) |
| 已关闭 | 问题不修改/Won't Fix | IGNORE（忽略） |
| 已关闭 | 完成/其他 | RECREATE（重新提单） |

**Won't Fix 关键字配置**（`config/comment_templates.json`）：
```json
"wont_fix": {
    "keywords": ["won't fix", "wont fix", "不解决", "无法解决", "问题不修改", "非问题"]
}
```

### 数据库同步字段

初始化阶段从 JIRA 同步以下字段到本地数据库：

| 字段 | 说明 | 用途 |
|------|------|------|
| `jira_key` | 问题键 | 唯一标识 |
| `status` | 状态 | 决策判断（Open/已解决/已关闭等） |
| `resolution` | 解决结果 | Won't Fix 判断（完成/问题不修改等） |
| `summary` | 标题 | 相似度匹配 |
| `fix_version` | 修复版本 | REOPEN 版本比较 |
| `assignee` | 经办人 | 问题分配 |
| `priority` | 优先级 | 问题属性 |

### 回归验证逻辑

回归 PASS 功能在 `_handle_resolved_without_matches()` 方法中实现：
- 只处理标题同时包含配置中指定关键字的问题（可在 `config/comment_templates.json` 配置）
- 第 1 次未匹配：添加"已回归验证1个版本PASS"备注，`regression_pass_count` 设为 1
- 第 2 次未匹配：添加"已回归验证2个版本PASS"备注并关单，`regression_pass_count` 设为 2

### 配置文件

| 文件 | 用途 |
|------|------|
| `config/comment_templates.json` | 备注模板、状态关键字、回归验证过滤条件 |
| `config/monkey_config.json` | 包名映射、模块配置、严重等级规则 |
| `.env` | JIRA 连接凭据（JIRA_URL, JIRA_USERNAME, JIRA_P12_PATH 等） |

## Utility Scripts (工具脚本)

| 脚本 | 用途 |
|------|------|
| `scripts/test_init_workflow.py` | 初始化阶段工作流验证，支持数据库定位和 JIRA 同步 |
| `scripts/cleanup_invalid_issues.py` | 清理数据库中不符合标题关键字条件的问题 |
| `scripts/full_validation_test.py` | 完整两轮验证测试，支持 `--real` 实际写入 JIRA |
| `scripts/check_db_status.py` | 检查数据库中问题状态和回归验证候选 |
| `scripts/check_resolution.py` | 检查数据库中的 resolution 字段 |
| `scripts/setup_resolved_issues.py` | 将问题状态改为"已解决"，用于测试回归 PASS |
| `scripts/jira_workflow_manager.py` | JIRA 工作流管理（状态转换、查看转换） |
| `scripts/check_transition_fields.py` | 查询 JIRA 转换所需字段 |
| `scripts/get_project_versions.py` | 获取项目有效版本列表 |

### 常用命令

```bash
# 初始化阶段验证（完整同步）
python scripts/test_init_workflow.py --max-results 100

# 初始化阶段验证（跳过同步，仅测试连接）
python scripts/test_init_workflow.py --skip-sync

# 初始化阶段验证（指定不同项目库）
python scripts/test_init_workflow.py --project VFFBA --skip-sync

# 清理不符合标题关键字条件的问题（dry-run）
python scripts/cleanup_invalid_issues.py

# 清理不符合标题关键字条件的问题（实际执行）
python scripts/cleanup_invalid_issues.py --execute

# 检查数据库状态
python scripts/check_db_status.py

# 检查 resolution 字段
python scripts/check_resolution.py

# 运行完整验证（实际写入 JIRA）
python scripts/full_validation_test.py --real

# 运行指定轮次
python scripts/full_validation_test.py --round 2 --real

# 将问题改为已解决状态（测试回归 PASS）
python scripts/setup_resolved_issues.py

# 查看问题可用转换
python scripts/jira_workflow_manager.py list-transitions VCAME-307

# 执行状态转换
python scripts/jira_workflow_manager.py transition VCAME-307 resolved
```

## JIRA Workflow Notes (VCAME 项目)

VCAME 项目的工作流转换需要填写多个必填字段：

**开始进行 (Open → 处理中)**
- `timetracking.originalEstimate` - 预估时间
- `customfield_10109` - Start date
- `customfield_10110` - End date

**解决问题 (处理中 → 已解决)**
- `resolution` - 解决结果（完成/问题不修改等）
- `fixVersions` - 修复版本（VCAME 项目只有 P1）
- `worklog` - 工时记录（需通过 worklog API 单独添加）
- `customfield_10144` - 根本原因
- `customfield_10145` - 长期措施
- `customfield_10146` - 可能风险
- `customfield_10147` - 对应的解决代码

## Execution Summary Output (执行结果输出)

每轮执行完成后，系统输出以下统计信息：

```
======================================================================
执行结果汇总
======================================================================
JIRA 系统: https://jira.tinno.com
项目库: VCAME
本地数据库: db/tinno_VCAME.db

处理统计:
  - 处理数: 19
  - 创建数: 15
  - 更新数: 4
  - 失败数: 0
  - 回归关闭: 3

变更详情:
  VCAME-327: CREATE (Open)
  VCAME-328: CREATE (Open)
  VCAME-320: UPDATE (Open) - 计数 22 → 33
  VCAME-307: REGRESSION_PASS (Resolved → Closed)
  ...
======================================================================
```
