# -*- coding: utf-8 -*-
"""One-off read-only probe: dump 我的考勤 and 加班查询 content for parser tuning.

Dumps every page in the browser context, because EHR menu items may open new tabs.
Never clicks 加班申请 or any submit control.
"""
from __future__ import annotations

from pathlib import Path

from browser import launch_page
from bpm_login import login_bpm
from config import load_config
from ehr_nav import open_my_attendance, open_overtime_query, wait_ehr_home_ready
from navigate_ehr import open_ehr

ART = Path(__file__).resolve().parent / "artifacts"


def _dump_page(page, tag: str, index: int) -> None:
    lines = [f"url={page.url}", f"title={page.title()}", f"frames={len(page.frames)}", ""]
    for i, frame in enumerate(page.frames):
        lines.append(f"=== frame[{i}] {frame.url[:150]} ===")
        try:
            lines.append(frame.inner_text("body")[:8000])
        except Exception as exc:
            lines.append(f"<inner_text error: {exc}>")
        lines.append("")

    lines.append("=== table rows per frame ===")
    for i, frame in enumerate(page.frames):
        try:
            rows = frame.evaluate(
                """() => Array.from(document.querySelectorAll('tr'))
                     .map(tr => Array.from(tr.cells || [])
                       .map(c => (c.innerText || '').replace(/\\s+/g, ' ').trim())
                       .join(' | '))
                     .filter(t => t)
                     .slice(0, 150)"""
            )
        except Exception as exc:
            lines.append(f"frame[{i}] rows error: {exc}")
            continue
        if rows:
            lines.append(f"-- frame[{i}] rows={len(rows)}")
            lines.extend(rows)

    out = ART / f"{tag}_page{index}.txt"
    out.write_text("\n".join(lines), encoding="utf-8")
    try:
        page.screenshot(path=str(ART / f"{tag}_page{index}.png"), full_page=True)
    except Exception:
        pass
    print(f"[dump] {out.name} url={page.url[:110]}", flush=True)


def dump_context(context, tag: str) -> None:
    ART.mkdir(parents=True, exist_ok=True)
    for index, page in enumerate(context.pages):
        try:
            _dump_page(page, tag, index)
        except Exception as exc:
            print(f"[dump] page{index} failed: {exc}", flush=True)


def main() -> None:
    cfg = load_config()
    with launch_page() as (_pw, _browser, context, page):
        login_bpm(page, cfg)
        ehr = open_ehr(page, context)
        wait_ehr_home_ready(ehr)
        print("[ok] EHR home ready", flush=True)
        dump_context(context, "probe_home")

        open_my_attendance(ehr)
        ehr.wait_for_timeout(5_000)
        print(f"[info] pages after 我的考勤 = {len(context.pages)}", flush=True)
        dump_context(context, "probe_attendance")

        open_overtime_query(ehr)
        ehr.wait_for_timeout(5_000)
        print(f"[info] pages after 加班查询 = {len(context.pages)}", flush=True)
        dump_context(context, "probe_overtime")

        print("[info] done; browser closes now", flush=True)


if __name__ == "__main__":
    main()
