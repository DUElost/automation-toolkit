import sys
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.files.android_main_log import AndroidMainLog
from modules.analyse.tne.types.tne07 import Tne07
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.GlobalAttrs import SCAN_MODE_AEE_TNE, SCAN_MODE_TNE, SCAN_MODE_TRANSSION
from modules.mode.ScanAeeTne import ScanAeeTne


JE_EARLY = """\
10-17 18:00:01.000  1111  1111 E AndroidRuntime: FATAL EXCEPTION: main
10-17 18:00:01.000  1111  1111 E AndroidRuntime: Process: com.other.app, PID: 1111
10-17 18:00:01.000  1111  1111 E AndroidRuntime: java.lang.IllegalStateException: other
10-17 18:00:01.000  1111  1111 E AndroidRuntime: \tat com.other.app.Foo.bar(Foo.java:1)
"""

JE_TARGET = """\
10-17 18:00:29.014  2222  2222 E AndroidRuntime: FATAL EXCEPTION: main
10-17 18:00:29.014  2222  2222 E AndroidRuntime: Process: com.demo.app, PID: 2222
10-17 18:00:29.014  2222  2222 E AndroidRuntime: java.lang.NullPointerException: boom
10-17 18:00:29.014  2222  2222 E AndroidRuntime: \tat com.demo.app.MainActivity.onCreate(MainActivity.java:41)
10-17 18:00:29.014  2222  2222 E AndroidRuntime: \tat android.app.Activity.performCreate(Activity.java:8000)
"""

NE_DEBUG = """\
10-17 18:00:29.100  3333  3333 F DEBUG   : *** *** *** *** *** *** *** ***
10-17 18:00:29.100  3333  3333 F DEBUG   : Timestamp: 2026-10-17 18:00:29
10-17 18:00:29.100  3333  3333 F DEBUG   : pid: 3333, tid: 3344, name: RenderThread  >>> /system/bin/surfaceflinger <<<
10-17 18:00:29.100  3333  3333 F DEBUG   :     #00 pc 0000abcd  /system/lib64/libfoo.so (foo_bar+16)
10-17 18:00:29.100  3333  3333 F DEBUG   :     #01 pc 0000beef  /system/lib64/libfoo.so
"""

TRANSUCC_HEAD = (
    "10-17 18:00:29.010  4499  4530 I TranSucc.CrashlyticsWork: "
    "handle Crash: procName = com.demo.app, pkgName = com.demo.app, "
    "BIHash = abcdef0123456789abcdef0123456789, crash_type = java_crash, stack='"
)


def _write_log(root, name, text):
    path = Path(root) / name
    path.write_text(text, encoding="utf-8")
    return path


def _make_tne_scanner():
    scanner = object.__new__(ScanAeeTne)
    scanner._ratio_std_tne = 90
    scanner._freeze_tne_type_list = []
    scanner._subsystem_crash_tne_type_list = []
    return scanner


class TransuccMultilineTest(unittest.TestCase):
    def test_stitches_multiline_stack_until_closing_quote(self):
        lines = [
            TRANSUCC_HEAD + "java.lang.NullPointerException: boom\n",
            "10-17 18:00:29.011  4499  4530 I TranSucc.CrashlyticsWork: "
            "\tat com.demo.app.MainActivity.onCreate(MainActivity.java:41)\n",
            "10-17 18:00:29.012  4499  4530 I TranSucc.CrashlyticsWork: "
            "\tat android.app.Activity.performCreate(Activity.java:8000)'\n",
            "10-17 18:00:29.020  4499  4530 I OtherTag: noise\n",
        ]
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = _write_log(temp_dir, "android_main_log", "".join(lines))
            groups = AndroidMainLog(str(log_path)).analyse_transucc()
        self.assertEqual(1, len(groups))
        self.assertEqual("com.demo.app", groups[0]["procName"])
        self.assertEqual("abcdef0123456789abcdef0123456789", groups[0]["BIHash"])
        self.assertIn("java.lang.NullPointerException: boom", groups[0]["stack"])
        self.assertIn("MainActivity.onCreate", groups[0]["stack"])
        self.assertIn("Activity.performCreate", groups[0]["stack"])
        self.assertFalse(groups[0]["stack"].endswith("'"))

    def test_single_line_stack_still_works(self):
        line = (
            TRANSUCC_HEAD
            + "java.lang.NullPointerException: boom\\tat com.demo.app.MainActivity.onCreate(MainActivity.java:41)'\n"
        )
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = _write_log(temp_dir, "android_main_log", line)
            groups = AndroidMainLog(str(log_path)).analyse_transucc()
        self.assertEqual(1, len(groups))
        self.assertIn("NullPointerException", groups[0]["stack"])

    def test_get_hash_value_unchanged_by_multiline_parser(self):
        line = (
            "10-13 19:59:26.844  4499  4530 I TranSucc.CrashlyticsWork: "
            "handle Crash: procName = com.google.android.apps.books, "
            "pkgName = com.google.android.apps.books, "
            "BIHash = 8600d7733aec5660fa8e5005bb39dd6e, "
            "DB-hash = 9b27776de685248085b7cf271fccbf68, crash_type = anr\n"
        )
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = _write_log(temp_dir, "SYS_ANDROID_LOG", line)
            closest_hash = AndroidMainLog(str(log_path)).get_hash_value(
                "apk", "Tue Oct 13 19:59:26 CST 2026", "com.google.android.apps.books")
        self.assertEqual("8600d7733aec5660fa8e5005bb39dd6e", closest_hash)


class CrashNearestPickTest(unittest.TestCase):
    def test_picks_nearest_process_stack_not_first_or_last(self):
        text = JE_TARGET + "\n" + JE_EARLY
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = _write_log(temp_dir, "android_crash_log", text)
            crash_log = AndroidCrashLog(str(log_path))
            last_time, last_detail, last_proc = crash_log.analyse_tne07()
            exp_time, detail = crash_log.analyse_fatal_by_stack(
                "java.lang.NullPointerException: boom",
                process_name="com.demo.app",
                prefer_time="10-17 18:00:29.010",
            )
        self.assertEqual("10-17 18:00:01.000", last_time)
        self.assertEqual("10-17 18:00:29.014", exp_time)
        self.assertIn("NullPointerException", detail)
        self.assertNotIn("IllegalStateException", detail)
        self.assertNotIn("2222", detail)
        self.assertNotIn("8000", detail)

    def test_native_address_cleaned(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = _write_log(temp_dir, "android_crash_log", NE_DEBUG)
            exp_time, detail = AndroidCrashLog(str(log_path)).analyse_fatal_by_stack(
                ">>> /system/bin/surfaceflinger <<<",
                process_name="surfaceflinger",
                prefer_time="10-17 18:00:29.100",
            )
        self.assertIsNotNone(detail)
        self.assertNotIn("0000abcd", detail)
        self.assertNotIn("0x", detail.lower())
        self.assertIn("libfoo.so", detail)


class TruncatedStackMatchTest(unittest.TestCase):
    def test_three_states(self):
        self.assertEqual(("empty", ""), TneBase._transucc_stack_match("  \n  "))
        self.assertEqual(
            ("full", "java.lang.NullPointerException: boom"),
            TneBase._transucc_stack_match("java.lang.NullPointerException: boom"),
        )
        mode, key = TneBase._transucc_stack_match(
            "java.lang.NullPointerException: boom\n\tat andro")
        self.assertEqual("truncated", mode)
        self.assertEqual("java.lang.NullPointerException: boom", key)
        mode, key = TneBase._transucc_stack_match(
            "java.lang.NullPointerException: boom\n\tat android.os.Handler")
        self.assertEqual("truncated", mode)
        self.assertEqual("java.lang.NullPointerException: boom", key)
        mode, key = TneBase._transucc_stack_match(
            "java.lang.NullPointerException: boom\n"
            "\tat com.demo.app.MainActivity.onCreate(MainActivity.java:41)\n"
            "\tat android.app.Activity.performCreate(Activity.java:8000)")
        self.assertEqual("full", mode)
        self.assertIn("MainActivity.onCreate", key)

    def test_tne_dedup_merges_truncated_and_full(self):
        scanner = _make_tne_scanner()
        full = [
            "p1", "V", "t", "c", "0xffffff07", "com.demo.app", "com.demo.app",
            "", "java.lang.NullPointerException: boom\n"
            "at com.demo.app.MainActivity.onCreate(MainActivity.java:41)\n"
            "at android.app.Activity.performCreate(Activity.java:8000)",
            "", "SN1", 1,
        ]
        truncated = [
            "p2", "V", "t", "c", "0xffffff07", "com.demo.app", "com.demo.app",
            "", "java.lang.NullPointerException: boom\n"
            "at android.os.Handler",
            "", "SN2", 1,
        ]
        merged = scanner._merge_tne_final_rows([], [full, truncated])
        self.assertEqual(1, len(merged))
        self.assertEqual(2, merged[0][11])

    def test_default_and_transsion_still_skip_tne_summary(self):
        from unittest import mock
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_scanner = object.__new__(ScanAeeTne)
            tne_scanner._scan_mode = SCAN_MODE_TNE
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

    def test_end_to_end_transucc_replaces_last_crash(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            tne_dir = Path(temp_dir) / "0xffffff07_2026_10_17_18_00_29_14"
            tne_dir.mkdir()
            _write_log(tne_dir, "android_crash_log", JE_EARLY + "\n" + JE_TARGET)
            _write_log(
                tne_dir, "android_main_log",
                TRANSUCC_HEAD + "java.lang.NullPointerException: boom\n"
                "10-17 18:00:29.011  4499  4530 I TranSucc.CrashlyticsWork: "
                "\tat com.demo.app.MainActivity.onCreate(MainActivity.java:41)\n"
                "10-17 18:00:29.012  4499  4530 I TranSucc.CrashlyticsWork: "
                "\tat android.app.Activity.performCreate(Activity.java:8000)'\n")
            tne = Tne07(str(tne_dir))
            self.assertTrue(tne.try_analyse_transucc_crash())
            self.assertIn("NullPointerException", tne._detail)
            self.assertNotIn("IllegalStateException", tne._detail)
            self.assertEqual("abcdef0123456789abcdef0123456789", tne._caused_by)
            self.assertEqual("com.demo.app", tne._package)


if __name__ == "__main__":
    unittest.main()
