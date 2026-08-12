# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.dropbox_monitor import DropboxMonitor


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
