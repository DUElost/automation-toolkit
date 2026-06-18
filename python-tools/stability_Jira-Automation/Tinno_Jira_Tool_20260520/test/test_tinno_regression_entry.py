import importlib.util
import json
import tempfile
import unittest
from argparse import Namespace
from pathlib import Path
from types import SimpleNamespace
from unittest import mock

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent


def load_batch_entry_module():
    module_path = TOOL_DIR / "create_tinno_jira_batch_from_excel.py"
    spec = importlib.util.spec_from_file_location("tinno_batch_entry_regression_test", module_path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class _FakeRegressionJira:
    auth_mode = "cookie"

    def current_user(self):
        return "dai.lv"

    def close(self):
        return None

    def project(self, project_key: str):
        return SimpleNamespace(key=project_key)

    def search_users(self, user: str, maxResults: int = 20):  # noqa: N803
        return [SimpleNamespace(name=user, displayName=user, emailAddress=f"{user}@tinno.com")]

    def search_issues(self, jql: str, maxResults: int = 50, fields: str = "*all"):  # noqa: N803
        return [SimpleNamespace(key="VCAME-100")]

    def get_issue(self, issue_key: str):
        return {
            "key": issue_key,
            "fields": {
                "summary": "[自动化][V551A][Total Number 7][V551A-15-250905V60][MonkeyAEE][Java (JE)]com.android.settings发生Java (JE)",
                "status": {"name": "Open"},
                "resolution": None,
                "fixVersions": [],
                "project": {"key": "VCAME"},
                "environment": "*Package:* com.android.settings\n*ExpClass:* Java (JE)\n*ExpType:* Crash\n*CurProcess:* com.android.settings",
                "customfield_10500": "java.lang.RuntimeException: test",
            },
        }


class TinnoRegressionEntryTest(unittest.TestCase):
    def setUp(self) -> None:
        self.module = load_batch_entry_module()
        defaults_path = TOOL_DIR / "config" / "tinno_jira_defaults.json"
        with defaults_path.open("r", encoding="utf-8") as fp:
            self.defaults = json.load(fp)

    def test_build_regression_row_extracts_version_and_exp_class_from_summary(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "[自动化][V551A][Total Number 7][V551A-15-250905V60][MonkeyAEE][Java (JE)]com.android.settings发生Java (JE)",
                "Description": "description",
                "Environment": "*Package:* com.android.settings\n*ExpClass:* Java (JE)\n*ExpType:* Crash\n*CurProcess:* com.android.settings",
                "key_information": "java.lang.RuntimeException: test",
            }
        )

        regression_row = self.module.build_regression_row(row, self.defaults)

        self.assertEqual("VCAME", regression_row["affect_project"])
        self.assertEqual("V551A-15-250905V60", regression_row["build_version"])
        self.assertEqual("V551A-15-250905V60", regression_row["current_version"])
        self.assertEqual("Java (JE)", regression_row["exp_class"])
        self.assertEqual("MonkeyAEE", regression_row["specialty"])

    def test_find_regression_match_filters_cross_specialty_history_rows(self) -> None:
        matching_rules = SimpleNamespace(
            required_exact_fields=["affect_project", "environment", "exp_class"],
            cause_similarity_threshold=0.9,
        )
        current_row = {
            "summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][开关机][Java (JE)]system_server发生Java (JE)",
            "specialty": "开关机",
            "affect_project": "VFFCA",
            "environment": "*Package:* system_server",
            "exp_class": "Java (JE)",
            "caused_by": "java.lang.RuntimeException: crash",
        }
        snapshot_rows = [
            {
                "jira_key": "VFFCA-100",
                "summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][休眠唤醒][Java (JE)]system_server发生Java (JE)",
                "affect_project": "VFFCA",
                "environment": "*Package:* system_server",
                "exp_class": "Java (JE)",
                "caused_by": "java.lang.RuntimeException: crash",
            }
        ]

        matched = self.module.find_regression_match(current_row, snapshot_rows, matching_rules)

        self.assertIsNone(matched)

    def test_extract_specialty_from_row_normalizes_test_case_label(self) -> None:
        row = {
            "Summary": "普通摘要",
            "Test Case": "MTBF专项",
        }

        specialty = self.module.extract_specialty_from_row(row, self.defaults)

        self.assertEqual("MTBF", specialty)

    def test_build_regression_pass_comment_uses_structured_template_for_tinno(self) -> None:
        comment = self.module.build_regression_pass_comment(
            pass_count=2,
            versions=["MLD-LX2-16-260521V5", "MLD-LX2-16-260523V6"],
            specialty="MonkeyAEE",
            current_version="MLD-LX2-16-260523V6",
        )

        self.assertEqual(
            "验证结果：PASS\n"
            "测试次数：0/1000\n"
            "验证步骤：MonkeyAEE\n"
            "验证版本：MLD-LX2-16-260523V6\n"
            "样机标识：PR1\n"
            "应用版本：/\n"
            "测试人员及联系方式：吕代+18379465576\n"
            "备注：已回归验证2个版本PASS，已测试版本：MLD-LX2-16-260521V5, MLD-LX2-16-260523V6",
            comment,
        )

    def test_build_regression_pass_comment_supports_external_comment_config(self) -> None:
        comment = self.module.build_regression_pass_comment(
            pass_count=1,
            versions=["MLD-LX2-16-260523V6"],
            specialty="MonkeyAEE",
            current_version="MLD-LX2-16-260523V6",
            comment_config={
                "common": {
                    "device_mark": "LAB-A",
                    "tester_contact": "张三+10086",
                    "pass_test_count": "5/500",
                },
                "pass_template": (
                    "验证结果：PASS\n"
                    "测试次数：{test_count}\n"
                    "验证步骤：{specialty}\n"
                    "验证版本：{current_version}\n"
                    "样机标识：{device_mark}\n"
                    "应用版本：/\n"
                    "测试人员及联系方式：{tester_contact}\n"
                    "备注：{remark}"
                ),
                "fail_template": "",
            },
        )

        self.assertEqual(
            "验证结果：PASS\n"
            "测试次数：5/500\n"
            "验证步骤：MonkeyAEE\n"
            "验证版本：MLD-LX2-16-260523V6\n"
            "样机标识：LAB-A\n"
            "应用版本：/\n"
            "测试人员及联系方式：张三+10086\n"
            "备注：已回归验证1个版本PASS，已测试版本：MLD-LX2-16-260523V6",
            comment,
        )

    def test_build_history_issue_main_comment_uses_structured_fail_template(self) -> None:
        row = pd.Series(
            {
                "Project": "VFFCA",
                "Issue Type": "Bug",
                "Summary": "[自动化][V552AA][Total Number 6][MLD-LX2-16-260523V6][MonkeyAEE][Java (JE)]com.android.wallpaper发生Java (JE)",
                "Description": "手机版本：['MLD-LX2-16-260523V6']\n异常包名：['com.android.wallpaper v36 (16)']",
                "Environment": "*Package:* com.android.wallpaper\n*ExpClass:* Java (JE)\n*ExpType:* system_app_crash\n*CurProcess:* com.android.wallpaper",
            }
        )

        comment = self.module.build_history_issue_main_comment(
            "OPEN_LIKE_UPDATE",
            row,
            {"jira_key": "VFFCA-100"},
        )

        self.assertEqual(
            "验证结果：FAIL\n"
            "测试次数：6\n"
            "验证步骤：MonkeyAEE\n"
            "验证版本：MLD-LX2-16-260523V6\n"
            "样机标识：PR1\n"
            "应用版本：v36 (16)\n"
            "测试人员及联系方式：吕代+18379465576\n"
            "备注：自动化回归命中历史单 VFFCA-100，当前版本 MLD-LX2-16-260523V6 再次复现，请继续跟进。",
            comment,
        )

    def test_build_history_issue_main_comment_marks_wait_new_version_with_structured_template(self) -> None:
        row = pd.Series(
            {
                "Project": "VFFCA",
                "Issue Type": "Bug",
                "Summary": "[自动化][V552AA][Total Number 2][MLD-LX2-16-260518V3][MTBF][Java (JE)]com.android.settings发生Java (JE)",
                "Description": "手机版本：['MLD-LX2-16-260518V3']",
                "Environment": "*Package:* com.android.settings\n*ExpClass:* Java (JE)\n*ExpType:* system_app_crash\n*CurProcess:* com.android.settings",
            }
        )

        comment = self.module.build_history_issue_main_comment(
            "RESOLVED_FIXED_WAIT_NEW_VERSION",
            row,
            {"jira_key": "VFFCA-200"},
        )

        self.assertEqual(
            "验证结果：FAIL\n"
            "测试次数：2\n"
            "验证步骤：MTBF\n"
            "验证版本：MLD-LX2-16-260518V3\n"
            "样机标识：PR1\n"
            "应用版本：/\n"
            "测试人员及联系方式：吕代+18379465576\n"
            "备注：自动化回归命中历史单 VFFCA-200，当前版本 MLD-LX2-16-260518V3 早于修复版本，先保留记录并继续观察。",
            comment,
        )

    def test_build_history_issue_main_comment_supports_external_comment_config(self) -> None:
        row = pd.Series(
            {
                "Project": "VFFCA",
                "Issue Type": "Bug",
                "Summary": "[自动化][V552AA][Total Number 3][MLD-LX2-16-260523V6][MTBF][Java (JE)]com.android.settings发生Java (JE)",
                "Description": "手机版本：['MLD-LX2-16-260523V6']",
                "Environment": "*Package:* com.android.settings\n*ExpClass:* Java (JE)\n*ExpType:* system_app_crash\n*CurProcess:* com.android.settings",
            }
        )

        comment = self.module.build_history_issue_main_comment(
            "OPEN_LIKE_UPDATE",
            row,
            {"jira_key": "VFFCA-300"},
            comment_config={
                "common": {
                    "device_mark": "LAB-B",
                    "tester_contact": "李四+10010",
                },
                "pass_template": "",
                "fail_template": (
                    "验证结果：FAIL\n"
                    "测试次数：{test_count}\n"
                    "验证步骤：{specialty}\n"
                    "验证版本：{current_version}\n"
                    "样机标识：{device_mark}\n"
                    "应用版本：{app_version}\n"
                    "测试人员及联系方式：{tester_contact}\n"
                    "备注：{remark}"
                ),
            },
        )

        self.assertEqual(
            "验证结果：FAIL\n"
            "测试次数：3\n"
            "验证步骤：MTBF\n"
            "验证版本：MLD-LX2-16-260523V6\n"
            "样机标识：LAB-B\n"
            "应用版本：/\n"
            "测试人员及联系方式：李四+10010\n"
            "备注：自动化回归命中历史单 VFFCA-300，当前版本 MLD-LX2-16-260523V6 再次复现，请继续跟进。",
            comment,
        )

    def test_collect_regression_summary_keywords_prefers_specialties(self) -> None:
        df = pd.DataFrame(
            [
                {"Summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][MonkeyAEE][Java (JE)]a发生Java (JE)"},
                {"Summary": "[自动化][V552AA][Total Number 1][MLD-LX3-16-260518V3][MTBF][Native (NE)]b发生Native (NE)"},
            ]
        )

        keywords = self.module.collect_regression_summary_keywords(df, self.defaults)

        self.assertEqual(["MTBF", "MonkeyAEE"], sorted(keywords))

    def test_collect_duplicate_issue_keys_reads_duplicate_links(self) -> None:
        duplicate_keys = self.module.collect_duplicate_issue_keys(
            {
                "jira_key": "VCAME-100",
                "raw_payload": json.dumps(
                    {
                        "fields": {
                            "issuelinks": [
                                {
                                    "type": {"name": "Duplicate"},
                                    "outwardIssue": {"key": "VCAME-101"},
                                }
                            ]
                        }
                    }
                ),
            }
        )

        self.assertEqual(["VCAME-101"], duplicate_keys)

    def test_build_regression_row_supports_non_monkey_summary_token(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "[自动化][V551A][Total Number 7][V551A-15-250905V60][MTBF][Java (JE)]com.android.settings发生Java (JE)",
                "Description": "description",
                "Environment": "",
                "key_information": "java.lang.RuntimeException: test",
            }
        )

        regression_row = self.module.build_regression_row(row, self.defaults)

        self.assertEqual("V551A-15-250905V60", regression_row["build_version"])
        self.assertEqual("Java (JE)", regression_row["exp_class"])

    def test_build_regression_row_extracts_version_from_description_note(self) -> None:
        row = pd.Series(
            {
                "Project": "VFFCA",
                "Issue Type": "Bug",
                "Summary": "【天珑团队】【V552AA】【EVT】【生产】【CIT】*#06#缺少SN号",
                "Description": "【备注】版本：MLD-LX2-16-260511V17_Daily_user_202605110956_FLASH",
            }
        )

        regression_row = self.module.build_regression_row(row, self.defaults)

        self.assertEqual(
            "MLD-LX2-16-260511V17_Daily_user_202605110956_FLASH",
            regression_row["build_version"],
        )
        self.assertEqual(regression_row["build_version"], regression_row["current_version"])

    def test_run_excel_mode_dry_run_wires_regression_match_and_outputs_summary(self) -> None:
        fake_rules = SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="reporter in (dai.lv)", max_results=20),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决"],
                resolved_fixed_resolutions=["完成"],
                closed_statuses=["Closed", "已关闭"],
            ),
            regression=SimpleNamespace(
                enabled=True,
                required_regression_pass_versions=2,
                enable_duplicate_followups=False,
                write_audit_report=True,
                strict_version_project_keys=["VCAME"],
            ),
            output=None,
        )

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            fake_rules.output = SimpleNamespace(
                sqlite_path=str(temp_path / "cache"),
                excel_summary_dir=str(temp_path / "summary"),
            )
            excel_df = pd.DataFrame(
                [
                    {
                        "Project": "VCAME",
                        "Issue Type": "Bug",
                        "Summary": "[自动化][V551A][Total Number 7][V551A-15-250905V60][MonkeyAEE][Java (JE)]com.android.settings发生Java (JE)",
                        "Assignee": "dai.lv",
                        "Priority": "Medium",
                        "Description": "description",
                        "key_information": "java.lang.RuntimeException: test",
                        "Environment": "*Package:* com.android.settings\n*ExpClass:* Java (JE)\n*ExpType:* Crash\n*CurProcess:* com.android.settings",
                        "PS": "*Reporter:* dai.lv\n*Version:* V551A-15-250905V60",
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
                test_mode=False,
                disable_regression=False,
                jira_username="dai.lv",
                jira_password="secret",
                jira_server="https://jira.tinno.com",
                jira_p12_path="dummy.p12",
                jira_p12_password="dummy-pass",
                jira_cookie_string=None,
                jira_cookie_jsessionid="cookie-session",
                jira_cookie_xsrf_token="cookie-xsrf",
                config_file=str(TOOL_DIR / "config" / "tinno_jira_defaults.json"),
                dry_run=True,
                validate_metadata=False,
                add_comments=False,
                wait_between_issues=0.0,
            )

            with mock.patch.object(self.module, "RESULT_DIR", temp_path / "result"):
                with mock.patch.object(self.module, "read_excel_smart", return_value=excel_df):
                    with mock.patch.object(self.module, "load_regression_rules", return_value=fake_rules):
                        with mock.patch.object(self.module, "connect_to_jira", return_value=_FakeRegressionJira()):
                            result = self.module.run_excel_mode(args)

            self.assertEqual(0, result)

            result_files = list((temp_path / "result").glob("tinno_jira_batch_create_result_*.json"))
            audit_files = list((temp_path / "result").glob("tinno_jira_batch_create_audit_*.json"))
            summary_files = list((temp_path / "summary").glob("tinno_jira_batch_create_summary_*.xlsx"))
            self.assertEqual(1, len(result_files))
            self.assertEqual(1, len(audit_files))
            self.assertEqual(1, len(summary_files))

            payload = json.loads(result_files[0].read_text(encoding="utf-8"))
            audit_payload = json.loads(audit_files[0].read_text(encoding="utf-8"))
            self.assertEqual("DRY_RUN", payload[0]["status"])
            self.assertEqual("VCAME-100", payload[0]["matched_jira_key"])
            self.assertEqual("OPEN_LIKE_UPDATE", payload[0]["decision"]["action"])
            self.assertEqual(1, audit_payload["action_counts"]["OPEN_LIKE_UPDATE"])
            self.assertEqual(1, audit_payload["status_counts"]["DRY_RUN"])

    def test_process_regression_pass_candidates_filters_specialty_and_syncs_project_db(self) -> None:
        fake_rules = SimpleNamespace(
            regression=SimpleNamespace(
                enabled=True,
                required_regression_pass_versions=2,
                enable_duplicate_followups=False,
                write_audit_report=True,
                strict_version_project_keys=["VCAME"],
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决"],
                resolved_fixed_resolutions=["完成"],
                closed_statuses=["Closed", "已关闭"],
            ),
        )

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            store = self.module.RegressionStore(temp_path / "cache" / "VCAME.db")
            project_db = self.module.DatabaseManager({"type": "sqlite", "path": str(temp_path / "project.db")})
            project_db.insert_issue(
                {
                    "jira_key": "VCAME-100",
                    "status": "已解决",
                    "summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][MonkeyAEE][Java (JE)]a发生Java (JE)",
                    "normalized_summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][MonkeyAEE][Java (JE)]a发生Java (JE)",
                    "test_environment": "*Package:* com.android.settings",
                    "raw_caused_by": "java.lang.RuntimeException",
                    "assignee": "dai.lv",
                    "bug_severity": "B",
                    "priority": "Medium",
                    "description": "desc",
                    "resolution": "完成",
                    "package_name": "com.android.settings",
                    "exp_class": "Java (JE)",
                    "exp_type": "Crash",
                    "cur_process": "com.android.settings",
                    "version": "P1",
                    "count": 1,
                    "device_count": 1,
                    "source_file": "",
                    "raw_data": {},
                    "fix_version": "P1",
                    "build_version": "P0",
                    "regression_pass_count": 0,
                    "verified_versions": [],
                }
            )
            store.save_snapshot(
                "run1",
                [
                    {
                        "jira_key": "VCAME-100",
                        "summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][MonkeyAEE][Java (JE)]a发生Java (JE)",
                        "status": "已解决",
                        "resolution": "完成",
                        "fix_version": "P1",
                        "build_version": "P0",
                        "affect_project": "VCAME",
                        "environment": "*Package:* com.android.settings",
                        "exp_class": "Java (JE)",
                        "caused_by": "java.lang.RuntimeException",
                        "raw_payload": "{}",
                    },
                    {
                        "jira_key": "VCAME-200",
                        "summary": "[自动化][V552AA][Total Number 1][MLD-LX2-16-260518V3][MTBF][Java (JE)]b发生Java (JE)",
                        "status": "已解决",
                        "resolution": "完成",
                        "fix_version": "P1",
                        "build_version": "P0",
                        "affect_project": "VCAME",
                        "environment": "*Package:* com.android.camera",
                        "exp_class": "Java (JE)",
                        "caused_by": "java.lang.RuntimeException",
                        "raw_payload": "{}",
                    },
                ],
            )

            with mock.patch.object(self.module, "add_issue_comment") as add_issue_comment:
                self.module.process_regression_pass_candidates(
                    jira_client=SimpleNamespace(),
                    store=store,
                    project_db=project_db,
                    run_id="run1",
                    current_version="P2",
                    regression_rules=fake_rules,
                    matched_jira_keys=set(),
                    allowed_specialties={"MonkeyAEE"},
                    args=Namespace(dry_run=False),
                    results=[],
                    summary_rows=[],
                )

            updated = project_db.get_issue_by_key("VCAME-100")
            project_db.close()

        self.assertEqual(1, add_issue_comment.call_count)
        self.assertEqual(1, updated["regression_pass_count"])
        self.assertIn("P2", json.loads(updated["verified_versions"]))

    def test_match_current_version_by_board_selects_same_board_highest(self) -> None:
        candidates = ["MLD-LX2-16-260518V3", "MLD-LX3-16-260520V5"]
        matched = self.module._match_current_version_by_board(
            "MLD-LX3-16-260508V1",
            candidates,
            fallback="MLD-LX2-16-260518V3",
        )
        self.assertEqual("MLD-LX3-16-260520V5", matched)

    def test_match_current_version_by_board_falls_back_without_board(self) -> None:
        matched = self.module._match_current_version_by_board(
            "P0",
            ["MLD-LX2-16-260518V3"],
            fallback="P1",
        )
        self.assertEqual("P1", matched)

    def test_process_regression_pass_records_board_matched_version(self) -> None:
        fake_rules = SimpleNamespace(
            regression=SimpleNamespace(
                enabled=True,
                required_regression_pass_versions=2,
                enable_duplicate_followups=False,
                write_audit_report=True,
                strict_version_project_keys=["VCAME"],
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决"],
                resolved_fixed_resolutions=["完成"],
                closed_statuses=["Closed", "已关闭"],
            ),
        )
        lx2_batch_version = "MLD-LX2-16-260518V5"
        lx3_effective_version = "MLD-LX3-16-260520V5"

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            store = self.module.RegressionStore(temp_path / "cache" / "VCAME.db")
            project_db = self.module.DatabaseManager({"type": "sqlite", "path": str(temp_path / "project.db")})
            project_db.insert_issue(
                {
                    "jira_key": "VCAME-100",
                    "status": "已解决",
                    "summary": "[自动化][V552AA][Total Number 1][MLD-LX3-16-260508V1][MonkeyAEE][Java (JE)]a发生Java (JE)",
                    "normalized_summary": "[自动化][V552AA][Total Number 1][MLD-LX3-16-260508V1][MonkeyAEE][Java (JE)]a发生Java (JE)",
                    "test_environment": "*Package:* com.android.settings",
                    "raw_caused_by": "java.lang.RuntimeException",
                    "assignee": "dai.lv",
                    "bug_severity": "B",
                    "priority": "Medium",
                    "description": "desc",
                    "resolution": "完成",
                    "package_name": "com.android.settings",
                    "exp_class": "Java (JE)",
                    "exp_type": "Crash",
                    "cur_process": "com.android.settings",
                    "version": "MLD-LX3-16-260510V1",
                    "count": 1,
                    "device_count": 1,
                    "source_file": "",
                    "raw_data": {},
                    "fix_version": "MLD-LX3-16-260510V1",
                    "build_version": "MLD-LX3-16-260508V1",
                    "regression_pass_count": 0,
                    "verified_versions": [],
                }
            )
            store.save_snapshot(
                "run1",
                [
                    {
                        "jira_key": "VCAME-100",
                        "summary": "[自动化][V552AA][Total Number 1][MLD-LX3-16-260508V1][MonkeyAEE][Java (JE)]a发生Java (JE)",
                        "status": "已解决",
                        "resolution": "完成",
                        "fix_version": "MLD-LX3-16-260510V1",
                        "build_version": "MLD-LX3-16-260508V1",
                        "affect_project": "VCAME",
                        "environment": "*Package:* com.android.settings",
                        "exp_class": "Java (JE)",
                        "caused_by": "java.lang.RuntimeException",
                        "raw_payload": "{}",
                    },
                ],
            )

            with mock.patch.object(self.module, "add_issue_comment") as add_issue_comment:
                self.module.process_regression_pass_candidates(
                    jira_client=SimpleNamespace(),
                    store=store,
                    project_db=project_db,
                    run_id="run1",
                    current_version=lx2_batch_version,
                    current_version_candidates=[
                        "MLD-LX2-16-260518V3",
                        lx3_effective_version,
                    ],
                    regression_rules=fake_rules,
                    matched_jira_keys=set(),
                    allowed_specialties={"MonkeyAEE"},
                    args=Namespace(dry_run=False),
                    results=[],
                    summary_rows=[],
                )

            updated = project_db.get_issue_by_key("VCAME-100")
            project_db.close()

        verified_versions = json.loads(updated["verified_versions"])
        self.assertEqual(1, add_issue_comment.call_count)
        self.assertEqual(1, updated["regression_pass_count"])
        self.assertIn(lx3_effective_version, verified_versions)
        self.assertNotIn(lx2_batch_version, verified_versions)

    def test_ensure_test_mode_upload_excel_generates_vcame_autotest_rows(self) -> None:
        raw_df = pd.DataFrame(
            [
                {
                    "Path": "/home/jxtinno/sonic_tinno/logs/test.log",
                    "Package": "system_server",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "ExpType": "system_server_crash",
                    "CurProcess": "system_server",
                    "Detail": "异常包名：system_server v1\n异常进程：system_server",
                    "key_information": "java.lang.RuntimeException: test",
                    "Count": 1,
                    "Device Count": 1,
                }
            ]
        )
        args = Namespace(
            history_reporter=None,
            jira_username="current.user",
            test_mode=True,
        )

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            with mock.patch.object(self.module, "RESULT_DIR", temp_path):
                with mock.patch.object(self.module, "read_excel_smart", return_value=raw_df):
                    with mock.patch.object(self.module, "load_upload_package_owner_mapping", return_value={}):
                        with mock.patch.object(self.module, "load_upload_severity_rules", return_value=[]):
                            with mock.patch.object(self.module, "load_upload_affect_project_mapping", return_value={}):
                                with mock.patch.object(self.module, "load_upload_test_case_summary", return_value={"Monkey专项": {"index": "0"}}):
                                    generated = self.module.ensure_test_mode_upload_excel(args, self.defaults)
                                    upload_df = pd.read_excel(generated, engine="openpyxl")

        self.assertEqual("VCAME", upload_df.loc[0, "Project"])
        self.assertEqual("AUTOTEST", upload_df.loc[0, "Module"])
        self.assertEqual("AUTOTEST", upload_df.loc[0, "Components"])
        self.assertEqual("current.user", upload_df.loc[0, "Assignee"])
        self.assertEqual("current.user", upload_df.loc[0, "Reporter"])
        self.assertEqual("Monkey专项", upload_df.loc[0, "Test Case"])

    def test_run_regression_verify_mode_test_mode_auto_fills_defaults(self) -> None:
        fake_rules = SimpleNamespace(
            jira_export=SimpleNamespace(enabled=True, jql="reporter in (dai.lv)", max_results=20),
            matching=SimpleNamespace(
                required_exact_fields=["affect_project", "environment", "exp_class"],
                cause_similarity_threshold=0.9,
            ),
            status_rules=SimpleNamespace(
                resolved_statuses=["已解决"],
                resolved_fixed_resolutions=["完成"],
                closed_statuses=["Closed", "已关闭"],
            ),
            regression=SimpleNamespace(
                enabled=True,
                required_regression_pass_versions=2,
                enable_duplicate_followups=False,
                write_audit_report=True,
                strict_version_project_keys=["VCAME"],
            ),
            output=None,
        )

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            fake_rules.output = SimpleNamespace(
                sqlite_path=str(temp_path / "cache"),
                excel_summary_dir=str(temp_path / "summary"),
            )
            args = Namespace(
                excel_file=None,
                regression_project=None,
                current_version=None,
                history_reporter=None,
                test_mode=True,
                disable_regression=False,
                create_only=False,
                jira_username="dai.lv",
                jira_password="secret",
                jira_server=None,
                jira_p12_path="dummy.p12",
                jira_p12_password="dummy-pass",
                jira_cookie_string=None,
                jira_cookie_jsessionid=None,
                jira_cookie_xsrf_token=None,
                config_file=str(TOOL_DIR / "config" / "tinno_jira_defaults.json"),
                dry_run=True,
                validate_metadata=False,
                add_comments=False,
                wait_between_issues=0.0,
                regression_specialties=[],
            )

            with mock.patch.dict(
                "os.environ",
                {
                    "TINNO_TEST_JIRA_COOKIE_JSESSIONID": "test-session",
                    "TINNO_TEST_JIRA_COOKIE_XSRF_TOKEN": "test-xsrf",
                },
                clear=False,
            ):
                with mock.patch.object(self.module, "load_regression_rules", return_value=fake_rules):
                        with mock.patch.object(self.module, "infer_test_mode_current_version", return_value="MLD-LX2-16-260518V3"):
                            with mock.patch.object(self.module, "connect_to_jira", return_value=_FakeRegressionJira()):
                                with mock.patch.object(self.module, "export_jira_snapshot", return_value=[]):
                                    with mock.patch.object(self.module, "process_regression_pass_candidates") as process_regression_pass:
                                        with mock.patch.object(self.module, "process_closed_main_duplicate_followups") as duplicate_followups:
                                            with mock.patch.object(self.module, "write_run_outputs", return_value=0):
                                                result = self.module.run_regression_verify_mode(args)

        self.assertEqual(0, result)
        self.assertEqual("VCAME", args.regression_project)
        self.assertEqual("MLD-LX2-16-260518V3", args.current_version)
        self.assertEqual("dai.lv", args.history_reporter)
        self.assertEqual("test-session", args.jira_cookie_jsessionid)
        self.assertEqual("test-xsrf", args.jira_cookie_xsrf_token)
        self.assertEqual(["MonkeyAEE"], args.regression_specialties)
        process_regression_pass.assert_called_once()
        self.assertEqual({"MonkeyAEE"}, process_regression_pass.call_args.kwargs["allowed_specialties"])
        duplicate_followups.assert_not_called()

    def test_build_run_decision_stats_uses_summary_rows_for_action_and_reason(self) -> None:
        results = [
            {"status": "SUCCESS", "decision": {"action": "FROM_RESULTS_ONLY"}},
            {"status": "FAILED", "decision": {"action": "IGNORED_ACTION"}},
        ]
        summary_rows = [
            {"action": "OPEN_LIKE_UPDATE", "reason": "HISTORY_MATCH"},
            {"action": "CREATE_NEW", "reason": "NO_HISTORY"},
        ]

        stats = self.module.build_run_decision_stats(results, summary_rows)

        self.assertEqual({"SUCCESS": 1, "FAILED": 1}, stats["status_counts"])
        self.assertEqual(
            {"OPEN_LIKE_UPDATE": 1, "CREATE_NEW": 1},
            stats["action_counts"],
        )
        self.assertEqual(
            {"HISTORY_MATCH": 1, "NO_HISTORY": 1},
            stats["reason_counts"],
        )
        self.assertNotIn("FROM_RESULTS_ONLY", stats["action_counts"])

    def test_build_run_decision_stats_empty_values_map_to_unknown(self) -> None:
        stats = self.module.build_run_decision_stats(
            [{"status": ""}],
            [{"action": "", "reason": ""}],
        )
        self.assertEqual({"UNKNOWN": 1}, stats["status_counts"])
        self.assertEqual({"UNKNOWN": 1}, stats["action_counts"])
        self.assertEqual({"UNKNOWN": 1}, stats["reason_counts"])

    def test_format_counts_orders_by_count_then_name(self) -> None:
        formatted = self.module._format_counts({"B": 2, "A": 1, "C": 2})
        self.assertEqual("B=2、C=2、A=1", formatted)

    def test_save_audit_report_uses_shared_decision_stats(self) -> None:
        results = [{"status": "SUCCESS", "decision": {"action": "IGNORED"}}]
        summary_rows = [{"action": "REGRESSION_PASS_PROGRESS", "reason": "回归PASS判定"}]

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            with mock.patch.object(self.module, "RESULT_DIR", temp_path):
                audit_path = self.module.save_audit_report(
                    results=results,
                    summary_rows=summary_rows,
                    run_id="run-test",
                )
                payload = json.loads(audit_path.read_text(encoding="utf-8"))

        self.assertEqual({"SUCCESS": 1}, payload["status_counts"])
        self.assertEqual({"REGRESSION_PASS_PROGRESS": 1}, payload["action_counts"])
        self.assertEqual({"回归PASS判定": 1}, payload["reason_counts"])


if __name__ == "__main__":
    unittest.main()
