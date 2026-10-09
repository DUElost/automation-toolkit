import json
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

import init_tinno_project as init_module
import tinno_upload_template_common as upload_common


class InitTinnoProjectTest(unittest.TestCase):
    def test_parse_customer_projects_splits_and_uppercases(self) -> None:
        self.assertEqual(
            ["PFDFAA", "MLD-LX2", "V552AA"],
            init_module.parse_customer_projects(" pfdFAA，MLD-LX2; V552AA pfdFAA "),
        )

    def test_infer_summary_product_prefers_product_code(self) -> None:
        self.assertEqual("PFDFAA", init_module.infer_summary_product(["PFDFAA"], "PFDFAA"))
        self.assertEqual("V552AA", init_module.infer_summary_product(["MLD-LX2", "V552AA"], "VFFCA"))
        self.assertEqual("VFFCA", init_module.infer_summary_product(["MLD-LX2"], "VFFCA"))
        self.assertEqual("PFDFAA", init_module.infer_summary_product(["MLD-NX2"], "PFDFAA"))

    def test_extract_component_assignee_prefers_real_assignee(self) -> None:
        component = {
            "name": "AUTOTEST",
            "realAssignee": {"name": "real.user"},
            "lead": {"name": "lead.user"},
        }
        self.assertEqual("real.user", init_module.extract_component_assignee(component))
        assignees, missing = init_module.extract_component_assignees(
            [
                component,
                {"name": "System", "lead": {"key": "lead.only"}},
                {"name": "Empty"},
            ]
        )
        self.assertEqual({"AUTOTEST": "real.user", "System": "lead.only"}, assignees)
        self.assertEqual(["Empty"], missing)

    def test_register_project_writes_mappings_without_dropping_existing_projects(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            affect_path = root / "affect_project_mapping.json"
            summary_path = root / "summary_product_mapping.json"
            module_path = root / "module_assignee_mapping.json"
            affect_path.write_text(
                json.dumps({"V552AA": {"jira_project": "VFFCA", "monkey_project": "VFFCA"}}, ensure_ascii=False),
                encoding="utf-8",
            )
            summary_path.write_text(json.dumps({"MLD-LX2": "V552AA"}, ensure_ascii=False), encoding="utf-8")
            module_path.write_text(json.dumps({"VFFCA": {"AUTOTEST": "old.user"}}, ensure_ascii=False), encoding="utf-8")

            result = init_module.register_project(
                customer_projects=["PFDFAA"],
                jira_key="PFDFAA",
                summary_product="PFDFAA",
                components=[{"name": "AUTOTEST", "realAssignee": {"name": "dai.lv"}}],
                affect_mapping_path=affect_path,
                summary_mapping_path=summary_path,
                module_assignee_path=module_path,
            )

            affect_data = json.loads(affect_path.read_text(encoding="utf-8"))
            summary_data = json.loads(summary_path.read_text(encoding="utf-8"))
            module_data = json.loads(module_path.read_text(encoding="utf-8"))
            self.assertEqual("VFFCA", affect_data["V552AA"]["jira_project"])
            self.assertEqual("PFDFAA", affect_data["PFDFAA"]["jira_project"])
            self.assertEqual("PFDFAA", summary_data["PFDFAA"])
            self.assertEqual("V552AA", summary_data["MLD-LX2"])
            self.assertEqual({"AUTOTEST": "dai.lv"}, module_data["PFDFAA"])
            self.assertEqual({"AUTOTEST": "old.user"}, module_data["VFFCA"])
            self.assertEqual({"AUTOTEST": "dai.lv"}, result["assignees"])

    def test_register_project_refuses_to_retarget_existing_prefix(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            affect_path = root / "affect_project_mapping.json"
            affect_path.write_text(
                json.dumps({"PFDFAA": {"jira_project": "VCAME", "monkey_project": "VCAME"}}, ensure_ascii=False),
                encoding="utf-8",
            )
            with self.assertRaises(ValueError):
                init_module.register_project(
                    customer_projects=["PFDFAA"],
                    jira_key="PFDFAA",
                    summary_product="PFDFAA",
                    components=[],
                    affect_mapping_path=affect_path,
                    summary_mapping_path=root / "summary.json",
                    module_assignee_path=root / "modules.json",
                )
            self.assertEqual("VCAME", json.loads(affect_path.read_text(encoding="utf-8"))["PFDFAA"]["jira_project"])

    def test_prepare_workspace_writes_copies_and_leaves_official_config(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            official = root / "official"
            workspace = root / "workspace"
            official.mkdir()
            affect_source = official / "affect_project_mapping.json"
            summary_source = official / "summary_product_mapping.json"
            module_source = official / "module_assignee_mapping.json"
            affect_source.write_text('{"V552AA": {"jira_project": "VFFCA", "monkey_project": "VFFCA"}}\n', encoding="utf-8")
            summary_source.write_text('{"MLD-LX2": "V552AA"}\n', encoding="utf-8")
            module_source.write_text("{}\n", encoding="utf-8")
            official_before = {
                path.name: path.read_text(encoding="utf-8")
                for path in (affect_source, summary_source, module_source)
            }

            with mock.patch.object(init_module, "DEFAULT_AFFECT_PROJECT_MAPPING", affect_source):
                with mock.patch.object(init_module, "SUMMARY_PRODUCT_MAPPING_FILE", summary_source):
                    with mock.patch.object(init_module, "DEFAULT_MODULE_ASSIGNEE_MAPPING", module_source):
                        paths = init_module.prepare_workspace(workspace)
                        init_module.register_project(
                            customer_projects=["PFDFAA"],
                            jira_key="PFDFAA",
                            summary_product="PFDFAA",
                            components=[{"name": "AUTOTEST", "realAssignee": {"name": "dai.lv"}}],
                            affect_mapping_path=paths["affect"],
                            summary_mapping_path=paths["summary"],
                            module_assignee_path=paths["module"],
                        )

            for path, original in (
                (affect_source, official_before["affect_project_mapping.json"]),
                (summary_source, official_before["summary_product_mapping.json"]),
                (module_source, official_before["module_assignee_mapping.json"]),
            ):
                self.assertEqual(original, path.read_text(encoding="utf-8"))
            workspace_affect = json.loads(paths["affect"].read_text(encoding="utf-8"))
            self.assertEqual("PFDFAA", workspace_affect["PFDFAA"]["jira_project"])
            self.assertEqual("VFFCA", workspace_affect["V552AA"]["jira_project"])
            self.assertIn("PFDFAA", json.loads(paths["module"].read_text(encoding="utf-8")))

    def test_collect_project_inputs_uses_cli_values_without_prompt(self) -> None:
        args = Namespace(customer_project="pfdFAA", jira_key="pfdFAA", summary_product=None)
        customer_projects, jira_key, summary_product = init_module.collect_project_inputs(args)
        self.assertEqual(["PFDFAA"], customer_projects)
        self.assertEqual("PFDFAA", jira_key)
        self.assertEqual("PFDFAA", summary_product)

    def test_build_upload_rows_uses_jira_component_assignee(self) -> None:
        main_df = pd.DataFrame(
            [
                {
                    "Package": "com.android.settings",
                    "Version": "PFDFAA-16-261009V1",
                    "Exp Class": "Java (JE)",
                    "Process": "com.android.settings",
                    "Detail": "settings crash",
                    "Count": 1,
                    "DeviceCount": 1,
                }
            ]
        )
        defaults = {
            "project_key": "VCAME",
            "issue_type": "Bug",
            "default_reporter": "dai.lv",
            "default_assignee": "fallback.user",
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
            package_mapping={"com.android.settings": {"module": "Settings", "assignee": "sheet.user"}},
            affect_project_mapping={"PFDFAA": {"jira_project": "PFDFAA", "affect_project": "PFDFAA"}},
            module_assignee_mapping={"PFDFAA": {"Settings": "jira.user"}},
            test_case_summary_mapping={"Monkey专项": {"index": "0"}},
            default_test_case="Monkey专项",
        )
        self.assertEqual("PFDFAA", rows[0]["Project"])
        self.assertEqual("Settings", rows[0]["Module"])
        self.assertEqual("jira.user", rows[0]["Assignee"])
        self.assertTrue(rows[0]["Summary"].startswith("[自动化][PFDFAA]"))
