from __future__ import annotations

import importlib
import sys
from pathlib import Path
from typing import Generator

import pandas as pd
import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def upload_template_module() -> Generator[object, None, None]:
    module_name = "transsion_upload_template_common"
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


def test_prepare_issue_record_includes_caused_by_column(upload_template_module):
    module = upload_template_module
    raw_row = pd.Series(
        {
            "Id": "1",
            "Path": "server/path",
            "Version": "X6851-16.3.0.021(OP001PF001AZ)_SU",
            "ExpTime": "2026-04-01 10:00:00",
            "ExpClass": "ANR",
            "ExpType ": "ANR",
            "CurProcess": "com.android.systemui",
            "Package": "com.android.systemui",
            "Detail": "detail",
            "CausedBy": "Input dispatching timed out",
            "Count": 1,
            "Device Count": 1,
        }
    )

    result = module.prepare_issue_record(
        raw_row=raw_row,
        test_case="休眠唤醒专项",
        defaults={
            "project_key": "X6851OS16",
            "issue_type": "故障",
            "default_reporter": "reporter",
            "default_assignee": "assignee",
            "default_issue_source": "内测 (自动化测试)",
            "default_issue_category": "Stability",
            "default_issue_nature": "New issues",
            "default_clients": ["H5"],
            "default_fix_way": "修改代码",
            "default_focus": "None",
            "default_importance": "中",
            "default_security_level": "ODM项目",
            "default_team_tag": "天珑团队",
            "default_bug_tag": "BUG",
            "default_category_tag": "稳定性专项",
            "default_preconditions": "/",
            "default_ref_result": "无需对比",
            "default_accessories": "无",
            "default_recovery": "不涉及恢复",
        },
        project_key_mapping={"X6851": "X6851OS16"},
        affect_project_value_mapping={"X6851": "X6851-P865"},
        monkey_project_mapping={},
        severity_to_priority_mapping={"C": "重要"},
        severity_rules=[{"keyword": "ANR", "level": "C", "operator": ">=", "threshold": 1}],
        probability_rating_mapping={"once": {"title_phrase": "小概率", "add_occasional_tag": True}},
        test_case_summary_mapping={"休眠唤醒专项": {"total_runs": 20, "preconditions": "执行休眠唤醒专项"}},
        package_owner_mapping={"com.android.systemui": {"component": "NavigationBar", "owner": "owner"}},
        regex_mapping=[],
        summary_tags=["OP", "Alpha"],
        default_affect_project="X6851",
        environment_override=None,
        default_case_no="NA",
        default_reporter="reporter",
        default_assignee="assignee",
    )

    assert result["CausedBy"] == "Input dispatching timed out"
