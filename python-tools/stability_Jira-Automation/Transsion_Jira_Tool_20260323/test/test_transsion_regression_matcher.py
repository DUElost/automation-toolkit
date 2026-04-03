from __future__ import annotations

import importlib
import json
import sys
from pathlib import Path
from types import SimpleNamespace
from typing import Generator

import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def matcher_module() -> Generator[object, None, None]:
    module_name = "transsion_regression_matcher"
    common_module_name = "transsion_batch_jira_common"
    original_path = list(sys.path)
    original_module = sys.modules.get(module_name)
    original_common_module = sys.modules.get(common_module_name)
    sys.modules.pop(module_name, None)
    sys.modules.pop(common_module_name, None)
    try:
        if str(MODULE_DIR) not in sys.path:
            sys.path.insert(0, str(MODULE_DIR))
        yield importlib.import_module(module_name)
    finally:
        if original_module is None:
            sys.modules.pop(module_name, None)
        else:
            sys.modules[module_name] = original_module
        if original_common_module is None:
            sys.modules.pop(common_module_name, None)
        else:
            sys.modules[common_module_name] = original_common_module
        sys.path[:] = original_path


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


def test_normalize_caused_by_removes_line_numbers_and_addresses(matcher_module):
    module = matcher_module

    normalized = module.normalize_caused_by(
        "java.lang.NullPointerException:123 at 0x7fff  caused by  foo  bar"
    )

    assert normalized == "java.lang.NullPointerException at caused by foo bar"


def test_is_strong_match_returns_true_when_exact_fields_match_and_cause_is_similar(matcher_module):
    module = matcher_module

    current = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "NullPointerException:123 at 0x7fff",
    }
    history = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "NullPointerException at 0x1234",
    }

    assert module.is_strong_match(current, history, 0.9) is True


def test_is_strong_match_returns_false_when_cause_similarity_is_below_threshold(matcher_module):
    module = matcher_module

    current = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "NullPointerException at line 123",
    }
    history = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "SocketTimeoutException during upload",
    }

    assert module.is_strong_match(current, history, 0.9) is False


def test_is_strong_match_returns_false_when_caused_by_is_empty(matcher_module):
    module = matcher_module

    current = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "   ",
    }
    history = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "SocketTimeoutException during upload",
    }

    assert module.is_strong_match(current, history, 0.9) is False


@pytest.mark.parametrize(
    "field_name,current_value,history_value",
    [
        ("affect_project", "X6851-P865", "X6726B"),
        ("environment", "PR1-A1", "PR1-B2"),
        ("exp_class", "Crash", "ANR"),
    ],
)
def test_is_strong_match_returns_false_when_any_exact_field_differs(
    matcher_module,
    field_name,
    current_value,
    history_value,
):
    module = matcher_module

    current = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "NullPointerException:123 at 0x7fff",
    }
    history = {
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "NullPointerException at 0x1234",
    }
    current[field_name] = current_value
    history[field_name] = history_value

    assert module.is_strong_match(current, history, 0.9) is False


def test_fetch_issue_snapshot_fields_extracts_core_and_optional_fields(batch_common_module):
    module = batch_common_module

    fake_issue = SimpleNamespace(
        key="TRANSSION-123",
        raw={
            "fields": {
                "summary": "Issue summary",
                "status": {"name": "Resolved"},
                "resolution": {"name": "Fixed"},
                "fixVersions": [{"name": "1.0.1"}],
                "affect_project": "X6851-P865",
                "environment": "PR1-A1",
                "exp_class": "Crash",
                "caused_by": "NullPointerException:123 at 0x7fff",
            }
        },
    )

    class FakeJiraClient:
        def issue(self, issue_key):
            assert issue_key == "TRANSSION-123"
            return fake_issue

    result = module.fetch_issue_snapshot_fields(FakeJiraClient(), "TRANSSION-123")

    assert result == {
        "jira_key": "TRANSSION-123",
        "summary": "Issue summary",
        "status": "Resolved",
        "resolution": "Fixed",
        "fix_version": "1.0.1",
        "affect_project": "X6851-P865",
        "environment": "PR1-A1",
        "exp_class": "Crash",
        "caused_by": "NullPointerException:123 at 0x7fff",
        "raw_payload": json.dumps(fake_issue.raw, ensure_ascii=False),
    }


def test_fetch_issue_snapshot_fields_uses_status_and_resolution_names_from_issue_fields_when_raw_missing(
    batch_common_module,
):
    module = batch_common_module

    fake_issue = SimpleNamespace(
        key="TRANSSION-456",
        raw={"fields": {"summary": "Fallback summary", "fixVersions": []}},
        fields=SimpleNamespace(
            status=SimpleNamespace(name="Open"),
            resolution=SimpleNamespace(name="Won't Fix"),
        ),
    )

    class FakeJiraClient:
        def issue(self, issue_key):
            assert issue_key == "TRANSSION-456"
            return fake_issue

    result = module.fetch_issue_snapshot_fields(FakeJiraClient(), "TRANSSION-456")

    assert result["status"] == "Open"
    assert result["resolution"] == "Won't Fix"


def test_fetch_issue_snapshot_fields_supports_custom_field_mapping(batch_common_module):
    module = batch_common_module

    fake_issue = SimpleNamespace(
        key="TRANSSION-789",
        raw={
            "fields": {
                "summary": "Mapped summary",
                "status": {"name": "Resolved"},
                "resolution": {"name": "Fixed"},
                "customfield_14205": "X6851-P865",
                "customfield_20001": "PR1-A1",
                "customfield_14202": "Crash",
                "customfield_20002": "NullPointerException at 0x7fff",
            }
        },
    )

    class FakeJiraClient:
        def issue(self, issue_key):
            assert issue_key == "TRANSSION-789"
            return fake_issue

    result = module.fetch_issue_snapshot_fields(
        FakeJiraClient(),
        "TRANSSION-789",
        field_mapping={
            "affect_project": "customfield_14205",
            "environment": "customfield_20001",
            "exp_class": "customfield_14202",
            "caused_by": "customfield_20002",
        },
    )

    assert result["affect_project"] == "X6851-P865"
    assert result["environment"] == "PR1-A1"
    assert result["exp_class"] == "Crash"
    assert result["caused_by"] == "NullPointerException at 0x7fff"


def test_fetch_issue_snapshot_fields_normalizes_mapped_option_objects(batch_common_module):
    module = batch_common_module

    fake_issue = SimpleNamespace(
        key="TRANSSION-790",
        raw={
            "fields": {
                "summary": "Mapped summary",
                "status": {"name": "Resolved"},
                "resolution": {"name": "Fixed"},
                "customfield_14205": {"value": "X6851-P865"},
                "customfield_14202": {"name": "ANR"},
                "customfield_14203": {"value": "Input dispatching timed out"},
            }
        },
    )

    class FakeJiraClient:
        def issue(self, issue_key):
            assert issue_key == "TRANSSION-790"
            return fake_issue

    result = module.fetch_issue_snapshot_fields(
        FakeJiraClient(),
        "TRANSSION-790",
        field_mapping={
            "affect_project": "customfield_14205",
            "exp_class": "customfield_14202",
            "caused_by": "customfield_14203",
        },
    )

    assert result["affect_project"] == "X6851-P865"
    assert result["exp_class"] == "ANR"
    assert result["caused_by"] == "Input dispatching timed out"
