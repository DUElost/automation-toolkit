# -*- coding: utf-8 -*-
"""Playwright bot: login once, fill exam by answer texts."""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional

from matching import match_options_by_text, match_stem, normalize_text, similarity
from qr_decode import decode_qr

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_STATE = ROOT / "data" / "storage_state.json"
DEFAULT_ANSWERS = ROOT / "data" / "answers.json"
SCREENSHOT_DIR = ROOT / "data" / "screenshots"
DEFAULT_LOGIN_URL = "https://tinno.study.moxueyuan.com/login"
STUDY_EXAM_URL_TMPL = "https://tinno.study.moxueyuan.com/task/exam/questions/{exam_id}"

EXTRACT_QUESTIONS_JS = r"""
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
    Array.from(el.querySelectorAll('.exam-option')).forEach((opt, optIndex) => {
      const raw = norm((opt.querySelector('.multiple-choice') || opt).innerText || '');
      const m = raw.match(optionRe);
      if (!m) return;
      options.push({
        letter: m[1].toUpperCase(),
        text: norm(m[2]),
        optIndex,
      });
    });
    if (options.length < 2) return;
    const key = stem.slice(0, 60) + '|' + options.map(o => o.text).join('|');
    if (seen.has(key)) return;
    seen.add(key);
    blocks.push({ stem, options, key, domIndex });
  });
  return blocks;
}
"""


def load_answers(path: Path) -> List[Dict[str, Any]]:
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, list):
        raise ValueError("answers.json must be a list")
    return data


def _candidate_chrome_paths() -> List[Path]:
    local = Path.home() / "AppData" / "Local"
    return [
        local / "ms-playwright" / "chromium-1200" / "chrome-win64" / "chrome.exe",
        local / "ms-playwright" / "chromium-1140" / "chrome-win" / "chrome.exe",
        Path(r"C:\Program Files\Google\Chrome\Application\chrome.exe"),
        Path(r"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"),
        Path(r"C:\Program Files\Microsoft\Edge\Application\msedge.exe"),
    ]


def launch_browser(playwright):
    """Launch headed Chromium; fall back to local installs if download missing."""
    try:
        return playwright.chromium.launch(headless=False)
    except Exception as first_err:
        for channel in ("chrome", "msedge"):
            try:
                return playwright.chromium.launch(headless=False, channel=channel)
            except Exception:
                pass
        for exe in _candidate_chrome_paths():
            if exe.is_file():
                print(f"Using local browser: {exe}")
                return playwright.chromium.launch(headless=False, executable_path=str(exe))
        raise first_err


def extract_exam_id(url: str) -> Optional[str]:
    """Extract exam id from ceping?id= / questions/<id> / similar URLs."""
    from urllib.parse import parse_qs, urlparse

    parsed = urlparse(url)
    qs = parse_qs(parsed.query)
    if qs.get("id"):
        return str(qs["id"][0]).strip()
    m = re.search(r"/questions/(\d+)", parsed.path or "")
    if m:
        return m.group(1)
    m = re.search(r"[?&]id=(\d+)", url)
    if m:
        return m.group(1)
    return None


def to_study_exam_url(url: str) -> str:
    """Map share/mobile entry URL to PC study exam questions page."""
    eid = extract_exam_id(url)
    if not eid:
        return str(url).strip()
    study = STUDY_EXAM_URL_TMPL.format(exam_id=eid)
    already = "study.moxueyuan.com" in url and f"/questions/{eid}" in url
    if not already:
        print(f"Normalized exam URL -> {study}")
    return study


def resolve_exam_url(url: Optional[str] = None, qr: Optional[str] = None) -> str:
    """Resolve exam page URL from --url or --qr, normalized to study domain."""
    if bool(url) == bool(qr):
        raise ValueError("Provide exactly one of --url or --qr")
    if qr:
        image = Path(qr)
        if not image.is_file():
            alt = ROOT / qr
            if alt.is_file():
                image = alt
        decoded = decode_qr(image)
        print(f"QR decoded -> {decoded}")
        return to_study_exam_url(decoded)
    return to_study_exam_url(str(url).strip())


def resolve_login_url(url: Optional[str] = None) -> str:
    """PC login page with 扫码登录 (default study login)."""
    return (url or DEFAULT_LOGIN_URL).strip()


def is_logged_in(page, context) -> bool:
    title = page.title() or ""
    cur = page.url or ""
    cookies = {c["name"]: c.get("value") for c in context.cookies()}
    islogin = str(cookies.get("enterprise:domainName:islogin", "")).upper()
    on_login = ("登录" in title) or ("/login" in cur.lower())
    if on_login:
        return False
    if islogin == "Y":
        return True
    if "exam" in cur.lower() or "ceping" in cur.lower() or "questions" in cur.lower():
        return True
    return False


def cmd_login(url: str, state_path: Path, wait_seconds: int = 300) -> int:
    from playwright.sync_api import sync_playwright

    state_path.parent.mkdir(parents=True, exist_ok=True)
    with sync_playwright() as p:
        browser = launch_browser(p)
        context = browser.new_context()
        page = context.new_page()
        page.goto(url, wait_until="domcontentloaded")
        print(f"已打开登录页: {url}")
        print("请在【弹出的 Playwright 窗口】使用「扫码登录」完成认证（不要用日常 Chrome）。")
        print(f"脚本会每 3 秒检测登录态，最长等待 {wait_seconds}s…")
        deadline = time.time() + wait_seconds
        logged_in = False
        while time.time() < deadline:
            try:
                if is_logged_in(page, context):
                    page.wait_for_timeout(1500)
                    if is_logged_in(page, context):
                        logged_in = True
                        break
            except Exception as e:
                print(f"poll error: {e}")
            time.sleep(3)
        if not logged_in:
            print("登录超时：未检测到有效登录态，不保存 storage_state。")
            browser.close()
            return 2
        context.storage_state(path=str(state_path))
        browser.close()
    print(f"Saved storage state -> {state_path}")
    return 0


def _click_option_by_text(page, option_text: str, dom_index: Optional[int] = None, opt_index: Optional[int] = None) -> bool:
    """Click an exam option by text, preferably within a question card."""
    try:
        if dom_index is not None and opt_index is not None:
            item = page.locator(".exam-content-item").nth(dom_index)
            item.scroll_into_view_if_needed(timeout=3000)
            opt = item.locator(".exam-option").nth(opt_index)
            opt.click(timeout=3000)
            return True
        if dom_index is not None:
            item = page.locator(".exam-content-item").nth(dom_index)
            item.scroll_into_view_if_needed(timeout=3000)
            opt = item.locator(".exam-option").filter(has_text=option_text)
            if opt.count():
                opt.first.click(timeout=3000)
                return True
        loc = page.locator(".exam-option").filter(has_text=option_text)
        count = loc.count()
        for i in range(count):
            item = loc.nth(i)
            if item.is_visible():
                item.click(timeout=3000)
                return True
    except Exception:
        return False
    return False


def cmd_fill(
    url: str,
    answers_path: Path,
    state_path: Path,
    threshold: float,
    submit: bool,
    force_submit: bool,
    dump: bool,
    keep_open: bool = True,
    login_wait: int = 300,
) -> int:
    from playwright.sync_api import sync_playwright

    if not state_path.exists():
        print(f"Missing login state: {state_path}")
        print(f"Starting PC 扫码登录: {DEFAULT_LOGIN_URL}")
        rc = cmd_login(DEFAULT_LOGIN_URL, state_path, wait_seconds=login_wait)
        if rc != 0:
            return rc

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
        browser = launch_browser(p)
        context = browser.new_context(storage_state=str(state_path))
        page = context.new_page()
        page.goto(url, wait_until="networkidle")
        page.wait_for_timeout(2000)

        if not is_logged_in(page, context):
            print("Login state invalid or expired; starting PC 扫码登录…")
            browser.close()
            rc = cmd_login(DEFAULT_LOGIN_URL, state_path, wait_seconds=login_wait)
            if rc != 0:
                return rc
            browser = launch_browser(p)
            context = browser.new_context(storage_state=str(state_path))
            page = context.new_page()
            page.goto(url, wait_until="networkidle")
            page.wait_for_timeout(2000)
            if not is_logged_in(page, context):
                print("Still not logged in after login flow.")
                browser.close()
                return 2
        try:
            page.wait_for_selector(".exam-content-item .exam-pre", timeout=15000)
        except Exception:
            print("Warning: exam question cards not found yet")

        # Expand sections via answer-card numbers (1..60) so all cards mount.
        aside = page.locator(".exam-content-aside, .exam-content-right")
        for n in (20, 40, 60, 1):
            try:
                target = aside.get_by_text(str(n), exact=True)
                if target.count():
                    target.first.click(timeout=2000)
                    page.wait_for_timeout(800)
            except Exception as e:
                print(f"Sidebar num {n} click skipped: {e}")

        page.evaluate("() => window.scrollTo(0, document.body.scrollHeight)")
        page.wait_for_timeout(600)
        page.evaluate("() => window.scrollTo(0, 0)")
        page.wait_for_timeout(300)

        if dump:
            SCREENSHOT_DIR.mkdir(parents=True, exist_ok=True)
            html_path = SCREENSHOT_DIR / "page.html"
            html_path.write_text(page.content(), encoding="utf-8")
            page.screenshot(path=str(SCREENSHOT_DIR / "page.png"), full_page=True)
            print(f"Dumped DOM -> {html_path}")

        questions = page.evaluate(EXTRACT_QUESTIONS_JS)
        print(f"Detected {len(questions)} question blocks on page")

        filled_keys = set()
        any_questions = bool(questions)
        if not questions:
            print("No questions detected; use --dump to inspect DOM")
            report["unmatched"].append({"stem": "", "best": 0, "second": 0, "reason": "no_questions"})
        else:
            for q in questions:
                page_stem = q.get("stem") or ""
                page_options = q.get("options") or []
                dom_index = q.get("domIndex")
                qkey = (
                    normalize_text(page_stem),
                    tuple(normalize_text(o.get("text", "")) for o in page_options),
                )
                if qkey in filled_keys:
                    continue
                hit = match_stem(
                    page_stem,
                    bank,
                    threshold=threshold,
                    min_gap=0.05,
                    page_option_texts=[o.get("text", "") for o in page_options],
                )
                if hit is None:
                    scored = sorted(
                        ((similarity(page_stem, b.get("stem", "")), b) for b in bank),
                        key=lambda x: x[0],
                        reverse=True,
                    )
                    best = scored[0][0] if scored else 0
                    second = scored[1][0] if len(scored) > 1 else 0
                    bucket = (
                        "ambiguous"
                        if best >= threshold and best - second < 0.05
                        else "unmatched"
                    )
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
                    opt = page_options[i]
                    text = opt["text"]
                    opt_index = opt.get("optIndex", i)
                    if not _click_option_by_text(
                        page,
                        text,
                        dom_index=dom_index,
                        opt_index=opt_index,
                    ):
                        ok_all = False
                    page.wait_for_timeout(120)
                if ok_all:
                    filled_keys.add(qkey)
                    report["filled"].append({"stem": page_stem, "answers": hit["answer_texts"]})
                else:
                    report["option_miss"].append({"stem": page_stem, "want": hit["answer_texts"]})

            # Read progress text for sanity
            try:
                prog = page.evaluate(
                    r"""() => {
                      const t = document.body.innerText || '';
                      const m = t.match(/当前答题\s*\d+\s*\/\s*\d+/) || t.match(/\d+\s*\/\s*60/);
                      return m ? m[0] : '';
                    }"""
                )
                if prog:
                    print(f"Page progress: {prog}")
            except Exception:
                pass

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
                    if not any_questions
                    else "unmatched/ambiguous/option_miss exist"
                )
                print(f"Refuse --submit because {reason}. Use --force-submit to override.")
                # keep browser open for manual review when keep_open
            else:
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
                else:
                    page.wait_for_timeout(1000)

        if keep_open:
            print("填答完成，浏览器保持打开，请核对后手动交卷。")
            print("关闭浏览器窗口结束脚本；或在此终端按 Enter 关闭浏览器。")
            try:
                input()
                if browser.is_connected():
                    browser.close()
            except EOFError:
                while browser.is_connected():
                    time.sleep(1)
        else:
            browser.close()

    return 1 if problems else 0


def _add_exam_entry_args(parser: argparse.ArgumentParser) -> None:
    group = parser.add_mutually_exclusive_group(required=True)
    group.add_argument("--url", help="Exam page URL (will normalize to study questions page when possible)")
    group.add_argument("--qr", help="Path to exam entry QR code image")


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(description="Moxueyuan exam bot")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_login = sub.add_parser(
        "login",
        help=f"Pre-login via PC 扫码登录 (default {DEFAULT_LOGIN_URL})",
    )
    p_login.add_argument(
        "--url",
        default=DEFAULT_LOGIN_URL,
        help=f"Login page URL (default: {DEFAULT_LOGIN_URL})",
    )
    p_login.add_argument("--state", default=str(DEFAULT_STATE))
    p_login.add_argument("--wait", type=int, default=300, help="Max seconds to wait for login")

    p_fill = sub.add_parser("fill", help="Fill answers from answers.json")
    _add_exam_entry_args(p_fill)
    p_fill.add_argument("--answers", default=str(DEFAULT_ANSWERS))
    p_fill.add_argument("--state", default=str(DEFAULT_STATE))
    p_fill.add_argument("--threshold", type=float, default=0.72)
    p_fill.add_argument("--submit", action="store_true")
    p_fill.add_argument("--force-submit", action="store_true")
    p_fill.add_argument("--dump", action="store_true", help="Dump HTML/screenshot for selector tuning")
    p_fill.add_argument(
        "--close",
        action="store_true",
        help="Close browser after fill (default: keep open for review)",
    )
    p_fill.add_argument("--wait", type=int, default=300, help="Max seconds for auto-login fallback")

    args = parser.parse_args(argv)

    if args.cmd == "login":
        login_url = resolve_login_url(getattr(args, "url", None))
        print(f"Login URL -> {login_url}")
        return cmd_login(login_url, Path(args.state), wait_seconds=args.wait)

    if args.cmd == "fill":
        try:
            exam_url = resolve_exam_url(url=getattr(args, "url", None), qr=getattr(args, "qr", None))
        except Exception as e:
            print(f"ERROR: {e}")
            return 2
        return cmd_fill(
            url=exam_url,
            answers_path=Path(args.answers),
            state_path=Path(args.state),
            threshold=args.threshold,
            submit=args.submit,
            force_submit=args.force_submit,
            dump=args.dump,
            keep_open=not args.close,
            login_wait=args.wait,
        )
    return 2


if __name__ == "__main__":
    sys.exit(main())
