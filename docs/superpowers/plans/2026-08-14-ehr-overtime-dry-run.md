# EHR 加班只读决策 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在进入 EHR 后只读采集昨日打卡与已有加班申请，按已确认规则输出决策日志，全程禁止提交加班申请。

**Architecture:** `overtime_rules` 纯函数承载取整与平日/周末逻辑（单测锁定）；`ehr_nav` / `ehr_attendance` / `ehr_overtime_query` 只负责只读导航与表格解析；`overtime_decision` 组装 Decision；`main_overtime_dry_run` 串联 BPM→EHR→读数→日志。写操作由常量 `ALLOW_SUBMIT_OVERTIME = False` 硬禁止。

**Tech Stack:** Python 3.8+、playwright、pytest、`datetime.timezone(UTC+8)`（不引入 zoneinfo 依赖）

**Spec:** `docs/superpowers/specs/2026-08-14-ehr-overtime-dry-run-design.md`

**Work from:** `F:\automation-toolkit\.worktrees\bpm-ehr-login`（分支 `feature/bpm-ehr-login`）

---

## File Structure

| Path | Responsibility |
|------|----------------|
| `python-tools/universal_Skill_task/overtime_rules.py` | 北京昨天、取整、平日/周末提案、与已有记录比对 |
| `python-tools/universal_Skill_task/overtime_decision.py` | Decision 数据类 + 格式化日志 |
| `python-tools/universal_Skill_task/ehr_nav.py` | 经「首页」跳到考勤/加班查询（禁止 go_back） |
| `python-tools/universal_Skill_task/ehr_attendance.py` | 解析我的考勤 → 目标日打卡时刻列表 |
| `python-tools/universal_Skill_task/ehr_overtime_query.py` | 解析加班查询 → 目标日已有起止 |
| `python-tools/universal_Skill_task/main_overtime_dry_run.py` | 只读入口 |
| `python-tools/universal_Skill_task/tests/test_overtime_rules.py` | 规则单测（已确认例子） |
| `python-tools/universal_Skill_task/tests/test_overtime_decision.py` | Decision 组装/日志格式 |
| `python-tools/universal_Skill_task/README.md` | 补充 dry-run 用法 |

工作目录：`python-tools/universal_Skill_task`。Windows 提交用 `git commit -m "..."`（不用 bash heredoc）。

---

### Task 1: 提交设计文档

**Files:**
- Already created: `docs/superpowers/specs/2026-08-14-ehr-overtime-dry-run-design.md`

- [ ] **Step 1: Commit design**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add docs/superpowers/specs/2026-08-14-ehr-overtime-dry-run-design.md
git commit -m "docs(bpm-ehr): add overtime dry-run decision design"
```

---

### Task 2: overtime_rules（TDD）

**Files:**
- Create: `python-tools/universal_Skill_task/overtime_rules.py`
- Create: `python-tools/universal_Skill_task/tests/test_overtime_rules.py`

- [ ] **Step 1: 写失败测试**

```python
# -*- coding: utf-8 -*-
import sys
from datetime import date, datetime, time, timedelta, timezone
from pathlib import Path

import pytest

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from overtime_rules import (
    Action,
    ExistingOvertime,
    ProposedWindow,
    ceil_half_hour,
    decide_action,
    floor_half_hour,
    is_weekend,
    propose_weekday,
    propose_weekend,
    target_yesterday,
)

BJ = timezone(timedelta(hours=8))


def test_target_yesterday_beijing():
    now = datetime(2026, 8, 14, 16, 0, tzinfo=BJ)
    assert target_yesterday(now) == date(2026, 8, 13)


def test_floor_half_hour_examples():
    assert floor_half_hour(time(21, 3)) == time(21, 0)
    assert floor_half_hour(time(20, 58)) == time(20, 30)
    assert floor_half_hour(time(19, 0)) == time(19, 0)
    assert floor_half_hour(time(19, 20)) == time(19, 0)
    assert floor_half_hour(time(19, 30)) == time(19, 30)
    assert floor_half_hour(time(18, 45)) == time(18, 30)
    assert floor_half_hour(time(18, 1)) == time(18, 0)


def test_ceil_half_hour_examples():
    assert ceil_half_hour(time(9, 0)) == time(9, 0)
    assert ceil_half_hour(time(9, 1)) == time(9, 30)
    assert ceil_half_hour(time(9, 30)) == time(9, 30)
    assert ceil_half_hour(time(9, 31)) == time(10, 0)
    assert ceil_half_hour(time(9, 56)) == time(10, 0)


def test_weekday_no_need_before_19():
    assert propose_weekday([time(18, 40)]) is None


def test_weekday_zero_duration_no_need():
    assert propose_weekday([time(19, 0)]) is None
    assert propose_weekday([time(19, 20)]) is None


def test_weekday_apply_examples():
    assert propose_weekday([time(19, 30)]) == ProposedWindow(time(19, 0), time(19, 30))
    assert propose_weekday([time(20, 58)]) == ProposedWindow(time(19, 0), time(20, 30))
    assert propose_weekday([time(21, 3)]) == ProposedWindow(time(19, 0), time(21, 0))


def test_weekend_examples():
    assert propose_weekend([time(9, 56), time(12, 2)]) == ProposedWindow(time(10, 0), time(12, 0))
    assert propose_weekend([time(9, 56), time(12, 2), time(18, 1)]) == ProposedWindow(time(10, 0), time(18, 0))
    assert propose_weekend([time(9, 56), time(12, 2), time(18, 45)]) == ProposedWindow(time(10, 0), time(18, 0))
    assert propose_weekend([time(9, 56), time(12, 2), time(18, 1), time(21, 3)]) == ProposedWindow(
        time(10, 0), time(20, 0)
    )
    assert propose_weekend([time(10, 0), time(21, 0)]) == ProposedWindow(time(10, 0), time(20, 0))
    assert propose_weekend([time(9, 0), time(17, 30)]) == ProposedWindow(time(9, 0), time(17, 30))


def test_is_weekend():
    assert is_weekend(date(2026, 8, 14)) is False  # Friday
    assert is_weekend(date(2026, 8, 15)) is True   # Saturday
    assert is_weekend(date(2026, 8, 16)) is True   # Sunday


def test_decide_action_paths():
    proposed = ProposedWindow(time(19, 0), time(21, 0))
    assert decide_action(None, None) == (Action.SKIP_NO_NEED, None)
    assert decide_action(proposed, None) == (Action.APPLY, proposed)
    same = ExistingOvertime(time(19, 0), time(21, 0))
    assert decide_action(proposed, same) == (Action.SKIP_ALREADY_SAME, proposed)
    diff = ExistingOvertime(time(19, 0), time(20, 30))
    assert decide_action(proposed, diff) == (Action.SKIP_DIFF_MANUAL, proposed)
```

- [ ] **Step 2: 运行确认失败**

Run: `cd python-tools/universal_Skill_task && pytest tests/test_overtime_rules.py -v`

Expected: FAIL（模块不存在）

- [ ] **Step 3: 写 `overtime_rules.py`**

```python
# -*- coding: utf-8 -*-
"""Pure overtime decision rules (Beijing time). No browser I/O."""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date, datetime, time, timedelta, timezone
from enum import Enum
from typing import List, Optional, Sequence, Tuple

BEIJING = timezone(timedelta(hours=8))
WEEKDAY_START = time(19, 0)
LUNCH_SPAN_NOTE = "若时段跨12:00-13:00，时数由系统自动减1（脚本不填时数）"


class Action(str, Enum):
    APPLY = "APPLY"
    SKIP_NO_NEED = "SKIP_NO_NEED"
    SKIP_ALREADY_SAME = "SKIP_ALREADY_SAME"
    SKIP_DIFF_MANUAL = "SKIP_DIFF_MANUAL"


@dataclass(frozen=True)
class ProposedWindow:
    start: time
    end: time


@dataclass(frozen=True)
class ExistingOvertime:
    start: time
    end: time


def target_yesterday(now: Optional[datetime] = None) -> date:
    """Return yesterday's date in Beijing time."""
    if now is None:
        now = datetime.now(BEIJING)
    elif now.tzinfo is None:
        now = now.replace(tzinfo=BEIJING)
    else:
        now = now.astimezone(BEIJING)
    return (now - timedelta(days=1)).date()


def is_weekend(day: date) -> bool:
    return day.weekday() >= 5  # Sat=5, Sun=6


def floor_half_hour(t: time) -> time:
    if t.minute < 30:
        return time(t.hour, 0)
    return time(t.hour, 30)


def ceil_half_hour(t: time) -> time:
    if t.minute == 0:
        return time(t.hour, 0)
    if t.minute <= 30:
        return time(t.hour, 30)
    # 31–59 → next hour :00
    if t.hour == 23:
        return time(23, 30)  # no next day in same-day overtime model
    return time(t.hour + 1, 0)


def _apply_evening_rules(start: time, end: time) -> time:
    """Weekend end adjustments for the 18:00–19:00 dinner span."""
    # End lands in [18:00, 19:00) → force 18:00
    if time(18, 0) <= end < time(19, 0):
        return time(18, 0)
    # Span crosses 18:00–19:00 → subtract 1 hour from end
    if start < time(18, 0) and end > time(19, 0):
        dt = datetime.combine(date(2000, 1, 1), end) - timedelta(hours=1)
        return dt.time().replace(second=0, microsecond=0)
    return end


def propose_weekday(punches: Sequence[time]) -> Optional[ProposedWindow]:
    if not punches:
        return None
    latest = max(punches)
    if latest < WEEKDAY_START:
        return None
    end = floor_half_hour(latest)
    start = WEEKDAY_START
    if end <= start:
        return None
    return ProposedWindow(start, end)


def propose_weekend(punches: Sequence[time]) -> Optional[ProposedWindow]:
    if not punches:
        return None
    start = ceil_half_hour(min(punches))
    end = floor_half_hour(max(punches))
    end = _apply_evening_rules(start, end)
    if end <= start:
        return None
    return ProposedWindow(start, end)


def propose_for_day(day: date, punches: Sequence[time]) -> Optional[ProposedWindow]:
    if is_weekend(day):
        return propose_weekend(punches)
    return propose_weekday(punches)


def decide_action(
    proposed: Optional[ProposedWindow],
    existing: Optional[ExistingOvertime],
) -> Tuple[Action, Optional[ProposedWindow]]:
    if proposed is None:
        return Action.SKIP_NO_NEED, None
    if existing is None:
        return Action.APPLY, proposed
    if existing.start == proposed.start and existing.end == proposed.end:
        return Action.SKIP_ALREADY_SAME, proposed
    return Action.SKIP_DIFF_MANUAL, proposed


def spans_lunch(start: time, end: time) -> bool:
    return start < time(13, 0) and end > time(12, 0)
```

注意：`ceil_half_hour` 对 `09:01`：`minute <= 30` 且不为 0 → `09:30`；对 `09:30`：`minute == 30` → `09:30`。上面实现里 `if t.minute <= 30` 在 minute==30 时返回 `HH:30`，正确；minute==0 已提前返回。

- [ ] **Step 4: 运行确认通过**

Run: `pytest tests/test_overtime_rules.py -v`

Expected: PASS

- [ ] **Step 5: Commit**

```powershell
git add python-tools/universal_Skill_task/overtime_rules.py python-tools/universal_Skill_task/tests/test_overtime_rules.py
git commit -m "feat(universal_Skill_task): add overtime decision rules with tests"
```

---

### Task 3: overtime_decision（日志组装）

**Files:**
- Create: `python-tools/universal_Skill_task/overtime_decision.py`
- Create: `python-tools/universal_Skill_task/tests/test_overtime_decision.py`

- [ ] **Step 1: 写失败测试**

```python
# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from overtime_decision import build_decision, format_decision
from overtime_rules import ExistingOvertime


def test_build_and_format_apply_weekend():
    punches = [time(9, 56), time(12, 2), time(18, 1), time(21, 3)]
    d = build_decision(date(2026, 8, 15), punches, None)  # Saturday
    text = format_decision(d)
    assert d.action.value == "APPLY"
    assert d.proposed_start == time(10, 0)
    assert d.proposed_end == time(20, 0)
    assert d.reason == "待确认"
    assert "target_date=2026-08-15 (weekend)" in text
    assert "action=APPLY" in text
    assert "proposed_start=10:00" in text
    assert "proposed_end=20:00" in text
    assert "跨18:00-19:00" in text or "notes=" in text


def test_build_skip_already_same():
    punches = [time(21, 3)]
    existing = ExistingOvertime(time(19, 0), time(21, 0))
    d = build_decision(date(2026, 8, 13), punches, existing)  # Wednesday
    assert d.action.value == "SKIP_ALREADY_SAME"
```

- [ ] **Step 2: pytest 确认失败**

- [ ] **Step 3: 写 `overtime_decision.py`**

```python
# -*- coding: utf-8 -*-
"""Assemble and format overtime Decision records."""

from __future__ import annotations

from dataclasses import dataclass
from datetime import date, time
from typing import List, Optional, Sequence

from overtime_rules import (
    LUNCH_SPAN_NOTE,
    Action,
    ExistingOvertime,
    ProposedWindow,
    decide_action,
    is_weekend,
    propose_for_day,
    spans_lunch,
)

ALLOW_SUBMIT_OVERTIME = False  # hard forbid submit in this phase


@dataclass(frozen=True)
class Decision:
    target_date: date
    day_kind: str  # weekday|weekend
    punches: List[time]
    existing: Optional[ExistingOvertime]
    action: Action
    proposed_start: Optional[time]
    proposed_end: Optional[time]
    reason: str
    notes: str


def _fmt_t(t: Optional[time]) -> str:
    return "none" if t is None else t.strftime("%H:%M")


def _fmt_punches(punches: Sequence[time]) -> str:
    if not punches:
        return "[]"
    return "[" + ", ".join(p.strftime("%H:%M") for p in punches) + "]"


def _fmt_existing(existing: Optional[ExistingOvertime]) -> str:
    if existing is None:
        return "none"
    return f"[{existing.start.strftime('%H:%M')}-{existing.end.strftime('%H:%M')}]"


def build_decision(
    target_date: date,
    punches: Sequence[time],
    existing: Optional[ExistingOvertime],
) -> Decision:
    proposed = propose_for_day(target_date, punches)
    action, window = decide_action(proposed, existing)
    notes_parts = []
    if window is not None:
        if is_weekend(target_date) and window.start < time(18, 0) and window.end >= time(20, 0):
            # heuristic note when evening subtract likely applied
            raw_end_hint = max(punches) if punches else None
            if raw_end_hint and raw_end_hint > time(19, 0):
                notes_parts.append("跨18:00-19:00，结束减1小时")
        if spans_lunch(window.start, window.end):
            notes_parts.append(LUNCH_SPAN_NOTE)
    if action == Action.SKIP_DIFF_MANUAL:
        notes_parts.append("已有申请与计算结果不一致，需人工处理")
    if not ALLOW_SUBMIT_OVERTIME:
        notes_parts.append("ALLOW_SUBMIT_OVERTIME=False（本阶段仅日志）")

    return Decision(
        target_date=target_date,
        day_kind="weekend" if is_weekend(target_date) else "weekday",
        punches=list(punches),
        existing=existing,
        action=action,
        proposed_start=None if window is None else window.start,
        proposed_end=None if window is None else window.end,
        reason="待确认",
        notes="; ".join(notes_parts) if notes_parts else "",
    )


def format_decision(d: Decision) -> str:
    lines = [
        f"target_date={d.target_date.isoformat()} ({d.day_kind})",
        f"punches={_fmt_punches(d.punches)}",
        f"existing={_fmt_existing(d.existing)}",
        f"action={d.action.value}",
        f"proposed_start={_fmt_t(d.proposed_start)}",
        f"proposed_end={_fmt_t(d.proposed_end)}",
        f"reason={d.reason}",
        f"notes={d.notes}",
    ]
    return "\n".join(lines)
```

- [ ] **Step 4: pytest 通过并 Commit**

```powershell
pytest tests/test_overtime_decision.py tests/test_overtime_rules.py -v
git add python-tools/universal_Skill_task/overtime_decision.py python-tools/universal_Skill_task/tests/test_overtime_decision.py
git commit -m "feat(universal_Skill_task): add overtime decision log assembler"
```

---

### Task 4: ehr_nav（经首页跳转）

**Files:**
- Create: `python-tools/universal_Skill_task/ehr_nav.py`

选择器以 EHR 首页快捷图标文案为准；Task 7 实测可微调常量。

- [ ] **Step 1: 写 `ehr_nav.py`**

```python
# -*- coding: utf-8 -*-
"""EHR in-app navigation. Always go via 首页; never browser back."""

from __future__ import annotations

from playwright.sync_api import Page, TimeoutError as PlaywrightTimeoutError

HOME_SELECTORS = [
    'a:has-text("首页")',
    'text=首页',
]
ATTENDANCE_SELECTORS = [
    'a:has-text("我的考勤")',
    'text=我的考勤',
]
OVERTIME_QUERY_SELECTORS = [
    'a:has-text("加班查询")',
    'text=加班查询',
]


class EhrNavError(RuntimeError):
    """EHR navigation failed."""


def _click_first(page: Page, selectors: list, what: str) -> None:
    last_exc = None
    for sel in selectors:
        loc = page.locator(sel).first
        try:
            if loc.count() and loc.is_visible():
                loc.click(timeout=15_000)
                page.wait_for_timeout(2_000)
                return
        except Exception as exc:  # noqa: BLE001 — try next selector
            last_exc = exc
            continue
    raise EhrNavError(f"Cannot click {what}. last_error={last_exc} url={page.url}")


def go_home(page: Page) -> None:
    _click_first(page, HOME_SELECTORS, "首页")


def open_my_attendance(page: Page) -> None:
    go_home(page)
    _click_first(page, ATTENDANCE_SELECTORS, "我的考勤")


def open_overtime_query(page: Page) -> None:
    go_home(page)
    _click_first(page, OVERTIME_QUERY_SELECTORS, "加班查询")
```

- [ ] **Step 2: Commit**

```powershell
git add python-tools/universal_Skill_task/ehr_nav.py
git commit -m "feat(universal_Skill_task): add EHR home-based navigation helpers"
```

---

### Task 5: 考勤 / 加班查询解析器（可测的解析 + 页面读取壳）

**Files:**
- Create: `python-tools/universal_Skill_task/ehr_attendance.py`
- Create: `python-tools/universal_Skill_task/ehr_overtime_query.py`
- Create: `python-tools/universal_Skill_task/tests/test_ehr_parsers.py`

表格 DOM 未知时，先实现**纯文本/行解析函数**（单测），页面函数调用导航后把 `body` 内文本交给解析器；Task 7 按实测改正则。

- [ ] **Step 1: 写解析测试**

```python
# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_attendance import parse_punches_from_text
from ehr_overtime_query import parse_existing_overtime_from_text


SAMPLE_ATTENDANCE = """
日期 上班 下班 其它
2026-08-12 09:01 18:20
2026-08-13 09:56 12:02 18:01 21:03
"""


SAMPLE_OVERTIME = """
申请日期 开始 结束 状态
2026-08-14 19:00 21:00 已通过
2026-08-13 10:00 20:00 审批中
"""


def test_parse_punches_for_day():
    punches = parse_punches_from_text(SAMPLE_ATTENDANCE, date(2026, 8, 13))
    assert punches == [time(9, 56), time(12, 2), time(18, 1), time(21, 3)]


def test_parse_existing_overtime():
    existing = parse_existing_overtime_from_text(SAMPLE_OVERTIME, date(2026, 8, 13))
    assert existing is not None
    assert existing.start == time(10, 0)
    assert existing.end == time(20, 0)
```

- [ ] **Step 2: 实现解析器与页面壳**

`ehr_attendance.py`:

```python
# -*- coding: utf-8 -*-
"""Read punch times from EHR 我的考勤 (read-only)."""

from __future__ import annotations

import re
from datetime import date, time
from typing import List

from playwright.sync_api import Page

from ehr_nav import open_my_attendance

_TIME_RE = re.compile(r"\b([01]?\d|2[0-3]):([0-5]\d)\b")
_DATE_RE = re.compile(r"(20\d{2})[-/](\d{1,2})[-/](\d{1,2})")


def parse_punches_from_text(text: str, target: date) -> List[time]:
    """Extract punch times from the line that contains target date.

    Assumes each logical row is one line; times after the date on that line are punches.
    Live DOM may need Task-7 tuning of line splitting.
    """
    target_keys = {
        target.isoformat(),
        f"{target.year}/{target.month}/{target.day}",
        f"{target.year}-{target.month:02d}-{target.day:02d}",
        f"{target.year}/{target.month:02d}/{target.day:02d}",
    }
    punches: List[time] = []
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        if not any(k in line for k in target_keys):
            # also accept Chinese date without zero-pad via regex match
            m = _DATE_RE.search(line)
            if not m:
                continue
            y, mo, d = int(m.group(1)), int(m.group(2)), int(m.group(3))
            if date(y, mo, d) != target:
                continue
        for hm in _TIME_RE.findall(line):
            punches.append(time(int(hm[0]), int(hm[1])))
    return punches


def read_punches_for_day(page: Page, target: date) -> List[time]:
    open_my_attendance(page)
    page.wait_for_timeout(2_000)
    text = page.inner_text("body")
    return parse_punches_from_text(text, target)
```

`ehr_overtime_query.py`:

```python
# -*- coding: utf-8 -*-
"""Read existing overtime applications from EHR 加班查询 (read-only)."""

from __future__ import annotations

import re
from datetime import date, time
from typing import Optional

from playwright.sync_api import Page

from ehr_nav import open_overtime_query
from overtime_rules import ExistingOvertime

_TIME_RE = re.compile(r"\b([01]?\d|2[0-3]):([0-5]\d)\b")
_DATE_RE = re.compile(r"(20\d{2})[-/](\d{1,2})[-/](\d{1,2})")


def parse_existing_overtime_from_text(text: str, target: date) -> Optional[ExistingOvertime]:
    """Return the first matching row's start/end for target date (list is newest-first)."""
    for raw in text.splitlines():
        line = raw.strip()
        if not line:
            continue
        m = _DATE_RE.search(line)
        if not m:
            continue
        y, mo, d = int(m.group(1)), int(m.group(2)), int(m.group(3))
        if date(y, mo, d) != target:
            continue
        times = [time(int(h), int(mi)) for h, mi in _TIME_RE.findall(line)]
        if len(times) >= 2:
            return ExistingOvertime(times[0], times[1])
    return None


def read_existing_overtime(page: Page, target: date) -> Optional[ExistingOvertime]:
    open_overtime_query(page)
    page.wait_for_timeout(2_000)
    text = page.inner_text("body")
    return parse_existing_overtime_from_text(text, target)
```

- [ ] **Step 3: pytest + Commit**

```powershell
pytest tests/test_ehr_parsers.py -v
git add python-tools/universal_Skill_task/ehr_attendance.py python-tools/universal_Skill_task/ehr_overtime_query.py python-tools/universal_Skill_task/tests/test_ehr_parsers.py
git commit -m "feat(universal_Skill_task): add read-only attendance and overtime parsers"
```

---

### Task 6: main_overtime_dry_run + README

**Files:**
- Create: `python-tools/universal_Skill_task/main_overtime_dry_run.py`
- Modify: `python-tools/universal_Skill_task/README.md`

- [ ] **Step 1: 写入口**

```python
# -*- coding: utf-8 -*-
"""BPM → EHR → read punches/overtime → decision log only (no submit)."""

from __future__ import annotations

import sys
import time
import traceback
from datetime import datetime
from pathlib import Path

from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import ConfigError, load_config
from ehr_attendance import read_punches_for_day
from ehr_nav import EhrNavError
from ehr_overtime_query import read_existing_overtime
from navigate_ehr import NavigateEhrError, open_ehr
from overtime_decision import ALLOW_SUBMIT_OVERTIME, build_decision, format_decision
from overtime_rules import target_yesterday

ROOT = Path(__file__).resolve().parent
ARTIFACTS = ROOT / "artifacts"


def _write_log(text: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_decision_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
    path.write_text(text + "\n", encoding="utf-8")
    return path


def _screenshot(page, tag: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"{datetime.now().strftime('%Y%m%d_%H%M%S')}_{tag}.png"
    try:
        page.screenshot(path=str(path), full_page=True)
    except Exception:
        page.screenshot(path=str(path))
    return path


def main() -> int:
    if ALLOW_SUBMIT_OVERTIME:
        print("[FAIL] ALLOW_SUBMIT_OVERTIME must stay False in dry-run phase")
        return 3

    try:
        cfg = load_config()
    except ConfigError as exc:
        print(f"[FAIL] config: {exc}")
        return 2

    target = target_yesterday()
    print(f"[INFO] target_date(Beijing yesterday)={target.isoformat()}")

    with launch_page() as (_pw, _browser, context, page):
        ehr_page = page
        try:
            login_bpm(page, cfg)
            print(f"[OK] BPM login url={page.url}")
            ehr_page = open_ehr(page, context)
            print(f"[OK] EHR opened url={ehr_page.url}")

            punches = read_punches_for_day(ehr_page, target)
            print(f"[OK] punches={punches}")
            existing = read_existing_overtime(ehr_page, target)
            print(f"[OK] existing={existing}")

            decision = build_decision(target, punches, existing)
            text = format_decision(decision)
            print("[DECISION]")
            print(text)
            log_path = _write_log(text)
            print(f"[INFO] decision_log={log_path}")

            print(f"[INFO] keep browser open {cfg.keep_open_seconds}s")
            time.sleep(cfg.keep_open_seconds)
            return 0
        except (LoginError, NavigateEhrError, EhrNavError) as exc:
            print(f"[FAIL] {exc}")
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'fail')}")
            except Exception:
                pass
            return 1
        except Exception as exc:
            print(f"[FAIL] unexpected: {exc}")
            traceback.print_exc()
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'unexpected')}")
            except Exception:
                pass
            return 1


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 2: README 追加章节**

在 `README.md` 末尾追加：

```markdown
## 加班只读决策（dry-run）

```powershell
python main_overtime_dry_run.py
```

流程：登录 BPM → 进 EHR → 我的考勤（昨日打卡）→ 首页 → 加班查询 → 输出决策日志到控制台与 `artifacts/overtime_decision_*.log`。

**禁止提交加班申请。** 代码内 `ALLOW_SUBMIT_OVERTIME=False`。
```

- [ ] **Step 3: Commit**

```powershell
git add python-tools/universal_Skill_task/main_overtime_dry_run.py python-tools/universal_Skill_task/README.md
git commit -m "feat(universal_Skill_task): add overtime dry-run entrypoint"
```

---

### Task 7: 实机只读探针与选择器/解析微调

**Files (可能修改):**
- `ehr_nav.py`, `ehr_attendance.py`, `ehr_overtime_query.py`

**硬规则：** 禁止点击「加班申请」提交/保存；若误进申请页立即离开并记日志。

- [ ] **Step 1: 运行**

```powershell
cd python-tools\universal_Skill_task
python main_overtime_dry_run.py
```

Expected: 打印 `[DECISION]` 块并生成 log；`action` 为四种之一。

- [ ] **Step 2: 若解析为空或导航失败**

1. 截图 `artifacts/*`
2. 必要时临时加探针把 `body` 文本写入 `artifacts/attendance_raw.txt` / `overtime_raw.txt`（只读）
3. 仅调整选择器或 `parse_*_from_text` 正则/行规则
4. 重跑直到打卡与已有申请解析正确

- [ ] **Step 3: 回归单测**

```powershell
pytest tests -v
```

Expected: 全部 PASS

- [ ] **Step 4: Commit 微调（勿提交 .env）**

```powershell
git status
git add python-tools/universal_Skill_task/ehr_nav.py python-tools/universal_Skill_task/ehr_attendance.py python-tools/universal_Skill_task/ehr_overtime_query.py
git commit -m "fix(universal_Skill_task): tune EHR read-only parsers after live probe"
```

若无需改文件则跳过 commit。

---

## Spec coverage（自检）

| Spec 要求 | Task |
|-----------|------|
| 北京时间昨天 | 2 |
| 读我的考勤 / 加班查询 | 4, 5, 7 |
| 经首页跳转、禁 go_back | 4 |
| 平日/周末规则与例子 | 2 |
| 已有申请比对三种跳过/申请 | 2, 3 |
| Decision 日志字段 | 3, 6 |
| 禁止提交 | 3 (`ALLOW_SUBMIT_OVERTIME`), 6, 7 |
| 事由待确认 | 3 |

## Placeholder scan

无 TBD；DOM 微调明确落在 Task 7。

## Type consistency

- `ProposedWindow` / `ExistingOvertime` / `Action` / `Decision`
- `read_punches_for_day(page, date) -> List[time]`
- `read_existing_overtime(page, date) -> Optional[ExistingOvertime]`
- `build_decision` / `format_decision`
