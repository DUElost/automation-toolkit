import os
import sys
import tempfile
import unittest
from argparse import Namespace
from pathlib import Path
from unittest import mock

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

import generate_tinno_jira_upload_list as generate_module


class _FixedDatetime:
    @staticmethod
    def now():
        class _Now:
            @staticmethod
            def strftime(_format: str) -> str:
                return "20260522_101010"

        return _Now()


class GenerateTinnoUploadListTest(unittest.TestCase):
    def test_load_local_env_reads_tinno_log_server_password(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            env_file = Path(temp_dir) / ".env.local"
            env_file.write_text("TINNO_LOG_SERVER_PASSWORD=direct-password", encoding="utf-8")
            with mock.patch.dict("os.environ", {}, clear=True):
                generate_module.load_local_env(env_file)
                self.assertEqual("direct-password", os.environ.get("TINNO_LOG_SERVER_PASSWORD"))

    def test_main_passes_overrides_into_build_upload_rows(self) -> None:
        args = Namespace(
            main_excel_path="input.xlsx",
            output_path="custom-output.xlsx",
            config_file="config.json",
            package_mapping_file="mapping.xlsx",
            severity_rules_file="severity.xlsx",
            affect_project_mapping_file="affect.json",
            test_summary_file="test-summary.xlsx",
            project_key="VFFCA",
            test_case="Monkey专项",
            reporter="reporter.a",
            assignee="assignee.a",
            test_mode=False,
        )
        defaults = {"project_key": "VCAME", "issue_type": "Bug"}

        with mock.patch.object(generate_module, "setup_logging"):
            with mock.patch.object(generate_module, "load_local_env") as load_local_env:
                with mock.patch.object(generate_module, "parse_args", return_value=args):
                    with mock.patch.object(generate_module, "load_defaults", return_value=defaults):
                            with mock.patch.object(generate_module, "read_excel_smart", return_value=pd.DataFrame([{"Package": "pkg"}])):
                                with mock.patch.object(generate_module, "load_package_owner_mapping", return_value={"pkg": {"module": "AUTOTEST", "assignee": "owner"}}):
                                    with mock.patch.object(generate_module, "load_severity_rules", return_value=[{"level": "A"}]) as load_severity:
                                        with mock.patch.object(generate_module, "load_affect_project_mapping", return_value={"V552AA": {"jira_project": "VFFCA"}}) as load_affect:
                                            with mock.patch.object(generate_module, "load_test_case_summary", return_value={"Monkey专项": {"index": "0"}}) as load_test_case_summary:
                                                with mock.patch.object(generate_module, "build_upload_rows", return_value=[{"Summary": "summary"}]) as build_rows:
                                                    with mock.patch.object(generate_module, "save_upload_list", return_value=Path(args.output_path)) as save_upload:
                                                        result = generate_module.main()

        self.assertEqual(0, result)
        self.assertEqual("VFFCA", defaults["project_key"])
        load_local_env.assert_called_once()
        load_severity.assert_called_once_with("severity.xlsx")
        load_affect.assert_called_once_with("affect.json")
        load_test_case_summary.assert_called_once_with("test-summary.xlsx")
        build_kwargs = build_rows.call_args.kwargs
        self.assertEqual("reporter.a", build_kwargs["reporter_override"])
        self.assertEqual("assignee.a", build_kwargs["assignee_override"])
        self.assertEqual("VFFCA", build_kwargs["project_override"])
        self.assertEqual("Monkey专项", build_kwargs["default_test_case"])
        self.assertEqual("input.xlsx", build_kwargs["source_excel_path"])
        self.assertEqual([{"level": "A"}], build_kwargs["severity_rules"])
        self.assertEqual({"V552AA": {"jira_project": "VFFCA"}}, build_kwargs["affect_project_mapping"])
        self.assertEqual({"Monkey专项": {"index": "0"}}, build_kwargs["test_case_summary_mapping"])
        save_upload.assert_called_once_with([{"Summary": "summary"}], "custom-output.xlsx")

    def test_main_uses_default_result_output_path_when_not_provided(self) -> None:
        args = Namespace(
            main_excel_path="input.xlsx",
            output_path=None,
            config_file="config.json",
            package_mapping_file="mapping.xlsx",
            severity_rules_file="severity.xlsx",
            affect_project_mapping_file="affect.json",
            test_summary_file="test-summary.xlsx",
            project_key=None,
            test_case=None,
            reporter=None,
            assignee=None,
            test_mode=False,
        )

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_result_dir = Path(temp_dir) / "result"
            with mock.patch.object(generate_module, "setup_logging"):
                with mock.patch.object(generate_module, "parse_args", return_value=args):
                    with mock.patch.object(generate_module, "load_defaults", return_value={"project_key": "VCAME", "issue_type": "Bug"}):
                            with mock.patch.object(generate_module, "read_excel_smart", return_value=pd.DataFrame([{"Package": "pkg"}])):
                                with mock.patch.object(generate_module, "load_package_owner_mapping", return_value={}):
                                    with mock.patch.object(generate_module, "load_severity_rules", return_value=[]):
                                        with mock.patch.object(generate_module, "load_affect_project_mapping", return_value={}):
                                            with mock.patch.object(generate_module, "load_test_case_summary", return_value={"Monkey专项": {"index": "0"}}):
                                                with mock.patch.object(generate_module, "build_upload_rows", return_value=[{"Summary": "summary", "Test Case": "Monkey专项"}]):
                                                    with mock.patch.object(generate_module, "RESULT_DIR", temp_result_dir):
                                                        with mock.patch.object(generate_module, "datetime", _FixedDatetime):
                                                            with mock.patch.object(generate_module, "save_upload_list", return_value=temp_result_dir / "saved.xlsx") as save_upload:
                                                                result = generate_module.main()

        self.assertEqual(0, result)
        output_path = save_upload.call_args.args[1]
        self.assertEqual(
            str(temp_result_dir / "JIRA_Upload_List_Tinno_Monkey专项_20260522_101010.xlsx"),
            output_path,
        )

    def test_main_uses_multi_test_case_name_in_default_output(self) -> None:
        args = Namespace(
            main_excel_path="input.xlsx",
            output_path=None,
            config_file="config.json",
            package_mapping_file="mapping.xlsx",
            severity_rules_file="severity.xlsx",
            affect_project_mapping_file="affect.json",
            test_summary_file="test-summary.xlsx",
            project_key=None,
            test_case=None,
            reporter=None,
            assignee=None,
            test_mode=False,
        )

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_result_dir = Path(temp_dir) / "result"
            with mock.patch.object(generate_module, "setup_logging"):
                with mock.patch.object(generate_module, "parse_args", return_value=args):
                    with mock.patch.object(generate_module, "load_defaults", return_value={"project_key": "VCAME", "issue_type": "Bug"}):
                        with mock.patch.object(generate_module, "read_excel_smart", return_value=pd.DataFrame([{"Package": "pkg"}])):
                            with mock.patch.object(generate_module, "load_package_owner_mapping", return_value={}):
                                with mock.patch.object(generate_module, "load_severity_rules", return_value=[]):
                                    with mock.patch.object(generate_module, "load_affect_project_mapping", return_value={}):
                                        with mock.patch.object(generate_module, "load_test_case_summary", return_value={"Monkey专项": {"index": "0"}, "MTBF专项": {"index": "1"}}):
                                            with mock.patch.object(
                                                generate_module,
                                                "build_upload_rows",
                                                return_value=[
                                                    {"Summary": "summary-a", "Test Case": "Monkey专项"},
                                                    {"Summary": "summary-b", "Test Case": "MTBF专项"},
                                                ],
                                            ):
                                                with mock.patch.object(generate_module, "RESULT_DIR", temp_result_dir):
                                                    with mock.patch.object(generate_module, "datetime", _FixedDatetime):
                                                        with mock.patch.object(generate_module, "save_upload_list", return_value=temp_result_dir / "saved.xlsx") as save_upload:
                                                            result = generate_module.main()

        self.assertEqual(0, result)
        output_path = save_upload.call_args.args[1]
        self.assertEqual(
            str(temp_result_dir / "JIRA_Upload_List_Tinno_多专项_20260522_101010.xlsx"),
            output_path,
        )

    def test_main_returns_error_when_no_rows_are_generated(self) -> None:
        args = Namespace(
            main_excel_path="input.xlsx",
            output_path="custom-output.xlsx",
            config_file="config.json",
            package_mapping_file="mapping.xlsx",
            severity_rules_file="severity.xlsx",
            affect_project_mapping_file="affect.json",
            test_summary_file="test-summary.xlsx",
            project_key=None,
            test_case=None,
            reporter=None,
            assignee=None,
            test_mode=False,
        )

        with mock.patch.object(generate_module, "setup_logging"):
            with mock.patch.object(generate_module, "parse_args", return_value=args):
                    with mock.patch.object(generate_module, "load_defaults", return_value={"project_key": "VCAME", "issue_type": "Bug"}):
                        with mock.patch.object(generate_module, "read_excel_smart", return_value=pd.DataFrame([{"Package": "pkg"}])):
                            with mock.patch.object(generate_module, "load_package_owner_mapping", return_value={}):
                                with mock.patch.object(generate_module, "load_severity_rules", return_value=[]):
                                    with mock.patch.object(generate_module, "load_affect_project_mapping", return_value={}):
                                        with mock.patch.object(generate_module, "load_test_case_summary", return_value={"Monkey专项": {"index": "0"}}):
                                            with mock.patch.object(generate_module, "build_upload_rows", return_value=[]):
                                                with mock.patch.object(generate_module, "save_upload_list") as save_upload:
                                                    result = generate_module.main()

        self.assertEqual(1, result)
        save_upload.assert_not_called()

    def test_main_test_mode_applies_default_source_user_and_autotest_module(self) -> None:
        args = Namespace(
            main_excel_path=None,
            output_path="custom-output.xlsx",
            config_file="config.json",
            package_mapping_file="mapping.xlsx",
            severity_rules_file="severity.xlsx",
            affect_project_mapping_file="affect.json",
            test_summary_file="test-summary.xlsx",
            project_key=None,
            test_case=None,
            reporter=None,
            assignee=None,
            test_mode=True,
        )
        defaults = {"project_key": "VCAME", "issue_type": "Bug", "default_reporter": "fallback.user"}

        with mock.patch.dict("os.environ", {"JIRA_USERNAME": "current.user"}, clear=False):
            with mock.patch.object(generate_module, "setup_logging"):
                with mock.patch.object(generate_module, "load_local_env"):
                    with mock.patch.object(generate_module, "parse_args", return_value=args):
                            with mock.patch.object(generate_module, "load_defaults", return_value=defaults):
                                with mock.patch.object(generate_module, "read_excel_smart", return_value=pd.DataFrame([{"Package": "pkg"}])) as read_excel:
                                    with mock.patch.object(generate_module, "load_package_owner_mapping", return_value={}):
                                        with mock.patch.object(generate_module, "load_severity_rules", return_value=[]):
                                            with mock.patch.object(generate_module, "load_affect_project_mapping", return_value={}):
                                                with mock.patch.object(generate_module, "load_test_case_summary", return_value={"Monkey专项": {"index": "0"}}):
                                                    with mock.patch.object(generate_module, "build_upload_rows", return_value=[{"Summary": "summary"}]) as build_rows:
                                                        with mock.patch.object(generate_module, "save_upload_list", return_value=Path(args.output_path)):
                                                            result = generate_module.main()

        self.assertEqual(0, result)
        read_excel.assert_called_once_with(str(generate_module.DEFAULT_TEST_MODE_MAIN_EXCEL))
        build_kwargs = build_rows.call_args.kwargs
        self.assertEqual("VCAME", build_kwargs["project_override"])
        self.assertEqual("current.user", build_kwargs["reporter_override"])
        self.assertEqual("current.user", build_kwargs["assignee_override"])
        self.assertEqual("AUTOTEST", build_kwargs["module_override"])
        self.assertEqual("Monkey专项", build_kwargs["default_test_case"])

    def test_main_requires_excel_when_not_test_mode(self) -> None:
        args = Namespace(
            main_excel_path=None,
            output_path="custom-output.xlsx",
            config_file="config.json",
            package_mapping_file="mapping.xlsx",
            severity_rules_file="severity.xlsx",
            affect_project_mapping_file="affect.json",
            test_summary_file="test-summary.xlsx",
            project_key=None,
            test_case=None,
            reporter=None,
            assignee=None,
            test_mode=False,
        )

        with mock.patch.object(generate_module, "setup_logging"):
            with mock.patch.object(generate_module, "load_local_env"):
                with mock.patch.object(generate_module, "parse_args", return_value=args):
                    with mock.patch.object(generate_module, "load_defaults", return_value={"project_key": "VCAME", "issue_type": "Bug"}):
                        with mock.patch.object(generate_module, "read_excel_smart") as read_excel:
                            result = generate_module.main()

        self.assertEqual(1, result)
        read_excel.assert_not_called()


if __name__ == "__main__":
    unittest.main()
