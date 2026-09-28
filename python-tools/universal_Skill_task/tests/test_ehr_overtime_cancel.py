# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_overtime_cancel import (
    OvertimeCancelMatch,
    OvertimeCancelTarget,
    find_matching_overtime,
    parse_del_href,
    parse_feedback_href,
)


def test_parse_feedback_and_del_href():
    day, start, oid = parse_feedback_href(
        "javascript:feedback('20/09/2026','09:00','341322026093116')"
    )
    assert day == date(2026, 9, 20)
    assert start == time(9, 0)
    assert oid == "341322026093116"
    emp, oid2, flag = parse_del_href("javascript:del('809529','341322026093116','Y')")
    assert emp == "809529"
    assert oid2 == oid
    assert flag == "Y"


def test_find_matching_filters_start_and_end():
    rows = [
        OvertimeCancelMatch(
            target_date=date(2026, 9, 20),
            start=time(9, 0),
            end=time(20, 0),
            emp_no="809529",
            ot_id="1",
            revoke_href="javascript:del('809529','1','Y')",
        ),
        OvertimeCancelMatch(
            target_date=date(2026, 9, 20),
            start=time(19, 0),
            end=time(21, 0),
            emp_no="809529",
            ot_id="2",
            revoke_href="javascript:del('809529','2','Y')",
        ),
    ]
    hits = find_matching_overtime(
        rows,
        OvertimeCancelTarget(date(2026, 9, 20), time(9, 0), time(20, 0)),
    )
    assert [h.ot_id for h in hits] == ["1"]
