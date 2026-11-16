"""v10 机型白名单测试：只监测 535 族，非 535 设备必须被跳过（不触碰真实 adb）。"""
import sys
from pathlib import Path
from unittest.mock import patch

import pytest

TOOL_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOL_DIR))

import memleak_monitor_2d as mon  # noqa: E402

SERIALS_535 = [
    "AHFFNX6930000180", "ATHTNX6930000026",      # MLD-NX2
    "ASEBNX6930000001", "AZ6QNX6A06000018",      # MLD-NX3-Claro
    "AT7QNX6B02000070", "AW8QNX6A06000068",      # MLD-NX3
]
SERIALS_NON_535 = ["A2WENX6B04000021", "AVCGNX6B03002479", "AS4XNX6914000017"]


def _fake_adb_output(serials, extra_offline=()):
    lines = ["List of devices attached"]
    lines += [f"{s}\tdevice" for s in serials]
    lines += [f"{s}\tunauthorized" for s in extra_offline]
    return "\n".join(lines) + "\n"


class _Result:
    def __init__(self, stdout):
        self.stdout = stdout


@pytest.fixture(autouse=True)
def _clear_cache():
    mon.device_log_path_map.clear()
    yield


def test_default_whitelist_covers_535_only():
    assert mon.get_serial_prefixes() == ("AHFFNX", "ATHTNX", "ASEBNX", "AZ6QNX", "AT7QNX", "AW8QNX")


@patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_535 + SERIALS_NON_535)))
def test_non_535_are_excluded(_r):
    got = mon.get_connected_devices()
    assert sorted(got) == sorted(SERIALS_535)
    assert not any(s.startswith(("A2WENX", "AVCGNX", "AS4XNX")) for s in got)


@patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_535, ("AVCGNX6B03002499",))))
def test_unauthorized_still_excluded(_r):
    assert "AVCGNX6B03002499" not in mon.get_connected_devices()


@patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_NON_535)))
def test_all_non_535_yields_empty(_r):
    """全机队都是非 535 设备时应返回空列表，而非误采集。"""
    assert mon.get_connected_devices() == []


@patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_535 + SERIALS_NON_535)))
def test_env_override_replaces_whitelist(_r, monkeypatch):
    monkeypatch.setenv("MEMLEAK_SERIAL_PREFIXES", "a2wenx, avcgnx")
    assert mon.get_serial_prefixes() == ("A2WENX", "AVCGNX")
    got = mon.get_connected_devices()
    assert sorted(got) == sorted(SERIALS_NON_535[:2])


@patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_535)))
def test_lowercase_serial_is_matched(_r):
    """序列号大小写异常时仍须按前缀判定，不得因大小写漏掉设备。"""
    lower = _fake_adb_output([s.lower() for s in SERIALS_535])
    with patch("subprocess.run", return_value=_Result(lower)):
        assert len(mon.get_connected_devices()) == len(SERIALS_535)


def test_config_example_agrees_with_source_constant():
    """config.json.example 只是只读参考；其前缀必须与源码常量一致，防文档漂移。"""
    import json

    cfg = json.loads(
        (TOOL_DIR / "config.json.example").read_text(encoding="utf-8")
    )
    assert tuple(cfg["serial_whitelist"]["prefixes"]) == mon.SERIAL_PREFIX_DEFAULT
    assert cfg["serial_whitelist"]["override_env"] == "MEMLEAK_SERIAL_PREFIXES"


@patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_535 + SERIALS_NON_535)))
def test_non_535_skip_is_logged_once_per_serial(_r):
    """v11(N6)：跳过非 535 设备这件事，每台只在首轮记 INFO，之后降为 DEBUG。

    反证：v10 每轮逐台重复打 INFO，`.58` 实测 118 分钟 132 条跳过 INFO、16 台唯一设备
    （外推日增≈1600 条/host），把与泄漏无关的行刷成主体日志。
    """
    mon.non_535_skip_notified.clear()
    with patch.object(mon.TEST_LOGGER, "info") as info, \
            patch.object(mon.TEST_LOGGER, "debug") as dbg:
        for _ in range(3):                       # 模拟 3 个轮次
            mon.get_connected_devices()
    first_round = [c.args[0] for c in info.call_args_list if "跳过非 535" in c.args[0]]
    later = [c.args[0] for c in dbg.call_args_list if "跳过非 535" in c.args[0]]
    assert len(first_round) == len(SERIALS_NON_535), first_round      # 每台设备只记 1 条
    # 消息里序列号紧跟全角括号，不能用空白切词取
    noticed = {m.split("族设备 ")[1].split("（")[0] for m in first_round}
    assert noticed == set(SERIALS_NON_535), first_round
    assert len(later) == 2 * len(SERIALS_NON_535), later              # 后两轮降级但仍留痕
    mon.non_535_skip_notified.clear()


@patch("subprocess.run", return_value=_Result(_fake_adb_output([s.lower() for s in SERIALS_NON_535])))
def test_skip_notice_dedup_is_case_insensitive(_r):
    """大小写不同的同一序列号不得再刷一条 INFO（判定按大写，去重键也必须按大写）。"""
    mon.non_535_skip_notified.clear()
    with patch("subprocess.run", return_value=_Result(_fake_adb_output(SERIALS_NON_535))):
        mon.get_connected_devices()              # 先按大写记满
    with patch.object(mon.TEST_LOGGER, "info") as info:
        mon.get_connected_devices()              # 再来一份小写的同一批设备
    assert not [c for c in info.call_args_list if "跳过非 535" in c.args[0]]
    mon.non_535_skip_notified.clear()
