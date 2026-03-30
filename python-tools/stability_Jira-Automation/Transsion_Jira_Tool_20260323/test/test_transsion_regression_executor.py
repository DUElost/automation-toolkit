from __future__ import annotations

import importlib
import sys
from pathlib import Path
from types import SimpleNamespace
from typing import Generator

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


def test_decide_action_returns_open_like_update(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 3, "ps": "note"},
        history={"status": "Open", "resolution": "", "fix_version": ""},
        current_version="V2",
    )

    assert decision.action == "OPEN_LIKE_UPDATE"
    assert decision.update_jira is True
    assert decision.manual_review is False
    assert decision.comment_required is True
    assert decision.recreate_issue is False


def test_decide_action_returns_manual_review_when_resolved_fixed_without_fix_version(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "已修复", "fix_version": ""},
        current_version="V2",
    )

    assert decision.action == "MANUAL_REVIEW"
    assert decision.update_jira is False
    assert decision.manual_review is True
    assert decision.comment_required is False


def test_decide_action_returns_wait_new_version_when_current_version_is_older(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "已修复", "fix_version": "V3"},
        current_version="V2",
    )

    assert decision.action == "RESOLVED_FIXED_WAIT_NEW_VERSION"
    assert decision.update_jira is False
    assert decision.manual_review is False
    assert decision.comment_required is True


def test_decide_action_ignores_fix_version_order_when_selecting_comparison_target(executor_module):
    module = executor_module

    decision_a = module.decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "已修复", "fix_version": "V1, V3"},
        current_version="V2",
    )
    decision_b = module.decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "已修复", "fix_version": "V3, V1"},
        current_version="V2",
    )

    assert decision_a.action == "RESOLVED_FIXED_WAIT_NEW_VERSION"
    assert decision_b.action == "RESOLVED_FIXED_WAIT_NEW_VERSION"
    assert decision_a.action == decision_b.action
    assert decision_a.manual_review is False
    assert decision_b.manual_review is False


def test_decide_action_returns_manual_review_when_current_version_is_empty(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "已修复", "fix_version": "V3"},
        current_version="",
    )

    assert decision.action == "MANUAL_REVIEW"
    assert decision.update_jira is False
    assert decision.manual_review is True
    assert decision.comment_required is False


def test_decide_action_returns_closed_recreate_when_closed_and_not_wont_fix(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 1},
        history={"status": "Closed", "resolution": "Fixed", "fix_version": "V1"},
        current_version="V2",
    )

    assert decision.action == "CLOSED_RECREATE"
    assert decision.update_jira is False
    assert decision.manual_review is False
    assert decision.recreate_issue is True


def test_decide_action_returns_wont_fix_keep(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 1},
        history={"status": "已解决", "resolution": "Won't Fix", "fix_version": "V1"},
        current_version="V2",
    )

    assert decision.action == "WONT_FIX_KEEP"
    assert decision.update_jira is False
    assert decision.manual_review is False
    assert decision.comment_required is True


def test_decide_action_returns_create_new_for_unmatched_history(executor_module):
    module = executor_module

    decision = module.decide_action(
        current_row={"count": 1},
        history={"status": "In Progress", "resolution": "Duplicate", "fix_version": "V1"},
        current_version="V2",
    )

    assert decision.action == "CREATE_NEW"
    assert decision.update_jira is False
    assert decision.manual_review is False
    assert decision.comment_required is False
    assert decision.recreate_issue is True


def test_update_issue_fields_updates_issue_fields(batch_common_module):
    module = batch_common_module

    updated = {}

    class FakeIssue:
        def update(self, fields):
            updated.update(fields)

    class FakeJiraClient:
        def issue(self, issue_key):
            assert issue_key == "TRANSSION-123"
            return FakeIssue()

    module.update_issue_fields(FakeJiraClient(), "TRANSSION-123", {"summary": "New summary"})

    assert updated == {"summary": "New summary"}


def test_add_issue_comment_adds_comment(batch_common_module):
    module = batch_common_module

    comments = []

    class FakeJiraClient:
        def add_comment(self, issue_key, comment):
            comments.append((issue_key, comment))

    module.add_issue_comment(FakeJiraClient(), "TRANSSION-123", "need review")

    assert comments == [("TRANSSION-123", "need review")]
