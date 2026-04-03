# Transsion Regression JQL Keywords Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 让第二阶段回归历史单导出根据上传模板中的专项类型动态选择检索关键词，Monkey专项检索 `MonkeyAEE`，其他专项检索 `稳定性专项`，并避免 `summary ~ "[MonkeyAEE]"` 触发 Jira 400。

**Architecture:** 保留现有 `regression_rules.json` 中的基础 JQL 作为项目/Reporter 范围条件，在主入口里基于 Excel 行内容动态追加 summary 关键词过滤。新增小型 JQL 构造辅助函数，集中处理专项识别与特殊字符转义，避免把动态规则散落在导出逻辑中。

**Tech Stack:** Python, pandas, pytest, jira

---

### Task 1: 先锁定期望行为

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`

- [ ] **Step 1: 写失败测试，覆盖 Monkey / 非 Monkey / 混合专项的导出 JQL**

```python
def test_build_regression_export_jql_uses_monkey_keyword_for_monkey_rows(...):
    ...

def test_build_regression_export_jql_uses_stability_keyword_for_non_monkey_rows(...):
    ...

def test_build_regression_export_jql_combines_keywords_for_mixed_rows(...):
    ...
```

- [ ] **Step 2: 运行单测确认失败**

Run: `python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q`
Expected: 新增测试因缺少辅助函数或行为不符而失败

### Task 2: 实现动态 JQL 构造

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`

- [ ] **Step 1: 新增专项识别与关键词转义辅助函数**

```python
def collect_regression_summary_keywords(df: pd.DataFrame) -> list[str]:
    ...

def build_regression_export_jql(base_jql: str, keywords: list[str]) -> str:
    ...
```

- [ ] **Step 2: 在历史单导出前基于当前上传模板生成动态 JQL**

```python
summary_keywords = collect_regression_summary_keywords(df)
snapshot_rows = export_jira_snapshot(jira, regression_rules, summary_keywords=summary_keywords)
```

- [ ] **Step 3: 仅保留配置中的基础范围条件，不再把固定关键词写死在代码路径里**

```python
issues = jira_client.search_issues(export_jql, ...)
```

- [ ] **Step 4: 运行目标单测确认通过**

Run: `python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q`
Expected: 相关测试通过

### Task 3: 更新配置契约并回归验证

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/config/regression_rules.json`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py`

- [ ] **Step 1: 把配置中的 `jira_export.jql` 调整为不含固定 summary 关键词的基础范围条件**

```json
"jql": "project = X6852OS16 AND reporter in (dailv.tinno)"
```

- [ ] **Step 2: 更新配置契约测试**

```python
assert rules.jira_export.jql == "project = X6852OS16 AND reporter in (dailv.tinno)"
```

- [ ] **Step 3: 运行相关测试确认通过**

Run: `python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py -q`
Expected: PASS
