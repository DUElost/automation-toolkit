import importlib.util
import sys
from pathlib import Path
from unittest.mock import MagicMock, patch

TOOL_DIR = Path(__file__).resolve().parents[1]
MODULE_PATH = TOOL_DIR / "MonkeyAEEinfo_260622.py"


def _load_monkey_module():
  spec = importlib.util.spec_from_file_location("monkey_aee_260622", MODULE_PATH)
  module = importlib.util.module_from_spec(spec)
  sys.modules[spec.name] = module
  spec.loader.exec_module(module)
  return module


def test_write_probe_timeout_stays_healthy_when_stat_ok():
  module = _load_monkey_module()
  probe = module.CIFSHealthProbe("/mnt/cifs", probe_timeout=1)

  stat_result = MagicMock(returncode=0)
  with patch.object(module.subprocess, "run") as mock_run:
    mock_run.side_effect = [
      stat_result,
      MagicMock(returncode=0),
    ]
    with patch.object(probe, "_probe_write_access", return_value=(False, "timeout")):
      assert probe.is_mount_healthy() is True

  assert probe.last_failure_reason == "io_slow"


def test_write_probe_failure_marks_unhealthy():
  module = _load_monkey_module()
  probe = module.CIFSHealthProbe("/mnt/cifs", probe_timeout=1)

  stat_result = MagicMock(returncode=0)
  with patch.object(module.subprocess, "run", return_value=stat_result):
    with patch.object(probe, "_probe_write_access", return_value=(False, "failed")):
      assert probe.is_mount_healthy() is False

  assert probe.last_failure_reason == "write_fail"
