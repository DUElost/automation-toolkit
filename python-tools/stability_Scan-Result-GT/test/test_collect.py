# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.collect import collect_problems, extract_caused_by

VERSION = "MyOS16.0.0_Z2581_GEN_AF"
DEVICE = "6R0A57SSAE6000218"


def _make_package(root, type_dash, ts, detail_lines=None, summary=None, anr_trace=None):
    pkg = os.path.join(root, VERSION, DEVICE, f"{type_dash}_{ts}")
    os.makedirs(pkg, exist_ok=True)
    if detail_lines is not None:
        with open(os.path.join(pkg, "detail.txt"), "w", encoding="utf-8") as f:
            f.write("\n".join(detail_lines) + "\n")
    if summary is not None:
        with open(os.path.join(pkg, f"{type_dash}_{ts}_summary.txt"),
                  "w", encoding="utf-8") as f:
            f.write(summary)
    if anr_trace is not None:
        with open(os.path.join(pkg, "anr_trace.txt"), "w", encoding="utf-8") as f:
            f.write(anr_trace)
    return pkg


def test_collect_je_package(tmp_path):
    detail = [
        "2026-08-05 17:13:10 system_app_crash (text, 1181 bytes)",
        "Process: com.android.systemui",
        "PID: 16220",
        "Timestamp: 2026-08-05 17:13:10.262+0800",
        "",
        "android.app.RemoteServiceException: shell-induced crash",
        "  at android.app.ActivityThread.throwRemoteServiceException(...)",
        "Caused by: android.os.RemoteException",
    ]
    _make_package(str(tmp_path), "system-app-crash", "2026-08-05-171310",
                  detail_lines=detail, summary="类型: system_app_crash  场景: FC\n")

    records = collect_problems(str(tmp_path))
    assert len(records) == 1
    r = records[0]
    assert r["Version"] == VERSION
    assert r["snNum"] == DEVICE
    assert r["ExpTime"] == "2026-08-05-171310"
    assert r["ExpType"] == "system_app_crash"
    assert r["ExpClass"] == "JE"
    assert r["Package"] == "com.android.systemui"
    assert "Caused by" in r["CausedBy"]
    # MTK 识别报告模板
    assert r["Detail"].startswith("Device_id: " + DEVICE)
    assert "解析库版本：scan_result_GT v1.0" in r["Detail"]
    assert "手机版本：['%s']" % VERSION in r["Detail"]
    assert "异常包名：['com.android.systemui" in r["Detail"]
    assert "异常进程：['com.android.systemui']" in r["Detail"]
    assert "pid：['16220']" in r["Detail"]
    assert "Backtrace：" in r["Detail"]
    assert "at android.app.ActivityThread.throwRemoteServiceException" in r["Detail"]


def test_collect_anr_package(tmp_path):
    pkg = _make_package(str(tmp_path), "data-app-anr", "2026-08-04-205510",
                        detail_lines=["2026-08-04 20:55:10 data_app_anr (text, 100 bytes)"],
                        anr_trace='Subject: Half ANR dump\n'
                                  'Cmd line: com.zte.mifavor.launcher\n'
                                  'DALVIK THREADS:\n'
                                  '"main" prio=5 tid=1 Native\n'
                                  '| group="main" sCount=1 flags=1\n'
                                  'at android.os.MessageQueue.nativePollOnce(Native method)\n')
    records = collect_problems(str(tmp_path))
    assert len(records) == 1
    r = records[0]
    assert r["ExpClass"] == "ANR"
    assert r["Package"] == "com.zte.mifavor.launcher"
    # half ANR 去重特征 = main 线程栈顶帧（进程/Subject/pid 为通用格式噪音）
    assert r["CausedBy"] == "at android.os.MessageQueue.nativePollOnce(Native method)"


def test_extract_caused_by_ne(tmp_path):
    pkg = _make_package(str(tmp_path), "SYSTEM-TOMBSTONE", "2026-08-05-171914",
                        detail_lines=["*** ***", "pid: 630",
                                      "signal 11 (SIGSEGV), code 0",
                                      "backtrace:", "      #00 pc 00000000",
                                      "      #01 pc 00000001"])
    caused = extract_caused_by("NE", pkg)
    assert "pc 00000000" in caused  # backtrace 首帧


def test_extract_caused_by_ne_uniview_fallback(tmp_path):
    """uniview NE 包（无 detail.txt）：CausedBy 从 tar 内 exp_detail 兜底提取。"""
    import tarfile
    import io

    pkg = os.path.join(str(tmp_path), VERSION, DEVICE, "native-crash_2026-07-01-121713")
    os.makedirs(pkg, exist_ok=True)
    data = (
        "*** *** ***\n"
        "pid: 2451, tid: 2451, name: com.android.bluetooth\n"
        "signal 11 (SIGSEGV), code 1\n"
        "backtrace:\n"
        "      #00 pc 00000000000dddc8  /apex/com.android.runtime/lib64/bionic/libc.so\n"
    ).encode()
    with tarfile.open(os.path.join(pkg, "001-2026-07-01_12-17-13.tar.gz"), "w:gz") as tf:
        info = tarfile.TarInfo("exp_detail.txt")
        info.size = len(data)
        tf.addfile(info, io.BytesIO(data))
    caused = extract_caused_by("NE", pkg, data.decode().splitlines())
    assert "pc 00000000000dddc8" in caused


def test_extract_caused_by_ne_tombstone_fallback(tmp_path):
    """FATAL.NE 类：exp_main 仅元信息，backtrace 在 tar 内 DATA_TOMBSTONES/tombstone_*。"""
    import tarfile
    import io

    pkg = os.path.join(str(tmp_path), VERSION, DEVICE,
                       "native-crash_2026-08-05-091230")
    os.makedirs(pkg, exist_ok=True)
    with tarfile.open(os.path.join(pkg, "001-2026-08-05_09-12-30.tar.gz"), "w:gz") as tf:
        info = tarfile.TarInfo("001-2026-08-05_09-12-30/exp_main.txt")
        data = b'{"kick_datetime":"2026-08-05_09-12-30.666"}\n'
        info.size = len(data)
        tf.addfile(info, io.BytesIO(data))
        tb = (
            "*** *** ***\n"
            "Timestamp: 2026-08-05 09:12:27.104+0800\n"
            "pid: 1642, tid: 1642, name: system_server\n"
            "signal 11 (SIGSEGV)\n"
            "backtrace:\n"
            "      #00 pc 00000000000ab888  /system/lib64/libutils.so\n"
        ).encode()
        info = tarfile.TarInfo("001-2026-08-05_09-12-30/DATA_TOMBSTONES/tombstone_07")
        info.size = len(tb)
        tf.addfile(info, io.BytesIO(tb))
    from modules.collect import _extract_exp_detail
    lines = _extract_exp_detail(pkg)
    assert any("backtrace:" in l for l in lines)
    caused = extract_caused_by("NE", pkg, lines)
    assert "pc 00000000000ab888" in caused


def test_extract_caused_by_ne_tombstone_file(tmp_path):
    """平台源 tombstone 包（无 detail.txt）：CausedBy 从包内 tombstone.txt 提取。"""
    pkg = _make_package(str(tmp_path), "SYSTEM-TOMBSTONE", "2026-07-01-121751",
                        summary="类型: SYSTEM_TOMBSTONE  场景: FC\n")
    with open(os.path.join(pkg, "tombstone.txt"), "w", encoding="utf-8") as f:
        f.write("*** *** ***\n"
                "pid: 1342, tid: 1342, name: com.android.bluetooth\n"
                "signal 6 (SIGABRT), code -1\n"
                "Abort message: 'stack.cc:149 StartEverything'\n"
                "backtrace:\n"
                "      #00 pc 00000000000729fc  /apex/com.android.runtime/lib64/bionic/libc.so\n")
    caused = extract_caused_by("NE", pkg)
    assert "pc 00000000000729fc" in caused


def test_uniview_type_package(tmp_path):
    _make_package(str(tmp_path), "Jank", "2026-08-04-205511",
                  detail_lines=["focus timeout", "appname: launcher"])
    records = collect_problems(str(tmp_path))
    assert len(records) == 1
    r = records[0]
    assert r["ExpClass"] == "Jank"
    # 参照 MTK：特殊类型 CurProcess/Package 直接填 ExpClass
    assert r["Package"] == "Jank"
    assert r["CurProcess"] == "Jank"


def test_detail_sr_dump_report(tmp_path):
    """SR：Detail 从 tar 内 dump_report.txt 提取重启现场。"""
    import tarfile
    import io
    import json as _json

    pkg = _make_package(str(tmp_path), "Reboot", "2026-05-24-155653",
                        summary="类型: Reboot  场景: SR\n")
    with open(os.path.join(pkg, "unievent_info.json"), "w", encoding="utf-8") as f:
        _json.dump({"kick_datetime": "2026-05-24_15:56:53.146",
                    "reboot_reason": " kernel_crash"}, f)
    with tarfile.open(os.path.join(pkg, "001-2026-05-24_15-56-53.tar.gz"), "w:gz") as tf:
        data = ("-reboot reg is 2080\n"
                "-reset mode is d\n"
                "-bootcause_cmdline is Reboot into panic\n").encode()
        info = tarfile.TarInfo("001-2026-05-24_15-56-53/dump_report.txt")
        info.size = len(data)
        tf.addfile(info, io.BytesIO(data))

    records = collect_problems(str(tmp_path))
    assert len(records) == 1
    r = records[0]
    assert r["ExpClass"] == "SR"
    assert "bootcause_cmdline is Reboot into panic" in r["Detail"]
    # SR 严重重启：CausedBy 走 MTK 兜底（每个问题单独看待，不按 reboot_reason 合并）
    assert r["CausedBy"].startswith("class:[SR]")


def test_sr_caused_by_fallback_not_merged(tmp_path):
    """SR 兜底：两条同 reboot_reason 的 SR 不合并（随机串防误归一类）。"""
    from modules.dedup import dedup
    import json as _json

    for i, ts in (("1", "2026-05-24-155653"), ("2", "2026-05-24-183943")):
        pkg = _make_package(str(tmp_path), "Reboot", ts,
                            summary="类型: Reboot  场景: SR\n")
        with open(os.path.join(pkg, "unievent_info.json"), "w", encoding="utf-8") as f:
            _json.dump({"kick_datetime": "2026-05-24_15:56:53.146",
                        "reboot_reason": " kernel_crash"}, f)
    records = collect_problems(str(tmp_path))
    assert len(records) == 2
    before, after = dedup(records)
    assert len(after) == 2  # 兜底随机串：不合并


def test_swt_caused_by_blocked_in(tmp_path):
    """SWT：CausedBy 取 Blocked in 阻塞详情（Subject 行），而非 Searching for 头行。"""
    pkg = _make_package(str(tmp_path), "system-server-watchdog", "2026-08-04-210108",
                        detail_lines=[
                            "Searching for: system_server_watchdog 2026-08-04 21:01:08",
                            "Subject: Blocked in monitor com.android.server.am.UFwActivityManagerServiceImpl "
                            "on monitor thread (watchdog.monitor) for 105s",
                        ])
    from modules.collect import extract_caused_by
    caused = extract_caused_by("SWT", pkg)
    assert caused.startswith("Blocked in monitor com.android.server.am")


def test_jank_caused_by_fallback(tmp_path):
    """Jank 无根因：CausedBy 走 MTK 兜底（随机串防误合并），Detail 保留事件描述。"""
    _make_package(str(tmp_path), "Jank", "2026-08-04-205511",
                  detail_lines=["focus timeout", "appname: launcher"])
    records = collect_problems(str(tmp_path))
    assert len(records) == 1
    r = records[0]
    assert r["ExpClass"] == "Jank"
    assert r["CausedBy"].startswith("class:[Jank]")


def test_detail_ne_tombstone_key(tmp_path):
    """NE（tombstone 包）：Detail 含 tombstone 头部 + backtrace 段。"""
    pkg = _make_package(str(tmp_path), "SYSTEM-TOMBSTONE", "2026-07-01-121751",
                        summary="类型: SYSTEM_TOMBSTONE  场景: FC\n")
    with open(os.path.join(pkg, "tombstone.txt"), "w", encoding="utf-8") as f:
        f.write("*** *** ***\n"
                "Build fingerprint: 'ZTE/P615F03/P615F03:16/...'\n"
                "pid: 1342, tid: 1342, name: com.android.bluetooth\n"
                "signal 6 (SIGABRT), code -1\n"
                "Abort message: 'stack.cc:149 StartEverything'\n"
                "backtrace:\n"
                "      #00 pc 00000000000729fc  /apex/com.android.runtime/lib64/bionic/libc.so\n"
                "      #01 pc 00000000008a1534  /apex/com.android.art/lib64/libart.so\n"
                "      #02 pc 0000000000016188  /apex/com.android.art/lib64/libbase.so\n")
    records = collect_problems(str(tmp_path))
    assert len(records) == 1
    r = records[0]
    assert "Abort message" in r["Detail"]
    assert "#00 pc 00000000000729fc" in r["Detail"]


def test_rom_ram_extract(tmp_path):
    """Rom_Ram：SYS_FILE_SYSTEMS /data 分区（ROM）+ SYS_PROPERTIES ddrsize（RAM）。"""
    import tarfile
    import io

    pkg = _make_package(str(tmp_path), "native-crash", "2026-08-05-091230",
                        summary="类型: native_crash  场景: NE\n")
    with tarfile.open(os.path.join(pkg, "001-2026-08-05_09-12-30.tar.gz"), "w:gz") as tf:
        fs = ("Filesystem            1K-blocks     Used Available Use% Mounted on\n"
              "/dev/block/dm-51     45582336 12967764  32614572  29% /data\n"
              "/dev/block/mmcblk0p55   63488    44120     19368  70% /metadata\n").encode()
        info = tarfile.TarInfo("001-2026-08-05_09-12-30/SYS_FILE_SYSTEMS")
        info.size = len(fs)
        tf.addfile(info, io.BytesIO(fs))
        prop = ("[ro.boot.ddrsize]: [4096M]\n"
                "[ro.boot.ddr_size]: [4096M]\n").encode()
        info = tarfile.TarInfo("001-2026-08-05_09-12-30/SYS_PROPERTIES")
        info.size = len(prop)
        tf.addfile(info, io.BytesIO(prop))
    from modules.collect import _extract_rom_ram
    assert _extract_rom_ram(pkg) == "64GB+4GB"
