# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from overtime_decision import build_decision, format_decision
from overtime_rules import ExistingOvertime


def test_build_and_format_apply_weekend():
    punches = [time(9, 56), time(12, 2), time(18, 1), time(21, 3)]
    d = build_decision(date(2026, 8, 15), punches, None)  # Saturday
    text = format_decision(d)
    assert d.action.value == "APPLY"
    assert d.proposed_start == time(10, 0)
    assert d.proposed_end == time(20, 0)
    assert d.reason == "待确认"
    assert "target_date=2026-08-15 (weekend)" in text
    assert "action=APPLY" in text
    assert "proposed_start=10:00" in text
    assert "proposed_end=20:00" in text
    assert "notes=" in text


def test_build_skip_already_same():
    punches = [time(21, 3)]
    existing = ExistingOvertime(time(19, 0), time(21, 0))
    d = build_decision(date(2026, 8, 13), punches, existing)  # Wednesday
    assert d.action.value == "SKIP_ALREADY_SAME"
