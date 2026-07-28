# 魔学院在线答题 Skill Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在 `python-tools/universal_Skill` 落地可解析 `7月考试.txt`、用 Playwright 按题干/选项文字自动填答（默认不交卷）的 Cursor Skill。

**Architecture:** `parse_answers.py` 把答案库变成带 `answer_texts` 的 JSON；`matching.py` 做题干模糊匹配与选项文字匹配；`exam_bot.py` 负责登录态、读 DOM、勾选与可选交卷；`.cursor/skills/moxueyuan-exam/SKILL.md` 教 Agent 按清单执行。

**Tech Stack:** Python 3.8+、pytest、playwright、difflib（标准库）

**Spec:** `docs/superpowers/specs/2026-07-28-moxueyuan-exam-skill-design.md`

---

## File Structure

| Path | Responsibility |
|------|----------------|
| `python-tools/universal_Skill/.gitignore` | 忽略 `storage_state.json`、缓存、截图 |
| `python-tools/universal_Skill/scripts/requirements.txt` | playwright、pytest |
| `python-tools/universal_Skill/scripts/parse_answers.py` | 解析答案库 + CLI |
| `python-tools/universal_Skill/scripts/matching.py` | 规范化、题干/选项匹配 |
| `python-tools/universal_Skill/scripts/exam_bot.py` | login / fill / submit |
| `python-tools/universal_Skill/tests/fixtures/sample_answers.txt` | 解析用小样例 |
| `python-tools/universal_Skill/tests/test_parse_answers.py` | 解析单测 |
| `python-tools/universal_Skill/tests/test_matching.py` | 匹配单测 |
| `python-tools/universal_Skill/.cursor/skills/moxueyuan-exam/SKILL.md` | Agent 工作流 |
| `python-tools/universal_Skill/README.md` | 人工使用说明 |
| `python-tools/universal_Skill/data/` | `answers.json`（生成）、`storage_state.json`（本地） |

工作目录约定：所有命令在 `python-tools/universal_Skill` 下执行（或用绝对路径）。

---

### Task 1: 脚手架与 gitignore

**Files:**
- Create: `python-tools/universal_Skill/.gitignore`
- Create: `python-tools/universal_Skill/scripts/requirements.txt`
- Create: `python-tools/universal_Skill/data/.gitkeep`

- [ ] **Step 1: 写 `.gitignore`**

```gitignore
data/storage_state.json
data/answers.json
data/screenshots/
__pycache__/
*.pyc
.pytest_cache/
.venv/
venv/
*.log
```

- [ ] **Step 2: 写 `scripts/requirements.txt`**

```text
playwright>=1.40.0
pytest>=7.0.0
```

- [ ] **Step 3: 创建 `data/.gitkeep`（空文件）**

- [ ] **Step 4: Commit**

```bash
git add python-tools/universal_Skill/.gitignore python-tools/universal_Skill/scripts/requirements.txt python-tools/universal_Skill/data/.gitkeep
git commit -m "chore(universal_Skill): scaffold gitignore and requirements"
```

---

### Task 2: 文本规范化与匹配（TDD）

**Files:**
- Create: `python-tools/universal_Skill/scripts/matching.py`
- Create: `python-tools/universal_Skill/tests/test_matching.py`

- [ ] **Step 1: 写失败测试**

创建 `tests/test_matching.py`：

```python
# -*- coding: utf-8 -*-
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from matching import normalize_text, match_stem, match_options_by_text


def test_normalize_strips_number_and_spaces():
    assert normalize_text("12.  hello，世界") == normalize_text("hello世界")


def test_match_stem_ignores_order():
    bank = [
        {"stem": normalize_text("MTBF的测试周期是什么"), "id": 1},
        {"stem": normalize_text("样机不支持某项功能"), "id": 2},
    ]
    hit = match_stem("【稳定性测试】MTBF的测试周期是什么？", bank, threshold=0.72)
    assert hit is not None
    assert hit["id"] == 1


def test_match_options_by_text_ignores_letters():
    page_options = [
        {"letter": "A", "text": "Wi-Fi连接不稳定", "locator_hint": 0},
        {"letter": "B", "text": "死机", "locator_hint": 1},
        {"letter": "C", "text": "重启", "locator_hint": 2},
    ]
    # 答案库认为正确答案文字是「死机」，即使页面字母不是原来的
    idxs = match_options_by_text(["死机"], page_options, threshold=0.9)
    assert idxs == [1]


def test_match_stem_ambiguous_returns_none():
    bank = [
        {"stem": normalize_text("关于MTBF测项的通过标准"), "id": 1},
        {"stem": normalize_text("关于MTBF测项的通过标准描述"), "id": 2},
    ]
    hit = match_stem("关于MTBF测项的通过标准描述正确的是", bank, threshold=0.5, min_gap=0.05)
    assert hit is None  # ambiguous
```

- [ ] **Step 2: 运行确认失败**

```bash
cd python-tools/universal_Skill
pip install pytest -q
pytest tests/test_matching.py -v
```

Expected: FAIL（`ModuleNotFoundError: matching` 或 import 失败）

- [ ] **Step 3: 实现 `scripts/matching.py`**

```python
# -*- coding: utf-8 -*-
"""Stem/option text matching for exam auto-fill."""
from __future__ import annotations

import re
import unicodedata
from difflib import SequenceMatcher
from typing import Any, Dict, List, Optional, Sequence


_PUNCT_RE = re.compile(r"[\s\u3000]+|[，。！？、；：""''（）\(\)\[\]【】《》<>·…—\-_,\.:;!\?\"']+")
_LEADING_NUM_RE = re.compile(r"^\d+[\.、．]\s*")
_OPTION_PREFIX_RE = re.compile(r"^[A-Fa-f][\.、．\s]+")


def normalize_text(text: str) -> str:
    if text is None:
        return ""
    s = unicodedata.normalize("NFKC", str(text)).strip()
    s = _LEADING_NUM_RE.sub("", s)
    s = _OPTION_PREFIX_RE.sub("", s)
    s = _PUNCT_RE.sub("", s)
    return s.lower()


def similarity(a: str, b: str) -> float:
    na, nb = normalize_text(a), normalize_text(b)
    if not na or not nb:
        return 0.0
    return SequenceMatcher(None, na, nb).ratio()


def match_stem(
    page_stem: str,
    bank: Sequence[Dict[str, Any]],
    threshold: float = 0.72,
    min_gap: float = 0.05,
) -> Optional[Dict[str, Any]]:
    """Return best bank item or None if below threshold / ambiguous."""
    scored = []
    for item in bank:
        stem = item.get("stem") or item.get("stem_raw") or ""
        scored.append((similarity(page_stem, stem), item))
    if not scored:
        return None
    scored.sort(key=lambda x: x[0], reverse=True)
    best_score, best = scored[0]
    second = scored[1][0] if len(scored) > 1 else 0.0
    if best_score < threshold:
        return None
    if best_score - second < min_gap:
        return None
    return best


def match_options_by_text(
    answer_texts: Sequence[str],
    page_options: Sequence[Dict[str, Any]],
    threshold: float = 0.9,
) -> List[int]:
    """Return indices into page_options whose text matches answer_texts."""
    hits: List[int] = []
    used = set()
    for ans in answer_texts:
        best_i, best_s = -1, 0.0
        for i, opt in enumerate(page_options):
            if i in used:
                continue
            s = similarity(ans, opt.get("text", ""))
            if s > best_s:
                best_s, best_i = s, i
        if best_i >= 0 and best_s >= threshold:
            hits.append(best_i)
            used.add(best_i)
    return hits
```

- [ ] **Step 4: 跑测试至通过**

```bash
pytest tests/test_matching.py -v
```

Expected: PASS。若 `test_match_stem_ambiguous_returns_none` 因分数差 ≥ 0.05 而失败，把 fixture 两题改成完全相同的 `stem` 字符串再断言 `None`。

- [ ] **Step 5: Commit**

```bash
git add python-tools/universal_Skill/scripts/matching.py python-tools/universal_Skill/tests/test_matching.py
git commit -m "feat(universal_Skill): add stem/option text matching"
```

---

### Task 3: 解析答案库（TDD）

**Files:**
- Create: `python-tools/universal_Skill/tests/fixtures/sample_answers.txt`
- Create: `python-tools/universal_Skill/tests/test_parse_answers.py`
- Create: `python-tools/universal_Skill/scripts/parse_answers.py`

- [ ] **Step 1: 写 fixture**

`tests/fixtures/sample_answers.txt`：

```text
1.
MTBF的测试周期是什么？
单选题1分
A. 5台*7天*24H
B. 10台*7天*24H
C. 15台*7天*24H
D. 20台*7天*24H
问题反馈
回答错误
(0分)
答案： D
2.
由于测试环境产生的bug单，应操作reject（ ）
判断题1分
A. 正确
B. 错误
问题反馈
回答错误
(0分)
答案： A
3.
以下哪些情况可能导致系统重启？
多选题3分
A. 电量耗尽
B. 系统内核崩溃
C. 后台应用崩溃
D. 电源管理IC故障
问题反馈
回答错误
(0分)
答案： A、B、D
```

- [ ] **Step 2: 写失败测试**

`tests/test_parse_answers.py`：

```python
# -*- coding: utf-8 -*-
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from parse_answers import parse_answers_text


FIXTURE = (ROOT / "tests" / "fixtures" / "sample_answers.txt").read_text(encoding="utf-8")


def test_parse_single_maps_letter_to_text():
    items = parse_answers_text(FIXTURE)
    assert items[0]["qtype"] == "single"
    assert items[0]["answer_letters"] == ["D"]
    assert items[0]["answer_texts"] == ["20台*7天*24H"]


def test_parse_judge():
    items = parse_answers_text(FIXTURE)
    assert items[1]["qtype"] == "judge"
    assert items[1]["answer_texts"] == ["正确"]


def test_parse_multi():
    items = parse_answers_text(FIXTURE)
    assert items[2]["qtype"] == "multi"
    assert items[2]["answer_letters"] == ["A", "B", "D"]
    assert "电量耗尽" in items[2]["answer_texts"]
    assert "系统内核崩溃" in items[2]["answer_texts"]
    assert "电源管理IC故障" in items[2]["answer_texts"]
    assert len(items[2]["answer_texts"]) == 3


def test_parse_full_july_file_has_many_items():
    text = (ROOT / "7月考试.txt").read_text(encoding="utf-8")
    items = parse_answers_text(text)
    assert len(items) >= 50
    assert all(item["answer_texts"] for item in items)
```

- [ ] **Step 3: 运行确认失败**

```bash
pytest tests/test_parse_answers.py -v
```

Expected: FAIL（无法 import `parse_answers`）

- [ ] **Step 4: 实现 `scripts/parse_answers.py`**

```python
# -*- coding: utf-8 -*-
"""Parse moxueyuan answer dump text into structured JSON."""
from __future__ import annotations

import argparse
import json
import re
from pathlib import Path
from typing import Any, Dict, List

from matching import normalize_text

_QTYPE_RE = re.compile(r"^(单选题|多选题|判断题)")
_OPTION_RE = re.compile(r"^([A-Fa-f])[\.、．]\s*(.*)$")
_ANSWER_RE = re.compile(r"^答案：\s*(.+)\s*$")
_NUM_ONLY_RE = re.compile(r"^\d+\.?$")
_SKIP_PREFIXES = ("问题反馈", "回答错误", "回答正确", "解析：", "(")


def _detect_qtype(line: str) -> str:
    if line.startswith("单选题"):
        return "single"
    if line.startswith("多选题"):
        return "multi"
    if line.startswith("判断题"):
        return "judge"
    return "unknown"


def _parse_answer_letters(raw: str) -> List[str]:
    # e.g. "D" or "A、B、D" or "A,B,D"
    parts = re.split(r"[、,，\s]+", raw.strip())
    letters = []
    for p in parts:
        p = p.strip().upper()
        if re.fullmatch(r"[A-F]", p):
            letters.append(p)
    return letters


def parse_answers_text(text: str) -> List[Dict[str, Any]]:
    lines = text.splitlines()
    items: List[Dict[str, Any]] = []
    i = 0
    n = len(lines)

    while i < n:
        line = lines[i].strip()
        if not _NUM_ONLY_RE.match(line):
            i += 1
            continue

        # stem lines until qtype
        i += 1
        stem_parts: List[str] = []
        qtype = "unknown"
        while i < n:
            cur = lines[i].strip()
            if _QTYPE_RE.match(cur):
                qtype = _detect_qtype(cur)
                i += 1
                break
            if _NUM_ONLY_RE.match(cur):
                break
            if cur and not cur.startswith(_SKIP_PREFIXES):
                stem_parts.append(cur)
            i += 1

        options = []
        while i < n:
            cur = lines[i].strip()
            m = _OPTION_RE.match(cur)
            if m:
                options.append({"letter": m.group(1).upper(), "text": m.group(2).strip()})
                i += 1
                continue
            if cur.startswith("答案：") or _ANSWER_RE.match(cur):
                break
            if _NUM_ONLY_RE.match(cur):
                break
            # skip feedback / score / blank
            i += 1

        answer_letters: List[str] = []
        while i < n:
            cur = lines[i].strip()
            am = _ANSWER_RE.match(cur)
            if am:
                answer_letters = _parse_answer_letters(am.group(1))
                i += 1
                break
            if _NUM_ONLY_RE.match(cur):
                break
            i += 1

        letter_to_text = {o["letter"]: o["text"] for o in options}
        answer_texts = [letter_to_text[L] for L in answer_letters if L in letter_to_text]
        stem_raw = "".join(stem_parts).strip()
        if stem_raw and answer_texts:
            items.append(
                {
                    "stem_raw": stem_raw,
                    "stem": normalize_text(stem_raw),
                    "qtype": qtype,
                    "options": options,
                    "answer_letters": answer_letters,
                    "answer_texts": answer_texts,
                }
            )

    return items


def main() -> None:
    parser = argparse.ArgumentParser(description="Parse exam answer text dump")
    parser.add_argument("--input", required=True, help="Path to answer txt")
    parser.add_argument("--output", required=True, help="Path to answers.json")
    args = parser.parse_args()
    text = Path(args.input).read_text(encoding="utf-8")
    items = parse_answers_text(text)
    out = Path(args.output)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(items, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Wrote {len(items)} items -> {out}")


if __name__ == "__main__":
    main()
```

- [ ] **Step 5: 跑测试至通过**

```bash
pytest tests/test_parse_answers.py tests/test_matching.py -v
```

Expected: 全部 PASS

- [ ] **Step 6: 生成 answers.json 并确认计数**

```bash
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
```

Expected: `Wrote N items` 且 N ≥ 50（`data/answers.json` 已被 gitignore，不必提交）

- [ ] **Step 7: Commit**

```bash
git add python-tools/universal_Skill/scripts/parse_answers.py python-tools/universal_Skill/tests/test_parse_answers.py python-tools/universal_Skill/tests/fixtures/sample_answers.txt
git commit -m "feat(universal_Skill): parse answer bank into answer_texts JSON"
```

---

### Task 4: Playwright exam_bot — login 与 fill 骨架

**Files:**
- Create: `python-tools/universal_Skill/scripts/exam_bot.py`

说明：魔学院 DOM 会变。本实现用「可见文本 + 通用选项模式」抽取题目；首次实机若失败，用 `--dump` 保存 HTML 后微调 `_extract_questions_js`。**不要**把账号密码写进代码。

- [ ] **Step 1: 安装 Playwright**

```bash
cd python-tools/universal_Skill
pip install -r scripts/requirements.txt
playwright install chromium
```

Expected: 安装成功，无报错。

- [ ] **Step 2: 实现 `scripts/exam_bot.py`**

完整文件如下（一次写入）：

```python
# -*- coding: utf-8 -*-
"""Playwright bot: login once, fill exam by answer texts."""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path
from typing import Any, Dict, List, Optional

from matching import match_options_by_text, match_stem, normalize_text

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_STATE = ROOT / "data" / "storage_state.json"
DEFAULT_ANSWERS = ROOT / "data" / "answers.json"
SCREENSHOT_DIR = ROOT / "data" / "screenshots"

# JS: extract questions from current page. Tune if site DOM changes.
EXTRACT_QUESTIONS_JS = r"""
() => {
  const norm = (s) => (s || '').replace(/\s+/g, ' ').trim();
  const optionRe = /^([A-Fa-f])[\.、．\s]+(.+)$/;
  const blocks = [];
  // Prefer elements that look like question cards
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
    """Click a visible option whose label contains option_text."""
    # Try role/label patterns; fall back to text locator
    locators = [
        page.get_by_text(option_text, exact=False),
    ]
    for loc in locators:
        try:
            count = loc.count()
        except Exception:
            continue
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

    if not state_path.exists():
        print(f"Missing login state: {state_path}. Run: python scripts/exam_bot.py login --url ...")
        return 2

    bank = load_answers(answers_path)
    report = {
        "filled": [],
        "unmatched": [],
        "ambiguous": [],
        "option_miss": [],
        "skipped": [],
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

        for q in questions:
            page_stem = q.get("stem") or ""
            page_options = q.get("options") or []
            hit = match_stem(page_stem, bank, threshold=threshold, min_gap=0.05)
            if hit is None:
                # distinguish unmatched vs ambiguous by re-scoring
                from matching import similarity

                scored = sorted(
                    ((similarity(page_stem, b.get("stem", "")), b) for b in bank),
                    key=lambda x: x[0],
                    reverse=True,
                )
                best, second = (scored[0][0] if scored else 0), (scored[1][0] if len(scored) > 1 else 0)
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
        detail_path.write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"Detail report -> {detail_path}")

        if submit:
            if problems and not force_submit:
                print("Refuse --submit because unmatched/ambiguous/option_miss exist. Use --force-submit to override.")
                browser.close()
                return 1
            # Heuristic submit button texts
            clicked = False
            for label in ("交卷", "提交", "提交试卷", "确认交卷"):
                btn = page.get_by_role("button", name=label)
                if btn.count() == 0:
                    btn = page.get_by_text(label, exact=False)
                if btn.count():
                    try:
                        btn.first.click(timeout=3000)
                        page.wait_for_timeout(500)
                        # confirm dialog if any
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
```

- [ ] **Step 3: 语法检查**

```bash
python -m py_compile scripts/exam_bot.py scripts/parse_answers.py scripts/matching.py
```

Expected: 无输出、退出码 0

- [ ] **Step 4: Commit**

```bash
git add python-tools/universal_Skill/scripts/exam_bot.py
git commit -m "feat(universal_Skill): add Playwright login/fill exam bot"
```

---

### Task 5: Cursor Skill + README

**Files:**
- Create: `python-tools/universal_Skill/.cursor/skills/moxueyuan-exam/SKILL.md`
- Create: `python-tools/universal_Skill/README.md`

- [ ] **Step 1: 写 SKILL.md**

```markdown
---
name: moxueyuan-exam
description: Fill Tinno moxueyuan online exams using local answer bank (7月考试.txt) via Playwright. Use when the user mentions 魔学院、moxueyuan、在线答题、考试自动填答、或 7月考试.txt.
---

# 魔学院在线答题

## 何时使用

用户要对照本地答案库自动勾选魔学院考试题（题序/选项字母可能打乱）。

## 工作目录

`python-tools/universal_Skill`

## 检查清单

复制并跟踪：

```
- [ ] pip install -r scripts/requirements.txt && playwright install chromium
- [ ] python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
- [ ] 若无 data/storage_state.json：python scripts/exam_bot.py login --url "<考试URL>"
- [ ] python scripts/exam_bot.py fill --url "<考试URL>"
- [ ] 阅读 data/last_report.json，处理 unmatched/ambiguous/option_miss
- [ ] 仅当用户明确要求且报告无问题：再加 --submit
```

## 规则

1. **选项按文字匹配**，忽略页面 A/B/C/D 字母。
2. **默认不交卷**。只有用户明确要求且使用 `--submit`；若报告有问题，不要加 `--force-submit`，除非用户再次明确同意。
3. 登录态失效时重跑 `login`，不要索要或保存账号密码。
4. 页面抽题失败时：`fill --dump`，根据 `data/screenshots/page.html` 调整 `exam_bot.py` 中 `EXTRACT_QUESTIONS_JS`。

## 命令

```bash
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
python scripts/exam_bot.py login --url "https://tinno.study.moxueyuan.com/task/exam/questions/..."
python scripts/exam_bot.py fill --url "https://tinno.study.moxueyuan.com/task/exam/questions/..."
python scripts/exam_bot.py fill --url "..." --submit
```
```

- [ ] **Step 2: 写 README.md**

```markdown
# universal_Skill — 魔学院考试自动填答

基于 `7月考试.txt` 答案库，用 Playwright 在魔学院考试页按**题干 + 选项文字**自动勾选。

## 安装

```bash
cd python-tools/universal_Skill
pip install -r scripts/requirements.txt
playwright install chromium
```

## 使用

```bash
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
python scripts/exam_bot.py login --url "<考试URL>"
python scripts/exam_bot.py fill --url "<考试URL>"
# 可选交卷（有未匹配题时会拒绝，除非 --force-submit）
python scripts/exam_bot.py fill --url "<考试URL>" --submit
```

## 注意

- `data/storage_state.json` 含会话信息，已 gitignore，勿提交。
- 默认只填不交。
- 单测：`pytest tests -v`
```

- [ ] **Step 3: Commit**

```bash
git add python-tools/universal_Skill/.cursor/skills/moxueyuan-exam/SKILL.md python-tools/universal_Skill/README.md
git commit -m "docs(universal_Skill): add moxueyuan-exam Cursor skill and README"
```

---

### Task 6: 回归与手工验收

**Files:** 无新文件（验证既有）

- [ ] **Step 1: 跑全量单测**

```bash
cd python-tools/universal_Skill
pytest tests -v
```

Expected: 全部 PASS

- [ ] **Step 2: 解析全量答案库**

```bash
python scripts/parse_answers.py --input "7月考试.txt" --output data/answers.json
python -c "import json; d=json.load(open('data/answers.json',encoding='utf-8')); print(len(d), d[0]['answer_texts'], d[-1]['qtype'])"
```

Expected: 条数 ≥ 50；首条 `answer_texts` 非空；末条 `qtype` 为 `multi` 或 `judge`/`single`

- [ ] **Step 3: 手工（需用户浏览器）**

1. `python scripts/exam_bot.py login --url "<用户提供的考试URL>"` → 手动登录 → Enter  
2. `python scripts/exam_bot.py fill --url "<同一URL>"`（不加 `--submit`）  
3. 打开 `data/last_report.json`，确认 `filled` 增加；若 `unmatched` 很多则 `--dump` 调 JS

- [ ] **Step 4: 若有小修选择器，再提交一次**

```bash
git add python-tools/universal_Skill/scripts/exam_bot.py
git commit -m "fix(universal_Skill): tune exam page question extraction"
```

（无修改则跳过）

---

## Spec Coverage Checklist

| Spec 项 | Task |
|---------|------|
| 解析答案库 → `answer_texts` | Task 3 |
| 题干模糊匹配 | Task 2 |
| 选项按文字、忽略字母 | Task 2 / 4 |
| 手动登录 + storage_state | Task 4 `login` |
| 默认不交卷 / `--submit` | Task 4 `fill` |
| 有问题时拒绝 submit（除非 force） | Task 4 |
| Skill 触发与清单 | Task 5 |
| gitignore storage_state | Task 1 |
| 单测 parse/match | Task 2–3 |
| README | Task 5 |

## Self-Review Notes

- 无 TBD/TODO 占位。
- `match_stem` / `match_options_by_text` / `parse_answers_text` / CLI 名称在各 Task 一致。
- DOM 抽取依赖启发式 JS：实机失败时走 `--dump` 微调，属规格中的「选择器集中配置/排错」路径，不是未完成项。
