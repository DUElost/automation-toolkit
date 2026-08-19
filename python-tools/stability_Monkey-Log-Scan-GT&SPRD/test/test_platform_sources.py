# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.platform_sources import (
    PlatformSources,
    parse_anr_trace,
    parse_tombstone,
    wrap_anr,
    wrap_tombstone,
)
from modules.analyse.summary_builder import SUMMARY_FILENAME

ANR_TRACE = (
    "Subject: Half ANR dump\n"
    "----- dumping pid: 2414 at 10366469\n"
    "proc 2414\n"
    "----- pid 2414 at 2026-08-04 20:55:10.539+0800 -----\n"
    'Cmd line: com.zte.mifavor.launcher\n'
    'DALVIK THREADS (48):\n'
    '"main" prio=5 tid=1 Native\n'
    "  | sysTid=2414 nice=-2\n"
)

TOMBSTONE = (
    "*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***\n"
    "Build fingerprint: 'ZTE/P615F03/P615F03:16/BP2A.250605.031.A3/20260517.132504:userdebug/test-keys'\n"
    "Timestamp: 2026-08-05 09:12:27.104+0800\n"
    "Cmdline: system_server\n"
    "pid: 1642, tid: 1642, name: system_server  >>> system_server <<<\n"
    "signal 11 (SIGSEGV)\n"
)


def _fake_config():
    return {
        "platform": {
            "sprd": {
                "sources": [
                    {"name": "anr_traces", "device_path": "/data/anr",
                     "dest_folder": "data_anr", "wrap": "anr"},
                    {"name": "tombstones", "device_path": "/data/tombstones",
                     "dest_folder": "sys_native_crash", "wrap": "tombstone"},
                    {"name": "ylog_lastkernel", "device_path": "/data/ylog/lastkernel.log",
                     "dest_folder": "ylog", "wrap": "raw"},
                ]
            }
        }
    }


def test_parse_anr_trace():
    pkg, pid, ts, subject = parse_anr_trace(ANR_TRACE)
    assert pkg == "com.zte.mifavor.launcher"
    assert pid == "2414"
    assert ts == "2026-08-04 20:55:10"
    assert subject == "Half ANR dump"


def test_parse_tombstone():
    pkg, pid, ts = parse_tombstone(TOMBSTONE)
    assert pkg == "system_server"
    assert pid == "1642"
    assert ts == "2026-08-05 09:12:27"


def test_wrap_anr_has_dropbox_head():
    wrapped = wrap_anr("com.example.app", "1234", "2026-08-04 12:00:00", "Subject X", "body\n")
    assert "data_app_anr" in wrapped.splitlines()[0]
    assert "Process: com.example.app" in wrapped
    assert "Timestamp: 2026-08-04 12:00:00" in wrapped
    assert wrapped.splitlines()[1] == "=" * 40


class FakeAdb:
    def __init__(self):
        self.pulled = []

    def run_command(self, cmd):
        if 'ls /data/anr' in cmd:
            return ["pid_2414_2026-08-04-20-55-10-507_half"]
        if 'ls /data/tombstones' in cmd:
            return ["tombstone_07"]
        if 'ls /data/ylog/lastkernel.log' in cmd:
            return ["lastkernel.log"]
        if 'cat /data/anr/' in cmd:
            return ANR_TRACE.splitlines()
        if 'cat /data/tombstones/' in cmd:
            return TOMBSTONE.splitlines()
        if 'cat /data/ylog/' in cmd:
            return ["[Wed Aug  5 09:01:19 2026] sprd-wlan: line"]
        return []


def test_scan_pulls_and_dedups(tmp_path):
    adb = FakeAdb()

    ps = PlatformSources("sn1", str(tmp_path), "sprd", _fake_config(), adb=adb)
    n, events = ps.scan()
    assert n == 3
    assert sorted(events) == ["anr_traces", "tombstones", "ylog_lastkernel"]

    anr_dir = os.path.join(str(tmp_path), "sn1",
                           "data-app-anr_2026-08-04-205510")
    files = os.listdir(anr_dir)
    assert "anr_trace.txt" in files
    assert SUMMARY_FILENAME in files
    with open(os.path.join(anr_dir, "anr_trace.txt"), encoding="utf-8") as f:
        content = f.read()
    assert "com.zte.mifavor.launcher" in content
    assert "DALVIK THREADS" in content

    ts_dir = os.path.join(str(tmp_path), "sn1",
                          "SYSTEM-TOMBSTONE_2026-08-05-091227")
    ts_files = os.listdir(ts_dir)
    assert "tombstone.txt" in ts_files
    assert SUMMARY_FILENAME in ts_files

    ylog_dir = os.path.join(str(tmp_path), "sn1", "ylog")
    assert os.listdir(ylog_dir) == ["lastkernel.log"]

    # 二次扫描：指纹相同 -> 0 新增
    n2, events2 = ps.scan()
    assert n2 == 0
    assert events2 == []


def test_scan_platform_pkg_ylog_ref(tmp_path):
    """ANR/tombstone 源建包：ap 分段覆盖时补 ylog.txt 引用（与 dropbox 包一致）。"""
    from modules.analyse.platform_sources import PlatformSources

    class ApAdb:
        def __init__(self):
            self.pulled = []

        def run_command(self, cmd):
            if 'ls /data/anr' in cmd:
                return ["pid_2414_2026-08-04-20-55-10-507_half"]
            if 'ls /data/tombstones' in cmd:
                return []
            if 'cat /data/anr/' in cmd:
                return ANR_TRACE.splitlines()
            if 'ls /data/ylog/ap/' in cmd:
                return ["082-0804_180232_poweron.ylog"]
            return []

        def _run_argv(self, argv, timeout=None):
            import pathlib
            p = pathlib.Path(argv[-1])
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text("ylog data")
            self.pulled.append(p.name)
            return []

    adb = ApAdb()
    ps = PlatformSources("sn1", str(tmp_path), "sprd", _fake_config(), adb=adb)
    ps.scan()
    anr_dir = os.path.join(str(tmp_path), "sn1",
                           "data-app-anr_2026-08-04-205510")
    with open(os.path.join(anr_dir, "ylog.txt"), encoding="utf-8") as f:
        ref = f.read()
    assert "082-0804_180232_poweron.ylog" in ref
    seg = os.path.join(str(tmp_path), "sn1", "ylog", "082-0804_180232_poweron.ylog")
    assert os.path.isfile(seg)


def test_uniview_parse_and_archive(tmp_path):
    """uniview 事件解析 + tar.gz 归档到问题包。"""
    from modules.analyse.platform_sources import PlatformSources

    cfg = {"platform": {"sprd": {"sources": []}}, "events": {}}

    class UvAdb:
        def run_command(self, cmd):
            if "cat " in cmd:
                return [
                    '{"sn":"SN1","event_count":"1"}',
                    '{"event_id":"103000006","event_name":"watchdog"}',
                    '{"kick_datetime":"2026-08-05_17-21-44.946","pid":"15771",'
                    '"proc":"system_server","tag":"system_server_watchdog"}',
                ]
            if "ls " in cmd:
                return ["002-2026-08-05_17-21-44.tar.gz"]
            return []

        def _run_argv(self, argv, timeout=None):
            import pathlib
            p = pathlib.Path(argv[-1])
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text("tar")
            return []

    ps = PlatformSources("SN1", str(tmp_path), "sprd", cfg, adb=UvAdb())
    evs = ps._handle_uniview({"dest_folder": "uniview"},
                             "/data/ylog/uniview_exception/SWT.103000006")
    assert len(evs) == 1
    assert evs[0]["tag"] == "system_server_watchdog"
    target = os.path.join(str(tmp_path), "SN1",
                          "system-server-watchdog_2026-08-05-172144",
                          "002-2026-08-05_17-21-44.tar.gz")
    assert os.path.isfile(target)


def test_uniview_incremental_seen(tmp_path):
    """uniview 增量：seen 后不重复处理。"""
    from modules.analyse.platform_sources import PlatformSources

    cfg = {"platform": {"sprd": {"sources": []}}, "events": {}}

    class UvAdb2:
        def run_command(self, cmd):
            if "cat " in cmd:
                return [
                    '{"sn":"SN1","event_count":"1"}',
                    '{"event_id":"103000006","event_name":"watchdog"}',
                    '{"kick_datetime":"2026-08-05_17-21-44.946","pid":"15771",'
                    '"proc":"system_server","tag":"system_server_watchdog"}',
                ]
            return []

        def _run_argv(self, argv, timeout=None):
            return []

    ps = PlatformSources("SN1", str(tmp_path), "sprd", cfg, adb=UvAdb2())
    evs1 = ps._handle_uniview({"dest_folder": "uniview", "_uniview_seen": 0},
                              "/data/ylog/uniview_exception/SWT.103000006")
    assert len(evs1) == 1
    evs2 = ps._handle_uniview({"dest_folder": "uniview", "_uniview_seen": 1},
                              "/data/ylog/uniview_exception/SWT.103000006")
    assert evs2 == []


def test_uniview_colon_timestamp_match(tmp_path):
    """Reboot 类 kick_datetime 用 : 分隔，tar 名用 -：变体须能命中。"""
    from modules.analyse.platform_sources import PlatformSources

    cfg = {"platform": {"sprd": {"sources": []}}, "events": {}}

    class UvAdb3:
        def run_command(self, cmd):
            if "ls " in cmd:
                return ["001-2026-05-24_15-56-53.tar.gz"]
            return []

        def _run_argv(self, argv, timeout=None):
            import pathlib
            p = pathlib.Path(argv[-1])
            p.parent.mkdir(parents=True, exist_ok=True)
            if not p.exists():
                p.write_text("tar")
            return []

    ps = PlatformSources("SN1", str(tmp_path), "sprd", cfg, adb=UvAdb3())
    ev = {"kick_datetime": "2026-05-24_15:56:53.875", "reboot_reason": "panic"}
    status = ps._archive_uniview_event({"dest_folder": "uniview"},
                                       "/data/ylog/uniview_exception/Reboot.103000002",
                                       ev, ["001-2026-05-24_15-56-53.tar.gz"])
    assert status == "ok"
    target = os.path.join(str(tmp_path), "SN1", "Reboot_2026-05-24-155653",
                          "001-2026-05-24_15-56-53.tar.gz")
    assert os.path.isfile(target)


def test_uniview_none_event_shell_pruned(tmp_path):
    """无 tar 事件且无现场/无 ylog：空壳事件包舍弃。"""
    from modules.analyse.platform_sources import PlatformSources

    cfg = {"platform": {"sprd": {"sources": []}}, "events": {}}

    class NoTarAdb:
        def run_command(self, cmd):
            if "cat " in cmd:
                return [
                    '{"kick_datetime":"2026-07-01_12-17-42.136","pid":"1048",'
                    '"proc":"com.android.bluetooth","tag":"native_crash"}',
                ]
            return []

        def _run_argv(self, argv, timeout=None):
            return []

    ps = PlatformSources("SN1", str(tmp_path), "sprd", cfg, adb=NoTarAdb())
    evs = ps._handle_uniview({"dest_folder": "uniview"},
                             "/data/ylog/uniview_exception/NE.103000003")
    assert len(evs) == 1
    pkg = os.path.join(str(tmp_path), "SN1", "native-crash_2026-07-01-121742")
    assert not os.path.isdir(pkg)


def test_uniview_none_event_kept_with_ap_seg(tmp_path):
    """无 tar 事件但有 ylog 分段覆盖：保留并导出引用。"""
    from modules.analyse.platform_sources import PlatformSources

    cfg = {"platform": {"sprd": {"sources": []}}, "events": {}}

    class ApOnlyAdb:
        def run_command(self, cmd):
            if "cat " in cmd:
                return [
                    '{"kick_datetime":"2026-07-01_12-17-42.136","pid":"1048",'
                    '"proc":"com.android.bluetooth","tag":"native_crash"}',
                ]
            if "ls /data/ylog/ap/" in cmd:
                return ["001-0701_090000--0702_000000.ylog"]
            return []

        def _run_argv(self, argv, timeout=None):
            import pathlib
            p = pathlib.Path(argv[-1])
            p.parent.mkdir(parents=True, exist_ok=True)
            p.write_text("ylog data")
            return []

    ps = PlatformSources("SN1", str(tmp_path), "sprd", cfg, adb=ApOnlyAdb())
    ps._handle_uniview({"dest_folder": "uniview"},
                       "/data/ylog/uniview_exception/NE.103000003")
    pkg = os.path.join(str(tmp_path), "SN1", "native-crash_2026-07-01-121742")
    assert os.path.isdir(pkg)
    assert os.path.isfile(os.path.join(pkg, "ylog.txt"))
    assert os.path.isfile(os.path.join(str(tmp_path), "SN1", "ylog",
                                       "001-0701_090000--0702_000000.ylog"))


def test_uniview_chain_crash_not_stuck(tmp_path):
    """连环 crash：设备只留首个 tar，其余同日事件须 none 推进，末事件 tar 不阻塞。"""
    from modules.analyse.platform_sources import PlatformSources

    cfg = {"platform": {"sprd": {"sources": []}}, "events": {}}

    class ChainAdb:
        def run_command(self, cmd):
            if "cat " in cmd:
                return [
                    '{"kick_datetime":"2026-07-01_12-17-13.803","tag":"native_crash"}',
                    '{"kick_datetime":"2026-07-01_12-17-24.476","tag":"native_crash"}',
                    '{"kick_datetime":"2026-07-01_12-17-33.070","tag":"native_crash"}',
                    '{"kick_datetime":"2026-08-05_17-19-14.538","tag":"native_crash"}',
                ]
            if "ls " in cmd:
                return ["001-2026-07-01_12-17-13.tar.gz",
                        "002-2026-08-05_17-19-14.tar.gz"]
            return []

        def _run_argv(self, argv, timeout=None):
            import pathlib
            p = pathlib.Path(argv[-1])
            p.parent.mkdir(parents=True, exist_ok=True)
            if not p.exists():
                p.write_text("tar")
            return []

    ps = PlatformSources("SN1", str(tmp_path), "sprd", cfg, adb=ChainAdb())
    cfg_src = {"dest_folder": "uniview"}
    evs = ps._handle_uniview(cfg_src, "/data/ylog/uniview_exception/NE.103000003")
    assert len(evs) == 4
    assert cfg_src["_uniview_seen"] == 4
    assert os.path.isfile(os.path.join(
        str(tmp_path), "SN1", "native-crash_2026-07-01-121713",
        "001-2026-07-01_12-17-13.tar.gz"))
    assert os.path.isfile(os.path.join(
        str(tmp_path), "SN1", "native-crash_2026-08-05-171914",
        "002-2026-08-05_17-19-14.tar.gz"))
    # 无 tar 且无现场/无 ylog 的空壳事件包被舍弃
    assert not os.path.isdir(os.path.join(
        str(tmp_path), "SN1", "native-crash_2026-07-01-121724"))


def test_snapshot_meminfo_skips_missing_package(tmp_path):
    """问题包不存在时 meminfo 不新建空壳目录。"""
    class Adb:
        def _run_argv(self, *a, **k):
            return ["MemTotal: 1"]

    ps = PlatformSources("sn1", str(tmp_path), "sprd", _fake_config(), adb=Adb())
    assert ps.snapshot_meminfo("data-app-crash_2026-08-13-011405") is None
    assert not os.path.isdir(os.path.join(
        str(tmp_path), "sn1", "data-app-crash_2026-08-13-011405"))


def test_snapshot_meminfo_writes_existing_package(tmp_path):
    """已建问题包内可写入 meminfo。"""
    class Adb:
        def _run_argv(self, *a, **k):
            return ["MemTotal: 1"]

    pkg = os.path.join(str(tmp_path), "sn1", "data-app-crash_2026-08-13-011405")
    os.makedirs(pkg)
    ps = PlatformSources("sn1", str(tmp_path), "sprd", _fake_config(), adb=Adb())
    dest = ps.snapshot_meminfo("data-app-crash_2026-08-13-011405")
    assert dest and os.path.isfile(dest)
    assert "MemTotal" in open(dest, encoding="utf-8").read()


def test_export_correlated_ap_skips_missing_package(tmp_path):
    """问题包不存在时 ap 关联不新建空壳。"""
    class Adb:
        def run_command(self, *a, **k):
            raise AssertionError("should not list ap when package missing")

        def _run_argv(self, *a, **k):
            raise AssertionError("should not pull")

    ps = PlatformSources("sn1", str(tmp_path), "sprd", _fake_config(), adb=Adb())
    assert ps.export_correlated_ap("2026-08-13 01:14:05",
                                   "data-app-crash_2026-08-13-011405") == []
    assert not os.path.isdir(os.path.join(
        str(tmp_path), "sn1", "data-app-crash_2026-08-13-011405"))


def test_snapshot_bugreport_skips_missing_package(tmp_path):
    """问题包不存在时 bugreport 不新建空壳。"""
    ps = PlatformSources("sn1", str(tmp_path), "sprd", {
        **_fake_config(),
        "events": {"bugreport_cooldown_minutes": 0,
                   "bugreport_cooldown_event_types": [],
                   "scene_map": {}},
    }, adb=object())
    assert ps.snapshot_bugreport("data-app-crash_2026-08-13-011405") is None
    assert not os.path.isdir(os.path.join(
        str(tmp_path), "sn1", "data-app-crash_2026-08-13-011405"))
