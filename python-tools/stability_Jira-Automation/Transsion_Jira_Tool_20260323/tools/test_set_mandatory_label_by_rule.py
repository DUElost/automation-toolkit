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


class SetMandatoryLabelByRuleScriptTest(unittest.TestCase):
    def test_parse_total_number_supports_square_and_fullwidth_brackets(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertEqual(module.parse_total_number("abc [Total Number 21] xyz"), 21)
        self.assertEqual(module.parse_total_number("abc 【Total Number 27】 xyz"), 27)

    def test_parse_total_number_returns_none_when_missing(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertIsNone(module.parse_total_number("abc without marker"))

    def test_determine_target_label_for_blocker_is_mp_block(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        result = module.determine_target_label("Blocker", "JE", 1)

        self.assertEqual(result, ("MP Block", None))

    def test_determine_target_label_supports_localized_priority_names(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertEqual(
            module.determine_target_label("紧急", "SWT", 1),
            ("MP Block", None),
        )
        self.assertEqual(
            module.determine_target_label("严重", "JE", 20),
            ("MP Block", None),
        )

    def test_determine_target_label_for_critical_uses_thresholds(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertEqual(
            module.determine_target_label("Critical", "JE", 20),
            ("MP Block", None),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "NE", 21),
            ("MP Block", None),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "ANR", 50),
            ("MP Block", None),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "ANR", 49),
            ("Not MP Block", None),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "OTHER", 10),
            ("Not MP Block", None),
        )

    def test_determine_target_label_supports_expclass_aliases(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertEqual(
            module.determine_target_label("Critical", "Native (NE)", 20),
            ("MP Block", None),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "Java (JE)", 20),
            ("MP Block", None),
        )

    def test_determine_target_label_marks_fail_when_total_number_missing(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        result = module.determine_target_label("Critical", "JE", None)

        self.assertEqual(result, (None, "summary_missing_total_number"))

    def test_build_failure_message_shows_actual_reason_and_summary(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        rule_info = {
            "priority_name": "Critical",
            "exp_class": "JE",
            "total_number": None,
            "target_label": None,
            "fail_reason": "summary_missing_total_number",
            "summary": "[Total Number 1] [MonkeyAEE] SWT system_server",
        }

        message = module.build_failure_message("X1103AEE-413", rule_info)

        self.assertIn("summary_missing_total_number", message)
        self.assertIn("priority=Critical", message)
        self.assertIn("exp_class=JE", message)
        self.assertIn("[Total Number 1]", message)

    def test_build_scope_jql_uses_fixed_ab_priority_scope(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        jql = module.build_scope_jql(
            ["X6852OS16", "X6851OS16"],
            ["dailv.tinno", "qimingwang.tinno"],
            component_name="3RD_Stability",
        )

        self.assertIn('project in ("X6852OS16", "X6851OS16")', jql)
        self.assertIn('reporter in ("dailv.tinno", "qimingwang.tinno")', jql)
        self.assertIn('priority in ("Blocker", "Critical")', jql)
        self.assertIn('component = "3RD_Stability"', jql)
        self.assertIn('resolution is EMPTY OR resolution not in (', jql)
        self.assertIn('"Won\'t Fix"', jql)
        self.assertIn('"Cannot Reproduce"', jql)
        self.assertIn('"Platform Limit"', jql)
        self.assertIn('"不能修复"', jql)
        self.assertIn('"无法再次复现"', jql)

    def test_determine_target_label_skips_specific_resolution_results(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertEqual(
            module.determine_target_label("Critical", "JE", 20, "Won't Fix"),
            (None, "skipped_resolution"),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "JE", 20, "Cannot Reproduce"),
            (None, "skipped_resolution"),
        )
        self.assertEqual(
            module.determine_target_label("Critical", "JE", 20, "Platform Limit"),
            (None, "skipped_resolution"),
        )

    def test_extract_label_values_and_validation(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        self.assertEqual(
            module.extract_label_values([{"value": "MP Block"}]),
            ["MP Block"],
        )
        self.assertEqual(
            module.extract_label_values(
                [{"value": "MP Block"}, {"value": "Not MP Block"}]
            ),
            ["MP Block", "Not MP Block"],
        )
        self.assertFalse(module.has_exactly_one_label([]))
        self.assertTrue(module.has_exactly_one_label(["MP Block"]))
        self.assertFalse(module.has_exactly_one_label(["MP Block", "Not MP Block"]))

    def test_parse_args_supports_multiple_project_keys_and_reporters(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        with patch.object(
            sys,
            "argv",
            [
                "set_mandatory_label_by_rule.py",
                "--project-key",
                "X6852OS16",
                "X6851OS16",
                "--report-username",
                "dailv.tinno",
                "qimingwang.tinno",
            ],
        ):
            args = module.parse_args()

        self.assertEqual(args.project_key, ["X6852OS16", "X6851OS16"])
        self.assertEqual(args.report_username, ["dailv.tinno", "qimingwang.tinno"])
        self.assertFalse(hasattr(args, "priority_name"))

    def test_parse_args_supports_dry_run(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        with patch.object(
            sys,
            "argv",
            [
                "set_mandatory_label_by_rule.py",
                "--project-key",
                "X6852OS16",
                "--dry-run",
            ],
        ):
            args = module.parse_args()

        self.assertTrue(args.dry_run)

    def test_update_issue_mandatory_label_dry_run_does_not_call_issue_update(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        class FakeIssue:
            def __init__(self):
                self.key = "X6852OS16-1"
                self.raw = {"fields": {"customfield_1": None}}
                self.update_called = False

            def update(self, **kwargs):
                self.update_called = True

        fake_issue = FakeIssue()
        fake_field_info = {"schema": {"type": "option"}, "allowedValues": []}

        with patch.object(
            module,
            "get_issue_target_field_meta",
            return_value=("customfield_1", fake_field_info),
        ), patch.object(
            module,
            "get_issue_field_value",
            return_value=None,
        ):
            updated, reason = module.update_issue_mandatory_label(
                client=None,
                issue=fake_issue,
                target_field_id="customfield_1",
                target_value="MP Block",
                dry_run=True,
            )

        self.assertTrue(updated)
        self.assertEqual(reason, "dry_run")
        self.assertFalse(fake_issue.update_called)

    def test_update_issue_not_mp_block_skips_when_label_already_has_value(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        class FakeIssue:
            def __init__(self):
                self.key = "X6852OS16-2"
                self.raw = {"fields": {"customfield_1": [{"value": "MP Block"}]}}
                self.update_called = False

            def update(self, **kwargs):
                self.update_called = True

        fake_issue = FakeIssue()
        fake_field_info = {"schema": {"type": "array"}, "allowedValues": []}

        with patch.object(
            module,
            "get_issue_target_field_meta",
            return_value=("customfield_1", fake_field_info),
        ), patch.object(
            module,
            "get_issue_field_value",
            return_value=[{"value": "MP Block"}],
        ):
            updated, reason = module.update_issue_mandatory_label(
                client=None,
                issue=fake_issue,
                target_field_id="customfield_1",
                target_value="Not MP Block",
            )

        self.assertFalse(updated)
        self.assertEqual(reason, "existing_value")
        self.assertFalse(fake_issue.update_called)

    def test_validate_scope_labels_in_dry_run_only_checks_multiple_values(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        class FakeIssue:
            def __init__(self, key, label_value):
                self.key = key
                self.raw = {"fields": {"customfield_1": label_value}}

        issues = [
            FakeIssue("X6852OS16-1", None),
            FakeIssue("X6852OS16-2", [{"value": "MP Block"}, {"value": "Not MP Block"}]),
        ]

        with patch.object(module, "find_all_scope_issues", return_value=issues):
            with self.assertRaises(AssertionError) as ctx:
                module.validate_scope_labels(
                    client=None,
                    project_key=["X6852OS16"],
                    reporter=["dailv.tinno"],
                    target_field_id="customfield_1",
                    require_non_empty=False,
                )

        self.assertIn("必解标签存在多个值", str(ctx.exception))
        self.assertNotIn("必解标签为空", str(ctx.exception))

    def test_validate_scope_labels_excludes_known_failure_keys(self):
        module = load_module("set_mandatory_label_by_rule.py", "set_mandatory_label_by_rule")

        class FakeIssue:
            def __init__(self, key, label_value):
                self.key = key
                self.raw = {"fields": {"customfield_1": label_value}}

        issues = [
            FakeIssue("X6852OS16-1", None),
            FakeIssue("X6852OS16-2", [{"value": "MP Block"}]),
        ]

        with patch.object(module, "find_all_scope_issues", return_value=issues):
            module.validate_scope_labels(
                client=None,
                project_key=["X6852OS16"],
                reporter=["dailv.tinno"],
                target_field_id="customfield_1",
                require_non_empty=True,
                exclude_keys={"X6852OS16-1"},
            )


if __name__ == "__main__":
    unittest.main()
