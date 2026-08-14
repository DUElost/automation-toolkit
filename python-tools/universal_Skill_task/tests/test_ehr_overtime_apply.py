# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_overtime_apply import (
    FORBIDDEN_CLICK_TEXTS,
    category_for_day_kind,
    format_ehr_date,
    format_ehr_time,
    is_forbidden_click_text,
)


def test_category_for_day_kind():
    assert category_for_day_kind("weekday") == "平日加班"
    assert category_for_day_kind("weekend") == "周末加班"


def test_format_ehr_date_dmy():
    assert format_ehr_date(date(2026, 8, 13)) == "13/08/2026"


def test_format_ehr_time():
    assert format_ehr_time(time(19, 0)) == "19:00"
    assert format_ehr_time(time(21, 30)) == "21:30"


def test_forbidden_click_texts_cover_submit_intent():
    required = ["提交", "保存", "送审", "确定"]
    for word in required:
        assert any(word in t for t in FORBIDDEN_CLICK_TEXTS), word


def test_is_forbidden_click_text():
    assert is_forbidden_click_text("提交") is True
    assert is_forbidden_click_text("保存申请") is True
    assert is_forbidden_click_text("加班申请") is False
    assert is_forbidden_click_text("首页") is False
