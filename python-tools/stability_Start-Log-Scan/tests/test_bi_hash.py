import sys
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from modules.analyse.tne.files.android_main_log import AndroidMainLog
from modules.common.GlobalAttrs import SCAN_MODE_NAME_ALIASES, SCAN_MODE_TRANSSION


class BiHashTest(unittest.TestCase):
    def test_mode_alias_transsion(self):
        self.assertEqual(SCAN_MODE_TRANSSION, SCAN_MODE_NAME_ALIASES["transsion"])

    def test_get_hash_value_from_crashlytics_line(self):
        log_line = (
            "10-13 19:59:26.844  4499  4530 I TranSucc.CrashlyticsWork: "
            "handle Crash: procName = com.google.android.apps.books, "
            "pkgName = com.google.android.apps.books, "
            "BIHash = 8600d7733aec5660fa8e5005bb39dd6e, "
            "DB-hash = 9b27776de685248085b7cf271fccbf68, crash_type = anr\n"
        )
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = Path(temp_dir) / "SYS_ANDROID_LOG"
            log_path.write_text(log_line, encoding="utf-8")
            android_main_log = AndroidMainLog(str(log_path))
            closest_hash = android_main_log.get_hash_value(
                "apk",
                "Tue Oct 13 19:59:26 CST 2026",
                "com.google.android.apps.books",
            )
        self.assertEqual("8600d7733aec5660fa8e5005bb39dd6e", closest_hash)

    def test_get_hash_value_picks_closest_time(self):
        lines = [
            "10-14 00:18:41.230  1  1 I TranSucc.CrashlyticsWork: "
            "handle Crash: procName = com.google.android.apps.books, "
            "pkgName = com.google.android.apps.books, "
            "BIHash = 3e1e10fa6ca29d933283fad9b867c4ff, DB-hash = x, crash_type = anr\n",
            "10-14 00:19:09.653  1  1 I TranSucc.CrashlyticsWork: "
            "handle Crash: procName = com.google.android.apps.books, "
            "pkgName = com.google.android.apps.books, "
            "BIHash = 8600d7733aec5660fa8e5005bb39dd6e, DB-hash = x, crash_type = anr\n",
        ]
        with tempfile.TemporaryDirectory() as temp_dir:
            log_path = Path(temp_dir) / "SYS_ANDROID_LOG"
            log_path.write_text("".join(lines), encoding="utf-8")
            closest_hash = AndroidMainLog(str(log_path)).get_hash_value(
                "apk",
                "Wed Oct 14 00:19:09 CST 2026",
                "com.google.android.apps.books",
            )
        self.assertEqual("8600d7733aec5660fa8e5005bb39dd6e", closest_hash)


if __name__ == "__main__":
    unittest.main()
