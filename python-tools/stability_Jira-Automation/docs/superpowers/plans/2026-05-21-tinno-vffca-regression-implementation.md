# Tinno VFFCA Regression Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在不修改 `Transsion_Jira_Tool_20260323` 的前提下，为 `Tinno_Jira_Tool_20260520` 补齐 `VFFCA` 的 `build_version` 落库、严格版本决策，以及 resolve/close 最小流转能力。

**Architecture:** 保持现有 Tinno 入口、适配层、回归执行层三段结构不变，只在 Tinno 目录内增加 `build_version` 生命周期和 `VFFCA` 版本规则。状态判断仍以 `status/resolution` 为先，`build_version/fix_version/current_version` 只在 `Resolved + 完成` 与回归 PASS 分支参与判定。

**Tech Stack:** Python 3.8+, pandas, sqlite3, requests, Jira REST API

---

### Task 1: 持久化 `build_version`

**Files:**
- Modify: `Tinno_Jira_Tool_20260520/tinno_regression_store.py`
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_store.py`

- [ ] 为 `jira_issue_snapshot` / `issue_state` 增加 `build_version` 字段，并在 `_init_db()` 中对旧库执行 `ALTER TABLE ... ADD COLUMN build_version TEXT`
- [ ] 扩展 `save_snapshot()`、`fetch_snapshot_by_run()`、`upsert_issue_state()`、`fetch_issue_state()`、`fetch_regression_pass_candidates()`、`record_regression_pass()` 的字段读写
- [ ] 增加回归存储测试，覆盖：
```python
assert "build_version" in snapshot_columns
assert fetched["build_version"] == "V552AA-16-260512V16_FTM_userdebug_202605120842_sign"
```

### Task 2: 补 `build_version` 解析与 Tinno 流转字段组装

**Files:**
- Modify: `Tinno_Jira_Tool_20260520/create_tinno_jira_batch_from_excel.py`
- Modify: `Tinno_Jira_Tool_20260520/tinno_batch_jira_common.py`
- Modify: `Tinno_Jira_Tool_20260520/jira_p12_client.py`
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_entry.py`

- [ ] 在 `build_regression_row()` 中把 Excel 行上的建单版本解析为 `build_version`，并让 `current_version` 继续表示本轮验证版本
- [ ] 在 `fetch_issue_snapshot_fields()` 中从 Jira `summary` / `environment` / `raw_payload` 回填 `build_version`
- [ ] 增加 Tinno Jira 流转辅助函数，支持：
```python
transitions = jira_client.transitions(issue, expand_fields=True)
fields = {
    "resolution": {"name": "完成"},
    "fixVersions": [{"name": fix_version}],
}
```
- [ ] 增加允许值校验，`VFFCA` 的 `fixVersions` 不在实时候选时返回 `MANUAL_REVIEW`

### Task 3: 补 `VFFCA` 严格版本决策与 PASS/关单执行

**Files:**
- Modify: `Tinno_Jira_Tool_20260520/tinno_regression_executor.py`
- Modify: `Tinno_Jira_Tool_20260520/create_tinno_jira_batch_from_excel.py`
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_executor.py`
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_entry.py`

- [ ] 把 `decide_action()` 改成项目感知，`VFFCA` 的 `Resolved + 完成` 分支按下列规则判定：
```python
if not build_version or not fix_version or not current_version:
    return manual_review
if fix_version <= build_version or current_version < build_version:
    return manual_review
if build_version < current_version < fix_version:
    return wait_new_version
if current_version >= fix_version:
    return manual_review
```
- [ ] 保持 open-like / wont-fix / closed 的优先级高于版本比较
- [ ] 在 `process_regression_pass_candidates()` 中加入 `build_version` 门槛，只允许 `current_version >= fix_version` 且版本链合法时计 PASS
- [ ] 在 `execute_decision()` 中补最小 resolve/close 执行分支，失败落 `MANUAL_REVIEW`

### Task 4: 验证

**Files:**
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_store.py`
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_executor.py`
- Test: `Tinno_Jira_Tool_20260520/test/test_tinno_regression_entry.py`

- [ ] 运行：
```powershell
python -m unittest Tinno_Jira_Tool_20260520.test.test_tinno_build_issue_fields
python -m unittest Tinno_Jira_Tool_20260520.test.test_tinno_regression_entry
python -m unittest Tinno_Jira_Tool_20260520.test.test_tinno_regression_store
python -m unittest Tinno_Jira_Tool_20260520.test.test_tinno_regression_executor
```
- [ ] 如需联调，再执行 Tinno dry-run：
```powershell
python create_tinno_jira_batch_from_excel.py --add-excel-file .\JIRA_Upload_List_20250913_223852.xlsx --jira-cookie-jsessionid "<JSESSIONID>" --jira-cookie-xsrf-token "<XSRF>" --dry-run
```
