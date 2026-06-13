import importlib.util
import json
import tempfile
import unittest
from argparse import Namespace
from pathlib import Path
from types import SimpleNamespace
from unittest import mock

import pandas as pd

from tinno_database_manager import DatabaseManager


TOOL_DIR = Path(__file__).resolve().parent.parent


def load_batch_entry_module():
    module_path = TOOL_DIR / "create_tinno_jira_batch_from_excel.py"
    spec = importlib.util.spec_from_file_location("tinno_batch_entry_create_only_test", module_path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class _FakeCreateOnlyJira:
    auth_mode = "cookie"

    def __init__(self) -> None:
        self.created_payloads = []
        self.closed = False

    def current_user(self):
        return "dai.lv"

    def create_issue(self, fields):
        self.created_payloads.append(fields)
        return {"key": "VFFCA-200"}

    def close(self):
        self.closed = True
        return None


class TinnoCreateOnlyEntryTest(unittest.TestCase):
    def setUp(self) -> None:
        self.module = load_batch_entry_module()

    def test_build_row_log_label_distinguishes_item_index_and_excel_row(self) -> None:
        self.assertEqual("第 1 条（Excel 第 2 行）", self.module.build_row_log_label(0))
        self.assertEqual("第 2 条（Excel 第 3 行）", self.module.build_row_log_label(1))

    def test_execute_decision_retries_without_assignee_when_assignment_is_rejected(self) -> None:
        class _RetryJira:
            def __init__(self) -> None:
                self.calls = []

            def create_issue(self, fields):
                self.calls.append(json.loads(json.dumps(fields)))
                assignee = ((fields.get("assignee") or {}).get("name") or "").strip()
                if assignee:
                    raise RuntimeError(
                        'Jira API请求失败 (POST https://jira.tinno.com/rest/api/2/issue), status=400, body={"errorMessages":[],"errors":{"assignee":"User \'tao.wang1\' cannot be assigned issues."}}'
                    )
                return {"key": "VFFCA-409"}

        jira = _RetryJira()
        row = pd.Series({"PS": ""})
        issue_fields = {
            "project": {"key": "VFFCA"},
            "issuetype": {"name": "Bug"},
            "summary": "demo",
            "assignee": {"name": "tao.wang1"},
        }
        decision = SimpleNamespace(
            action="CREATE_NEW",
            manual_review=False,
            update_jira=False,
            recreate_issue=True,
            comment_required=False,
        )
        args = Namespace(add_comments=False)

        result = self.module.execute_decision(
            jira_client=jira,
            row=row,
            issue_fields=issue_fields,
            decision=decision,
            matched_row=None,
            args=args,
            row_number=2,
        )

        self.assertEqual("SUCCESS", result["status"])
        self.assertEqual("VFFCA-409", result["issue_key"])
        self.assertEqual(2, len(jira.calls))
        self.assertIn("assignee", jira.calls[0])
        self.assertNotIn("assignee", jira.calls[1])

    def test_run_excel_mode_create_only_skips_regression_and_syncs_project_db(self) -> None:
        excel_df = pd.DataFrame(
            [
                {
                    "Project": "VFFCA",
                    "Issue Type": "Bug",
                    "Summary": "[自动化][V552AA][Total Number 75][MLD-LX2-16-260518V3][MonkeyAEE][Java (JE)]com.android.wallpaper发生Java (JE)",
                    "Assignee": "dai.lv",
                    "Module": "AUTOTEST",
                    "Priority": "Medium",
                    "Description": "【备注】版本：MLD-LX2-16-260518V3_Daily_user_202605180930_FLASH",
                    "key_information": "java.lang.RuntimeException: test",
                    "Environment": "*Package:* com.android.wallpaper\n*ExpClass:* Java (JE)\n*ExpType:* Crash\n*CurProcess:* com.android.wallpaper",
                    "PS": "日志地址: 220.175.120.251/xx\n账号: sonic\n密码: direct-password",
                    "Bug Severity": "B",
                    "Previous Version Status": "Previous version exists",
                }
            ]
        )
        args = Namespace(
            excel_file="dummy.xlsx",
            regression_project=None,
            current_version=None,
            history_reporter=None,
            disable_regression=False,
            create_only=True,
            jira_username="dai.lv",
            jira_password="secret",
            jira_server="https://jira.tinno.com",
            jira_p12_path="dummy.p12",
            jira_p12_password="dummy-pass",
            jira_cookie_string=None,
            jira_cookie_jsessionid="cookie-session",
            jira_cookie_xsrf_token="cookie-xsrf",
            config_file=str(TOOL_DIR / "config" / "tinno_jira_defaults.json"),
            dry_run=False,
            validate_metadata=False,
            add_comments=False,
            wait_between_issues=0.0,
        )

        fake_jira = _FakeCreateOnlyJira()

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            db_path = temp_path / "tinno_VFFCA.db"
            result_dir = temp_path / "result"

            with mock.patch.object(self.module, "RESULT_DIR", result_dir):
                with mock.patch.object(self.module, "read_excel_smart", return_value=excel_df):
                    with mock.patch.object(self.module, "connect_to_jira", return_value=fake_jira):
                        with mock.patch.object(self.module, "build_issue_fields", return_value={"summary": "created"}):
                            with mock.patch.object(self.module, "build_project_history_db_path", return_value=db_path):
                                with mock.patch.object(self.module, "load_regression_rules", side_effect=AssertionError("create-only 不应加载回归规则")):
                                    with mock.patch.object(self.module, "find_regression_match", side_effect=AssertionError("create-only 不应做历史匹配")):
                                        with mock.patch.object(self.module, "decide_action", side_effect=AssertionError("create-only 不应走回归决策")):
                                            with mock.patch.object(self.module, "process_regression_pass_candidates", side_effect=AssertionError("create-only 不应做回归 PASS")):
                                                result = self.module.run_excel_mode(args)

            self.assertEqual(0, result)
            self.assertTrue(fake_jira.closed)
            self.assertEqual(1, len(fake_jira.created_payloads))

            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            try:
                row = db.get_issue_by_key("VFFCA-200")
            finally:
                db.close()

            self.assertIsNotNone(row)
            self.assertEqual("Open", row["status"])
            self.assertEqual("dai.lv", row["assignee"])
            self.assertEqual("B", row["bug_severity"])
            self.assertEqual("Medium", row["priority"])
            self.assertEqual("com.android.wallpaper", row["package_name"])
            self.assertEqual("Java (JE)", row["exp_class"])
            self.assertEqual("Crash", row["exp_type"])
            self.assertEqual("com.android.wallpaper", row["cur_process"])
            self.assertEqual("MLD-LX2-16-260518V3_Daily_user_202605180930_FLASH", row["build_version"])
            self.assertEqual("MLD-LX2-16-260518V3_Daily_user_202605180930_FLASH", row["version"])

            raw_data = json.loads(row["raw_data"])
            self.assertEqual("VFFCA", raw_data["project"])
            self.assertEqual("AUTOTEST", raw_data["upload_row"]["Module"])
            self.assertIn("220.175.120.251", raw_data["upload_row"]["PS"])

            result_files = list(result_dir.glob("tinno_jira_batch_create_result_*.json"))
            self.assertEqual(1, len(result_files))
            payload = json.loads(result_files[0].read_text(encoding="utf-8"))
            self.assertEqual("SUCCESS", payload[0]["status"])
            self.assertEqual("CREATE_NEW", payload[0]["decision"]["action"])
            self.assertEqual("VFFCA-200", payload[0]["issue_key"])


if __name__ == "__main__":
    unittest.main()
