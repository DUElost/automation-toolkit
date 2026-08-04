import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.dropbox_monitor import second_reduce_one, DropboxMonitor


def test_second_reduce_one_normal():
    assert second_reduce_one("2025-06-12 09:04:02") == "2025-06-12 09:04:01"


def test_second_reduce_one_cross_minute():
    assert second_reduce_one("2025-06-12 09:04:00") == "2025-06-12 09:03:59"


def test_second_reduce_one_invalid_returns_original():
    assert second_reduce_one("06-12 09:04:02") == "06-12 09:04:02"


def test_extract_name_timestamp_process():
    monitor = DropboxMonitor("sn1", "out", "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    detail = ["Process: com.foo", "Build: x", "Timestamp: 2025-06-12 09:04:02"]
    name, ts = monitor._extract_name_timestamp(detail, "2025-06-12 09:04:01")
    assert name == "com.foo"
    assert ts == "2025-06-12 09:04:02"


def test_extract_name_timestamp_cmdline():
    monitor = DropboxMonitor("sn1", "out", "SYSTEM_TOMBSTONE",
                             {"folder": "sys_native_crash", "name_field": "Cmdline"})
    detail = ["Timestamp: 2025-06-12 09:04:02", "Cmdline: /system/bin/foo/bar"]
    name, ts = monitor._extract_name_timestamp(detail, "2025-06-12 09:04:01")
    assert name == "%system%bin%foo%bar"
    assert ts == "2025-06-12 09:04:02"


def test_different_time_within_60s():
    monitor = DropboxMonitor("sn1", "out", "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    logcat = ["--------- beginning of main", "--------- beginning of system",
              "06-12 09:04:02.123 100 200 I tag: msg"]
    assert monitor.different_time(logcat, "2025-06-12 09:04:02") is True


def test_different_time_over_60s():
    monitor = DropboxMonitor("sn1", "out", "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    logcat = ["--------- beginning of main", "--------- beginning of system",
              "06-12 09:05:30.123 100 200 I tag: msg"]
    assert monitor.different_time(logcat, "2025-06-12 09:04:02") is False
