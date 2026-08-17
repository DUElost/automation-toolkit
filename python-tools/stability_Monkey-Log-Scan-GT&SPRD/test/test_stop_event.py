# -*- coding: utf-8 -*-
"""Ctrl+C 停止标志：可中断等待。"""
import os
import sys
import threading
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from scan_log_gt import ScanLogGT


def _scanner():
    return ScanLogGT(
        config={"dropbox": {"types": {"data_app_crash": {}}},
                "general": {"polling_interval_seconds": 1}},
        output_root="/tmp",
        platform="none",
    )


def test_wait_returns_false_before_stop():
    s = _scanner()
    t0 = time.time()
    assert s._wait(0.2) is False
    assert time.time() - t0 >= 0.15


def test_wait_returns_true_after_stop():
    s = _scanner()
    s.request_stop()
    t0 = time.time()
    assert s._wait(5) is True
    assert time.time() - t0 < 1.0


def test_stop_unblocks_waiting_thread():
    s = _scanner()
    done = threading.Event()

    def worker():
        s._wait(30)
        done.set()

    t = threading.Thread(target=worker)
    t.start()
    time.sleep(0.1)
    s.request_stop()
    assert done.wait(2)
    t.join(timeout=2)
