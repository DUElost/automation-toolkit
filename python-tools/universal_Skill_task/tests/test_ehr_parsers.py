# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_attendance import looks_like_attendance_page, parse_punches_from_text
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

REAL_ATTENDANCE = """
日期	申诉	班值	上班	下班	时长	卡钟记录
13/08/2026		定班-南昌-弹性new(08:45-18:15)	08:59	21:10	12:11	08:59 21:10	签卡		休假
"""

REAL_OVERTIME = """
平日加班	10/08/2026	19:00	10/08/2026	23:00	4.00	0.00	4.00	原因
"""

# Rest day: 卡钟记录 is empty and the only times sit inside the 班值 label.
REAL_REST_DAY = """
日期	申诉	班值	上班	下班	时长	卡钟记录
09/08/2026		定班-南昌-休息(09:00-18:00)			 		签卡		休假	
"""

# Clock-out only: 卡钟记录 holds a single punch.
REAL_SINGLE_PUNCH = """
26/07/2026		定班-南昌-休息(09:00-18:00)		20:06	 	20:06 	签卡		休假	
"""


def test_parse_punches_for_day():
    punches = parse_punches_from_text(SAMPLE_ATTENDANCE, date(2026, 8, 13))
    assert punches == [time(9, 56), time(12, 2), time(18, 1), time(21, 3)]


def test_parse_real_attendance_card_clock_record_only():
    punches = parse_punches_from_text(REAL_ATTENDANCE, date(2026, 8, 13))
    assert punches == [time(8, 59), time(21, 10)]


def test_rest_day_shift_label_is_not_a_punch():
    assert parse_punches_from_text(REAL_REST_DAY, date(2026, 8, 9)) == []


def test_single_punch_row_reads_card_clock_only():
    assert parse_punches_from_text(REAL_SINGLE_PUNCH, date(2026, 7, 26)) == [time(20, 6)]


def test_looks_like_attendance_page_rejects_blank_render():
    assert looks_like_attendance_page(REAL_ATTENDANCE) is True
    assert looks_like_attendance_page("") is False
    assert looks_like_attendance_page("首页 我的考勤 加班查询") is False


def test_parse_existing_overtime():
    existing = parse_existing_overtime_from_text(SAMPLE_OVERTIME, date(2026, 8, 13))
    assert existing is not None
    assert existing.start == time(10, 0)
    assert existing.end == time(20, 0)


def test_parse_real_overtime_day_month_year():
    existing = parse_existing_overtime_from_text(REAL_OVERTIME, date(2026, 8, 10))
    assert existing is not None
    assert existing.start == time(19, 0)
    assert existing.end == time(23, 0)
