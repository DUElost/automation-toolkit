from pathlib import Path
import importlib.util
import unittest


def load_module():
    script_path = Path(__file__).with_name("verify_resolved_issues.py")
    if not script_path.exists():
        raise FileNotFoundError(f"缺少脚本: {script_path}")

    spec = importlib.util.spec_from_file_location("verify_resolved_issues", script_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class FakeIssue:
    def __init__(self, key):
        self.key = key


class FakeJira:
    def __init__(self, transitions_by_issue=None):
        self.transitions_by_issue = transitions_by_issue or {}
        self.transition_calls = []

    def transitions(self, issue_key):
        return self.transitions_by_issue.get(issue_key, [])

    def transition_issue(self, issue_key, **kwargs):
        self.transition_calls.append((issue_key, kwargs))


class VerifyResolvedIssuesScriptTest(unittest.TestCase):
    def test_build_jql_for_single_reporter(self):
        module = load_module()

        self.assertEqual(module.VERIFY_TRANSITION_NAME, "VerifyIssue")
        self.assertEqual(module.VERIFY_COMMENT, "按照原单测试步骤验证。")
        jql = module.build_jql(["KO5OS16AEE"], ["target.reporter"])
        self.assertIn('project in ("KO5OS16AEE")', jql)
        self.assertIn('status = "Resolved"', jql)
        self.assertIn('reporter = "target.reporter"', jql)
        self.assertNotIn("reporter in", jql)
        self.assertTrue(jql.endswith("ORDER BY created DESC"))

    def test_parse_args_supports_multiple_project_keys_and_reporter(self):
        module = load_module()

        args = module.parse_args(
            ["--project-keys", "KO5OS16AEE", "KO5OS16BEE", "--reporter", "target.reporter"]
        )

        self.assertEqual(args.project_keys, ["KO5OS16AEE", "KO5OS16BEE"])
        self.assertEqual(args.reporter, ["target.reporter"])

    def test_build_jql_for_multiple_reporters(self):
        module = load_module()

        jql = module.build_jql(
            ["KO5OS16AEE", "KO5OS16BEE"],
            ["user.one", "user.two"],
        )

        self.assertIn('project in ("KO5OS16AEE", "KO5OS16BEE")', jql)
        self.assertIn('reporter in ("user.one", "user.two")', jql)

    def test_parse_args_supports_multiple_reporters(self):
        module = load_module()

        args = module.parse_args(
            [
                "--project-keys", "KO5OS16AEE", "KO5OS16BEE",
                "--reporter", "user.one", "user.two",
            ]
        )

        self.assertEqual(args.project_keys, ["KO5OS16AEE", "KO5OS16BEE"])
        self.assertEqual(args.reporter, ["user.one", "user.two"])

    def test_parse_args_requires_reporter(self):
        module = load_module()

        with self.assertRaises(SystemExit):
            module.parse_args(["--project-keys", "KO5OS16AEE"])

    def test_find_verify_transition_only_matches_verify_issue(self):
        module = load_module()

        transition = module.find_verify_transition(
            [
                {"id": "11", "name": "ResolveIssue", "to": {"name": "Resolved"}},
                {"id": "21", "name": "VerifyIssue", "to": {"name": "Verified"}},
            ]
        )

        self.assertEqual(transition["id"], "21")

    def test_transition_issue_to_verified_uses_fixed_comment(self):
        module = load_module()
        client = FakeJira(
            transitions_by_issue={
                "KO5OS16AEE-100": [
                    {"id": "21", "name": "VerifyIssue", "to": {"name": "Verified"}}
                ]
            }
        )

        result = module.transition_issue_to_verified(client, FakeIssue("KO5OS16AEE-100"))

        self.assertTrue(result)
        self.assertEqual(
            client.transition_calls,
            [
                (
                    "KO5OS16AEE-100",
                    {"transition": "21", "comment": "按照原单测试步骤验证。"},
                )
            ],
        )


if __name__ == "__main__":
    unittest.main()
