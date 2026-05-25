import sys
import unittest
from pathlib import Path
from types import SimpleNamespace


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from tinno_batch_jira_common import build_transition_fields, transition_issue_to_closed, transition_issue_to_resolved


class _FakeTransitionJiraClient:
    def __init__(self, transitions, current_status: str):
        self._transitions = transitions
        self._current_status = current_status
        self.calls = []

    def issue(self, issue_key: str):
        return SimpleNamespace(
            key=issue_key,
            fields=SimpleNamespace(status=SimpleNamespace(name=self._current_status)),
        )

    def transitions(self, issue, expand_fields: bool = False):
        self.calls.append(("transitions", issue.key if hasattr(issue, "key") else issue, expand_fields))
        return self._transitions

    def transition_issue(self, issue, transition_id: str, comment=None, fields=None):
        self.calls.append(("transition_issue", issue.key if hasattr(issue, "key") else issue, transition_id, fields))
        return {}


class TinnoTransitionFieldsTest(unittest.TestCase):
    def test_build_transition_fields_uses_allowed_value_ids(self) -> None:
        fields, error_message = build_transition_fields(
            {
                "resolution": {
                    "required": True,
                    "name": "Resolution",
                    "allowedValues": [{"id": "10000", "name": "完成"}],
                },
                "fixVersions": {
                    "required": False,
                    "name": "Fix Version/s",
                    "allowedValues": [{"id": "20000", "name": "V552AA-16-260515V25"}],
                },
            },
            resolution_name="完成",
            fix_version="V552AA-16-260515V25",
        )

        self.assertEqual("", error_message)
        self.assertEqual({"id": "10000"}, fields["resolution"])
        self.assertEqual([{"id": "20000"}], fields["fixVersions"])

    def test_build_transition_fields_rejects_unknown_fix_version(self) -> None:
        fields, error_message = build_transition_fields(
            {
                "resolution": {
                    "required": True,
                    "name": "Resolution",
                    "allowedValues": [{"id": "10000", "name": "完成"}],
                },
                "fixVersions": {
                    "required": False,
                    "name": "Fix Version/s",
                    "allowedValues": [{"id": "20000", "name": "V552AA-16-260515V25"}],
                },
            },
            resolution_name="完成",
            fix_version="V552AA-16-260521V37",
        )

        self.assertEqual({}, fields)
        self.assertIn("Fix Version/s", error_message)

    def test_transition_helpers_pass_minimal_resolution_and_fix_version_fields(self) -> None:
        close_jira = _FakeTransitionJiraClient(
            [
                {
                    "id": "701",
                    "name": "Close Issue",
                    "to": {"name": "Closed"},
                    "fields": {
                        "resolution": {
                            "required": True,
                            "name": "Resolution",
                            "allowedValues": [{"id": "10000", "name": "完成"}],
                        },
                        "fixVersions": {
                            "required": False,
                            "name": "Fix Version/s",
                            "allowedValues": [{"id": "20000", "name": "V552AA-16-260515V25"}],
                        },
                    },
                },
            ],
            current_status="Resolved",
        )
        resolve_jira = _FakeTransitionJiraClient(
            [
                {
                    "id": "5",
                    "name": "Resolve Issue",
                    "to": {"name": "Resolved"},
                    "fields": {
                        "resolution": {
                            "required": True,
                            "name": "Resolution",
                            "allowedValues": [{"id": "10000", "name": "完成"}],
                        },
                        "fixVersions": {
                            "required": False,
                            "name": "Fix Version/s",
                            "allowedValues": [{"id": "20000", "name": "V552AA-16-260515V25"}],
                        },
                    },
                },
            ],
            current_status="In Progress",
        )

        closed_ok, _ = transition_issue_to_closed(
            close_jira,
            "VFFCA-1",
            ["Closed"],
            resolution_name="完成",
            fix_version="V552AA-16-260515V25",
        )
        resolved_ok, _ = transition_issue_to_resolved(
            resolve_jira,
            "VFFCA-1",
            ["Resolved"],
            resolution_name="完成",
            fix_version="V552AA-16-260515V25",
        )

        self.assertTrue(closed_ok)
        self.assertTrue(resolved_ok)
        close_transition_calls = [item for item in close_jira.calls if item[0] == "transition_issue"]
        resolve_transition_calls = [item for item in resolve_jira.calls if item[0] == "transition_issue"]
        self.assertEqual("701", close_transition_calls[0][2])
        self.assertEqual({"id": "10000"}, close_transition_calls[0][3]["resolution"])
        self.assertEqual([{"id": "20000"}], close_transition_calls[0][3]["fixVersions"])
        self.assertEqual("5", resolve_transition_calls[0][2])


if __name__ == "__main__":
    unittest.main()
