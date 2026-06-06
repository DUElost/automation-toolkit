from pathlib import Path
import importlib.util
import unittest


def load_module():
    script_path = Path(__file__).with_name("remove_verify_comment.py")
    if not script_path.exists():
        raise FileNotFoundError(f"缺少脚本: {script_path}")

    spec = importlib.util.spec_from_file_location("remove_verify_comment", script_path)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class FakeComment:
    def __init__(self, comment_id, body):
        self.id = comment_id
        self.body = body
        self.delete_calls = 0

    def delete(self, params=None):
        self.delete_calls += 1


class FakeIssue:
    def __init__(self, key):
        self.key = key


class FakeJira:
    def __init__(self, comments_by_issue=None, search_results=None):
        self.comments_by_issue = comments_by_issue or {}
        self.search_results = search_results or []
        self.search_calls = []

    def comments(self, issue_key):
        return self.comments_by_issue.get(issue_key, [])

    def search_issues(self, jql, startAt=0, maxResults=50):
        self.search_calls.append((jql, startAt, maxResults))
        return self.search_results[startAt:startAt + maxResults]


class RemoveVerifyCommentScriptTest(unittest.TestCase):
    def test_constants_and_single_issue_args(self):
        module = load_module()

        self.assertEqual(module.TARGET_COMMENT_BODY, "按照原单测试步骤验证。")
        args = module.parse_args(["--issue-key", "KO5OS16AEE-100"])
        self.assertEqual(args.issue_key, "KO5OS16AEE-100")
        self.assertFalse(args.update_all)

    def test_parse_args_supports_batch_mode(self):
        module = load_module()

        args = module.parse_args(
            [
                "--project-keys", "KO5OS16AEE", "KO5OS16BEE",
                "--update-all",
            ]
        )

        self.assertEqual(args.project_keys, ["KO5OS16AEE", "KO5OS16BEE"])
        self.assertTrue(args.update_all)

    def test_parse_args_allows_batch_mode_without_reporter(self):
        module = load_module()

        args = module.parse_args(["--project-keys", "KO5OS16AEE", "--update-all"])

        self.assertEqual(args.project_keys, ["KO5OS16AEE"])
        self.assertTrue(args.update_all)

    def test_find_latest_matching_comment_returns_latest_match(self):
        module = load_module()

        comment = module.find_latest_matching_comment(
            [
                FakeComment("1", "按照原单测试步骤验证。"),
                FakeComment("2", "其他备注"),
                FakeComment("3", "按照原单测试步骤验证。"),
            ]
        )

        self.assertEqual(comment.id, "3")

    def test_remove_latest_verify_comment_only_deletes_latest_match(self):
        module = load_module()
        first_comment = FakeComment("1", "按照原单测试步骤验证。")
        middle_comment = FakeComment("2", "其他备注")
        latest_comment = FakeComment("3", "按照原单测试步骤验证。")
        client = FakeJira(
            comments_by_issue={
                "KO5OS16AEE-100": [
                    first_comment,
                    middle_comment,
                    latest_comment,
                ]
            }
        )

        result = module.remove_latest_verify_comment(client, "KO5OS16AEE-100")

        self.assertTrue(result)
        self.assertEqual(first_comment.delete_calls, 0)
        self.assertEqual(middle_comment.delete_calls, 0)
        self.assertEqual(latest_comment.delete_calls, 1)

    def test_remove_latest_verify_comment_returns_false_without_match(self):
        module = load_module()
        other_comment = FakeComment("9", "其他备注")
        client = FakeJira(
            comments_by_issue={
                "KO5OS16AEE-101": [other_comment]
            }
        )

        result = module.remove_latest_verify_comment(client, "KO5OS16AEE-101")

        self.assertFalse(result)
        self.assertEqual(other_comment.delete_calls, 0)

    def test_build_jql_for_batch_mode(self):
        module = load_module()

        jql = module.build_jql(["KO5OS16AEE", "KO5OS16BEE"])

        self.assertIn('project in ("KO5OS16AEE", "KO5OS16BEE")', jql)
        self.assertIn('status in ("Resolved", "Verified")', jql)
        self.assertIn("updated >= -1d", jql)
        self.assertNotIn("reporter =", jql)
        self.assertTrue(jql.endswith("ORDER BY updated DESC"))


if __name__ == "__main__":
    unittest.main()
