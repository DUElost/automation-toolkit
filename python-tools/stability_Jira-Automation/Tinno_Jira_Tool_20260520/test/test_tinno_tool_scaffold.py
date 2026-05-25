import json
import importlib.util
import os
import tempfile
import unittest
from argparse import Namespace
from pathlib import Path
from unittest import mock

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent


def load_batch_entry_module():
    module_path = TOOL_DIR / "create_tinno_jira_batch_from_excel.py"
    spec = importlib.util.spec_from_file_location("tinno_batch_entry_under_test", module_path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class TinnoToolScaffoldTest(unittest.TestCase):
    def test_expected_files_exist(self) -> None:
        expected = [
            "create_tinno_jira_batch_from_excel.py",
            "generate_tinno_jira_upload_list.py",
            "readme.txt",
            "config/tinno_jira_defaults.json",
            "config/regression_rules.json",
            "config/comment_templates.json",
            "config/regression_comment_config.json",
            "tinno_batch_jira_common.py",
            "tinno_regression_executor.py",
        ]
        missing = [item for item in expected if not (TOOL_DIR / item).exists()]
        self.assertEqual([], missing)

    def test_defaults_are_tinno_specific(self) -> None:
        defaults_path = TOOL_DIR / "config" / "tinno_jira_defaults.json"
        with defaults_path.open("r", encoding="utf-8") as fp:
            defaults = json.load(fp)

        self.assertEqual("https://jira.tinno.com", defaults["jira_server"])
        self.assertEqual("VCAME", defaults["project_key"])
        self.assertEqual("customfield_10120", defaults["field_ids"]["bug_severity"])
        self.assertEqual("customfield_10500", defaults["field_ids"]["key_information"])
        self.assertEqual("customfield_10123", defaults["field_ids"]["previous_version_status"])
        self.assertEqual("customfield_10124", defaults["field_ids"]["previous_version_text"])
        self.assertEqual("AUTOTEST", defaults["default_component"])
        self.assertEqual("Previous version exists", defaults["default_previous_version_status"])
        self.assertEqual("100%", defaults["default_previous_version_text"])
        self.assertEqual("p12", defaults["auth"]["mode"])

    def test_regression_rules_use_tinno_statuses(self) -> None:
        rules_path = TOOL_DIR / "config" / "regression_rules.json"
        with rules_path.open("r", encoding="utf-8") as fp:
            rules = json.load(fp)

        status_rules = rules["status_rules"]
        self.assertIn("开放", status_rules["open_like_statuses"])
        self.assertIn("已解决", status_rules["resolved_statuses"])
        self.assertIn("完成", status_rules["resolved_fixed_resolutions"])
        self.assertIn("问题不修改", status_rules["wont_fix_resolutions"])
        self.assertIn("已关闭", status_rules["closed_statuses"])
        self.assertFalse(rules["regression"]["enable_duplicate_followups"])
        self.assertTrue(rules["regression"]["write_audit_report"])
        self.assertIn("VFFCA", rules["regression"]["strict_version_project_keys"])

    def test_parse_args_reads_cookie_env_and_mentions_cookie_priority(self) -> None:
        module = load_batch_entry_module()
        env = {
            "JIRA_COOKIE_JSESSIONID": "cookie-session",
            "JIRA_COOKIE_XSRF_TOKEN": "cookie-xsrf",
        }
        with mock.patch.dict(os.environ, env, clear=False):
            with mock.patch("sys.argv", ["create_tinno_jira_batch_from_excel.py", "--dry-run"]):
                args = module.parse_args()

        self.assertEqual("cookie-session", args.jira_cookie_jsessionid)
        self.assertEqual("cookie-xsrf", args.jira_cookie_xsrf_token)

    def test_parse_args_supports_create_only_flag(self) -> None:
        module = load_batch_entry_module()
        with mock.patch("sys.argv", ["create_tinno_jira_batch_from_excel.py", "--create-only"]):
            args = module.parse_args()

        self.assertTrue(args.create_only)

    def test_parse_args_supports_test_mode_flag(self) -> None:
        module = load_batch_entry_module()
        with mock.patch("sys.argv", ["create_tinno_jira_batch_from_excel.py", "--test-mode"]):
            args = module.parse_args()

        self.assertTrue(args.test_mode)

    def test_load_local_env_allows_parse_args_to_pick_up_p12_defaults(self) -> None:
        module = load_batch_entry_module()
        with tempfile.TemporaryDirectory() as temp_dir:
            env_file = Path(temp_dir) / ".env.local"
            env_file.write_text(
                "\n".join(
                    [
                        "JIRA_P12_PATH=F:\\automation-toolkit\\python-tools\\stability_Jira-Automation\\Tinno_Jira_Tool_20260520\\890177.p12",
                        "JIRA_P12_PASSWORD=masked-secret",
                    ]
                ),
                encoding="utf-8",
            )
            with mock.patch.dict(os.environ, {}, clear=True):
                module.load_local_env(env_file)
                with mock.patch("sys.argv", ["create_tinno_jira_batch_from_excel.py", "--dry-run"]):
                    args = module.parse_args()

        self.assertEqual(
            "F:\\automation-toolkit\\python-tools\\stability_Jira-Automation\\Tinno_Jira_Tool_20260520\\890177.p12",
            args.jira_p12_path,
        )
        self.assertEqual("masked-secret", args.jira_p12_password)

    def test_validate_metadata_logs_auth_mode(self) -> None:
        module = load_batch_entry_module()
        fake_jira = mock.Mock()
        fake_jira.auth_mode = "cookie"
        fake_jira.close = mock.Mock()
        args = Namespace(
            excel_file="dummy.xlsx",
            regression_project=None,
            jira_username="dai.lv",
            jira_password="secret",
            jira_server="https://jira.tinno.com",
            jira_p12_path="dummy.p12",
            jira_p12_password="dummy-pass",
            jira_cookie_string=None,
            jira_cookie_jsessionid="session-cookie",
            jira_cookie_xsrf_token="xsrf-cookie",
            config_file=str(TOOL_DIR / "config" / "tinno_jira_defaults.json"),
            test_mode=False,
            dry_run=False,
            validate_metadata=True,
            add_comments=False,
            wait_between_issues=0.0,
        )

        with mock.patch.object(module, "load_regression_rules"):
            with mock.patch.object(module, "read_excel_smart", return_value=pd.DataFrame([{"Project": "VCAME", "Issue Type": "Bug"}])):
                with mock.patch.object(module, "validate_upload_excel", return_value=True):
                    with mock.patch.object(module, "connect_to_jira", return_value=fake_jira):
                        with mock.patch.object(module, "get_create_meta_fields", return_value={}):
                            with mock.patch.object(module, "build_field_name_lookup", return_value={}):
                                with mock.patch.object(module, "extract_allowed_values", return_value={}):
                                    with mock.patch.object(module.logger, "info") as logger_info:
                                        result = module.run_excel_mode(args)

        self.assertEqual(0, result)
        logger_info.assert_any_call("当前认证来源: %s", "cookie")
        fake_jira.close.assert_called_once()

    def test_apply_test_mode_defaults_reads_local_test_cookie_env(self) -> None:
        module = load_batch_entry_module()
        args = Namespace(
            jira_server=None,
            jira_cookie_jsessionid=None,
            jira_cookie_xsrf_token=None,
            history_reporter=None,
            jira_username=None,
            test_mode=True,
        )
        defaults = {
            "jira_server": "https://jira.tinno.com",
            "default_reporter": "dai.lv",
            "default_assignee": "dai.lv",
        }

        with mock.patch.dict(
            os.environ,
            {
                "TINNO_TEST_JIRA_COOKIE_JSESSIONID": "test-session",
                "TINNO_TEST_JIRA_COOKIE_XSRF_TOKEN": "test-xsrf",
            },
            clear=False,
        ):
            module.apply_test_mode_defaults(args, defaults)

        self.assertEqual("https://jira.tinno.com", args.jira_server)
        self.assertEqual("test-session", args.jira_cookie_jsessionid)
        self.assertEqual("test-xsrf", args.jira_cookie_xsrf_token)
        self.assertEqual("dai.lv", args.history_reporter)


if __name__ == "__main__":
    unittest.main()
