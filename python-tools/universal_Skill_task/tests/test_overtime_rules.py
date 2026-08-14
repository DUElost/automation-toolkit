# -*- coding: utf-8 -*-
import sys
from datetime import date, datetime, time, timedelta, timezone
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from overtime_rules import (
    Action,
    ExistingOvertime,
    ProposedWindow,
    ceil_half_hour,
    decide_action,
    floor_half_hour,
    is_weekend,
    propose_weekday,
    propose_weekend,
    target_days_last_week,
    target_yesterday,
)

BJ = timezone(timedelta(hours=8))


def test_target_yesterday_beijing():
    now = datetime(2026, 8, 14, 16, 0, tzinfo=BJ)
    assert target_yesterday(now) == date(2026, 8, 13)


def test_target_days_last_week_excludes_today():
    now = datetime(2026, 8, 14, 22, 0, tzinfo=BJ)
    days = target_days_last_week(now)
    assert days == [
        date(2026, 8, 7),
        date(2026, 8, 8),
        date(2026, 8, 9),
        date(2026, 8, 10),
        date(2026, 8, 11),
        date(2026, 8, 12),
        date(2026, 8, 13),
    ]
    assert date(2026, 8, 14) not in days
    assert len(days) == 7


def test_floor_half_hour_examples():
    assert floor_half_hour(time(21, 3)) == time(21, 0)
    assert floor_half_hour(time(20, 58)) == time(20, 30)
    assert floor_half_hour(time(19, 0)) == time(19, 0)
    assert floor_half_hour(time(19, 20)) == time(19, 0)
    assert floor_half_hour(time(19, 30)) == time(19, 30)
    assert floor_half_hour(time(18, 45)) == time(18, 30)
    assert floor_half_hour(time(18, 1)) == time(18, 0)


def test_ceil_half_hour_examples():
    assert ceil_half_hour(time(9, 0)) == time(9, 0)
    assert ceil_half_hour(time(9, 1)) == time(9, 30)
    assert ceil_half_hour(time(9, 30)) == time(9, 30)
    assert ceil_half_hour(time(9, 31)) == time(10, 0)
    assert ceil_half_hour(time(9, 56)) == time(10, 0)


def test_weekday_no_need_before_19():
    assert propose_weekday([time(18, 40)]) is None


def test_weekday_zero_duration_no_need():
    assert propose_weekday([time(19, 0)]) is None
    assert propose_weekday([time(19, 20)]) is None


def test_weekday_apply_examples():
    assert propose_weekday([time(19, 30)]) == ProposedWindow(time(19, 0), time(19, 30))
    assert propose_weekday([time(20, 58)]) == ProposedWindow(time(19, 0), time(20, 30))
    assert propose_weekday([time(21, 3)]) == ProposedWindow(time(19, 0), time(21, 0))


def test_weekend_examples():
    assert propose_weekend([time(9, 56), time(12, 2)]) == ProposedWindow(time(10, 0), time(12, 0))
    assert propose_weekend([time(9, 56), time(12, 2), time(18, 1)]) == ProposedWindow(time(10, 0), time(18, 0))
    assert propose_weekend([time(9, 56), time(12, 2), time(18, 45)]) == ProposedWindow(time(10, 0), time(18, 0))
    assert propose_weekend([time(9, 56), time(12, 2), time(18, 1), time(21, 3)]) == ProposedWindow(
        time(10, 0), time(20, 0)
    )
    assert propose_weekend([time(10, 0), time(21, 0)]) == ProposedWindow(time(10, 0), time(20, 0))
    assert propose_weekend([time(9, 0), time(17, 30)]) == ProposedWindow(time(9, 0), time(17, 30))


def test_is_weekend():
    assert is_weekend(date(2026, 8, 14)) is False  # Friday
    assert is_weekend(date(2026, 8, 15)) is True   # Saturday
    assert is_weekend(date(2026, 8, 16)) is True   # Sunday


def test_decide_action_paths():
    proposed = ProposedWindow(time(19, 0), time(21, 0))
    assert decide_action(None, None) == (Action.SKIP_NO_NEED, None)
    assert decide_action(proposed, None) == (Action.APPLY, proposed)
    same = ExistingOvertime(time(19, 0), time(21, 0))
    assert decide_action(proposed, same) == (Action.SKIP_ALREADY_SAME, proposed)
    diff = ExistingOvertime(time(19, 0), time(20, 30))
    assert decide_action(proposed, diff) == (Action.SKIP_DIFF_MANUAL, proposed)
