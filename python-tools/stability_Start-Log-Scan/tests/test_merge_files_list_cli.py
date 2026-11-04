# -*- coding: utf-8 -*-
"""-merge_files_list 回归测试。

341daa222 引入、bbda5340d 误删；STP 控制面跨主机合并只使用该参数，必须保留。
语义与 341daa222 相同：文件一行一个 xls 路径，忽略空行，追加在 -merge_files 之后。
"""
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


class MergeFilesListCliTest(unittest.TestCase):
    def _run(self, argv):
        merge_instance = mock.Mock()
        merge_ctor = mock.Mock(return_value=merge_instance)
        with mock.patch.object(sys, "argv", argv):
            with mock.patch("modules.mode.MergeExcels.MergeExcels", merge_ctor):
                with mock.patch("modules.mode.ScanAeeTne.ScanAeeTne",
                                mock.Mock(side_effect=AssertionError("不应进入扫描路径"))):
                    with self.assertRaises(SystemExit):
                        runpy.run_path(str(SCRIPT_PATH), run_name="__main__")
        return merge_ctor, merge_instance

    def test_help_lists_flag(self):
        out = subprocess.run([sys.executable, str(SCRIPT_PATH), "-h"], cwd=str(REPO_ROOT),
                             stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        self.assertEqual(0, out.returncode)
        self.assertIn(b"-merge_files_list", out.stdout)
        self.assertIn(b"-match_issues", out.stdout)

    def test_list_file_feeds_start_merge_files(self):
        with tempfile.TemporaryDirectory() as d:
            lst = Path(d) / "files.txt"
            lst.write_text("/a/Result_1_org.xls\n\n  /b/Result_2_org.xls  \n", encoding="utf-8")
            merge_ctor, merge_instance = self._run(
                [str(SCRIPT_PATH), "-merge_files_list", str(lst), "-side", "shanghai"])
        expected = ["/a/Result_1_org.xls", "/b/Result_2_org.xls"]
        self.assertEqual(expected, merge_ctor.call_args[0][0])
        self.assertEqual("shanghai", merge_ctor.call_args[0][1])
        merge_instance.start_merge_files.assert_called_once_with(expected)

    def test_list_appends_after_merge_files(self):
        with tempfile.TemporaryDirectory() as d:
            lst = Path(d) / "files.txt"
            lst.write_text("/b/2.xls\n", encoding="utf-8")
            _, merge_instance = self._run(
                [str(SCRIPT_PATH), "-merge_files", "/a/1.xls", "-merge_files_list", str(lst)])
        merge_instance.start_merge_files.assert_called_once_with(["/a/1.xls", "/b/2.xls"])


if __name__ == "__main__":
    unittest.main()
