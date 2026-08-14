# EHR 加班申请预填（不提交）Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 在 dry-run 决策为 `APPLY` 时打开 EHR「加班申请」并预填类别/起止/事由，浏览器停住供人工核对，全程禁止提交。

**Architecture:** 独立入口 `main_overtime_prefill.py` 复用登录与决策链路；`ehr_overtime_apply.py` 只负责经首页打开申请页并填写白名单控件；提交类操作由黑名单 + `ALLOW_SUBMIT_OVERTIME=False` 启动校验双重禁止。选择器以实现时探针为准。

**Tech Stack:** Python 3.8+、playwright、pytest、现有 `overtime_decision` / `ehr_nav`

**Spec:** `docs/superpowers/specs/2026-08-14-ehr-overtime-prefill-design.md`

**Work from:** `F:\automation-toolkit\.worktrees\bpm-ehr-login`（分支 `feature/bpm-ehr-login`）

---

## File Structure

| Path | Responsibility |
|------|----------------|
| `python-tools/universal_Skill_task/ehr_overtime_apply.py` | 打开加班申请 + 按 Decision 预填；无 submit API |
| `python-tools/universal_Skill_task/main_overtime_prefill.py` | 预填入口：决策后仅 APPLY 填表，等 Enter |
| `python-tools/universal_Skill_task/ehr_nav.py` | 增补 `open_overtime_apply()` |
| `python-tools/universal_Skill_task/tests/test_ehr_overtime_apply.py` | 类别映射、日期格式、提交黑名单 |
| `python-tools/universal_Skill_task/_probe_overtime_apply.py` | 只读探针：dump 加班申请表单控件 |
| `python-tools/universal_Skill_task/README.md` | 补充 prefill 用法与安全说明 |

工作目录：`python-tools/universal_Skill_task`。Windows 提交用 `git commit -m "..."`（不用 bash heredoc）。

前置：工作区尚有未提交的考勤/加班解析修正（`DD/MM/YYYY` + 卡钟记录），Task 1 先提交，避免与预填混在一起。

---

### Task 1: 提交 dry-run 解析修正（前置）

**Files:**
- Modify (already done, uncommitted): `ehr_attendance.py`, `ehr_overtime_query.py`, `tests/test_ehr_parsers.py`
- Optional: `_probe_ehr_tables.py`（探针脚本，可一并纳入或仍保持本地）

- [ ] **Step 1: 确认测试通过**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login\python-tools\universal_Skill_task
python -m pytest tests -q
```

Expected: 全部 passed（当前应为 19）

- [ ] **Step 2: Commit**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/ehr_attendance.py python-tools/universal_Skill_task/ehr_overtime_query.py python-tools/universal_Skill_task/tests/test_ehr_parsers.py
git commit -m "fix(universal_Skill_task): parse EHR DMY dates and card-clock punches"
```

若需保留探针脚本：

```powershell
git add python-tools/universal_Skill_task/_probe_ehr_tables.py
git commit -m "chore(universal_Skill_task): add EHR table probe helper"
```

---

### Task 2: 预填纯函数 + 提交黑名单（TDD）

**Files:**
- Create: `python-tools/universal_Skill_task/ehr_overtime_apply.py`（先只放纯函数与常量）
- Create: `python-tools/universal_Skill_task/tests/test_ehr_overtime_apply.py`

- [ ] **Step 1: 写失败测试**

```python
# -*- coding: utf-8 -*-
import sys
from datetime import date, time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))

from ehr_overtime_apply import (
    FORBIDDEN_CLICK_TEXTS,
    category_for_day_kind,
    format_ehr_date,
    format_ehr_time,
    is_forbidden_click_text,
)


def test_category_for_day_kind():
    assert category_for_day_kind("weekday") == "平日加班"
    assert category_for_day_kind("weekend") == "周末加班"


def test_format_ehr_date_dmy():
    assert format_ehr_date(date(2026, 8, 13)) == "13/08/2026"


def test_format_ehr_time():
    assert format_ehr_time(time(19, 0)) == "19:00"
    assert format_ehr_time(time(21, 30)) == "21:30"


def test_forbidden_click_texts_cover_submit_intent():
    required = ["提交", "保存", "送审", "确定"]
    for word in required:
        assert any(word in t for t in FORBIDDEN_CLICK_TEXTS), word


def test_is_forbidden_click_text():
    assert is_forbidden_click_text("提交") is True
    assert is_forbidden_click_text("保存申请") is True
    assert is_forbidden_click_text("加班申请") is False
    assert is_forbidden_click_text("首页") is False
```

- [ ] **Step 2: Run test to verify it fails**

```powershell
python -m pytest tests/test_ehr_overtime_apply.py -q
```

Expected: FAIL（模块或符号不存在）

- [ ] **Step 3: 最小实现（仅纯函数，无 Playwright 填表）**

```python
# -*- coding: utf-8 -*-
"""Open EHR 加班申请 and prefill fields. Never submit."""

from __future__ import annotations

from datetime import date, time
from typing import List

FORBIDDEN_CLICK_TEXTS: List[str] = [
    "提交",
    "保存",
    "送审",
    "确定",
    "确认提交",
    "同意提交",
]


def category_for_day_kind(day_kind: str) -> str:
    if day_kind == "weekend":
        return "周末加班"
    return "平日加班"


def format_ehr_date(d: date) -> str:
    return f"{d.day:02d}/{d.month:02d}/{d.year}"


def format_ehr_time(t: time) -> str:
    return t.strftime("%H:%M")


def is_forbidden_click_text(text: str) -> bool:
    s = (text or "").strip()
    if not s:
        return False
    return any(bad in s for bad in FORBIDDEN_CLICK_TEXTS)
```

- [ ] **Step 4: Run tests**

```powershell
python -m pytest tests/test_ehr_overtime_apply.py -q
```

Expected: PASS

- [ ] **Step 5: Commit**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/ehr_overtime_apply.py python-tools/universal_Skill_task/tests/test_ehr_overtime_apply.py
git commit -m "feat(universal_Skill_task): add overtime prefill helpers and submit blacklist"
```

---

### Task 3: ehr_nav 增加「加班申请」

**Files:**
- Modify: `python-tools/universal_Skill_task/ehr_nav.py`

- [ ] **Step 1: 追加常量与函数**

在 `OVERTIME_QUERY_TEXTS` 旁增加：

```python
OVERTIME_APPLY_TEXTS = ["加班申请"]
```

在文件末尾（`wait_ehr_home_ready` 之前或之后均可）增加：

```python
def open_overtime_apply(page: Page) -> None:
    go_home(page)
    page.wait_for_timeout(1_000)
    _click_by_texts(page, OVERTIME_APPLY_TEXTS, "加班申请")
```

- [ ] **Step 2: 冒烟导入**

```powershell
python -c "from ehr_nav import open_overtime_apply; print('ok')"
```

Expected: `ok`

- [ ] **Step 3: Commit**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/ehr_nav.py
git commit -m "feat(universal_Skill_task): navigate to overtime apply via home"
```

---

### Task 4: 加班申请页只读探针脚本

**Files:**
- Create: `python-tools/universal_Skill_task/_probe_overtime_apply.py`

目的：在写填表选择器前，dump 申请页 inputs/selects/buttons（含 iframe）。**禁止点击提交类按钮**。

- [ ] **Step 1: 写探针**

```python
# -*- coding: utf-8 -*-
"""Read-only probe of EHR 加班申请 form controls. Never click submit."""

from __future__ import annotations

from pathlib import Path

from browser import launch_page
from bpm_login import login_bpm
from config import load_config
from ehr_nav import open_overtime_apply, wait_ehr_home_ready
from ehr_overtime_apply import is_forbidden_click_text
from navigate_ehr import open_ehr

ART = Path(__file__).resolve().parent / "artifacts"


def dump_controls(page) -> str:
    lines = [f"url={page.url}", f"title={page.title()}", ""]
    for i, frame in enumerate(page.frames):
        lines.append(f"=== frame[{i}] {frame.url[:160]} ===")
        try:
            info = frame.evaluate(
                """() => {
                  const out = [];
                  const nodes = document.querySelectorAll('input,select,textarea,button,a');
                  for (const el of Array.from(nodes).slice(0, 200)) {
                    out.push({
                      tag: el.tagName,
                      type: el.getAttribute('type') || '',
                      name: el.getAttribute('name') || '',
                      id: el.id || '',
                      value: (el.value || '').slice(0, 40),
                      text: (el.innerText || el.textContent || '').trim().slice(0, 40),
                    });
                  }
                  return out;
                }"""
            )
        except Exception as exc:
            lines.append(f"<err {exc}>")
            continue
        for row in info:
            mark = " FORBIDDEN" if is_forbidden_click_text(row.get("text") or "") else ""
            lines.append(
                f"{row['tag']} type={row['type']!r} name={row['name']!r} "
                f"id={row['id']!r} value={row['value']!r} text={row['text']!r}{mark}"
            )
        lines.append("")
    return "\n".join(lines)


def main() -> None:
    cfg = load_config()
    ART.mkdir(parents=True, exist_ok=True)
    with launch_page() as (_pw, _browser, context, page):
        login_bpm(page, cfg)
        ehr = open_ehr(page, context)
        wait_ehr_home_ready(ehr)
        open_overtime_apply(ehr)
        ehr.wait_for_timeout(5_000)
        text = dump_controls(ehr)
        out = ART / "probe_overtime_apply.txt"
        out.write_text(text, encoding="utf-8")
        ehr.screenshot(path=str(ART / "probe_overtime_apply.png"), full_page=True)
        print(f"wrote {out}", flush=True)
        print("Press Enter to close...", flush=True)
        input()


if __name__ == "__main__":
    main()
```

- [ ] **Step 2: 本机运行（需证书配合）**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login\python-tools\universal_Skill_task
python _probe_overtime_apply.py
```

Expected: 生成 `artifacts/probe_overtime_apply.txt` 与 `.png`；文件中可见类别/日期/时间/事由相关控件；标记 `FORBIDDEN` 的提交按钮**未被点击**。

- [ ] **Step 3: 根据探针结果记下选择器**（写入下一 Task 实现注释中），例如：
  - 类别 select / radio
  - 开始日期、开始时间
  - 结束日期、结束时间
  - 事由 textarea/input

- [ ] **Step 4: Commit 探针脚本**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/_probe_overtime_apply.py
git commit -m "chore(universal_Skill_task): add overtime apply form probe"
```

---

### Task 5: 实现 `prefill_overtime_form`（基于探针选择器）

**Files:**
- Modify: `python-tools/universal_Skill_task/ehr_overtime_apply.py`
- Modify: `python-tools/universal_Skill_task/tests/test_ehr_overtime_apply.py`（可选：映射断言已覆盖）

> 选择器以下方占位为准；**执行本 Task 前必须完成 Task 4 探针**，用真实 `name`/`id` 替换 `TODO_SELECTOR_*` 常量。

- [ ] **Step 1: 扩展模块**

在 `ehr_overtime_apply.py` 追加（选择器换成探针真实值）：

```python
from playwright.sync_api import Frame, Page

from ehr_nav import open_overtime_apply
from overtime_decision import Decision
from overtime_rules import Action

# Replace after Task 4 probe — examples only:
SEL_CATEGORY = "select[name='TODO_CATEGORY']"  # or radio by label
SEL_START_DATE = "input[name='TODO_START_DATE']"
SEL_START_TIME = "input[name='TODO_START_TIME']"
SEL_END_DATE = "input[name='TODO_END_DATE']"
SEL_END_TIME = "input[name='TODO_END_TIME']"
SEL_REASON = "textarea[name='TODO_REASON'], input[name='TODO_REASON']"


class OvertimeApplyError(RuntimeError):
    """Failed to open or prefill overtime apply form."""


def _find_frame_with_selector(page: Page, selector: str) -> Frame:
    for frame in page.frames:
        try:
            if frame.locator(selector).count() > 0:
                return frame
        except Exception:
            continue
    raise OvertimeApplyError(f"Selector not found in any frame: {selector}")


def _fill_first(frame: Frame, selector: str, value: str) -> None:
    loc = frame.locator(selector).first
    loc.wait_for(state="visible", timeout=15_000)
    loc.fill(value)


def prefill_overtime_form(page: Page, decision: Decision) -> None:
    if decision.action != Action.APPLY:
        raise OvertimeApplyError(f"Refuse to prefill when action={decision.action.value}")
    if decision.proposed_start is None or decision.proposed_end is None:
        raise OvertimeApplyError("APPLY decision missing proposed start/end")

    open_overtime_apply(page)
    page.wait_for_timeout(3_000)

    category = category_for_day_kind(decision.day_kind)
    start_date = format_ehr_date(decision.target_date)
    end_date = format_ehr_date(decision.target_date)
    start_time = format_ehr_time(decision.proposed_start)
    end_time = format_ehr_time(decision.proposed_end)
    reason = decision.reason or "待确认"

    # Category: prefer select_option by label; if radio, click label text instead.
    frame = _find_frame_with_selector(page, SEL_CATEGORY)
    cat = frame.locator(SEL_CATEGORY).first
    tag = cat.evaluate("el => el.tagName")
    if tag == "SELECT":
        cat.select_option(label=category)
    else:
        # fallback: click visible text equal to category inside form frame
        frame.get_by_text(category, exact=True).first.click()

    _fill_first(_find_frame_with_selector(page, SEL_START_DATE), SEL_START_DATE, start_date)
    _fill_first(_find_frame_with_selector(page, SEL_START_TIME), SEL_START_TIME, start_time)
    _fill_first(_find_frame_with_selector(page, SEL_END_DATE), SEL_END_DATE, end_date)
    _fill_first(_find_frame_with_selector(page, SEL_END_TIME), SEL_END_TIME, end_time)
    _fill_first(_find_frame_with_selector(page, SEL_REASON), SEL_REASON, reason)

    # Safety: never click anything whose text matches forbidden list.
    # (No submit call exists in this module.)
```

> 若探针显示日期必须经 My97DatePicker 点选：用 `fill` 失败时改为 `click` 输入框 + 填值 + `press('Enter')` 或按日历点选；把实际步骤写进本函数并在 commit message 说明。

- [ ] **Step 2: 导入冒烟**

```powershell
python -c "from ehr_overtime_apply import prefill_overtime_form, FORBIDDEN_CLICK_TEXTS; print(len(FORBIDDEN_CLICK_TEXTS))"
```

- [ ] **Step 3: 单测仍通过**

```powershell
python -m pytest tests/test_ehr_overtime_apply.py tests/test_overtime_decision.py -q
```

Expected: PASS

- [ ] **Step 4: Commit**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/ehr_overtime_apply.py
git commit -m "feat(universal_Skill_task): prefill overtime apply form without submit"
```

---

### Task 6: `main_overtime_prefill.py` 入口

**Files:**
- Create: `python-tools/universal_Skill_task/main_overtime_prefill.py`

- [ ] **Step 1: 写入口**

```python
# -*- coding: utf-8 -*-
"""BPM → EHR → decide → prefill overtime apply (never submit)."""

from __future__ import annotations

import sys
import traceback
from datetime import datetime
from pathlib import Path

from browser import launch_page
from bpm_login import LoginError, login_bpm
from config import ConfigError, load_config
from ehr_attendance import read_punches_for_day
from ehr_nav import EhrNavError, wait_ehr_home_ready
from ehr_overtime_apply import OvertimeApplyError, prefill_overtime_form
from ehr_overtime_query import read_existing_overtime
from navigate_ehr import NavigateEhrError, open_ehr
from overtime_decision import ALLOW_SUBMIT_OVERTIME, build_decision, format_decision
from overtime_rules import Action, target_yesterday

ROOT = Path(__file__).resolve().parent
ARTIFACTS = ROOT / "artifacts"


def _write_log(text: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_decision_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log"
    path.write_text(text + "\n", encoding="utf-8")
    return path


def _screenshot(page, tag: str) -> Path:
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / f"overtime_prefill_{datetime.now().strftime('%Y%m%d_%H%M%S')}_{tag}.png"
    try:
        page.screenshot(path=str(path), full_page=True)
    except Exception:
        page.screenshot(path=str(path))
    return path


def _wait_enter(msg: str) -> None:
    print(msg, flush=True)
    try:
        input()
    except EOFError:
        pass


def main() -> int:
    if ALLOW_SUBMIT_OVERTIME:
        print("[FAIL] ALLOW_SUBMIT_OVERTIME must stay False in prefill phase")
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
            wait_ehr_home_ready(ehr_page)
            print("[OK] EHR home ready")

            punches = read_punches_for_day(ehr_page, target)
            print(f"[OK] punches={punches}")
            existing = read_existing_overtime(ehr_page, target)
            print(f"[OK] existing={existing}")

            decision = build_decision(target, punches, existing)
            text = format_decision(decision)
            print("[DECISION]")
            print(text)
            print(f"[INFO] decision_log={_write_log(text)}")

            if decision.action != Action.APPLY:
                print(f"[INFO] skip prefill because action={decision.action.value}")
                _wait_enter("[INFO] Press Enter to close browser...")
                return 0

            prefill_overtime_form(ehr_page, decision)
            shot = _screenshot(ehr_page, "filled")
            print(f"[OK] prefilled; screenshot={shot}")
            print("[INFO] ALLOW_SUBMIT_OVERTIME=False — did not click submit")
            _wait_enter("[INFO] Review the form, then press Enter to close browser...")
            return 0
        except (LoginError, NavigateEhrError, EhrNavError, OvertimeApplyError) as exc:
            print(f"[FAIL] {exc}")
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'fail')}")
            except Exception:
                pass
            _wait_enter("[INFO] Press Enter to close browser...")
            return 1
        except Exception as exc:
            print(f"[FAIL] unexpected: {exc}")
            traceback.print_exc()
            try:
                print(f"[INFO] screenshot={_screenshot(ehr_page, 'unexpected')}")
            except Exception:
                pass
            _wait_enter("[INFO] Press Enter to close browser...")
            return 1


if __name__ == "__main__":
    sys.exit(main())
```

- [ ] **Step 2: 语法检查**

```powershell
python -m py_compile main_overtime_prefill.py
```

Expected: 无输出、exit 0

- [ ] **Step 3: Commit**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/main_overtime_prefill.py
git commit -m "feat(universal_Skill_task): add overtime prefill entrypoint"
```

---

### Task 7: README

**Files:**
- Modify: `python-tools/universal_Skill_task/README.md`

- [ ] **Step 1: 增加一节**

在 dry-run 说明之后追加：

```markdown
## 加班预填（不提交）

```powershell
python main_overtime_prefill.py
```

行为：

1. 与 dry-run 相同：登录 → 读考勤/加班查询 → 写决策日志
2. 仅当 `action=APPLY` 时打开「加班申请」并预填类别、起止、事由「待确认」
3. **不会**点击提交/保存；`ALLOW_SUBMIT_OVERTIME` 必须为 `False`
4. 预填后浏览器保持打开，终端按 Enter 后退出

人工核对截图：`artifacts/overtime_prefill_*.png`
```

- [ ] **Step 2: Commit**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login
git add python-tools/universal_Skill_task/README.md
git commit -m "docs(universal_Skill_task): document overtime prefill entrypoint"
```

---

### Task 8: 实机预填验收

**Files:** 可能微调 `ehr_overtime_apply.py` 选择器

- [ ] **Step 1: 全量单测**

```powershell
cd F:\automation-toolkit\.worktrees\bpm-ehr-login\python-tools\universal_Skill_task
python -m pytest tests -q
```

Expected: 全部 PASS

- [ ] **Step 2: 实机运行**

```powershell
python main_overtime_prefill.py
```

Expected（昨日若仍为需加班工作日，类似）：

```text
[DECISION]
action=APPLY
proposed_start=19:00
proposed_end=21:00
...
[OK] prefilled; screenshot=...
[INFO] ALLOW_SUBMIT_OVERTIME=False — did not click submit
[INFO] Review the form, then press Enter to close browser...
```

人工核对浏览器：

- 类别 = 平日加班（或周末对应）
- 开始/结束日期时间与决策一致
- 事由 = 待确认
- 未出现提交成功/流程已送审提示

- [ ] **Step 3: 若选择器需微调，改完再测再 commit**

```powershell
git add python-tools/universal_Skill_task/ehr_overtime_apply.py
git commit -m "fix(universal_Skill_task): tune overtime apply form selectors"
```

- [ ] **Step 4: 在本 plan 文件勾选完成项，并在文末追加「Task 8 实测结果」短节（日期、决策、是否预填成功、未提交确认）**

---

## Spec coverage checklist

| Spec 要求 | Task |
|-----------|------|
| 独立入口 + `ehr_overtime_apply` | 5, 6 |
| 仅 APPLY 预填 | 6 |
| 类别平日/周末 | 2, 5 |
| 事由待确认 | 5, 6 |
| 禁止提交 / `ALLOW_SUBMIT_OVERTIME=False` | 2, 5, 6 |
| 经首页导航 | 3, 5 |
| Enter 等待核对 + 截图 | 6 |
| 探针定选择器 | 4, 5, 8 |
| README | 7 |
| 解析器前置修正 | 1 |

---

## Self-review notes

- 无 TBD 步骤；Task 5 的选择器明确要求先跑 Task 4 替换占位常量
- 不实现 submit API；黑名单单测锁定
- 与 dry-run 入口分离，不改 `main_overtime_dry_run.py` 语义
