import importlib.util
import json
import tempfile
import unittest
from argparse import Namespace
from pathlib import Path
from types import SimpleNamespace
from unittest import mock

import pandas as pd


TOOL_DIR = Path(__file__).resolve().parent.parent


def load_retro_module():
    module_path = TOOL_DIR / "retro_add_tinno_ps_comments.py"
    spec = importlib.util.spec_from_file_location("retro_add_tinno_ps_comments_test", module_path)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class RetroAddTinnoPsCommentsTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.module = load_retro_module()

    def test_build_excel_row_map_uses_index_plus_two(self) -> None:
        df = pd.DataFrame(
            [
                {"PS": ""},
                {"PS": "first comment"},
                {"PS": "nan"},
                {"PS": "second comment"},
            ]
        )
        row_map = self.module.build_excel_row_map(df)
        self.assertEqual(
            {
                3: "first comment",
                5: "second comment",
            },
            row_map,
        )

    def test_find_result_json_rejects_ambiguous_candidates(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            result_dir = Path(temp_dir) / "result"
            result_dir.mkdir()
            excel_name = "JIRA_Upload_List_Tinno_Monkey专项_20260615_211827.xlsx"
            (result_dir / "tinno_jira_batch_create_result_20260615_212929.json").write_text("[]", encoding="utf-8")
            (result_dir / "tinno_jira_batch_create_result_20260615_213000.json").write_text("[]", encoding="utf-8")

            with mock.patch.object(self.module, "RESULT_DIR", result_dir):
                matched = self.module.find_result_json_by_excel(str(result_dir.parent / excel_name))

        self.assertIsNone(matched)

    def test_find_result_json_allows_ambiguous_with_force(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            result_dir = Path(temp_dir) / "result"
            result_dir.mkdir()
            excel_name = "JIRA_Upload_List_Tinno_Monkey专项_20260615_211827.xlsx"
            closer = result_dir / "tinno_jira_batch_create_result_20260615_212929.json"
            farther = result_dir / "tinno_jira_batch_create_result_20260615_213000.json"
            closer.write_text("[]", encoding="utf-8")
            farther.write_text("[]", encoding="utf-8")

            with mock.patch.object(self.module, "RESULT_DIR", result_dir):
                matched = self.module.find_result_json_by_excel(
                    str(result_dir.parent / excel_name),
                    force=True,
                )

        self.assertEqual(str(closer), matched)

    def test_main_skips_existing_comments_by_default(self) -> None:
        excel_df = pd.DataFrame([{"PS": "same ps text"}])
        result_payload = [{"row": 2, "status": "SUCCESS", "issue_key": "VCAME-1"}]

        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            excel_path = temp_path / "JIRA_Upload_List_Tinno_Monkey专项_20260615_211827.xlsx"
            result_path = temp_path / "tinno_jira_batch_create_result_20260615_212929.json"
            excel_path.write_bytes(b"")
            result_path.write_text(json.dumps(result_payload), encoding="utf-8")

            fake_jira = SimpleNamespace(auth_mode="cookie", close=lambda: None)
            args = Namespace(
                excel_file=str(excel_path),
                result_json=str(result_path),
                jira_username="user",
                jira_password="pass",
                jira_server=None,
                jira_p12_path="",
                jira_p12_password="",
                jira_cookie_string=None,
                jira_cookie_jsessionid="js",
                jira_cookie_xsrf_token="xsrf",
                config_file=str(TOOL_DIR / "config" / "tinno_jira_defaults.json"),
                dry_run=False,
                no_skip_existing=False,
                force_auto_match=False,
            )

            with mock.patch.object(self.module, "parse_args", return_value=args):
                with mock.patch.object(self.module, "load_local_env"):
                    with mock.patch.object(self.module, "setup_logging"):
                        with mock.patch.object(self.module, "read_excel_smart", return_value=excel_df):
                            with mock.patch.object(self.module, "connect_to_jira", return_value=fake_jira):
                                with mock.patch.object(self.module, "issue_has_comment", return_value=True) as has_comment:
                                    with mock.patch.object(self.module, "add_issue_comment") as add_comment:
                                        exit_code = self.module.main()

        self.assertEqual(0, exit_code)
        has_comment.assert_called_once()
        add_comment.assert_not_called()


if __name__ == "__main__":
    unittest.main()
