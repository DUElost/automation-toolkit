# -*- coding: utf-8 -*-
"""Send overtime decision summaries to Feishu custom bot webhooks."""

from __future__ import annotations

import base64
import hashlib
import hmac
import json
import re
import time
import urllib.error
import urllib.request
from datetime import datetime, timezone, timedelta
from typing import List, Optional, Sequence

from account_config import AccountRunResult
from overtime_decision import Decision
from overtime_rules import Action

BEIJING = timezone(timedelta(hours=8))

_WEEKDAY_ZH = ("周一", "周二", "周三", "周四", "周五", "周六", "周日")
_CARD_TITLE = "EHR加班申请自动化"

_ACTION_LABELS = {
    Action.APPLY: "需申请",
    Action.SKIP_NO_NEED: "无需申请",
    Action.SKIP_ALREADY_SAME: "已一致",
    Action.SKIP_DIFF_MANUAL: "需人工",
}

_SECTION_META = {
    Action.APPLY: ("📝", "待提交加班申请"),
    Action.SKIP_DIFF_MANUAL: ("⚠️", "需人工核对"),
    Action.SKIP_ALREADY_SAME: ("✅", "已有相同记录"),
    Action.SKIP_NO_NEED: ("⏭️", "无需申请"),
}

_SECTION_ORDER = (
    Action.APPLY,
    Action.SKIP_DIFF_MANUAL,
    Action.SKIP_ALREADY_SAME,
    Action.SKIP_NO_NEED,
)


class FeishuNotifyError(RuntimeError):
    """Webhook request failed or Feishu API returned an error."""


def _lark_div(content: str) -> dict:
    return {"tag": "div", "text": {"tag": "lark_md", "content": content}}


def _hr() -> dict:
    return {"tag": "hr"}


def _fmt_md_date(iso_date: str) -> str:
    try:
        d = datetime.strptime(iso_date[:10], "%Y-%m-%d").date()
    except ValueError:
        return iso_date
    return f"{d.strftime('%m/%d')}「{_WEEKDAY_ZH[d.weekday()]}」"


def _day_heading(d: Decision) -> str:
    wd = _WEEKDAY_ZH[d.target_date.weekday()]
    return f"{d.target_date.strftime('%m/%d')}「{wd}」"


def _fmt_window(d: Decision) -> str:
    if d.proposed_start is not None and d.proposed_end is not None:
        return f"{d.proposed_start.strftime('%H:%M')}-{d.proposed_end.strftime('%H:%M')}"
    if d.existing is not None:
        return f"{d.existing.start.strftime('%H:%M')}-{d.existing.end.strftime('%H:%M')}"
    return "-"


def _user_note(d: Decision) -> str:
    if d.action == Action.SKIP_NO_NEED:
        if not d.punches:
            return "无有效卡钟"
        return f"下班 {d.punches[-1].strftime('%H:%M')}"
    if d.action == Action.SKIP_DIFF_MANUAL and d.existing is not None:
        ex = d.existing
        return f"已有 {ex.start.strftime('%H:%M')}-{ex.end.strftime('%H:%M')}"
    if not d.notes:
        return "-"
    parts = [p.strip() for p in d.notes.split("; ") if p.strip()]
    parts = [p for p in parts if not any(m in p for m in _INTERNAL_NOTE_MARKERS)]
    return "；".join(parts) if parts else "-"


_INTERNAL_NOTE_MARKERS = ("ALLOW_SUBMIT_OVERTIME=False",)


def _account_display_name(item: AccountRunResult) -> str:
    return item.username or item.account_id


def _decision_line(d: Decision) -> str:
    heading = _day_heading(d)
    if d.action == Action.SKIP_NO_NEED:
        note = _user_note(d)
        return f"{heading} {note}"
    window = _fmt_window(d)
    if d.action == Action.SKIP_DIFF_MANUAL:
        note = _user_note(d)
        return f"{heading} {window} {note}" if note != "-" else f"{heading} {window}"
    if window != "-":
        return f"{heading} {window}"
    return heading


def _format_decisions_text(
    decisions: Sequence[Decision],
    submitted_dates: Sequence[str],
) -> str:
    if not decisions:
        return "📭 无决策数据"
    submitted_set = set(submitted_dates)
    sections: List[str] = []

    # Dates actually submitted in this run (decision may still be APPLY).
    newly = [d for d in decisions if d.target_date.isoformat() in submitted_set]
    if newly:
        lines = ["✅ 本次已提交加班申请："]
        lines.extend(_decision_line(d) for d in newly)
        sections.append("\n".join(lines))

    remaining = [d for d in decisions if d.target_date.isoformat() not in submitted_set]
    for action in _SECTION_ORDER:
        emoji, title = _SECTION_META[action]
        group = [d for d in remaining if d.action == action]
        if not group:
            continue
        lines = [f"{emoji} {title}："]
        lines.extend(_decision_line(d) for d in group)
        sections.append("\n".join(lines))
    return "\n\n".join(sections)


def _fmt_hours(value: float) -> str:
    if float(value).is_integer():
        return str(int(value))
    text = f"{float(value):.2f}".rstrip("0").rstrip(".")
    return text


def _fmt_timesheet_deduction(deduction: float) -> str:
    if deduction and float(deduction) > 0:
        return f"(按工作日扣 {_fmt_hours(deduction)})"
    return "(不扣除)"


def _fmt_timesheet_done_line(row) -> str:
    return (
        f"  {_fmt_md_date(row.date)} {_fmt_hours(row.hours)} "
        f"{_fmt_timesheet_deduction(row.deduction)}"
    )


def _format_timesheet_text(item: AccountRunResult) -> str:
    if item.timesheet_step_skipped:
        return "⏱️ 工时提报：\n⏭️ 本步已跳过（decisions-only）"

    ts = item.timesheet
    if ts is None:
        return "⏱️ 工时提报：\n- 无数据"

    lines = ["⏱️ 工时提报："]
    if ts.skipped_empty:
        lines.append("📭 待办列表为空，已跳过")
        return "\n".join(lines)

    if ts.processed:
        lines.append("✅ 本轮已完成：")
        lines.extend(_fmt_timesheet_done_line(row) for row in ts.processed)
    elif ts.incomplete:
        lines.append("✅ 本轮已完成：无")
    else:
        # Pending list non-empty but nothing processed (e.g. timesheet-max=0).
        lines.append("⏸️ 本轮未处理待办（受次数上限限制）")
        return "\n".join(lines)

    if ts.incomplete:
        lines.append("⚠️ 未完成：")
        for row in ts.incomplete:
            lines.append(f"{_fmt_md_date(row.date)} {row.reason}")
    else:
        lines.append("⚠️ 未完成：无")

    return "\n".join(lines)


def _format_overtime_meal_text(item: AccountRunResult) -> str:
    if item.overtime_meal_step_skipped:
        return "🍱 加班餐：\n⏭️ 本步已跳过（decisions-only）"

    meal = item.overtime_meal
    if meal is None:
        return "🍱 加班餐：\n- 无数据"

    lines = ["🍱 加班餐："]
    if meal.skipped_not_monday:
        lines.append("⏭️ 非周一，已跳过")
        return "\n".join(lines)
    if meal.skipped_no_eligible:
        lines.append("📭 本周无符合条件的就餐日期，已跳过")
        return "\n".join(lines)
    if meal.processed:
        lines.append("✅ 本轮已完成：")
        for row in meal.processed:
            lines.append(f"  {_fmt_md_date(row.date)}")
    else:
        lines.append("✅ 本轮已完成：无")
    return "\n".join(lines)


def _format_account_body(item: AccountRunResult) -> str:
    parts = [_account_header(item)]
    if item.reason:
        parts.append(f"📌 {item.reason}")
    parts.append(_format_timesheet_text(item))
    parts.append(_format_overtime_meal_text(item))
    if item.decisions:
        parts.append("📋 加班申请：")
        parts.append(_format_decisions_text(item.decisions, item.submitted_dates))
    elif not item.run_success:
        parts.append(f"❌ {_brief_error(item.error_message or '执行失败')}")
    return "\n\n".join(parts)


def _format_main_body(results: Sequence[AccountRunResult]) -> str:
    return "\n\n".join(_format_account_body(item) for item in results)


def _brief_error(error: str) -> str:
    text = (error or "执行失败").strip().splitlines()[0].strip()
    text = re.sub(r"\s*url=.*$", "", text, flags=re.IGNORECASE).strip()
    text = re.sub(r"\s*last_error=.*$", "", text, flags=re.IGNORECASE).strip()
    known = (
        ("门户", "BPM 门户打开失败"),
        ("我的考勤", "考勤页读取失败"),
        ("加班查询", "加班查询读取失败"),
        ("工时提报", "工时提报失败"),
        ("工作时数", "工时提报失败"),
        ("加班餐", "加班餐申请失败"),
        ("login", "BPM 登录失败"),
        ("Login", "BPM 登录失败"),
        ("chromewebdata", "浏览器页面加载失败"),
    )
    for needle, brief in known:
        if needle in text:
            return brief
    return text[:60] + ("…" if len(text) > 60 else "")


def _format_trigger_block(triggered_at: datetime) -> str:
    return f"🕐 触发时间：{triggered_at.strftime('%Y-%m-%d %H:%M:%S')}"


def _format_multi_account_summary(results: Sequence[AccountRunResult]) -> str:
    total = len(results)
    success = sum(1 for item in results if item.run_success)
    failed = total - success
    ts_done = sum(len(item.timesheet.processed) for item in results if item.timesheet)
    ts_incomplete = sum(
        len(item.timesheet.incomplete) for item in results if item.timesheet
    )
    meal_done = sum(
        len(item.overtime_meal.processed) for item in results if item.overtime_meal
    )
    lines = [
        "📊 汇总结果：",
        f"✅ Success：{success}/{total}",
        f"❌ Failed: {failed}/{total}",
        f"⏱️ 工时提报 完成 {ts_done} 条 / 未完成 {ts_incomplete} 条",
        f"🍱 加班餐 完成 {meal_done} 天",
    ]
    if failed == 0 and ts_incomplete == 0:
        lines.append("🎉 所有账号均执行成功")
    elif failed == 0 and ts_incomplete > 0:
        lines.append(f"⚠️ 有 {ts_incomplete} 条工时提报未完成，请人工处理")
    else:
        lines.append(f"⚠️ {failed} 个账号执行失败")
    return "\n".join(lines)


def _account_header(item: AccountRunResult) -> str:
    return f"👤 **{_account_display_name(item)}**"


def _card_header_template(results: Sequence[AccountRunResult]) -> str:
    if any(not item.run_success for item in results):
        return "red"
    if any(item.timesheet and item.timesheet.incomplete for item in results):
        return "orange"
    for item in results:
        if any(d.action in (Action.SKIP_DIFF_MANUAL, Action.APPLY) for d in item.decisions):
            return "orange"
    return "green"


def build_account_results_card(
    results: Sequence[AccountRunResult],
    *,
    title: Optional[str] = None,
    triggered_at: Optional[datetime] = None,
) -> dict:
    """Build Feishu JSON 2.0 card: trigger / text body / text summary."""
    when = triggered_at or datetime.now(BEIJING)
    if title is None:
        title = _CARD_TITLE

    elements: List[dict] = [
        _lark_div(_format_trigger_block(when)),
        _hr(),
        _lark_div(_format_main_body(results)),
        _hr(),
        _lark_div(_format_multi_account_summary(results)),
    ]

    return {
        "msg_type": "interactive",
        "card": {
            "schema": "2.0",
            "config": {"wide_screen_mode": True},
            "header": {
                "title": {"tag": "plain_text", "content": title},
                "template": _card_header_template(results),
            },
            "body": {"elements": elements},
        },
    }


def build_summary_card(
    decisions: Sequence[Decision],
    *,
    allow_submit: bool = False,
    submitted_dates: Optional[Sequence[str]] = None,
    reason: Optional[str] = None,
    title: Optional[str] = None,
    run_success: bool = True,
    error_message: Optional[str] = None,
    triggered_at: Optional[datetime] = None,
    account_id: str = "",
    username: str = "",
) -> dict:
    del allow_submit
    result = AccountRunResult(
        account_id=account_id or username,
        username=username,
        reason=reason,
        decisions=list(decisions),
        submitted_dates=list(submitted_dates or ()),
        run_success=run_success,
        error_message=error_message,
    )
    return build_account_results_card([result], title=title, triggered_at=triggered_at)


def build_summary_post(decisions: Sequence[Decision], **kwargs) -> dict:
    return build_summary_card(decisions, **kwargs)


def build_failure_card(error: str, log_path: Optional[str] = None) -> dict:
    del log_path
    result = AccountRunResult(
        account_id="",
        username="",
        run_success=False,
        error_message=error,
    )
    return build_account_results_card([result])


def format_decisions_summary(
    decisions: Sequence[Decision],
    *,
    submitted_dates: Optional[Sequence[str]] = None,
    reason: Optional[str] = None,
    run_success: bool = True,
    error_message: Optional[str] = None,
    triggered_at: Optional[datetime] = None,
    account_id: str = "",
    username: str = "",
    **kwargs,
) -> str:
    del kwargs
    result = AccountRunResult(
        account_id=account_id or username,
        username=username,
        reason=reason,
        decisions=list(decisions),
        submitted_dates=list(submitted_dates or ()),
        run_success=run_success,
        error_message=error_message,
    )
    when = triggered_at or datetime.now(BEIJING)
    return "\n\n".join([
        _format_trigger_block(when),
        _format_main_body([result]),
        _format_multi_account_summary([result]),
    ])


def _sign_payload(payload: dict, secret: str) -> dict:
    timestamp = str(int(time.time()))
    string_to_sign = f"{timestamp}\n{secret}"
    hmac_code = hmac.new(
        string_to_sign.encode("utf-8"),
        digestmod=hashlib.sha256,
    ).digest()
    sign = base64.b64encode(hmac_code).decode("utf-8")
    signed = dict(payload)
    signed["timestamp"] = timestamp
    signed["sign"] = sign
    return signed


def send_webhook(
    webhook_url: str,
    payload: dict,
    *,
    secret: Optional[str] = None,
    timeout: float = 30.0,
) -> dict:
    body = _sign_payload(payload, secret) if secret else payload
    data = json.dumps(body, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(
        webhook_url,
        data=data,
        headers={"Content-Type": "application/json; charset=utf-8"},
        method="POST",
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            raw = resp.read().decode("utf-8")
    except urllib.error.HTTPError as exc:
        detail = exc.read().decode("utf-8", errors="replace")
        raise FeishuNotifyError(f"HTTP {exc.code}: {detail}") from exc
    except urllib.error.URLError as exc:
        raise FeishuNotifyError(f"request failed: {exc}") from exc

    parsed = json.loads(raw)
    if parsed.get("code") not in (0, None):
        raise FeishuNotifyError(
            f"Feishu error code={parsed.get('code')} msg={parsed.get('msg')}"
        )
    return parsed


def notify_account_results(
    webhook_url: str,
    results: Sequence[AccountRunResult],
    *,
    secret: Optional[str] = None,
    triggered_at: Optional[datetime] = None,
) -> dict:
    payload = build_account_results_card(results, triggered_at=triggered_at)
    return send_webhook(webhook_url, payload, secret=secret)


def notify_decisions_summary(
    webhook_url: str,
    decisions: Sequence[Decision],
    *,
    secret: Optional[str] = None,
    allow_submit: bool = False,
    submitted_dates: Optional[List[str]] = None,
    reason: Optional[str] = None,
    run_success: bool = True,
    error_message: Optional[str] = None,
    triggered_at: Optional[datetime] = None,
    account_id: str = "",
    username: str = "",
) -> dict:
    del allow_submit
    result = AccountRunResult(
        account_id=account_id or username,
        username=username,
        reason=reason,
        decisions=list(decisions),
        submitted_dates=list(submitted_dates or ()),
        run_success=run_success,
        error_message=error_message,
    )
    return notify_account_results(
        webhook_url,
        [result],
        secret=secret,
        triggered_at=triggered_at,
    )


def notify_failure(
    webhook_url: str,
    error: str,
    *,
    secret: Optional[str] = None,
    log_path: Optional[str] = None,
) -> dict:
    del log_path
    payload = build_failure_card(error)
    return send_webhook(webhook_url, payload, secret=secret)
