import subprocess
import sys
from pathlib import Path
from unittest.mock import MagicMock, patch

import pytest

TOOL_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(TOOL_DIR))

from storage_filler import (  # noqa: E402
    FILL_TARGET_DIR,
    _build_fill_file_path,
    _fill_in_chunks,
    _get_storage_info,
)


def test_fill_target_dir_is_sdcard():
  assert FILL_TARGET_DIR == "/sdcard"


def test_build_fill_file_path_uses_sdcard():
  path = _build_fill_file_path("abc123")
  assert path.startswith("/sdcard/")
  assert path.endswith("fill_file_abc123.tmp")


def test_get_storage_info_queries_sdcard_partition():
  fake_output = "Filesystem     1K-blocks    Used Available Use% Mounted on\n/dev/fuse  10000000 2000000 8000000  20% /sdcard\n"
  with patch("storage_filler.subprocess.check_output", return_value=fake_output) as mock_run:
    total_gb, used_gb = _get_storage_info("device123")

  mock_run.assert_called_once_with(
      ["adb", "-s", "device123", "shell", "df", "/sdcard"],
      text=True,
      stderr=subprocess.STDOUT,
  )
  assert total_gb == pytest.approx(9.54, rel=0.01)
  assert used_gb == pytest.approx(1.91, rel=0.01)


def test_fill_in_chunks_writes_to_sdcard():
  with patch("storage_filler.subprocess.Popen") as mock_popen, patch(
      "storage_filler.time.time", return_value=1710000000
  ), patch("storage_filler.random.randint", return_value=5555):
    process = MagicMock()
    process.communicate.return_value = (b"", b"")
    process.returncode = 0
    mock_popen.return_value = process

    assert _fill_in_chunks("device123", 1) is True

  command = mock_popen.call_args[0][0]
  assert "/sdcard/fill_file_1710000000_5555.tmp" in command
