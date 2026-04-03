# Transsion Jira Tool 第二阶段回归增强设计

## 1. 目标

为 [Transsion_Jira_Tool_20260323](F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323) 的第二阶段补充以下能力：

- 执行前按配置的 JQL 从 Jira 导出历史问题单到本地
- 将本轮上传数据与历史问题单进行强命中比对
- 根据历史问题单状态执行不同动作
- 支持已解决问题的回归 PASS 记录与达到阈值后的关单流程
- 支持 Open 类问题的累计出现次数和整单覆盖更新
- 同时输出本地 SQLite 明细和 Excel 摘要结果

该能力必须保持为 `Transsion_Jira_Tool_20260323` 目录下的独立工具实现，可以复用仓库内现有相似设计思路，但不依赖 `stability_Jira-Automation/src` 主流程作为运行时前置。

## 2. 设计原则

- 保持独立：配置、数据库、结果报表、入口脚本均位于当前工具目录
- 轻量持久化：使用单文件 SQLite，不引入外部服务
- 低误判优先：只支持强命中，不引入模糊命中自动处理
- 配置驱动：JQL、状态分组、回归阈值、评论模板均可配置
- 不破坏现有第二阶段建单逻辑：新增能力以“命中历史单后的决策分流”为主

## 3. 术语定义

### 3.1 已解决问题

只有同时满足以下条件，才认定为“已解决问题”：

- Jira 状态为 `已解决`
- Jira 解决结果为 `已修复`

### 3.2 不修复类问题

以下解决结果统一归为 `wont_fix_like`：

- `问题不修改`
- `非问题`
- `Won't Fix`
- `不解决`

### 3.3 Open 类问题

以下状态统一归为 `open_like`：

- `Open`
- `开放`
- `Reopened`
- `重新打开`
- `处理中`

`Submitted` 不参与历史问题单状态决策，只保留新建问题后尝试流转到 `Open/开放` 的现有逻辑。

## 4. 历史问题导出范围

执行前必须按配置文件中的 JQL 从 Jira 导出历史问题单。

首版导出范围建议如下：

```sql
project = X6852OS16
AND reporter in (dailv.tinno)
AND (
  summary ~ "【稳定性专项】"
  OR summary ~ "[MonkeyAEE]"
)
```

导出规则必须配置化，后续允许按项目、提单人、标题关键字调整，不改代码。

## 5. 命中标准

### 5.1 总体原则

只支持强命中。未达到强命中条件的历史问题单，一律视为未命中，不进行自动复用。

### 5.2 强命中条件

历史问题单与本轮上传问题，必须同时满足以下条件才算命中成功：

- `affect_project` 完全一致
- `environment` 完全一致
- `exp_class` 完全一致
- `caused_by_signature` 相似度大于等于配置阈值

建议首版阈值：

- `cause_similarity_threshold = 0.90`

### 5.3 非命中说明

以下情况均视为不命中：

- `affect_project` 不一致
- `environment` 不一致
- `exp_class` 不一致
- `caused_by_signature` 未达到阈值

以下字段不参与主命中判断：

- `components`
- `summary`

### 5.4 caused_by_signature

`caused_by` 在比较前需要做归一化，去掉噪声信息，例如：

- 行号
- 内存地址
- 时间戳
- 无关空白

## 6. 状态决策动作

### 6.1 命中 open_like

条件：命中的历史问题单状态属于 `open_like`

动作：

- 不提新单
- 更新业务计数：`new_count = old_count + current_count`
- 按新计数重算并覆盖更新：
  - `Summary`
  - `Description`
  - `Priority`
  - 严重度附件
- 本地 `open_seen_count + 1`
- 追加主评论，格式与新增问题单评论一致，包含完整详情块
- 若本轮有 `PS`，继续追加 `PS` 评论

失败规则：

- 主评论失败，整条记录记失败
- `PS` 评论失败，整条记录记失败

### 6.2 命中已解决已修复，且当前版本早于修复版本

条件：

- 状态为 `已解决`
- 解决结果为 `已修复`
- `fixVersion` 有值
- `current_version < fixVersion`

动作：

- 不改 Jira 状态
- 追加评论：`当前版本出现，待新版本验证`
- 评论格式与新增问题单评论一致，包含完整详情块
- 若有 `PS`，继续追加

失败规则：

- 任一评论失败，整条记录记失败

### 6.3 命中已解决已修复，但需人工确认

条件满足以下任一项：

- `fixVersion` 为空
- `current_version >= fixVersion`

动作：

- 不改 Jira
- 不自动 Reopen
- 不追加评论
- 仅在结果中标记 `MANUAL_REVIEW`

退出码规则：

- 不影响整体退出码
- 仅报表提示

### 6.4 命中不修复类问题

条件：解决结果属于 `wont_fix_like`

动作：

- 不提单
- 不改状态
- 追加评论：`当前版本仍出现，但按不修复类问题保留原结论`
- 评论格式与新增问题单评论一致，包含完整详情块
- 若有 `PS`，继续追加

失败规则：

- 任一评论失败，整条记录记失败

### 6.5 命中已关闭且非不修复类问题

条件：

- 状态属于关闭类
- 解决结果不属于 `wont_fix_like`

动作：

- 重新提单
- 新建问题继续走当前第二阶段已有流程：
  - 创建问题
  - 评论
  - 上传严重度附件
  - 流转到 `Open/开放`
  - 回写经办人

### 6.6 命中已关闭且属于不修复类问题

条件：

- 状态属于关闭类
- 解决结果属于 `wont_fix_like`

动作：

- 不提单
- 不改状态
- 追加与 `wont_fix_like` 相同的保留结论评论
- 若有 `PS`，继续追加

失败规则：

- 任一评论失败，整条记录记失败

### 6.7 未命中历史问题

条件：没有任何历史问题达到强命中条件

动作：

- 新建 Jira 问题
- 延用当前第二阶段已有建单流程

## 7. 回归 PASS 与关单规则

### 7.1 PASS 判定前置条件

历史问题单只有同时满足以下条件，才允许记录回归 PASS：

- 状态为 `已解决`
- 解决结果为 `已修复`
- 本轮未命中该问题
- `fixVersion` 有值
- `current_version >= fixVersion`
- `current_version` 之前未记过 PASS

### 7.2 PASS 累计规则

配置项：

- `required_regression_pass_versions`

默认值：

- `2`

处理逻辑：

- `new_pass_count = old_pass_count + 1`
- 若 `new_pass_count < required_regression_pass_versions`
  - 追加评论：`已回归验证{n}个版本PASS`
  - 更新 `regression_pass_count`
  - 更新 `verified_versions`
- 若 `new_pass_count >= required_regression_pass_versions`
  - 追加评论：`已回归验证{n}个版本PASS`
  - 走关单流程
  - 更新 `regression_pass_count`
  - 更新 `verified_versions`
  - 更新本地状态为关闭

该规则必须兼容 `1/2/3/N`，不得写死“第 2 次关单”。

### 7.3 不参与 PASS 判定的情况

以下情况不记录 PASS，仅在结果中说明原因：

- `fixVersion` 为空
- `current_version < fixVersion`

## 8. 评论规则

### 8.1 风格要求

除 `MANUAL_REVIEW` 外，所有自动评论都应使用与新增问题单评论一致的风格：

- 首行写动作说明
- 后续附带详情块

建议详情块至少包含：

- `Version`
- `Path`
- `Duplicate Number`
- `Device Count`

### 8.2 PS 规则

若本轮记录存在 `PS`：

- 新建问题时，按现有逻辑继续追加
- 命中 `open_like`、`wait_new_version`、`wont_fix_like`、`closed_wont_fix_like` 时，也继续追加

### 8.3 评论失败规则

只要主评论或 `PS` 评论任一失败：

- 整条记录记失败

## 9. 配置文件设计

建议新增配置文件：

- `config/regression_rules.json`

建议结构如下：

```json
{
  "jira_export": {
    "enabled": true,
    "jql": "project = X6852OS16 AND reporter in (dailv.tinno) AND (summary ~ \"【稳定性专项】\" OR summary ~ \"[MonkeyAEE]\")",
    "max_results": 1000,
    "fields": [
      "key",
      "summary",
      "status",
      "resolution",
      "reporter",
      "assignee",
      "created",
      "updated",
      "comment",
      "fixVersions",
      "components",
      "priority",
      "description"
    ]
  },
  "matching": {
    "required_exact_fields": [
      "affect_project",
      "environment",
      "exp_class"
    ],
    "cause_similarity_threshold": 0.9
  },
  "status_rules": {
    "open_like_statuses": [
      "Open",
      "开放",
      "Reopened",
      "重新打开",
      "处理中"
    ],
    "resolved_statuses": [
      "已解决"
    ],
    "resolved_fixed_resolutions": [
      "已修复"
    ],
    "wont_fix_resolutions": [
      "问题不修改",
      "非问题",
      "Won't Fix",
      "不解决"
    ],
    "closed_statuses": [
      "Closed",
      "已关闭",
      "已关单"
    ]
  },
  "regression": {
    "required_regression_pass_versions": 2,
    "dedupe_pass_by_version": true
  },
  "output": {
    "sqlite_path": "result/transsion_regression_cache.db",
    "excel_summary_dir": "result"
  }
}
```

评论模板可以参考现有 [comment_templates.json](F:/automation-toolkit/python-tools/stability_Jira-Automation/config/comment_templates.json) 的命名方式，但应在当前工具目录下维护独立配置版本。

## 10. SQLite 表结构最小集

建议本地库文件：

- `result/transsion_regression_cache.db`

### 10.1 jira_issue_snapshot

用途：保存每次执行前从 Jira 导出的历史快照

建议字段：

- `id`
- `run_id`
- `jira_key`
- `summary`
- `status`
- `resolution`
- `fix_version`
- `priority`
- `assignee`
- `reporter`
- `affect_project`
- `environment`
- `exp_class`
- `caused_by`
- `created_at`
- `updated_at`
- `raw_payload`

### 10.2 issue_state

用途：保存本地累计状态

建议字段：

- `id`
- `jira_key`
- `fingerprint`
- `status`
- `resolution`
- `fix_version`
- `count`
- `open_seen_count`
- `regression_pass_count`
- `verified_versions`
- `last_seen_version`
- `updated_at`

### 10.3 execution_results

用途：保存本次每条输入记录的执行结果

建议字段：

- `id`
- `run_id`
- `row_number`
- `source_summary`
- `matched_jira_key`
- `matched_status`
- `matched_resolution`
- `fix_version`
- `action`
- `success`
- `manual_review`
- `reason`
- `old_count`
- `new_count`
- `comment_status`
- `ps_comment_status`
- `result_message`
- `created_at`

### 10.4 sync_runs

用途：保存每次同步/执行元数据

建议字段：

- `run_id`
- `started_at`
- `finished_at`
- `jql`
- `current_version`
- `exported_issue_count`
- `processed_row_count`
- `success_count`
- `failed_count`

## 11. 执行流程时序

1. 读取第二阶段输入 Excel
2. 读取 `regression_rules.json`
3. 从 Jira 按 JQL 导出历史问题单
4. 将导出结果写入 `jira_issue_snapshot`
5. 逐行读取本轮输入并执行强命中判断
6. 按命中状态决定：
   - 更新原单
   - 仅评论
   - 重新提单
   - 人工确认
   - PASS/关单
7. 将执行结果写入 `execution_results`
8. 更新 `issue_state`
9. 导出 Excel 摘要

## 12. Excel 摘要输出

建议 Excel 摘要至少包含以下字段：

- `row_number`
- `matched_jira_key`
- `matched_status`
- `matched_resolution`
- `fix_version`
- `action`
- `success`
- `manual_review`
- `reason`
- `old_count`
- `new_count`
- `comment_status`
- `ps_comment_status`
- `result_message`

## 13. 风险与注意事项

- 由于采用逐行处理，同一轮中多个输入命中同一 Jira 单时，允许该单被多次更新
- 为降低误判，本版不支持弱命中和自动模糊归并
- `MANUAL_REVIEW` 场景不应改 Jira，也不应影响整体退出码
- 评论失败会导致单条记录失败，结果中必须清晰体现失败原因
- `Priority` 与严重度附件在 `open_like` 更新时允许升降级，直接覆盖旧值

## 14. 暂不包含内容

以下内容不纳入本次设计范围：

- 模糊命中后的人工审核工作流
- 本轮内对多行输入的二次聚合
- 主框架数据库复用
- 外部服务型持久化
