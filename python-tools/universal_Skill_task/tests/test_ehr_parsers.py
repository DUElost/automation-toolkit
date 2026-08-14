# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_attendance import parse_punches_from_text
from ehr_overtime_query import parse_existing_overtime_from_text


SAMPLE_ATTENDANCE = """
日期 上班 下班 其它
2026-08-12 09:01 18:20
2026-08-13 09:56 12:02 18:01 21:03
"""


SAMPLE_OVERTIME = """
申请日期 开始 结束 状态
2026-08-14 19:00 21:00 已通过
2026-08-13 10:00 20:00 审批中
"""


def test_parse_punches_for_day():
    punches = parse_punches_from_text(SAMPLE_ATTENDANCE, date(2026, 8, 13))
    assert punches == [time(9, 56), time(12, 2), time(18, 1), time(21, 3)]


def test_parse_existing_overtime():
    existing = parse_existing_overtime_from_text(SAMPLE_OVERTIME, date(2026, 8, 13))
    assert existing is not None
    assert existing.start == time(10, 0)
    assert existing.end == time(20, 0)
