import io
import os
import runpy
import sys
import tempfile
import unittest
from contextlib import redirect_stdout
from pathlib import Path
from unittest import mock


REPO_ROOT = Path(__file__).resolve().parents[1]
SCRIPT_PATH = REPO_ROOT / "start_log_scan.py"
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))


class _DummyAeeResult:
    def __init__(self, path, cur_process, package):
        self._attrs = [
            path,
            "V1.0",
            "2026-11-26 11:20:12",
            "Java (JE)",
            "system_app_crash",
            cur_process,
            package,
            "Device_id: dev1\nBacktrace:\njava.lang.NullPointerException",
            "hash_abc",
            "",
            1,
            "MainActivity",
            "dev1",
            False,
            "",
        ]

    def get_aee_attrs(self):
        return list(self._attrs)

    @property
    def recognize_exception_rlt(self):
        return True

    @property
    def handle_recognize_rlt(self):
        return True

    def is_ignore_ke_ne_hwasan(self):
        return False

    def is_ne_system_issue(self):
        return False


class NoWhitelistCliTest(unittest.TestCase):
    def test_help_includes_no_whitelist_argument(self):
        buf = io.StringIO()
        with mock.patch.object(sys, "argv", [str(SCRIPT_PATH), "-h"]):
            with redirect_stdout(buf):
                with self.assertRaises(SystemExit) as exit_ctx:
                    runpy.run_path(str(SCRIPT_PATH), run_name="__main__")
        self.assertEqual(0, exit_ctx.exception.code)
        help_text = buf.getvalue()
        self.assertIn("-nw", help_text)
        self.assertIn("--no_whitelist", help_text)

    def test_default_keeps_whitelist_enabled_for_scanaeetne(self):
        scanner_instance = mock.Mock()
        scanner_ctor = mock.Mock(return_value=scanner_instance)
        with tempfile.TemporaryDirectory() as temp_dir:
            argv = [
                str(SCRIPT_PATH),
                "-m",
                "transsion",
                "-d",
                temp_dir,
                "-s",
            ]
            with mock.patch.object(sys, "argv", argv):
                with mock.patch("modules.mode.ScanAeeTne.ScanAeeTne", scanner_ctor):
                    runpy.run_path(str(SCRIPT_PATH), run_name="__main__")

        self.assertTrue(scanner_ctor.called)
        self.assertFalse(scanner_ctor.call_args.kwargs.get("ignore_pkglist"))
        scanner_instance.start_scan.assert_called_once_with()

    def test_no_whitelist_flag_passed_to_all_scanbase_modes(self):
        mode_to_target = [
            ("transsion", "modules.mode.ScanAeeTne.ScanAeeTne", []),
            ("3", "modules.mode.ScanAeeFans.ScanAeeFans", []),
            ("4", "modules.mode.ScanTneUsic.ScanTneUsic", []),
            ("14", "modules.mode.ScanTneUsic.ScanTneUsic", []),
            ("20", "modules.mode.ScanTneUsic.ScanTneUsic", []),
            ("21", "modules.mode.ScanTneUsic.ScanTneUsic", []),
            ("10", "modules.mode.ScanStuckLogo.ScanStuckLogo", []),
            ("5", "modules.mode.ScanAeePlatform.ScanAeePlatform", []),
            ("11", "modules.mode.ScanAeeMedia.ScanAeePlatformMedia", []),
            ("6", "modules.mode.ScanAeeDaily.ScanAeeDaily", []),
            ("9", "modules.mode.ScanAeeMTBF.ScanAeeMTBF", []),
            ("18", "modules.mode.ScanAeeOTADaily.ScanAeeOTADaily", []),
            ("19", "modules.mode.ScanAeeIndependent.ScanAeeIndependent", []),
            ("22", "modules.mode.ScanTneUpload.ScanTneUpload", []),
        ]
        for flag in ("-nw", "--no_whitelist"):
            for mode_arg, patch_target, extra_args in mode_to_target:
                with self.subTest(flag=flag, mode=mode_arg, target=patch_target):
                    scanner_instance = mock.Mock()
                    scanner_ctor = mock.Mock(return_value=scanner_instance)
                    with tempfile.TemporaryDirectory() as temp_dir:
                        argv = [
                            str(SCRIPT_PATH),
                            "-m",
                            mode_arg,
                            "-d",
                            temp_dir,
                            "-s",
                            flag,
                        ] + extra_args
                        with mock.patch.object(sys, "argv", argv):
                            with mock.patch(patch_target, scanner_ctor):
                                runpy.run_path(str(SCRIPT_PATH), run_name="__main__")

                    self.assertTrue(scanner_ctor.called)
                    self.assertIs(True, scanner_ctor.call_args.kwargs.get("ignore_pkglist"))
                    scanner_instance.start_scan.assert_called_once_with()

    def test_no_whitelist_flag_passed_to_dedup_org_and_merge_excels(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            org_path = Path(temp_dir) / "Result_demo_org.xls"
            org_path.write_bytes(b"placeholder")
            dedup_instance = mock.Mock()
            dedup_instance.run.return_value = str(Path(temp_dir) / "out.xls")
            dedup_ctor = mock.Mock(return_value=dedup_instance)
            with mock.patch.object(sys, "argv", [str(SCRIPT_PATH), "-dedup_org", str(org_path), "-nw"]):
                with mock.patch("modules.mode.DedupOrgExcel.DedupOrgExcel", dedup_ctor):
                    with mock.patch("builtins.print"):
                        with self.assertRaises(SystemExit) as exit_ctx:
                            runpy.run_path(str(SCRIPT_PATH), run_name="__main__")
            self.assertEqual(0, exit_ctx.exception.code)
            dedup_ctor.assert_called_once_with(str(org_path), "shanghai", ignore_pkglist=True)

            merge_instance = mock.Mock()
            merge_ctor = mock.Mock(return_value=merge_instance)
            with mock.patch.object(sys, "argv", [str(SCRIPT_PATH), "-merge", temp_dir, "--no_whitelist"]):
                with mock.patch("modules.mode.MergeExcels.MergeExcels", merge_ctor):
                    with self.assertRaises(SystemExit):
                        runpy.run_path(str(SCRIPT_PATH), run_name="__main__")
            self.assertTrue(merge_ctor.called)
            self.assertIs(True, merge_ctor.call_args.kwargs.get("ignore_pkglist"))
            merge_instance.start_merge.assert_called_once_with()

    def test_all_scanbase_subclasses_accept_and_forward_ignore_pkglist(self):
        from modules.mode.BaseScan import ScanBase
        from modules.mode.DedupOrgExcel import DedupOrgExcel
        from modules.mode.MergeExcels import MergeExcels
        from modules.mode.ScanAeeDaily import ScanAeeDaily
        from modules.mode.ScanAeeFans import ScanAeeFans
        from modules.mode.ScanAeeIndependent import ScanAeeIndependent
        from modules.mode.ScanAeeMTBF import ScanAeeMTBF
        from modules.mode.ScanAeeMedia import ScanAeePlatformMedia
        from modules.mode.ScanAeeOTADaily import ScanAeeOTADaily
        from modules.mode.ScanAeePlatform import ScanAeePlatform
        from modules.mode.ScanAeeTne import ScanAeeTne
        from modules.mode.ScanStuckLogo import ScanStuckLogo
        from modules.mode.ScanTneUpload import ScanTneUpload
        from modules.mode.ScanTneUsic import ScanTneUsic

        instances = [
            ScanAeeTne(23, "SH", -1, ".", ".", True, True, ignore_pkglist=True),
            ScanAeeFans(3, "SH", 1, ".", ".", True, True, ignore_pkglist=True),
            ScanTneUsic(4, "SH", 1, ".", ".", True, True, ignore_pkglist=True),
            ScanStuckLogo(10, "SH", 1, ".", ".", True, True, ignore_pkglist=True),
            ScanAeePlatform(5, "SH", 1, ".", ".", True, True, ignore_pkglist=True),
            ScanAeePlatformMedia(11, "SH", 1, ".", ".", True, True, None, None, "p", "u", False, None, 1, "prj", "bld", "16", "sn1;sn2", "r", "tc", "tk", ignore_pkglist=True),
            ScanAeeDaily(6, "SH", 1, ".", ".", True, True, None, ignore_pkglist=True),
            ScanAeeMTBF(9, "SH", ".", ".", None, "p", "u", False, "prj", "bld", "tc", "tk", ignore_pkglist=True),
            ScanAeeOTADaily(18, "SH", 1, ".", ".", True, True, ignore_pkglist=True),
            ScanAeeIndependent(19, "SH", -1, ".", ".", True, True, ignore_pkglist=True),
            ScanTneUpload(22, "SH", 1, ".", ".", True, True, ignore_pkglist=True),
            DedupOrgExcel("demo_org.xls", ignore_pkglist=True),
            MergeExcels(["."], "shanghai", None, 1, ignore_pkglist=True),
        ]
        for obj in instances:
            self.assertIsInstance(obj, ScanBase)
            self.assertTrue(obj._ignore_pkglist, f"{type(obj).__name__} should set _ignore_pkglist=True")

    def test_load_configs_respects_cli_no_whitelist_over_default_false(self):
        from modules.common.Path import PathManager
        from modules.mode.ScanAeeTne import ScanAeeTne

        scanner_default = ScanAeeTne(23, "SH", -1, ".", ".", True, True, ignore_pkglist=False)
        scanner_nw = ScanAeeTne(23, "SH", -1, ".", ".", True, True, ignore_pkglist=True)

        with mock.patch.object(
            type(PathManager),
            "config_folder",
            new_callable=mock.PropertyMock,
            return_value=str(REPO_ROOT / "config"),
        ):
            scanner_default._load_configs()
            scanner_nw._load_configs()

        self.assertFalse(scanner_default._ignore_pkglist)
        self.assertTrue(scanner_nw._ignore_pkglist)

    def test_pre_analyse_dbg_and_aee_to_data_list_behavior(self):
        from modules.common.Path import PathManager
        from modules.mode.ScanAeeTne import ScanAeeTne

        with tempfile.TemporaryDirectory() as temp_dir:
            exp_dir = Path(temp_dir) / "18954406BB000039" / "aee_exp" / "2026_1126_112012_972_db.20.JE"
            exp_dir.mkdir(parents=True)
            dbg_path = exp_dir / "db.20.JE.dbg"
            dbg_path.write_bytes(b"fake")
            zz_path = exp_dir / "ZZ_INTERNAL"
            zz_path.write_text(
                "Java (JE),27673,39,99,/data/vendor/core/,1,system_app_crash,"
                "com.transsion.document:yozo.Office.WP0,Thu Nov 26 11:20:12 CST 2026 @ 2026-11-26 11:20:12.972245,1,6288145",
                encoding="utf-8",
            )

            with mock.patch.object(
                type(PathManager),
                "tmp_folder",
                new_callable=mock.PropertyMock,
                return_value=str(temp_dir),
            ):
                # 默认开启白名单：非白名单进程被丢弃
                s_with_wl = ScanAeeTne(23, "SH", -1, temp_dir, str(REPO_ROOT), False, True, ignore_pkglist=False)
                s_with_wl._pkglist = ["com.android.settings"]
                stop_1, zz_list_1, discard_1 = s_with_wl._pre_analyse_dbg([str(dbg_path)])
                self.assertFalse(stop_1)
                self.assertEqual([], zz_list_1)
                self.assertEqual(1, len(discard_1))
                self.assertEqual("discard_dbg_version", discard_1[0][1])

                org_1, final_1, _ = s_with_wl._aee_to_data_list(
                    [_DummyAeeResult(str(dbg_path), "com.transsion.document", "com.transsion.document")],
                    replace_path=False,
                )
                self.assertEqual(1, len(org_1))
                self.assertEqual(0, len(final_1))

                # 传入 -nw：关闭白名单校验，保留到待解压和最终结果
                s_no_wl = ScanAeeTne(23, "SH", -1, temp_dir, str(REPO_ROOT), False, True, ignore_pkglist=True)
                s_no_wl._pkglist = ["com.android.settings"]
                stop_2, zz_list_2, discard_2 = s_no_wl._pre_analyse_dbg([str(dbg_path)])
                self.assertFalse(stop_2)
                self.assertEqual([str(dbg_path)], [z.dbg_path for z in zz_list_2])
                self.assertEqual([], discard_2)

                org_2, final_2, _ = s_no_wl._aee_to_data_list(
                    [_DummyAeeResult(str(dbg_path), "com.transsion.document", "com.transsion.document")],
                    replace_path=False,
                )
                self.assertEqual(1, len(org_2))
                self.assertEqual(1, len(final_2))


if __name__ == "__main__":
    unittest.main()
