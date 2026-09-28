# -*- coding: utf-8 -*-
"""Cancel/revoke existing EHR overtime applications (standalone helper)."""

from __future__ import annotations

import re
from dataclasses import dataclass
from datetime import date, time
from typing import List, Optional, Sequence

from playwright.sync_api import Page

from ehr_nav import open_overtime_query

_FEEDBACK_RE = re.compile(
    r"feedback\(\s*'(?P<d>\d{1,2})/(?P<m>\d{1,2})/(?P<y>20\d{2})'\s*,\s*"
    r"'(?P<h>[01]?\d|2[0-3]):(?P<min>[0-5]\d)'\s*,\s*'(?P<oid>[^']+)'\s*\)",
    re.I,
)
_DEL_RE = re.compile(
    r"del\(\s*'(?P<emp>[^']+)'\s*,\s*'(?P<oid>[^']+)'\s*,\s*'(?P<flag>[^']*)'\s*\)",
    re.I,
)
_ROW_TIME_RE = re.compile(
    r"(?P<d>\d{1,2})/(?P<m>\d{1,2})/(?P<y>20\d{2})\s+"
    r"(?P<h1>[01]?\d|2[0-3]):(?P<min1>[0-5]\d)\s+"
    r"(?P<d2>\d{1,2})/(?P<m2>\d{1,2})/(?P<y2>20\d{2})\s+"
    r"(?P<h2>[01]?\d|2[0-3]):(?P<min2>[0-5]\d)"
)


class OvertimeCancelError(RuntimeError):
    """Failed to locate or revoke an overtime row."""


@dataclass(frozen=True)
class OvertimeCancelTarget:
    target_date: date
    start: time
    end: Optional[time] = None


@dataclass(frozen=True)
class OvertimeCancelMatch:
    target_date: date
    start: time
    end: Optional[time]
    emp_no: str
    ot_id: str
    revoke_href: str
    row_text: str = ""


def _fmt_dmy(day: date) -> str:
    return f"{day.day:02d}/{day.month:02d}/{day.year}"


def _fmt_hm(t: time) -> str:
    return t.strftime("%H:%M")


def parse_feedback_href(href: str) -> Optional[tuple[date, time, str]]:
    m = _FEEDBACK_RE.search(href or "")
    if not m:
        return None
    return (
        date(int(m["y"]), int(m["m"]), int(m["d"])),
        time(int(m["h"]), int(m["min"])),
        m["oid"],
    )


def parse_del_href(href: str) -> Optional[tuple[str, str, str]]:
    m = _DEL_RE.search(href or "")
    if not m:
        return None
    return m["emp"], m["oid"], m["flag"]


def _parse_end_from_row(row_text: str, day: date, start: time) -> Optional[time]:
    for m in _ROW_TIME_RE.finditer(row_text or ""):
        row_day = date(int(m["y"]), int(m["m"]), int(m["d"]))
        row_start = time(int(m["h1"]), int(m["min1"]))
        if row_day == day and row_start == start:
            return time(int(m["h2"]), int(m["min2"]))
    times = re.findall(r"\b([01]?\d|2[0-3]):([0-5]\d)\b", row_text or "")
    if len(times) >= 2:
        return time(int(times[1][0]), int(times[1][1]))
    return None


def list_revocable_overtime(page: Page) -> List[OvertimeCancelMatch]:
    """Scan 加班查询 frames for rows that expose 撤销申请."""
    open_overtime_query(page)
    page.wait_for_timeout(3_000)
    matches: List[OvertimeCancelMatch] = []
    for frame in page.frames:
        try:
            rows = frame.evaluate(
                """() => {
                  return Array.from(document.querySelectorAll('tr')).map((tr) => {
                    const feedback = tr.querySelector(\"a[href*='feedback(']\");
                    const revoke = tr.querySelector(\"a[href*='del(']\");
                    if (!feedback || !revoke) return null;
                    const text = ((revoke.innerText || revoke.textContent || '') + '').trim();
                    if (text && !/撤销/.test(text)) return null;
                    return {
                      feedbackHref: feedback.getAttribute('href') || '',
                      revokeHref: revoke.getAttribute('href') || '',
                      rowText: ((tr.innerText || '') + '').replace(/\\s+/g, ' ').trim().slice(0, 300),
                    };
                  }).filter(Boolean);
                }"""
            )
        except Exception:
            continue
        for row in rows or []:
            fb = parse_feedback_href(row.get("feedbackHref") or "")
            dl = parse_del_href(row.get("revokeHref") or "")
            if fb is None or dl is None:
                continue
            day, start, oid_fb = fb
            emp, oid_del, _flag = dl
            if oid_fb != oid_del:
                # Prefer del oid; still keep if feedback oid differs unexpectedly.
                oid = oid_del
            else:
                oid = oid_del
            end = _parse_end_from_row(row.get("rowText") or "", day, start)
            matches.append(
                OvertimeCancelMatch(
                    target_date=day,
                    start=start,
                    end=end,
                    emp_no=emp,
                    ot_id=oid,
                    revoke_href=row.get("revokeHref") or "",
                    row_text=row.get("rowText") or "",
                )
            )
    return matches


def find_matching_overtime(
    rows: Sequence[OvertimeCancelMatch],
    target: OvertimeCancelTarget,
) -> List[OvertimeCancelMatch]:
    """Filter revocable rows by date/start[/end]."""
    out: List[OvertimeCancelMatch] = []
    for row in rows:
        if row.target_date != target.target_date:
            continue
        if row.start != target.start:
            continue
        if target.end is not None and row.end is not None and row.end != target.end:
            continue
        out.append(row)
    return out


def revoke_overtime(page: Page, match: OvertimeCancelMatch) -> None:
    """Click/evaluate 撤销申请 for one matched row and accept dialogs."""
    accepted: List[str] = []

    def accept(dialog) -> None:
        accepted.append(dialog.message or "")
        dialog.accept()

    page.on("dialog", accept)
    try:
        clicked = False
        for frame in page.frames:
            try:
                clicked = frame.evaluate(
                    """(href) => {
                      const a = Array.from(document.querySelectorAll('a'))
                        .find((el) => (el.getAttribute('href') || '') === href);
                      if (!a) return false;
                      a.click();
                      return true;
                    }""",
                    match.revoke_href,
                )
            except Exception:
                clicked = False
            if clicked:
                break
        if not clicked:
            # Fallback: call del() directly in any frame that defines it.
            emp, oid, flag = parse_del_href(match.revoke_href) or (
                match.emp_no,
                match.ot_id,
                "Y",
            )
            invoked = False
            for frame in page.frames:
                try:
                    invoked = frame.evaluate(
                        """({emp, oid, flag}) => {
                          if (typeof del !== 'function') return false;
                          del(emp, oid, flag);
                          return true;
                        }""",
                        {"emp": emp, "oid": oid, "flag": flag},
                    )
                except Exception:
                    invoked = False
                if invoked:
                    break
            if not invoked:
                raise OvertimeCancelError(
                    f"撤销申请 control not clickable for "
                    f"{match.target_date} {_fmt_hm(match.start)}"
                    f"{'-' + _fmt_hm(match.end) if match.end else ''}"
                )
        page.wait_for_timeout(4_000)
    finally:
        page.remove_listener("dialog", accept)

    for message in accepted:
        print(f"[INFO] overtime-cancel dialog: {message}", flush=True)


def cancel_matching_overtime(
    page: Page,
    targets: Sequence[OvertimeCancelTarget],
    *,
    allow: bool,
) -> List[OvertimeCancelMatch]:
    """Find targets on 加班查询; revoke when allow=True. Returns matched rows."""
    rows = list_revocable_overtime(page)
    matched: List[OvertimeCancelMatch] = []
    for target in targets:
        hits = find_matching_overtime(rows, target)
        if not hits:
            print(
                f"[WARN] no revocable overtime for "
                f"{target.target_date.isoformat()} {_fmt_hm(target.start)}"
                f"{'-' + _fmt_hm(target.end) if target.end else ''}",
                flush=True,
            )
            continue
        for hit in hits:
            print(
                f"[OK] matched {hit.target_date.isoformat()} "
                f"{_fmt_hm(hit.start)}-{_fmt_hm(hit.end) if hit.end else '?'} "
                f"ot_id={hit.ot_id} emp={hit.emp_no}",
                flush=True,
            )
            matched.append(hit)
            if not allow:
                print("[INFO] dry-run: skip 撤销申请 (pass --ALLOW to revoke)", flush=True)
                continue
            revoke_overtime(page, hit)
            print(
                f"[OK] revoked {hit.target_date.isoformat()} "
                f"{_fmt_hm(hit.start)}-{_fmt_hm(hit.end) if hit.end else '?'}",
                flush=True,
            )
            # Refresh list for subsequent targets.
            rows = list_revocable_overtime(page)
    return matched
