from __future__ import annotations

import importlib
import sys
from pathlib import Path
from typing import Generator

import pandas as pd
import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT

EXPECTED_COLUMNS = [
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


@pytest.fixture
def regression_report_module() -> Generator[object, None, None]:
    module_name = "transsion_regression_report"
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


def test_write_excel_summary_generates_xlsx_with_compatible_columns(
    tmp_path: Path,
    regression_report_module,
):
    module = regression_report_module
    output_file = tmp_path / "summary.xlsx"

    module.write_excel_summary(
        output_file,
        [
            {
                "row_number": 3,
                "matched_jira_key": "TRANSSION-8",
                "matched_status": "Resolved",
                "matched_resolution": "Fixed",
                "fix_version": "V2",
                "action": "OPEN_LIKE_UPDATE",
                "success": 1,
                "manual_review": 0,
                "reason": "命中历史单",
                "old_count": 2,
                "new_count": 3,
                "comment_status": "ADDED",
                "ps_comment_status": "",
                "result_message": "updated",
            }
        ],
    )

    assert output_file.exists()
    payload = pd.read_excel(output_file, engine="openpyxl").fillna("")
    assert list(payload.columns) == EXPECTED_COLUMNS
    assert payload.to_dict(orient="records") == [
        {
            "row_number": 3,
            "matched_jira_key": "TRANSSION-8",
            "matched_status": "Resolved",
            "matched_resolution": "Fixed",
            "fix_version": "V2",
            "action": "OPEN_LIKE_UPDATE",
            "success": 1,
            "manual_review": 0,
            "reason": "命中历史单",
            "old_count": 2,
            "new_count": 3,
            "comment_status": "ADDED",
            "ps_comment_status": "",
            "result_message": "updated",
        }
    ]
