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
    text = text.lstrip("\ufeff")
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
    text = Path(args.input).read_text(encoding="utf-8-sig")
    items = parse_answers_text(text)
    out = Path(args.output)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(items, ensure_ascii=False, indent=2), encoding="utf-8")
    print(f"Wrote {len(items)} items -> {out}")


if __name__ == "__main__":
    main()
