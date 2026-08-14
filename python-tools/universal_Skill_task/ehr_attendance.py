# -*- coding: utf-8 -*-
"""Read punch times from EHR 我的考勤 (read-only)."""

from __future__ import annotations

import re
from datetime import date, time
from typing import List

from playwright.sync_api import Page

from ehr_nav import open_my_attendance

_TIME_RE = re.compile(r"\b([01]?\d|2[0-3]):([0-5]\d)\b")
_DATE_RE = re.compile(r"(20\d{2})[-/](\d{1,2})[-/](\d{1,2})")


def parse_punches_from_text(text: str, target: date) -> List[time]:
    """Extract punch times from the line that contains target date."""
    target_keys = {
        target.isoformat(),
        f"{target.year}/{target.month}/{target.day}",
        f"{target.year}-{target.month:02d}-{target.day:02d}",
        f"{target.year}/{target.month:02d}/{target.day:02d}",
    }
    punches: List[time] = []
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        matched = any(k in line for k in target_keys)
        if not matched:
            m = _DATE_RE.search(line)
            if not m:
                continue
            y, mo, d = int(m.group(1)), int(m.group(2)), int(m.group(3))
            if date(y, mo, d) != target:
                continue
        for hm in _TIME_RE.findall(line):
            punches.append(time(int(hm[0]), int(hm[1])))
    return punches


def read_punches_for_day(page: Page, target: date) -> List[time]:
    open_my_attendance(page)
    page.wait_for_timeout(2_000)
    text = page.inner_text("body")
    return parse_punches_from_text(text, target)
