# -*- coding: utf-8 -*-
"""failed-dbg 兜底结果的设备号取值（v2.1.1）。

缺陷：v2.1.0 把扫描根下第一级目录（STP 布局中是项目目录）当作 DeviceId，
并对整个项目目录 os.walk 读 SYS_PROPERTIES、以项目目录作缓存键。
STP 扫描根布局：<scan_root>/<项目目录>/<串号>/...（平台 scan_scope.build_scoped_scan_root）。
"""
import os
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))
TESTS_DIR = Path(__file__).resolve().parent
if str(TESTS_DIR) not in sys.path:
    sys.path.insert(0, str(TESTS_DIR))

from golden import aee_dedup_corpus as corpus  # noqa: E402

PROJECT = "MLD-LX2_16_261010V143_1105_MonkeyAEEinfo"
SN_A = "AYCGNX6616000305"
SN_B = "BXCGNX6616000999"
UNKNOWN = "unknown_device_id"
DISCARD = "discard_device_id"


def _props(device_id, build):
    return "[ro.build.display.id]: [{}]\n[ro.serialno]: [{}]\n".format(build, device_id)


class FailedDbgDeviceIdTest(unittest.TestCase):
    def setUp(self):
        self._tmp = tempfile.TemporaryDirectory()
        self.work = Path(self._tmp.name)
        self.root = self.work / "scan_root"
        self.root.mkdir()
        cfg = self.work / "cfg"
        cfg.mkdir()
        corpus.write_config(cfg)
        self.scanner = corpus.make_scanner(str(cfg), "SCAN_MODE_AEE", "shanghai")
        self.scanner._scan_root_dir = str(self.root)
        self.scanner._build_version = None
        self.scanner._failed_dbg_info_cache = {}

    def tearDown(self):
        self._tmp.cleanup()

    def _dbg(self, *parts):
        path = self.root.joinpath(*parts)
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(b"")
        return str(path)

    def _write_props(self, *parts, device_id, build):
        path = self.root.joinpath(*parts, "SYS_PROPERTIES")
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(_props(device_id, build), encoding="utf-8")
        return path

    def _get(self, dbg):
        return self.scanner._get_failed_dbg_build_version_and_device_id(dbg)

    # 1. 反例：v2.1.0 得到项目目录名
    def test_serial_dir_under_project_dir(self):
        dbg = self._dbg(PROJECT, SN_A, "aee_exp", "1793871130516_db.01.NE")
        build, device_id = self._get(dbg)
        self.assertEqual(SN_A, device_id)
        self.assertNotEqual(PROJECT, device_id)
        self.assertEqual("VersionNone", build)

    def test_vendor_aee_exp(self):
        dbg = self._dbg(PROJECT, SN_A, "vendor_aee_exp", "2026_1022_133239_000_db.01.NE")
        self.assertEqual(SN_A, self._get(dbg)[1])

    def test_rule_independent_of_scan_root(self):
        # 串号取 aee_exp 上一级，与扫描根层级无关
        self.scanner._scan_root_dir = str(self.work / "unrelated_root")
        dbg = self._dbg(PROJECT, "extra_level", SN_A, "aee_exp", "db.01.NE")
        self.assertEqual(SN_A, self._get(dbg)[1])

    # 2. 不读同项目其他设备的属性
    def test_does_not_read_other_device_properties(self):
        self._write_props(PROJECT, SN_B, "aee_exp", "db.00.NE.DEC", device_id=SN_B, build="Bver")
        dbg_a = self._dbg(PROJECT, SN_A, "aee_exp", "1793871130516_db.01.NE")
        from modules.mode import BaseScan as base_scan
        real = base_scan.SysProperties
        constructed = []

        def spy(path):
            constructed.append(path)
            return real(path)

        with mock.patch.object(base_scan, "SysProperties", side_effect=spy):
            build, device_id = self._get(dbg_a)
        self.assertEqual(SN_A, device_id)
        self.assertNotEqual("Bver", build)
        sn_a_dir = str(self.root / PROJECT / SN_A)
        for path in constructed:
            self.assertTrue(str(path).startswith(sn_a_dir + os.sep), path)

    def test_reads_own_properties(self):
        self._write_props(PROJECT, SN_A, "aee_exp", "db.00.NE.DEC", device_id=SN_A, build="Aver")
        dbg_a = self._dbg(PROJECT, SN_A, "aee_exp", "1793871130516_db.01.NE")
        self.assertEqual(("Aver", SN_A), self._get(dbg_a))

    # 3. 不复用错误缓存（两种顺序）
    def _two_devices(self):
        self._write_props(PROJECT, SN_B, "aee_exp", "db.00.NE.DEC", device_id=SN_B, build="Bver")
        dbg_a = self._dbg(PROJECT, SN_A, "aee_exp", "1793871130516_db.01.NE")
        dbg_b = self._dbg(PROJECT, SN_B, "aee_exp", "2026_1022_133239_000_db.01.NE")
        return dbg_a, dbg_b

    def test_cache_b_then_a(self):
        dbg_a, dbg_b = self._two_devices()
        rlt_b = self._get(dbg_b)
        rlt_a = self._get(dbg_a)
        self.assertEqual(("Bver", SN_B), rlt_b)
        self.assertEqual(SN_A, rlt_a[1])
        self.assertNotEqual(rlt_b, rlt_a)
        self.assertNotIn(str(self.root / PROJECT), self.scanner._failed_dbg_info_cache)

    def test_cache_a_then_b(self):
        dbg_a, dbg_b = self._two_devices()
        rlt_a = self._get(dbg_a)
        rlt_b = self._get(dbg_b)
        self.assertEqual(SN_A, rlt_a[1])
        self.assertEqual(("Bver", SN_B), rlt_b)
        self.assertNotIn(str(self.root / PROJECT), self.scanner._failed_dbg_info_cache)

    # 4. 无法证明：输出 unknown_device_id，不 walk、不读属性
    def _assert_unproven(self, dbg):
        from modules.mode import BaseScan as base_scan
        with mock.patch.object(base_scan.os, "walk", side_effect=AssertionError("不应 os.walk")), \
                mock.patch.object(base_scan, "SysProperties", side_effect=AssertionError("不应读 SYS_PROPERTIES")):
            build, device_id = self._get(dbg)
        self.assertEqual(UNKNOWN, device_id)
        self.assertEqual("VersionNone", build)

    def test_no_aee_exp_dir(self):
        self._write_props(PROJECT, SN_B, "x", device_id=SN_B, build="Bver")
        self._assert_unproven(self._dbg(PROJECT, "1793871130516_db.01.NE"))
        self._assert_unproven(self._dbg(PROJECT, SN_A, "1793871130516_db.01.NE"))

    def test_aee_exp_directly_under_project_dir(self):
        self._assert_unproven(self._dbg(PROJECT, "aee_exp", "db.01.NE"))

    def test_serial_dir_with_underscore(self):
        self._assert_unproven(self._dbg(PROJECT, "AYCG_NX6616", "aee_exp", "db.01.NE"))

    def test_serial_dir_all_digits(self):
        self._assert_unproven(self._dbg(PROJECT, "1793871130516", "aee_exp", "db.01.NE"))

    def test_serial_dir_with_dash_or_dot(self):
        self._assert_unproven(self._dbg(PROJECT, "AYCG-NX6616", "aee_exp", "db.01.NE"))
        self._assert_unproven(self._dbg(PROJECT, "AYCG.NX6616", "aee_exp", "db.01.NE"))

    def test_no_regex_fallback(self):
        # v2.1.0 会用 /([A-Za-z0-9]{10,})/ 从任意位置兜底取值
        outside = self.work / "elsewhere" / "ZZZZZZ9999999" / "db.01.NE"
        outside.parent.mkdir(parents=True)
        outside.write_bytes(b"")
        self._assert_unproven(str(outside))

    def test_unproven_uses_scan_build_version(self):
        self.scanner._build_version = "NX2-V1"
        build, device_id = self._get(self._dbg(PROJECT, "db.01.NE"))
        self.assertEqual(("NX2-V1", UNKNOWN), (build, device_id))

    def test_unproven_never_outputs_path_component(self):
        dbg = self._dbg(PROJECT, "1793871130516_db.01.NE")
        _, device_id = self._get(dbg)
        self.assertNotIn(device_id, Path(dbg).parts)

    # 5. 冲突：路径串号 A，属性 device_id B
    def test_properties_conflict(self):
        self._write_props(PROJECT, SN_A, "aee_exp", "db.00.NE.DEC", device_id=SN_B, build="Aver")
        dbg = self._dbg(PROJECT, SN_A, "aee_exp", "db.01.NE")
        self.assertEqual(("Aver", DISCARD), self._get(dbg))

    # 6. 旧布局：扫描根就是项目目录
    def test_legacy_layout_scan_root_is_project(self):
        self.scanner._scan_root_dir = str(self.root / PROJECT)
        self._write_props(PROJECT, SN_A, "aee_exp", "db.00.NE.DEC", device_id=SN_A, build="Aver")
        dbg = self._dbg(PROJECT, SN_A, "aee_exp", "db.01.NE")
        self.assertEqual(("Aver", SN_A), self._get(dbg))

    def test_windows_separators(self):
        dbg = self._dbg(PROJECT, SN_A, "aee_exp", "db.01.NE")
        self.assertEqual(SN_A, self._get(dbg.replace("/", "\\"))[1])


def _aee_extract_runnable():
    tool = PROJECT_ROOT / "tools" / "aee_extract" / "aee_extract"
    return sys.platform.startswith("linux") and tool.is_file() and os.access(str(tool), os.X_OK)


@unittest.skipUnless(_aee_extract_runnable(), "需要 Linux 且 aee_extract 可执行")
class CorruptDbgFallbackTest(unittest.TestCase):
    """用人为损坏的 dbg 走真实 aee_extract → failed-dbg 兜底，检查兜底行的 DeviceId 与 Detail。"""

    def test_corrupt_dbg_fallback_row(self):
        with tempfile.TemporaryDirectory() as d:
            work = Path(d)
            cfg = work / "cfg"
            cfg.mkdir()
            corpus.write_config(cfg)
            scanner = corpus.make_scanner(str(cfg), "SCAN_MODE_AEE", "shanghai")
            root = work / "scan_root"
            scanner._scan_root_dir = str(root)
            scanner._build_version = None
            scanner._failed_dbg_info_cache = {}
            scanner._aee_extract = str(PROJECT_ROOT / "tools" / "aee_extract" / "aee_extract")
            scanner._extract_dbg_time_out = 60
            scanner._ignore_pkglist = True
            scanner._archive_address = None
            scanner._replace_index = None
            dbg_files = []
            for sn, name in ((SN_A, "1793871130516_db.01.NE"), (SN_B, "2026_1022_133239_000_db.01.NE")):
                dbg = root / PROJECT / sn / "aee_exp" / name
                dbg.parent.mkdir(parents=True)
                dbg.write_bytes(os.urandom(4096))  # 人为损坏
                dbg_files.append(str(dbg))
            failed = scanner._extract_dbg(dbg_files)
            self.assertEqual(sorted(dbg_files), sorted(failed))
            rows = scanner._build_extract_failed_aee_result_list(failed)
            by_path = {r.get_aee_attrs()[0]: r.get_aee_attrs() for r in rows}
            self.assertEqual(2, len(by_path))
            for sn, dbg in zip((SN_A, SN_B), dbg_files):
                attrs = by_path[dbg]
                self.assertEqual(sn, attrs[12])
                self.assertIn("Device_id: {}".format(sn), attrs[7])
                self.assertNotIn(PROJECT, attrs[7])


if __name__ == "__main__":
    unittest.main()
