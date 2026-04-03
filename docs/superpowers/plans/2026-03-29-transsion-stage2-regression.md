# Transsion Stage2 Regression Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `Transsion_Jira_Tool_20260323` 的第二阶段增加“Jira 历史单导出、本地 SQLite 比对、强命中判定、状态动作执行、回归 PASS/关单、Excel 摘要输出”能力，并保持该工具目录独立运行。

**Architecture:** 以 `create_transsion_jira_batch_from_excel.py` 为统一入口，新增独立的配置读取、SQLite 持久化、Jira 快照导出与强命中、状态动作执行模块。入口脚本只做参数解析和流程编排，业务规则分拆到新模块中，避免把现有建单脚本继续堆大。

**Tech Stack:** Python 3、pandas、sqlite3、jira、json、openpyxl/xlsxwriter（沿用 pandas 的 Excel 输出能力）

---

### Task 1: 配置文件与结果模型落地

**Files:**
- Create: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/config/regression_rules.json`
- Create: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_models.py`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py`

- [ ] **Step 1: 写配置读取失败用例**

```python
from pathlib import Path

import pytest

from transsion_regression_models import load_regression_rules


def test_load_regression_rules_requires_matching_fields(tmp_path: Path):
    config_file = tmp_path / "regression_rules.json"
    config_file.write_text('{"matching": {"required_exact_fields": []}}', encoding="utf-8")

    with pytest.raises(ValueError, match="required_exact_fields"):
        load_regression_rules(config_file)
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py -q`
Expected: FAIL with `ImportError` or `AttributeError` for `load_regression_rules`

- [ ] **Step 3: 写最小配置文件和模型实现**

```python
from dataclasses import dataclass
from pathlib import Path
from typing import Any
import json


@dataclass
class MatchingRules:
    required_exact_fields: list[str]
    cause_similarity_threshold: float


@dataclass
class RegressionRules:
    jira_export: dict[str, Any]
    matching: MatchingRules
    status_rules: dict[str, list[str]]
    regression: dict[str, Any]
    output: dict[str, Any]


def load_regression_rules(path: Path) -> RegressionRules:
    raw = json.loads(path.read_text(encoding="utf-8"))
    required_fields = raw.get("matching", {}).get("required_exact_fields") or []
    if not required_fields:
        raise ValueError("required_exact_fields 不能为空")
    threshold = float(raw.get("matching", {}).get("cause_similarity_threshold", 0.9))
    return RegressionRules(
        jira_export=raw.get("jira_export", {}),
        matching=MatchingRules(required_fields, threshold),
        status_rules=raw.get("status_rules", {}),
        regression=raw.get("regression", {}),
        output=raw.get("output", {}),
    )
```

- [ ] **Step 4: 运行测试确认通过**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py -q`
Expected: PASS

- [ ] **Step 5: 补充 README 中的配置说明**

```text
- 新增 config/regression_rules.json
- 第二阶段执行前会按该文件中的 JQL 导出历史 Jira 问题单
- 回归阈值、状态分组、输出路径均从该文件读取
```

- [ ] **Step 6: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/config/regression_rules.json python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_models.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt
git commit -m "feat(transsion-jira): add regression config model"
```

### Task 2: 本地 SQLite 存储层

**Files:**
- Create: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_store.py`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_store.py`

- [ ] **Step 1: 写建表与写入快照的失败测试**

```python
from pathlib import Path

from transsion_regression_store import RegressionStore


def test_store_initializes_tables_and_saves_snapshot(tmp_path: Path):
    db_path = tmp_path / "cache.db"
    store = RegressionStore(db_path)
    store.save_snapshot(
        run_id="run-1",
        rows=[{
            "jira_key": "KO5OS16AEE-1",
            "summary": "[MonkeyAEE] sample",
            "status": "Open",
            "resolution": "",
            "fix_version": "",
            "affect_project": "V1",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException",
        }],
    )

    snapshot_rows = store.fetch_snapshot_by_run("run-1")
    assert len(snapshot_rows) == 1
    assert snapshot_rows[0]["jira_key"] == "KO5OS16AEE-1"
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_store.py -q`
Expected: FAIL with missing `RegressionStore`

- [ ] **Step 3: 实现最小 SQLite 存储层**

```python
import sqlite3
from pathlib import Path


class RegressionStore:
    def __init__(self, db_path: Path):
        self.db_path = db_path
        self.conn = sqlite3.connect(db_path)
        self.conn.row_factory = sqlite3.Row
        self._init_schema()

    def _init_schema(self) -> None:
        self.conn.executescript(
            """
            CREATE TABLE IF NOT EXISTS jira_issue_snapshot (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                run_id TEXT NOT NULL,
                jira_key TEXT NOT NULL,
                summary TEXT,
                status TEXT,
                resolution TEXT,
                fix_version TEXT,
                affect_project TEXT,
                environment TEXT,
                exp_class TEXT,
                caused_by TEXT,
                raw_payload TEXT
            );
            CREATE TABLE IF NOT EXISTS issue_state (
                jira_key TEXT PRIMARY KEY,
                fingerprint TEXT,
                status TEXT,
                resolution TEXT,
                fix_version TEXT,
                count INTEGER DEFAULT 0,
                open_seen_count INTEGER DEFAULT 0,
                regression_pass_count INTEGER DEFAULT 0,
                verified_versions TEXT DEFAULT '[]',
                last_seen_version TEXT,
                updated_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
            CREATE TABLE IF NOT EXISTS execution_results (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                run_id TEXT NOT NULL,
                row_number INTEGER,
                matched_jira_key TEXT,
                action TEXT,
                success INTEGER,
                manual_review INTEGER,
                reason TEXT,
                result_message TEXT,
                created_at TEXT DEFAULT CURRENT_TIMESTAMP
            );
            CREATE TABLE IF NOT EXISTS sync_runs (
                run_id TEXT PRIMARY KEY,
                jql TEXT,
                current_version TEXT,
                started_at TEXT,
                finished_at TEXT
            );
            """
        )
        self.conn.commit()
```

- [ ] **Step 4: 运行测试确认通过**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_store.py -q`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_store.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_store.py
git commit -m "feat(transsion-jira): add regression sqlite store"
```

### Task 3: Jira 快照导出与强命中模块

**Files:**
- Create: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_matcher.py`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_matcher.py`

- [ ] **Step 1: 写 caused_by 归一化和强命中测试**

```python
from transsion_regression_matcher import normalize_caused_by, is_strong_match


def test_normalize_caused_by_removes_line_numbers_and_addresses():
    text = "java.lang.RuntimeException: boom at Foo.java:123 addr=0x7fff"
    normalized = normalize_caused_by(text)
    assert ":123" not in normalized
    assert "0x7fff" not in normalized


def test_is_strong_match_requires_exact_fields_and_cause_threshold():
    current = {
        "affect_project": "V1",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException: boom at Foo.java:1",
    }
    history = {
        "affect_project": "V1",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException: boom at Foo.java:99",
    }
    assert is_strong_match(current, history, cause_threshold=0.9) is True
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_matcher.py -q`
Expected: FAIL with missing matcher functions

- [ ] **Step 3: 实现快照行解析与强命中判断**

```python
import re
from difflib import SequenceMatcher


_LINE_NO_RE = re.compile(r":\d+")
_ADDR_RE = re.compile(r"0x[0-9a-fA-F]+")


def normalize_caused_by(text: str) -> str:
    normalized = _LINE_NO_RE.sub("", text or "")
    normalized = _ADDR_RE.sub("", normalized)
    return " ".join(normalized.split())


def is_strong_match(current: dict, history: dict, cause_threshold: float) -> bool:
    if current.get("affect_project") != history.get("affect_project"):
        return False
    if current.get("environment") != history.get("environment"):
        return False
    if current.get("exp_class") != history.get("exp_class"):
        return False
    current_cause = normalize_caused_by(current.get("caused_by", ""))
    history_cause = normalize_caused_by(history.get("caused_by", ""))
    score = SequenceMatcher(None, current_cause, history_cause).ratio()
    return score >= cause_threshold
```

- [ ] **Step 4: 在公共模块里补充 Jira 详情读取辅助函数**

```python
def fetch_issue_snapshot_fields(jira_client: JIRA, issue_key: str) -> dict[str, Any]:
    issue = jira_client.issue(issue_key)
    fields = issue.raw.get("fields", {})
    return {
        "jira_key": issue.key,
        "summary": fields.get("summary"),
        "status": (fields.get("status") or {}).get("name", ""),
        "resolution": (fields.get("resolution") or {}).get("name", ""),
        "fix_version": ((fields.get("fixVersions") or [{}])[0]).get("name", ""),
        "priority": (fields.get("priority") or {}).get("name", ""),
        "description": fields.get("description", ""),
        "raw_payload": issue.raw,
    }
```

- [ ] **Step 5: 运行测试确认通过**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_matcher.py -q`
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_matcher.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_matcher.py
git commit -m "feat(transsion-jira): add jira snapshot matcher"
```

### Task 4: 状态动作执行器

**Files:**
- Create: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_executor.py`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_executor.py`

- [ ] **Step 1: 写 open_like 更新与 manual_review 测试**

```python
from transsion_regression_executor import decide_action


def test_decide_action_returns_open_like_update():
    action = decide_action(
        current_row={"count": 3, "ps": "note"},
        history={"status": "Open", "resolution": "", "fix_version": ""},
        current_version="V2",
    )
    assert action.action == "OPEN_LIKE_UPDATE"


def test_decide_action_returns_manual_review_when_resolved_fixed_without_fix_version():
    action = decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "已修复", "fix_version": ""},
        current_version="V2",
    )
    assert action.action == "MANUAL_REVIEW"
    assert action.update_jira is False
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_executor.py -q`
Expected: FAIL with missing executor module

- [ ] **Step 3: 实现决策结果模型与决策函数**

```python
from dataclasses import dataclass


@dataclass
class ActionDecision:
    action: str
    update_jira: bool
    manual_review: bool
    comment_required: bool
    recreate_issue: bool = False


def decide_action(current_row: dict, history: dict, current_version: str) -> ActionDecision:
    status = str(history.get("status") or "")
    resolution = str(history.get("resolution") or "")
    fix_version = str(history.get("fix_version") or "")
    if status in {"Open", "开放", "Reopened", "重新打开", "处理中"}:
        return ActionDecision("OPEN_LIKE_UPDATE", True, False, True)
    if resolution in {"问题不修改", "非问题", "Won't Fix", "不解决"}:
        return ActionDecision("WONT_FIX_KEEP", False, False, True)
    if status in {"Closed", "已关闭", "已关单"}:
        return ActionDecision("CLOSED_RECREATE", True, False, False, recreate_issue=True)
    if status == "已解决" and resolution == "已修复" and not fix_version:
        return ActionDecision("MANUAL_REVIEW", False, True, False)
    return ActionDecision("CREATE_NEW", True, False, False, recreate_issue=True)
```

- [ ] **Step 4: 在公共模块中补充更新 Jira 字段、追加评论、上传附件、读取 transition 的辅助函数**

```python
def update_issue_fields(jira_client: JIRA, issue_key: str, fields: dict[str, Any]) -> None:
    issue = jira_client.issue(issue_key)
    issue.update(fields=fields)


def add_issue_comment(jira_client: JIRA, issue_key: str, comment: str) -> None:
    jira_client.add_comment(issue_key, comment)
```

- [ ] **Step 5: 运行测试确认通过**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_executor.py -q`
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_executor.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_batch_jira_common.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_executor.py
git commit -m "feat(transsion-jira): add regression action executor"
```

### Task 5: 入口脚本接入回归流程

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`

- [ ] **Step 1: 写入口 dry-run 结果结构测试**

```python
from types import SimpleNamespace

from create_transsion_jira_batch_from_excel import run_batch_create


def test_run_batch_create_returns_manual_review_and_success_entries(monkeypatch):
    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="u",
        jira_password="p",
        jira_server="http://jira",
        config_file="fake.json",
        severity_rules_file="rules.xls",
        bug_severity_image_dir="images",
        wait_between_issues=0,
        dry_run=True,
        validate_metadata=False,
        add_comments=True,
    )
    result = run_batch_create(args)
    assert result in {0, 1}
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py -q`
Expected: FAIL due to unmocked dependencies or missing regression integration

- [ ] **Step 3: 重构入口为“导出快照 -> 匹配 -> 决策 -> 执行动作 -> 记录结果”**

```python
rules = load_regression_rules(Path(CURRENT_DIR / "config" / "regression_rules.json"))
store = RegressionStore(Path(rules.output["sqlite_path"]))
run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
snapshot_rows = export_jira_snapshot(jira, rules.jira_export)
store.save_snapshot(run_id, snapshot_rows)

for index, row in df.iterrows():
    normalized_row = build_regression_row(row)
    matched = find_best_match(normalized_row, snapshot_rows, rules.matching.cause_similarity_threshold)
    decision = decide_action(normalized_row, matched or {}, current_version=normalized_row["version"])
    result = execute_decision(...)
    store.save_execution_result(run_id, result)
```

- [ ] **Step 4: 运行入口测试与现有 dry-run 验证**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py -q`
Expected: PASS

Run: `python python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py --add-excel-file python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/JIRA_Upload_List_Transsion_开关机专项_20260325_115150.xlsx --dry-run`
Expected: 成功输出 JSON 结果，并新增 SQLite/Excel 摘要文件，不实际修改 Jira

- [ ] **Step 5: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py
git commit -m "feat(transsion-jira): integrate regression flow into batch entry"
```

### Task 6: Excel 摘要输出与结果字段补齐

**Files:**
- Create: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_report.py`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_report.py`

- [ ] **Step 1: 写 Excel 摘要生成测试**

```python
from pathlib import Path

from transsion_regression_report import write_excel_summary


def test_write_excel_summary_creates_file(tmp_path: Path):
    output_file = tmp_path / "summary.xlsx"
    write_excel_summary(
        output_file,
        [{
            "row_number": 1,
            "matched_jira_key": "KO5OS16AEE-1",
            "action": "OPEN_LIKE_UPDATE",
            "success": True,
            "manual_review": False,
            "reason": "",
            "old_count": 3,
            "new_count": 5,
        }],
    )
    assert output_file.exists()
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_report.py -q`
Expected: FAIL with missing report module

- [ ] **Step 3: 实现 Excel 摘要输出**

```python
import pandas as pd


SUMMARY_COLUMNS = [
    "row_number",
    "matched_jira_key",
    "matched_status",
    "matched_resolution",
    "fix_version",
    "action",
    "success",
    "manual_review",
    "reason",
    "old_count",
    "new_count",
    "comment_status",
    "ps_comment_status",
    "result_message",
]


def write_excel_summary(output_file, rows):
    df = pd.DataFrame(rows)
    for column in SUMMARY_COLUMNS:
        if column not in df.columns:
            df[column] = ""
    df[SUMMARY_COLUMNS].to_excel(output_file, index=False)
```

- [ ] **Step 4: 运行测试确认通过**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_report.py -q`
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_report.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_report.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py
git commit -m "feat(transsion-jira): add regression excel summary output"
```

### Task 7: 回归 PASS 与文档收尾

**Files:**
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_executor.py`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_store.py`
- Modify: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt`
- Test: `python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_pass.py`

- [ ] **Step 1: 写 PASS 阈值兼容测试**

```python
from transsion_regression_executor import evaluate_regression_pass


def test_regression_pass_closes_when_threshold_is_one():
    result = evaluate_regression_pass(
        pass_count=0,
        required_versions=1,
        current_version="V10",
        fix_version="V9",
        already_verified=[],
    )
    assert result.action == "REGRESSION_PASS_CLOSE"


def test_regression_pass_stays_in_progress_when_threshold_is_three():
    result = evaluate_regression_pass(
        pass_count=1,
        required_versions=3,
        current_version="V10",
        fix_version="V9",
        already_verified=["V9"],
    )
    assert result.action == "REGRESSION_PASS_PROGRESS"
```

- [ ] **Step 2: 运行测试确认失败**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_pass.py -q`
Expected: FAIL with missing pass evaluator

- [ ] **Step 3: 实现 PASS 判定与版本去重**

```python
def evaluate_regression_pass(pass_count, required_versions, current_version, fix_version, already_verified):
    if not fix_version:
        return ActionDecision("REGRESSION_PASS_SKIP", False, False, False)
    if current_version in already_verified:
        return ActionDecision("REGRESSION_PASS_SKIP", False, False, False)
    new_count = pass_count + 1
    if new_count >= required_versions:
        return ActionDecision("REGRESSION_PASS_CLOSE", True, False, True)
    return ActionDecision("REGRESSION_PASS_PROGRESS", False, False, True)
```

- [ ] **Step 4: 运行回归 PASS 测试与 README 检查**

Run: `python -m pytest python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_pass.py -q`
Expected: PASS

Run: `rg -n "回归|JQL|SQLite|Excel 摘要" python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt`
Expected: README 已包含新增能力说明

- [ ] **Step 5: Commit**

```bash
git add python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_executor.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/transsion_regression_store.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_pass.py python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt
git commit -m "feat(transsion-jira): add regression pass close flow"
```
