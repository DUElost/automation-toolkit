"""v12 当日重复 dump 门槛测试：堆占比不再往上爬时，同一 (设备, 进程) 当天不产第二份 hprof。

现场动因（只作背景，不进判据）：11-18 一台 launcher3 单日 30 份 / 9.0GB，11-19 同样形态
23 份 / 7.1GB，堆体量已在平台期。门槛只放行「继续爬坡」的那一次，问题覆盖度不减。
本文件不触碰真实 adb 与共享盘：dump 命令用桩记录，15.4 空间刻意报低以走「只留本地」早退分支。
"""
import os
import re
import sys
import time
from datetime import datetime
from pathlib import Path
from unittest.mock import patch

import pytest

TOOL_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOL_DIR))

import memleak_monitor_2d as mon  # noqa: E402

DEV_A = "AT7QNX6B02000070"
DEV_B = "AT7QNX6B02000076"
LAUNCHER = "com.android.launcher3"
SETTINGS = "com.android.settings"
LOG_DIR = ("/home/android/sonic_agent/logs/ftp_log/sonic_tinno/"
           "MLD-NX3_16_261110V94_261119_Systeminfo/%s/")


class _RecLogger:
    """记录 TEST_LOGGER 的调用层级，不宣称落盘。"""

    def __init__(self):
        self.rows = []

    def _add(self, lvl, msg, *args, **kwargs):
        self.rows.append((lvl, str(msg)))

    def info(self, m, *a, **k):
        self._add("info", m, *a, **k)

    def warning(self, m, *a, **k):
        self._add("warning", m, *a, **k)

    def warn(self, m, *a, **k):
        self._add("warn", m, *a, **k)

    def error(self, m, *a, **k):
        self._add("error", m, *a, **k)

    def debug(self, m, *a, **k):
        self._add("debug", m, *a, **k)


def _disk_of(path):
    """本地暂存盘报充足；15.4（ftp_log 路径）报低于门槛，让函数在 dump 后早退，不碰 CIFS。"""
    low = 10 * 1024 ** 3
    high = 500 * 1024 ** 3
    return type("Usage", (), {"free": low if "ftp_log" in path else high})()


def _age_cooldown(device=DEV_A, pkg=LAUNCHER):
    """把上次 dump 时刻拨回冷却期之外，让本次调用真正走到 v12 门槛（冷却优先返回会掩盖门槛）。"""
    key = f"{device}_{pkg}"
    base = mon.HPROF_DUMP_COOLDOWN_SECONDS if pkg != mon.SYSTEM_SERVER_PROC_NAME \
        else mon.SYSTEM_SERVER_DUMP_COOLDOWN_SECONDS
    mon.last_hprof_dump_times[key] = time.time() - base - 1


def _dump(device=DEV_A, pkg=LAUNCHER, pct=None, reason="测试触发"):
    """跑一次 _trigger_hprof_dump，返回 (是否执行了 dumpheap 批次, 日志行列表)。"""
    logger = _RecLogger()
    ran = []
    with patch.object(mon, "TEST_LOGGER", logger), \
            patch.object(mon.os, "makedirs", lambda *a, **k: None), \
            patch.object(mon.shutil, "disk_usage", _disk_of), \
            patch.object(mon, "execute_commands", lambda d, c, n: ran.append(n)), \
            patch.object(mon, "_resolve_system_server_pid", lambda d: "1234"):
        mon._trigger_hprof_dump(device, LOG_DIR % device, reason,
                                target_package=pkg, heap_pct=pct)
    return ran, logger.rows


def _source_default_gain():
    src = (TOOL_DIR / "memleak_monitor_2d.py").read_text(encoding="utf-8")
    m = re.search(
        r'DUMP_REPEAT_MIN_PCT_GAIN\s*=\s*float\(os\.environ\.get\("MEMLEAK_DUMP_REPEAT_GAIN",\s*"([^"]+)"\)\)',
        src,
    )
    assert m, "未在源码中找到 DUMP_REPEAT_MIN_PCT_GAIN 默认值定义"
    return float(m.group(1))


@pytest.fixture(autouse=True)
def _clean_state():
    mon.last_dump_pct_by_day.clear()
    mon.last_hprof_dump_times.clear()
    with patch.object(mon, "DUMP_REPEAT_MIN_PCT_GAIN", _source_default_gain()):
        yield
    mon.last_dump_pct_by_day.clear()
    mon.last_hprof_dump_times.clear()


def _day_key(device=DEV_A, pkg=LAUNCHER):
    return f"{device}_{pkg}_{datetime.now().strftime('%Y-%m-%d')}"


def test_first_dump_of_the_day_is_not_gated():
    """当日第一次：照抓，并把占比记进门槛状态。"""
    ran, _rows = _dump(pct=90.0)
    assert ran == ["hprof_dump_batch"]
    assert mon.last_dump_pct_by_day[_day_key()] == 90.0


def test_repeat_without_gain_is_skipped():
    """同天同 (设备,进程) 只涨 1 个百分点（<5）：不产第二份，只记 INFO 说明跳过。"""
    _dump(pct=90.0)
    _age_cooldown()
    ran, rows = _dump(pct=91.0)
    assert ran == []
    assert [r for r in rows if "跳过重复抓取" in r[1]]
    assert [r for r in rows if r[0] == "warning"] == []      # 不再有「触发 hprof dump」
    assert mon.last_dump_pct_by_day[_day_key()] == 90.0      # 状态不被回写


def test_repeat_with_gain_dumps_and_raises_state():
    """涨满 6 个百分点（>=5）：再抓一次，门槛随整体上移。"""
    _dump(pct=90.0)
    _age_cooldown()
    ran, _rows = _dump(pct=96.0)
    assert ran == ["hprof_dump_batch"]
    assert mon.last_dump_pct_by_day[_day_key()] == 96.0


def test_gate_is_scoped_per_device_and_per_process():
    """跨设备、跨进程互不影响：各算各的当日第一份。"""
    assert _dump(device=DEV_A, pkg=LAUNCHER, pct=90.0)[0] == ["hprof_dump_batch"]
    assert _dump(device=DEV_B, pkg=LAUNCHER, pct=90.0)[0] == ["hprof_dump_batch"]
    assert _dump(device=DEV_A, pkg=SETTINGS, pct=90.0)[0] == ["hprof_dump_batch"]
    assert _dump(device=DEV_A, pkg=LAUNCHER, pct=90.0)[0] == []   # 只有完全同键才被拦


def test_yesterday_state_does_not_leak_into_today():
    """门槛键含日期：昨天的记录不抑制今天的抓取。"""
    mon.last_dump_pct_by_day[f"{DEV_A}_{LAUNCHER}_2020-01-01"] = 99.0
    ran, _rows = _dump(pct=50.0)
    assert ran == ["hprof_dump_batch"]
    assert _day_key() in mon.last_dump_pct_by_day


def test_trigger_without_pct_is_not_gated():
    """RSS 类触发不带堆占比：不受本门槛约束（v12 有意保守，不拿无法比较的量去压制触发）。"""
    assert _dump(pct=None)[0] == ["hprof_dump_batch"]
    _age_cooldown()
    assert _dump(pct=None)[0] == ["hprof_dump_batch"]
    assert mon.last_dump_pct_by_day == {}


def test_gate_can_be_disabled_without_a_new_version():
    """增幅门槛设 0 即退回 v11 行为（同一份堆当天可反复抓）。"""
    with patch.object(mon, "DUMP_REPEAT_MIN_PCT_GAIN", 0.0):
        _dump(pct=90.0)
        _age_cooldown()
        assert _dump(pct=90.0)[0] == ["hprof_dump_batch"]


def test_documented_gain_matches_source_constant():
    """readme.txt 记录的默认门槛值必须与源码默认常量一致（不受外部环境变量干扰）。"""
    readme = (TOOL_DIR / "readme.txt").read_text(encoding="utf-8")
    assert f"DUMP_REPEAT_MIN_PCT_GAIN = {_source_default_gain():g}" in readme

def test_cooldown_and_repeat_gate_are_two_separate_gates():
    """增幅够但仍在 30 分钟冷却期内：应被冷却挡下（报「冷却期」），而不是被门槛挡下。"""
    _dump(pct=90.0)
    ran, rows = _dump(pct=99.0)          # 未拨冷却
    assert ran == []
    assert [r for r in rows if "冷却期" in r[1]]
    assert not [r for r in rows if "跳过重复抓取" in r[1]]


# ─────────────────────────────────────────────────────────────────────────
# 调用点级锁定（C 方案）：上穿档一定放行，只有「早期信号补抓」受当日门槛约束
# ─────────────────────────────────────────────────────────────────────────
TARGET_KB = 256 * 1024          # dalvik.vm.heapgrowthlimit = 256MB


def _via_check(ratio, early=None, prev_level=0, device=DEV_A, pkg=LAUNCHER):
    """走真实调用方 check_launcher_heap，返回 (是否执行 dump, 日志行)。"""
    import contextlib
    logger = _RecLogger()
    ran = []
    mon.la_heap_level[device] = prev_level
    mon.app_heap_level[(device, pkg)] = prev_level
    stack = [
        patch.object(mon, "TEST_LOGGER", logger),
        patch.object(mon, "_read_dalvik_heap_kb", lambda d, p=pkg: int(TARGET_KB * ratio)),
        patch.object(mon, "_read_target_heap_kb", lambda d, k=None: TARGET_KB),
        patch.object(mon, "_scan_logcat_early_signal", lambda d: early),
        patch.object(mon, "_append_heap_series", lambda *a, **k: None),
        patch.object(mon.os, "makedirs", lambda *a, **k: None),
        patch.object(mon.shutil, "disk_usage", _disk_of),
        patch.object(mon, "execute_commands", lambda d, c, n: ran.append(n)),
    ]
    with contextlib.ExitStack() as st:
        for ctx in stack:
            st.enter_context(ctx)
        mon.check_launcher_heap(device, LOG_DIR % device, pkg=pkg)
    return ran, logger.rows


def test_level_crossing_call_site_bypasses_the_gate():
    """上穿 L1 时即使低于当日峰值（86% < 95%）也必须抓——这是「同日第二次发作」的唯一入口。"""
    mon.last_dump_pct_by_day[_day_key()] = 95.0
    ran, rows = _via_check(ratio=0.86, early=None, prev_level=0)
    assert ran == ["hprof_dump_batch"]
    assert not [r for r in rows if "跳过重复抓取" in r[1]]
    assert mon.last_dump_pct_by_day[_day_key()] == 95.0      # max(95, 86)：低档上穿不会把峰值拉低


def test_early_signal_catchup_call_site_is_gated():
    """档位没变、只有早期信号、堆没再涨：补抓必须被当日门槛拦下（这正是 9.0GB 的来源）。"""
    mon.last_dump_pct_by_day[_day_key()] = 95.0
    _age_cooldown()
    ran, rows = _via_check(ratio=0.86, early="Clamp target GC heap", prev_level=1)
    assert ran == []
    assert [r for r in rows if "跳过重复抓取" in r[1]]


def test_crossing_seeds_the_peak_then_quietens_catchup():
    """联动效果：上穿先抓并记下 86%，之后平台期的补抓就被同一门槛收住。"""
    assert _via_check(ratio=0.86, early=None, prev_level=0)[0] == ["hprof_dump_batch"]
    assert mon.last_dump_pct_by_day[_day_key()] == pytest.approx(86.0, abs=0.01)
    _age_cooldown()
    assert _via_check(ratio=0.87, early="Waiting for a blocking GC", prev_level=1)[0] == []
    _age_cooldown()
    assert _via_check(ratio=0.93, early="Throwing OutOfMemoryError", prev_level=1)[0] == ["hprof_dump_batch"]
    assert mon.last_dump_pct_by_day[_day_key()] == pytest.approx(93.0, abs=0.01)   # 真在爬坡就继续给证据


def test_readme_documents_which_paths_the_gate_covers():
    """文档必须写清门槛只管补抓、上穿不受闸（避免下一个人以为上穿也会被拦）。"""
    readme = (TOOL_DIR / "readme.txt").read_text(encoding="utf-8")
    assert "上穿" in readme and "不受" in readme and "补抓" in readme
