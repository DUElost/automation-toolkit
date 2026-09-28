# -*- coding: utf-8 -*-
"""Tests for Feishu overtime summary notifications."""

import sys
from datetime import date, time
from pathlib import Path
from unittest.mock import patch

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from account_config import AccountRunResult
from feishu_notify import (
    _brief_error,
    build_account_results_card,
    build_summary_post,
    format_decisions_summary,
    send_webhook,
)
from overtime_decision import build_decision
from overtime_rules import ExistingOvertime


def test_format_decisions_summary_user_layout():
    decisions = [
        build_decision(
            date(2026, 8, 8),
            [time(14, 31), time(23, 29)],
            ExistingOvertime(time(15, 0), time(22, 0)),
        ),
        build_decision(date(2026, 8, 9), [], None),
    ]
    text = format_decisions_summary(decisions, reason="稳定性挂测")
    assert "🕐 触发时间：" in text
    assert "📊 汇总结果：" in text
    assert "✅ Success：1/1" in text
    assert "⏱️ 工时提报：" in text
    assert "账号数" not in text
    assert "ALLOW_SUBMIT_OVERTIME" not in text


def test_build_account_results_card_has_text_body_and_summary():
    from bpm_timesheet import (
        TimesheetIncompleteItem,
        TimesheetProcessedItem,
        TimesheetRunResult,
    )

    d1 = build_decision(
        date(2026, 8, 8),
        [time(14, 31), time(23, 29)],
        ExistingOvertime(time(15, 0), time(22, 0)),
    )
    d2 = build_decision(date(2026, 8, 9), [], None)
    results = [
        AccountRunResult(
            account_id="rin",
            username="dai.lv@tinno.com",
            reason="项目A",
            decisions=[d1, d2],
            timesheet=TimesheetRunResult(
                processed=[
                    TimesheetProcessedItem(date="2026-08-08", hours=7.5, deduction=0.5),
                    TimesheetProcessedItem(date="2026-08-09", hours=4.0, deduction=0.0),
                ],
                incomplete=[
                    TimesheetIncompleteItem(
                        date="2026-08-10",
                        reason="工作时数为空",
                    )
                ],
            ),
            run_success=True,
        ),
        AccountRunResult(
            account_id="zhangsan",
            username="zhang.san@tinno.com",
            reason="项目B",
            decisions=[d1],
            submitted_dates=["2026-08-08"],
            timesheet=TimesheetRunResult(skipped_empty=True),
            run_success=True,
        ),
    ]
    payload = build_account_results_card(results)
    card = payload["card"]
    assert card["schema"] == "2.0"
    assert card["header"]["template"] == "orange"
    elements = card["body"]["elements"]
    assert not any(el.get("tag") == "table" for el in elements)
    assert sum(1 for el in elements if el.get("tag") == "hr") == 2
    divs = [el["text"]["content"] for el in elements if el.get("tag") == "div"]
    body = divs[1]
    assert "👤 **dai.lv@tinno.com**" in body
    assert "👤 **zhang.san@tinno.com**" in body
    assert "rin" not in body
    assert "📌 项目A" in body
    assert "⏱️ 工时提报：" in body
    assert "✅ 本轮已完成：" in body
    assert "  08/08「周六」 7.5 (按工作日扣 0.5)" in body
    assert "  08/09「周日」 4 (不扣除)" in body
    assert "⚠️ 未完成：" in body
    assert "08/10「周一」 工作时数为空" in body
    assert "待办列表为空，已跳过" in body
    assert "🍱 加班餐：" in body
    assert "📋 加班申请：" in body
    assert "✅ 本次已提交加班申请：" in body
    assert "✅ 已有相同记录：" in body
    assert "08/08「周六」" in body
    assert "⏭️ 无需申请" in body
    assert "\u3000" not in body
    summary = divs[2]
    assert "✅ Success：2/2" in summary
    assert "⏱️ 工时提报 完成 2 条 / 未完成 1 条" in summary
    assert "🍱 加班餐 完成" in summary
    assert "👤" not in summary
    assert "有 1 条工时提报未完成" in summary


def test_build_summary_post_structure():
    d = build_decision(date(2026, 8, 13), [time(21, 3)], None)
    payload = build_summary_post([d], submitted_dates=["2026-08-13"])
    card = payload["card"]
    assert card["header"]["title"]["content"] == "EHR加班申请自动化"
    elements = card["body"]["elements"]
    assert not any(el.get("tag") == "table" for el in elements)
    flat = "\n".join(el["text"]["content"] for el in elements if el.get("tag") == "div")
    assert "08/13「周四」" in flat


def test_brief_error_shortens_long_message():
    assert _brief_error("Cannot click 加班查询. last_error=timeout") == "加班查询读取失败"


def test_send_webhook_adds_sign_when_secret():
    captured = {}

    class FakeResp:
        def __enter__(self):
            return self

        def __exit__(self, *args):
            return False

        def read(self):
            return b'{"code":0,"msg":"success"}'

    def fake_urlopen(req, timeout=30):
        captured["data"] = req.data.decode("utf-8")
        return FakeResp()

    with patch("feishu_notify.urllib.request.urlopen", fake_urlopen):
        send_webhook(
            "https://example.com/hook",
            {"msg_type": "text", "content": {"text": "hi"}},
            secret="s3cr3t",
        )

    body = __import__("json").loads(captured["data"])
    assert "timestamp" in body
    assert "sign" in body
