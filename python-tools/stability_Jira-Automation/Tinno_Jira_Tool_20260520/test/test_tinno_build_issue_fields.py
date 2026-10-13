import json
import sys
import unittest
from pathlib import Path
from types import SimpleNamespace

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from tinno_batch_jira_common import build_issue_fields, extract_specialty_token_from_summary


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

    def test_build_issue_labels_preserves_specialty_and_adds_fixed_label(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Test Case": "MTBF专项",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(["MTBF", "稳定性测试"], fields["labels"])

    def test_build_issue_labels_monkey_specialty_maps_to_monkeyaee(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Test Case": "Monkey专项",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(["MonkeyAEE", "稳定性测试"], fields["labels"])

    def test_build_issue_labels_falls_back_to_summary_specialty_token(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "[自动化][V552AA][Total Number 6][MLD-LX2-16-260523V6][MTBF][Java (JE)]x发生Java (JE)",
                "Description": "description",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(["MTBF", "稳定性测试"], fields["labels"])

    def test_build_issue_labels_ignores_unknown_summary_token(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "[自动化][V552AA][Total Number 1][VVTB35.41-1][62次][ANR]x发生ANR",
                "Description": "description",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        # 非白名单 token 不写入 labels，专项回退到配置默认值
        self.assertEqual(["MonkeyAEE", "稳定性测试"], fields["labels"])

    def test_build_issue_labels_keeps_legacy_default_when_no_specialty_found(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(self.defaults.get("labels", ["MonkeyAEE"]) + self.defaults.get("fixed_labels", ["稳定性测试"]), fields["labels"])

    def test_build_issue_labels_dedupes_fixed_label_with_specialty(self) -> None:
        row = pd.Series(
            {
                "Project": "VCAME",
                "Issue Type": "Bug",
                "Summary": "summary",
                "Description": "description",
                "Test Case": "稳定性测试专项",
            }
        )

        fields = build_issue_fields(self.jira, row, self.defaults)

        self.assertEqual(["稳定性测试"], fields["labels"])

    def test_extract_specialty_token_new_and_legacy_version_formats(self) -> None:
        # 新版版本号段（\d{6}V\d+）
        self.assertEqual(
            "MTBF",
            extract_specialty_token_from_summary(
                "[自动化][V552AA][Total Number 6][MLD-LX2-16-260523V6][MTBF][Java (JE)]a发生Java (JE)"
            ),
        )
        # 旧版单号段格式，回退按固定结构取第 5 段
        self.assertEqual(
            "MonkeyAEE",
            extract_specialty_token_from_summary(
                "[自动化][V551A][Total Number 1][VVTB35.41-1][MonkeyAEE][ANR]system发生ANR"
            ),
        )
        self.assertEqual(
            "MonkeyAEE",
            extract_specialty_token_from_summary(
                "[自动化][V551A][Total Number 30][P2][MonkeyAEE][java.lang.NullPointerException]x发生y"
            ),
        )
        # 非自动化标题结构不猜测
        self.assertEqual("", extract_specialty_token_from_summary("手工单标题"))


if __name__ == "__main__":
    unittest.main()
