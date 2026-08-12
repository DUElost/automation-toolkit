# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.dedup import dedup


def _rec(expclass, package, caused, ts):
    return {
        "Path": f"p/{package}_{ts}",
        "Version": "V1",
        "ExpTime": ts,
        "ExpType": "x",
        "CurProcess": package,
        "Package": package,
        "Detail": "",
        "CausedBy": caused,
        "extraTag": "",
        "sum": 1,
        "snNum": "SN1",
        "ExpClass": expclass,
    }


def test_identical_causedby_merged():
    records = [
        _rec("JE", "com.foo", "Caused by: java.lang.NPE", "2026-08-05-110000"),
        _rec("JE", "com.foo", "Caused by: java.lang.NPE", "2026-08-05-120000"),
    ]
    before, after = dedup(records)
    assert len(before) == 2
    assert len(after) == 1
    assert after[0]["sum"] == 2
    assert after[0]["ExpTime"] == "2026-08-05-110000"  # 最早为代表


def test_different_causedby_kept():
    records = [
        _rec("JE", "com.foo", "Caused by: java.lang.NPE", "2026-08-05-110000"),
        _rec("JE", "com.foo", "Caused by: java.lang.OOM", "2026-08-05-120000"),
    ]
    before, after = dedup(records)
    assert len(after) == 2
    assert all(r["sum"] == 1 for r in after)


def test_similar_causedby_merged():
    records = [
        _rec("JE", "com.camera2", "Caused by: java.lang.IllegalStateException at Camera.open() line 1", "2026-08-05-100000"),
        _rec("JE", "com.camera2", "Caused by: java.lang.IllegalStateException at Camera.open() line 2", "2026-08-05-110000"),
    ]
    before, after = dedup(records)
    assert len(after) == 1
    assert after[0]["sum"] == 2


def test_threshold_config():
    records = [
        _rec("JE", "com.foo", "A B C D E F G H", "2026-08-05-100000"),
        _rec("JE", "com.foo", "A B C D E F G X", "2026-08-05-110000"),
    ]
    _, after_loose = dedup(records, {"dedup": {"similarity_threshold": 0.5}})
    assert len(after_loose) == 1
    _, after_strict = dedup(records, {"dedup": {"similarity_threshold": 0.99}})
    assert len(after_strict) == 2


def test_digit_only_difference_merged():
    """MTK 清洗：仅数字不同（阻塞秒数/行号）视为同根因。"""
    records = [
        _rec("SWT", "system_server",
             "Blocked in monitor com.android.server.am.UFwActivityManagerServiceImpl on monitor thread (watchdog.monitor) for 365s",
             "2026-08-11-141439"),
        _rec("SWT", "system_server",
             "Blocked in monitor com.android.server.am.UFwActivityManagerServiceImpl on monitor thread (watchdog.monitor) for 31s",
             "2026-08-11-141606"),
    ]
    before, after = dedup(records)
    assert len(after) == 1
    assert after[0]["sum"] == 2


def test_swt_searching_line_fallback_not_merged():
    """SWT 仅 Searching 行（无阻塞详情）：清洗后为纯类型文本，走兜底各自保留。"""
    from modules.collect import _fallback_caused_by
    records = [
        _rec("SWT", "system_server", _fallback_caused_by("SWT", "system_server"),
             "2026-08-11-141313"),
        _rec("SWT", "system_server", _fallback_caused_by("SWT", "system_server"),
             "2026-08-12-092852"),
    ]
    before, after = dedup(records)
    assert len(after) == 2
