# -*- coding: utf-8 -*-
import sys
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from bpm_overtime_meal import should_run_overtime_meal
from meal_state import has_meal_success, mark_meal_success, week_iso_key


def test_week_iso_key():
    assert week_iso_key(date(2026, 9, 21)) == "2026-W39"
    assert week_iso_key(date(2026, 9, 22)) == "2026-W39"


def test_mark_and_has_meal_success(tmp_path):
    day = date(2026, 9, 21)
    assert has_meal_success("account2", day, state_dir=tmp_path) is False
    path = mark_meal_success(
        "account2",
        day,
        ["2026-09-21", "2026-09-22"],
        state_dir=tmp_path,
    )
    assert path.is_file()
    assert has_meal_success("account2", day, state_dir=tmp_path) is True
    # Same week Tuesday still sees the marker.
    assert has_meal_success("account2", date(2026, 9, 22), state_dir=tmp_path) is True
    # Other account untouched.
    assert has_meal_success("account1", day, state_dir=tmp_path) is False


def test_should_run_respects_week_marker(tmp_path):
    monday = date(2026, 9, 21)
    tuesday = date(2026, 9, 22)
    assert should_run_overtime_meal(
        tuesday, account_id="account2", state_dir=tmp_path
    ) is True
    mark_meal_success("account2", monday, ["2026-09-21"], state_dir=tmp_path)
    assert should_run_overtime_meal(
        tuesday, account_id="account2", state_dir=tmp_path
    ) is False
    assert should_run_overtime_meal(
        monday, account_id="account2", state_dir=tmp_path
    ) is False
