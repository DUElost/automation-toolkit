import gc
import json
import os
import sqlite3
import shutil
import sys
import tempfile
import time
import unittest
from pathlib import Path


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from tinno_regression_store import RegressionStore


def _table_columns(db_path: Path, table_name: str):
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        cursor.execute(f"PRAGMA table_info({table_name})")
        return cursor.fetchall()


class TinnoRegressionStoreTest(unittest.TestCase):
    def test_store_creates_build_version_columns(self) -> None:
        temp_dir = tempfile.mkdtemp()
        try:
            db_path = Path(temp_dir) / "regression.db"
            store = RegressionStore(db_path)
            del store
            gc.collect()
            time.sleep(0.05)

            snapshot_columns = [column[1] for column in _table_columns(db_path, "jira_issue_snapshot")]
            issue_state_columns = [column[1] for column in _table_columns(db_path, "issue_state")]

            self.assertIn("build_version", snapshot_columns)
            self.assertIn("build_version", issue_state_columns)
        finally:
            if os.path.exists(temp_dir):
                shutil.rmtree(temp_dir, ignore_errors=True)

    def test_store_migrates_existing_database_without_build_version(self) -> None:
        temp_dir = tempfile.mkdtemp()
        try:
            db_path = Path(temp_dir) / "legacy.db"
            with sqlite3.connect(db_path) as conn:
                cursor = conn.cursor()
                cursor.execute(
                    """
                    CREATE TABLE jira_issue_snapshot (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        run_id TEXT NOT NULL,
                        jira_key TEXT NOT NULL,
                        summary TEXT,
                        status TEXT,
                        resolution TEXT,
                        fix_version TEXT,
                        affect_project TEXT,
                        environment TEXT,
                        exp_class TEXT,
                        caused_by TEXT,
                        raw_payload TEXT
                    )
                    """
                )
                cursor.execute(
                    """
                    CREATE TABLE issue_state (
                        jira_key TEXT PRIMARY KEY,
                        fingerprint TEXT,
                        status TEXT,
                        resolution TEXT,
                        fix_version TEXT,
                        count INTEGER DEFAULT 0,
                        open_seen_count INTEGER DEFAULT 0,
                        regression_pass_count INTEGER DEFAULT 0,
                        verified_versions TEXT DEFAULT '[]',
                        last_seen_version TEXT,
                        updated_at TEXT DEFAULT CURRENT_TIMESTAMP
                    )
                    """
                )
                cursor.execute(
                    """
                    CREATE TABLE execution_results (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        run_id TEXT NOT NULL,
                        row_number INTEGER,
                        matched_jira_key TEXT,
                        fix_version TEXT,
                        action TEXT,
                        success INTEGER,
                        manual_review INTEGER,
                        reason TEXT,
                        result_message TEXT,
                        created_at TEXT DEFAULT CURRENT_TIMESTAMP
                    )
                    """
                )
                cursor.execute(
                    """
                    CREATE TABLE sync_runs (
                        run_id TEXT PRIMARY KEY,
                        started_at TEXT,
                        finished_at TEXT,
                        jql TEXT,
                        current_version TEXT
                    )
                    """
                )
                conn.commit()

            RegressionStore(db_path)

            snapshot_columns = [column[1] for column in _table_columns(db_path, "jira_issue_snapshot")]
            issue_state_columns = [column[1] for column in _table_columns(db_path, "issue_state")]
            self.assertIn("build_version", snapshot_columns)
            self.assertIn("build_version", issue_state_columns)
        finally:
            if os.path.exists(temp_dir):
                shutil.rmtree(temp_dir, ignore_errors=True)

    def test_save_snapshot_and_issue_state_round_trip_build_version(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "regression.db"
            store = RegressionStore(db_path)
            store.save_snapshot(
                "run-001",
                [
                    {
                        "jira_key": "VFFCA-1",
                        "summary": "issue",
                        "status": "Resolved",
                        "resolution": "完成",
                        "fix_version": "V552AA-16-260515V25",
                        "build_version": "V552AA-16-260511V17",
                        "affect_project": "VFFCA",
                        "environment": "env",
                        "exp_class": "Crash",
                        "caused_by": "stack",
                        "raw_payload": '{"key":"VFFCA-1"}',
                    }
                ],
            )

            snapshot_row = store.fetch_snapshot_by_run("run-001")[0]
            self.assertEqual("V552AA-16-260511V17", snapshot_row["build_version"])

            store.upsert_issue_state(
                {
                    "jira_key": "VFFCA-1",
                    "status": "Resolved",
                    "resolution": "完成",
                    "fix_version": "V552AA-16-260515V25",
                    "build_version": "V552AA-16-260511V17",
                    "verified_versions": json.dumps(["V552AA-16-260521V37"], ensure_ascii=True),
                }
            )
            issue_state = store.fetch_issue_state("VFFCA-1")
            self.assertEqual("V552AA-16-260511V17", issue_state["build_version"])

    def test_record_regression_pass_preserves_build_version(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "regression.db"
            store = RegressionStore(db_path)
            store.upsert_issue_state(
                {
                    "jira_key": "VFFCA-2",
                    "status": "Resolved",
                    "resolution": "完成",
                    "fix_version": "V552AA-16-260515V25",
                    "build_version": "V552AA-16-260511V17",
                    "verified_versions": ["V552AA-16-260519V22"],
                }
            )

            store.record_regression_pass(
                "VFFCA-2",
                "V552AA-16-260521V37",
                2,
            )

            issue_state = store.fetch_issue_state("VFFCA-2")
            self.assertEqual("V552AA-16-260511V17", issue_state["build_version"])
            self.assertIn("V552AA-16-260521V37", json.loads(issue_state["verified_versions"]))


if __name__ == "__main__":
    unittest.main()
