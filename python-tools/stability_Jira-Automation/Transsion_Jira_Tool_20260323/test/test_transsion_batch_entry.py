from __future__ import annotations

import importlib
import json
import logging
import sys
from pathlib import Path
from types import SimpleNamespace
from typing import Generator

import pandas as pd
import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


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


def _make_args(tmp_path: Path, **overrides):
    base = {
        "excel_file": "fake.xlsx",
        "regression_project": None,
        "regression_specialties": [],
        "current_version": None,
        "history_reporter": None,
        "jira_username": "user",
        "jira_password": "pass",
        "jira_server": "http://jira.example.com",
        "config_file": "fake-defaults.json",
        "severity_rules_file": "fake-rules.xls",
        "bug_severity_image_dir": str(tmp_path / "images"),
        "wait_between_issues": 0,
        "dry_run": False,
        "validate_metadata": False,
        "add_comments": True,
        "disable_regression": False,
    }
    base.update(overrides)
    return SimpleNamespace(**base)


def test_resolve_run_mode_returns_excel_for_excel_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file="upload.xlsx",
        regression_project=None,
        regression_specialties=[],
        current_version=None,
        history_reporter=None,
    )

    mode = module.resolve_run_mode(args)

    assert mode == "excel"


def test_resolve_run_mode_returns_regression_verify_for_regression_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
    )

    mode = module.resolve_run_mode(args)

    assert mode == "regression_verify"


def test_resolve_run_mode_rejects_mixed_excel_and_regression_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file="upload.xlsx",
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
    )

    with pytest.raises(ValueError, match="模式参数不能同时"):
        module.resolve_run_mode(args)


def test_resolve_run_mode_rejects_missing_required_regression_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=[],
        current_version=None,
        history_reporter=None,
    )

    with pytest.raises(ValueError, match="regression-specialty|current-version|history-reporter"):
        module.resolve_run_mode(args)


def test_build_project_scoped_sqlite_path_returns_project_db_under_regression_cache(batch_entry_module):
    module = batch_entry_module

    resolved = module.build_project_scoped_sqlite_path(
        project_key="X6851OS16",
        sqlite_path_setting="result/regression_cache",
    )

    assert resolved == module.CURRENT_DIR / "result" / "regression_cache" / "X6851OS16.db"


def test_build_regression_verify_jql_uses_monkey_aee_keyword_for_monkey_aee_specialty(batch_entry_module):
    module = batch_entry_module

    jql = module.build_regression_verify_jql(
        project_key="X6851OS16",
        reporter="dailv.tinno",
        specialty="MonkeyAEE",
    )

    assert jql == 'project = X6851OS16 AND reporter in (dailv.tinno) AND (summary ~ "\\\\[MonkeyAEE\\\\]")'


def test_build_regression_verify_jql_uses_plain_monkey_specialty_text(batch_entry_module):
    module = batch_entry_module

    jql = module.build_regression_verify_jql(
        project_key="X6851OS16",
        reporter="dailv.tinno",
        specialty="Monkey专项",
    )

    assert jql == 'project = X6851OS16 AND reporter in (dailv.tinno) AND (summary ~ "Monkey专项")'


def test_build_regression_verify_jql_uses_stability_keyword_for_non_monkey_specialty(batch_entry_module):
    module = batch_entry_module

    jql = module.build_regression_verify_jql(
        project_key="X6851OS16",
        reporter="dailv.tinno",
        specialty="休眠唤醒专项",
    )

    assert jql == 'project = X6851OS16 AND reporter in (dailv.tinno) AND (summary ~ "【稳定性专项】")'


def test_deduplicate_snapshot_rows_by_jira_key_keeps_latest_first(batch_entry_module):
    module = batch_entry_module

    rows = module.deduplicate_snapshot_rows_by_jira_key(
        [
            {"jira_key": "X6851OS16-607", "summary": "a"},
            {"jira_key": "X6851OS16-607", "summary": "b"},
            {"jira_key": "X6851OS16-608", "summary": "c"},
        ]
    )

    assert rows == [
        {"jira_key": "X6851OS16-607", "summary": "a"},
        {"jira_key": "X6851OS16-608", "summary": "c"},
    ]


def test_run_batch_create_uses_project_scoped_store_path_for_excel_mode(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    args = _make_args(tmp_path, dry_run=True, excel_file="fake.xlsx")
    df = pd.DataFrame([_make_row(Project="X6851OS16")])
    captured_paths = []

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return []

    monkeypatch.setattr(
        module,
        "load_defaults",
        lambda _: {"jira_server": "http://jira.example.com", "project_key": "X6851OS16", "issue_type": "故障"},
    )
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="reporter in (dailv.tinno)", max_results=50, fields=["key"]),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path="result/regression_cache",
                excel_summary_dir=str(tmp_path / "result"),
            ),
        ),
    )
    monkeypatch.setattr(
        module,
        "RegressionStore",
        lambda db_path: captured_paths.append(db_path) or SimpleNamespace(
            save_sync_run=lambda *_a, **_k: None,
            save_snapshot=lambda *_a, **_k: None,
            save_execution_result=lambda *_a, **_k: None,
        ),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})
    monkeypatch.setattr(module, "process_regression_pass_candidates", lambda **_: None)

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert captured_paths == [module.CURRENT_DIR / "result" / "regression_cache" / "X6851OS16.db"]


def test_run_batch_create_regression_verify_mode_builds_queries_per_specialty_and_writes_execution_results(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    args = _make_args(
        tmp_path,
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项", "Monkey专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
        dry_run=True,
    )
    captured_jql: list[str] = []
    saved_results: list[dict[str, object]] = []

    class FakeJira:
        def current_user(self):
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            captured_jql.append(jql)
            return [SimpleNamespace(key="X6851OS16-607")]

        def issue(self, issue_key: str):
            return SimpleNamespace(
                key=issue_key,
                raw={
                    "fields": {
                        "summary": "【天珑团队】【BUG】【X6851】【OP】【Alpha】【稳定性专项】【休眠唤醒专项】问题",
                        "status": {"name": "Verified"},
                        "resolution": {"name": "已修复"},
                        "fixVersions": [{"name": "X6851-16.3.0.020(OP001PF001AZ)_SU"}],
                    }
                },
            )

    class FakeStore:
        def save_sync_run(self, *_args, **_kwargs):
            return None

        def save_snapshot(self, *_args, **_kwargs):
            return None

        def save_execution_result(self, payload):
            saved_results.append(payload)

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: FakeStore())

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert len(captured_jql) == 2
    assert any('summary ~ "Monkey专项"' in item for item in captured_jql)
    assert any("稳定性专项" in item for item in captured_jql)
    assert saved_results


def test_run_batch_create_regression_verify_mode_dry_run_does_not_record_pass_state(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    args = _make_args(
        tmp_path,
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
        dry_run=True,
    )
    record_calls: list[str] = []

    class FakeJira:
        def current_user(self):
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return [SimpleNamespace(key="X6851OS16-607")]

        def issue(self, issue_key: str):
            return SimpleNamespace(
                key=issue_key,
                raw={
                    "fields": {
                        "summary": "【天珑团队】【BUG】【X6851】【OP】【Alpha】【稳定性专项】【休眠唤醒专项】问题",
                        "status": {"name": "Verified"},
                        "resolution": {"name": "已修复"},
                        "fixVersions": [{"name": "X6851-16.3.0.020(OP001PF001AZ)_SU"}],
                    }
                },
            )

    class FakeStore:
        def save_sync_run(self, *_args, **_kwargs):
            return None

        def save_snapshot(self, *_args, **_kwargs):
            return None

        def save_execution_result(self, *_args, **_kwargs):
            return None

        def record_regression_pass(self, *_args, **_kwargs):
            record_calls.append("called")

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: FakeStore())

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert record_calls == []


def test_run_batch_create_regression_verify_mode_records_skip_results_and_reason(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    caplog: pytest.LogCaptureFixture,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    args = _make_args(
        tmp_path,
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.020(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
        dry_run=True,
    )
    saved_results: list[dict[str, object]] = []

    class FakeJira:
        def current_user(self):
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return [SimpleNamespace(key="X6851OS16-607")]

        def issue(self, issue_key: str):
            return SimpleNamespace(
                key=issue_key,
                raw={
                    "fields": {
                        "summary": "【天珑团队】【BUG】【X6851】【OP】【Alpha】【稳定性专项】【休眠唤醒专项】问题",
                        "status": {"name": "Verified"},
                        "resolution": {"name": "已修复"},
                        "fixVersions": [{"name": "X6851-16.3.0.021(OP001PF001AZ)_SU"}],
                    }
                },
            )

    class FakeStore:
        def save_sync_run(self, *_args, **_kwargs):
            return None

        def save_snapshot(self, *_args, **_kwargs):
            return None

        def save_execution_result(self, payload):
            saved_results.append(payload)

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: FakeStore())

    with caplog.at_level(logging.INFO):
        exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert saved_results
    assert saved_results[0]["action"] == "REGRESSION_PASS_SKIP"
    assert saved_results[0]["reason"] == "CURRENT_VERSION_BEFORE_FIX_VERSION"
    assert "REGRESSION_PASS_SKIP" in caplog.text
    assert "CURRENT_VERSION_BEFORE_FIX_VERSION" in caplog.text


def test_build_regression_pass_comment_keeps_legacy_format_for_monkey_specialty(batch_entry_module):
    module = batch_entry_module

    comment = module.build_regression_pass_comment(
        pass_count=1,
        versions=["X6851-16.3.0.022(OP001PF001AZ)_SU"],
        specialty="Monkey专项",
        current_version="X6851-16.3.0.022(OP001PF001AZ)_SU",
    )

    assert comment == "已回归验证1个版本PASS，已测试版本：X6851-16.3.0.022(OP001PF001AZ)_SU"


def test_build_regression_pass_comment_uses_multiline_template_for_non_monkey_specialty(batch_entry_module):
    module = batch_entry_module

    comment = module.build_regression_pass_comment(
        pass_count=2,
        versions=[
            "X6851-16.3.0.022(OP001PF001AZ)_SU",
            "X6851-16.3.0.023(OP001PF001AZ)_SU",
        ],
        specialty="休眠唤醒专项",
        current_version="X6851-16.3.0.023(OP001PF001AZ)_SU",
    )

    assert comment == (
        "验证结果：PASS\n"
        "测试次数：0/1000\n"
        "验证步骤：休眠唤醒专项\n"
        "验证版本：X6851-16.3.0.023(OP001PF001AZ)_SU\n"
        "样机标识：PR1\n"
        "应用版本：/\n"
        "测试人员及联系方式：吕代+18379465576\n"
        "备注：已回归验证2个版本PASS，已测试版本："
        "X6851-16.3.0.022(OP001PF001AZ)_SU, X6851-16.3.0.023(OP001PF001AZ)_SU"
    )


def test_build_regression_pass_comment_treats_adb_reboot_monkey_as_non_monkey(batch_entry_module):
    module = batch_entry_module

    comment = module.build_regression_pass_comment(
        pass_count=1,
        versions=["X6851-16.3.0.022(OP001PF001AZ)_SU"],
        specialty="ADB重启+Monkey专项",
        current_version="X6851-16.3.0.022(OP001PF001AZ)_SU",
    )

    assert comment == (
        "验证结果：PASS\n"
        "测试次数：0/1000\n"
        "验证步骤：ADB重启+Monkey专项\n"
        "验证版本：X6851-16.3.0.022(OP001PF001AZ)_SU\n"
        "样机标识：PR1\n"
        "应用版本：/\n"
        "测试人员及联系方式：吕代+18379465576\n"
        "备注：已回归验证1个版本PASS，已测试版本：X6851-16.3.0.022(OP001PF001AZ)_SU"
    )


def _make_row(**overrides):
    row = {
        "Project": "TRANSSION",
        "Issue Type": "故障",
        "Summary": "历史命中问题",
        "Description": "desc",
        "Priority": "重要",
        "Components": "Audio",
        "Versions": "V2",
        "Assignee": "owner",
        "Reporter": "reporter",
        "Risk": "once",
        "Issue Source": "测试",
        "Issue Category": "稳定性",
        "Issue Nature": "功能",
        "Affect Project": "ProjectA",
        "Case No": "CASE-1",
        "Environment": "userdebug",
        "Exp Class": "AEE",
        "PS": "需要补充说明",
        "caused_by": "java.lang.RuntimeException: boom at Foo.java:1",
    }
    row.update(overrides)
    return row


def _make_rules(tmp_path: Path, result_dir: Path):
    return SimpleNamespace(
        jira_export=SimpleNamespace(
            enabled=True,
            jql="project = TRANSSION AND statusCategory != Done",
            max_results=50,
            fields=["key", "summary"],
        ),
        matching=SimpleNamespace(
            required_exact_fields=["affect_project", "environment", "exp_class"],
            cause_similarity_threshold=0.9,
        ),
        status_rules=SimpleNamespace(
            open_like_statuses=["Open", "开放", "Reopened", "重新打开", "处理中"],
            resolved_statuses=["已解决", "Verified"],
            resolved_fixed_resolutions=["已修复"],
            wont_fix_resolutions=["问题不修改", "非问题", "Won't Fix", "不解决"],
            closed_statuses=["Closed", "已关闭", "已关单"],
        ),
        regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
        output=SimpleNamespace(
            sqlite_path=str(tmp_path / "regression.db"),
            excel_summary_dir=str(result_dir),
        ),
    )


def test_collect_regression_summary_keywords_uses_monkey_keyword_for_monkey_rows(batch_entry_module):
    module = batch_entry_module
    df = pd.DataFrame(
        [
            _make_row(
                Summary="【天珑团队】【BUG】【X6852OS16】【稳定性专项】【Monkey专项】执行Monkey专项过程中，发生异常"
            )
        ]
    )

    assert module.collect_regression_summary_keywords(df) == ["[MonkeyAEE]"]


def test_extract_specialty_from_summary_recognizes_monkey_aee_tag(batch_entry_module):
    module = batch_entry_module

    specialty = module.extract_specialty_from_summary(
        "[Total Number 4] [MonkeyAEE] ANR com.trassion.infinix.xclub"
    )

    assert specialty == "Monkey专项"


def test_get_regression_pass_candidates_keeps_monkey_aee_rows_when_specialty_allowed(batch_entry_module):
    module = batch_entry_module
    regression_rules = _make_rules(Path("."), Path("."))

    candidates = module._get_regression_pass_candidates(
        store=SimpleNamespace(),
        run_id="20260422_140109",
        snapshot_rows=[
            {
                "jira_key": "X6852AEE-71",
                "status": "已解决",
                "resolution": "已修复",
                "fix_version": "X6852-16.3.0.102(OP001PF001AZ)",
                "summary": "[Total Number 4] [MonkeyAEE] ANR com.trassion.infinix.xclub",
            }
        ],
        regression_rules=regression_rules,
        matched_jira_keys=set(),
        allowed_specialties={"Monkey专项"},
    )

    assert len(candidates) == 1
    assert candidates[0]["jira_key"] == "X6852AEE-71"


def test_collect_regression_summary_keywords_uses_stability_keyword_for_non_monkey_rows(batch_entry_module):
    module = batch_entry_module
    df = pd.DataFrame(
        [
            _make_row(
                Summary="【天珑团队】【BUG】【X6852OS16】【稳定性专项】【开关机专项】执行开关机专项过程中，发生异常"
            )
        ]
    )

    assert module.collect_regression_summary_keywords(df) == ["【稳定性专项】"]


def test_build_regression_export_jql_combines_keywords_for_mixed_rows(batch_entry_module):
    module = batch_entry_module
    base_jql = "project = X6852OS16 AND reporter in (dailv.tinno)"
    keywords = ["【稳定性专项】", "[MonkeyAEE]"]

    assert module.build_regression_export_jql(base_jql, keywords) == (
        "project = X6852OS16 AND reporter in (dailv.tinno) "
        "AND (summary ~ \"【稳定性专项】\" OR summary ~ \"\\\\[MonkeyAEE\\\\]\")"
    )


def test_collect_batch_project_key_returns_single_project(batch_entry_module):
    module = batch_entry_module
    df = pd.DataFrame(
        [
            _make_row(Project="X6851OS16"),
            _make_row(Project="X6851OS16", Summary="另一个问题"),
        ]
    )

    class FakeJira:
        pass

    assert module.collect_batch_project_key(FakeJira(), df, {}) == "X6851OS16"


def test_collect_batch_project_key_raises_for_multiple_projects(batch_entry_module):
    module = batch_entry_module
    df = pd.DataFrame(
        [
            _make_row(Project="X6851OS16"),
            _make_row(Project="X6852OS16", Summary="另一个问题"),
        ]
    )

    class FakeJira:
        pass

    with pytest.raises(ValueError, match="多个 Jira 项目"):
        module.collect_batch_project_key(FakeJira(), df, {})


def test_export_jira_snapshot_logs_export_jql(batch_entry_module, caplog: pytest.LogCaptureFixture):
    module = batch_entry_module
    caplog.set_level(logging.INFO)

    class FakeJira:
        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            assert jql == 'project = X6852OS16 AND reporter in (dailv.tinno) AND (summary ~ "【稳定性专项】")'
            return []

    rules = SimpleNamespace(
        jira_export=SimpleNamespace(
            enabled=True,
            jql="reporter in (dailv.tinno)",
            max_results=50,
        )
    )

    rows = module.export_jira_snapshot(
        FakeJira(),
        rules,
        base_jql="project = X6852OS16 AND reporter in (dailv.tinno)",
        summary_keywords=["【稳定性专项】"],
    )

    assert rows == []
    assert '历史问题单导出 JQL: project = X6852OS16 AND reporter in (dailv.tinno) AND (summary ~ "【稳定性专项】")' in caplog.text


def test_run_batch_create_uses_current_user_in_regression_export_jql(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    args = _make_args(tmp_path, dry_run=True)
    df = pd.DataFrame([_make_row()])
    captured_jql: list[str] = []

    class FakeJira:
        def current_user(self) -> str:
            return "qimingwang.tinno"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            captured_jql.append(jql)
            return []

    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "X6852OS16", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="reporter in (dailv.tinno)", max_results=50, fields=["key"]),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(tmp_path / "result"),
            ),
        ),
    )
    monkeypatch.setattr(
        module,
        "RegressionStore",
        lambda *_args, **_kwargs: SimpleNamespace(
            save_sync_run=lambda *_a, **_k: None,
            save_snapshot=lambda *_a, **_k: None,
            save_execution_result=lambda *_a, **_k: None,
        ),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert captured_jql == ['project = TRANSSION AND reporter in (qimingwang.tinno) AND (summary ~ "【稳定性专项】")']


def test_run_batch_create_passes_current_user_as_create_reporter_override(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    args = _make_args(tmp_path, dry_run=True)
    df = pd.DataFrame([_make_row()])
    captured_kwargs: dict[str, object] = {}

    class FakeJira:
        def current_user(self) -> str:
            return "qimingwang.tinno"

        def search_issues(self, *_args, **_kwargs):
            return []

    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(enabled=False, jql="", max_results=50, fields=["key"]),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=False, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(tmp_path / "result"),
            ),
        ),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})

    def fake_build_issue_fields(**kwargs):
        captured_kwargs.update(kwargs)
        return {"summary": "stub"}

    monkeypatch.setattr(module, "build_issue_fields", fake_build_issue_fields)

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert captured_kwargs["create_reporter_override"] == "qimingwang.tinno"


def test_export_jira_snapshot_passes_snapshot_field_mapping(batch_entry_module, monkeypatch: pytest.MonkeyPatch):
    module = batch_entry_module
    captured: list[dict[str, object]] = []

    def fake_fetch_issue_snapshot_fields(_jira_client, issue_key: str, field_mapping=None):
        captured.append({"issue_key": issue_key, "field_mapping": field_mapping})
        return {"jira_key": issue_key}

    class FakeJira:
        def search_issues(self, *_args, **_kwargs):
            return [SimpleNamespace(key="X6851OS16-607")]

    rules = SimpleNamespace(
        jira_export=SimpleNamespace(
            enabled=True,
            jql="reporter in (dailv.tinno)",
            max_results=50,
        )
    )

    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", fake_fetch_issue_snapshot_fields)

    rows = module.export_jira_snapshot(
        FakeJira(),
        rules,
        base_jql="project = X6851OS16 AND reporter in (dailv.tinno)",
        summary_keywords=["【稳定性专项】"],
        field_mapping={"caused_by": "customfield_14203"},
    )

    assert rows == [{"jira_key": "X6851OS16-607"}]
    assert captured == [
        {
            "issue_key": "X6851OS16-607",
            "field_mapping": {"caused_by": "customfield_14203"},
        }
    ]


def test_run_batch_create_dry_run_logs_decision_summary(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
    caplog: pytest.LogCaptureFixture,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    caplog.set_level(logging.INFO)
    args = _make_args(tmp_path, dry_run=True)
    df = pd.DataFrame([_make_row()])

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *_args, **_kwargs):
            return []

    class FakeStore:
        def __init__(self, _db_path):
            pass

        def save_sync_run(self, _record):
            return None

        def save_snapshot(self, _run_id, _rows):
            return None

        def save_execution_result(self, _result):
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
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(
        module,
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="project = TRANSSION",
                max_results=50,
                fields=["key"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert "第 1 行 dry-run结果: matched_jira_key=NONE action=CREATE_NEW reason=未命中历史单" in caplog.text


def test_run_batch_create_returns_error_for_multiple_projects(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
    caplog: pytest.LogCaptureFixture,
):
    module = batch_entry_module
    caplog.set_level(logging.ERROR)
    args = _make_args(tmp_path, dry_run=True)
    df = pd.DataFrame(
        [
            _make_row(Project="X6851OS16"),
            _make_row(Project="X6852OS16", Summary="第二行"),
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="reporter in (dailv.tinno)", max_results=50, fields=["key"]),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(tmp_path / "result"),
            ),
        ),
    )

    exit_code = module.run_batch_create(args)

    assert exit_code == 1
    assert "当前上传模板包含多个 Jira 项目" in caplog.text


def test_run_batch_create_dry_run_writes_regression_decision_result_json(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"snapshots": [], "execution_results": []}

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
        add_comments=True,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "历史命中问题",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V2",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectA",
                "Case No": "CASE-1",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "需要人工复核",
                "caused_by": "java.lang.RuntimeException: boom at Foo.java:1",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            assert "project = TRANSSION" in jql
            return [SimpleNamespace(key="TRANSSION-1")]

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshots"].append({"run_id": run_id, "rows": list(rows)})

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="project = TRANSSION AND statusCategory != Done",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(
        module,
        "get_meta_bundle",
        lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}},
    )
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-1",
            "summary": "历史问题",
            "status": "已解决",
            "resolution": "已修复",
            "fix_version": "",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom at Foo.java:9",
            "raw_payload": "{}",
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(
        module,
        "decide_action",
        lambda *_args, **_kwargs: SimpleNamespace(
            action="MANUAL_REVIEW",
            update_jira=False,
            manual_review=True,
            comment_required=False,
            recreate_issue=False,
        ),
    )

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert store_events["snapshots"]
    assert store_events["execution_results"]
    assert store_events["execution_results"][0]["action"] == "MANUAL_REVIEW"
    assert store_events["execution_results"][0]["manual_review"] == 1

    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    assert result_files, "应写出结果 JSON"
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["decision"]["action"] == "MANUAL_REVIEW"
    assert payload[0]["matched_jira_key"] == "TRANSSION-1"


def test_run_batch_create_skips_regression_flow_when_regression_disabled(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    args = _make_args(tmp_path, dry_run=True)
    df = pd.DataFrame([_make_row()])

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *args, **kwargs):
            raise AssertionError("回归关闭时不应导出历史 Jira 单")

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="project = TRANSSION", max_results=50, fields=["key"]),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=False, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(
        module,
        "RegressionStore",
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("回归关闭时不应初始化 RegressionStore")),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    assert result_files, "应写出结果 JSON"
    summary_files = sorted(result_dir.glob("transsion_jira_batch_create_summary_*.xlsx"))
    assert not summary_files, "回归关闭时不应输出 Excel 摘要"
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["decision"]["action"] == "CREATE_NEW"
    assert payload[0]["matched_jira_key"] is None


def test_run_batch_create_cli_disable_regression_overrides_enabled_config(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    args = _make_args(tmp_path, dry_run=True, disable_regression=True)
    df = pd.DataFrame([_make_row()])

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, *args, **kwargs):
            raise AssertionError("命令行关闭回归后不应导出历史 Jira 单")

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="project = TRANSSION", max_results=50, fields=["key"]),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(
        module,
        "RegressionStore",
        lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("命令行关闭回归后不应初始化 RegressionStore")),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub"})

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    assert result_files, "应写出结果 JSON"
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["decision"]["action"] == "CREATE_NEW"
    assert payload[0]["matched_jira_key"] is None


def test_run_batch_create_non_dry_run_executes_update_and_comment_for_open_like_match(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}
    update_calls: list[tuple[str, dict]] = []
    comment_calls: list[tuple[str, str]] = []

    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="user",
        jira_password="pass",
        jira_server="http://jira.example.com",
        config_file="fake-defaults.json",
        severity_rules_file="fake-rules.xls",
        bug_severity_image_dir=str(tmp_path / "images"),
        wait_between_issues=0,
        dry_run=False,
        validate_metadata=False,
        add_comments=True,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "历史命中问题",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V2",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectA",
                "Case No": "CASE-1",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "需要补充说明",
                "caused_by": "java.lang.RuntimeException: boom at Foo.java:1",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-2")]

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshot_rows"] = list(rows)

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="project = TRANSSION AND statusCategory != Done",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(
        module,
        "get_meta_bundle",
        lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}},
    )
    monkeypatch.setattr(
        module,
        "build_issue_fields",
        lambda **_: {
            "project": {"key": "TRANSSION"},
            "issuetype": {"name": "故障"},
            "reporter": {"name": "reporter"},
            "assignee": {"name": "owner"},
            "summary": "stub",
            "description": "stub-desc",
            "priority": {"name": "Major"},
        },
    )
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-2",
            "summary": "历史问题",
            "status": "Open",
            "resolution": "",
            "fix_version": "",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom at Foo.java:9",
            "raw_payload": "{}",
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(
        module,
        "decide_action",
        lambda *_args, **_kwargs: SimpleNamespace(
            action="OPEN_LIKE_UPDATE",
            update_jira=True,
            manual_review=False,
            comment_required=True,
            recreate_issue=False,
        ),
    )
    monkeypatch.setattr(module, "update_issue_fields", lambda jira, issue_key, fields: update_calls.append((issue_key, dict(fields))))
    monkeypatch.setattr(module, "add_issue_comment", lambda jira, issue_key, comment: comment_calls.append((issue_key, comment)))

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert update_calls == [
        (
            "TRANSSION-2",
            {
                "summary": "stub",
                "description": "stub-desc",
                "priority": {"name": "Major"},
            },
        )
    ]
    assert "project" not in update_calls[0][1]
    assert "issuetype" not in update_calls[0][1]
    assert "reporter" not in update_calls[0][1]
    assert "assignee" not in update_calls[0][1]
    assert len(comment_calls) == 2
    assert comment_calls[0][0] == "TRANSSION-2"
    assert comment_calls[0][1]
    assert comment_calls[0][1] != "需要补充说明"
    assert comment_calls[1][0] == "TRANSSION-2"
    assert comment_calls[1][1] == "*Reporter:* robot\n需要补充说明"
    assert store_events["execution_results"][0]["action"] == "OPEN_LIKE_UPDATE"


def test_run_batch_create_non_dry_run_open_like_match_without_ps_still_adds_main_comment(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    update_calls: list[tuple[str, dict]] = []
    comment_calls: list[tuple[str, str]] = []

    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="user",
        jira_password="pass",
        jira_server="http://jira.example.com",
        config_file="fake-defaults.json",
        severity_rules_file="fake-rules.xls",
        bug_severity_image_dir=str(tmp_path / "images"),
        wait_between_issues=0,
        dry_run=False,
        validate_metadata=False,
        add_comments=True,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "历史命中问题",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V2",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectA",
                "Case No": "CASE-1",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "",
                "caused_by": "java.lang.RuntimeException: boom at Foo.java:1",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-3")]

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="project = TRANSSION AND statusCategory != Done",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: SimpleNamespace(
        save_sync_run=lambda *_a, **_k: None,
        save_snapshot=lambda *_a, **_k: None,
        save_execution_result=lambda *_a, **_k: None,
    ))
    monkeypatch.setattr(
        module,
        "get_meta_bundle",
        lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}},
    )
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc"})
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-3",
            "summary": "历史问题",
            "status": "Open",
            "resolution": "",
            "fix_version": "",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom at Foo.java:9",
            "raw_payload": "{}",
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(
        module,
        "decide_action",
        lambda *_args, **_kwargs: SimpleNamespace(
            action="OPEN_LIKE_UPDATE",
            update_jira=True,
            manual_review=False,
            comment_required=True,
            recreate_issue=False,
        ),
    )
    monkeypatch.setattr(module, "update_issue_fields", lambda jira, issue_key, fields: update_calls.append((issue_key, dict(fields))))
    monkeypatch.setattr(module, "add_issue_comment", lambda jira, issue_key, comment: comment_calls.append((issue_key, comment)))

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert update_calls == [("TRANSSION-3", {"summary": "stub", "description": "stub-desc"})]
    assert len(comment_calls) == 1
    assert comment_calls[0][0] == "TRANSSION-3"
    assert comment_calls[0][1]


def test_run_batch_create_non_dry_run_wont_fix_match_without_ps_still_adds_main_comment(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    comment_calls: list[tuple[str, str]] = []

    args = SimpleNamespace(
        excel_file="fake.xlsx",
        jira_username="user",
        jira_password="pass",
        jira_server="http://jira.example.com",
        config_file="fake-defaults.json",
        severity_rules_file="fake-rules.xls",
        bug_severity_image_dir=str(tmp_path / "images"),
        wait_between_issues=0,
        dry_run=False,
        validate_metadata=False,
        add_comments=True,
    )

    df = pd.DataFrame(
        [
            {
                "Project": "TRANSSION",
                "Issue Type": "故障",
                "Summary": "历史命中问题",
                "Description": "desc",
                "Priority": "重要",
                "Components": "Audio",
                "Versions": "V2",
                "Assignee": "owner",
                "Reporter": "reporter",
                "Risk": "once",
                "Issue Source": "测试",
                "Issue Category": "稳定性",
                "Issue Nature": "功能",
                "Affect Project": "ProjectA",
                "Case No": "CASE-1",
                "Environment": "userdebug",
                "Exp Class": "AEE",
                "PS": "",
                "caused_by": "java.lang.RuntimeException: boom at Foo.java:1",
            }
        ]
    )

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-4")]

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
        "load_regression_rules",
        lambda _: SimpleNamespace(
            jira_export=SimpleNamespace(
                enabled=True,
                jql="project = TRANSSION AND statusCategory != Done",
                max_results=50,
                fields=["key", "summary"],
            ),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            output=SimpleNamespace(
                sqlite_path=str(tmp_path / "regression.db"),
                excel_summary_dir=str(result_dir),
            ),
        ),
    )
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: SimpleNamespace(
        save_sync_run=lambda *_a, **_k: None,
        save_snapshot=lambda *_a, **_k: None,
        save_execution_result=lambda *_a, **_k: None,
    ))
    monkeypatch.setattr(
        module,
        "get_meta_bundle",
        lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}},
    )
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc"})
    monkeypatch.setattr(
        module,
        "fetch_issue_snapshot_fields",
        lambda *_args, **_kwargs: {
            "jira_key": "TRANSSION-4",
            "summary": "历史问题",
            "status": "已解决",
            "resolution": "问题不修改",
            "fix_version": "",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException: boom at Foo.java:9",
            "raw_payload": "{}",
        },
    )
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(
        module,
        "decide_action",
        lambda *_args, **_kwargs: SimpleNamespace(
            action="WONT_FIX_KEEP",
            update_jira=False,
            manual_review=False,
            comment_required=True,
            recreate_issue=False,
        ),
    )
    monkeypatch.setattr(module, "update_issue_fields", lambda *_args, **_kwargs: (_ for _ in ()).throw(AssertionError("不应更新 issue 字段")))
    monkeypatch.setattr(module, "add_issue_comment", lambda jira, issue_key, comment: comment_calls.append((issue_key, comment)))

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert len(comment_calls) == 1
    assert comment_calls[0][0] == "TRANSSION-4"
    assert comment_calls[0][1]


def test_build_regression_row_uses_max_version_as_current_version(batch_entry_module):
    module = batch_entry_module

    regression_row = module.build_regression_row(pd.Series(_make_row(Versions="V2, V4")))

    assert regression_row["versions"] == ["V2", "V4"]
    assert regression_row["current_version"] == "V4"


def test_build_regression_row_reads_caused_by_from_excel_column_alias(batch_entry_module):
    module = batch_entry_module

    regression_row = module.build_regression_row(
        pd.Series(_make_row(caused_by=None, CausedBy="Input dispatching timed out"))
    )

    assert regression_row["caused_by"] == "Input dispatching timed out"


def test_find_regression_match_prefers_latest_updated_then_created(batch_entry_module):
    module = batch_entry_module
    current_row = {
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
    }
    snapshot_rows = [
        {
            "jira_key": "TRANSSION-9",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException",
            "raw_payload": json.dumps({"fields": {"updated": "2026-03-29T01:00:00.000+0000"}}),
        },
        {
            "jira_key": "TRANSSION-2",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException",
            "raw_payload": json.dumps({"fields": {"updated": "2026-03-30T01:00:00.000+0000"}}),
        },
    ]

    matched = module.find_regression_match(
        current_row,
        snapshot_rows,
        SimpleNamespace(required_exact_fields=["affect_project", "environment", "exp_class"], cause_similarity_threshold=0.9),
    )

    assert matched["jira_key"] == "TRANSSION-2"


def test_find_regression_match_falls_back_to_jira_key_order_when_timestamps_missing(batch_entry_module):
    module = batch_entry_module
    current_row = {
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
    }
    snapshot_rows = [
        {
            "jira_key": "TRANSSION-9",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException",
            "raw_payload": "{}",
        },
        {
            "jira_key": "TRANSSION-2",
            "affect_project": "ProjectA",
            "environment": "userdebug",
            "exp_class": "AEE",
            "caused_by": "java.lang.RuntimeException",
            "raw_payload": "{}",
        },
    ]

    matched = module.find_regression_match(
        current_row,
        snapshot_rows,
        SimpleNamespace(required_exact_fields=["affect_project", "environment", "exp_class"], cause_similarity_threshold=0.9),
    )

    assert matched["jira_key"] == "TRANSSION-2"


def test_run_batch_create_manual_review_does_not_build_issue_fields(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-5")]

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshot_rows"] = list(rows)

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: pd.DataFrame([_make_row(Components="", Versions="")]))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", lambda *_args, **_kwargs: {
        "jira_key": "TRANSSION-5",
        "summary": "历史问题",
        "status": "已解决",
        "resolution": "已修复",
        "fix_version": "",
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
        "raw_payload": "{}",
    })
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(module, "decide_action", lambda *_args, **_kwargs: SimpleNamespace(
        action="MANUAL_REVIEW",
        update_jira=False,
        manual_review=True,
        comment_required=False,
        recreate_issue=False,
    ))
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: (_ for _ in ()).throw(AssertionError("MANUAL_REVIEW 不应构建建单字段")))

    exit_code = module.run_batch_create(_make_args(tmp_path))

    assert exit_code == 0
    assert store_events["execution_results"][0]["action"] == "MANUAL_REVIEW"
    assert store_events["execution_results"][0]["success"] == 1


def test_run_batch_create_preserves_matched_history_key_when_recreate_prework_fails(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-8")]

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshot_rows"] = list(rows)

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: pd.DataFrame([_make_row()]))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", lambda *_args, **_kwargs: {
        "jira_key": "TRANSSION-8",
        "summary": "历史问题",
        "status": "Closed",
        "resolution": "",
        "fix_version": "",
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
        "raw_payload": "{}",
    })
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(module, "decide_action", lambda *_args, **_kwargs: SimpleNamespace(
        action="CLOSED_RECREATE",
        update_jira=False,
        manual_review=False,
        comment_required=False,
        recreate_issue=True,
    ))
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: (_ for _ in ()).throw(RuntimeError("build fields failed")))

    exit_code = module.run_batch_create(_make_args(tmp_path))

    assert exit_code == 1
    assert store_events["execution_results"][0]["matched_jira_key"] == "TRANSSION-8"
    assert store_events["execution_results"][0]["action"] == "CLOSED_RECREATE"
    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["matched_jira_key"] == "TRANSSION-8"
    assert payload[0]["decision"]["action"] == "CLOSED_RECREATE"
    assert payload[0]["status"] == "FAILED"


def test_run_batch_create_create_new_records_new_issue_key(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
    caplog: pytest.LogCaptureFixture,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}
    caplog.set_level(logging.INFO)

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return []

        def create_issue(self, fields):
            return SimpleNamespace(key="TRANSSION-NEW-1")

        def add_comment(self, issue_key, comment):
            return None

        def add_attachment(self, **kwargs):
            return None

        def issue(self, issue_key):
            return SimpleNamespace(fields=SimpleNamespace(status=SimpleNamespace(name="Open")))

        def transitions(self, issue):
            return []

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshot_rows"] = list(rows)

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: pd.DataFrame([_make_row()]))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", lambda *_args, **_kwargs: {})
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: False)
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc", "priority": {"name": "Major"}})
    monkeypatch.setattr(module, "decide_action", lambda *_args, **kwargs: SimpleNamespace(
        action="CREATE_NEW",
        update_jira=False,
        manual_review=False,
        comment_required=False,
        recreate_issue=True,
    ))
    monkeypatch.setattr(module, "resolve_bug_severity_attachment_name", lambda *_args, **_kwargs: None)
    monkeypatch.setattr(module, "transition_issue_to_open", lambda *_args, **_kwargs: (False, "skip"))

    exit_code = module.run_batch_create(_make_args(tmp_path, add_comments=False))

    assert exit_code == 0
    assert "第 1 行执行结果: matched_jira_key=TRANSSION-NEW-1 action=CREATE_NEW reason=未命中历史单 status=SUCCESS result=CREATE_NEW -> TRANSSION-NEW-1" in caplog.text
    assert store_events["execution_results"][0]["matched_jira_key"] == "TRANSSION-NEW-1"
    assert store_events["execution_results"][0]["success"] == 1
    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["issue_key"] == "TRANSSION-NEW-1"
    excel_files = sorted(result_dir.glob("transsion_jira_batch_create_summary_*.xlsx"))
    assert excel_files, "应写出结果 Excel 摘要"
    excel_payload = pd.read_excel(excel_files[-1], engine="openpyxl").fillna("")
    assert excel_payload.to_dict(orient="records") == [
        {
            "row_number": 1,
            "matched_jira_key": "TRANSSION-NEW-1",
            "matched_status": "",
            "matched_resolution": "",
            "fix_version": "",
            "action": "CREATE_NEW",
            "success": 1,
            "manual_review": 0,
            "reason": "未命中历史单",
            "old_count": "",
            "new_count": "",
            "comment_status": "",
            "ps_comment_status": "",
            "result_message": "CREATE_NEW -> TRANSSION-NEW-1",
        }
    ]


def test_run_batch_create_preserves_issue_key_when_create_succeeds_but_followup_fails(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return []

        def create_issue(self, fields):
            return SimpleNamespace(key="TRANSSION-NEW-2")

        def add_comment(self, issue_key, comment):
            return None

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshot_rows"] = list(rows)

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: pd.DataFrame([_make_row()]))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc", "priority": {"name": "Major"}})
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: False)
    monkeypatch.setattr(module, "decide_action", lambda *_args, **_kwargs: SimpleNamespace(
        action="CREATE_NEW",
        update_jira=False,
        manual_review=False,
        comment_required=False,
        recreate_issue=True,
    ))
    monkeypatch.setattr(module, "resolve_bug_severity_attachment_name", lambda *_args, **_kwargs: None)
    monkeypatch.setattr(module, "transition_issue_to_open", lambda *_args, **_kwargs: (_ for _ in ()).throw(RuntimeError("transition failed")))

    exit_code = module.run_batch_create(_make_args(tmp_path, add_comments=False))

    assert exit_code == 1
    assert store_events["execution_results"][0]["matched_jira_key"] == "TRANSSION-NEW-2"
    assert store_events["execution_results"][0]["success"] == 0
    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["issue_key"] == "TRANSSION-NEW-2"
    assert payload[0]["status"] == "FAILED"


def test_run_batch_create_history_comment_failure_keeps_matched_issue_key(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    store_events: dict[str, object] = {"execution_results": []}

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-6")]

    class FakeStore:
        def __init__(self, db_path: Path):
            store_events["db_path"] = Path(db_path)

        def save_sync_run(self, record):
            store_events["sync_run"] = dict(record)

        def save_snapshot(self, run_id, rows):
            store_events["snapshot_rows"] = list(rows)

        def save_execution_result(self, result):
            store_events["execution_results"].append(dict(result))

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: pd.DataFrame([_make_row()]))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", FakeStore)
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc", "priority": {"name": "Major"}})
    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", lambda *_args, **_kwargs: {
        "jira_key": "TRANSSION-6",
        "summary": "历史问题",
        "status": "Open",
        "resolution": "",
        "fix_version": "",
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
        "raw_payload": "{}",
    })
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(module, "decide_action", lambda *_args, **_kwargs: SimpleNamespace(
        action="OPEN_LIKE_UPDATE",
        update_jira=True,
        manual_review=False,
        comment_required=True,
        recreate_issue=False,
    ))
    monkeypatch.setattr(module, "update_issue_fields", lambda *_args, **_kwargs: None)
    monkeypatch.setattr(module, "add_issue_comment", lambda *_args, **_kwargs: (_ for _ in ()).throw(RuntimeError("comment failed")))

    exit_code = module.run_batch_create(_make_args(tmp_path))

    assert exit_code == 1
    assert store_events["execution_results"][0]["matched_jira_key"] == "TRANSSION-6"
    assert store_events["execution_results"][0]["success"] == 0
    result_files = sorted(result_dir.glob("transsion_jira_batch_create_result_*.json"))
    payload = json.loads(result_files[-1].read_text(encoding="utf-8"))
    assert payload[0]["matched_jira_key"] == "TRANSSION-6"
    assert payload[0]["issue_key"] == "TRANSSION-6"
    assert payload[0]["status"] == "FAILED"


def test_run_batch_create_history_ps_comment_respects_add_comments_flag(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    comment_calls: list[tuple[str, str]] = []

    class FakeJira:
        def current_user(self) -> str:
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-7")]

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "read_excel_smart", lambda _: pd.DataFrame([_make_row(PS="只应在 add_comments=true 时追加")]))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: SimpleNamespace(
        save_sync_run=lambda *_a, **_k: None,
        save_snapshot=lambda *_a, **_k: None,
        save_execution_result=lambda *_a, **_k: None,
    ))
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc", "priority": {"name": "Major"}})
    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", lambda *_args, **_kwargs: {
        "jira_key": "TRANSSION-7",
        "summary": "历史问题",
        "status": "Open",
        "resolution": "",
        "fix_version": "",
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
        "raw_payload": "{}",
    })
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(module, "decide_action", lambda *_args, **_kwargs: SimpleNamespace(
        action="OPEN_LIKE_UPDATE",
        update_jira=True,
        manual_review=False,
        comment_required=True,
        recreate_issue=False,
    ))
    monkeypatch.setattr(module, "update_issue_fields", lambda *_args, **_kwargs: None)
    monkeypatch.setattr(module, "add_issue_comment", lambda jira, issue_key, comment: comment_calls.append((issue_key, comment)))

    exit_code = module.run_batch_create(_make_args(tmp_path, add_comments=False))

    assert exit_code == 0
    assert len(comment_calls) == 1
    assert comment_calls[0][0] == "TRANSSION-7"
    assert "只应在 add_comments=true 时追加" not in comment_calls[0][1]


def test_run_batch_create_history_ps_comment_uses_current_user_as_reporter(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    result_dir = tmp_path / "result"
    comment_calls: list[tuple[str, str]] = []

    class FakeJira:
        def current_user(self) -> str:
            return "qimingwang.tinno"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            return [SimpleNamespace(key="TRANSSION-8")]

    monkeypatch.setattr(module, "RESULT_DIR", result_dir)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "TRANSSION", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(
        module,
        "read_excel_smart",
        lambda _: pd.DataFrame([_make_row(PS="*Reporter:* dailv.tinno\n*Version:* V2\n*Path:* /tmp/log")]),
    )
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, result_dir))
    monkeypatch.setattr(
        module,
        "RegressionStore",
        lambda *_args, **_kwargs: SimpleNamespace(
            save_sync_run=lambda *_a, **_k: None,
            save_snapshot=lambda *_a, **_k: None,
            save_execution_result=lambda *_a, **_k: None,
        ),
    )
    monkeypatch.setattr(module, "get_meta_bundle", lambda *_: {"create_fields": {}, "allowed_values": {}, "field_name_lookup": {}})
    monkeypatch.setattr(module, "build_issue_fields", lambda **_: {"summary": "stub", "description": "stub-desc", "priority": {"name": "Major"}})
    monkeypatch.setattr(module, "fetch_issue_snapshot_fields", lambda *_args, **_kwargs: {
        "jira_key": "TRANSSION-8",
        "summary": "历史问题",
        "status": "Open",
        "resolution": "",
        "fix_version": "",
        "affect_project": "ProjectA",
        "environment": "userdebug",
        "exp_class": "AEE",
        "caused_by": "java.lang.RuntimeException",
        "raw_payload": "{}",
    })
    monkeypatch.setattr(module, "is_strong_match", lambda *_args, **_kwargs: True)
    monkeypatch.setattr(module, "decide_action", lambda *_args, **_kwargs: SimpleNamespace(
        action="OPEN_LIKE_UPDATE",
        update_jira=True,
        manual_review=False,
        comment_required=True,
        recreate_issue=False,
    ))
    monkeypatch.setattr(module, "update_issue_fields", lambda *_args, **_kwargs: None)
    monkeypatch.setattr(module, "add_issue_comment", lambda jira, issue_key, comment: comment_calls.append((issue_key, comment)))

    exit_code = module.run_batch_create(_make_args(tmp_path, add_comments=True))

    assert exit_code == 0
    assert len(comment_calls) == 2
    assert comment_calls[1][0] == "TRANSSION-8"
    assert "*Reporter:* qimingwang.tinno" in comment_calls[1][1]
