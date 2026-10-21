import sys
import tempfile
import unittest
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from modules.mode.ScanAeeTne import ScanAeeTne


def _make_scanner(root):
    scanner = object.__new__(ScanAeeTne)
    scanner._scan_root_dir = str(root)
    scanner._scan_date_formatted_aee = None
    scanner._zero_size_dbg_set = set()
    scanner._extract_failed_dbg_set = set()
    return scanner


class ScanExpMainPlanBTest(unittest.TestCase):
    def test_finds_exp_main_under_dec_and_skips_mobilelog(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            root = Path(temp_dir)
            keep = root / "sn1" / "aee_exp" / "db.01.ANR" / "db.01.ANR.dbg.DEC"
            keep.mkdir(parents=True)
            keep_exp = keep / "__exp_main.txt"
            keep_exp.write_text("ok", encoding="utf-8")
            # DEC 子目录内的同名文件不应被扫入（关键文件只在 DEC 根）
            nested = keep / "subdir"
            nested.mkdir()
            (nested / "__exp_main.txt").write_text("nested", encoding="utf-8")
            # 重日志目录内的假阳性应被剪枝跳过
            noise = root / "sn1" / "debuglogger" / "mobilelog" / "deep"
            noise.mkdir(parents=True)
            (noise / "__exp_main.txt").write_text("noise", encoding="utf-8")

            scanner = _make_scanner(root)
            got = scanner._ScanAeeTne__scan_exp_main_list()
            self.assertEqual([str(keep_exp)], got)

    def test_prune_skip_dir_names(self):
        dirs = ["aee_exp", "mobilelog", "debuglogger", ".git", "db.01.ANR.dbg.DEC"]
        ScanAeeTne._prune_walk_dirs(dirs, skip_dec_dirs=False)
        self.assertEqual(["aee_exp", "db.01.ANR.dbg.DEC"], dirs)

        dirs2 = ["aee_exp", "db.01.ANR.dbg.DEC", "mobilelog"]
        ScanAeeTne._prune_walk_dirs(dirs2, skip_dec_dirs=True)
        self.assertEqual(["aee_exp"], dirs2)

    def test_new_test_dir_count_matches_baseline_walk(self):
        """与朴素 os.walk 在 NEW/test 上找到的 __exp_main 数量一致。"""
        test_root = Path(r"C:\Users\dai.lv\Desktop\NEW\test")
        if not test_root.is_dir():
            self.skipTest("NEW/test not present")

        baseline = []
        for r, _d, files in __import__("os").walk(str(test_root)):
            if "__exp_main.txt" in files:
                baseline.append(__import__("os").path.join(r, "__exp_main.txt"))

        scanner = _make_scanner(test_root)
        got = scanner._ScanAeeTne__scan_exp_main_list()
        self.assertEqual(sorted(baseline), sorted(got))


if __name__ == "__main__":
    unittest.main()
