# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_overtime_apply import (
    FORBIDDEN_CLICK_TEXTS,
    OvertimeApplyError,
    SEL_END_TIME,
    SEL_REASON,
    SEL_START_DATE,
    SEL_START_TIME,
    format_ehr_date,
    format_ehr_time,
    is_forbidden_click_text,
    plan_prefill_values,
)
from overtime_decision import build_decision


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


def _apply_decision():
    return build_decision(date(2026, 8, 13), [time(8, 59), time(21, 10)], None)


def test_plan_prefill_values_covers_visible_form_fields():
    values = plan_prefill_values(_apply_decision())
    assert values == {
        SEL_START_DATE: "13/08/2026",
        SEL_START_TIME: "19:00",
        SEL_END_TIME: "21:00",
        SEL_REASON: "待确认",
    }


def test_plan_prefill_values_uses_reason_override():
    values = plan_prefill_values(_apply_decision(), reason="V552AA 稳定性挂测")
    assert values[SEL_REASON] == "V552AA 稳定性挂测"


def test_parse_cli_flags_allow_and_reason():
    from account_config import parse_run_options

    opts = parse_run_options([
        "--reason", "hello",
        "--ALLOW",
        "--no-prompt",
        "--decisions-only",
        "--reason", "rin:专用事由",
    ])
    assert opts.global_reason == "hello"
    assert opts.allow_submit is True
    assert opts.no_prompt is True
    assert opts.decisions_only is True
    assert dict(opts.reason_by_id)["rin"] == "专用事由"
    opts = parse_run_options([])
    assert opts.global_reason is None
    assert opts.allow_submit is False


def test_plan_prefill_values_rejects_non_apply():
    skip = build_decision(date(2026, 8, 13), [], None)
    try:
        plan_prefill_values(skip)
    except OvertimeApplyError:
        return
    raise AssertionError("expected OvertimeApplyError for non-APPLY decision")
