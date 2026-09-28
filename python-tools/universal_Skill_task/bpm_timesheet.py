# -*- coding: utf-8 -*-
"""BPM 工时提报：处理待提报列表后再进入 EHR。"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import date
from typing import List, Optional

from playwright.sync_api import Page, TimeoutError as PlaywrightTimeoutError

from bpm_login import dismiss_bpm_home_overlays
from workday_calendar import should_deduct_half_hour, workday_kind

PORTAL_TAB = "#Shortcutmenu a"
TIMESHEET_LINK = "a[onclick*='WHSubmitView']"
GRID_ID = "WHSubmitViewGrid"
HOURS_DEDUCTION = 0.5
MAX_ITEMS = 30


class TimesheetError(RuntimeError):
    """BPM timesheet navigation or submit failed."""


class TimesheetSkipItem(TimesheetError):
    """One list row should be skipped (e.g. 工作时数 too small)."""


@dataclass(frozen=True)
class TimesheetItem:
    missed_date: str
    emp_no: str = ""
    emp_name: str = ""


@dataclass(frozen=True)
class TimesheetIncompleteItem:
    """One pending date that could not be completed."""

    date: str
    reason: str


@dataclass(frozen=True)
class TimesheetProcessedItem:
    """One successfully filled/submitted timesheet row."""

    date: str
    hours: float
    deduction: float


@dataclass
class TimesheetRunResult:
    processed: List[TimesheetProcessedItem] = field(default_factory=list)
    skipped_empty: bool = False
    incomplete: List[TimesheetIncompleteItem] = field(default_factory=list)
    error_message: Optional[str] = None

    @property
    def skipped_low_hours(self) -> List[str]:
        """Dates skipped because hours were empty or too small after deduction."""
        return [item.date for item in self.incomplete]


def adjusted_work_hours(
    raw_hours: float,
    deduction: float = HOURS_DEDUCTION,
) -> float:
    """Apply lunch/buffer deduction (0 on rest/holiday days)."""
    return round(max(raw_hours - deduction, 0.0), 2)


def hours_adjustment_is_valid(raw_hours: float, deduction: float = HOURS_DEDUCTION) -> bool:
    return adjusted_work_hours(raw_hours, deduction) > 0


def deduction_for_date(day: date) -> float:
    """0.5 on official CN workdays (incl. 补班); 0 on weekends/legal holidays."""
    return HOURS_DEDUCTION if should_deduct_half_hour(day) else 0.0


def open_portal(page: Page) -> None:
    dismiss_bpm_home_overlays(page)
    try:
        page.evaluate("() => App.navTabs.activeModel('Shortcutmenu')")
        page.wait_for_timeout(2_000)
        return
    except Exception:
        pass
    last_exc: Optional[Exception] = None
    for _ in range(3):
        try:
            page.locator(PORTAL_TAB).first.click(timeout=12_000)
            page.wait_for_timeout(2_000)
            return
        except Exception as exc:
            last_exc = exc
            dismiss_bpm_home_overlays(page)
            page.wait_for_timeout(1_000)
    raise TimesheetError(f"Could not click 门户. url={page.url}") from last_exc


def open_timesheet_list(page: Page) -> None:
    """Open 工时提报 list from portal 流程中心 / App.WHSubmitView()."""
    dismiss_bpm_home_overlays(page)
    try:
        open_portal(page)
    except TimesheetError:
        print("[WARN] 门户 click failed; continue with App.WHSubmitView()", flush=True)

    link = page.locator(TIMESHEET_LINK)
    try:
        if link.count() and link.first.is_visible():
            link.first.click(timeout=15_000)
        else:
            page.evaluate("() => App.WHSubmitView()")
    except Exception:
        try:
            page.evaluate("() => App.WHSubmitView()")
        except Exception as exc2:
            raise TimesheetError(f"Could not open 工时提报 list. url={page.url}") from exc2
    page.wait_for_timeout(4_000)
    try:
        page.wait_for_function(
            f"() => !!(window.Ext && Ext.getCmp('{GRID_ID}'))",
            timeout=30_000,
        )
    except PlaywrightTimeoutError as exc:
        raise TimesheetError(f"WHSubmitViewGrid never appeared. url={page.url}") from exc


def list_pending_dates(page: Page) -> List[TimesheetItem]:
    raw = page.evaluate(
        f"""() => {{
          const grid = Ext.getCmp('{GRID_ID}');
          if (!grid || !grid.store) return [];
          const out = [];
          grid.store.each(function (r) {{
            out.push({{
              missed_date: String(r.get('MISSEDDATE') || ''),
              emp_no: String(r.get('EMPNO') || ''),
              emp_name: String(r.get('EMPNAME') || ''),
            }});
          }});
          return out;
        }}"""
    )
    items: List[TimesheetItem] = []
    for row in raw or []:
        date = (row.get("missed_date") or "").strip()
        if date:
            items.append(
                TimesheetItem(
                    missed_date=date,
                    emp_no=(row.get("emp_no") or "").strip(),
                    emp_name=(row.get("emp_name") or "").strip(),
                )
            )
    return items


def _open_row_by_date(page: Page, missed_date: str) -> str:
    result = page.evaluate(
        f"""(date) => {{
          const grid = Ext.getCmp('{GRID_ID}');
          if (!grid || !grid.store) return '';
          const idx = grid.store.find('MISSEDDATE', date);
          if (idx < 0) return '';
          const view = grid.getView();
          const row = view.getRow ? view.getRow(idx) : null;
          const icon = row && row.querySelector
            ? row.querySelector('.m_lc_new')
            : null;
          if (icon) {{
            icon.click();
            return date;
          }}
          App.openWorkHourFlow(null, date);
          return date;
        }}""",
        missed_date,
    )
    if not result:
        raise TimesheetError(f"Could not open timesheet row date={missed_date}")
    page.wait_for_timeout(6_000)
    return str(result)


def _return_to_timesheet_list(page: Page) -> None:
    """Close/leave detail form and show the pending list again."""
    try:
        page.evaluate(
            """() => {
              if (!window.Ext) return;
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  const xt = (c.getXType && c.getXType()) || '';
                  if (xt !== 'tabpanel' || !c.items) return;
                  c.items.each(function (tab) {
                    const title = (tab.title || '') + '';
                    if (/流程启动|项目成员工时/.test(title) && c.remove) {
                      c.remove(tab);
                    }
                  });
                } catch (e) {}
              });
            }"""
        )
    except Exception:
        pass
    open_timesheet_list(page)


def _find_detail_grid_id(page: Page) -> str:
    grid_id = page.evaluate(
        """() => {
          let found = '';
          if (!window.Ext) return found;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (!c.store || !c.colModel) return;
              const idxs = (c.colModel.config || []).map((x) => x.dataIndex);
              if (idxs.includes('workdays') && idxs.includes('taskName')) {
                found = c.id;
              }
            } catch (e) {}
          });
          return found;
        }"""
    )
    if not grid_id:
        raise TimesheetError("Detail grid with workdays/taskName not found")
    return str(grid_id)


def _read_workday_ttl_text(page: Page) -> str:
    value = page.evaluate(
        """() => {
          const el = document.querySelector("input[name='workdayTTL']");
          if (el && el.value != null && String(el.value).trim() !== '') return String(el.value);
          if (!window.Ext) return '';
          let found = '';
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'workdayTTL' && c.getValue) found = String(c.getValue());
            } catch (e) {}
          });
          return found;
        }"""
    )
    return str(value or "").strip()


def _read_workday_ttl(page: Page) -> float:
    text = _read_workday_ttl_text(page)
    if not text or text.lower() in ("undefined", "null", "nan"):
        raise TimesheetSkipItem("工作时数为空")
    try:
        return float(text)
    except ValueError as exc:
        raise TimesheetSkipItem(f"工作时数无法解析: {text!r}") from exc


def _read_workweek_date(page: Page) -> date:
    value = page.evaluate(
        """() => {
          const el = document.querySelector("input[name='workweekDate']");
          if (el && el.value) return el.value;
          if (!window.Ext) return '';
          let found = '';
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'workweekDate' && c.getValue) found = String(c.getValue());
            } catch (e) {}
          });
          return found;
        }"""
    )
    text = str(value or "").strip().replace("/", "-")
    if not text:
        raise TimesheetError("工时日期 (workweekDate) is empty")
    try:
        return date.fromisoformat(text[:10])
    except ValueError as exc:
        raise TimesheetError(f"工时日期 not a date: {text!r}") from exc


def fill_timesheet_detail(
    page: Page,
    reason: str,
    *,
    missed_date: str,
) -> TimesheetProcessedItem:
    """Fill task/hours on the open form; return processed row metadata.

    Deduction calendar uses the list row's missed_date (source of truth), not
    the form workweekDate field which can be stale across successive opens.
    """
    grid_id = _find_detail_grid_id(page)
    raw_hours = _read_workday_ttl(page)
    target = date.fromisoformat(str(missed_date).strip().replace("/", "-")[:10])
    deduction = deduction_for_date(target)
    kind = workday_kind(target)
    if not hours_adjustment_is_valid(raw_hours, deduction):
        raise TimesheetSkipItem(
            f"工作时数过小（{raw_hours}，{kind}减{deduction}后≤0）"
        )
    hours = adjusted_work_hours(raw_hours, deduction)
    task = (reason or "").strip() or "待确认"
    ok = page.evaluate(
        """({gridId, hours, task}) => {
          const grid = Ext.getCmp(gridId);
          if (!grid || !grid.store || grid.store.getCount() < 1) return false;
          const rec = grid.store.getAt(0);
          rec.beginEdit();
          rec.set('taskName', task);
          rec.set('workBehavior', task);
          rec.set('workdays', hours);
          rec.endEdit();
          if (grid.view && grid.view.refresh) grid.view.refresh();
          return String(rec.get('workdays')) === String(hours)
            && String(rec.get('taskName')) === task;
        }""",
        {"gridId": grid_id, "hours": hours, "task": task},
    )
    if not ok:
        raise TimesheetError(
            f"Failed to set workdays={hours} taskName={task!r} on detail grid"
        )
    print(
        f"[OK] timesheet filled date={target.isoformat()} kind={kind} "
        f"workdayTTL={raw_hours} deduct={deduction} -> workdays={hours} task={task!r}",
        flush=True,
    )
    return TimesheetProcessedItem(
        date=target.isoformat(),
        hours=hours,
        deduction=deduction,
    )


def submit_timesheet_detail(page: Page) -> None:
    """Click 同意 and accept confirm dialogs."""
    accepted: List[str] = []

    def accept(dialog) -> None:
        accepted.append(dialog.message or "")
        dialog.accept()

    page.on("dialog", accept)
    try:
        clicked = page.evaluate(
            """() => {
              let target = null;
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  const xt = (c.getXType && c.getXType()) || '';
                  if ((xt === 'button' || xt === 'tbbutton') && c.text === '同意' && !c.hidden) {
                    target = c;
                  }
                } catch (e) {}
              });
              if (!target) return false;
              target.handler ? target.handler.call(target.scope || target, target) : target.el.dom.click();
              return true;
            }"""
        )
        if not clicked:
            page.get_by_role("button", name="同意").first.click(timeout=10_000)
        page.wait_for_timeout(6_000)
    finally:
        page.remove_listener("dialog", accept)

    for message in accepted:
        print(f"[INFO] timesheet dialog: {message}", flush=True)


def _reload_timesheet_list(page: Page) -> None:
    page.wait_for_timeout(2_000)
    try:
        page.wait_for_function(
            f"() => !!(window.Ext && Ext.getCmp('{GRID_ID}') && Ext.getCmp('{GRID_ID}').store)",
            timeout=20_000,
        )
    except PlaywrightTimeoutError:
        open_timesheet_list(page)
    try:
        page.evaluate(
            f"""() => {{
              const grid = Ext.getCmp('{GRID_ID}');
              if (grid && grid.store) grid.store.reload();
            }}"""
        )
        page.wait_for_timeout(2_000)
    except Exception:
        open_timesheet_list(page)


def process_all_timesheets(
    page: Page,
    reason: str,
    *,
    allow_submit: bool,
    max_items: Optional[int] = None,
) -> TimesheetRunResult:
    """Drain 工时提报 pending list: fill each row; submit when allow_submit.

    Empty list → skip the whole step.
    Empty 工作时数 / hours too small after deduction → incomplete with reason.
    max_items limits successful processed rows (None = MAX_ITEMS).
    """
    limit = MAX_ITEMS if max_items is None else max(0, int(max_items))
    result = TimesheetRunResult()
    open_timesheet_list(page)
    pending = list_pending_dates(page)
    if not pending:
        print("[INFO] 工时提报 list empty; skip timesheet step", flush=True)
        result.skipped_empty = True
        return result

    print(
        f"[INFO] 工时提报 pending={len(pending)} dates={[p.missed_date for p in pending]} "
        f"max_items={limit}",
        flush=True,
    )
    skipped_dates: set[str] = set()

    for _ in range(MAX_ITEMS):
        if len(result.processed) >= limit:
            print(
                f"[INFO] timesheet max_items={limit} reached; leave remaining for later",
                flush=True,
            )
            break
        pending = [
            item
            for item in list_pending_dates(page)
            if item.missed_date not in skipped_dates
        ]
        if not pending:
            break

        missed = pending[0].missed_date
        _open_row_by_date(page, missed)
        try:
            filled = fill_timesheet_detail(page, reason, missed_date=missed)
        except TimesheetSkipItem as exc:
            reason_text = str(exc).strip() or "无法完成提报"
            print(f"[WARN] [{missed}] {reason_text}; skip this row", flush=True)
            result.incomplete.append(
                TimesheetIncompleteItem(date=missed, reason=reason_text)
            )
            skipped_dates.add(missed)
            _return_to_timesheet_list(page)
            continue

        if allow_submit:
            submit_timesheet_detail(page)
            _reload_timesheet_list(page)
            print(f"[OK] timesheet submitted date={missed}", flush=True)
        else:
            print(
                f"[INFO] timesheet filled date={missed}; no --ALLOW, stop list drain",
                flush=True,
            )
            result.processed.append(filled)
            return result
        result.processed.append(filled)

    remaining = [
        item.missed_date
        for item in list_pending_dates(page)
        if item.missed_date not in skipped_dates
    ]
    # Intentional early stop via max_items leaves remaining rows — not an error.
    if allow_submit and remaining and len(result.processed) < limit:
        raise TimesheetError(
            f"工时提报 list still has rows after {len(result.processed)} submits: {remaining}"
        )
    return result
