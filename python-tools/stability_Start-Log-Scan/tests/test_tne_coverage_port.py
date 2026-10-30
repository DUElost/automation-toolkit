import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from modules.analyse.tne.AnalyseTne import analyse_tne, parse_tne_dir_timestamp
from modules.analyse.tne.files.sys_prop import SysProp
from modules.analyse.tne.types.TneBacklightSensorDetect import TneBacklightSensorDetect
from modules.analyse.tne.types.TneCloneStability import CLONE_STABILITY_PACKAGE
from modules.common.GlobalAttrs import SCAN_MODE_AEE_TNE, SCAN_MODE_TNE, SCAN_MODE_TRANSSION
from modules.mode.ScanAeeTne import ScanAeeTne


SYS_PROP_SN = """\
[ro.build.display.id]: [V2.0]
[ro.serialno]: [SN123456]
"""

SYS_PROP_SHELL = SYS_PROP_SN + """\
[persist.sys.boot.reason.history]: [reboot,shell.2026-10-17]
"""

SYS_PROP_OTA = SYS_PROP_SN + """\
[persist.sys.boot.reason.history]: [reboot,ota.2026-10-17]
"""

TDS_LOG = """\
10-17 18:00:29.014  1111  1111 E TDS     : TDS Exception for [ALS_TIMEOUT]
10-17 18:01:30.100  1111  1111 E TDS     : TDS Exception for [PS_FAIL]
"""


def _write(root, name, text):
    path = Path(root) / name
    path.write_text(text, encoding="utf-8")
    return path


class ParseTimestampTest(unittest.TestCase):
    def test_legacy_compact_and_dual(self):
        legacy = parse_tne_dir_timestamp("2026_10_17_18_00_29_14")
        self.assertEqual("2026-10-17 18:00:29", legacy.strftime("%Y-%m-%d %H:%M:%S"))
        compact = parse_tne_dir_timestamp("2026101718002914")
        self.assertEqual("2026-10-17 18:00:29", compact.strftime("%Y-%m-%d %H:%M:%S"))
        dual = parse_tne_dir_timestamp("2026101717590000_2026101718002914_abcdef")
        self.assertEqual("2026-10-17 18:00:29", dual.strftime("%Y-%m-%d %H:%M:%S"))


class CloneStabilityTest(unittest.TestCase):
    def test_connection_fail_uses_dir_time_and_sn(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0x0016000a_2026_10_17_18_00_29_14"
            tne_dir.mkdir()
            _write(tne_dir, "sys_prop", SYS_PROP_SN)
            ok, path, tne, err, detail = analyse_tne(str(tne_dir))
            self.assertTrue(ok)
            self.assertEqual(str(tne_dir), path)
            self.assertIsNone(err)
            self.assertEqual("0x0016000a_连接失败", tne._exp_class)
            self.assertEqual("0x0016000a", tne._exp_type)
            self.assertEqual(CLONE_STABILITY_PACKAGE, tne._package)
            self.assertEqual("2026-10-17 18:00:29", tne._exp_time)
            self.assertIn("ExpClass: 0x0016000a", tne._detail)
            self.assertIn("SN: SN123456", tne._detail)

    def test_transfer_fail_compact_timestamp(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0x0016000b_2026101718002914"
            tne_dir.mkdir()
            _write(tne_dir, "sys_prop", SYS_PROP_SN)
            ok, _, tne, _, _ = analyse_tne(str(tne_dir))
            self.assertTrue(ok)
            self.assertEqual("0x0016000b_传输失败", tne._exp_class)
            self.assertEqual("2026-10-17 18:00:29", tne._exp_time)


class BacklightSensorTest(unittest.TestCase):
    def test_multi_hit_extra_results(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0xffffff73_2026101718002914"
            tne_dir.mkdir()
            _write(tne_dir, "android_system_log", TDS_LOG)
            tne = TneBacklightSensorDetect(str(tne_dir), "0xffffff73")
            tne.analyse()
            self.assertEqual("0xffffff73_ALS_TIMEOUT", tne._exp_class)
            self.assertIn("ErrorCode：ALS_TIMEOUT", tne._detail)
            self.assertIn("TDS Exception for [ALS_TIMEOUT]", tne._caused_by)
            self.assertEqual(1, len(tne._extra_results))
            extra = tne._extra_results[0]
            self.assertEqual("0xffffff73_PS_FAIL", extra._exp_class)
            self.assertIn("ErrorCode：PS_FAIL", extra._detail)

    def test_analyse_tne_expands_extra_results(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0xffffff73_2026101718002914"
            tne_dir.mkdir()
            _write(tne_dir, "android_system_log", TDS_LOG)
            scanner = object.__new__(ScanAeeTne)
            scanner._freeze_tne_type_list = []
            scanner._subsystem_crash_tne_type_list = []
            scanner._daemon_crash_tne_type_list = []
            rows = scanner._analyse_tne([str(tne_dir)])
            self.assertEqual(2, len(rows))
            self.assertEqual("0xffffff73_ALS_TIMEOUT", rows[0]._exp_class)
            self.assertEqual("0xffffff73_PS_FAIL", rows[1]._exp_class)


class AdbRebootResetTest(unittest.TestCase):
    def test_sys_prop_shell_and_ota(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            shell_path = _write(temp_dir, "sys_prop_shell", SYS_PROP_SHELL)
            ota_path = _write(temp_dir, "sys_prop_ota", SYS_PROP_OTA)
            normal_path = _write(temp_dir, "sys_prop_ok", SYS_PROP_SN)
            self.assertTrue(SysProp(str(shell_path)).is_shell_reboot)
            self.assertTrue(SysProp(str(ota_path)).is_shell_reboot)
            self.assertFalse(SysProp(str(normal_path)).is_shell_reboot)

    def test_tne06_shell_reboot_is_skipped(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0xffffff06_2026_10_17_18_00_29_14"
            tne_dir.mkdir()
            _write(tne_dir, "sys_prop", SYS_PROP_SHELL)
            ok, _, tne, err, detail = analyse_tne(str(tne_dir))
            self.assertFalse(ok)
            self.assertEqual("adb_reboot_reset", err)
            self.assertEqual("adb_reboot_reset", tne._extra_tag)
            self.assertEqual("adb_reboot_reset", tne._detail)

    def test_tne06_normal_boot_still_reports(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0xffffff06_2026_10_17_18_00_29_14"
            tne_dir.mkdir()
            _write(tne_dir, "sys_prop", SYS_PROP_SN)
            ok, _, tne, err, _ = analyse_tne(str(tne_dir))
            self.assertTrue(ok)
            self.assertIsNone(err)
            self.assertNotEqual("adb_reboot_reset", tne._extra_tag)
            self.assertEqual("0xffffff06_stucklogo", tne._exp_class)


class ModeAndWhitelistTest(unittest.TestCase):
    def test_default_and_transsion_still_skip_tne_summary(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_scanner = object.__new__(ScanAeeTne)
            tne_scanner._scan_mode = SCAN_MODE_TNE
            tne_scanner._scan_root_dir = temp_dir
            tne_scanner._scan_tne_summary = mock.Mock()
            tne_scanner._scan()
            tne_scanner._scan_tne_summary.assert_called_once_with()

            default_scanner = object.__new__(ScanAeeTne)
            default_scanner._scan_mode = SCAN_MODE_AEE_TNE
            default_scanner._scan_root_dir = None
            default_scanner._ratio_std_aee = 90
            default_scanner._scan_date_formatted_aee = None
            default_scanner._scan_tne_summary = mock.Mock()
            default_scanner._scan()
            default_scanner._scan_tne_summary.assert_not_called()

            transsion_scanner = object.__new__(ScanAeeTne)
            transsion_scanner._scan_mode = SCAN_MODE_TRANSSION
            transsion_scanner._scan_root_dir = None
            transsion_scanner._ratio_std_aee = 90
            transsion_scanner._scan_date_formatted_aee = None
            transsion_scanner._scan_tne_summary = mock.Mock()
            transsion_scanner._scan()
            transsion_scanner._scan_tne_summary.assert_not_called()

    def test_1026_whitelist_files_synced(self):
        config = REPO_ROOT / "config"
        self.assertTrue((config / "whitelist_tne_to_prj.txt").is_file())
        self.assertTrue((config / "whitelist_tne_to_usicpro.txt").is_file())
        self.assertTrue((config / "whitelist_fansaee_to_prj.txt").is_file())
        self.assertTrue((config / "whitelist_fansaee_to_fanspro.txt").is_file())
        self.assertTrue((config / "internal_dev_package.txt").is_file())
        pkglist = (config / "pkglist.txt").read_text(encoding="utf-8", errors="ignore")
        internal = (config / "internal_dev_package.txt").read_text(encoding="utf-8", errors="ignore")
        self.assertIn("com.android.quickstep", pkglist)
        self.assertIn("com.android.quickstep", internal)
        self.assertIn("com.transsion.rilemanagerx", internal)
        self.assertLessEqual(len([line for line in pkglist.splitlines() if line.strip()]), 500)


if __name__ == "__main__":
    unittest.main()
