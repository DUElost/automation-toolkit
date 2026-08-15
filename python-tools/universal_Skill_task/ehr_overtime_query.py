# -*- coding: utf-8 -*-
"""Read existing overtime applications from EHR 加班查询 (read-only)."""

from __future__ import annotations

import re
from datetime import date, time
from typing import Dict, Optional, Sequence

from playwright.sync_api import Page

from ehr_attendance import collect_page_text
from ehr_nav import open_overtime_query
from overtime_rules import ExistingOvertime

_TIME_RE = re.compile(r"\b([01]?\d|2[0-3]):([0-5]\d)\b")
_DATE_RE = re.compile(r"(20\d{2})[-/](\d{1,2})[-/](\d{1,2})")
_REAL_ROW_RE = re.compile(
    r"(?P<d1>\d{1,2})/(?P<m1>\d{1,2})/(?P<y1>20\d{2})\s+"
    r"(?P<h1>[01]?\d|2[0-3]):(?P<min1>[0-5]\d)\s+"
    r"(?P<d2>\d{1,2})/(?P<m2>\d{1,2})/(?P<y2>20\d{2})\s+"
    r"(?P<h2>[01]?\d|2[0-3]):(?P<min2>[0-5]\d)"
)


def _existing_from_real_match(match: re.Match) -> tuple[date, ExistingOvertime]:
    start_date = date(int(match["y1"]), int(match["m1"]), int(match["d1"]))
    return start_date, ExistingOvertime(
        time(int(match["h1"]), int(match["min1"])),
        time(int(match["h2"]), int(match["min2"])),
    )


def _existing_from_line(line: str) -> Optional[tuple[date, ExistingOvertime]]:
    real = _REAL_ROW_RE.search(line)
    if real:
        return _existing_from_real_match(real)

    m = _DATE_RE.search(line)
    if not m:
        return None
    y, mo, d = int(m.group(1)), int(m.group(2)), int(m.group(3))
    times = [time(int(h), int(mi)) for h, mi in _TIME_RE.findall(line)]
    if len(times) < 2:
        return None
    return date(y, mo, d), ExistingOvertime(times[0], times[1])


def parse_existing_overtime_map_from_text(
    text: str,
    targets: Sequence[date],
) -> Dict[date, Optional[ExistingOvertime]]:
    """Return existing overtime per target date from one query page dump."""
    target_set = set(targets)
    result: Dict[date, Optional[ExistingOvertime]] = {d: None for d in targets}
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        parsed = _existing_from_line(line)
        if parsed is None:
            continue
        start_date, existing = parsed
        if start_date in target_set:
            result[start_date] = existing
    return result


def parse_existing_overtime_from_text(text: str, target: date) -> Optional[ExistingOvertime]:
    """Return the first matching row's start/end for target date."""
    return parse_existing_overtime_map_from_text(text, [target])[target]


def read_existing_overtime_for_days(
    page: Page,
    targets: Sequence[date],
) -> Dict[date, Optional[ExistingOvertime]]:
    """Open 加班查询 once and parse rows for all target dates."""
    if not targets:
        return {}
    open_overtime_query(page)
    page.wait_for_timeout(3_000)
    return parse_existing_overtime_map_from_text(collect_page_text(page), targets)


def read_existing_overtime(page: Page, target: date) -> Optional[ExistingOvertime]:
    return read_existing_overtime_for_days(page, [target])[target]
