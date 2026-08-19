# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.classify import classify


def test_classify_known_types():
    assert classify("data_app_crash") == "JE"
    assert classify("system_app_crash") == "JE"
    assert classify("data_app_anr") == "ANR"
    assert classify("system_app_native_crash") == "NE"
    assert classify("SYSTEM_TOMBSTONE") == "NE"
    assert classify("FATAL.NE") == "FATAL.NE"
    assert classify("system_server_watchdog") == "SWT"
    assert classify("KERNEL_PANIC") == "KE"
    assert classify("SYSTEM_RESTART") == "SR"


def test_classify_unknown_fallback():
    assert classify("some_unknown_type") == "some_unknown_type"


def test_classify_fatal_ne_family():
    from modules.classify import expclass_family, is_ne_family
    assert expclass_family("FATAL.NE") == "NE"
    assert is_ne_family("FATAL.NE")
    assert is_ne_family("NE")


def test_classify_custom_map():
    m = {"x": "XX"}
    assert classify("x", m) == "XX"
    assert classify("y", m) == "y"
