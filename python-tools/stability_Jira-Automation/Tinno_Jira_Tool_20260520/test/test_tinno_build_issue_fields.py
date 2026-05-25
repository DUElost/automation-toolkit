import json
import sys
import unittest
from pathlib import Path
from types import SimpleNamespace

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from tinno_batch_jira_common import build_issue_fields


class _FakeJiraClient:
    def __init__(self) -> None:
        self.component_allowed_values = []

    def project(self, project_key: str) -> SimpleNamespace:
        return SimpleNamespace(key=project_key)

    def search_users(self, user: str, maxResults: int = 20):  # noqa: N803
        username = str(user or "").strip()
        if not username:
            return []
        return [
            SimpleNamespace(
                name=username,
                displayName=username,
                emailAddress=f"{username}@tinno.com",
            )
        ]

    def createmeta(self, projectKeys: str, expand: str = "projects.issuetypes.fields"):  # noqa: N803
        return {
            "projects": [
                {
                    "key": projectKeys,
                    "issuetypes": [
                        {
                            "name": "Bug",
                            "fields": {
                                "components": {
                                    "name": "Component/s",
                                    "allowedValues": [{"name": item} for item in self.component_allowed_values],
                                }
                            },
                        }
                    ],
                }
            ]
        }


class TinnoBuildIssueFieldsTest(unittest.TestCase):
    def setUp(self) -> None:
        defaults_path = TOOL_DIR / "config" / "tinno_jira_defaults.json"
        with defaults_path.open("r", encoding="utf-8") as fp:
            self.defaults = json.load(fp)
        self.jira = _FakeJiraClient()

    def test_build_issue_fields_does_not_send_version_fields_on_create(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Versions": "P1",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertNotIn("fixVersions", fields)
        self.assertNotIn("versions", fields)

    def test_build_issue_fields_falls_back_to_autotest_component(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual([{"name": "AUTOTEST"}], fields["components"])

    def test_build_issue_fields_does_not_send_reporter_on_create(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Reporter": "dai.lv",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertNotIn("reporter", fields)

    def test_build_issue_fields_uses_previous_version_defaults_when_excel_empty(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(
            {"value": "Previous version exists"},
            fields[self.defaults["field_ids"]["previous_version_status"]],
        )
        self.assertEqual(
            {"value": "100%"},
            fields[self.defaults["field_ids"]["previous_version_text"]],
        )

    def test_build_issue_fields_remaps_legacy_previous_version_status_probability_value(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Previous Version Status": "100%",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(
            {"value": "Previous version exists"},
            fields[self.defaults["field_ids"]["previous_version_status"]],
        )
        self.assertEqual(
            {"value": "100%"},
            fields[self.defaults["field_ids"]["previous_version_text"]],
        )

    def test_build_issue_fields_resolves_component_to_allowed_value(self) -> None:
        self.jira.component_allowed_values = ["Setting", "Wall Paper"]
        row = pd.Series(
            {
                "Project": "VFFCA",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Module": "Settings",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual([{"name": "Setting"}], fields["components"])


if __name__ == "__main__":
    unittest.main()
