import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from modules.common.GlobalAttrs import SCAN_MODE_AEE_TNE, SCAN_MODE_TNE, SCAN_MODE_TRANSSION
from modules.mode.ScanAeeTne import ScanAeeTne


class FakeTne(object):
    def __init__(self, path, version, exp_type, package, detail, device_id="SN1", count=1):
        self._attrs = [
            path, version, "2026-10-17 00:02:20", "AppCrashANR", exp_type,
            package, package, "", detail, "", device_id, count,
        ]

    def get_tne_attrs(self):
        return list(self._attrs)


def _make_tne_scanner(root):
    scanner = object.__new__(ScanAeeTne)
    scanner._scan_mode = SCAN_MODE_TNE
    scanner._scan_root_dir = str(root)
    scanner._scan_date_formatted_tne = ""
    scanner._scan_date_formatted_aee = None
    scanner._skip_extract = True
    scanner._ratio_std_tne = 90
    scanner._freeze_tne_type_list = []
    scanner._subsystem_crash_tne_type_list = []
    scanner._extra_jira_tag = None
    scanner._jira_repo = None
    scanner._reporter = None
    scanner._scan_place = "SH"
    scanner._report_date_formatted = "20261027"
    scanner._build_version = None
    scanner._zero_size_dbg_set = set()
    scanner._extract_failed_dbg_set = set()
    scanner._convert_path_to_win = lambda path: path
    return scanner


class TneSummaryTest(unittest.TestCase):
    def test_scan_dispatches_tne_mode_only(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_scanner = _make_tne_scanner(temp_dir)
            tne_scanner._scan_tne_summary = mock.Mock()
            tne_scanner._scan()
            tne_scanner._scan_tne_summary.assert_called_once_with()

            default_scanner = _make_tne_scanner(temp_dir)
            default_scanner._scan_mode = SCAN_MODE_AEE_TNE
            default_scanner._scan_root_dir = None
            default_scanner._ratio_std_aee = 90
            default_scanner._scan_tne_summary = mock.Mock()
            default_scanner._scan()
            default_scanner._scan_tne_summary.assert_not_called()

            transsion_scanner = _make_tne_scanner(temp_dir)
            transsion_scanner._scan_mode = SCAN_MODE_TRANSSION
            transsion_scanner._scan_root_dir = None
            transsion_scanner._ratio_std_aee = 90
            transsion_scanner._scan_tne_summary = mock.Mock()
            transsion_scanner._scan()
            transsion_scanner._scan_tne_summary.assert_not_called()

    def test_collect_tne_files_and_dirs_skips_mobilelog(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            keep_dir = root / "0x00160006_2026101718002914"
            keep_dir.mkdir()
            keep_file = root / "0xffffff07_2026101719000000.tne"
            keep_file.write_bytes(b"tne")
            noise = root / "debuglogger" / "mobilelog"
            noise.mkdir(parents=True)
            (noise / "0x00160006_2026101718002914").mkdir()
            (noise / "0xffffff07_2026101719000000.tne").write_bytes(b"noise")

            scanner = _make_tne_scanner(root)
            files, dirs = scanner._collect_tne_files_and_dirs()
            self.assertEqual([str(keep_file)], files)
            self.assertEqual([str(keep_dir)], dirs)

    def test_collect_respects_scan_date(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            keep = root / "0x00160006_2026101718002914"
            keep.mkdir()
            skip = root / "0x00160006_2026101618002914"
            skip.mkdir()
            scanner = _make_tne_scanner(root)
            scanner._scan_date_formatted_tne = "20261017"
            files, dirs = scanner._collect_tne_files_and_dirs()
            self.assertEqual([], files)
            self.assertEqual([str(keep)], dirs)

    def test_dedup_merges_count_path_and_device(self):
        scanner = _make_tne_scanner(".")
        results = [
            FakeTne("D:\\a\\0x00160006_1", "X-260101V", "0xffffff07", "com.demo.app", "stack aaa", "SN1"),
            FakeTne("D:\\b\\0x00160006_2", "X-260202V", "0xffffff07", "com.demo.app", "stack aaa", "SN2"),
        ]
        org_list, final_list = scanner._tne_to_org_final(results, replace_path=False)
        self.assertEqual(2, len(org_list))
        self.assertEqual(1, len(final_list))
        self.assertEqual(2, final_list[0][11])
        self.assertIn("D:\\a\\0x00160006_1", final_list[0][0])
        self.assertIn("D:\\b\\0x00160006_2", final_list[0][0])
        self.assertEqual("SN1,SN2", final_list[0][10])
        self.assertEqual("X-260202V", final_list[0][1])
        self.assertEqual(1, org_list[0][11])

    def test_file_missing_undefined_stays_in_org_only(self):
        scanner = _make_tne_scanner(".")
        missing = FakeTne("D:\\miss", "undefined", "TNE_ERROR_file_missing", "undefined", "undefined")
        org_list, final_list = scanner._tne_to_org_final([missing], replace_path=False)
        self.assertEqual(1, len(org_list))
        self.assertEqual(0, len(final_list))

    def test_scan_tne_summary_writes_excel_and_summary(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            tne_dir = root / "0xffffff07_2026101718002914"
            tne_dir.mkdir()
            scanner = _make_tne_scanner(root)
            fake = FakeTne(str(tne_dir), "X-260101V", "0xffffff07", "com.demo.app", "stack aaa")
            scanner._analyse_tne = mock.Mock(return_value=[fake])
            excel_instances = []

            class FakeExcel(object):
                def __init__(self, path):
                    self.path = path
                    excel_instances.append(self)
                    self.tne_rows = None

                def insertResultTne(self, rows):
                    self.tne_rows = rows

            with mock.patch("modules.common.Excel.Excel", FakeExcel):
                scanner._scan_tne_summary()

            self.assertEqual(2, len(excel_instances))
            self.assertTrue(excel_instances[0].path.endswith("_org.xls"))
            self.assertEqual(1, len(excel_instances[0].tne_rows))
            self.assertEqual(1, len(excel_instances[1].tne_rows))
            summaries = list(root.glob("*_summary.json"))
            self.assertEqual(1, len(summaries))


if __name__ == "__main__":
    unittest.main()
