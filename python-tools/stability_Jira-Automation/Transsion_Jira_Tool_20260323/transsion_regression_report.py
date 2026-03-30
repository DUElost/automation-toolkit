from __future__ import annotations

from pathlib import Path
from typing import Any, Iterable, Mapping

import pandas as pd


SUMMARY_COLUMNS = [
    "row_number",
    "matched_jira_key",
    "matched_status",
    "matched_resolution",
    "fix_version",
    "action",
    "success",
    "manual_review",
    "reason",
    "old_count",
    "new_count",
    "comment_status",
    "ps_comment_status",
    "result_message",
]


def _normalize_summary_row(row: Mapping[str, Any]) -> dict[str, Any]:
    normalized: dict[str, Any] = {}
    for column in SUMMARY_COLUMNS:
        value = row.get(column, "")
        normalized[column] = "" if value is None else value
    return normalized


def write_excel_summary(output_file: str | Path, rows: Iterable[Mapping[str, Any]]) -> Path:
    target = Path(output_file)
    target.parent.mkdir(parents=True, exist_ok=True)
    payload = [_normalize_summary_row(row) for row in rows]
    pd.DataFrame(payload, columns=SUMMARY_COLUMNS).to_excel(target, index=False, engine="openpyxl")
    return target
