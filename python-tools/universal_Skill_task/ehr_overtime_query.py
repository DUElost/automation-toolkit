# -*- coding: utf-8 -*-
"""Read existing overtime applications from EHR 加班查询 (read-only)."""

from __future__ import annotations

import re
from datetime import date, time
from typing import Optional

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


def parse_existing_overtime_from_text(text: str, target: date) -> Optional[ExistingOvertime]:
    """Return the first matching row's start/end for target date."""
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue

        real = _REAL_ROW_RE.search(line)
        if real:
            start_date = date(int(real["y1"]), int(real["m1"]), int(real["d1"]))
            if start_date == target:
                return ExistingOvertime(
                    time(int(real["h1"]), int(real["min1"])),
                    time(int(real["h2"]), int(real["min2"])),
                )
            continue

        m = _DATE_RE.search(line)
        if not m:
            continue
        y, mo, d = int(m.group(1)), int(m.group(2)), int(m.group(3))
        if date(y, mo, d) != target:
            continue
        times = [time(int(h), int(mi)) for h, mi in _TIME_RE.findall(line)]
        if len(times) >= 2:
            return ExistingOvertime(times[0], times[1])
    return None


def read_existing_overtime(page: Page, target: date) -> Optional[ExistingOvertime]:
    open_overtime_query(page)
    page.wait_for_timeout(3_000)
    return parse_existing_overtime_from_text(collect_page_text(page), target)
