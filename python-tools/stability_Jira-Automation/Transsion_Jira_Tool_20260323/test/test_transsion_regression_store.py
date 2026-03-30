from __future__ import annotations

import json
import importlib
import sqlite3
import sys
from pathlib import Path

import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def regression_store_module():
    module_name = "transsion_regression_store"
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


def _table_columns(db_path: Path, table_name: str):
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        cursor.execute(f"PRAGMA table_info({table_name})")
        return cursor.fetchall()


def _table_names(db_path: Path):
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        cursor.execute(
            "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name"
        )
        return [row[0] for row in cursor.fetchall() if row[0] != "sqlite_sequence"]


def test_store_creates_minimal_schema_and_defaults(tmp_path, regression_store_module):
    module = regression_store_module
    db_path = tmp_path / "regression.db"

    module.RegressionStore(db_path)

    assert _table_names(db_path) == [
        "execution_results",
        "issue_state",
        "jira_issue_snapshot",
        "sync_runs",
    ]

    snapshot_columns = _table_columns(db_path, "jira_issue_snapshot")
    assert [column[1] for column in snapshot_columns] == [
        "id",
        "run_id",
        "jira_key",
        "summary",
        "status",
        "resolution",
        "fix_version",
        "affect_project",
        "environment",
        "exp_class",
        "caused_by",
        "raw_payload",
    ]
    assert snapshot_columns[1][3] == 1

    issue_state_columns = _table_columns(db_path, "issue_state")
    assert [column[1] for column in issue_state_columns] == [
        "jira_key",
        "fingerprint",
        "status",
        "resolution",
        "fix_version",
        "count",
        "open_seen_count",
        "regression_pass_count",
        "verified_versions",
        "last_seen_version",
        "updated_at",
    ]
    assert issue_state_columns[0][5] == 1
    assert issue_state_columns[8][4] == "'[]'"
    assert issue_state_columns[10][4] == "CURRENT_TIMESTAMP"

    execution_columns = _table_columns(db_path, "execution_results")
    assert [column[1] for column in execution_columns] == [
        "id",
        "run_id",
        "row_number",
        "matched_jira_key",
        "fix_version",
        "action",
        "success",
        "manual_review",
        "reason",
        "result_message",
        "created_at",
    ]
    assert execution_columns[1][3] == 1
    assert execution_columns[10][4] == "CURRENT_TIMESTAMP"

    sync_columns = _table_columns(db_path, "sync_runs")
    assert [column[1] for column in sync_columns] == [
        "run_id",
        "started_at",
        "finished_at",
        "jql",
        "current_version",
    ]
    assert sync_columns[0][5] == 1


def test_save_snapshot_and_fetch_snapshot_by_run_round_trips_rows(tmp_path, regression_store_module):
    module = regression_store_module
    db_path = tmp_path / "regression.db"
    store = module.RegressionStore(db_path)

    rows = [
        {
            "jira_key": "TRANSSION-1",
            "summary": "First issue",
            "status": "Open",
            "resolution": "",
            "fix_version": "1.0.0",
            "affect_project": "X",
            "environment": "prod",
            "exp_class": "crash",
            "caused_by": "NullPointer",
            "raw_payload": '{"key":"TRANSSION-1"}',
        }
    ]

    store.save_snapshot("run-001", rows)
    fetched = store.fetch_snapshot_by_run("run-001")

    assert fetched == [
        {
            "run_id": "run-001",
            "jira_key": "TRANSSION-1",
            "summary": "First issue",
            "status": "Open",
            "resolution": "",
            "fix_version": "1.0.0",
            "affect_project": "X",
            "environment": "prod",
            "exp_class": "crash",
            "caused_by": "NullPointer",
            "raw_payload": '{"key":"TRANSSION-1"}',
        }
    ]


@pytest.mark.parametrize("row", [{}, {"jira_key": "   "}])
def test_save_snapshot_rejects_missing_or_blank_jira_key(tmp_path, regression_store_module, row):
    module = regression_store_module
    db_path = tmp_path / "regression.db"
    store = module.RegressionStore(db_path)

    with pytest.raises(ValueError, match="jira_key"):
        store.save_snapshot("run-002", [row])


def test_upsert_issue_state_preserves_existing_values_and_serializes_verified_versions(tmp_path, regression_store_module):
    module = regression_store_module
    db_path = tmp_path / "regression.db"
    store = module.RegressionStore(db_path)

    store.upsert_issue_state(
        {
            "jira_key": "TRANSSION-2",
            "fingerprint": "fp-1",
            "status": "Open",
            "resolution": "",
            "fix_version": "1.0.0",
            "count": 1,
            "open_seen_count": 1,
            "regression_pass_count": 0,
            "verified_versions": ["1.0.0"],
            "last_seen_version": "1.0.0",
        }
    )
    first_row = store.fetch_issue_state("TRANSSION-2")
    store.upsert_issue_state(
        {
            "jira_key": "TRANSSION-2",
            "fingerprint": "fp-2",
            "status": "Resolved",
            "resolution": "Fixed",
            "fix_version": "1.1.0",
            "verified_versions": json.dumps(["1.0.0", "1.1.0"], ensure_ascii=True),
            "last_seen_version": "1.1.0",
        }
    )

    fetched = store.fetch_issue_state("TRANSSION-2")

    assert fetched == {
        "jira_key": "TRANSSION-2",
        "fingerprint": "fp-2",
        "status": "Resolved",
        "resolution": "Fixed",
        "fix_version": "1.1.0",
        "count": 1,
        "open_seen_count": 1,
        "regression_pass_count": 0,
        "verified_versions": json.dumps(["1.0.0", "1.1.0"], ensure_ascii=True),
        "last_seen_version": "1.1.0",
        "updated_at": first_row["updated_at"],
    }


def test_save_execution_result_and_fetch_execution_results_by_run(tmp_path, regression_store_module):
    module = regression_store_module
    db_path = tmp_path / "regression.db"
    store = module.RegressionStore(db_path)

    store.save_execution_result(
        {
            "run_id": "run-200",
            "row_number": 7,
            "matched_jira_key": "TRANSSION-9",
            "fix_version": "1.2.0",
            "action": "CREATE_NEW",
            "success": 1,
            "manual_review": 0,
            "reason": "No strong match",
            "result_message": "created",
        }
    )

    fetched = store.fetch_execution_results_by_run("run-200")

    assert len(fetched) == 1
    assert fetched[0]["run_id"] == "run-200"
    assert fetched[0]["row_number"] == 7
    assert fetched[0]["matched_jira_key"] == "TRANSSION-9"
    assert fetched[0]["fix_version"] == "1.2.0"
    assert fetched[0]["action"] == "CREATE_NEW"
    assert fetched[0]["success"] == 1
    assert fetched[0]["manual_review"] == 0
    assert fetched[0]["reason"] == "No strong match"
    assert fetched[0]["result_message"] == "created"
    assert fetched[0]["created_at"]


def test_save_sync_run_patch_keeps_existing_values(tmp_path, regression_store_module):
    module = regression_store_module
    db_path = tmp_path / "regression.db"
    store = module.RegressionStore(db_path)

    store.save_sync_run(
        {
            "run_id": "run-300",
            "started_at": "2026-03-29T10:00:00",
            "jql": "project = TRANSSION",
            "current_version": "1.2.3",
        }
    )
    store.save_sync_run(
        {
            "run_id": "run-300",
            "finished_at": "2026-03-29T10:30:00",
        }
    )

    fetched = store.fetch_sync_run("run-300")

    assert fetched == {
        "run_id": "run-300",
        "started_at": "2026-03-29T10:00:00",
        "finished_at": "2026-03-29T10:30:00",
        "jql": "project = TRANSSION",
        "current_version": "1.2.3",
    }
