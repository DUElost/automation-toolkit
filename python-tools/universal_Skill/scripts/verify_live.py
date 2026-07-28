# -*- coding: utf-8 -*-
"""Fill then immediately verify selections in the same browser session."""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from exam_bot import (  # noqa: E402
    DEFAULT_ANSWERS,
    DEFAULT_STATE,
    EXTRACT_QUESTIONS_JS,
    _click_option_by_text,
    launch_browser,
)
from matching import match_options_by_text, match_stem, normalize_text  # noqa: E402

URL = "https://tinno.study.moxueyuan.com/task/exam/questions/7720452?resource_relation="

EXTRACT_SELECTED_JS = r"""
() => {
  const norm = (s) => (s || '').replace(/\s+/g, ' ').trim();
  const optionRe = /^([A-Fa-f])[\.、．\s]+(.+)$/;
  const blocks = [];
  const seen = new Set();
  document.querySelectorAll('.exam-content-item').forEach((el, domIndex) => {
    const stemEl = el.querySelector('.exam-pre');
    if (!stemEl) return;
    const stem = norm(stemEl.innerText || '');
    if (!stem) return;
    const options = [];
    const selected = [];
    el.querySelectorAll('.exam-option').forEach((opt, optIndex) => {
      const raw = norm((opt.querySelector('.multiple-choice') || opt).innerText || '');
      const m = raw.match(optionRe);
      if (!m) return;
      const text = norm(m[2]);
      const icon = opt.querySelector('i.iconfont');
      const cls = (icon && icon.className) || '';
      // selected single/multi icons used by moxueyuan
      const isSelected = cls.includes('icon-single_icon') || cls.includes('icon-more_icon');
      options.push({ letter: m[1].toUpperCase(), text, optIndex, selected: isSelected, iconClass: cls });
      if (isSelected) selected.push(text);
    });
    if (options.length < 2) return;
    const key = stem.slice(0, 60) + '|' + options.map(o => o.text).join('|');
    if (seen.has(key)) return;
    seen.add(key);
    blocks.push({ stem, options, selected, domIndex });
  });
  return blocks;
}
"""


def set_equal(xs, ys) -> bool:
    return {normalize_text(x) for x in xs} == {normalize_text(y) for y in ys}


def expand_all(page) -> None:
    aside = page.locator(".exam-content-aside, .exam-content-right")
    for n in (20, 40, 60, 1):
        try:
            t = aside.get_by_text(str(n), exact=True)
            if t.count():
                t.first.click(timeout=2000)
                page.wait_for_timeout(700)
        except Exception:
            pass


def fill_all(page, bank) -> dict:
    report = {"filled": 0, "fail": []}
    questions = page.evaluate(EXTRACT_QUESTIONS_JS)
    filled_keys = set()
    for q in questions:
        stem = q.get("stem") or ""
        page_options = q.get("options") or []
        dom_index = q.get("domIndex")
        qkey = (normalize_text(stem), tuple(normalize_text(o.get("text", "")) for o in page_options))
        if qkey in filled_keys:
            continue
        hit = match_stem(
            stem,
            bank,
            threshold=0.72,
            min_gap=0.05,
            page_option_texts=[o.get("text", "") for o in page_options],
        )
        if hit is None:
            report["fail"].append({"stem": stem, "reason": "no_match"})
            continue
        idxs = match_options_by_text(hit["answer_texts"], page_options, threshold=0.85)
        if len(idxs) != len(hit["answer_texts"]):
            report["fail"].append({"stem": stem, "reason": "option_miss", "want": hit["answer_texts"]})
            continue
        ok = True
        for i in idxs:
            opt = page_options[i]
            if not _click_option_by_text(page, opt["text"], dom_index=dom_index, opt_index=opt.get("optIndex", i)):
                ok = False
            page.wait_for_timeout(80)
        if ok:
            filled_keys.add(qkey)
            report["filled"] += 1
        else:
            report["fail"].append({"stem": stem, "reason": "click_fail", "want": hit["answer_texts"]})
    return report


def verify_all(page, bank) -> dict:
    out = {"ok": [], "wrong": [], "empty": [], "stem_fail": []}
    blocks = page.evaluate(EXTRACT_SELECTED_JS)
    for b in blocks:
        stem = b["stem"]
        selected = b.get("selected") or []
        page_opts = b["options"]
        hit = match_stem(
            stem,
            bank,
            threshold=0.72,
            min_gap=0.05,
            page_option_texts=[o["text"] for o in page_opts],
        )
        if hit is None:
            out["stem_fail"].append({"stem": stem, "selected": selected})
            continue
        expect = hit["answer_texts"]
        if not selected:
            out["empty"].append({"stem": stem, "expect": expect})
        elif set_equal(selected, expect):
            out["ok"].append({"stem": stem, "selected": selected})
        else:
            out["wrong"].append({"stem": stem, "expect": expect, "selected": selected})
    return out, blocks


def main() -> int:
    from playwright.sync_api import sync_playwright

    bank = json.loads(Path(DEFAULT_ANSWERS).read_text(encoding="utf-8"))
    with sync_playwright() as p:
        browser = launch_browser(p)
        context = browser.new_context(storage_state=str(DEFAULT_STATE))
        page = context.new_page()
        page.goto(URL, wait_until="networkidle")
        page.wait_for_timeout(2000)
        expand_all(page)

        fill_report = fill_all(page, bank)
        print("FILL", fill_report["filled"], "fails", len(fill_report["fail"]))
        page.wait_for_timeout(500)
        expand_all(page)

        verify, blocks = verify_all(page, bank)
        prog = page.evaluate(
            r"""() => {
              const t = document.body.innerText || '';
              const m = t.match(/当前答题\s*\d+\s*\/\s*\d+/) || t.match(/\d+\s*\/\s*60/);
              return m ? m[0] : '';
            }"""
        )
        # icon stats
        icon_stats = page.evaluate(
            """() => {
              let single=0, nosingle=0, multiple=0, other=0;
              document.querySelectorAll('.exam-option i.iconfont').forEach(i => {
                const c=i.className||'';
                if (c.includes('icon-single_icon')) single++;
                else if (c.includes('icon-multiple_icon')) multiple++;
                else if (c.includes('icon-nosingle_icon')) nosingle++;
                else other++;
              });
              return {single, multiple, nosingle, other, cards: document.querySelectorAll('.exam-content-item').length};
            }"""
        )
        summary = {
            "progress": prog,
            "cards": len(blocks),
            "fill_claimed": fill_report["filled"],
            "verify_ok": len(verify["ok"]),
            "verify_wrong": len(verify["wrong"]),
            "verify_empty": len(verify["empty"]),
            "verify_stem_fail": len(verify["stem_fail"]),
            "icon_stats": icon_stats,
        }
        print("SUMMARY", json.dumps(summary, ensure_ascii=False))
        detail = {"summary": summary, "fill_fail": fill_report["fail"], "verify": verify}
        path = ROOT / "data" / "verify_live_report.json"
        path.write_text(json.dumps(detail, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"Detail -> {path}")
        if verify["wrong"]:
            print("WRONG:")
            for w in verify["wrong"][:15]:
                print("-", w["stem"][:50])
                print("  expect:", w["expect"])
                print("  selected:", w["selected"])

        print("浏览器保持打开供你肉眼复核；关闭窗口结束。")
        try:
            input()
        except EOFError:
            while browser.is_connected():
                time.sleep(1)
        if browser.is_connected():
            browser.close()

    ok = (
        summary["verify_wrong"] == 0
        and summary["verify_empty"] == 0
        and summary["verify_stem_fail"] == 0
        and summary["verify_ok"] >= 55
    )
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
