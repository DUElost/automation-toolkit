import importlib.util
import gc
import json
import sqlite3
import sys
import tempfile
import time
import unittest
from pathlib import Path

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parents[1]
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from tinno_database_manager import DatabaseManager
from tinno_regression_store import RegressionStore


def load_batch_entry_module():
    module_path = TOOL_DIR / "create_tinno_jira_batch_from_excel.py"
    spec = importlib.util.spec_from_file_location("tinno_batch_entry_project_db_test", module_path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


def _table_columns(db_path: Path, table_name: str):
    with sqlite3.connect(db_path) as conn:
        cursor = conn.cursor()
        cursor.execute(f"PRAGMA table_info({table_name})")
        return cursor.fetchall()


def _close_db(db: DatabaseManager) -> None:
    db.close()
    gc.collect()
    time.sleep(0.05)


class TinnoProjectHistoryDbTest(unittest.TestCase):
    def setUp(self) -> None:
        self.module = load_batch_entry_module()

    def test_build_project_history_db_path_defaults_to_regression_cache_db(self) -> None:
        resolved = self.module.build_project_history_db_path(
            "https://jira.tinno.com",
            "VFFCA",
        )

        self.assertEqual(
            self.module.CURRENT_DIR / "result" / "tinno_regression_cache" / "VFFCA.db",
            resolved,
        )

    def test_build_project_history_db_path_accepts_explicit_cache_setting(self) -> None:
        resolved = self.module.build_project_history_db_path(
            "https://jira.tinno.com",
            "VFFCA",
            sqlite_path_setting="result/custom_cache",
        )

        self.assertEqual(
            self.module.CURRENT_DIR / "result" / "custom_cache" / "VFFCA.db",
            resolved,
        )

    def test_database_manager_supports_build_version_column(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "tinno_VFFCA.db"
            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            try:
                columns = [column[1] for column in _table_columns(db_path, "jira_issues_main")]
                self.assertIn("build_version", columns)

                db.insert_issue(
                    {
                        "jira_key": "VFFCA-100",
                        "status": "Open",
                        "summary": "summary",
                        "normalized_summary": "summary",
                        "test_environment": "",
                        "raw_caused_by": "",
                        "assignee": "dai.lv",
                        "bug_severity": "B",
                        "priority": "Medium",
                        "description": "desc",
                        "resolution": "",
                        "package_name": "pkg",
                        "exp_class": "Crash",
                        "exp_type": "",
                        "cur_process": "",
                        "version": "V552AA-16-260521V37",
                        "count": 1,
                        "device_count": 1,
                        "source_file": "",
                        "raw_data": {},
                        "fix_version": "",
                        "build_version": "V552AA-16-260511V17",
                        "regression_pass_count": 0,
                        "verified_versions": [],
                    }
                )
                row = db.get_issue_by_key("VFFCA-100")
                self.assertEqual("V552AA-16-260511V17", row["build_version"])
            finally:
                _close_db(db)

    def test_migrate_legacy_project_history_db_copies_existing_issue_rows_once(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            legacy_db_path = temp_path / "db" / "tinno_VFFCA.db"
            merged_db_path = temp_path / "result" / "tinno_regression_cache" / "VFFCA.db"

            legacy_db = DatabaseManager({"type": "sqlite", "path": str(legacy_db_path)})
            try:
                legacy_db.insert_issue(
                    {
                        "jira_key": "VFFCA-105",
                        "status": "Open",
                        "summary": "summary",
                        "normalized_summary": "summary",
                        "test_environment": "",
                        "raw_caused_by": "",
                        "assignee": "dai.lv",
                        "bug_severity": "B",
                        "priority": "Medium",
                        "description": "desc",
                        "resolution": "",
                        "package_name": "pkg",
                        "exp_class": "Crash",
                        "exp_type": "",
                        "cur_process": "",
                        "version": "V552AA-16-260521V37",
                        "count": 1,
                        "device_count": 1,
                        "source_file": "",
                        "raw_data": {},
                        "fix_version": "",
                        "build_version": "V552AA-16-260511V17",
                        "regression_pass_count": 0,
                        "verified_versions": [],
                    }
                )
            finally:
                _close_db(legacy_db)

            merged_db = DatabaseManager({"type": "sqlite", "path": str(merged_db_path)})
            try:
                migrated_count = self.module.migrate_legacy_project_history_db(merged_db, legacy_db_path)
                repeated_count = self.module.migrate_legacy_project_history_db(merged_db, legacy_db_path)
                row = merged_db.get_issue_by_key("VFFCA-105")
                all_rows = merged_db.execute("SELECT jira_key FROM jira_issues_main WHERE jira_key = ?", ("VFFCA-105",))
            finally:
                _close_db(merged_db)

            self.assertEqual(1, migrated_count)
            self.assertEqual(0, repeated_count)
            self.assertIsNotNone(row)
            self.assertEqual("V552AA-16-260511V17", row["build_version"])
            self.assertEqual(1, len(all_rows))

    def test_merge_history_prefers_project_db_build_version_over_snapshot(self) -> None:
        history_row = {
            "jira_key": "VFFCA-101",
            "status": "Resolved",
            "resolution": "完成",
            "fix_version": "V552AA-16-260515V25",
            "build_version": "",
        }
        issue_state = {"build_version": ""}
        project_db_row = {"build_version": "V552AA-16-260511V17"}

        merged = self.module.merge_history_sources(history_row, issue_state, project_db_row)

        self.assertEqual("V552AA-16-260511V17", merged["build_version"])

    def test_backfill_issue_state_from_project_history_repairs_stale_build_version(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "VFFCA.db"
            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            store = RegressionStore(db_path)
            try:
                db.insert_issue(
                    {
                        "jira_key": "VFFCA-106",
                        "status": "Open",
                        "summary": "summary",
                        "normalized_summary": "summary",
                        "test_environment": "",
                        "raw_caused_by": "",
                        "assignee": "dai.lv",
                        "bug_severity": "B",
                        "priority": "Medium",
                        "description": "desc",
                        "resolution": "",
                        "package_name": "pkg",
                        "exp_class": "Crash",
                        "exp_type": "",
                        "cur_process": "",
                        "version": "V552AA-16-260521V37",
                        "count": 1,
                        "device_count": 1,
                        "source_file": "",
                        "raw_data": {},
                        "fix_version": "V552AA-16-260515V25",
                        "build_version": "V552AA-16-260511V17",
                        "regression_pass_count": 1,
                        "verified_versions": ["V552AA-16-260519V22"],
                    }
                )
                store.upsert_issue_state(
                    {
                        "jira_key": "VFFCA-106",
                        "status": "Open",
                        "resolution": "",
                        "fix_version": "",
                        "build_version": "recognizeexception",
                        "regression_pass_count": 0,
                        "verified_versions": [],
                        "last_seen_version": "V551A-15-250905V60",
                    }
                )

                repaired_count = self.module.backfill_issue_state_from_project_history(store, db)
                issue_state = store.fetch_issue_state("VFFCA-106")
            finally:
                _close_db(db)

            self.assertEqual(1, repaired_count)
            self.assertEqual("V552AA-16-260511V17", issue_state["build_version"])
            self.assertEqual("V552AA-16-260515V25", issue_state["fix_version"])
            self.assertEqual("V552AA-16-260521V37", issue_state["last_seen_version"])
            self.assertEqual(1, issue_state["regression_pass_count"])
            self.assertIn("V552AA-16-260519V22", json.loads(issue_state["verified_versions"]))

    def test_sync_created_issue_to_project_history_db_writes_build_version(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "tinno_VFFCA.db"
            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            try:
                regression_row = {
                    "summary": "summary",
                    "description": "desc",
                    "project": "VFFCA",
                    "affect_project": "VFFCA",
                    "environment": "",
                    "exp_class": "Crash",
                    "caused_by": "stack",
                    "current_version": "V552AA-16-260521V37",
                    "build_version": "V552AA-16-260511V17",
                }

                self.module.sync_issue_to_project_history_db(
                    project_db=db,
                    jira_key="VFFCA-102",
                    regression_row=regression_row,
                    status="Open",
                    resolution="",
                    fix_version="",
                )

                row = db.get_issue_by_key("VFFCA-102")
                self.assertEqual("V552AA-16-260511V17", row["build_version"])
                self.assertEqual("V552AA-16-260521V37", row["version"])
            finally:
                _close_db(db)

    def test_sync_created_issue_to_project_history_db_persists_upload_context(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "tinno_VFFCA.db"
            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            try:
                regression_row = {
                    "summary": "[自动化][V552AA][Total Number 75][MLD-LX2-16-260518V3][MonkeyAEE][Java (JE)]com.android.wallpaper发生Java (JE)",
                    "description": "【备注】版本：MLD-LX2-16-260518V3_Daily_user_202605180930_FLASH",
                    "project": "VFFCA",
                    "affect_project": "VFFCA",
                    "environment": "*Package:* com.android.wallpaper\n*ExpClass:* Java (JE)\n*ExpType:* Crash\n*CurProcess:* com.android.wallpaper",
                    "exp_class": "Java (JE)",
                    "caused_by": "java.lang.RuntimeException: test",
                    "current_version": "MLD-LX2-16-260518V3_Daily_user_202605180930_FLASH",
                    "build_version": "MLD-LX2-16-260518V3_Daily_user_202605180930_FLASH",
                    "ps": "日志地址: 220.175.120.251/xx",
                }
                source_row = pd.Series(
                    {
                        "Project": "VFFCA",
                        "Issue Type": "Bug",
                        "Summary": regression_row["summary"],
                        "Assignee": "dai.lv",
                        "Module": "AUTOTEST",
                        "Priority": "Medium",
                        "Description": regression_row["description"],
                        "key_information": regression_row["caused_by"],
                        "Environment": regression_row["environment"],
                        "PS": regression_row["ps"],
                        "Bug Severity": "B",
                        "Previous Version Status": "Previous version exists",
                    }
                )

                self.module.sync_issue_to_project_history_db(
                    project_db=db,
                    jira_key="VFFCA-103",
                    source_row=source_row,
                    regression_row=regression_row,
                    status="Open",
                    resolution="",
                    fix_version="",
                )

                row = db.get_issue_by_key("VFFCA-103")
                self.assertEqual("dai.lv", row["assignee"])
                self.assertEqual("B", row["bug_severity"])
                self.assertEqual("Medium", row["priority"])
                self.assertEqual("com.android.wallpaper", row["package_name"])
                self.assertEqual("Crash", row["exp_type"])
                self.assertEqual("com.android.wallpaper", row["cur_process"])

                raw_data = json.loads(row["raw_data"])
                self.assertEqual("VFFCA", raw_data["project"])
                self.assertEqual("AUTOTEST", raw_data["upload_row"]["Module"])
                self.assertEqual("日志地址: 220.175.120.251/xx", raw_data["upload_row"]["PS"])
            finally:
                _close_db(db)

    def test_sync_created_issue_uses_effective_issue_fields_assignee_when_provided(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "tinno_VFFCA.db"
            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            try:
                regression_row = {
                    "summary": "summary",
                    "description": "desc",
                    "project": "VFFCA",
                    "affect_project": "VFFCA",
                    "environment": "*Package:* com.ape.soundrecorder\n*ExpClass:* Java (JE)\n*ExpType:* system_app_crash\n*CurProcess:* com.ape.soundrecorder",
                    "exp_class": "Java (JE)",
                    "caused_by": "stack",
                    "current_version": "MLD-LX2-16-260518V3",
                    "build_version": "MLD-LX2-16-260518V3",
                }
                source_row = pd.Series(
                    {
                        "Assignee": "tao.wang1",
                        "Bug Severity": "A",
                        "Priority": "High",
                    }
                )

                self.module.sync_issue_to_project_history_db(
                    project_db=db,
                    jira_key="VFFCA-104",
                    source_row=source_row,
                    regression_row=regression_row,
                    status="Open",
                    resolution="",
                    fix_version="",
                    assignee_fallback_used=True,
                    effective_issue_fields={
                        "project": {"key": "VFFCA"},
                        "issuetype": {"name": "Bug"},
                        "summary": "summary",
                    },
                )

                row = db.get_issue_by_key("VFFCA-104")
                self.assertIsNone(row["assignee"])
            finally:
                _close_db(db)


if __name__ == "__main__":
    unittest.main()
