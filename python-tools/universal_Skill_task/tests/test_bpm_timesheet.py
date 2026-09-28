# -*- coding: utf-8 -*-
import sys
from datetime import date
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from bpm_timesheet import (
    TimesheetSkipItem,
    adjusted_work_hours,
    deduction_for_date,
    hours_adjustment_is_valid,
)
from workday_calendar import (
    is_official_workday,
    is_overtime_meal_eligible,
    overtime_meal_dates_for_week,
    shift_label_implies_workday,
    should_deduct_half_hour,
    week_bounds_containing,
    workday_kind,
)


def test_adjusted_work_hours_subtracts_configured_amount():
    assert adjusted_work_hours(4, 0.5) == 3.5
    assert adjusted_work_hours(4, 0.0) == 4.0
    assert adjusted_work_hours(0.5, 0.5) == 0.0


def test_hours_adjustment_is_valid():
    assert hours_adjustment_is_valid(4, 0.5) is True
    assert hours_adjustment_is_valid(0.5, 0.5) is False
    assert hours_adjustment_is_valid(0.5, 0.0) is True


def test_2026_national_day_makeup_and_weekend():
    assert is_official_workday(date(2026, 9, 20)) is True
    assert workday_kind(date(2026, 9, 20)) == "makeup"
    assert should_deduct_half_hour(date(2026, 9, 20)) is True
    assert deduction_for_date(date(2026, 9, 20)) == 0.5

    assert is_official_workday(date(2026, 9, 19)) is False
    assert workday_kind(date(2026, 9, 19)) == "weekend"
    assert deduction_for_date(date(2026, 9, 19)) == 0.0

    assert is_official_workday(date(2026, 10, 1)) is False
    assert workday_kind(date(2026, 10, 1)) == "holiday"
    assert deduction_for_date(date(2026, 10, 1)) == 0.0

    assert is_official_workday(date(2026, 9, 14)) is True
    assert workday_kind(date(2026, 9, 14)) == "workday"
    assert deduction_for_date(date(2026, 9, 14)) == 0.5


def test_ehr_shift_label_hints():
    assert shift_label_implies_workday("定班-南昌-休息(09:00-18:00)") is False
    assert shift_label_implies_workday("定班-南昌-弹性new(08:45-18:15)") is True
    assert shift_label_implies_workday("") is None


def test_timesheet_skip_item_empty_hours_message():
    err = TimesheetSkipItem("工作时数为空")
    assert "工作时数为空" in str(err)


def test_overtime_meal_excludes_friday_and_holiday_monday():
    # 2026-09-21 is Monday; week Mon 21 .. Sun 27.
    monday, sunday = week_bounds_containing(date(2026, 9, 21))
    assert monday == date(2026, 9, 21)
    assert sunday == date(2026, 9, 27)

    assert is_overtime_meal_eligible(date(2026, 9, 21)) is True  # Mon
    assert is_overtime_meal_eligible(date(2026, 9, 24)) is True  # Thu
    assert is_overtime_meal_eligible(date(2026, 9, 25)) is False  # Fri, Sat rest
    assert is_overtime_meal_eligible(date(2026, 9, 26)) is False  # Sat rest
    assert is_overtime_meal_eligible(date(2026, 9, 20)) is True  # Sun makeup 补班
    assert is_overtime_meal_eligible(date(2026, 10, 1)) is False  # legal holiday

    # Friday workday + next-day Saturday makeup → Friday also eligible.
    assert workday_kind(date(2026, 10, 9)) == "workday"
    assert workday_kind(date(2026, 10, 10)) == "makeup"
    assert is_overtime_meal_eligible(date(2026, 10, 9)) is True
    assert is_overtime_meal_eligible(date(2026, 10, 10)) is True

    days = overtime_meal_dates_for_week(date(2026, 9, 21))
    assert days == [
        date(2026, 9, 21),
        date(2026, 9, 22),
        date(2026, 9, 23),
        date(2026, 9, 24),
    ]

    assert overtime_meal_dates_for_week(date(2026, 10, 5)) == [
        date(2026, 10, 8),
        date(2026, 10, 9),
        date(2026, 10, 10),
    ]


def test_should_run_overtime_meal_monday_only():
    from bpm_overtime_meal import should_run_overtime_meal

    assert should_run_overtime_meal(date(2026, 9, 21)) is True
    assert should_run_overtime_meal(date(2026, 9, 22)) is False
