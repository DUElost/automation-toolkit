# -*- coding: utf-8 -*-
"""Overtime window decision rules (pure logic, no EHR interaction)."""
from __future__ import annotations

from dataclasses import dataclass
from datetime import date, datetime, time, timedelta, timezone
from enum import Enum
from typing import Iterable, List, Optional, Sequence, Tuple

BEIJING = timezone(timedelta(hours=8))

LUNCH_SPAN_NOTE = "12:00-13:00 lunch break excluded from overtime span"


class Action(Enum):
    APPLY = "APPLY"
    SKIP_NO_NEED = "SKIP_NO_NEED"
    SKIP_ALREADY_SAME = "SKIP_ALREADY_SAME"
    SKIP_DIFF_MANUAL = "SKIP_DIFF_MANUAL"


@dataclass(frozen=True)
class ProposedWindow:
    start: time
    end: time


@dataclass(frozen=True)
class ExistingOvertime:
    start: time
    end: time


def target_yesterday(now: Optional[datetime] = None) -> date:
    if now is None:
        now = datetime.now(BEIJING)
    elif now.tzinfo is None:
        now = now.replace(tzinfo=BEIJING)
    else:
        now = now.astimezone(BEIJING)
    return (now - timedelta(days=1)).date()


def target_days_last_week(now: Optional[datetime] = None) -> List[date]:
    """Return the last 7 calendar days before today (Beijing), oldest first.

    Today itself is excluded. Example: 2026-08-14 → 08-07 … 08-13.
    """
    end = target_yesterday(now)
    return [end - timedelta(days=offset) for offset in range(6, -1, -1)]


def is_weekend(day: date) -> bool:
    return day.weekday() >= 5


def floor_half_hour(t: time) -> time:
    minute = 0 if t.minute < 30 else 30
    return time(t.hour, minute)


def ceil_half_hour(t: time) -> time:
    if t.minute == 0:
        return t
    if t.minute <= 30:
        return time(t.hour, 30)
    hour = (t.hour + 1) % 24
    return time(hour, 0)


def propose_weekday(punches: Sequence[time]) -> Optional[ProposedWindow]:
    if not punches:
        return None
    start = time(19, 0)
    max_punch = max(punches)
    if max_punch < start:
        return None
    end = floor_half_hour(max_punch)
    if end <= start:
        return None
    return ProposedWindow(start, end)


def propose_weekend(punches: Sequence[time]) -> Optional[ProposedWindow]:
    if not punches:
        return None
    start = ceil_half_hour(min(punches))
    end = floor_half_hour(max(punches))

    if time(18, 0) <= end < time(19, 0):
        end = time(18, 0)

    if start < time(18, 0) and end > time(19, 0):
        end_dt = datetime.combine(date.min, end) - timedelta(hours=1)
        end = end_dt.time()

    if end <= start:
        return None
    return ProposedWindow(start, end)


def propose_for_day(day: date, punches: Sequence[time]) -> Optional[ProposedWindow]:
    if is_weekend(day):
        return propose_weekend(punches)
    return propose_weekday(punches)


def decide_action(
    proposed: Optional[ProposedWindow],
    existing: Optional[ExistingOvertime],
) -> Tuple[Action, Optional[ProposedWindow]]:
    if proposed is None:
        return Action.SKIP_NO_NEED, None
    if existing is None:
        return Action.APPLY, proposed
    if proposed.start == existing.start and proposed.end == existing.end:
        return Action.SKIP_ALREADY_SAME, proposed
    return Action.SKIP_DIFF_MANUAL, proposed


def spans_lunch(start: time, end: time) -> bool:
    lunch_start = time(12, 0)
    lunch_end = time(13, 0)
    return start < lunch_end and end > lunch_start
