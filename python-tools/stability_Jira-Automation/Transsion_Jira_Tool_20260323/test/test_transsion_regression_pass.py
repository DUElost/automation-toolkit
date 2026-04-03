from __future__ import annotations

import importlib
import json
import sys
from pathlib import Path
from types import SimpleNamespace
from typing import Generator

import pandas as pd
import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def executor_module() -> Generator[object, None, None]:
    module_name = "transsion_regression_executor"
    original_path = list(sys.path)
    original_module = sys.modules.get(module_name)
    sys.modules.pop(module_name, None)
    try:
        if str(MODULE_DIR) not in sys.path:
            sys.path.insert(0, str(MODULE_DIR))
        yield importlib.import_module(module_name)
    finally:
        if original_module is None:
            sys.modules.pop(module_name, None)
        else:
            sys.modules[module_name] = original_module
        sys.path[:] = original_path


@pytest.fixture
def batch_entry_module() -> Generator[object, None, None]:
    module_name = "create_transsion_jira_batch_from_excel"
    original_path = list(sys.path)
    original_module = sys.modules.get(module_name)
    sys.modules.pop(module_name, None)
    try:
        if str(MODULE_DIR) not in sys.path:
            sys.path.insert(0, str(MODULE_DIR))
        yield importlib.import_module(module_name)
    finally:
        if original_module is None:
            sys.modules.pop(module_name, None)
        else:
            sys.modules[module_name] = original_module
        sys.path[:] = original_path


def test_regression_pass_closes_when_threshold_is_one(executor_module):
    module = executor_module

    result = module.evaluate_regression_pass(
        pass_count=0,
        required_versions=1,
        current_version="V10",
        fix_version="V9",
        already_verified=[],
    )

    assert result.action == "REGRESSION_PASS_CLOSE"
    assert result.record_pass is True
    assert result.close_issue is True
    assert result.new_pass_count == 1


def test_regression_pass_stays_in_progress_when_threshold_is_three(executor_module):
    module = executor_module

    result = module.evaluate_regression_pass(
        pass_count=1,
        required_versions=3,
        current_version="V10",
        fix_version="V9",
        already_verified=["V9"],
    )

    assert result.action == "REGRESSION_PASS_PROGRESS"
    assert result.record_pass is True
    assert result.close_issue is False
    assert result.new_pass_count == 2


def test_regression_pass_skips_when_current_version_already_verified(executor_module):
    module = executor_module

    result = module.evaluate_regression_pass(
        pass_count=1,
        required_versions=2,
        current_version="V10",
        fix_version="V9",
        already_verified=["V10"],
    )

    assert result.action == "REGRESSION_PASS_SKIP"
    assert result.record_pass is False
    assert result.close_issue is False
    assert result.new_pass_count == 1


def test_run_batch_create_dry_run_appends_regression_pass_result(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}
    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="user",
        jira_password="pass",
        jira_server="http://jira.example.com",
        config_file="fake-defaults.json",
        severity_rules_file="fake-rules.xls",
        bug_severity_image_dir=str(tmp_path / "images"),
        wait_between_issues=0,
        dry_run=True,
        validate_metadata=False,
        add_comments=False,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "未命中当前历史单",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V10",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectB",
                "Case No": "CASE-9",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "",
                "caused_by": "java.lang.IllegalStateException: no-match",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return [SimpleNamespace(key="TRANSSION-88")]

    class FakeStore:
        def __init__(self, _db_path):
            pass

        def save_sync_run(self, _record):
            return None

        def save_snapshot(self, _run_id, _rows):
            return None

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

        def fetch_issue_state(self, jira_key):
            assert jira_key == "TRANSSION-88"
            return None

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(
        module,
        "load_defaults",
        lambda _: {
            "jira_server": "http://jira.example.com",
            "default_wait_between_issues_seconds": 0,
            "project_key": "TRANSSION",
            "issue_type": "故障",
        },
    )
    monkeypatch.setattr(
        module,
        "load_priority_mapping_from_rules_excel",
        lambda _: {"severity_to_priority": {}, "priority_aliases": {}},
    )
    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(
        module,
        "get_meta_bundle",
        lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}},
    )
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="project = X6852OS16 AND reporter in (dailv.tinno)",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决"],
                resolved_fixed_resolutions=["已修复"],
                closed_statuses=["已关闭", "已关单", "Closed"],
            ),
            regression=SimpleNamespace(required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-88",
            "summary": "已解决待PASS问题",
            "status": "已解决",
            "resolution": "已修复",
            "fix_version": "V9",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom",
            "raw_payload": json.dumps({"fields": {"created": "2026-03-20T10:00:00.000+0800"}}),
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: False)

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert any(
        item["action"] == "REGRESSION_PASS_PROGRESS"
        for item in store_events["execution_results"]
    ), "dry-run 应追加一条 PASS 结果"


def test_run_batch_create_dry_run_appends_regression_pass_result_for_verified_status(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}
    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="user",
        jira_password="pass",
        jira_server="http://jira.example.com",
        config_file="fake-defaults.json",
        severity_rules_file="fake-rules.xls",
        bug_severity_image_dir=str(tmp_path / "images"),
        wait_between_issues=0,
        dry_run=True,
        validate_metadata=False,
        add_comments=False,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "【天珑团队】【BUG】【TRANSSION】【稳定性专项】【休眠唤醒专项】执行休眠唤醒专项过程中，未命中当前历史单",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V10",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectB",
                "Case No": "CASE-9",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "",
                "caused_by": "java.lang.IllegalStateException: no-match",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return [SimpleNamespace(key="TRANSSION-88")]

    class FakeStore:
        def __init__(self, _db_path):
            pass

        def save_sync_run(self, _record):
            return None

        def save_snapshot(self, _run_id, _rows):
            return None

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

        def fetch_issue_state(self, jira_key):
            assert jira_key == "TRANSSION-88"
            return None

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(
        module,
        "load_defaults",
        lambda _: {
            "jira_server": "http://jira.example.com",
            "default_wait_between_issues_seconds": 0,
            "project_key": "TRANSSION",
            "issue_type": "故障",
        },
    )
    monkeypatch.setattr(
        module,
        "load_priority_mapping_from_rules_excel",
        lambda _: {"severity_to_priority": {}, "priority_aliases": {}},
    )
    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="reporter in (dailv.tinno)",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决", "Verified"],
                resolved_fixed_resolutions=["已修复"],
                closed_statuses=["已关闭", "已关单", "Closed"],
            ),
            regression=SimpleNamespace(required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-88",
            "summary": "【天珑团队】【BUG】【TRANSSION】【稳定性专项】【休眠唤醒专项】执行休眠唤醒专项过程中，已解决待PASS问题",
            "status": "Verified",
            "resolution": "已修复",
            "fix_version": "V9",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom",
            "raw_payload": json.dumps({"fields": {"created": "2026-03-20T10:00:00.000+0800"}}),
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: False)

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert any(
        item["action"] == "REGRESSION_PASS_PROGRESS"
        for item in store_events["execution_results"]
    ), "Verified + 已修复 应追加一条 PASS 结果"


def test_run_batch_create_dry_run_skips_regression_pass_for_unrelated_specialty(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}
    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="user",
        jira_password="pass",
        jira_server="http://jira.example.com",
        config_file="fake-defaults.json",
        severity_rules_file="fake-rules.xls",
        bug_severity_image_dir=str(tmp_path / "images"),
        wait_between_issues=0,
        dry_run=True,
        validate_metadata=False,
        add_comments=False,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "【天珑团队】【BUG】【TRANSSION】【稳定性专项】【休眠唤醒专项】执行休眠唤醒专项过程中，未命中当前历史单",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V10",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectB",
                "Case No": "CASE-9",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "",
                "caused_by": "java.lang.IllegalStateException: no-match",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return [SimpleNamespace(key="TRANSSION-88")]

    class FakeStore:
        def __init__(self, _db_path):
            pass

        def save_sync_run(self, _record):
            return None

        def save_snapshot(self, _run_id, _rows):
            return None

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

        def fetch_issue_state(self, jira_key):
            assert jira_key == "TRANSSION-88"
            return None

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(
        module,
        "load_defaults",
        lambda _: {
            "jira_server": "http://jira.example.com",
            "default_wait_between_issues_seconds": 0,
            "project_key": "TRANSSION",
            "issue_type": "故障",
        },
    )
    monkeypatch.setattr(
        module,
        "load_priority_mapping_from_rules_excel",
        lambda _: {"severity_to_priority": {}, "priority_aliases": {}},
    )
    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="reporter in (dailv.tinno)",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决", "Verified"],
                resolved_fixed_resolutions=["已修复"],
                closed_statuses=["已关闭", "已关单", "Closed"],
            ),
            regression=SimpleNamespace(required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-88",
            "summary": "【天珑团队】【BUG】【TRANSSION】【稳定性专项】【MTFB专项】执行MTFB专项过程中，已解决待PASS问题",
            "status": "Verified",
            "resolution": "已修复",
            "fix_version": "V9",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom",
            "raw_payload": json.dumps({"fields": {"created": "2026-03-20T10:00:00.000+0800"}}),
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: False)

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert not any(
        item["action"] == "REGRESSION_PASS_PROGRESS"
        for item in store_events["execution_results"]
    ), "不在本轮专项集合里的历史单不应推进 PASS"
