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
HOURS_DEDUCTION_OVER_8 = 1.0
HOURS_BAND_THRESHOLD = 8.0
MAX_ITEMS = 30

# Switchable deduction rules (keep "calendar" for rollback).
DEDUCTION_RULE_CALENDAR = "calendar"  # 法定工作日/补班扣 0.5；周末/节假日不扣
DEDUCTION_RULE_HOURS_BAND = "hours_band"  # 工作日&周末：≤8 扣 0.5，>8 扣 1
DEDUCTION_RULE = DEDUCTION_RULE_HOURS_BAND


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
    """Apply lunch/buffer deduction."""
    return round(max(raw_hours - deduction, 0.0), 2)


def hours_adjustment_is_valid(raw_hours: float, deduction: float = HOURS_DEDUCTION) -> bool:
    return adjusted_work_hours(raw_hours, deduction) > 0


def deduction_for_date(day: date) -> float:
    """Legacy calendar rule: 0.5 on official CN workdays (incl. 补班); 0 on weekends/holidays."""
    return HOURS_DEDUCTION if should_deduct_half_hour(day) else 0.0


def deduction_for_hours_band(raw_hours: float) -> float:
    """New rule (workday & weekend alike): ≤8 → 0.5；>8 → 1.0."""
    if float(raw_hours) > HOURS_BAND_THRESHOLD:
        return HOURS_DEDUCTION_OVER_8
    return HOURS_DEDUCTION


def resolve_deduction(
    raw_hours: float,
    day: date,
    *,
    rule: Optional[str] = None,
) -> float:
    """Resolve deduction by active rule; default is DEDUCTION_RULE."""
    active = (rule or DEDUCTION_RULE or "").strip() or DEDUCTION_RULE_HOURS_BAND
    if active == DEDUCTION_RULE_CALENDAR:
        return deduction_for_date(day)
    if active == DEDUCTION_RULE_HOURS_BAND:
        return deduction_for_hours_band(raw_hours)
    raise TimesheetError(f"Unknown timesheet deduction rule: {active!r}")

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


DEFAULT_PROJ_TYPE = "研发项目"


def _read_detail_field(page: Page, grid_id: str, data_index: str) -> str:
    value = page.evaluate(
        """({gridId, dataIndex}) => {
          const grid = Ext.getCmp(gridId);
          if (!grid || !grid.store || grid.store.getCount() < 1) return '';
          return String(grid.store.getAt(0).get(dataIndex) || '');
        }""",
        {"gridId": grid_id, "dataIndex": data_index},
    )
    return str(value or "").strip()


def _read_detail_proj_name(page: Page, grid_id: str) -> str:
    return _read_detail_field(page, grid_id, "projName")


def _select_detail_row(page: Page, grid_id: str) -> None:
    page.evaluate(
        """(gridId) => {
          const grid = Ext.getCmp(gridId);
          if (!grid) return;
          if (grid.stopEditing) { try { grid.stopEditing(false); } catch (e) {} }
          const sm = grid.getSelectionModel();
          if (sm && sm.selectRow) sm.selectRow(0, false);
        }""",
        grid_id,
    )


def _open_detail_selector(page: Page, grid_id: str, data_index: str) -> dict:
    """Select row 0, startEditing the column, click browse trigger."""
    return page.evaluate(
        """({gridId, dataIndex}) => {
          const grid = Ext.getCmp(gridId);
          if (!grid || !grid.store || grid.store.getCount() < 1) {
            return {ok:false, err:'no grid'};
          }
          if (grid.stopEditing) { try { grid.stopEditing(false); } catch (e) {} }
          const sm = grid.getSelectionModel();
          if (sm.selectRow) sm.selectRow(0, false);
          let colIndex = -1;
          (grid.colModel.config || []).forEach((col, i) => {
            if ((col.dataIndex || '') === dataIndex) colIndex = i;
          });
          if (colIndex < 0) return {ok:false, err:'no col', dataIndex: dataIndex};
          grid.startEditing(0, colIndex);
          const field = grid.activeEditor && grid.activeEditor.field;
          if (!field || !field.onTriggerClick) return {ok:false, err:'no trigger'};
          field.onTriggerClick();
          return {
            ok: true,
            selectorKey: field.selectorKey || '',
            selCount: sm.getSelections().length,
          };
        }""",
        {"gridId": grid_id, "dataIndex": data_index},
    )


def _confirm_visible_selector(page: Page) -> bool:
    return bool(
        page.evaluate(
            """() => {
              let clicked = false;
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  if (((c.getXType && c.getXType()) || '') === 'button'
                      && c.text === '确定' && c.isVisible && c.isVisible()) {
                    c.handler ? c.handler.call(c.scope || c, c) : c.el.dom.click();
                    clicked = true;
                  }
                } catch (e) {}
              });
              return clicked;
            }"""
        )
    )


def ensure_timesheet_proj_type(
    page: Page,
    proj_type: str = DEFAULT_PROJ_TYPE,
    *,
    grid_id: Optional[str] = None,
) -> None:
    """Ensure 项目类型 via ProjTypeSel (e.g. 研发项目) before picking project name."""
    target = (proj_type or "").strip() or DEFAULT_PROJ_TYPE
    gid = grid_id or _find_detail_grid_id(page)
    current = _read_detail_field(page, gid, "projType")
    if current == target:
        print(f"[INFO] timesheet projType already {target!r}; skip", flush=True)
        return

    opened = _open_detail_selector(page, gid, "projType")
    if not opened.get("ok"):
        raise TimesheetError(f"Could not open 项目类型 selector: {opened}")

    ready = False
    for _ in range(30):
        ready = bool(
            page.evaluate(
                """() => {
                  let found = false;
                  Ext.ComponentMgr.all.each(function (c) {
                    try {
                      if (!c.store || !c.colModel || c.store.getCount() < 1) return;
                      if (!(c.getSelectionModel)) return;
                      const idxs = (c.colModel.config || []).map((x) => x.dataIndex || '');
                      if (idxs.includes('taskName') && idxs.includes('workdays')) return;
                      const keys = Object.keys((c.store.getAt(0) || {}).data || {});
                      if (keys.includes('list_name') && keys.includes('dic_id')) found = true;
                    } catch (e) {}
                  });
                  return found;
                }"""
            )
        )
        if ready:
            break
        page.wait_for_timeout(400)
    if not ready:
        raise TimesheetError("项目分类选择器 store did not load")

    selected = page.evaluate(
        """(text) => {
          let best = null;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (!(c.getSelectionModel && c.store && c.store.getCount() > 0)) return;
              if (!(c.isVisible && c.isVisible())) return;
              const idxs = (c.colModel.config || []).map((x) => x.dataIndex || '');
              if (idxs.includes('taskName') && idxs.includes('workdays')) return;
              const keys = Object.keys((c.store.getAt(0) || {}).data || {});
              if (keys.includes('list_name') && keys.includes('dic_id')) best = c;
            } catch (e) {}
          });
          if (!best) return {ok:false, err:'no type grid'};
          let hit = null, hitIdx = -1;
          best.store.each(function (rec, i) {
            if (hit) return;
            if (String((rec.data || {}).list_name || '') === text) {
              hit = rec.data; hitIdx = i;
            }
          });
          if (!hit) {
            const samples = [];
            best.store.each(function (rec, i) {
              if (i < 8) samples.push((rec.data || {}).list_name);
            });
            return {ok:false, err:'type not found', samples: samples};
          }
          best.getSelectionModel().selectRow(hitIdx, false);
          try { best.fireEvent('rowdblclick', best, hitIdx); } catch (e) {}
          return {ok:true, gridId: best.id, hit: hit, hitIdx: hitIdx};
        }""",
        target,
    )
    if not selected.get("ok"):
        raise TimesheetError(f"Could not select 项目类型 {target!r}: {selected}")
    _confirm_visible_selector(page)
    page.wait_for_timeout(1_200)
    after = _read_detail_field(page, gid, "projType")
    if after != target:
        raise TimesheetError(
            f"项目类型 select failed: want {target!r} got {after!r}"
        )
    print(f"[OK] timesheet projType selected {target!r}", flush=True)


def select_timesheet_project(
    page: Page,
    project_name: str,
    *,
    grid_id: Optional[str] = None,
    proj_type: str = DEFAULT_PROJ_TYPE,
) -> None:
    """Select 项目类型 then 项目名称 (WHsubmitProjSelector).

    Order required by BPM UI:
      1) 研发项目 (ProjTypeSel)
      2) project name e.g. P535AA (WHsubmitProjSelector)
    Search by title is attempted first; BPM often returns empty for known titles,
    so pagination through the default list is the reliable fallback.
    Selecting a project clears taskName; caller must refill task fields after.
    """
    target = (project_name or "").strip()
    if not target:
        return
    gid = grid_id or _find_detail_grid_id(page)
    _select_detail_row(page, gid)
    ensure_timesheet_proj_type(page, proj_type, grid_id=gid)

    current = _read_detail_proj_name(page, gid)
    if current == target:
        print(f"[INFO] timesheet project already {target!r}; skip name selector", flush=True)
        return

    opened = _open_detail_selector(page, gid, "projName")
    if not opened.get("ok"):
        raise TimesheetError(f"Could not open project selector: {opened}")

    # Wait for project store
    ready = False
    for _ in range(30):
        ready = bool(
            page.evaluate(
                """() => {
                  let found = false;
                  Ext.ComponentMgr.all.each(function (c) {
                    try {
                      if (!c.store || !c.colModel) return;
                      const idxs = (c.colModel.config || []).map((x) => x.dataIndex || '');
                      if (idxs.includes('title') && idxs.includes('proj_id')
                          && c.store.getCount() > 0) found = true;
                    } catch (e) {}
                  });
                  return found;
                }"""
            )
        )
        if ready:
            break
        page.wait_for_timeout(500)
    if not ready:
        raise TimesheetError("Project selector store did not load")

    def _find_in_store() -> dict:
        return page.evaluate(
            """(kw) => {
              let best = null;
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  if (!c.store || !c.colModel || c.store.getCount() < 1) return;
                  const idxs = (c.colModel.config || []).map((x) => x.dataIndex || '');
                  if (idxs.includes('title') && idxs.includes('proj_id')) best = c;
                } catch (e) {}
              });
              if (!best) return {ok:false, err:'no project grid'};
              let hit = null, hitIdx = -1;
              best.store.each(function (rec, i) {
                if (hit) return;
                const title = String((rec.data || {}).title || '');
                if (title === kw) { hit = rec.data; hitIdx = i; }
              });
              return {
                ok: !!hit,
                gridId: best.id,
                hit: hit,
                hitIdx: hitIdx,
                count: best.store.getCount(),
              };
            }""",
            target,
        )

    # Try title search (often empty on BPM; keep as fast path)
    page.evaluate(
        """(kw) => {
          Ext.ComponentMgr.all.each(function (c) {
            try {
              const n = (c.name || '');
              if (n === 'DLQUERY_title' && c.setValue) c.setValue(kw);
              if (n === 'DLQUERY_proj_id' && c.setValue) c.setValue('');
            } catch (e) {}
          });
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (((c.getXType && c.getXType()) || '') === 'button'
                  && ((c.name || '') === 'DLQUERY_WHsubmitProjSelector' || c.text === '查询')) {
                c.handler ? c.handler.call(c.scope || c, c) : c.el.dom.click();
              }
            } catch (e) {}
          });
        }""",
        target,
    )
    page.wait_for_timeout(2_000)
    found = _find_in_store()

    if not found.get("ok"):
        # Clear search and paginate
        page.evaluate(
            """() => {
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  const n = (c.name || '');
                  if ((n === 'DLQUERY_title' || n === 'DLQUERY_proj_id') && c.setValue) {
                    c.setValue('');
                  }
                } catch (e) {}
              });
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  if (((c.getXType && c.getXType()) || '') === 'button'
                      && ((c.name || '') === 'DLQUERY_WHsubmitProjSelector' || c.text === '查询')) {
                    c.handler ? c.handler.call(c.scope || c, c) : c.el.dom.click();
                  }
                } catch (e) {}
              });
            }"""
        )
        page.wait_for_timeout(2_000)
        for page_i in range(25):
            found = _find_in_store()
            if found.get("ok"):
                print(
                    f"[INFO] timesheet project {target!r} found on selector page {page_i}",
                    flush=True,
                )
                break
            moved = page.evaluate(
                """() => {
                  const el = document.querySelector('.x-tbar-page-next:not(.x-item-disabled)');
                  if (!el) return false;
                  el.click();
                  return true;
                }"""
            )
            if not moved:
                break
            page.wait_for_timeout(1_200)

    if not found.get("ok"):
        raise TimesheetError(f"Project {target!r} not found in 工时提报项目选择器")

    confirmed = page.evaluate(
        """({gridId, hitIdx}) => {
          const g = Ext.getCmp(gridId);
          if (!g) return {ok:false, err:'grid gone'};
          g.getSelectionModel().selectRow(hitIdx, false);
          try { g.fireEvent('rowdblclick', g, hitIdx); } catch (e) {}
          let clicked = false;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (((c.getXType && c.getXType()) || '') === 'button'
                  && c.text === '确定' && c.isVisible && c.isVisible()) {
                c.handler ? c.handler.call(c.scope || c, c) : c.el.dom.click();
                clicked = true;
              }
            } catch (e) {}
          });
          return {ok: true, clicked: clicked};
        }""",
        {"gridId": found["gridId"], "hitIdx": found["hitIdx"]},
    )
    page.wait_for_timeout(1_500)
    after = _read_detail_proj_name(page, gid)
    if after != target:
        raise TimesheetError(
            f"Project select failed: want {target!r} got {after!r} confirm={confirmed}"
        )
    print(f"[OK] timesheet project selected {target!r}", flush=True)


def fill_timesheet_detail(
    page: Page,
    reason: str,
    *,
    missed_date: str,
    project: Optional[str] = None,
) -> TimesheetProcessedItem:
    """Fill 项目类型→项目名称→工时/任务 on the open form.

    Deduction calendar uses the list row's missed_date (source of truth), not
    the form workweekDate field which can be stale across successive opens.
    When project is set: 研发项目 → project name (clears taskName) → task/hours.
    """
    grid_id = _find_detail_grid_id(page)
    raw_hours = _read_workday_ttl(page)
    target = date.fromisoformat(str(missed_date).strip().replace("/", "-")[:10])
    deduction = resolve_deduction(raw_hours, target)
    kind = workday_kind(target)
    if not hours_adjustment_is_valid(raw_hours, deduction):
        raise TimesheetSkipItem(
            f"工作时数过小（{raw_hours}，{kind}/{DEDUCTION_RULE}减{deduction}后≤0）"
        )
    hours = adjusted_work_hours(raw_hours, deduction)
    task = (reason or "").strip() or "待确认"
    proj = (project or "").strip() or None
    if proj:
        # 1) 研发项目  2) P535AA  3) 工时+任务详情（下方写入）
        select_timesheet_project(page, proj, grid_id=grid_id)
    ok = page.evaluate(
        """({gridId, hours, task}) => {
          const grid = Ext.getCmp(gridId);
          if (!grid || !grid.store || grid.store.getCount() < 1) return false;
          const rec = grid.store.getAt(0);
          rec.beginEdit();
          rec.set('taskName', task);
          rec.set('workBehavior', task);
          rec.set('workBehavior2', task);
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
    proj_now = _read_detail_proj_name(page, grid_id)
    print(
        f"[OK] timesheet filled date={target.isoformat()} kind={kind} "
        f"workdayTTL={raw_hours} deduct={deduction} -> workdays={hours} "
        f"proj={proj_now!r} task={task!r}",
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
    project: Optional[str] = None,
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
        f"max_items={limit} project={project!r}",
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
            filled = fill_timesheet_detail(
                page, reason, missed_date=missed, project=project
            )
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
