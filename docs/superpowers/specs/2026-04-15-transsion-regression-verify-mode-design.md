# Transsion 第二阶段回归验证模式设计

## 1. 目标

为 [create_transsion_jira_batch_from_excel.py](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py) 新增一个“回归验证模式”，用于：

- 不依赖上传模板 Excel
- 不执行新问题提交
- 针对 Jira 历史库中的“已解决问题”执行批量回归验证
- 复用现有 PASS 判定、评论、关单、本地 SQLite 落库能力

该模式必须与现有 Excel 模式共存，并且在同一 Jira 项目 Key 下共享同一套本地累计状态。

## 2. 设计原则

- 主流程复用：复用现有 `RegressionStore`、`evaluate_regression_pass(...)`、结果 JSON、Excel 摘要和 dry-run 语义
- 输入分离：Excel 模式负责“上传模板驱动的建单/回归”；回归验证模式负责“业务参数驱动的历史问题回归”
- 参数收敛：不向用户暴露原始 JQL 输入，JQL 由代码按业务参数构建
- 安全过滤：即使粗筛 JQL 命中较宽，代码内部仍然按“已解决/Verified + 已修复”做保护性过滤
- 项目隔离：本地 SQLite 必须按 Jira 项目 Key 隔离，避免不同项目状态混在一起
- 同项目共享：同一个项目下，Excel 模式和回归验证模式共用同一份本地累计状态

## 3. 两种运行模式

### 3.1 Excel 模式

触发条件：

- 传入 `--add-excel-file`

行为：

- 保持当前逻辑不变
- 读取上传模板 Excel
- 执行现有建单 / 更新 / 回归 PASS 逻辑

### 3.2 回归验证模式

触发条件：

- 传入 `--regression-project`

行为：

- 不读取上传模板 Excel
- 不执行建单、更新历史单匹配链路
- 直接按业务参数构建历史 Jira 查询
- 对命中的历史问题执行现有 PASS 验证逻辑

## 4. 模式参数设计

### 4.1 Excel 模式参数

保留现有参数：

- `--add-excel-file`
- `--jira-username`
- `--jira-password`
- `--jira-server`
- `--dry-run`
- `--add-comments`
- `--disable-regression`

### 4.2 回归验证模式新增参数

- `--regression-project`
  - 目标 Jira 项目 Key，例如 `X6851OS16`
- `--regression-specialty`
  - 目标专项，支持重复传参
  - 例如 `--regression-specialty 休眠唤醒专项 --regression-specialty Monkey专项`
- `--current-version`
  - 本轮回归验证的版本，例如 `X6851-16.3.0.021(OP001PF001AZ)_SU`
- `--history-reporter`
  - 用于粗筛历史问题的 `reporter`

回归验证模式仍复用：

- `--jira-username`
- `--jira-password`
- `--jira-server`
- `--dry-run`
- `--add-comments`

## 5. 模式互斥规则

启动前必须先解析运行模式。

### 5.1 合法输入

- 只传 `--add-excel-file`：进入 Excel 模式
- 只传 `--regression-project`：进入回归验证模式

### 5.2 非法输入

以下情况直接报错退出：

- 同时传 `--add-excel-file` 和 `--regression-project`
- 两种模式参数都未触发
- 回归验证模式缺少以下任一参数：
  - `--regression-specialty`
  - `--current-version`
  - `--history-reporter`

## 6. 回归验证模式的 JQL 构建

### 6.1 总体策略

不接受用户直接输入原始 JQL。

代码按专项逐个构建 JQL，每个专项独立执行，避免多专项混成一条大查询而影响日志和去重。

### 6.2 每个专项的粗筛条件

每个专项的基础 JQL 由以下部分组成：

- `project = <regression_project>`
- `reporter in (<history_reporter>)`
- `summary ~ "<专项粗筛关键词>"`

### 6.3 专项关键词规则

- `Monkey专项` 使用 `[MonkeyAEE]`
- 其他专项使用 `【稳定性专项】`

### 6.4 精筛规则

即使某条问题被 JQL 拉到，仍然必须在代码内继续按以下条件过滤后才能进入 PASS 判定：

- `status` 属于 `已解决` 或 `Verified`
- `resolution` 属于 `已修复`
- 从 `summary` 解析出的专项名必须属于本次传入的 `--regression-specialty`

这意味着 JQL 只负责粗筛，真正进入状态机的候选问题必须通过内部保护性过滤。

## 7. 回归验证模式执行流程

1. 解析参数并识别为 `regression_verify` 模式
2. 连接 Jira
3. 根据 `regression_project` 选择项目级 SQLite
4. 按 `regression_specialty` 逐个构建 JQL
5. 拉取历史问题快照
6. 同一 run 内按 `jira_key` 去重
7. 对每条候选问题执行内部状态 / 解决结果 / 专项过滤
8. 使用 `current_version` 调用现有 `evaluate_regression_pass(...)`
9. 生成 `REGRESSION_PASS_SKIP / PROGRESS / CLOSE` 决策
10. 输出 JSON / Excel 摘要
11. 非 dry-run 时，按现有逻辑执行评论、累计 PASS、必要时关单

## 8. verified_versions 的含义

`issue_state.verified_versions` 代表某个 `jira_key` 已经被确认通过回归验证的版本集合。

示例：

- `jira_key = X6851OS16-607`
- `verified_versions = ["X6851-16.3.0.020", "X6851-16.3.0.021"]`

如果本次再次使用 `--current-version X6851-16.3.0.021(...)` 执行回归验证，则该问题必须返回 `REGRESSION_PASS_SKIP`，而不是再次累计 PASS。

这样做的目的：

- 避免同一版本重复累计
- 避免重复加评论
- 避免错误提前关单

## 9. 本地库隔离设计

### 9.1 隔离维度

本地 SQLite 按 Jira 项目 Key 隔离，而不是所有项目共用一个数据库。

### 9.2 路径

路径结构固定为：

- `result/regression_cache/X6851OS16.db`
- `result/regression_cache/X6852OS16.db`

### 9.3 路由规则

- Excel 模式：
  - 从上传模板中解析唯一 `Project`
  - 自动使用 `result/regression_cache/<Project>.db`
- 回归验证模式：
  - 直接使用 `--regression-project`
  - 自动使用 `result/regression_cache/<regression_project>.db`

### 9.4 共享范围

- 同一个项目下：
  - Excel 模式和回归验证模式共享同一份本地累计状态
- 不同项目之间：
  - 完全隔离

## 10. 本地库写入策略

### 10.1 sync_runs

每次命令执行生成一个 `run_id`。

回归验证模式下：

- 多专项属于同一个 `run_id`
- `current_version` 继续写入 `sync_runs.current_version`
- `jql` 保存为本次实际构造出来的多条专项 JQL 汇总文本

### 10.2 jira_issue_snapshot

保存本次 run 拉到的历史问题快照。

要求：

- 同一 run 内按 `jira_key` 去重
- 去重后再写库，避免多专项命中同一问题导致重复快照

### 10.3 execution_results

每个被评估的 `jira_key` 每次 run 写一条执行结果。

动作值沿用现有枚举：

- `REGRESSION_PASS_SKIP`
- `REGRESSION_PASS_PROGRESS`
- `REGRESSION_PASS_CLOSE`

### 10.4 issue_state

继续作为唯一累计状态来源，保存：

- `regression_pass_count`
- `verified_versions`
- `last_seen_version`

Excel 模式和回归验证模式只要属于同一项目，就都更新同一个 `issue_state`。

## 11. dry-run 语义

回归验证模式必须保持与现有逻辑一致的 dry-run 语义。

`--dry-run` 时：

- 允许连接 Jira
- 允许导出历史问题
- 允许写 `sync_runs`
- 允许写 `jira_issue_snapshot`
- 允许写 `execution_results`
- 不执行评论
- 不执行关单
- 不更新 `issue_state.regression_pass_count`
- 不追加 `verified_versions`

非 `--dry-run` 时：

- 按现有逻辑执行评论
- 按现有逻辑累计 PASS
- 达到阈值时执行关单

## 12. 日志与结果输出

回归验证模式继续复用当前输出：

- 控制台日志
- JSON 结果
- Excel 摘要

新增日志项：

- 当前模式：`回归验证模式`
- 当前项目
- 当前 reporter
- 当前版本
- 当前专项
- 当前专项实际构造的 JQL
- 每条候选问题的判定结果

## 13. 非目标

本次设计不包含以下内容：

- 不开放用户直接输入原始 JQL
- 不做跨项目共享状态
- 不改变现有 Excel 模式的业务语义
- 不新增新的回归判定标准，仅复用现有 PASS 状态机

## 14. 风险与约束

- 多专项时如果不按 `jira_key` 去重，会导致重复计数风险
- 如果只依赖 JQL 而不做内部状态过滤，可能推进错误问题
- 如果不按项目拆分 SQLite，不同项目的累计状态会互相污染
- 如果 `verified_versions` 不参与去重，同一版本重复执行会错误累计 PASS
