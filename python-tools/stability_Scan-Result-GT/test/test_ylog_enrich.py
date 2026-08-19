# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.ylog_enrich import enrich_record, _find_ap_segment, _parse_exp_time, _line_in_window
from modules.collect import collect_problems

VERSION = "MyOS16.0.0_Z2581_GEN_AF"
DEVICE = "6R0A57SSAE6000218"


def test_parse_exp_time():
    dt = _parse_exp_time("2026-08-12-092852")
    assert dt.strftime("%Y-%m-%d %H:%M:%S") == "2026-08-12 09:28:52"


def test_find_ap_segment(tmp_path):
    ylog = tmp_path / "ylog"
    ylog.mkdir()
    # 段覆盖 09:28:00 - 09:29:00
    (ylog / "010-0812_092800--0812_093000.ylog").write_bytes(b"")
    seg = _find_ap_segment(str(ylog), _parse_exp_time("2026-08-12-092852"))
    assert seg == "010-0812_092800--0812_093000.ylog"


def test_ylog_fwreboot_enrich_detail_and_caused_by(tmp_path):
    """设备 ylog/fwreboot：按时间窗 enrich Detail，MTK 兜底 CausedBy 可被 SWT Blocked in 替换。"""
    pkg = os.path.join(str(tmp_path), VERSION, DEVICE, "SWT_2026-08-12-092852")
    os.makedirs(pkg, exist_ok=True)
    ylog_fw = os.path.join(str(tmp_path), VERSION, DEVICE, "ylog", "fwreboot", "001")
    os.makedirs(ylog_fw, exist_ok=True)
    with open(os.path.join(ylog_fw, "android.log"), "w", encoding="utf-8") as f:
        f.write("08-12 09:28:40.413  1568  1857 I watchdog: Blocked in monitor "
                "com.android.server.am.UFwActivityManagerServiceImpl "
                "on monitor thread (watchdog.monitor) for 105s\n")

    config = {"ylog_enrich": {"enabled": True, "window_seconds": 120}}
    records = collect_problems(str(tmp_path), config)
    assert len(records) == 1
    r = records[0]
    assert "ylog 设备关联" in r["Detail"]
    assert "Blocked in monitor" in r["Detail"]
    assert r["CausedBy"].startswith("Blocked in monitor")


def test_ylog_enrich_disabled(tmp_path):
    pkg = os.path.join(str(tmp_path), VERSION, DEVICE, "SWT_2026-08-12-092852")
    os.makedirs(pkg, exist_ok=True)
    ylog_fw = os.path.join(str(tmp_path), VERSION, DEVICE, "ylog", "fwreboot", "001")
    os.makedirs(ylog_fw, exist_ok=True)
    with open(os.path.join(ylog_fw, "android.log"), "w", encoding="utf-8") as f:
        f.write("08-12 09:28:40.413 I watchdog: Blocked in monitor foo for 105s\n")
    config = {"ylog_enrich": {"enabled": False}}
    records = collect_problems(str(tmp_path), config)
    assert "ylog 设备关联" not in records[0]["Detail"]


def test_ylog_noise_filtered(tmp_path):
    """充电/温控 watchdog 噪音不应进入 ylog enrich Detail。"""
    pkg = os.path.join(str(tmp_path), VERSION, DEVICE, "SWT_2026-08-12-092852")
    os.makedirs(pkg, exist_ok=True)
    ylog_fw = os.path.join(str(tmp_path), VERSION, DEVICE, "ylog", "fwreboot", "001")
    os.makedirs(ylog_fw, exist_ok=True)
    with open(os.path.join(ylog_fw, "android.log"), "w", encoding="utf-8") as f:
        f.write(
            "08-12 09:28:41.000  1234  5678 I bq2560x_charger_feed_watchdog: feed watchdog\n"
            "08-12 09:28:42.000  1234  5678 I watchdog: Blocked in monitor "
            "com.android.server.am.UFwActivityManagerServiceImpl for 105s\n"
        )
    config = {"ylog_enrich": {"enabled": True, "window_seconds": 120}}
    records = collect_problems(str(tmp_path), config)
    assert "charger_feed_watchdog" not in records[0]["Detail"]
    assert "Blocked in monitor" in records[0]["Detail"]


def test_kernel_bracket_timestamp_in_window():
    anchor = _parse_exp_time("2026-08-12-092852")
    line = "[Wed Aug 12 09:28:47 2026] I watchdog: Blocked in monitor foo"
    assert _line_in_window(line, anchor, 120)
    old = "[Wed Aug 12 09:20:00 2026] I watchdog: Blocked in monitor foo"
    assert not _line_in_window(old, anchor, 120)
