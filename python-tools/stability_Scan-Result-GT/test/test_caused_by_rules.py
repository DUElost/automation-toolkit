# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.caused_by_rules import (
    merge_rules,
    set_active_rules,
    ylog_patterns_for,
)


def test_merge_rules_ke_patterns():
    rules = merge_rules({"KE": {"patterns": ["custom panic line"]}})
    assert rules["KE"]["patterns"] == ["custom panic line"]
    assert "killed by signal" not in rules["KE"]["patterns"]
    assert rules["JE"]["am_crash_sources"] == ["SYS_ANDROID_LOG", "events.log"]


def test_ylog_patterns_fatal_ne():
    set_active_rules()
    pats = ylog_patterns_for("FATAL.NE")
    assert "Fatal signal" in pats
