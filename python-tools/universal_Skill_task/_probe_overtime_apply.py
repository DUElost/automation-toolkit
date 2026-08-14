# -*- coding: utf-8 -*-
"""Read-only probe of EHR 加班申请 form controls. Never click submit."""

from __future__ import annotations

from pathlib import Path

from browser import launch_page
from bpm_login import login_bpm
from config import load_config
from ehr_nav import open_overtime_apply, wait_ehr_home_ready
from ehr_overtime_apply import is_forbidden_click_text
from navigate_ehr import open_ehr

ART = Path(__file__).resolve().parent / "artifacts"


def dump_controls(page) -> str:
    lines = [f"url={page.url}", f"title={page.title()}", ""]
    for i, frame in enumerate(page.frames):
        lines.append(f"=== frame[{i}] {frame.url[:160]} ===")
        try:
            info = frame.evaluate(
                """() => {
                  const out = [];
                  const nodes = document.querySelectorAll('input,select,textarea,button,a');
                  for (const el of Array.from(nodes).slice(0, 200)) {
                    out.push({
                      tag: el.tagName,
                      type: el.getAttribute('type') || '',
                      name: el.getAttribute('name') || '',
                      id: el.id || '',
                      value: (el.value || '').slice(0, 40),
                      text: (el.innerText || el.textContent || '').trim().slice(0, 40),
                    });
                  }
                  return out;
                }"""
            )
        except Exception as exc:
            lines.append(f"<err {exc}>")
            continue
        for row in info:
            mark = " FORBIDDEN" if is_forbidden_click_text(row.get("text") or "") else ""
            lines.append(
                f"{row['tag']} type={row['type']!r} name={row['name']!r} "
                f"id={row['id']!r} value={row['value']!r} text={row['text']!r}{mark}"
            )
        lines.append("")
    return "\n".join(lines)


def main() -> None:
    cfg = load_config()
    ART.mkdir(parents=True, exist_ok=True)
    with launch_page() as (_pw, _browser, context, page):
        login_bpm(page, cfg)
        ehr = open_ehr(page, context)
        wait_ehr_home_ready(ehr)
        open_overtime_apply(ehr)
        ehr.wait_for_timeout(5_000)
        text = dump_controls(ehr)
        out = ART / "probe_overtime_apply.txt"
        out.write_text(text, encoding="utf-8")
        ehr.screenshot(path=str(ART / "probe_overtime_apply.png"), full_page=True)
        print(f"wrote {out}", flush=True)
        print("Press Enter to close...", flush=True)
        input()


if __name__ == "__main__":
    main()
