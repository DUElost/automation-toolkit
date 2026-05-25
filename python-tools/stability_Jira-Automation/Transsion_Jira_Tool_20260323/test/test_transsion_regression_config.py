from __future__ import annotations

import importlib
import json
import sys
from pathlib import Path
from typing import Generator

import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT
MODULE_NAME = "transsion_regression_models"
REAL_CONFIG_PATH = PROJECT_ROOT / "config" / "regression_rules.json"


@pytest.fixture
def regression_module() -> Generator[object, None, None]:
    module_dir = str(MODULE_DIR)
    original_path = list(sys.path)
    original_modules = set(sys.modules.keys())
    original_module = sys.modules.get(MODULE_NAME)
    sys.modules.pop(MODULE_NAME, None)
    try:
        if module_dir not in sys.path:
            sys.path.insert(0, module_dir)
        yield importlib.import_module(MODULE_NAME)
    finally:
        current_modules = set(sys.modules.keys())
        for module_key in current_modules - original_modules:
            sys.modules.pop(module_key, None)
        if original_module is None:
            sys.modules.pop(MODULE_NAME, None)
        else:
            sys.modules[MODULE_NAME] = original_module
        sys.path[:] = original_path


def test_module_exports_required_symbols(regression_module):
    module = regression_module

    assert hasattr(module, "MatchingRules")
    assert hasattr(module, "RegressionRules")
    assert hasattr(module, "load_regression_rules")


def test_real_regression_rules_config_matches_contract(regression_module):
    module = regression_module

    rules = module.load_regression_rules(REAL_CONFIG_PATH)

    assert rules.jira_export.enabled is True
    assert rules.jira_export.jql == "reporter in (dailv.tinno)"
    assert rules.jira_export.max_results == 1000
    assert rules.jira_export.fields == [
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
        "description",
        "affect_project",
        "environment",
        "exp_class",
        "caused_by",
    ]
    assert rules.status_rules.open_like_statuses
    assert rules.status_rules.resolved_statuses
    assert rules.status_rules.resolved_fixed_resolutions
    assert rules.status_rules.wont_fix_resolutions
    assert rules.status_rules.closed_statuses
    assert rules.matching.required_exact_fields == [
        "affect_project",
        "environment",
        "exp_class",
    ]
    assert rules.matching.cause_similarity_threshold == 0.9
    assert rules.regression.enabled is True
    assert rules.regression.required_regression_pass_versions == 2
    assert rules.output.sqlite_path == "result/regression_cache"
    assert rules.output.excel_summary_dir == "result"
    assert rules.status_rules.open_like_statuses == ["Open", "开放", "Reopened", "重新打开", "处理中"]
    assert rules.status_rules.resolved_statuses == ["已解决", "Verified"]
    assert rules.status_rules.resolved_fixed_resolutions == ["已修复"]
    assert rules.status_rules.wont_fix_resolutions == ["问题不修改", "非问题", "Won't Fix", "不解决"]
    assert rules.status_rules.closed_statuses == ["Closed", "已关闭", "已关单"]


def test_load_regression_rules_reads_json(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                },
                "matching": {
                    "required_exact_fields": ["affect_project", "environment", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": ["open"],
                    "resolved_statuses": ["resolved"],
                    "resolved_fixed_resolutions": ["fixed"],
                    "wont_fix_resolutions": ["wont fix"],
                    "closed_statuses": ["closed"],
                },
                "regression": {"enabled": True, "required_regression_pass_versions": 2},
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    rules = module.load_regression_rules(config_path)

    assert isinstance(rules, module.RegressionRules)
    assert isinstance(rules.matching, module.MatchingRules)
    assert rules.jira_export.enabled is True
    assert isinstance(rules.jira_export.fields, list)
    assert rules.matching.required_exact_fields == [
        "affect_project",
        "environment",
        "exp_class",
    ]
    assert rules.matching.cause_similarity_threshold == 0.9
    assert rules.regression.enabled is True
    assert rules.regression.required_regression_pass_versions == 2
    assert rules.output.sqlite_path == "result/transsion_regression_cache.db"
    assert rules.output.excel_summary_dir == "result"


def test_load_regression_rules_allows_disabling_regression(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                },
                "matching": {
                    "required_exact_fields": ["affect_project", "environment", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": ["open"],
                    "resolved_statuses": ["resolved"],
                    "resolved_fixed_resolutions": ["fixed"],
                    "wont_fix_resolutions": ["wont fix"],
                    "closed_statuses": ["closed"],
                },
                "regression": {"enabled": False, "required_regression_pass_versions": 2},
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    rules = module.load_regression_rules(config_path)

    assert rules.regression.enabled is False
    assert rules.regression.required_regression_pass_versions == 2


def test_load_regression_rules_rejects_empty_required_exact_fields(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "matching": {
                    "required_exact_fields": [],
                    "cause_similarity_threshold": 0.9,
                }
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="required_exact_fields"):
        module.load_regression_rules(config_path)


def test_load_regression_rules_rejects_non_contract_required_exact_fields(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                },
                "matching": {
                    "required_exact_fields": ["environment", "affect_project", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": ["open"],
                    "resolved_statuses": ["resolved"],
                    "resolved_fixed_resolutions": ["fixed"],
                    "wont_fix_resolutions": ["wont fix"],
                    "closed_statuses": ["closed"],
                },
                "regression": {"enabled": True, "required_regression_pass_versions": 2},
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="required_exact_fields"):
        module.load_regression_rules(config_path)


def test_load_regression_rules_rejects_empty_status_lists(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                },
                "matching": {
                    "required_exact_fields": ["affect_project", "environment", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": [],
                    "resolved_statuses": [],
                    "resolved_fixed_resolutions": [],
                    "wont_fix_resolutions": [],
                    "closed_statuses": [],
                },
                "regression": {"enabled": True, "required_regression_pass_versions": 2},
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="status_rules"):
        module.load_regression_rules(config_path)


def test_load_regression_rules_rejects_unknown_top_level_key(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                },
                "matching": {
                    "required_exact_fields": ["affect_project", "environment", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": ["open"],
                    "resolved_statuses": ["resolved"],
                    "resolved_fixed_resolutions": ["fixed"],
                    "wont_fix_resolutions": ["wont fix"],
                    "closed_statuses": ["closed"],
                },
                "regression": {"enabled": True, "required_regression_pass_versions": 2},
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
                "unexpected": True,
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="unexpected"):
        module.load_regression_rules(config_path)


def test_load_regression_rules_rejects_unknown_section_key(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                    "unexpected_field": "boom",
                },
                "matching": {
                    "required_exact_fields": ["affect_project", "environment", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": ["open"],
                    "resolved_statuses": ["resolved"],
                    "resolved_fixed_resolutions": ["fixed"],
                    "wont_fix_resolutions": ["wont fix"],
                    "closed_statuses": ["closed"],
                },
                "regression": {"enabled": True, "required_regression_pass_versions": 2},
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="jira_export"):
        module.load_regression_rules(config_path)


def test_load_regression_rules_rejects_false_section_value(tmp_path, regression_module):
    module = regression_module

    config_path = tmp_path / "regression_rules.json"
    config_path.write_text(
        json.dumps(
            {
                "jira_export": {
                    "enabled": True,
                    "jql": "project = TRANSSION AND statusCategory != Done",
                    "max_results": 100,
                    "fields": ["key", "summary"],
                },
                "matching": {
                    "required_exact_fields": ["affect_project", "environment", "exp_class"],
                    "cause_similarity_threshold": 0.9,
                },
                "status_rules": {
                    "open_like_statuses": ["open"],
                    "resolved_statuses": ["resolved"],
                    "resolved_fixed_resolutions": ["fixed"],
                    "wont_fix_resolutions": ["wont fix"],
                    "closed_statuses": ["closed"],
                },
                "regression": False,
                "output": {
                    "sqlite_path": "result/transsion_regression_cache.db",
                    "excel_summary_dir": "result",
                },
            },
            ensure_ascii=True,
            indent=2,
        ),
        encoding="utf-8",
    )

    with pytest.raises(ValueError, match="regression 必须是对象"):
        module.load_regression_rules(config_path)
