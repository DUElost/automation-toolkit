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

        jql = module.build_jql(
            ["KO5OS16AEE"], "target.reporter", empty_field_id="customfield_15400"
        )

        self.assertIn('project = "KO5OS16AEE"', jql)
        self.assertIn('reporter = "target.reporter"', jql)
        self.assertIn("cf[15400] is EMPTY", jql)
        self.assertNotIn("project in", jql)

    def test_build_jql_falls_back_to_field_name_without_id(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        jql = module.build_jql(["KO5OS16AEE"], "target.reporter")

        self.assertIn('"必解标签" is EMPTY', jql)

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

    def test_build_jql_supports_exclude_priority_names(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        jql = module.build_jql(
            ["KO5OS16AEE"],
            "target.reporter",
            exclude_priority_names=["Major"],
        )

        self.assertIn('(priority != "Major" OR priority is EMPTY)', jql)

    def test_parse_args_supports_exclude_priority_name(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        with patch.object(
            sys,
            "argv",
            [
                "set_mp_block.py",
                "--project-key",
                "KO5OS16AEE",
                "--exclude-priority-name",
                "Major",
                "Minor",
            ],
        ):
            args = module.parse_args()

        self.assertEqual(args.exclude_priority_name, ["Major", "Minor"])

    def test_main_defaults_to_blocker_priority(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        with patch.object(
            sys, "argv", ["set_mp_block.py", "--project-key", "KO5OS16AEE"]
        ), patch.object(
            module.common, "get_jira_credentials", return_value=("user", "pass")
        ), patch.object(
            module.common, "connect_to_jira", return_value=object()
        ), patch.object(
            module.common, "set_block_labels"
        ) as mock_set:
            module.main()

        kwargs = mock_set.call_args.kwargs
        self.assertEqual(kwargs["priority_name"], ["Blocker"])
        self.assertIsNone(kwargs["exclude_priority_names"])

    def test_main_cli_priority_overrides_default(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        with patch.object(
            sys,
            "argv",
            [
                "set_mp_block.py",
                "--project-key",
                "KO5OS16AEE",
                "--priority-name",
                "Critical",
            ],
        ), patch.object(
            module.common, "get_jira_credentials", return_value=("user", "pass")
        ), patch.object(
            module.common, "connect_to_jira", return_value=object()
        ), patch.object(
            module.common, "set_block_labels"
        ) as mock_set:
            module.main()

        kwargs = mock_set.call_args.kwargs
        self.assertEqual(kwargs["priority_name"], ["Critical"])
        self.assertIsNone(kwargs["exclude_priority_names"])

    def test_build_jql_includes_existing_not_mp_block(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        jql = module.build_jql(
            ["KO5OS16AEE"],
            "target.reporter",
            empty_field_id="customfield_15400",
            include_existing_values=["Not MP Block"],
        )

        self.assertIn(
            '(cf[15400] is EMPTY OR cf[15400] in ("Not MP Block"))',
            jql,
        )

    def test_main_defaults_include_existing_not_mp_block(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        with patch.object(
            sys, "argv", ["set_mp_block.py", "--project-key", "KO5OS16AEE"]
        ), patch.object(
            module.common, "get_jira_credentials", return_value=("user", "pass")
        ), patch.object(
            module.common, "connect_to_jira", return_value=object()
        ), patch.object(
            module.common, "set_block_labels"
        ) as mock_set:
            module.main()

        kwargs = mock_set.call_args.kwargs
        self.assertEqual(kwargs["include_existing_values"], ["Not MP Block"])
        self.assertEqual(kwargs["priority_name"], ["Blocker"])

    def test_extract_option_values(self):
        module = load_module("set_mp_block.py", "set_mp_block")

        self.assertEqual(module.common.extract_option_values(None), [])
        self.assertEqual(
            module.common.extract_option_values({"value": "MP Block", "id": "1"}),
            ["MP Block"],
        )
        self.assertEqual(
            module.common.extract_option_values(
                [{"value": "Not MP Block", "id": "1"}, {"value": "MP Block", "id": "2"}]
            ),
            ["Not MP Block", "MP Block"],
        )


if __name__ == "__main__":
    unittest.main()
