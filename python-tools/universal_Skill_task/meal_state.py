# -*- coding: utf-8 -*-
"""Per-account weekly success marker for BPM overtime-meal booking."""

from __future__ import annotations

import json
from datetime import date, datetime, timezone
from pathlib import Path
from typing import List, Optional, Sequence

DEFAULT_STATE_DIR = Path(__file__).resolve().parent / "artifacts" / "meal_state"


def week_iso_key(day: date) -> str:
    """ISO week key, e.g. 2026-W46."""
    iso = day.isocalendar()
    return f"{iso.year}-W{iso.week:02d}"


def meal_state_path(
    account_id: str,
    day: date,
    *,
    state_dir: Optional[Path] = None,
) -> Path:
    root = Path(state_dir) if state_dir is not None else DEFAULT_STATE_DIR
    safe_id = (account_id or "unknown").strip().replace("/", "_").replace("\\", "_")
    return root / f"{week_iso_key(day)}_{safe_id}.json"


def has_meal_success(
    account_id: str,
    day: date,
    *,
    state_dir: Optional[Path] = None,
) -> bool:
    path = meal_state_path(account_id, day, state_dir=state_dir)
    if not path.is_file():
        return False
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return False
    return bool(data.get("ok")) and data.get("week") == week_iso_key(day)


def mark_meal_success(
    account_id: str,
    day: date,
    submitted_dates: Sequence[str],
    *,
    state_dir: Optional[Path] = None,
) -> Path:
    path = meal_state_path(account_id, day, state_dir=state_dir)
    path.parent.mkdir(parents=True, exist_ok=True)
    payload = {
        "ok": True,
        "week": week_iso_key(day),
        "account_id": account_id,
        "submitted_dates": list(submitted_dates),
        "ok_at": datetime.now(timezone.utc).isoformat(),
    }
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    return path
