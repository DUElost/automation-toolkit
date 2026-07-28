# -*- coding: utf-8 -*-
"""Playwright bot: login once, fill exam by answer texts."""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional

from matching import match_options_by_text, match_stem

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_STATE = ROOT / "data" / "storage_state.json"
DEFAULT_ANSWERS = ROOT / "data" / "answers.json"
SCREENSHOT_DIR = ROOT / "data" / "screenshots"

EXTRACT_QUESTIONS_JS = r"""
() => {
  const norm = (s) => (s || '').replace(/\s+/g, ' ').trim();
  const optionRe = /^([A-Fa-f])[\.、．\s]+(.+)$/;
  const blocks = [];
  const candidates = Array.from(document.querySelectorAll('div, li, section, article'));
  const seen = new Set();
  for (const el of candidates) {
    const text = norm(el.innerText || '');
    if (text.length < 10 || text.length > 2500) continue;
    const lines = text.split('\n').map(norm).filter(Boolean);
    const optIdx = lines.findIndex(l => optionRe.test(l));
    if (optIdx < 1) continue;
    const options = [];
    for (let i = optIdx; i < lines.length; i++) {
      const m = lines[i].match(optionRe);
      if (!m) {
        if (options.length) break;
        continue;
      }
      options.push({ letter: m[1].toUpperCase(), text: m[2] });
    }
    if (options.length < 2) continue;
    const stem = lines.slice(0, optIdx).join('');
    const key = stem.slice(0, 40) + '|' + options.map(o => o.text).join('|');
    if (seen.has(key)) continue;
    seen.add(key);
    blocks.push({ stem, options, key });
  }
  return blocks;
}
"""


def load_answers(path: Path) -> List[Dict[str, Any]]:
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, list):
        raise ValueError("answers.json must be a list")
    return data


def cmd_login(url: str, state_path: Path) -> int:
    from playwright.sync_api import sync_playwright

    state_path.parent.mkdir(parents=True, exist_ok=True)
    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        context = browser.new_context()
        page = context.new_page()
        page.goto(url, wait_until="domcontentloaded")
        print("请在打开的浏览器中完成登录，并进入可答题页面。")
        print("完成后回到终端，按 Enter 保存登录态…")
        try:
            input()
        except EOFError:
            print("未检测到交互输入，等待 90s 后保存…")
            time.sleep(90)
        context.storage_state(path=str(state_path))
        browser.close()
    print(f"Saved storage state -> {state_path}")
    return 0


def _click_option_by_text(page, option_text: str) -> bool:
    loc = page.get_by_text(option_text, exact=False)
    try:
        count = loc.count()
    except Exception:
        return False
    for i in range(count):
        item = loc.nth(i)
        try:
            if item.is_visible():
                item.click(timeout=3000)
                return True
        except Exception:
            continue
    return False


def cmd_fill(
    url: str,
    answers_path: Path,
    state_path: Path,
    threshold: float,
    submit: bool,
    force_submit: bool,
    dump: bool,
) -> int:
    from playwright.sync_api import sync_playwright
    from matching import similarity

    if not state_path.exists():
        print(f"Missing login state: {state_path}. Run: python scripts/exam_bot.py login --url ...")
        return 2

    try:
        bank = load_answers(answers_path)
    except FileNotFoundError:
        print(
            f"Missing answers file: {answers_path}. "
            f"Generate it with: python scripts/parse_answers.py --input <题库.txt> --output {answers_path}"
        )
        return 2
    except json.JSONDecodeError as e:
        print(
            f"Invalid JSON in answers file: {answers_path} ({e}). "
            f"Regenerate with: python scripts/parse_answers.py --input <题库.txt> --output {answers_path}"
        )
        return 2

    report = {
        "filled": [],
        "unmatched": [],
        "ambiguous": [],
        "option_miss": [],
    }

    with sync_playwright() as p:
        browser = p.chromium.launch(headless=False)
        context = browser.new_context(storage_state=str(state_path))
        page = context.new_page()
        page.goto(url, wait_until="networkidle")
        page.wait_for_timeout(2000)

        if dump:
            SCREENSHOT_DIR.mkdir(parents=True, exist_ok=True)
            html_path = SCREENSHOT_DIR / "page.html"
            html_path.write_text(page.content(), encoding="utf-8")
            page.screenshot(path=str(SCREENSHOT_DIR / "page.png"), full_page=True)
            print(f"Dumped DOM -> {html_path}")

        questions = page.evaluate(EXTRACT_QUESTIONS_JS)
        print(f"Detected {len(questions)} question blocks on page")

        if not questions:
            print("No questions detected; use --dump to inspect DOM")
            report["unmatched"].append({"stem": "", "best": 0, "second": 0, "reason": "no_questions"})
        else:
            for q in questions:
                page_stem = q.get("stem") or ""
                page_options = q.get("options") or []
                hit = match_stem(page_stem, bank, threshold=threshold, min_gap=0.05)
                if hit is None:
                    scored = sorted(
                        ((similarity(page_stem, b.get("stem", "")), b) for b in bank),
                        key=lambda x: x[0],
                        reverse=True,
                    )
                    best = scored[0][0] if scored else 0
                    second = scored[1][0] if len(scored) > 1 else 0
                    bucket = "ambiguous" if best >= threshold and best - second < 0.05 else "unmatched"
                    report[bucket].append({"stem": page_stem, "best": best, "second": second})
                    continue

                idxs = match_options_by_text(hit["answer_texts"], page_options, threshold=0.85)
                if len(idxs) != len(hit["answer_texts"]):
                    report["option_miss"].append(
                        {
                            "stem": page_stem,
                            "want": hit["answer_texts"],
                            "page": [o.get("text") for o in page_options],
                        }
                    )
                    continue

                ok_all = True
                for i in idxs:
                    text = page_options[i]["text"]
                    if not _click_option_by_text(page, text):
                        ok_all = False
                if ok_all:
                    report["filled"].append({"stem": page_stem, "answers": hit["answer_texts"]})
                else:
                    report["option_miss"].append({"stem": page_stem, "want": hit["answer_texts"]})

        problems = report["unmatched"] + report["ambiguous"] + report["option_miss"]
        print(json.dumps({k: len(v) for k, v in report.items()}, ensure_ascii=False))
        detail_path = ROOT / "data" / "last_report.json"
        detail_path.parent.mkdir(parents=True, exist_ok=True)
        detail_path.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"Detail report -> {detail_path}")

        if submit:
            if problems and not force_submit:
                reason = (
                    "no questions detected"
                    if not questions
                    else "unmatched/ambiguous/option_miss exist"
                )
                print(f"Refuse --submit because {reason}. Use --force-submit to override.")
                browser.close()
                return 1
            clicked = False
            for label in ("交卷", "提交", "提交试卷", "确认交卷"):
                btn = page.get_by_role("button", name=label)
                if btn.count() == 0:
                    btn = page.get_by_text(label, exact=False)
                if btn.count():
                    try:
                        btn.first.click(timeout=3000)
                        page.wait_for_timeout(500)
                        for conf in ("确认", "确定", "是"):
                            c = page.get_by_role("button", name=conf)
                            if c.count():
                                c.first.click(timeout=2000)
                                break
                        clicked = True
                        break
                    except Exception as e:
                        print(f"Submit click failed for {label}: {e}")
            if not clicked:
                print("Submit button not found")
                browser.close()
                return 1

        browser.close()

    return 1 if problems else 0


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="Moxueyuan exam bot")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_login = sub.add_parser("login", help="Manual login and save storage state")
    p_login.add_argument("--url", required=True)
    p_login.add_argument("--state", default=str(DEFAULT_STATE))

    p_fill = sub.add_parser("fill", help="Fill answers from answers.json")
    p_fill.add_argument("--url", required=True)
    p_fill.add_argument("--answers", default=str(DEFAULT_ANSWERS))
    p_fill.add_argument("--state", default=str(DEFAULT_STATE))
    p_fill.add_argument("--threshold", type=float, default=0.72)
    p_fill.add_argument("--submit", action="store_true")
    p_fill.add_argument("--force-submit", action="store_true")
    p_fill.add_argument("--dump", action="store_true", help="Dump HTML/screenshot for selector tuning")

    args = parser.parse_args(argv)
    if args.cmd == "login":
        return cmd_login(args.url, Path(args.state))
    if args.cmd == "fill":
        return cmd_fill(
            url=args.url,
            answers_path=Path(args.answers),
            state_path=Path(args.state),
            threshold=args.threshold,
            submit=args.submit,
            force_submit=args.force_submit,
            dump=args.dump,
        )
    return 2


if __name__ == "__main__":
    sys.exit(main())
