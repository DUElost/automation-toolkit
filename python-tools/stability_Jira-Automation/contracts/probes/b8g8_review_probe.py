#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""B8 G8 独立复核探针（Transsion / Tinno 共用同一套场景）。

只用纯模拟工作簿、模拟 manifest 与模拟 Jira，不连接真实 Jira、不读取真实凭据。
探针覆盖：

- 清空 Occurrence IDs 不回落 manifest；小数标识不截断；
- 合法多发生合并、新建、匹配与失败；
- AutoFilter 隐藏行、显式删行、重排、重复发生；
- 相对/绝对 --output-dir、自动工作区、双工作区隔离、旧默认行为；
- 清单、摘要 XLSX、审计 JSON、批量结果、attribution.json 落点。

用法：
    python b8g8_review_probe.py --repo-root <repo> --tool transsion --workspace <dir> --report <json>
"""

from __future__ import annotations

import argparse
import importlib
import json
import os
import sys
from contextlib import contextmanager
from pathlib import Path
from types import SimpleNamespace
from typing import Any, Dict, Iterable, List, Optional, Tuple
from unittest import mock

import pandas as pd
from openpyxl import load_workbook
from jira.exceptions import JIRAError

TOOL_DIRS = {
    "transsion": "Transsion_Jira_Tool_20260323",
    "tinno": "Tinno_Jira_Tool_20260520",
}
BATCH_MODULES = {
    "transsion": "create_transsion_jira_batch_from_excel",
    "tinno": "create_tinno_jira_batch_from_excel",
}
GEN_MODULES = {
    "transsion": "generate_transsion_jira_upload_list",
    "tinno": "generate_tinno_jira_upload_list",
}


@contextmanager
def chdir(path: Path):
    previous = Path.cwd()
    os.chdir(path)
    try:
        yield
    finally:
        os.chdir(previous)


class FakeIssue:
    def __init__(self, key: str) -> None:
        self.key = key

    def get(self, name: str, default: Any = None) -> Any:
        return self.key if name == "key" else default


class FakeJira:
    auth_mode = "cookie"

    def __init__(self) -> None:
        self.counter = 0
        self.created: List[Tuple[str, str]] = []
        self.closed = False

    def current_user(self) -> str:
        return "probe-user"

    def project(self, key: str):
        return SimpleNamespace(key=key)

    def create_issue(self, fields):
        summary = str((fields or {}).get("summary") or "")
        if "FAIL" in summary:
            raise JIRAError(status_code=500, text="simulated create failure")
        self.counter += 1
        key = f"SIM-{self.counter}"
        self.created.append((summary, key))
        return FakeIssue(key)

    def issue(self, key: str):
        return SimpleNamespace(
            fields=SimpleNamespace(status=SimpleNamespace(name="Open")),
            update=lambda **kwargs: None,
            raw={"fields": {}},
        )

    def transitions(self, issue):
        return []

    def transition_issue(self, *args, **kwargs):
        return None

    def add_comment(self, *args, **kwargs):
        return None

    def add_attachment(self, *args, **kwargs):
        return None

    def close(self):
        self.closed = True


def _manifest() -> Dict[str, Any]:
    return {
        "schema": "stp.jira_delivery_input/v1",
        "plan_run_id": 1096,
        "root_plan_run_id": 1085,
        "platform": "mtk",
        "delivery_version_id": 4,
        "delivery_version_no": 2,
        "issue_ids": [7, 8, 9],
        "event_ids": ["dle-1", "dle-2"],
        "issues": [
            {"signature_id": 7, "occurrence_ids": [101, 102, 103]},
            {"signature_id": 8, "occurrence_ids": [201]},
            {"signature_id": 9, "occurrence_ids": [301]},
        ],
        "attribution_candidates": [
            {"signature_id": 7, "occurrence_id": 101, "occurrence_key": "k101", "dle_id": "dle-1", "serial": "S1"},
            {"signature_id": 7, "occurrence_id": 102, "occurrence_key": "k102", "dle_id": "dle-1", "serial": "S1"},
            {"signature_id": 7, "occurrence_id": 103, "occurrence_key": "k103", "dle_id": "dle-2", "serial": "S2"},
            {"signature_id": 8, "occurrence_id": 201, "occurrence_key": "k201", "dle_id": "dle-2", "serial": "S2"},
            {"signature_id": 9, "occurrence_id": 301, "occurrence_key": "k301", "dle_id": "dle-2", "serial": "S2"},
        ],
    }


def _row(tool: str, signature: Any, occurrences: Any, summary: str, count: int = 1) -> Dict[str, Any]:
    if tool == "transsion":
        base = {
            "Project": "X6851OS16",
            "Issue Type": "故障",
            "Summary": summary,
            "Description": summary,
            "Priority": "重要",
            "Components": "Framework_other",
            "Versions": "X6851-16.3.0.021",
            "Assignee": "自动",
            "Reporter": "probe-user",
            "Environment": "PR1-A1",
            "Risk": "once",
            "Test Total Count": 1000,
            "Issue Source": "内测 (自动化测试)",
            "Issue Category": "Stability",
            "Issue Nature": "New issues",
            "Affect Project": "X6851-P865",
            "Case No": "NA",
            "PS": "",
            "Exp Class": "ANR",
            "CausedBy": "",
            "Package": "com.android.phone",
            "Count": count,
            "Device Count": 1,
        }
    else:
        base = {
            "Project": "VFFCA",
            "Issue Type": "Bug",
            "Summary": summary,
            "Description": summary,
            "Priority": "B",
            "Bug Severity": "B",
            "Test Case": "Monkey专项",
            "key_information": "",
            "Module": "System Stability",
            "Components": "System Stability",
            "Assignee": "probe-user",
            "Reporter": "probe-user",
            "Versions": "MLD-LX2-16-260928V9",
            "Environment": "*异常包名:* com.android.phone",
            "PS": "",
            "Previous Version Status": "Previous version exists",
            "Previous Version Text": "100%",
        }
    base.update(
        {
            "Signature ID": "" if signature is None else signature,
            "Occurrence IDs": "" if occurrences is None else (
                occurrences if isinstance(occurrences, str) else json.dumps(occurrences)
            ),
            "Occurrence Keys": "[]",
            "Occurrence Count": len(occurrences) if isinstance(occurrences, list) else 0,
            "Attribution Status": "OK",
            "Attribution Note": "",
            "Source Excel Row": 2,
        }
    )
    return base


def _write_workbook(path: Path, rows: List[Dict[str, Any]], hidden: Iterable[str] = ()) -> Path:
    path.parent.mkdir(parents=True, exist_ok=True)
    pd.DataFrame(rows).to_excel(path, index=False)
    hidden_summaries = set(hidden)
    if hidden_summaries:
        workbook = load_workbook(path)
        sheet = workbook.active
        sheet.auto_filter.ref = sheet.dimensions
        for excel_row, row in enumerate(rows, start=2):
            if row.get("Summary") in hidden_summaries:
                sheet.row_dimensions[excel_row].hidden = True
        workbook.save(path)
    return path


def _load_module(repo_root: Path, tool: str, kind: str):
    tool_dir = repo_root / "python-tools" / "stability_Jira-Automation" / TOOL_DIRS[tool]
    module_name = BATCH_MODULES[tool] if kind == "batch" else GEN_MODULES[tool]
    if str(tool_dir) not in sys.path:
        sys.path.insert(0, str(tool_dir))
    sys.modules.pop(module_name, None)
    return importlib.import_module(module_name), tool_dir


def _batch_args(tool: str, tool_dir: Path, workspace: Path, workbook: Path, output_dir: Optional[str]) -> SimpleNamespace:
    common = {
        "excel_file": str(workbook),
        "regression_project": None,
        "regression_specialties": [],
        "current_version": None,
        "history_reporter": None,
        "jira_server": "http://simulated.invalid",
        "config_file": str(tool_dir / "config" / ("transsion_jira_defaults.json" if tool == "transsion" else "tinno_jira_defaults.json")),
        "severity_rules_file": str(tool_dir / "config" / "问题等级定级表.xls"),
        "dry_run": False,
        "validate_metadata": False,
        "add_comments": False,
        "wait_between_issues": 0,
        "output_dir": output_dir,
        "attribution_manifest": str(workspace / "manifest.json"),
    }
    if tool == "transsion":
        common.update(
            {
                "jira_username": "probe-user",
                "jira_password": "probe-pass",
                "bug_severity_image_dir": str(workspace / "no-images"),
                "disable_regression": False,
            }
        )
    else:
        common.update(
            {
                "test_mode": False,
                "create_only": False,
                "disable_regression": False,
                "ignore_version_prefix_for_regression": False,
                "jira_username": "probe-user",
                "jira_password": "probe-pass",
                "jira_p12_path": str(workspace / "probe.p12"),
                "jira_p12_password": "probe",
                "jira_cookie_string": None,
                "jira_cookie_jsessionid": None,
                "jira_cookie_xsrf_token": None,
            }
        )
    return SimpleNamespace(**common)


def _defaults(tool: str) -> Dict[str, Any]:
    if tool == "transsion":
        return {
            "project_key": "X6851OS16",
            "issue_type": "故障",
            "jira_server": "http://simulated.invalid",
            "default_assignee": "probe-user",
            "default_reporter": "probe-user",
            "default_clients": [],
            "default_issue_source": "内测 (自动化测试)",
            "default_issue_category": "Stability",
            "default_issue_nature": "New issues",
            "default_fix_way": "修改代码",
            "default_focus": "None",
            "default_importance": "中",
            "default_security_level": "ODM项目",
            "field_ids": {},
        }
    return {
        "project_key": "VFFCA",
        "issue_type": "Bug",
        "jira_server": "http://simulated.invalid",
        "default_reporter": "probe-user",
        "default_assignee": "probe-user",
        "default_priority": "Medium",
        "default_bug_severity": "B",
        "default_affect_project": "VFFCA",
        "default_component": "AUTOTEST",
        "default_test_case": "Monkey专项",
    }


def _patch_batch(tool: str, module: Any, fake: FakeJira):
    patches = {
        "connect_to_jira": lambda *args, **kwargs: fake,
        "resolve_project_key": lambda jira, raw, cache=None: str(raw),
        "build_issue_fields": lambda **kwargs: {"summary": str(kwargs["row"].get("Summary") or "")},
        "export_jira_snapshot": lambda *args, **kwargs: [],
        "find_regression_match": lambda regression_row, snapshot, matching: (
            {"jira_key": "SIM-MATCHED-900", "status": "Open"}
            if "MATCH" in str(regression_row.get("summary") or "")
            else None
        ),
        "update_issue_fields": lambda *args, **kwargs: None,
        "add_history_issue_comments": lambda *args, **kwargs: {
            "comment_status": "",
            "ps_comment_status": "",
            "comment_count": 0,
        },
        "process_regression_pass_candidates": lambda *args, **kwargs: None,
        "process_closed_main_duplicate_followups": lambda *args, **kwargs: None,
        "load_defaults": lambda _: _defaults(tool),
    }
    if tool == "transsion":
        patches.update(
            {
                "get_meta_bundle": lambda *args, **kwargs: {
                    "create_fields": {},
                    "field_name_lookup": {},
                    "allowed_values": {},
                },
                "resolve_user_name": lambda jira, raw, cache=None, fallback=None: str(raw or fallback or "probe-user"),
                "resolve_bug_severity_attachment_name": lambda *args, **kwargs: None,
                "load_priority_mapping_from_rules_excel": lambda _: {
                    "severity_to_priority": {},
                    "priority_aliases": {},
                },
            }
        )
    else:
        patches.update(
            {
                "get_create_meta_fields": lambda *args, **kwargs: {},
                "bind_local_build_versions": lambda snapshot, *args, **kwargs: snapshot,
                "backfill_issue_state_from_project_history": lambda *args, **kwargs: 0,
                "_upsert_snapshot_issue_states": lambda *args, **kwargs: None,
                "merge_history_sources": lambda row, *args, **kwargs: row,
                "get_project_history_issue": lambda *args, **kwargs: None,
                "sync_issue_to_project_history_db": lambda **kwargs: None,
            }
        )
    return mock.patch.multiple(module, **patches)


def _read_json(path: Path) -> Any:
    return json.loads(path.read_text(encoding="utf-8"))


def _result_files(workspace: Path) -> List[Path]:
    return sorted((workspace / "result").glob("*_jira_batch_create_result_*.json"))


def _links(workspace: Path) -> List[Dict[str, Any]]:
    path = workspace / "attribution.json"
    return _read_json(path).get("links", []) if path.is_file() else []


def _gaps(workspace: Path) -> List[Dict[str, Any]]:
    path = workspace / "attribution.json"
    return _read_json(path).get("gaps", []) if path.is_file() else []


def _run_batch(
    tool: str,
    module: Any,
    args: SimpleNamespace,
    fake: FakeJira,
    cwd: Optional[Path] = None,
) -> int:
    context = _patch_batch(tool, module, fake)
    with context:
        if cwd is not None:
            with chdir(cwd):
                return int(module.run_excel_mode(args))
        return int(module.run_excel_mode(args))


def _check(condition: bool, detail: str, failures: List[str]) -> None:
    if not condition:
        failures.append(detail)


def _scenario_create_match_failure(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "create-match-failure"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [
        _row(tool, 7, [101, 102], "CREATE-multi", 2),
        _row(tool, 8, [201], "MATCH-open"),
        _row(tool, 9, [301], "FAIL-create"),
    ]
    workbook = _write_workbook(workspace / "input.xlsx", rows)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    created = [summary for summary, _ in fake.created]
    links = {(int(link["occurrence_id"]), link["issue_key"]) for link in _links(workspace)}
    _check("CREATE-multi" in created, "multi occurrence create missing", failures)
    _check("FAIL-create" not in created, "failure row unexpectedly created", failures)
    _check(
        links == {(101, "SIM-1"), (102, "SIM-1"), (201, "SIM-MATCHED-900")},
        f"unexpected links: {sorted(links)}",
        failures,
    )
    result_files = _result_files(workspace)
    _check(bool(result_files), "batch result json missing", failures)
    results = _read_json(result_files[-1]) if result_files else []
    _check(
        all(
            ("signature_id" in row and "occurrence_ids" in row)
            for row in results
            if row.get("issue_key") or row.get("matched_jira_key")
        ),
        "result rows with keys lack attribution ids",
        failures,
    )
    _check(bool(list((workspace / "result").glob("*_summary_*.xlsx"))), "summary xlsx missing", failures)
    if tool == "tinno":
        _check(bool(list((workspace / "result").glob("*_audit_*.json"))), "audit json missing", failures)
    return {
        "scenario": "create_match_failure",
        "passed": not failures,
        "failures": failures,
        "created": created,
        "links": sorted([list(item) for item in links]),
        "rc": rc,
    }


def _scenario_empty_occurrence_ids(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "empty-occurrence"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [_row(tool, 7, None, "EMPTY-occurrence")]
    workbook = _write_workbook(workspace / "input.xlsx", rows)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    gaps = _gaps(workspace)
    links = _links(workspace)
    artifacts = _read_json(workspace / "attribution.json") if (workspace / "attribution.json").is_file() else {}
    items = artifacts.get("items") or []
    _check(links == [], f"empty occurrence produced links: {links}", failures)
    _check(
        any(gap.get("kind") == "empty_occurrence_ids" for gap in gaps),
        f"empty occurrence gap missing: {gaps}",
        failures,
    )
    _check(
        any(item.get("attribution_status") == "EMPTY_OCCURRENCE_IDS" for item in items),
        "empty occurrence status missing",
        failures,
    )
    return {
        "scenario": "empty_occurrence_ids",
        "passed": not failures,
        "failures": failures,
        "links": links,
        "gaps": gaps,
        "rc": rc,
    }


def _scenario_fractional_ids(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "fractional-ids"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [
        _row(tool, "7.5", [101], "FRAC-signature"),
        _row(tool, 7, "[101.5]", "FRAC-occurrence"),
    ]
    workbook = _write_workbook(workspace / "input.xlsx", rows)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    gaps = _gaps(workspace)
    kinds = [gap.get("kind") for gap in gaps]
    _check(_links(workspace) == [], "fractional ids produced links", failures)
    _check("invalid_signature_id" in kinds, f"invalid signature gap missing: {kinds}", failures)
    _check("invalid_occurrence_id" in kinds, f"invalid occurrence gap missing: {kinds}", failures)
    return {
        "scenario": "fractional_ids",
        "passed": not failures,
        "failures": failures,
        "links": _links(workspace),
        "gaps": gaps,
        "created": [summary for summary, _ in fake.created],
        "rc": rc,
    }


def _scenario_autofilter_hidden(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "autofilter-hidden"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [
        _row(tool, 7, [101, 102], "VISIBLE-row", 2),
        _row(tool, 8, [201], "HIDDEN-row"),
    ]
    workbook = _write_workbook(workspace / "input.xlsx", rows, hidden={"HIDDEN-row"})
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    created = [summary for summary, _ in fake.created]
    links = _links(workspace)
    results = _read_json(_result_files(workspace)[-1]) if _result_files(workspace) else []
    artifacts = _read_json(workspace / "attribution.json") if (workspace / "attribution.json").is_file() else {}
    _check(created == ["VISIBLE-row"], f"hidden row created: {created}", failures)
    _check(
        {(int(link["occurrence_id"]), link["issue_key"]) for link in links}
        == {(101, "SIM-1"), (102, "SIM-1")},
        f"hidden row links leaked: {links}",
        failures,
    )
    _check(
        any(item.get("filtered") and item.get("status") == "SKIPPED" for item in artifacts.get("items") or []),
        "hidden row not marked filtered/skipped in attribution",
        failures,
    )
    _check(
        any(row.get("error") == "autofilter_hidden" for row in results),
        "hidden row not recorded as autofilter_hidden in result",
        failures,
    )
    return {
        "scenario": "autofilter_hidden",
        "passed": not failures,
        "failures": failures,
        "created": created,
        "links": links,
        "rc": rc,
    }


def _scenario_explicit_delete(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "explicit-delete"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [_row(tool, 7, [101], "KEEP-row")]
    workbook = _write_workbook(workspace / "input.xlsx", rows)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    _check([summary for summary, _ in fake.created] == ["KEEP-row"], "deleted row still created", failures)
    _check({link["occurrence_id"] for link in _links(workspace)} == {101}, "deleted row link leaked", failures)
    return {"scenario": "explicit_delete", "passed": not failures, "failures": failures, "rc": rc}


def _scenario_reorder(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "reorder"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [
        _row(tool, 8, [201], "ORDER-B"),
        _row(tool, 7, [101, 102], "ORDER-A", 2),
    ]
    workbook = _write_workbook(workspace / "input.xlsx", rows)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    key_by_summary = {summary: key for summary, key in fake.created}
    links = {(int(link["occurrence_id"]), link["issue_key"]) for link in _links(workspace)}
    _check(
        links == {(201, key_by_summary.get("ORDER-B", "")), (101, key_by_summary.get("ORDER-A", "")), (102, key_by_summary.get("ORDER-A", ""))},
        f"reorder links wrong: {links}",
        failures,
    )
    return {"scenario": "reorder", "passed": not failures, "failures": failures, "links": sorted([list(item) for item in links]), "rc": rc}


def _scenario_duplicate_occurrence(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "duplicate-occurrence"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    rows = [_row(tool, 7, [101], "DUP-a"), _row(tool, 7, [101], "DUP-b")]
    workbook = _write_workbook(workspace / "input.xlsx", rows)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    _check(fake.created == [], f"duplicate occurrence created: {fake.created}", failures)
    _check(_links(workspace) == [], "duplicate occurrence produced links", failures)
    _check(
        all(gap.get("kind") == "duplicate_occurrence_id" for gap in _gaps(workspace)),
        f"duplicate gaps wrong: {_gaps(workspace)}",
        failures,
    )
    return {"scenario": "duplicate_occurrence", "passed": not failures, "failures": failures, "rc": rc}



def _seed_simple(workspace: Path, tool: str, summary: str = "SIMPLE-row") -> Path:
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    return _write_workbook(workspace / "input.xlsx", [_row(tool, 7, [101], summary)])


def _assert_batch_outputs(workspace: Path, tool: str, failures: List[str]) -> None:
    _check(bool(_result_files(workspace)), f"result json missing under {workspace}", failures)
    _check((workspace / "attribution.json").is_file(), f"attribution.json missing under {workspace}", failures)
    _check(
        bool(list((workspace / "result").glob("*_summary_*.xlsx"))),
        f"summary xlsx missing under {workspace / 'result'}",
        failures,
    )
    if tool == "tinno":
        _check(
            bool(list((workspace / "result").glob("*_audit_*.json"))),
            f"audit json missing under {workspace / 'result'}",
            failures,
        )


def _scenario_output_relative(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    parent = root / "output-relative-parent"
    workspace = parent / "rel_ws"
    workbook = _seed_simple(workspace, tool)
    fake = FakeJira()
    args = _batch_args(tool, tool_dir, workspace, workbook, "rel_ws")
    rc = _run_batch(tool, module, args, fake, cwd=parent)
    failures: List[str] = []
    _assert_batch_outputs(parent / "rel_ws", tool, failures)
    return {"scenario": "output_relative", "passed": not failures, "failures": failures, "workspace": str(parent / "rel_ws"), "rc": rc}


def _scenario_output_absolute(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "output-absolute"
    workbook = _seed_simple(workspace, tool)
    fake = FakeJira()
    rc = _run_batch(tool, module, _batch_args(tool, tool_dir, workspace, workbook, str(workspace)), fake)
    failures: List[str] = []
    _assert_batch_outputs(workspace, tool, failures)
    return {"scenario": "output_absolute", "passed": not failures, "failures": failures, "workspace": str(workspace), "rc": rc}


def _scenario_output_auto(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "output-auto"
    workbook = _seed_simple(workspace, tool)
    fake = FakeJira()
    args = _batch_args(tool, tool_dir, workspace, workbook, None)
    args.attribution_manifest = None
    rc = _run_batch(tool, module, args, fake, cwd=workspace)
    failures: List[str] = []
    _assert_batch_outputs(workspace, tool, failures)
    return {"scenario": "output_auto", "passed": not failures, "failures": failures, "workspace": str(workspace), "rc": rc}


def _scenario_two_workspaces(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    ws1 = root / "two-workspaces-a"
    ws2 = root / "two-workspaces-b"
    wb1 = _seed_simple(ws1, tool, "WS-A")
    wb2 = _seed_simple(ws2, tool, "WS-B")
    fake1, fake2 = FakeJira(), FakeJira()
    rc1 = _run_batch(tool, module, _batch_args(tool, tool_dir, ws1, wb1, str(ws1)), fake1)
    rc2 = _run_batch(tool, module, _batch_args(tool, tool_dir, ws2, wb2, str(ws2)), fake2)
    failures: List[str] = []
    _assert_batch_outputs(ws1, tool, failures)
    _assert_batch_outputs(ws2, tool, failures)
    _check(bool(list((ws1 / "result").rglob("*.db"))), "workspace A regression db missing", failures)
    _check(bool(list((ws2 / "result").rglob("*.db"))), "workspace B regression db missing", failures)
    _check([item["issue_key"] for item in _links(ws1)] == ["SIM-1"], f"ws1 links wrong: {_links(ws1)}", failures)
    _check([item["issue_key"] for item in _links(ws2)] == ["SIM-1"], f"ws2 links wrong: {_links(ws2)}", failures)
    _check(
        not any("two-workspaces-b" in str(path) for path in ws1.rglob("*")),
        "workspace A contains workspace B artifact",
        failures,
    )
    _check(
        not any("two-workspaces-a" in str(path) for path in ws2.rglob("*")),
        "workspace B contains workspace A artifact",
        failures,
    )
    return {"scenario": "two_workspaces", "passed": not failures, "failures": failures, "rc": [rc1, rc2]}


def _scenario_legacy_default(tool: str, module: Any, tool_dir: Path, root: Path) -> Dict[str, Any]:
    workspace = root / "legacy-default"
    workspace.mkdir(parents=True, exist_ok=True)
    workbook = _write_workbook(workspace / "input.xlsx", [_row(tool, 7, [101], "LEGACY-row")])
    legacy_result = root / "legacy-result"
    legacy_result.mkdir(parents=True, exist_ok=True)
    fake = FakeJira()
    args = _batch_args(tool, tool_dir, workspace, workbook, None)
    args.attribution_manifest = None
    extra_patch = (
        {"build_project_scoped_sqlite_path": lambda *args, **kwargs: legacy_result / "reg.db"}
        if tool == "transsion"
        else {"build_project_history_db_path": lambda *args, **kwargs: legacy_result / "history.db"}
    )
    with mock.patch.object(module, "RESULT_DIR", legacy_result):
        with mock.patch.multiple(module, **extra_patch):
            rc = _run_batch(tool, module, args, fake, cwd=workspace)
    failures: List[str] = []
    _check(bool(list(legacy_result.glob("*_result_*.json"))), "legacy result json missing", failures)
    _check(not (workspace / "attribution.json").exists(), "legacy run wrote attribution.json", failures)
    _check(not (workspace / "result").exists(), "legacy run wrote workspace/result", failures)
    return {"scenario": "legacy_default", "passed": not failures, "failures": failures, "legacy_result": str(legacy_result), "rc": rc}


def _raw_row(tool: str) -> Dict[str, Any]:
    version = "X6851-16.3.0.021" if tool == "transsion" else "MLD-LX2-16-260928V9"
    return {
        "Id": 7,
        "Path": "evidence/1085/mtk/S1/event",
        "Version": version,
        "ExpTime": "2026-11-16 10:00:00",
        "ExpClass": "ANR",
        "ExpType ": "system_app_anr",
        "CurProcess": "com.android.phone",
        "Package": "com.android.phone",
        "Detail": "simulated ANR",
        "CausedBy": "",
        "Count": 3,
        "DeviceCount": 1,
        "Activity": "",
    }


def _prepare_generator_fixtures(tool: str, workspace: Path) -> Dict[str, Path]:
    fixtures = {}
    fixtures["pkg"] = workspace / "pkg_map.xlsx"
    pd.DataFrame(
        [{"应用包名": "com.android.phone", "模块": "Framework_other", "负责人": "probe-user"}]
    ).to_excel(fixtures["pkg"], index=False)
    fixtures["summary"] = workspace / "summary.xlsx"
    pd.DataFrame(
        [{"测试项": "Monkey专项", "编号": 0, "测试总次数": 1000, "测试步骤": "Monkey 1000 轮"}]
    ).to_excel(fixtures["summary"], index=False)
    fixtures["probability"] = workspace / "probability.xlsx"
    pd.DataFrame(
        [
            {"概率": "once", "是否加偶现标签": 1, "标题附加词语": "小概率"},
            {"概率": "occasional", "是否加偶现标签": 1, "标题附加词语": "概率性"},
            {"概率": "often", "是否加偶现标签": 1, "标题附加词语": "大概率"},
            {"概率": "must", "是否加偶现标签": 0, "标题附加词语": ""},
        ]
    ).to_excel(fixtures["probability"], index=False)
    fixtures["regex"] = workspace / "regex.txt"
    fixtures["regex"].write_text("", encoding="utf-8")
    return fixtures


def _scenario_generator_workspace(tool: str, repo_root: Path, root: Path) -> Dict[str, Any]:
    module, tool_dir = _load_module(repo_root, tool, "generate")
    workspace = root / "generator-workspace"
    workspace.mkdir(parents=True, exist_ok=True)
    (workspace / "manifest.json").write_text(json.dumps(_manifest(), ensure_ascii=False), encoding="utf-8")
    raw_workbook = workspace / "raw.xlsx"
    pd.DataFrame([_raw_row(tool)]).to_excel(raw_workbook, index=False, engine="openpyxl")
    fixtures = _prepare_generator_fixtures(tool, workspace)
    if tool == "transsion":
        args = SimpleNamespace(
            main_excel_path=str(raw_workbook),
            project_key="X6851OS16",
            test_case="Monkey专项",
            output_path=None,
            affect_project=None,
            environment="PR1-A1",
            case_no="NA",
            reporter="probe-user",
            assignee=None,
            assignee_auto=True,
            assignee_manual=False,
            summary_tags=["OP"],
            config_file=str(tool_dir / "config" / "transsion_jira_defaults.json"),
            affect_project_mapping_file=str(tool_dir / "config" / "affect_project_mapping.json"),
            package_mapping_file=str(fixtures["pkg"]),
            severity_rules_file=str(tool_dir / "config" / "问题等级定级表.xls"),
            probability_rules_file=str(fixtures["probability"]),
            test_summary_file=str(fixtures["summary"]),
            component_regex_file=str(fixtures["regex"]),
            output_dir=str(workspace),
            attribution_manifest=str(workspace / "manifest.json"),
        )
    else:
        args = SimpleNamespace(
            main_excel_path=str(raw_workbook),
            output_path=None,
            config_file=str(tool_dir / "config" / "tinno_jira_defaults.json"),
            package_mapping_file=str(fixtures["pkg"]),
            severity_rules_file=str(tool_dir / "config" / "问题等级定级表.xls"),
            affect_project_mapping_file=str(tool_dir / "config" / "affect_project_mapping.json"),
            summary_product_mapping_file=None,
            module_assignee_mapping_file=None,
            test_summary_file=str(fixtures["summary"]),
            project_key="VFFCA",
            test_case="Monkey专项",
            reporter="probe-user",
            assignee="probe-user",
            test_mode=False,
            output_dir=str(workspace),
            attribution_manifest=str(workspace / "manifest.json"),
        )
    failures: List[str] = []
    with mock.patch.object(module, "setup_logging"):
        with mock.patch.object(module, "parse_args", return_value=args):
            if tool == "tinno":
                with mock.patch.object(module, "load_local_env"):
                    rc = int(module.main())
            else:
                rc = int(module.main())
    workbooks = list(workspace.glob("JIRA_Upload_List_*.xlsx"))
    _check(len(workbooks) == 1, f"generator workbook count={len(workbooks)}", failures)
    _check((workspace / "attribution_input.json").is_file(), "attribution_input.json missing", failures)
    if workbooks:
        payload = pd.read_excel(workbooks[0])
        _check("Occurrence IDs" in payload.columns, "generator workbook lacks Occurrence IDs", failures)
        _check(
            any(json.loads(value) == [101, 102, 103] for value in payload["Occurrence IDs"].tolist()),
            "generator did not keep full occurrence set",
            failures,
        )
    return {
        "scenario": "generator_workspace",
        "passed": not failures,
        "failures": failures,
        "workbook": str(workbooks[0]) if workbooks else "",
        "rc": rc,
    }



SCENARIOS = [
    ("create_match_failure", _scenario_create_match_failure, "batch"),
    ("empty_occurrence_ids", _scenario_empty_occurrence_ids, "batch"),
    ("fractional_ids", _scenario_fractional_ids, "batch"),
    ("autofilter_hidden", _scenario_autofilter_hidden, "batch"),
    ("explicit_delete", _scenario_explicit_delete, "batch"),
    ("reorder", _scenario_reorder, "batch"),
    ("duplicate_occurrence", _scenario_duplicate_occurrence, "batch"),
    ("output_relative", _scenario_output_relative, "batch"),
    ("output_absolute", _scenario_output_absolute, "batch"),
    ("output_auto", _scenario_output_auto, "batch"),
    ("two_workspaces", _scenario_two_workspaces, "batch"),
    ("legacy_default", _scenario_legacy_default, "batch"),
    ("generator_workspace", _scenario_generator_workspace, "generate"),
]


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="B8 G8 独立复核探针")
    parser.add_argument("--repo-root", default=str(Path(__file__).resolve().parents[4]))
    parser.add_argument("--tool", choices=sorted(TOOL_DIRS), required=True)
    parser.add_argument("--workspace", required=True)
    parser.add_argument("--report", default=None)
    parsed = parser.parse_args(argv)

    repo_root = Path(parsed.repo_root).resolve()
    workspace_root = Path(parsed.workspace)
    workspace_root.mkdir(parents=True, exist_ok=True)

    batch_module, tool_dir = _load_module(repo_root, parsed.tool, "batch")
    results: List[Dict[str, Any]] = []
    for name, scenario, kind in SCENARIOS:
        try:
            if kind == "batch":
                detail = scenario(parsed.tool, batch_module, tool_dir, workspace_root)
            else:
                detail = scenario(parsed.tool, repo_root, workspace_root)
        except Exception as exc:  # noqa: BLE001 - 探针失败必须落盘
            detail = {
                "scenario": name,
                "passed": False,
                "failures": [f"exception: {type(exc).__name__}: {exc}"],
            }
        results.append(detail)

    report = {
        "probe": "b8g8_review_probe/v1",
        "tool": parsed.tool,
        "contract_version": "b8-g8-attribution-v1",
        "repo_root": str(repo_root),
        "workspace": str(workspace_root),
        "passed": all(item.get("passed") for item in results),
        "scenarios": results,
    }
    body = json.dumps(report, ensure_ascii=False, indent=2)
    if parsed.report:
        report_path = Path(parsed.report)
        report_path.parent.mkdir(parents=True, exist_ok=True)
        report_path.write_text(body + "\n", encoding="utf-8")
    print(body)
    return 0 if report["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())

