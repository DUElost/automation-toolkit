# -*- coding: utf-8 -*-
"""去重行为 golden 测试：org / final 列表与两份 xls 字节必须与基线一致。

基线 tests/golden/aee_dedup_golden.json 由引入成员关系输出之前的代码
（main a1f405b）生成。任何让本测试失败的改动都改变了去重行为或报表格式。
"""
import json
import sys
import tempfile
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))
TESTS_DIR = Path(__file__).resolve().parent
if str(TESTS_DIR) not in sys.path:
    sys.path.insert(0, str(TESTS_DIR))

from golden import aee_dedup_corpus as corpus  # noqa: E402


class AeeDedupGoldenTest(unittest.TestCase):
    def test_outputs_match_baseline(self):
        golden = json.loads(corpus.GOLDEN_PATH.read_text(encoding="utf-8"))
        with tempfile.TemporaryDirectory() as d:
            for name in sorted(corpus.SCENARIOS):
                with self.subTest(scenario=name):
                    out, _ = corpus.run_scenario(name, d)
                    out = json.loads(json.dumps(out, ensure_ascii=False, sort_keys=True))
                    self.assertEqual(golden[name]["org"], out["org"])
                    self.assertEqual(golden[name]["final"], out["final"])
                    self.assertEqual(golden[name]["deleted"], out["deleted"])
                    self.assertEqual(golden[name]["xls_sha256"], out["xls_sha256"])


if __name__ == "__main__":
    unittest.main()
