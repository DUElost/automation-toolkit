import tempfile
import sys
import unittest
from pathlib import Path
from unittest import mock


PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    # 保证从仓库根目录和项目目录两种入口都能找到 modules 包
    sys.path.insert(0, str(PROJECT_ROOT))


class DedupOrgExcelTest(unittest.TestCase):
    def setUp(self):
        self._temp_dir = tempfile.TemporaryDirectory()
        self._work_dir = Path(self._temp_dir.name)
        self._config_dir = self._work_dir / "config"
        self._config_dir.mkdir()
        self._write_config_file("pkglist.txt", "com.android.nfc\n")
        self._write_config_file("pkglist_factory.txt", "com.android.nfc\n")
        self._write_config_file("blacklist.txt", "")
        self._write_config_file("report_history.txt", "")

    def tearDown(self):
        self._temp_dir.cleanup()

    def _runner_class(self):
        from modules.mode.DedupOrgExcel import DedupOrgExcel

        return DedupOrgExcel

    def _write_config_file(self, file_name, content):
        file_path = self._config_dir / file_name
        file_path.write_text(content, encoding="utf-8")
        return file_path

    def _write_org_excel(self, file_name="Result_demo_org.xls", rows=None):
        import xlwt

        org_path = self._work_dir / file_name
        workbook = xlwt.Workbook(encoding="utf-8")
        sheet = workbook.add_sheet("aeeexp", cell_overwrite_ok=True)
        headers = [
            "Id",
            "Path",
            "Version",
            "ExpTime",
            "ExpClass",
            "ExpType",
            "CurProcess",
            "Package",
            "Detail",
            "CausedBy",
            "extraTag",
            "Count",
            "Activity",
            "DeviceId",
        ]
        for col_index, header in enumerate(headers):
            sheet.write(0, col_index, header)

        default_rows = rows or [
            [
                1,
                "C:/logs/a/__exp_main.txt",
                "V1",
                "2026-04-04 10:00:00",
                "Java (JE)",
                "NullPointerException",
                "com.android.nfc",
                "com.android.nfc",
                "detail-a",
                "same-caused-by",
                "",
                1,
                "MainActivity",
                "device-1",
            ],
            [
                2,
                "C:/logs/b/__exp_main.txt",
                "V1",
                "2026-04-04 10:01:00",
                "Java (JE)",
                "NullPointerException",
                "com.android.nfc",
                "com.android.nfc",
                "detail-b",
                "same-caused-by",
                "",
                1,
                "MainActivity",
                "device-2",
            ],
        ]

        for row_index, row in enumerate(default_rows, start=1):
            for col_index, value in enumerate(row):
                sheet.write(row_index, col_index, value)

        workbook.save(str(org_path))
        return org_path

    def test_run_uses_default_shanghai_and_generates_timestamped_file(self):
        org_path = self._write_org_excel()
        DedupOrgExcel = self._runner_class()

        runner = DedupOrgExcel(str(org_path), config_dir=str(self._config_dir))
        output_path = runner.run()

        self.assertTrue(output_path.endswith(".xls"))
        self.assertIn("_dedup_org_", Path(output_path).name)
        self.assertTrue(Path(output_path).is_file())

    def test_run_deduplicates_duplicate_rows_and_writes_device_count(self):
        org_path = self._write_org_excel()
        DedupOrgExcel = self._runner_class()

        runner = DedupOrgExcel(str(org_path), config_dir=str(self._config_dir))
        output_path = runner.run()

        import xlrd

        workbook = xlrd.open_workbook(output_path)
        sheet = workbook.sheet_by_index(0)
        headers = [str(value).strip() for value in sheet.row_values(0)]
        self.assertIn("DeviceCount", headers)

        device_count_index = headers.index("DeviceCount")
        self.assertEqual(2, sheet.nrows)
        self.assertEqual(2.0, sheet.row_values(1)[device_count_index])

    def test_run_rejects_non_org_excel_name(self):
        invalid_path = self._write_org_excel(file_name="Result_demo.xls")
        DedupOrgExcel = self._runner_class()

        runner = DedupOrgExcel(str(invalid_path), config_dir=str(self._config_dir))

        with self.assertRaises(ValueError):
            runner.run()

    def test_run_keeps_pkglist_filtering_semantics(self):
        org_path = self._write_org_excel(
            rows=[
                [
                    1,
                    "C:/logs/a/__exp_main.txt",
                    "V1",
                    "2026-04-04 10:00:00",
                    "Java (JE)",
                    "NullPointerException",
                    "com.demo",
                    "com.demo",
                    "detail-a",
                    "same-caused-by",
                    "",
                    1,
                    "MainActivity",
                    "device-1",
                ]
            ]
        )
        DedupOrgExcel = self._runner_class()

        runner = DedupOrgExcel(str(org_path), config_dir=str(self._config_dir))
        output_path = runner.run()

        import xlrd

        workbook = xlrd.open_workbook(output_path)
        sheet = workbook.sheet_by_index(0)
        self.assertEqual(1, sheet.nrows)

    def test_run_factory_side_uses_factory_pkglist_instead_of_default_pkglist(self):
        self._write_config_file("pkglist.txt", "com.demo\n")
        self._write_config_file("pkglist_factory.txt", "com.android.nfc\n")
        org_path = self._write_org_excel()
        DedupOrgExcel = self._runner_class()

        runner = DedupOrgExcel(str(org_path), side="factory", config_dir=str(self._config_dir))
        output_path = runner.run()

        import xlrd

        workbook = xlrd.open_workbook(output_path)
        sheet = workbook.sheet_by_index(0)
        self.assertEqual(2, sheet.nrows)
        self.assertEqual("com.android.nfc", str(sheet.row_values(1)[6]).strip())

    def test_run_uses_explicit_config_dir_even_if_cwd_changes(self):
        org_path = self._write_org_excel()
        DedupOrgExcel = self._runner_class()
        other_dir = self._work_dir / "other"
        other_dir.mkdir()

        with mock.patch("os.getcwd", return_value=str(other_dir)):
            runner = DedupOrgExcel(str(org_path), config_dir=str(self._config_dir))
            output_path = runner.run()

        self.assertTrue(Path(output_path).is_file())


if __name__ == "__main__":
    unittest.main()
