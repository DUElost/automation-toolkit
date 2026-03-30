from __future__ import annotations

import re
from difflib import SequenceMatcher
from typing import Any, Dict, Sequence

from transsion_batch_jira_common import clean_cell_value
from transsion_regression_models import EXPECTED_REQUIRED_EXACT_FIELDS

_LINE_NUMBER_RE = re.compile(r":\d+")
_ADDRESS_RE = re.compile(r"0x[0-9a-fA-F]+")
_WHITESPACE_RE = re.compile(r"\s+")


def normalize_caused_by(text: str) -> str:
    text = str(clean_cell_value(text) or "").strip()
    if not text:
        return ""

    text = _ADDRESS_RE.sub("", text)
    text = _LINE_NUMBER_RE.sub("", text)
    text = _WHITESPACE_RE.sub(" ", text)
    return text.strip()


def _normalized_text(value: Any) -> str:
    return str(clean_cell_value(value) or "").strip()


def is_strong_match(
    current: Dict[str, Any],
    history: Dict[str, Any],
    cause_threshold: float,
    exact_fields: Sequence[str] = EXPECTED_REQUIRED_EXACT_FIELDS,
) -> bool:
    for field_name in exact_fields:
        if _normalized_text(current.get(field_name)) != _normalized_text(history.get(field_name)):
            return False

    try:
        similarity_threshold = float(cause_threshold)
    except (TypeError, ValueError):
        similarity_threshold = 0.9

    current_caused_by = normalize_caused_by(current.get("caused_by", ""))
    history_caused_by = normalize_caused_by(history.get("caused_by", ""))
    if not current_caused_by or not history_caused_by:
        return False
    similarity = SequenceMatcher(None, current_caused_by, history_caused_by).ratio()
    return similarity >= similarity_threshold
