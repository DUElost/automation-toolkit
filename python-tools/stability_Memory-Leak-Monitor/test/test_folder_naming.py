"""产物目录命名解析测试（对齐 15.4 既有战役目录约定，不触碰真实设备）。"""
import re
import sys
from datetime import datetime
from pathlib import Path
from unittest.mock import patch

import pytest

TOOL_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOL_DIR))

import memleak_monitor_2d as mon  # noqa: E402


@pytest.mark.parametrize(
    "product_name,display_id,expected_prefix",
    [
        # 形态一：MLD-NX2-16-261013V21
        ("MLD-NX2", "MLD-NX2-16-261013V21", "MLD-NX2_16_261013V21"),
        # 形态二：display id 带括号，日期段被括号分隔
        ("MLY-LX3", "MLY-LX3-16(260914V2)260922", "MLY-LX3_16_260914V2"),
        # 含连字符的产品名照原样拼接（NX3-Claro 实测形态）
        ("MLD-NX3-Claro", "MLD-NX3-Claro-16-261027V56", "MLD-NX3-Claro_16_261027V56"),
    ],
)
def test_folder_name_shape(product_name, display_id, expected_prefix):
    """<ro.product.name>_<段2>_<buildtoken>_<YYMMDD>_Systeminfo"""
    with patch.object(mon, "_run_adb_prop_command", side_effect=[product_name, display_id]):
        got = mon.generate_device_log_folder_name_components("ANY-SERIAL")
    assert got == "_".join(
        [expected_prefix, datetime.now().strftime("%y%m%d"), "Systeminfo"]
    )


def test_folder_name_rejects_missing_props():
    """属性读不到时返回 None（调用方据此跳过该设备本轮处理）。"""
    with patch.object(mon, "_run_adb_prop_command", side_effect=[None, None]):
        assert mon.generate_device_log_folder_name_components("ANY-SERIAL") is None


def test_trigger_thresholds_match_documented_criteria():
    """readme.txt 记录的判据必须与源码常量一致，改判据需同步文档。"""
    assert mon.SS_HEAP_LEVELS == [(1, 0.85), (2, 0.95)]
    assert mon.SS_LEVEL_RESET_RATIO == 0.35
    assert mon.SYSTEM_SERVER_RSS_DUMP_THRESHOLD_KB == 1_000_000
    assert mon.LAUNCHER_RSS_DUMP_THRESHOLD_KB == 1_000_000
    assert mon.LAUNCHER_EARLY_MIN_RATIO == 0.60
    assert mon.SS_FAST_POLL_INTERVAL == 30
    assert mon.SYSTEM_SERVER_DUMP_COOLDOWN_SECONDS == 7200
    assert mon.HPROF_DUMP_COOLDOWN_SECONDS == 1800


def test_targets_registered():
    """四路监控对象（systemui/settings 复用 launcher 档判据）。"""
    assert mon.LAUNCHER_PKG == "com.android.launcher3"
    assert set(mon.APP_EXTRA_PKGS) == {"com.android.systemui", "com.android.settings"}
    assert mon.HEAP_SERIES_LAUNCHER_FILENAME == "meminfo_heap_launcher.txt"
    assert mon.APP_HEAP_SERIES_MULTI_FILENAME == "meminfo_heap_apps.txt"


def _pct_of(line):
    m = re.search(r"pct=([\d.]+)%", line)
    return float(m.group(1)) if m else None


def test_apps_series_is_per_process_throttled():
    """v9 修复：systemui 与 settings 合写一份文件时，不得互相吃掉对方的行。"""
    import tempfile
    from pathlib import Path

    with tempfile.TemporaryDirectory() as tmp:
        tmp_path = Path(tmp)
        target = "meminfo_heap_apps.txt"
        mon.heap_series_last_write.clear()
        mon._append_heap_series("DEV", tmp_path, 30 * 1024, 256 * 1024, 0, None, target, proc="com.android.systemui")
        gc_hint = "Waiting for a blocking GC"
        mon._append_heap_series("DEV", tmp_path, 228 * 1024, 256 * 1024, 1, gc_hint, target,
                                proc="com.android.settings")
        # 同进程 30 秒内重复调用必须仍被节流
        mon._append_heap_series("DEV", tmp_path, 230 * 1024, 256 * 1024, 1, None, target, proc="com.android.settings")
        lines = (tmp_path / target).read_text(encoding="utf-8").splitlines()
    assert len(lines) == 2, lines
    procs = {l.split("proc=")[1].split()[0]: _pct_of(l) for l in lines}
    assert procs["com.android.systemui"] == 11.7, procs
    # settings 的 89.1% 高水位必须留存——修复前它会被 systemui 的行挤掉
    assert procs["com.android.settings"] == 89.1, procs


def test_system_server_series_format_unchanged():
    """system_server 通道不带 proc= 字段，保证历史曲线可续读、解析口径不变。"""
    import tempfile
    from pathlib import Path

    with tempfile.TemporaryDirectory() as tmp:
        tmp_path = Path(tmp)
        mon.heap_series_last_write.clear()
        mon._append_heap_series("DEV", tmp_path, 62 * 1024, 512 * 1024, 0, None, "meminfo_heap.txt")
        row = (tmp_path / "meminfo_heap.txt").read_text(encoding="utf-8").splitlines()[-1]
    assert "| proc=" not in row
    assert "target=512MB" in row


def test_monkey_off_by_default():
    """压力归平台专项：默认不得由本工具拉起 monkey。"""
    assert mon.MONKEY_ENABLED is False
