# -*- coding: utf-8 -*-
"""Chinese official workday calendar (incl. makeup 补班 / legal holidays)."""

from __future__ import annotations

from datetime import date, datetime, timedelta
from typing import List, Optional, Union

from chinesedays.date_utils import HolidayType, get_holiday_type, is_workday

DateLike = Union[date, datetime, str]


def _as_date(value: DateLike) -> date:
    if isinstance(value, datetime):
        return value.date()
    if isinstance(value, date):
        return value
    text = str(value).strip().replace("/", "-")
    return date.fromisoformat(text[:10])


def is_official_workday(value: DateLike) -> bool:
    """True for normal workdays and makeup workdays (补班); False for weekends/holidays."""
    return bool(is_workday(_as_date(value)))


def workday_kind(value: DateLike) -> str:
    """Return a short label: workday | makeup | holiday | weekend."""
    day = _as_date(value)
    kind = get_holiday_type(day)
    if kind == HolidayType.WORK:
        return "makeup"
    if kind == HolidayType.LEGAL:
        return "holiday"
    if is_workday(day):
        return "workday"
    return "weekend"


def should_deduct_half_hour(value: DateLike) -> bool:
    """Normal/makeup workdays deduct 0.5h; legal holidays and rest weekends do not."""
    return is_official_workday(value)


def shift_label_implies_workday(shift_label: str) -> Optional[bool]:
    """Optional EHR 班值 hint: 休息 → False, 定班/弹性 without 休息 → True, else None."""
    text = (shift_label or "").strip()
    if not text:
        return None
    if "休息" in text:
        return False
    if "定班" in text or "弹性" in text or "班" in text:
        return True
    return None


def week_bounds_containing(today: DateLike) -> tuple[date, date]:
    """Return (Monday, Sunday) of the calendar week that contains today."""
    day = _as_date(today)
    monday = day - timedelta(days=day.weekday())
    sunday = monday + timedelta(days=6)
    return monday, sunday


def is_overtime_meal_eligible(day: DateLike) -> bool:
    """Eligible overtime-meal dates: official workdays (incl. 补班).

    Holidays and rest weekends are out. Friday is excluded by default, except
    when that Friday is itself a workday and the next day is also a workday
    (typically Saturday 补班). Saturday/Sunday makeup days remain eligible.
    """
    d = _as_date(day)
    if not is_official_workday(d):
        return False
    if d.weekday() == 4:  # Friday
        return is_official_workday(d + timedelta(days=1))
    return True


def overtime_meal_dates_for_week(today: Optional[DateLike] = None) -> List[date]:
    """Eligible meal dates Mon–Sun of the week containing today."""
    anchor = _as_date(today) if today is not None else date.today()
    monday, sunday = week_bounds_containing(anchor)
    out: List[date] = []
    cur = monday
    while cur <= sunday:
        if is_overtime_meal_eligible(cur):
            out.append(cur)
        cur += timedelta(days=1)
    return out
