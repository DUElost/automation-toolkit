from __future__ import annotations

import importlib
import logging
import sys
from pathlib import Path
from typing import Generator

import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def batch_common_module() -> Generator[object, None, None]:
    module_name = "transsion_batch_jira_common"
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


class _FakeProject:
    key = "TRANSSION"


class _FakeJira:
    def project(self, _text):
        return _FakeProject()

    def search_users(self, *args, **kwargs):
        return []


def _make_row(**overrides):
    row = {
        "Project": "TRANSSION",
        "Issue Type": "故障",
        "Summary": "test summary",
        "Description": "test desc",
        "Priority": "重要",
        "Components": "NavigationBar",
        "Versions": "V10",
        "Environment": "userdebug",
        "CausedBy": "Input dispatching timed out",
        "Reporter": "reporter",
        "Assignee": "assignee",
    }
    row.update(overrides)
    return row


def _make_defaults():
    return {
        "project_key": "TRANSSION",
        "issue_type": "故障",
        "default_reporter": "reporter",
        "default_assignee": "assignee",
        "field_ids": {"caused_by": "customfield_14203"},
    }


def test_build_issue_fields_falls_back_to_odm_component_when_components_invalid(batch_common_module):
    module = batch_common_module

    issue_fields = module.build_issue_fields(
        jira_client=_FakeJira(),
        row=_make_row(),
        defaults=_make_defaults(),
        create_fields={},
        allowed_values={
            "components": {
                "Audio": {"name": "Audio"},
                "ODM处理": {"name": "ODM处理"},
            },
            "versions": {"V10": {"name": "V10"}},
            "priority": {"重要": {"name": "重要"}},
        },
        severity_to_priority_mapping={},
        priority_alias_mapping={},
        user_cache={},
        project_cache={},
        create_assignee_override=None,
    )

    assert issue_fields["components"] == [{"name": "ODM处理"}]


def test_build_issue_fields_logs_versions_metadata_when_validation_fails(
    batch_common_module,
    caplog: pytest.LogCaptureFixture,
):
    module = batch_common_module

    caplog.set_level(logging.ERROR)

    with pytest.raises(ValueError, match="Versions 存在无效值"):
        module.build_issue_fields(
            jira_client=_FakeJira(),
            row=_make_row(Components="Audio", Versions="UNKNOWN"),
            defaults=_make_defaults(),
            create_fields={},
            allowed_values={
                "components": {
                    "Audio": {"name": "Audio"},
                    "ODM处理": {"name": "ODM处理"},
                },
                "versions": {"V10": {"name": "V10"}},
                "priority": {"重要": {"name": "重要"}},
            },
            severity_to_priority_mapping={},
            priority_alias_mapping={},
            user_cache={},
            project_cache={},
            create_assignee_override=None,
        )

    assert "Versions 校验失败" in caplog.text
    assert "project=TRANSSION" in caplog.text
    assert "issue_type=故障" in caplog.text
    assert "submitted=['UNKNOWN']" in caplog.text
    assert "allowed_sample=['V10']" in caplog.text


def test_build_issue_fields_reports_original_component_and_odm_fallback_failure(batch_common_module):
    module = batch_common_module

    with pytest.raises(ValueError, match="NavigationBar.*ODM处理"):
        module.build_issue_fields(
            jira_client=_FakeJira(),
            row=_make_row(),
            defaults=_make_defaults(),
            create_fields={},
            allowed_values={
                "components": {
                    "Audio": {"name": "Audio"},
                },
                "versions": {"V10": {"name": "V10"}},
                "priority": {"重要": {"name": "重要"}},
            },
            severity_to_priority_mapping={},
            priority_alias_mapping={},
            user_cache={},
            project_cache={},
            create_assignee_override=None,
        )


def test_build_issue_fields_writes_caused_by_custom_field(batch_common_module):
    module = batch_common_module

    issue_fields = module.build_issue_fields(
        jira_client=_FakeJira(),
        row=_make_row(Components="Audio"),
        defaults=_make_defaults(),
        create_fields={"customfield_14203": {"name": "CausedBy"}},
        allowed_values={
            "components": {
                "Audio": {"name": "Audio"},
                "ODM处理": {"name": "ODM处理"},
            },
            "versions": {"V10": {"name": "V10"}},
            "priority": {"重要": {"name": "重要"}},
        },
        severity_to_priority_mapping={},
        priority_alias_mapping={},
        user_cache={},
        project_cache={},
        create_assignee_override=None,
    )

    assert issue_fields["customfield_14203"] == "Input dispatching timed out"


def test_build_issue_fields_uses_create_reporter_override_for_reporter_and_opener(batch_common_module):
    module = batch_common_module

    issue_fields = module.build_issue_fields(
        jira_client=_FakeJira(),
        row=_make_row(Components="Audio", Reporter="template.reporter", Opener="template.opener"),
        defaults={
            **_make_defaults(),
            "field_ids": {"opener": "customfield_10000"},
        },
        create_fields={"customfield_10000": {"name": "Opener"}},
        allowed_values={
            "components": {
                "Audio": {"name": "Audio"},
                "ODM处理": {"name": "ODM处理"},
            },
            "versions": {"V10": {"name": "V10"}},
            "priority": {"重要": {"name": "重要"}},
        },
        severity_to_priority_mapping={},
        priority_alias_mapping={},
        user_cache={},
        project_cache={},
        create_assignee_override=None,
        create_reporter_override="qimingwang.tinno",
    )

    assert issue_fields["reporter"] == {"name": "qimingwang.tinno"}
    assert issue_fields["customfield_10000"] == {"name": "qimingwang.tinno"}
