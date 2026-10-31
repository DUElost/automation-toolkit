import os
import tempfile
import unittest
from pathlib import Path
from unittest import mock

from modules.mode.incremental_org import (
    attrs_to_aee_excel_data,
    filter_org_rows_by_new_paths,
    find_latest_org_excel,
    is_discard_org_row,
)


class IncrementalOrgTest(unittest.TestCase):
    def test_find_latest_org_excel_by_filename_timestamp(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            older = Path(temp_dir) / "Result_None_None_MonkeyAEE_SH_20261016_113849_org.xls"
            newer = Path(temp_dir) / "Result_None_None_MonkeyAEE_SH_20261019_153707_org.xls"
            unrelated = Path(temp_dir) / "Result_None_None_MonkeyAEE_SH_20261019_153707.xls"
            older.write_bytes(b"old")
            newer.write_bytes(b"new")
            unrelated.write_bytes(b"final")

            self.assertEqual(str(newer), find_latest_org_excel(temp_dir))

    def test_find_latest_org_excel_returns_none_when_missing(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self.assertIsNone(find_latest_org_excel(temp_dir))
            self.assertIsNone(find_latest_org_excel(os.path.join(temp_dir, "not_exists")))

    def test_filter_org_rows_keeps_only_new_paths_and_skips_discard(self):
        org_list = [
            ["/logs/a/db.dbg", "V1", "t", "JE", "type", "proc", "pkg", "d", "c", "", 1],
            ["/logs/b/db.dbg", "V1", "t", "JE", "type", "proc", "pkg", "d", "c", "", 1],
            ["/logs/c/db.dbg", "discard_dbg_version", "t", "JE", "type", "proc", "pkg", "d", "c", "", 1],
        ]
        prev_paths = {"/logs/a/db.dbg"}
        delta = filter_org_rows_by_new_paths(org_list, prev_paths)

        self.assertEqual(1, len(delta))
        self.assertEqual("/logs/b/db.dbg", delta[0][0])
        self.assertTrue(is_discard_org_row(org_list[2]))

    def test_attrs_to_aee_excel_data_roundtrip_path(self):
        attrs = [
            "/logs/x/db.dbg", "V1", "2026-10-19", "Java (JE)", "type",
            "proc", "pkg", "detail", "caused", "tag", 1, "act", "SN001", False, "8+8",
        ]
        data = attrs_to_aee_excel_data(attrs)
        out = data.get_aee_attrs()
        self.assertEqual(attrs[0], out[0])
        self.assertEqual(attrs[8], out[8])
        self.assertEqual("SN001", out[12])


class IncrementalCliTest(unittest.TestCase):
    def test_help_includes_incremental_argument(self):
        import subprocess
        import sys

        repo_root = Path(__file__).resolve().parents[1]
        result = subprocess.run(
            [sys.executable, str(repo_root / "start_log_scan.py"), "-h"],
            cwd=str(repo_root),
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="ignore",
        )
        self.assertEqual(0, result.returncode)
        self.assertIn("-inc", result.stdout)

    def test_inc_flag_passed_to_scanaeetne(self):
        import runpy
        import sys

        repo_root = Path(__file__).resolve().parents[1]
        script_path = repo_root / "start_log_scan.py"
        scanner_instance = mock.Mock()
        scanner_ctor = mock.Mock(return_value=scanner_instance)

        with tempfile.TemporaryDirectory() as temp_dir:
            argv = [
                str(script_path),
                "-d_abs",
                temp_dir,
                "-p",
                "SH",
                "-s",
                "-inc",
            ]
            with mock.patch.object(sys, "argv", argv):
                with mock.patch("modules.mode.ScanAeeTne.ScanAeeTne", scanner_ctor):
                    with mock.patch("modules.mode.DedupOrgExcel.DedupOrgExcel"):
                        runpy.run_path(str(script_path), run_name="__main__")

        self.assertTrue(scanner_ctor.called)
        self.assertTrue(scanner_ctor.call_args.kwargs.get("incremental"))


if __name__ == "__main__":
    unittest.main()
