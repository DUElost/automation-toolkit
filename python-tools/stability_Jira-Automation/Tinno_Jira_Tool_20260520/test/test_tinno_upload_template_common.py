import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

import tinno_upload_template_common as upload_common


class TinnoUploadTemplateCommonTest(unittest.TestCase):
    def test_load_test_case_summary_reads_excel(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            file_path = Path(temp_dir) / "test_case_summary.xlsx"
            pd.DataFrame(
                [
                    {
                        "编号": 0,
                        "测试项": "Monkey专项",
                        "测试总次数": 2000,
                        "测试步骤": "monkey steps",
                    }
                ]
            ).to_excel(file_path, index=False, engine="openpyxl")

            mapping = upload_common.load_test_case_summary(file_path)

        self.assertEqual(
            {
                "Monkey专项": {
                    "index": "0",
                    "total_runs": 2000,
                    "preconditions": "monkey steps",
                }
            },
            mapping,
        )

    def test_load_affect_project_mapping_supports_project_only_mapping(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            file_path = Path(temp_dir) / "affect_project_mapping.json"
            file_path.write_text(
                """
{
  "V552AA": {
    "jira_project": "VFFCA"
  }
}
                """.strip(),
                encoding="utf-8",
            )

            mapping = upload_common.load_affect_project_mapping(file_path)

        self.assertEqual(
            {
                "V552AA": {
                    "jira_project": "VFFCA",
                    "affect_project": "V552AA",
                    "monkey_project": "",
                }
            },
            mapping,
        )

    def test_load_severity_rules_reads_rules_from_excel(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            file_path = Path(temp_dir) / "severity_rules.xlsx"
            pd.DataFrame(
                [
                    {
                        "问题等级": "A",
                        "报错类型": "Java",
                        "次数要求": ">=5",
                    }
                ]
            ).to_excel(file_path, index=False, engine="openpyxl")

            rules = upload_common.load_severity_rules(file_path)

        self.assertEqual(
            [
                {
                    "level": "A",
                    "keyword": "Java",
                    "operator": ">=",
                    "threshold": 5,
                }
            ],
            rules,
        )

    def test_load_package_owner_mapping_supports_alias_columns(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            file_path = Path(temp_dir) / "package_mapping.xlsx"
            pd.DataFrame(
                [
                    {
                        "Package": "com.android.settings",
                        "Components": "Setting",
                        "负责人": "owner.a",
                    }
                ]
            ).to_excel(file_path, index=False, engine="openpyxl")

            mapping = upload_common.load_package_owner_mapping(file_path)

        self.assertEqual(
            {
                "com.android.settings": {
                    "module": "Setting",
                    "assignee": "owner.a",
                }
            },
            mapping,
        )

    def test_build_upload_rows_uses_mapping_and_defaults(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "V551A-15-250905V60",
                    "Exp Class": "Java (JE)",
                    "Exp Type": "NullPointerException",
                    "Process": "com.android.settings",
                    "Detail": "Settings crash detail",
                    "CausedBy": "java.lang.NullPointerException",
                    "Count": 7,
                    "DeviceCount": 2,
                    "Severity Level": "A",
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {"Monkey专项": "MonkeyAEE"},
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }
        package_mapping = {
            "com.android.settings": {
                "module": "Setting",
                "assignee": "owner.a",
            }
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping=package_mapping,
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="input.xlsx",
        )

        self.assertEqual(1, len(rows))
        row = rows[0]
        self.assertEqual("VCAME", row["Project"])
        self.assertEqual("Bug", row["Issue Type"])
        self.assertEqual("High", row["Priority"])
        self.assertEqual("A", row["Bug Severity"])
        self.assertEqual("Monkey专项", row["Test Case"])
        self.assertEqual("Setting", row["Module"])
        self.assertEqual("Setting", row["Components"])
        self.assertEqual("owner.a", row["Assignee"])
        self.assertEqual("dai.lv", row["Reporter"])
        self.assertEqual("V551A-15-250905V60", row["Versions"])
        self.assertNotIn("Affect Project", row)
        self.assertEqual("Previous version exists", row["Previous Version Status"])
        self.assertEqual("100%", row["Previous Version Text"])
        self.assertIn("com.android.settings", row["Summary"])
        self.assertIn("Java (JE)", row["Summary"])
        self.assertIn("[MonkeyAEE]", row["Summary"])
        self.assertIn("Settings crash detail", row["Description"])
        self.assertIn("*Test Case*: Monkey专项", row["Description"])
        self.assertIn("java.lang.NullPointerException", row["Description"])
        self.assertIn("*Package:* com.android.settings", row["Environment"])
        self.assertIn("*Reporter:* dai.lv", row["PS"])
        self.assertIn("*Duplicate Number:* 7", row["PS"])

    def test_build_upload_rows_falls_back_to_package_and_default_values(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "包名": "com.android.wallpaper",
                    "版本": "V551A-15-250905V60",
                    "异常类型": "Java (JE)",
                    "异常进程": "com.android.wallpaper",
                    "详情": "Wallpaper crash detail",
                    "次数": 75,
                    "设备数": 3,
                }
            ]
        )
        defaults = {
            "project_key": "VFFCA",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="input.xlsx",
        )

        self.assertEqual(1, len(rows))
        row = rows[0]
        self.assertEqual("System Stability", row["Module"])
        self.assertEqual("System Stability", row["Components"])
        self.assertEqual("autotest", row["Assignee"])
        self.assertEqual("B", row["Bug Severity"])
        self.assertEqual("Medium", row["Priority"])
        self.assertEqual("Monkey专项", row["Test Case"])
        self.assertNotIn("Affect Project", row)

    def test_build_upload_rows_derives_severity_from_rules_when_excel_missing(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "V552AA-15-250905V60",
                    "Exp Class": "Java (JE)",
                    "Exp Type": "NullPointerException",
                    "Process": "com.android.settings",
                    "Detail": "Settings crash detail",
                    "Count": 9,
                    "DeviceCount": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }
        severity_rules = [
            {
                "level": "A",
                "keyword": "Java",
                "operator": ">=",
                "threshold": 5,
            }
        ]

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            severity_rules=severity_rules,
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="input.xlsx",
        )

        self.assertEqual("A", rows[0]["Bug Severity"])
        self.assertEqual("High", rows[0]["Priority"])

    def test_build_upload_rows_uses_row_test_case_name_before_cli_default(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "CurProcess": "com.android.settings",
                    "Detail": "Settings crash detail",
                    "Count": 3,
                    "DeviceCount": 1,
                    "TestCase": "MTBF专项",
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {
                "Monkey专项": "MonkeyAEE",
                "MTBF专项": "MTBF",
            },
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            test_case_summary_mapping={
                "Monkey专项": {"index": "0"},
                "MTBF专项": {"index": "1"},
            },
            default_test_case="Monkey专项",
            source_excel_path="input.xlsx",
        )

        self.assertEqual("MTBF专项", rows[0]["Test Case"])
        self.assertIn("[MTBF]", rows[0]["Summary"])

    def test_build_upload_rows_supports_row_test_case_index(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "CurProcess": "com.android.settings",
                    "Detail": "Settings crash detail",
                    "Count": 3,
                    "DeviceCount": 1,
                    "TestCase": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {
                "Monkey专项": "MonkeyAEE",
                "MTBF专项": "MTBF",
            },
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            test_case_summary_mapping={
                "Monkey专项": {"index": "0"},
                "MTBF专项": {"index": "1"},
            },
            default_test_case="Monkey专项",
            source_excel_path="input.xlsx",
        )

        self.assertEqual("MTBF专项", rows[0]["Test Case"])
        self.assertIn("[MTBF]", rows[0]["Summary"])

    def test_build_upload_rows_supports_row_test_case_index_zero(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "CurProcess": "com.android.settings",
                    "Detail": "Settings crash detail",
                    "Count": 3,
                    "DeviceCount": 1,
                    "TestCase": 0,
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "MTBF专项",
            "test_case_label_mapping": {
                "Monkey专项": "MonkeyAEE",
                "MTBF专项": "MTBF",
            },
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            test_case_summary_mapping={
                "Monkey专项": {"index": "0"},
                "MTBF专项": {"index": "1"},
            },
            default_test_case="MTBF专项",
            source_excel_path="input.xlsx",
        )

        self.assertEqual("Monkey专项", rows[0]["Test Case"])
        self.assertIn("[MonkeyAEE]", rows[0]["Summary"])

    def test_build_upload_rows_supports_raw_monkey_report_column_names(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Path": "/home/jxtinno/sonic_tinno/MLD-LX2/logs/aee_exp/__exp_main.txt",
                    "Package": "system_server",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "ExpType ": "system_server_crash",
                    "CurProcess": "system_server",
                    "Detail": "raw monkey detail",
                    "CausedBy": "java.lang.RuntimeException",
                    "Count": 1,
                    "DeviceCount": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VFFCA",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {"Monkey专项": "MonkeyAEE"},
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }
        affect_project_mapping = {
            "MLD-LX2": {
                "jira_project": "VFFCA",
                "affect_project": "MLD-LX2",
                "monkey_project": "VFFCA",
            }
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            affect_project_mapping=affect_project_mapping,
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="Result_None_None_MonkeyAEE_SH_20260521.xls",
        )

        self.assertIn("[Java (JE)]", rows[0]["Summary"])
        self.assertNotIn("[Unknown]", rows[0]["Summary"])
        self.assertIn("*ExpClass:* Java (JE)", rows[0]["Environment"])
        self.assertIn("*ExpType:* system_server_crash", rows[0]["Environment"])
        self.assertIn("*Path:* 220.175.120.251/MLD-LX2/logs/aee_exp/__exp_main.txt", rows[0]["PS"])
        self.assertIn("*220.175.120.251 日志服务器访问方式：*", rows[0]["PS"])
        self.assertIn("文件管理器中输入ftp://172.21.15.4", rows[0]["PS"])
        self.assertIn("使用filezilla工具连接 地址：220.175.120.251", rows[0]["PS"])

    def test_build_upload_rows_ps_embeds_password_from_env_without_whitelist(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Path": "/home/jxtinno/sonic_tinno/MLD-LX2/logs/aee_exp/__exp_main.txt",
                    "Package": "system_server",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "ExpType ": "system_server_crash",
                    "CurProcess": "system_server",
                    "Detail": "raw monkey detail",
                    "CausedBy": "java.lang.RuntimeException",
                    "Count": 1,
                    "DeviceCount": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VFFCA",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }

        with mock.patch.dict("os.environ", {"TINNO_LOG_SERVER_PASSWORD": "direct-password"}, clear=False):
            rows = upload_common.build_upload_rows(
                main_df=main_df,
                defaults=defaults,
                package_mapping={},
                test_case_summary_mapping={"Monkey专项": {"index": "0"}},
                default_test_case="Monkey专项",
                source_excel_path="Result_None_None_MonkeyAEE_SH_20260521.xls",
            )

        self.assertIn("密码：direct-password", rows[0]["PS"])

    def test_build_upload_rows_resolves_project_from_mapping_without_affect_project_column(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "V552AA-15-250905V60",
                    "Exp Class": "Java (JE)",
                    "Process": "com.android.settings",
                    "Detail": "Settings crash detail",
                    "Count": 1,
                    "DeviceCount": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {"Monkey专项": "MonkeyAEE"},
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }
        affect_project_mapping = {
            "V552AA": {
                "jira_project": "VFFCA",
                "affect_project": "V552AA",
                "monkey_project": "VFFCA",
            }
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            affect_project_mapping=affect_project_mapping,
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="Result_None_None_MonkeyAEE_SH_20260521.xls",
        )

        self.assertEqual("VFFCA", rows[0]["Project"])
        self.assertNotIn("Affect Project", rows[0])

    def test_build_upload_rows_resolves_mld_lx2_versions_to_vffca_project(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.systemui",
                    "Version": "MLD-LX2-16-260518V3",
                    "Exp Class": "Java (JE)",
                    "Process": "com.android.systemui",
                    "Detail": "SystemUI crash detail",
                    "Count": 2,
                    "DeviceCount": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {"Monkey专项": "MonkeyAEE"},
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }
        affect_project_mapping = {
            "MLD-LX2": {
                "jira_project": "VFFCA",
                "affect_project": "MLD-LX2",
                "monkey_project": "VFFCA",
            }
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            affect_project_mapping=affect_project_mapping,
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="Result_None_None_MonkeyAEE_SH_20260521.xls",
        )

        self.assertEqual("VFFCA", rows[0]["Project"])
        self.assertTrue(rows[0]["Summary"].startswith("[自动化][V552AA]"))

    def test_build_upload_rows_environment_prefers_detail_package_and_process(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.wallpaper",
                    "Version": "MLD-LX2-16-260518V3",
                    "ExpClass": "Java (JE)",
                    "ExpType ": "system_app_crash",
                    "CurProcess": "com.android.wallpaper",
                    "Detail": "\n".join(
                        [
                            "设备版本：['MLD-LX2-16-260518V3']",
                            "异常包名：['com.android.wallpaper v36 (16)']",
                            "异常进程：['com.android.wallpaper']",
                        ]
                    ),
                    "CausedBy": "java.lang.RuntimeException",
                    "Count": 65,
                    "DeviceCount": 39,
                }
            ]
        )
        defaults = {
            "project_key": "VFFCA",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "autotest",
            "default_bug_severity": "B",
            "default_test_case": "Monkey专项",
            "test_case_label_mapping": {"Monkey专项": "MonkeyAEE"},
            "default_module_fallback": "System Stability",
            "default_previous_version_status": "Previous version exists",
            "default_previous_version_text": "100%",
        }

        rows = upload_common.build_upload_rows(
            main_df=main_df,
            defaults=defaults,
            package_mapping={},
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
            source_excel_path="Result_None_None_MonkeyAEE_SH_20260521.xls",
        )

        self.assertIn("*Package:* ['com.android.wallpaper v36 (16)']", rows[0]["Environment"])
        self.assertIn("*CurProcess:* ['com.android.wallpaper']", rows[0]["Environment"])

    def test_save_upload_list_writes_excel_file(self) -> None:
        rows = [
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Assignee": "owner.a",
                "Module": "Setting",
                "Priority": "High",
                "Description": "detail",
                "key_information": "caused by",
                "Environment": "*Package:* com.android.settings",
                "PS": "*Reporter:* dai.lv",
                "Bug Severity": "A",
                "Previous Version Status": "Previous version exists",
            }
        ]

        with tempfile.TemporaryDirectory() as temp_dir:
            output_path = Path(temp_dir) / "upload.xlsx"
            saved = upload_common.save_upload_list(rows, output_path)
            df = pd.read_excel(saved, engine="openpyxl")
            self.assertTrue(saved.exists())

        self.assertEqual("summary", df.loc[0, "Summary"])
        self.assertEqual("Setting", df.loc[0, "Module"])


if __name__ == "__main__":
    unittest.main()
