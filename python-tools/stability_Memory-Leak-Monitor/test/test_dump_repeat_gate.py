"""v12 当日重复 dump 门槛测试：堆占比不再往上爬时，同一 (设备, 进程) 当天不产第二份 hprof。

现场动因（只作背景，不进判据）：11-18 一台 launcher3 单日 30 份 / 9.0GB，11-19 同样形态
23 份 / 7.1GB，堆体量已在平台期。门槛只放行「继续爬坡」的那一次，问题覆盖度不减。
本文件不触碰真实 adb 与共享盘：dump 命令用桩记录，15.4 空间刻意报低以走「只留本地」早退分支。
"""
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


@pytest.fixture(autouse=True)
def _clean_state():
    mon.last_dump_pct_by_day.clear()
    mon.last_hprof_dump_times.clear()
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
    """readme.txt 记录的门槛值必须与源码常量一致（沿用既有文档-代码同轴约定）。"""
    readme = (TOOL_DIR / "readme.txt").read_text(encoding="utf-8")
    assert f"DUMP_REPEAT_MIN_PCT_GAIN = {mon.DUMP_REPEAT_MIN_PCT_GAIN:g}" in readme

def test_cooldown_and_repeat_gate_are_two_separate_gates():
    """增幅够但仍在 30 分钟冷却期内：应被冷却挡下（报「冷却期」），而不是被门槛挡下。"""
    _dump(pct=90.0)
    ran, rows = _dump(pct=99.0)          # 未拨冷却
    assert ran == []
    assert [r for r in rows if "冷却期" in r[1]]
    assert not [r for r in rows if "跳过重复抓取" in r[1]]
