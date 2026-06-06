from pathlib import Path
from unittest.mock import patch
import importlib.util
import sys
import unittest


def load_module(file_name, module_name):
    script_path = Path(__file__).with_name(file_name)
    if not script_path.exists():
        raise FileNotFoundError(f"缺少脚本: {script_path}")

    spec = importlib.util.spec_from_file_location(module_name, script_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class SetMpBlockScriptTest(unittest.TestCase):
    def test_set_mp_block_script_uses_mp_block_value(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        self.assertEqual(module.TARGET_FIELD_VALUE, "MP Block")

    def test_build_jql_for_single_project(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        jql = module.build_jql(["KO5OS16AEE"], "target.reporter")

        self.assertIn('project = "KO5OS16AEE"', jql)
        self.assertIn('reporter = "target.reporter"', jql)
        self.assertNotIn("project in", jql)

    def test_build_jql_for_multiple_projects(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        jql = module.build_jql(["KO5OS16AEE", "KO5OS16BEE"], "target.reporter")

        self.assertIn('project in ("KO5OS16AEE", "KO5OS16BEE")', jql)

    def test_build_jql_for_multiple_reporters(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        jql = module.build_jql(
            ["KO5OS16AEE"],
            ["dailv.tinno", "qimingwang.tinno"],
        )

        self.assertIn(
            'reporter in ("dailv.tinno", "qimingwang.tinno")',
            jql,
        )

    def test_parse_args_supports_multiple_project_keys(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        with patch.object(
            sys,
            "argv",
            ["set_mp_block.py", "--project-key", "KO5OS16AEE", "KO5OS16BEE"],
        ):
            args = module.parse_args()

        self.assertEqual(args.project_key, ["KO5OS16AEE", "KO5OS16BEE"])

    def test_parse_args_supports_multiple_report_usernames(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        with patch.object(
            sys,
            "argv",
            [
                "set_mp_block.py",
                "--project-key",
                "KO5OS16AEE",
                "--report-username",
                "dailv.tinno",
                "qimingwang.tinno",
            ],
        ):
            args = module.parse_args()

        self.assertEqual(args.report_username, ["dailv.tinno", "qimingwang.tinno"])


if __name__ == "__main__":
    unittest.main()
