# -*- coding: utf-8 -*-
"""Verify selected options on live exam page against answers.json."""
from __future__ import annotations

import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from exam_bot import (  # noqa: E402
    DEFAULT_ANSWERS,
    DEFAULT_STATE,
    EXTRACT_QUESTIONS_JS,
    launch_browser,
)
from matching import match_stem, normalize_text, similarity  # noqa: E402

URL = "https://tinno.study.moxueyuan.com/task/exam/questions/7720452?resource_relation="

EXTRACT_SELECTED_JS = r"""
() => {
  const norm = (s) => (s || '').replace(/\s+/g, ' ').trim();
  const optionRe = /^([A-Fa-f])[\.、．\s]+(.+)$/;
  const blocks = [];
  const seen = new Set();
  const items = Array.from(document.querySelectorAll('.exam-content-item'));
  items.forEach((el, domIndex) => {
    const stemEl = el.querySelector('.exam-pre');
    if (!stemEl) return;
    const stem = norm(stemEl.innerText || '');
    if (!stem) return;
    const options = [];
    const selected = [];
    Array.from(el.querySelectorAll('.exam-option')).forEach((opt, optIndex) => {
      const raw = norm((opt.querySelector('.multiple-choice') || opt).innerText || '');
      const m = raw.match(optionRe);
      if (!m) return;
      const text = norm(m[2]);
      const icon = opt.querySelector('i.iconfont');
      const cls = (icon && icon.className) || '';
      const isSelected = /icon-single_icon|icon-multiple_icon|icon-checked|is-checked/.test(cls)
        || /theme-text(?!-hover)/.test(cls)
        || opt.className.includes('is-checked');
      options.push({ letter: m[1].toUpperCase(), text, optIndex, selected: !!isSelected, iconClass: cls });
      if (isSelected) selected.push(text);
    });
    if (options.length < 2) return;
    const key = stem.slice(0, 60) + '|' + options.map(o => o.text).join('|');
    if (seen.has(key)) return;
    seen.add(key);
    blocks.push({ stem, options, selected, key, domIndex });
  });
  return blocks;
}
"""


def texts_equal(a, b) -> bool:
    return normalize_text(a) == normalize_text(b)


def set_equal(xs, ys) -> bool:
    return {normalize_text(x) for x in xs} == {normalize_text(y) for y in ys}


def main() -> int:
    from playwright.sync_api import sync_playwright

    bank = json.loads(Path(DEFAULT_ANSWERS).read_text(encoding="utf-8"))
    out = {
        "checked": 0,
        "ok": [],
        "wrong": [],
        "empty": [],
        "unmatched_stem": [],
        "ambiguous": [],
    }

    with sync_playwright() as p:
        browser = launch_browser(p)
        context = browser.new_context(storage_state=str(DEFAULT_STATE))
        page = context.new_page()
        page.goto(URL, wait_until="networkidle")
        page.wait_for_timeout(2000)
        aside = page.locator(".exam-content-aside, .exam-content-right")
        for n in (20, 40, 60, 1):
            try:
                t = aside.get_by_text(str(n), exact=True)
                if t.count():
                    t.first.click(timeout=2000)
                    page.wait_for_timeout(600)
            except Exception:
                pass
        page.wait_for_timeout(800)

        # First sample icon classes to tune detector if needed
        sample = page.evaluate(
            """() => {
              const opts = Array.from(document.querySelectorAll('.exam-option')).slice(0, 8);
              return opts.map(o => {
                const i = o.querySelector('i.iconfont');
                return { text: (o.innerText||'').replace(/\\s+/g,' ').trim().slice(0,40), icon: i ? i.className : '', cls: o.className };
              });
            }"""
        )
        print("SAMPLE_ICONS:")
        for s in sample:
            print(s)

        blocks = page.evaluate(EXTRACT_SELECTED_JS)
        print(f"Loaded {len(blocks)} question cards")

        # If nothing selected detected, try alternate: compare icon-nosingle vs icon-single counts
        selected_total = sum(len(b.get("selected") or []) for b in blocks)
        print(f"Detected selected options total: {selected_total}")

        for b in blocks:
            stem = b["stem"]
            page_opts = b["options"]
            selected = b.get("selected") or []
            hit = match_stem(
                stem,
                bank,
                threshold=0.72,
                min_gap=0.05,
                page_option_texts=[o["text"] for o in page_opts],
            )
            out["checked"] += 1
            if hit is None:
                scored = sorted(
                    ((similarity(stem, x.get("stem", "")), x) for x in bank),
                    key=lambda t: t[0],
                    reverse=True,
                )
                best = scored[0][0] if scored else 0
                second = scored[1][0] if len(scored) > 1 else 0
                bucket = "ambiguous" if best >= 0.72 and best - second < 0.05 else "unmatched_stem"
                out[bucket].append({"stem": stem, "selected": selected, "best": best, "second": second})
                continue

            expect = hit["answer_texts"]
            if not selected:
                out["empty"].append({"stem": stem, "expect": expect, "page": [o["text"] for o in page_opts]})
                continue
            if set_equal(selected, expect):
                out["ok"].append({"stem": stem, "selected": selected})
            else:
                out["wrong"].append(
                    {
                        "stem": stem,
                        "expect": expect,
                        "selected": selected,
                        "page_options": [o["text"] for o in page_opts],
                    }
                )

        prog = page.evaluate(
            r"""() => {
              const t = document.body.innerText || '';
              const m = t.match(/当前答题\s*\d+\s*\/\s*\d+/) || t.match(/\d+\s*\/\s*60/);
              return m ? m[0] : '';
            }"""
        )
        print(f"Page progress: {prog}")
        browser.close()

    report_path = ROOT / "data" / "verify_report.json"
    report_path.write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8")
    summary = {
        "checked": out["checked"],
        "ok": len(out["ok"]),
        "wrong": len(out["wrong"]),
        "empty": len(out["empty"]),
        "unmatched_stem": len(out["unmatched_stem"]),
        "ambiguous": len(out["ambiguous"]),
    }
    print("SUMMARY", json.dumps(summary, ensure_ascii=False))
    print(f"Detail -> {report_path}")
    if out["wrong"]:
        print("WRONG samples:")
        for w in out["wrong"][:10]:
            print("-", w["stem"][:40])
            print("  expect:", w["expect"])
            print("  selected:", w["selected"])
    if out["empty"]:
        print("EMPTY samples:")
        for w in out["empty"][:5]:
            print("-", w["stem"][:40], "expect", w["expect"])
    return 0 if not out["wrong"] and not out["empty"] and not out["unmatched_stem"] and not out["ambiguous"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
