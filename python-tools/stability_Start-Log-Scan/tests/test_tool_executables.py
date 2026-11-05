# -*- coding: utf-8 -*-
"""外部二进制可执行位与启动自检（v2.1.1 §2b）。

v2.1.0 的三个 Linux ELF 在 git 中为 100644，从 tag 导出后不可执行，
aee_extract 每次 Permission denied，报表退化为 failed-dbg 兜底行。
"""
import json
import os
import runpy
import shutil
import stat
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path
from unittest import mock

PROJECT_ROOT = Path(__file__).resolve().parents[1]
SCRIPT_PATH = PROJECT_ROOT / "start_log_scan.py"
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

LINUX_BINARIES = [
    "tools/aee_extract/aee_extract",
    "tools/decompress/linux/tne_decompress",
    "tools/expdb/p-new-db",
]


def _in_git_checkout():
    try:
        out = subprocess.run(["git", "-C", str(PROJECT_ROOT), "rev-parse", "--is-inside-work-tree"],
                             stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
        return out.returncode == 0 and out.stdout.strip() == b"true"
    except OSError:
        return False


@unittest.skipUnless(_in_git_checkout(), "需要 git 工作区")
class GitModeTest(unittest.TestCase):
    def test_linux_binaries_are_100755_in_git(self):
        out = subprocess.check_output(["git", "-C", str(PROJECT_ROOT), "ls-files", "-s", "--"] + LINUX_BINARIES)
        modes = {}
        for line in out.decode("utf-8").splitlines():
            meta, path = line.split("\t", 1)
            modes[path] = meta.split(" ")[0]
        self.assertEqual(3, len(modes), modes)
        for path, mode in modes.items():
            self.assertEqual("100755", mode, path)


class CheckExecutablesTest(unittest.TestCase):
    def test_missing_and_not_executable(self):
        from modules.common.ToolCheck import REASON_MISSING, REASON_NOT_EXECUTABLE, check_executables
        with tempfile.TemporaryDirectory() as d:
            ok = Path(d) / "ok"
            ok.write_bytes(b"#!/bin/sh\n")
            ok.chmod(0o755)
            noexec = Path(d) / "noexec"
            noexec.write_bytes(b"")
            noexec.chmod(0o664)
            missing = Path(d) / "missing"
            problems = check_executables([str(ok), str(noexec), str(missing)])
        self.assertEqual([(str(noexec), REASON_NOT_EXECUTABLE), (str(missing), REASON_MISSING)], problems)


@unittest.skipUnless(sys.platform.startswith("linux"), "Linux 自检")
class InitEnvSelfCheckTest(unittest.TestCase):
    def _tools(self, d, mode_by_name):
        root = Path(d) / "tools"
        for rel in LINUX_BINARIES:
            name = Path(rel).name
            if mode_by_name.get(name) == "missing":
                continue
            target = root / Path(rel).relative_to("tools")
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(b"#!/bin/sh\n")
            target.chmod(mode_by_name.get(name, 0o755))
        return str(root)

    def _init_env(self, tools_folder):
        from modules.common.GlobalAttrs import EXIT_CODE_INVALID_ENV
        from modules.common.Path import PathManager
        from modules.mode.DedupOrgExcel import DedupOrgExcel
        with tempfile.TemporaryDirectory() as cfg:
            scanner = DedupOrgExcel(str(Path(cfg) / "x_org.xls"), "shanghai", config_dir=cfg)
        with mock.patch.object(type(PathManager), "tools_folder", new_callable=mock.PropertyMock,
                               return_value=tools_folder):
            try:
                scanner._init_env()
            except SystemExit as exc:
                return exc.code, EXIT_CODE_INVALID_ENV
        return None, EXIT_CODE_INVALID_ENV

    def test_not_executable_exits_non_zero(self):
        with tempfile.TemporaryDirectory() as d:
            code, invalid = self._init_env(self._tools(d, {"aee_extract": 0o664}))
        self.assertEqual(invalid, code)
        self.assertNotEqual(0, code)

    def test_missing_exits_non_zero(self):
        for name in ("aee_extract", "tne_decompress", "p-new-db"):
            with self.subTest(missing=name), tempfile.TemporaryDirectory() as d:
                code, invalid = self._init_env(self._tools(d, {name: "missing"}))
                self.assertEqual(invalid, code)

    def test_all_executable_passes_self_check(self):
        with tempfile.TemporaryDirectory() as d:
            code, invalid = self._init_env(self._tools(d, {}))
        self.assertNotEqual(invalid, code)


class StartScanSystemExitTest(unittest.TestCase):
    def test_env_exit_code_not_swallowed(self):
        from modules.common.GlobalAttrs import EXIT_CODE_INVALID_ENV
        scanner = mock.Mock()
        scanner.start_scan.side_effect = SystemExit(EXIT_CODE_INVALID_ENV)
        with tempfile.TemporaryDirectory() as d:
            argv = [str(SCRIPT_PATH), "-m", "1", "-d_abs", d, "-p", "SH", "-s"]
            with mock.patch.object(sys, "argv", argv), \
                    mock.patch("modules.mode.ScanAeeTne.ScanAeeTne", mock.Mock(return_value=scanner)):
                with self.assertRaises(SystemExit) as ctx:
                    runpy.run_path(str(SCRIPT_PATH), run_name="__main__")
        self.assertEqual(EXIT_CODE_INVALID_ENV, ctx.exception.code)


@unittest.skipUnless(shutil.which("git"), "需要 git")
class MakeReleaseModeTest(unittest.TestCase):
    def test_release_json_records_modes_and_export_keeps_exec_bit(self):
        from modules.common.Version import VERSION
        version = VERSION.lstrip("vV").split("_")[0]
        with tempfile.TemporaryDirectory() as d:
            repo = Path(d) / "repo"
            tool = repo / "tool"
            (tool / "release").mkdir(parents=True)
            (tool / "modules" / "common").mkdir(parents=True)
            shutil.copy(PROJECT_ROOT / "release" / "make_release.py", tool / "release" / "make_release.py")
            shutil.copy(PROJECT_ROOT / "modules" / "common" / "Version.py", tool / "modules" / "common" / "Version.py")
            (tool / "modules" / "common" / "__init__.py").write_text("", encoding="utf-8")
            (tool / "bin_tool").write_bytes(b"\x7fELF")
            (tool / "bin_tool").chmod(0o755)
            (tool / "plain.txt").write_text("x", encoding="utf-8")
            (repo / ".gitignore").write_text("__pycache__/\n", encoding="utf-8")
            git = ["git", "-C", str(repo), "-c", "user.name=t", "-c", "user.email=t@t"]
            subprocess.check_call(git[:3] + ["init", "-q"])
            subprocess.check_call(git + ["add", "-A"])
            subprocess.check_call(git + ["commit", "-qm", "init"])
            tag = "start-log-scan/v" + version
            subprocess.check_call(git + ["tag", tag])
            out_dir = Path(d) / "dist"
            subprocess.check_call([sys.executable, str(tool / "release" / "make_release.py"),
                                   "--tag", tag, "--out", str(out_dir)], stdout=subprocess.DEVNULL)
            dest = out_dir / version
            release = json.loads((dest / "release.json").read_text(encoding="utf-8"))
            self.assertEqual("100755", release["files_mode"]["bin_tool"])
            self.assertEqual("100644", release["files_mode"]["plain.txt"])
            self.assertIn("bin_tool", release["executables"])
            self.assertNotIn("plain.txt", release["executables"])
            self.assertEqual(set(release["files_sha256"]), set(release["files_mode"]))
            self.assertTrue(os.stat(dest / "bin_tool").st_mode & stat.S_IXUSR)
            self.assertFalse(os.stat(dest / "plain.txt").st_mode & stat.S_IXUSR)


if __name__ == "__main__":
    unittest.main()
