"""Unit tests for the offline Monkey → Jira pipeline."""

from __future__ import annotations

import unittest
from unittest.mock import MagicMock, patch

import pandas as pd

from .offline_monkey_pipeline import OfflineMonkeyPipeline


class OfflineMonkeyPipelineTests(unittest.TestCase):
    """Ensure the offline pipeline can run end-to-end with mocked inputs."""

    def test_pipeline_creates_issue_when_no_match(self) -> None:
        pipeline = OfflineMonkeyPipeline(project_key="VCAME")
        sample_upload = [
            {
                "summary": "[Total Number 5][MonkeyAEE] ANR com.example.app",
                "version": "X6726B-15.1.1.119SP03(OP001PF001AZ)_SU",
                "key_information": "java.lang.ANR",
                "module": "ExampleModule",
                "affect_project": "X6726B",
                "bug_severity": "A",
                "assignee": "autotest",
                "priority": "High",
            }
        ]

        with patch("tests.offline_monkey_pipeline.ExcelToJiraUploadListGenerator") as mock_gen_cls, patch.object(
            OfflineMonkeyPipeline, "_load_existing_issues", return_value=pd.DataFrame()
        ), patch.object(OfflineMonkeyPipeline, "_write_output", return_value=None):
            generator_instance = MagicMock()
            generator_instance.load_excel_files.return_value = True
            generator_instance.generate_upload_list.return_value = True
            generator_instance.stats = {"upload_list": sample_upload}
            mock_gen_cls.return_value = generator_instance

            result = pipeline.run(regression_cycles=1)

        self.assertFalse(result.actions.empty, "Pipeline should record at least one action")
        self.assertEqual(result.actions.iloc[0]["Action"], "create")
        self.assertEqual(result.actions.iloc[0]["Module"], "ExampleModule")
        self.assertIn("IssueKey", result.issues.columns)
        self.assertEqual(len(result.issues), 1)


if __name__ == "__main__":
    unittest.main()

