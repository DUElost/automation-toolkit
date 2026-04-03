# Transsion Single Project Batch Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 让第二阶段批量处理强制要求一份上传模板只包含一个 Jira 项目，并从模板实际 `Project` 列提取该项目用于回归历史导出。

**Architecture:** 在主入口读取 Excel 并连接 Jira 后，先解析模板中的唯一项目；如果项目为空或出现多个项目则直接失败退出。历史单导出 JQL 不再从配置中预置项目，而是把模板项目作为动态基础条件拼入导出语句，再叠加 reporter 和专项关键词过滤。

**Tech Stack:** Python, pandas, pytest, jira

---

### Task 1: 锁定单项目约束

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`

- [ ] **Step 1: 写失败测试，覆盖模板单项目提取与多项目拒绝**

```python
def test_collect_batch_project_key_returns_single_project(...):
    ...

def test_collect_batch_project_key_raises_for_multiple_projects(...):
    ...
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q`
Expected: 新增测试失败

### Task 2: 实现模板项目驱动的回归导出

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`

- [ ] **Step 1: 新增唯一项目提取辅助函数**

```python
def collect_batch_project_key(...):
    ...
```

- [ ] **Step 2: 历史导出 JQL 改为使用模板项目，不再依赖配置内预置项目**

```python
export_jql = build_regression_export_jql(
    base_jql=build_regression_base_jql(batch_project_key, args.jira_username),
    keywords=summary_keywords,
)
```

- [ ] **Step 3: 多项目或空项目时提前报错退出**

```python
logger.error("当前上传模板包含多个 Jira 项目...")
return 1
```

- [ ] **Step 4: 运行测试确认通过**

Run: `python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q`
Expected: PASS

### Task 3: 回归验证

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py`

- [ ] **Step 1: 更新配置契约，明确配置不再预置项目过滤语句**

```python
assert rules.jira_export.jql == "reporter in (dailv.tinno)"
```

- [ ] **Step 2: 运行相关回归**

Run: `python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_pass.py -q`
Expected: PASS
