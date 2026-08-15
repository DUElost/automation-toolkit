# -*- coding: utf-8 -*-
"""Read punch times from EHR 我的考勤 (read-only)."""

from __future__ import annotations

import re
from datetime import date, time
from typing import Dict, List, Sequence

from playwright.sync_api import Page

from ehr_nav import open_my_attendance

class AttendanceReadError(RuntimeError):
    """Attendance page did not render, so punches cannot be trusted."""


_TIME_RE = re.compile(r"\b([01]?\d|2[0-3]):([0-5]\d)\b")
_PURE_TIMES_RE = re.compile(r"^(?:[01]?\d|2[0-3]):[0-5]\d(?:\s+(?:[01]?\d|2[0-3]):[0-5]\d)*$")
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


def _extract_punches_from_line(line: str) -> List[time]:
    if "签卡" in line and "\t" in line:
        fields = line.split("签卡", 1)[0].split("\t")
        for field in reversed(fields):
            if not _PURE_TIMES_RE.match(field.strip()):
                continue
            return [time(int(h), int(mi)) for h, mi in _TIME_RE.findall(field)]
        return []

    return [time(int(hm[0]), int(hm[1])) for hm in _TIME_RE.findall(line)]


def parse_punches_map_from_text(text: str, targets: Sequence[date]) -> Dict[date, List[time]]:
    """Extract punch times for each target date from one attendance page dump."""
    target_set = frozenset(targets)
    result: Dict[date, List[time]] = {d: [] for d in targets}
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        matched = [d for d in target_set if _line_matches_date(line, d)]
        if not matched:
            continue
        punches = _extract_punches_from_line(line)
        for d in matched:
            result[d] = punches
    return result


def parse_punches_from_text(text: str, target: date) -> List[time]:
    """Extract punch times from the line that contains target date."""
    return parse_punches_map_from_text(text, [target])[target]


def looks_like_attendance_page(text: str) -> bool:
    """True when the attendance table actually rendered.

    A blank EHR render also yields zero punches, which must not be read as
    "no punches that day".
    """
    return bool(_DMY_DATE_RE.search(text) or _DATE_RE.search(text))


def collect_page_text(page: Page) -> str:
    """Concatenate body text of the page and every frame (tables often live in iframes)."""
    chunks = []
    for frame in page.frames:
        try:
            chunks.append(frame.inner_text("body"))
        except Exception:
            continue
    return "\n".join(chunks)


def read_punches_for_days(page: Page, targets: Sequence[date]) -> Dict[date, List[time]]:
    """Open 我的考勤 once and parse punches for all target dates."""
    if not targets:
        return {}
    open_my_attendance(page)
    page.wait_for_timeout(3_000)
    text = collect_page_text(page)
    if not looks_like_attendance_page(text):
        page.reload(wait_until="domcontentloaded")
        page.wait_for_timeout(3_000)
        open_my_attendance(page)
        page.wait_for_timeout(3_000)
        text = collect_page_text(page)
    if not looks_like_attendance_page(text):
        raise AttendanceReadError(f"我的考勤 did not render any dates. url={page.url}")
    return parse_punches_map_from_text(text, targets)


def read_punches_for_day(page: Page, target: date) -> List[time]:
    return read_punches_for_days(page, [target])[target]
