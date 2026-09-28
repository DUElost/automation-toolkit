# -*- coding: utf-8 -*-
"""BPM 工作日加班餐申请：仅周一触发，一次可多选就餐日期。"""

from __future__ import annotations

from dataclasses import dataclass, field
from datetime import date
from typing import List, Optional, Sequence

from playwright.sync_api import Page

from bpm_timesheet import open_portal
from workday_calendar import overtime_meal_dates_for_week

FLOW_ID = 1550
FLOW_NAME = "加班餐预订流程"


class OvertimeMealError(RuntimeError):
    """加班餐导航或提交失败。"""


@dataclass(frozen=True)
class OvertimeMealProcessedItem:
    date: str


@dataclass
class OvertimeMealRunResult:
    processed: List[OvertimeMealProcessedItem] = field(default_factory=list)
    skipped_not_monday: bool = False
    skipped_no_eligible: bool = False
    step_skipped: bool = False
    error_message: Optional[str] = None


def should_run_overtime_meal(today: Optional[date] = None) -> bool:
    """Only Mondays trigger the overtime-meal step."""
    day = today or date.today()
    return day.weekday() == 0


def open_overtime_meal_form(page: Page) -> None:
    """门户后打开「加班餐预订流程」启动页。"""
    open_portal(page)
    page.wait_for_timeout(800)
    try:
        page.evaluate(
            "() => App.navTabs && App.navTabs.activeModel && "
            "App.navTabs.activeModel('NewProcessViewNew')"
        )
        page.wait_for_timeout(1_000)
    except Exception:
        pass

    opened = page.evaluate(
        f"""() => {{
          if (window.ProDefinitionView && ProDefinitionView.newFlow) {{
            ProDefinitionView.newFlow({FLOW_ID}, '{FLOW_NAME}');
            return 'newFlow';
          }}
          const link = Array.from(document.querySelectorAll('a'))
            .find((a) => ((a.innerText || '') + '').includes('{FLOW_NAME}')
              && (a.getAttribute('onclick') || '').includes('newFlow'));
          if (link) {{ link.click(); return 'link'; }}
          return '';
        }}"""
    )
    if not opened:
        raise OvertimeMealError(f"Cannot open {FLOW_NAME}")
    page.wait_for_timeout(4_000)
    ready = page.evaluate(
        """() => {
          let ok = false;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'dateSel') ok = true;
            } catch (e) {}
          });
          return ok;
        }"""
    )
    if not ready:
        raise OvertimeMealError(f"{FLOW_NAME} form did not load (dateSel missing)")


def _open_date_picker(page: Page) -> None:
    page.evaluate(
        """() => {
          let target = null;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'dateSel' && c.onTriggerClick && !c.hidden) target = c;
            } catch (e) {}
          });
          if (!target) throw new Error('dateSel trigger missing');
          target.onTriggerClick();
        }"""
    )
    page.wait_for_timeout(2_000)


def _click_ext_button(page: Page, text: str) -> None:
    clicked = page.evaluate(
        """(label) => {
          let btn = null;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              const xt = (c.getXType && c.getXType()) || '';
              if ((xt === 'button' || xt === 'tbbutton') && c.text === label && !c.hidden) {
                btn = c;
              }
            } catch (e) {}
          });
          if (!btn) return false;
          btn.handler ? btn.handler.call(btn.scope || btn, btn) : btn.el.dom.click();
          return true;
        }""",
        text,
    )
    if not clicked:
        page.get_by_role("button", name=text).first.click(timeout=10_000)
    page.wait_for_timeout(1_500)


def select_meal_dates(page: Page, days: Sequence[date]) -> List[str]:
    """Open 订餐日期选择器, multi-select eligible ISO dates, confirm."""
    want = [d.isoformat() for d in days]
    if not want:
        return []
    _open_date_picker(page)
    result = page.evaluate(
        """(wantDates) => {
          const grids = [];
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (!(c.getSelectionModel && typeof c.getSelectionModel === 'function')) return;
              if (!c.store || c.store.getCount() < 1) return;
              const rec0 = c.store.getAt(0).data || {};
              if (!rec0.dstr && !/20\\d{2}-\\d{2}-\\d{2}/.test(JSON.stringify(rec0))) return;
              grids.push({id: c.id, count: c.store.getCount()});
            } catch (e) {}
          });
          grids.sort((a, b) => b.count - a.count);
          if (!grids.length) return {ok: false, err: 'no date grid'};
          const grid = Ext.getCmp(grids[0].id);
          const sm = grid.getSelectionModel();
          if (sm.clearSelections) sm.clearSelections();
          const selected = [];
          grid.store.each(function (rec) {
            const data = rec.data || {};
            let dateVal = String(data.dstr || '');
            if (!dateVal) {
              for (const k of Object.keys(data)) {
                const v = String(data[k] || '');
                if (/^20\\d{2}-\\d{2}-\\d{2}/.test(v)) { dateVal = v.slice(0, 10); break; }
              }
            }
            dateVal = dateVal.slice(0, 10);
            if (!wantDates.includes(dateVal)) return;
            const idx = grid.store.indexOf(rec);
            if (sm.selectRow) sm.selectRow(idx, true);
            else if (sm.selectRecords) sm.selectRecords([rec], true);
            selected.push(dateVal);
          });
          return {ok: true, selected};
        }""",
        want,
    )
    if not result.get("ok"):
        raise OvertimeMealError(f"Meal date grid not found: {result}")
    selected = list(result.get("selected") or [])
    missing = [d for d in want if d not in selected]
    if missing:
        raise OvertimeMealError(
            f"Eligible dates not available in picker: {missing}; got={selected}"
        )
    _click_ext_button(page, "确定")
    page.wait_for_timeout(1_000)
    # Verify hidden dateSel contains all selected.
    values = page.evaluate(
        """() => {
          const vals = [];
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'dateSel' && c.getValue) {
                const v = String(c.getValue() || '').trim();
                if (v) vals.push(v);
              }
            } catch (e) {}
          });
          return vals;
        }"""
    )
    joined = ",".join(values)
    for day in selected:
        if day not in joined:
            raise OvertimeMealError(
                f"dateSel missing {day} after confirm; values={values}"
            )
    return selected


def select_booker_by_email(page: Page, email: str) -> str:
    """Open 预订人 selector, search by email/account, confirm selection."""
    email = (email or "").strip()
    if not email:
        raise OvertimeMealError("Booker email is empty")

    prefilled = page.evaluate(
        """() => {
          let name = '';
          let uid = '';
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'yongCanPerson' && c.getValue) {
                const v = String(c.getValue() || '').trim();
                if (v) name = v;
              }
              if (c.name === 'yongCanPersonUId' && c.getValue) {
                uid = String(c.getValue() || '').trim();
              }
            } catch (e) {}
          });
          return {name, uid};
        }"""
    )

    page.evaluate(
        """() => {
          let target = null;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'yongCanPerson' && c.onTriggerClick && !c.hidden) target = c;
            } catch (e) {}
          });
          if (!target) throw new Error('yongCanPerson trigger missing');
          target.onTriggerClick();
        }"""
    )
    page.wait_for_timeout(2_000)

    page.evaluate(
        """(email) => {
          const field = Ext.getCmp('SysUserSelector_UserName');
          if (field && field.setValue) {
            field.setValue(email);
            if (field.fireEvent) field.fireEvent('specialkey', field, {getKey: () => 13});
            return true;
          }
          let fallback = null;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              const name = (c.name || '') + '';
              const fl = (c.fieldLabel || '') + '';
              if (c.hidden) return;
              if (name === 'Q_realName_S_LK' || /邮箱|工号|姓名|账号/.test(fl)) fallback = c;
            } catch (e) {}
          });
          if (!fallback || !fallback.setValue) return false;
          fallback.setValue(email);
          return true;
        }""",
        email,
    )
    page.wait_for_timeout(400)
    page.evaluate(
        """() => {
          let btn = null;
          Ext.ComponentMgr.all.each(function (c) {
            try {
              const xt = (c.getXType && c.getXType()) || '';
              if ((xt === 'button' || xt === 'tbbutton')
                  && (c.text === '查找' || c.text === '查询')
                  && !c.hidden) {
                btn = c;
              }
            } catch (e) {}
          });
          if (btn) {
            btn.handler ? btn.handler.call(btn.scope || btn, btn) : btn.el.dom.click();
            return true;
          }
          // Magnifier next to SysUserSelector_UserName
          const field = Ext.getCmp('SysUserSelector_UserName');
          if (field && field.onTriggerClick) {
            field.onTriggerClick();
            return true;
          }
          return false;
        }"""
    )
    page.wait_for_timeout(2_000)

    prefer_name = str(prefilled.get("name") or "").strip()
    selected = page.evaluate(
        """({email, preferName}) => {
          const needle = (email || '').toLowerCase();
          const local = needle.split('@')[0];
          const grids = [];
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (!(c.getSelectionModel && typeof c.getSelectionModel === 'function')) return;
              if (!c.store || c.store.getCount() < 1) return;
              const rec0 = c.store.getAt(0).data || {};
              if (rec0.userId == null && rec0.realName == null) return;
              // Skip the tiny '已选择' panel when a larger candidate grid exists.
              grids.push(c);
            } catch (e) {}
          });
          grids.sort((a, b) => b.store.getCount() - a.store.getCount());
          if (!grids.length) return {ok: false, err: 'no user grid'};
          const best = grids[0];
          const sm = best.getSelectionModel();
          if (sm.clearSelections) sm.clearSelections();

          function pick(rec) {
            const data = rec.data || {};
            const idx = best.store.indexOf(rec);
            if (sm.selectRow) sm.selectRow(idx, false);
            else if (sm.selectRecords) sm.selectRecords([rec], false);
            return {userId: data.userId, realName: String(data.realName || '')};
          }

          let hit = null;
          // 1) Prefer exact realName match with form prefill.
          if (preferName) {
            best.store.each(function (rec) {
              if (hit) return;
              if (String(rec.data.realName || '') === preferName) hit = pick(rec);
            });
          }
          // 2) Email / local-part blob match.
          if (!hit) {
            best.store.each(function (rec) {
              if (hit) return;
              const data = rec.data || {};
              const blob = JSON.stringify(data).toLowerCase();
              if (blob.includes(needle) || (local && blob.includes(local))) hit = pick(rec);
            });
          }
          // 3) Single filtered row.
          if (!hit && best.store.getCount() === 1) hit = pick(best.store.getAt(0));
          if (!hit) return {ok: false, err: 'no matching user', count: best.store.getCount()};
          return {ok: true, hit};
        }""",
        {"email": email, "preferName": prefer_name},
    )

    if not selected.get("ok"):
        # Keep dialog selection if 已选择 already has the prefilled booker.
        kept = page.evaluate(
            """() => {
              let keptName = '';
              Ext.ComponentMgr.all.each(function (c) {
                try {
                  if (!(c.store && c.store.getCount && c.store.getCount() === 1)) return;
                  const title = ((c.title || '') + '');
                  const rec = c.store.getAt(0).data || {};
                  if (rec.realName && (title.includes('已选择') || rec.unremoveable != null)) {
                    keptName = String(rec.realName);
                  }
                } catch (e) {}
              });
              return keptName;
            }"""
        )
        if not kept and not prefilled.get("name"):
            raise OvertimeMealError(
                f"Booker not found for {email!r}: {selected}"
            )
        print(
            f"[WARN] 加班餐 booker search miss for {email!r}; "
            f"keep prefilled/selected={kept or prefilled.get('name')!r}",
            flush=True,
        )
    _click_ext_button(page, "确定")
    page.wait_for_timeout(1_000)

    current = page.evaluate(
        """() => {
          let name = '';
          let uid = '';
          Ext.ComponentMgr.all.each(function (c) {
            try {
              if (c.name === 'yongCanPerson' && c.getValue) {
                const v = String(c.getValue() || '').trim();
                if (v) name = v;
              }
              if (c.name === 'yongCanPersonUId' && c.getValue) {
                uid = String(c.getValue() || '').trim();
              }
            } catch (e) {}
          });
          return {name, uid};
        }"""
    )
    if not current.get("name") and not current.get("uid"):
        raise OvertimeMealError("预订人 empty after confirm")
    return str(current.get("name") or email)


def submit_overtime_meal(page: Page) -> None:
    """Click 同意 and accept browser confirm dialogs."""
    accepted: List[str] = []

    def accept(dialog) -> None:
        accepted.append(dialog.message or "")
        dialog.accept()

    page.on("dialog", accept)
    try:
        _click_ext_button(page, "同意")
        page.wait_for_timeout(5_000)
    finally:
        page.remove_listener("dialog", accept)
    for message in accepted:
        print(f"[INFO] overtime-meal dialog: {message}", flush=True)


def process_overtime_meal(
    page: Page,
    booker_email: str,
    *,
    allow_submit: bool,
    today: Optional[date] = None,
) -> OvertimeMealRunResult:
    """Run Monday overtime-meal booking for the current week.

    Empty eligible-date list → skip. Without --ALLOW, fill only and stop.
    """
    result = OvertimeMealRunResult()
    anchor = today or date.today()
    if not should_run_overtime_meal(anchor):
        print(
            f"[INFO] 加班餐 skip: today={anchor.isoformat()} is not Monday",
            flush=True,
        )
        result.skipped_not_monday = True
        return result

    days = overtime_meal_dates_for_week(anchor)
    if not days:
        print(
            f"[INFO] 加班餐 skip: no eligible meal dates in week of {anchor.isoformat()}",
            flush=True,
        )
        result.skipped_no_eligible = True
        return result

    print(
        f"[INFO] 加班餐 eligible={ [d.isoformat() for d in days] } "
        f"booker={booker_email!r} allow_submit={allow_submit}",
        flush=True,
    )
    open_overtime_meal_form(page)
    selected = select_meal_dates(page, days)
    booker = select_booker_by_email(page, booker_email)
    print(f"[OK] 加班餐 filled dates={selected} booker={booker!r}", flush=True)

    if not allow_submit:
        print("[INFO] 加班餐 filled; no --ALLOW, skip 同意", flush=True)
        result.processed = [OvertimeMealProcessedItem(date=d) for d in selected]
        return result

    submit_overtime_meal(page)
    result.processed = [OvertimeMealProcessedItem(date=d) for d in selected]
    print(f"[OK] 加班餐 submitted dates={selected}", flush=True)
    return result
