# -*- coding: utf-8 -*-
"""成员关系 sidecar（stp.scan_membership v1.0）测试。"""
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
from modules.dedup import membership  # noqa: E402
from modules.dedup.aee_rule import RULE_ID, RULE_VERSION, sha256_text  # noqa: E402


class SidecarFromScanTest(unittest.TestCase):
    def setUp(self):
        self._tmp = tempfile.TemporaryDirectory()
        self.work = Path(self._tmp.name)

    def tearDown(self):
        self._tmp.cleanup()

    def _scan(self, name):
        scan_mode, scan_type, factory = corpus.SCENARIOS[name]
        cfg = self.work / ("cfg_" + name)
        cfg.mkdir()
        corpus.write_config(cfg)
        scanner = corpus.make_scanner(str(cfg), scan_mode, scan_type)
        org, final, _ = scanner._aee_to_data_list(corpus.to_objs(factory()))
        return scanner, org, final

    def _sidecar(self, name):
        scanner, org, final = self._scan(name)
        from modules.common.Excel import Excel
        org_path = self.work / "Result_x_None_MonkeyAEE_SH_20261104_101010_org.xls"
        final_path = self.work / "Result_x_None_MonkeyAEE_SH_20261104_101010.xls"
        Excel(str(org_path)).insertResultAee(org)
        Excel(str(final_path)).insertResultAee(final, deduplicated=True)
        members = membership.members_path_for(str(org_path))
        scanner._write_membership_sidecar(members, org, final, scanner._last_aee_membership,
                                          str(org_path), str(final_path), None)
        data = json.loads(Path(members).read_text(encoding="utf-8"))
        return data, org, final, org_path, final_path, members

    def test_file_name_and_header(self):
        data, org, final, org_path, final_path, members = self._sidecar("aee_shanghai")
        self.assertTrue(members.endswith("Result_x_None_MonkeyAEE_SH_20261104_101010_members.json"))
        self.assertEqual("stp.scan_membership", data["schema"])
        self.assertEqual("1.0", data["schema_version"])
        meta = data["meta"]
        self.assertEqual(RULE_ID, meta["rule"]["id"])
        self.assertEqual(RULE_VERSION, meta["rule"]["version"])
        self.assertEqual(90, meta["rule"]["params"]["threshold"])
        self.assertEqual("start-log-scan", meta["tool"]["name"])
        self.assertIn("recognizeexception", meta["parsers"])
        self.assertEqual(org_path.name, meta["reports"]["org_xls"]["file"])
        self.assertEqual(sha256_text_bytes(org_path), meta["reports"]["org_xls"]["sha256"])
        self.assertEqual(len(final), meta["reports"]["final_xls"]["rows"])
        self.assertFalse(Path(members + ".tmp").exists())

    def test_every_org_row_once_and_join_keys_match_xls(self):
        import xlrd
        data, org, final, org_path, _, _ = self._sidecar("aee_shanghai")
        self.assertEqual(len(org), len(data["rows"]))
        sheet = xlrd.open_workbook(str(org_path)).sheet_by_name("aeeexp")
        header = [str(h).strip() for h in sheet.row_values(0)]
        path_col = header.index("Path")
        for row in data["rows"]:
            # G3 映射：mapping.row（表头为第 1 行的一基行号）== org_row + 1
            xls_row = row["org_row"] + 1
            self.assertEqual(row["path"], sheet.cell_value(xls_row - 1, path_col))
            self.assertEqual(row["org_row"] - 1, int(sheet.cell_value(xls_row - 1, 0)))

    def test_groups_consistent_with_final(self):
        data, org, final, _, _, _ = self._sidecar("aee_shanghai")
        self.assertEqual(len(final), len(data["groups"]))
        rows_by_no = {r["org_row"]: r for r in data["rows"]}
        for g in data["groups"]:
            final_row = final[g["final_row"] - 1]
            self.assertEqual(final_row[10], g["count"])
            self.assertEqual(len(g["member_rows"]), g["count"])
            self.assertEqual(g["representative_row"], g["member_rows"][0])
            rep = rows_by_no[g["representative_row"]]
            self.assertTrue(rep["is_representative"])
            self.assertEqual(final_row[0], rep["path"])
            self.assertEqual(final_row[8], g["representative_signature"]["caused_by"])
            for m in g["member_rows"][1:]:
                member = rows_by_no[m]
                self.assertEqual(g["group"], member["group"])
                self.assertFalse(member["is_representative"])
                self.assertEqual("similarity", member["branch"])
                self.assertGreaterEqual(member["similarity_to_rep"], 90)
                self.assertEqual(rep["signature"]["exp_class"], member["signature"]["exp_class"])
                self.assertEqual(rep["signature"]["package"], member["signature"]["package"])

    def test_branches_and_filter_reasons(self):
        data, *_ = self._sidecar("aee_shanghai")
        stats = data["stats"]
        self.assertEqual(stats["rows"], stats["filtered"] + stats["singleton"] + stats["similarity"])
        self.assertEqual(2, stats["singleton"])
        self.assertEqual(
            {"ad10_pr0_camera", "anr_screen_off", "invalid_combo_wifi",
             "nfc_too_close", "not_in_pkglist", "pid_not_found", "preanalyse_discard",
             "unknown_app_crash"},
            set(stats["filter_reasons"]))
        for row in data["rows"]:
            if row["branch"] == "filtered":
                self.assertIsNone(row["group"])
                self.assertTrue(row["filter_reason"])
            else:
                self.assertIsNone(row["filter_reason"])
                self.assertIsNotNone(row["group"])
        # 非 fatal 的 detailToBeDone 行并入首个 singleton 组
        singleton_groups = [g for g in data["groups"] if g["entered_by"] == "singleton"]
        self.assertEqual(2, len(singleton_groups))
        self.assertEqual(2, singleton_groups[0]["count"])

    def test_platform_fuzz_factory_reasons(self):
        expected = {"platform": {"platform_data_app"}, "fuzz": {"fuzz"}, "factory": {"factory_api"}}
        for name, reasons in expected.items():
            with self.subTest(scenario=name):
                data, *_ = self._sidecar(name)
                self.assertTrue(reasons <= set(data["stats"]["filter_reasons"]))

    def test_emergency_after_s(self):
        scan_mode, scan_type, factory = corpus.SCENARIOS["aee_shanghai"]
        cfg = self.work / "cfg_emergency"
        cfg.mkdir()
        corpus.write_config(cfg)
        scanner = corpus.make_scanner(str(cfg), scan_mode, scan_type)
        scanner._android = "T"
        org, final, _ = scanner._aee_to_data_list(corpus.to_objs(factory()))
        sidecar = membership.build_sidecar(org, final, scanner._last_aee_membership, {})
        self.assertIn("emergency_after_s", sidecar["stats"]["filter_reasons"])

    def test_discard_rows_appended_after_dedup(self):
        scanner, org, final = self._scan("aee_shanghai")
        discard = ["/x/db.discard", "discard_dbg_version", "", "", "", "", "discard_dbg", "", "", "", 1, "", None, False, ""]
        org = scanner._save_discard_to_org(org, [discard])
        sidecar = membership.build_sidecar(org, final, scanner._last_aee_membership, {})
        last = sidecar["rows"][-1]
        self.assertEqual("filtered", last["branch"])
        self.assertEqual("preanalyse_discard", last["filter_reason"])

    def test_empty_scan(self):
        sidecar = membership.build_sidecar([], [], membership.AeeMembershipTrace(90), {}, final_written=False)
        self.assertEqual([], sidecar["rows"])
        self.assertEqual([], sidecar["groups"])

    def test_incremental_composition(self):
        scanner, org, full_final = self._scan("aee_shanghai")
        full_trace = scanner._last_aee_membership
        from modules.mode.incremental_org import attrs_to_aee_excel_data
        prev_paths = {org[0][0], org[1][0]}  # 第 1、2 行（同组）已在上次扫描
        delta_org = [r for r in org if r[0] not in prev_paths]
        _, delta_final, _ = scanner._aee_to_data_list([attrs_to_aee_excel_data(r) for r in delta_org])
        composed = membership.compose_incremental_trace(org, full_trace, delta_org, scanner._last_aee_membership)
        sidecar = membership.build_sidecar(org, delta_final, composed, {})
        rows = sidecar["rows"]
        self.assertEqual("incremental_prev_path", rows[0]["filter_reason"])
        self.assertEqual("incremental_prev_path", rows[1]["filter_reason"])
        self.assertTrue(rows[2]["is_representative"])  # 第 3 行成为差集中该组代表
        self.assertEqual(len(delta_final), len(sidecar["groups"]))
        for g in sidecar["groups"]:
            self.assertEqual(delta_final[g["final_row"] - 1][10], g["count"])

    def test_incremental_no_delta(self):
        scanner, org, _ = self._scan("aee_shanghai")
        composed = membership.compose_incremental_trace(org, scanner._last_aee_membership, [], None)
        sidecar = membership.build_sidecar(org, [], composed, {}, final_written=False)
        self.assertEqual([], sidecar["groups"])
        self.assertTrue(all(r["branch"] == "filtered" for r in sidecar["rows"]))


class DedupOrgSidecarTest(unittest.TestCase):
    def test_dedup_org_writes_members(self):
        import xlrd  # noqa: F401
        from modules.common.Excel import Excel
        from modules.mode.DedupOrgExcel import DedupOrgExcel
        with tempfile.TemporaryDirectory() as d:
            cfg = Path(d) / "config"
            cfg.mkdir()
            corpus.write_config(cfg)
            scanner = corpus.make_scanner(str(cfg), "SCAN_MODE_AEE", "shanghai")
            org, _, _ = scanner._aee_to_data_list(corpus.to_objs(corpus.corpus_rows()))
            org_path = Path(d) / "Result_demo_org.xls"
            Excel(str(org_path)).insertResultAee(org)
            out = DedupOrgExcel(str(org_path), "shanghai", config_dir=str(cfg)).run()
            members = Path(membership.members_path_for(out))
            self.assertTrue(members.is_file())
            data = json.loads(members.read_text(encoding="utf-8"))
            self.assertEqual(org_path.name, data["meta"]["reports"]["org_xls"]["file"])
            self.assertEqual(Path(out).name, data["meta"]["reports"]["final_xls"]["file"])
            self.assertEqual(len(org), len(data["rows"]))


def sha256_text_bytes(path):
    import hashlib
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


if __name__ == "__main__":
    unittest.main()


class ScanAeeTneGenerateResultTest(unittest.TestCase):
    """__generate_result 端到端：xls、members.json、summary.json 同前缀，summary 登记 members_json。"""

    def _scanner(self, work, trace_src):
        from modules.mode.ScanAeeTne import ScanAeeTne
        s = ScanAeeTne.__new__(ScanAeeTne)
        for k, v in trace_src.__dict__.items():
            setattr(s, k, v)
        s._build_version = None
        s._jira_repo = "NX2"
        s._reporter = "stp"
        s._scan_root_dir = str(work)
        s._report_date_formatted = "20261104"
        s._scan_place = "SH"
        return s

    def test_generate_result_writes_members(self):
        with tempfile.TemporaryDirectory() as d:
            work = Path(d)
            cfg = work / "cfg"
            cfg.mkdir()
            corpus.write_config(cfg)
            src = corpus.make_scanner(str(cfg), "SCAN_MODE_AEE", "shanghai")
            org, final, _ = src._aee_to_data_list(corpus.to_objs(corpus.corpus_rows()))
            out = work / "out"
            out.mkdir()
            scanner = self._scanner(out, src)
            summary = {}
            scanner._ScanAeeTne__generate_result(org, final, summary,
                                                 membership_trace=src._last_aee_membership)
            members = sorted(out.glob("*_members.json"))
            orgs = sorted(out.glob("*_org.xls"))
            self.assertEqual(1, len(members))
            self.assertEqual(orgs[0].name[:-len("_org.xls")], members[0].name[:-len("_members.json")])
            data = json.loads(members[0].read_text(encoding="utf-8"))
            self.assertEqual(len(org), len(data["rows"]))
            self.assertEqual(len(final), len(data["groups"]))
            summary_file = sorted(out.glob("*_summary.json"))[0]
            gen = json.loads(summary_file.read_text(encoding="utf-8"))["generated_files"]
            self.assertEqual(str(members[0]), gen["members_json"])
