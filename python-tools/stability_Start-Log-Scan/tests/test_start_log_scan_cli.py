import os
import runpy
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


REPO_ROOT = Path(__file__).resolve().parents[1]
SCRIPT_PATH = REPO_ROOT / "start_log_scan.py"
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


class StartLogScanCliTest(unittest.TestCase):
    def _run_cli_with_mocks(self, argv, dedup_ctor=None, scanner_ctor=None):
        with mock.patch.object(sys, "argv", argv):
            with mock.patch("modules.mode.DedupOrgExcel.DedupOrgExcel", dedup_ctor or mock.Mock()):
                with mock.patch("modules.mode.ScanAeeTne.ScanAeeTne", scanner_ctor or mock.Mock()):
                    with mock.patch("builtins.print") as print_mock:
                        with self.assertRaises(SystemExit) as exit_context:
                            runpy.run_path(str(SCRIPT_PATH), run_name="__main__")

        return exit_context.exception.code, print_mock

    def test_help_includes_dedup_org_argument(self):
        result = subprocess.run(
            [sys.executable, str(SCRIPT_PATH), "-h"],
            cwd=str(REPO_ROOT),
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="ignore",
        )

        self.assertEqual(0, result.returncode)
        self.assertIn("-dedup_org", result.stdout)

    def test_dedup_org_mode_runs_dedup_and_exits_before_scan_path(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            org_path = Path(temp_dir) / "Result_demo_org.xls"
            org_path.write_bytes(b"placeholder")

            dedup_instance = mock.Mock()
            dedup_instance.run.return_value = str(Path(temp_dir) / "Result_demo_dedup.xls")
            dedup_ctor = mock.Mock(return_value=dedup_instance)
            scanner_ctor = mock.Mock(side_effect=AssertionError("不应进入扫描路径"))

            argv = [
                str(SCRIPT_PATH),
                "-dedup_org",
                str(org_path),
            ]
            exit_code, print_mock = self._run_cli_with_mocks(
                argv,
                dedup_ctor=dedup_ctor,
                scanner_ctor=scanner_ctor,
            )

        self.assertEqual(0, exit_code)
        dedup_ctor.assert_called_once_with(str(org_path), "shanghai")
        dedup_instance.run.assert_called_once_with()
        print_mock.assert_called_once_with(dedup_instance.run.return_value)

    def test_dedup_org_without_value_fails_and_does_not_enter_scan_path(self):
        scanner_ctor = mock.Mock(side_effect=AssertionError("不应进入扫描路径"))
        dedup_ctor = mock.Mock(side_effect=AssertionError("缺少路径时不应创建 DedupOrgExcel"))

        exit_code, print_mock = self._run_cli_with_mocks(
            [str(SCRIPT_PATH), "-dedup_org", "-side", "factory"],
            dedup_ctor=dedup_ctor,
            scanner_ctor=scanner_ctor,
        )

        self.assertNotEqual(0, exit_code)
        dedup_ctor.assert_not_called()
        scanner_ctor.assert_not_called()
        print_mock.assert_not_called()

    def test_dedup_org_run_exception_exits_with_non_zero(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            org_path = Path(temp_dir) / "Result_demo_org.xls"
            org_path.write_bytes(b"placeholder")

            dedup_instance = mock.Mock()
            dedup_instance.run.side_effect = RuntimeError("dedup failed")
            scanner_ctor = mock.Mock(side_effect=AssertionError("不应进入扫描路径"))

            exit_code, print_mock = self._run_cli_with_mocks(
                [str(SCRIPT_PATH), "-dedup_org", str(org_path)],
                dedup_ctor=mock.Mock(return_value=dedup_instance),
                scanner_ctor=scanner_ctor,
            )

        self.assertNotEqual(0, exit_code)
        dedup_instance.run.assert_called_once_with()
        scanner_ctor.assert_not_called()
        print_mock.assert_not_called()


if __name__ == "__main__":
    unittest.main()
