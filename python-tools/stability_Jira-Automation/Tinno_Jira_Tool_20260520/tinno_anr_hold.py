#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Tinno ANR 本地留存：累计出现次数 >5（≥6）才允许新建。"""

from __future__ import annotations

import json
import re
from dataclasses import dataclass
from datetime import datetime
from typing import Any, Dict, List, Optional, Sequence

from tinno_regression_matcher import is_strong_match

DEFAULT_MIN_SUBMIT_COUNT = 6
DEFAULT_EXP_CLASS_KEYWORDS = ("ANR",)


@dataclass(frozen=True)
class AnrHoldDecision:
    hold: bool
    cumulative_count: int
    matched_record_ids: List[int]
    matched_records: List[Dict[str, Any]]
    reason: str


def is_anr_issue(
    *,
    exp_class: Any = "",
    summary: Any = "",
    keywords: Sequence[str] | None = None,
) -> bool:
    tokens = [str(item).strip().upper() for item in (keywords or DEFAULT_EXP_CLASS_KEYWORDS) if str(item).strip()]
    if not tokens:
        tokens = list(DEFAULT_EXP_CLASS_KEYWORDS)
    haystacks = [str(exp_class or "").upper(), str(summary or "").upper()]
    return any(token in text for token in tokens for text in haystacks if text)


def parse_occurrence_count(value: Any) -> int:
    text = str(value or "").strip()
    if not text:
        return 1
    try:
        number = int(float(text))
    except (TypeError, ValueError):
        match = re.search(r"\d+", text)
        number = int(match.group(0)) if match else 1
    return max(number, 1)


def build_match_row_from_hold_record(record: Dict[str, Any]) -> Dict[str, Any]:
    return {
        "affect_project": record.get("affect_project") or "",
        "environment": record.get("environment") or "",
        "exp_class": record.get("exp_class") or "",
        "caused_by": record.get("caused_by") or "",
    }


def find_matching_hold_records(
    current_row: Dict[str, Any],
    hold_records: Sequence[Dict[str, Any]],
    *,
    cause_threshold: float = 0.9,
    exact_fields: Sequence[str] | None = None,
) -> List[Dict[str, Any]]:
    matched: List[Dict[str, Any]] = []
    for record in hold_records:
        history_row = build_match_row_from_hold_record(record)
        if is_strong_match(
            current_row,
            history_row,
            cause_threshold,
            exact_fields=exact_fields or ("affect_project", "environment", "exp_class"),
        ):
            matched.append(dict(record))
    return matched


def evaluate_anr_hold(
    *,
    current_row: Dict[str, Any],
    current_count: int,
    hold_records: Sequence[Dict[str, Any]],
    min_submit_count: int = DEFAULT_MIN_SUBMIT_COUNT,
    cause_threshold: float = 0.9,
    exact_fields: Sequence[str] | None = None,
) -> AnrHoldDecision:
    matched = find_matching_hold_records(
        current_row,
        hold_records,
        cause_threshold=cause_threshold,
        exact_fields=exact_fields,
    )
    held_total = sum(parse_occurrence_count(item.get("count")) for item in matched)
    cumulative = held_total + max(int(current_count or 0), 1)
    threshold = max(int(min_submit_count or DEFAULT_MIN_SUBMIT_COUNT), 1)
    if cumulative < threshold:
        return AnrHoldDecision(
            hold=True,
            cumulative_count=cumulative,
            matched_record_ids=[int(item["id"]) for item in matched if item.get("id") is not None],
            matched_records=matched,
            reason=f"ANR累计{cumulative}<{threshold}，本地留存",
        )
    return AnrHoldDecision(
        hold=False,
        cumulative_count=cumulative,
        matched_record_ids=[int(item["id"]) for item in matched if item.get("id") is not None],
        matched_records=matched,
        reason=f"ANR累计{cumulative}>={threshold}，允许建单",
    )


def apply_total_number_to_summary(summary: Any, total_count: int) -> str:
    text = str(summary or "")
    total = max(int(total_count or 0), 1)
    if re.search(r"\[Total Number\s+\d+\]", text, flags=re.IGNORECASE):
        return re.sub(
            r"\[Total Number\s+\d+\]",
            f"[Total Number {total}]",
            text,
            flags=re.IGNORECASE,
        )
    if text.startswith("[自动化]"):
        return re.sub(r"^(\[自动化\])", rf"\1[Total Number {total}]", text, count=1)
    return f"[Total Number {total}]{text}"


def build_anr_history_comment(
    *,
    cumulative_count: int,
    current_version: str,
    current_count: int,
    matched_records: Sequence[Dict[str, Any]],
) -> str:
    lines = [
        "ANR本地累计达到建单阈值，使用最新一次信息建单。",
        f"*累计次数:* {cumulative_count}",
        f"*本次版本:* {current_version or '-'}",
        f"*本次次数:* {max(int(current_count or 0), 1)}",
        "*历史出现:*",
    ]
    if not matched_records:
        lines.append("- （无本地历史留存，本行次数已达阈值）")
        return "\n".join(lines)

    for index, record in enumerate(matched_records, start=1):
        version = str(record.get("version") or "-").strip() or "-"
        count = parse_occurrence_count(record.get("count"))
        source = str(record.get("source_file") or "-").strip() or "-"
        processed_at = str(record.get("processed_at") or "-").strip() or "-"
        lines.append(f"- #{index} version={version} count={count} at={processed_at} source={source}")
    return "\n".join(lines)


def serialize_occurrence_payload(payload: Dict[str, Any]) -> str:
    return json.dumps(payload, ensure_ascii=False)


def deserialize_occurrence_payload(raw: Any) -> Dict[str, Any]:
    if isinstance(raw, dict):
        return raw
    text = str(raw or "").strip()
    if not text:
        return {}
    try:
        data = json.loads(text)
    except (TypeError, json.JSONDecodeError):
        return {}
    return data if isinstance(data, dict) else {}


def build_hold_record_payload(
    *,
    regression_row: Dict[str, Any],
    count: int,
    source_file: str = "",
    row_number: Any = None,
) -> Dict[str, Any]:
    return {
        "affect_project": str(regression_row.get("affect_project") or "").strip(),
        "environment": str(regression_row.get("environment") or "").strip(),
        "exp_class": str(regression_row.get("exp_class") or "").strip(),
        "caused_by": str(regression_row.get("caused_by") or "").strip(),
        "version": str(regression_row.get("current_version") or regression_row.get("build_version") or "").strip(),
        "count": max(int(count or 0), 1),
        "source_file": str(source_file or "").strip(),
        "row_number": row_number,
        "occurrence_payload": {
            "summary": regression_row.get("summary"),
            "description": regression_row.get("description"),
            "ps": regression_row.get("ps"),
            "versions": regression_row.get("versions"),
            "current_version": regression_row.get("current_version"),
        },
        "processed_at": datetime.now().isoformat(timespec="seconds"),
    }
