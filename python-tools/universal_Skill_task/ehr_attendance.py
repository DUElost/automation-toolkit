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
_DMY_DATE_RE = re.compile(r"(\d{1,2})/(\d{1,2})/(20\d{2})")


def _line_matches_date(line: str, target: date) -> bool:
    for match in _DATE_RE.finditer(line):
        if date(int(match.group(1)), int(match.group(2)), int(match.group(3))) == target:
            return True
    for match in _DMY_DATE_RE.finditer(line):
        if date(int(match.group(3)), int(match.group(2)), int(match.group(1))) == target:
            return True
    return False


def parse_punches_from_text(text: str, target: date) -> List[time]:
    """Extract punch times from the line that contains target date."""
    punches: List[time] = []
    for raw in text.splitlines():
        line = raw.strip()
        if not line or not _line_matches_date(line, target):
            continue

        # In the real EHR row, 卡钟记录 is the last time-bearing tab cell
        # before 签卡. Earlier cells also contain shift hours and duration.
        if "签卡" in line and "\t" in line:
            fields = line.split("签卡", 1)[0].split("\t")
            for field in reversed(fields):
                times = _TIME_RE.findall(field)
                if times:
                    punches.extend(time(int(h), int(mi)) for h, mi in times)
                    break
            continue

        for hm in _TIME_RE.findall(line):
            punches.append(time(int(hm[0]), int(hm[1])))
    return punches


def collect_page_text(page: Page) -> str:
    """Concatenate body text of the page and every frame (tables often live in iframes)."""
    chunks = []
    for frame in page.frames:
        try:
            chunks.append(frame.inner_text("body"))
        except Exception:
            continue
    return "\n".join(chunks)


def read_punches_for_day(page: Page, target: date) -> List[time]:
    open_my_attendance(page)
    page.wait_for_timeout(3_000)
    return parse_punches_from_text(collect_page_text(page), target)
