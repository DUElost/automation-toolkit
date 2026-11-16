from __future__ import annotations

import importlib
import sys
from pathlib import Path
from types import SimpleNamespace
from typing import Generator

import pandas as pd
import pytest
from unittest import mock


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def generate_module() -> Generator[object, None, None]:
    module_name = "generate_transsion_jira_upload_list"
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


def test_save_upload_list_keeps_caused_by_column(tmp_path: Path, generate_module):
    module = generate_module
    output_path = tmp_path / "upload.xlsx"

    module.save_upload_list(
        [
            {
                "Project": "X6851OS16",
                "Issue Type": "故障",
                "Summary": "summary",
                "CausedBy": "Input dispatching timed out",
            }
        ],
        str(output_path),
    )

    df = pd.read_excel(output_path, engine="openpyxl")

    assert "CausedBy" in df.columns
    assert df.loc[0, "CausedBy"] == "Input dispatching timed out"


def _make_args(assignee_auto: bool, assignee_manual: bool) -> SimpleNamespace:
    return SimpleNamespace(
        config_file="config/transsion_jira_defaults.json",
        main_excel_path="result.xls",
        affect_project_mapping_file="config/affect_project_mapping.json",
        package_mapping_file="config/包名与模块&经办人对应表_transsion.xlsx",
        severity_rules_file="config/问题等级定级表.xls",
        probability_rules_file="config/问题出现概率评级表.xlsx",
        test_summary_file="config/稳定性专项汇总.xlsx",
        component_regex_file="config/backup/包名与compent 对应_Transsion.txt",
        project_key=None,
        affect_project=None,
        assignee=None,
        summary_tags=["OP"],
        environment="PR1-A1",
        case_no="NA",
        reporter=None,
        test_case="休眠唤醒专项",
        assignee_auto=assignee_auto,
        assignee_manual=assignee_manual,
    )


def _build_rows(generate_module, args, main_df):
    module = generate_module
    module.read_excel_smart = lambda _: main_df
    module.load_test_case_summary = lambda _: {"休眠唤醒专项": {"total_runs": 20, "preconditions": "/"}}
    module.load_defaults = lambda _: {"project_key": "X6851OS16", "default_assignee": "assignee"}
    module.load_package_owner_mapping = lambda _: {
        "com.android.systemui": {"component": "NavigationBar", "owner": "owner"}
    }
    module.load_affect_project_mapping = lambda _: {}
    module.load_priority_mapping_from_rules_excel = lambda _: {"severity_to_priority": {}, "priority_aliases": {}}
    module.load_component_regex_mapping = lambda _: []
    module.load_severity_rules = lambda _: []
    module.load_probability_rating_mapping = lambda _: {}
    return module.build_upload_rows(args)


def test_build_upload_rows_assignee_auto_mode(generate_module):
    module = generate_module
    main_df = pd.DataFrame(
        [
            {"ExpClass": "ANR", "Package": "com.android.systemui", "Version": "X6851-16.3.0.021", "Count": 1},
            {"ExpClass": "NE", "Package": "com.android.phone", "Version": "X6851-16.3.0.021", "Count": 1},
        ]
    )
    rows, _, skipped = _build_rows(generate_module, _make_args(assignee_auto=True, assignee_manual=False), main_df)

    assert skipped == []
    assert len(rows) == 2
    assert all(str(row["Assignee"]) == "自动" for row in rows)
    assert rows[0]["Assignee"] == "自动"


def test_build_upload_rows_assignee_manual_mode_keeps_owner(generate_module):
    module = generate_module
    main_df = pd.DataFrame(
        [
            {"ExpClass": "ANR", "Package": "com.android.systemui", "Version": "X6851-16.3.0.021", "Count": 1},
        ]
    )
    rows, _, skipped = _build_rows(generate_module, _make_args(assignee_auto=False, assignee_manual=True), main_df)

    assert skipped == []
    assert len(rows) == 1
    assert rows[0]["Assignee"] == "owner"


def test_build_upload_rows_assignee_manual_mode_skips_empty_owner(generate_module):
    module = generate_module
    main_df = pd.DataFrame(
        [
            {"ExpClass": "ANR", "Package": "com.android.systemui", "Version": "X6851-16.3.0.021", "Count": 1},
            {"ExpClass": "NE", "Package": "com.android.phone", "Version": "X6851-16.3.0.021", "Count": 1},
        ]
    )
    rows, _, skipped = _build_rows(generate_module, _make_args(assignee_auto=False, assignee_manual=True), main_df)

    assert len(rows) == 1
    assert rows[0]["Assignee"] == "owner"
    assert len(skipped) == 1
    assert skipped[0]["row_number"] == "2"
    assert skipped[0]["package"] == "com.android.phone"
    assert "未匹配到经办人" in skipped[0]["reason"]


def test_parse_args_requires_exactly_one_assignee_mode(generate_module):
    module = generate_module
    with pytest.raises(SystemExit):
        module.parse_args([])
    with pytest.raises(SystemExit):
        module.parse_args(["--assignee-auto", "--assignee-manual"])


def test_parse_args_accepts_each_assignee_mode(generate_module):
    module = generate_module
    auto_args = module.parse_args(["--assignee-auto"])
    manual_args = module.parse_args(["--assignee-manual"])
    assert auto_args.assignee_auto is True
    assert auto_args.assignee_manual is False
    assert manual_args.assignee_auto is False
    assert manual_args.assignee_manual is True

def test_main_writes_workspace_list_and_attribution_artifact(tmp_path: Path, generate_module):
    module = generate_module
    manifest = {
        "schema": "stp.jira_delivery_input/v1",
        "plan_run_id": 1096,
        "platform": "mtk",
        "delivery_version_id": 4,
        "delivery_version_no": 2,
        "issue_ids": [7],
        "issues": [{"signature_id": 7, "occurrence_ids": [101, 102]}],
        "attribution_candidates": [
            {"signature_id": 7, "occurrence_id": 101, "occurrence_key": "k101"},
            {"signature_id": 7, "occurrence_id": 102, "occurrence_key": "k102"},
        ],
    }
    (tmp_path / "manifest.json").write_text(__import__("json").dumps(manifest), encoding="utf-8")
    args = _make_args(assignee_auto=True, assignee_manual=False)
    args.output_path = None
    args.output_dir = str(tmp_path)
    args.attribution_manifest = str(tmp_path / "manifest.json")
    row = {
        "Project": "X6851OS16",
        "Issue Type": "故障",
        "Summary": "summary",
        "Count": 2,
        "_raw_signature": 7,
        "_raw_occurrence_ids": "[101,102]",
        "_excel_row": 2,
    }

    with mock.patch.object(module, "setup_logging"):
        with mock.patch.object(module, "parse_args", return_value=args):
            with mock.patch.object(module, "build_upload_rows", return_value=([row], ["Monkey专项"], [])):
                assert module.main() == 0

    workbooks = list(tmp_path.glob("JIRA_Upload_List_Transsion_*.xlsx"))
    assert len(workbooks) == 1
    payload = pd.read_excel(workbooks[0])
    assert list(payload["Occurrence IDs"]) == ["[101, 102]"]
    artifact = tmp_path / "attribution_input.json"
    assert artifact.is_file()
    assert '"stage": "generate"' in artifact.read_text(encoding="utf-8")
