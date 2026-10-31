import importlib.util
import sys
from pathlib import Path
from unittest.mock import patch

TOOL_DIR = Path(__file__).resolve().parents[1]
MODULE_PATH = TOOL_DIR / "MonkeyAEEinfo_260622.py"


def _load_monkey_module():
    tool_dir = str(TOOL_DIR)
    if tool_dir not in sys.path:
        sys.path.insert(0, tool_dir)
    spec = importlib.util.spec_from_file_location("monkey_aee_260622", MODULE_PATH)
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


def _mock_local_stats(file_count=5, total_size=50_000, has_dbg=True):
    def fake_run(cmd, **kwargs):
        cmd_text = cmd if isinstance(cmd, str) else " ".join(cmd)
        if "awk" in cmd_text:
            result = type("R", (), {})()
            result.stdout = f"{file_count} {total_size}"
            result.returncode = 0
            return result
        if "*.dbg" in cmd_text:
            result = type("R", (), {})()
            result.stdout = "/tmp/foo.dbg" if has_dbg else ""
            result.returncode = 0
            return result
        raise AssertionError(f"unexpected command: {cmd_text}")

    return fake_run


def test_remote_zero_rejects_partial_when_expected_snapshot(tmp_path):
    module = _load_monkey_module()
    local_dir = tmp_path / "aee_log"
    local_dir.mkdir()
    task = {"expected_remote_file_count": 10, "expected_remote_total_size": 100_000}

    with patch.object(module, "IS_WINDOWS", False):
        with patch.object(module, "_safe_is_dir", return_value=True):
            with patch.object(module.subprocess, "run", side_effect=_mock_local_stats(file_count=3, total_size=30_000)):
                with patch.object(module, "_get_remote_file_stats", return_value=(0, 0)):
                    ok, msg, remote_verified = module._verify_pulled_aee_log_strict(
                        str(local_dir), "/data/aee_exp/db", "device1", task=task
                    )

    assert ok is False
    assert remote_verified is True
    assert "文件数不足" in msg


def test_remote_zero_accepts_complete_when_matches_snapshot(tmp_path):
    module = _load_monkey_module()
    local_dir = tmp_path / "aee_log"
    local_dir.mkdir()
    task = {"expected_remote_file_count": 5, "expected_remote_total_size": 50_000}

    with patch.object(module, "IS_WINDOWS", False):
        with patch.object(module, "_safe_is_dir", return_value=True):
            with patch.object(module.subprocess, "run", side_effect=_mock_local_stats(file_count=5, total_size=50_000)):
                with patch.object(module, "_get_remote_file_stats", return_value=(0, 0)):
                    ok, msg, remote_verified = module._verify_pulled_aee_log_strict(
                        str(local_dir), "/data/aee_exp/db", "device1", task=task
                    )

    assert ok is True
    assert remote_verified is True
    assert "历史观测一致" in msg


def test_remote_zero_without_snapshot_stays_awaiting_remote_verify(tmp_path):
    module = _load_monkey_module()
    local_dir = tmp_path / "aee_log"
    local_dir.mkdir()
    task = {}

    with patch.object(module, "IS_WINDOWS", False):
        with patch.object(module, "_safe_is_dir", return_value=True):
            with patch.object(module.subprocess, "run", side_effect=_mock_local_stats(file_count=5, total_size=50_000)):
                with patch.object(module, "_get_remote_file_stats", return_value=(0, 0)):
                    ok, msg, remote_verified = module._verify_pulled_aee_log_strict(
                        str(local_dir), "/data/aee_exp/db", "device1", task=task
                    )

    assert ok is True
    assert remote_verified is False
    assert "待远程确认" in msg


def test_verify_records_expected_remote_stats_from_live_remote(tmp_path):
    module = _load_monkey_module()
    local_dir = tmp_path / "aee_log"
    local_dir.mkdir()
    task = {}

    with patch.object(module, "IS_WINDOWS", False):
        with patch.object(module, "_safe_is_dir", return_value=True):
            with patch.object(module.subprocess, "run", side_effect=_mock_local_stats(file_count=5, total_size=50_000)):
                with patch.object(module, "_get_remote_file_stats", return_value=(8, 80_000)):
                    ok, msg, remote_verified = module._verify_pulled_aee_log_strict(
                        str(local_dir), "/data/aee_exp/db", "device1", task=task
                    )

    assert ok is False
    assert remote_verified is True
    assert task["expected_remote_file_count"] == 8
    assert task["expected_remote_total_size"] == 80_000
