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
