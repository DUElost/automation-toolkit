# -*- coding: utf-8 -*-
"""-match_issues 匹配入口测试。只用标准库，可在 Python 3.7/3.8/3.11 运行。"""
import json
import os
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path

PROJECT_ROOT = Path(__file__).resolve().parents[1]
SCRIPT_PATH = PROJECT_ROOT / "start_log_scan.py"
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from modules.dedup import aee_rule  # noqa: E402
from modules.dedup.match_cli import InputError, run_match  # noqa: E402

NPE = "java.lang.NullPointerException at Foo.bar(Foo.java:{})"


def _req(existing, rows):
    return {"schema": "stp.issue_match_request", "schema_version": "1.0", "existing": existing, "rows": rows}


def _row(ref, caused_by, exp_class="Java (JE)", package="com.a", path="/x/db.00"):
    return {"ref": ref, "exp_class": exp_class, "package": package, "caused_by": caused_by, "path": path}


def _issue(issue_id, caused_by, exp_class="Java (JE)", package="com.a"):
    return {"issue_id": issue_id, "exp_class": exp_class, "package": package, "caused_by": caused_by}


class MatchIssuesTest(unittest.TestCase):
    def test_matches_existing_first_hit_in_order(self):
        out = run_match(_req([_issue("I1", NPE.format(1)), _issue("I2", NPE.format(2))],
                             [_row("r1", NPE.format(99))]))
        r = out["results"][0]
        self.assertEqual("I1", r["matched_issue_id"])
        self.assertEqual("similarity", r["branch"])
        self.assertGreaterEqual(r["similarity"], 90)
        self.assertIsNone(r["new_group"])

    def test_key_fields_must_be_equal(self):
        out = run_match(_req([_issue("I1", NPE.format(1), package="com.b"),
                              _issue("I2", NPE.format(1), exp_class="Native (NE)")],
                             [_row("r1", NPE.format(1))]))
        self.assertIsNone(out["results"][0]["matched_issue_id"])
        self.assertEqual("n1", out["results"][0]["new_group"])

    def test_new_groups_absorb_later_rows(self):
        out = run_match(_req([], [_row("r1", NPE.format(1)), _row("r2", NPE.format(2)),
                                  _row("r3", "completely different text zzz")]))
        res = out["results"]
        self.assertEqual(("n1", None), (res[0]["new_group"], res[0]["similarity"]))
        self.assertEqual("n1", res[1]["new_group"])
        self.assertIsNotNone(res[1]["similarity"])
        self.assertEqual("n2", res[2]["new_group"])
        self.assertEqual(2, out["stats"]["new_groups"])

    def test_singleton_never_matches_but_can_absorb(self):
        fatal = "/x/fatal/db.fatal.00"
        out = run_match(_req([_issue("I1", "detailToBeDone")],
                             [_row("r1", "detailToBeDone", path=fatal), _row("r2", "detailToBeDone")]))
        res = out["results"]
        self.assertEqual("singleton", res[0]["branch"])
        self.assertIsNone(res[0]["matched_issue_id"])
        # 非 fatal 行仍按顺序先比 existing
        self.assertEqual("I1", res[1]["matched_issue_id"])

    def test_meta(self):
        out = run_match(_req([], []))
        self.assertEqual("stp.issue_match_result", out["schema"])
        self.assertEqual(aee_rule.RULE_ID, out["meta"]["rule"]["id"])
        self.assertEqual("1", out["meta"]["rule"]["version"])
        self.assertIn("git_commit", out["meta"]["tool"])

    def test_invalid_input(self):
        for bad in ({"schema": "x"}, _req([], [_row("r", "a"), _row("r", "b")]),
                    _req([{"issue_id": 1}], []), dict(_req([], []), schema_version="2.0")):
            with self.subTest(bad=bad):
                with self.assertRaises(InputError):
                    run_match(bad)

    def test_equivalent_to_in_scan_grouping(self):
        """existing 为空时，匹配入口的分组与扫描内去重一致（同一规则实现）。"""
        rows = [_row("r{}".format(i), NPE.format(i)) for i in range(5)]
        rows.append(_row("rx", "other"))
        rows.append(_row("rf", "detailToBeDone", path="/x/fatal/db"))
        rows.append(_row("rg", "detailToBeDone"))
        reps, groups = [], []
        for r in rows:
            if aee_rule.is_singleton(r["path"], r["caused_by"]):
                idx = None
            else:
                idx, _, _ = aee_rule.find_first_match(reps, r["exp_class"], r["package"], r["caused_by"])
            if idx is None:
                reps.append((r["exp_class"], r["package"], r["caused_by"]))
                groups.append(len(reps))
            else:
                groups.append(idx + 1)
        out = run_match(_req([], rows))
        self.assertEqual(["n{}".format(g) for g in groups], [r["new_group"] for r in out["results"]])


class MatchCliTest(unittest.TestCase):
    def _run(self, payload, python=sys.executable):
        with tempfile.TemporaryDirectory() as d:
            inp = Path(d) / "in.json"
            outp = Path(d) / "out" / "result.json"
            inp.write_text(json.dumps(payload) if not isinstance(payload, str) else payload, encoding="utf-8")
            proc = subprocess.run([python, str(SCRIPT_PATH), "-match_issues", str(inp), "-o", str(outp)],
                                  cwd=str(PROJECT_ROOT), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            result = json.loads(outp.read_text(encoding="utf-8")) if outp.exists() else None
            return proc.returncode, result, proc.stderr.decode("utf-8", "ignore")

    def test_cli_ok_without_scan_dependencies(self):
        # 入口在加载扫描依赖前分流，未装 xlrd/xlwt/pymysql 的解释器也能运行
        code, result, err = self._run(_req([_issue("I1", NPE.format(1))], [_row("r1", NPE.format(2))]))
        self.assertEqual(0, code, err)
        self.assertEqual("I1", result["results"][0]["matched_issue_id"])
        self.assertNotIn("xlwt", err)

    def test_cli_does_not_import_scan_modules(self):
        probe = ("import sys, runpy; sys.argv=['start_log_scan.py','-match_issues','{inp}','-o','{out}'];\n"
                 "try:\n runpy.run_path('start_log_scan.py', run_name='__main__')\n"
                 "except SystemExit as e:\n assert e.code == 0, e.code\n"
                 "bad=[m for m in ('xlwt','xlrd','pymysql','modules.mode.BaseScan') if m in sys.modules]\n"
                 "assert not bad, bad\n")
        with tempfile.TemporaryDirectory() as d:
            inp = Path(d) / "in.json"
            inp.write_text(json.dumps(_req([], [])), encoding="utf-8")
            code = subprocess.run([sys.executable, "-c", probe.format(inp=inp, out=Path(d) / "o.json")],
                                  cwd=str(PROJECT_ROOT)).returncode
        self.assertEqual(0, code)

    def test_cli_bad_input_exit_2(self):
        code, result, _ = self._run("{not json")
        self.assertEqual(2, code)
        self.assertIsNone(result)
        code, _, _ = self._run({"schema": "nope"})
        self.assertEqual(2, code)


if __name__ == "__main__":
    unittest.main()
