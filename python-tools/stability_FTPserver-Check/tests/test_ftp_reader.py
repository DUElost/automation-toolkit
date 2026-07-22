# -*- coding: utf-8 -*-
import os
import sys
import unittest
from pathlib import Path
from unittest.mock import patch

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

from ftp_reader_20260626 import (
    CHUNKED_DOWNLOAD_THRESHOLD,
    DEFAULT_CHUNK_COUNT,
    DEFAULT_CONFIG,
    DownloadProgress,
    _chunked_download_is_truncated,
    _is_transient_network_error,
    _part_file_size,
    apply_known_ftp_path_aliases,
    download_file_with_progress,
    resolve_ftp_target,
    should_use_chunked_file_download,
)


class DownloadProgressTest(unittest.TestCase):
    def test_add_file_does_not_double_count_bytes(self) -> None:
        progress = DownloadProgress(total_files=1, total_bytes=100)
        progress.add_bytes(100)
        progress.add_file()
        files, bytes_done, _ = progress.snapshot()
        self.assertEqual(files, 1)
        self.assertEqual(bytes_done, 100)


class ResolveFtpTargetTest(unittest.TestCase):
    def test_ftp_url_resolves_host_and_path_alias(self) -> None:
        config, remote_path, note = resolve_ftp_target(
            DEFAULT_CONFIG,
            "ftp://220.175.120.251/home/jxtinno/sonic_tinno/MonkeyAEE",
        )
        self.assertEqual(config.host, "220.175.120.251")
        self.assertEqual(config.port, 21)
        self.assertEqual(remote_path, "/MonkeyAEE")
        self.assertIn("220.175.120.251", note or "")

    def test_ftp_url_username_fills_known_password(self) -> None:
        config, remote_path, note = resolve_ftp_target(
            DEFAULT_CONFIG,
            "ftp://tianlong@113.140.11.141/ZTE_version/demo.zip",
        )
        self.assertEqual(config.host, "113.140.11.141")
        self.assertEqual(config.username, "tianlong")
        self.assertEqual(config.password, "tianlong123")
        self.assertEqual(remote_path, "/ZTE_version/demo.zip")
        self.assertIsNotNone(note)

    def test_embedded_ipv4_in_absolute_path(self) -> None:
        config, remote_path, note = resolve_ftp_target(
            DEFAULT_CONFIG,
            "/61.157.181.82:18080/share/projectA",
        )
        self.assertEqual(config.host, "61.157.181.82")
        self.assertEqual(config.port, 18080)
        self.assertEqual(remote_path, "/projectA")
        self.assertIsNotNone(note)

    def test_project_path_does_not_rewrite_default_host(self) -> None:
        config, remote_path, note = resolve_ftp_target(
            DEFAULT_CONFIG,
            "/MLD-LX3-16-260521V5/MonkeyAEE",
        )
        self.assertEqual(config.host, DEFAULT_CONFIG.host)
        self.assertEqual(config.port, DEFAULT_CONFIG.port)
        self.assertEqual(remote_path, "/MLD-LX3-16-260521V5/MonkeyAEE")
        self.assertIsNotNone(note)
        self.assertIn("220.175.120.251", note)


class ApplyKnownFtpPathAliasesTest(unittest.TestCase):
    def test_sonic_tinno_prefix_maps_to_root(self) -> None:
        path = apply_known_ftp_path_aliases(
            DEFAULT_CONFIG,
            "/home/jxtinno/sonic_tinno/foo/bar",
        )
        self.assertEqual(path, "/foo/bar")


class DownloadFileWithProgressTest(unittest.TestCase):
    def test_should_use_chunked_independent_of_workers_semantics(self) -> None:
        large = 20 * 1024 * 1024
        self.assertTrue(
            should_use_chunked_file_download(large, CHUNKED_DOWNLOAD_THRESHOLD, DEFAULT_CHUNK_COUNT)
        )
        self.assertFalse(
            should_use_chunked_file_download(1024, CHUNKED_DOWNLOAD_THRESHOLD, DEFAULT_CHUNK_COUNT)
        )
        self.assertFalse(
            should_use_chunked_file_download(large, CHUNKED_DOWNLOAD_THRESHOLD, chunk_count=1)
        )

    @patch("ftp_reader_20260626.time.sleep")
    @patch("ftp_reader_20260626.download_single_file_parallel")
    @patch("ftp_reader_20260626.download_chunked_file")
    def test_falls_back_when_chunked_download_fails(
        self,
        mock_chunked,
        mock_single,
        mock_sleep,
    ) -> None:
        mock_chunked.side_effect = RuntimeError("REST not supported")
        download_file_with_progress(
            DEFAULT_CONFIG,
            "/remote/big.dbg",
            Path(PROJECT_ROOT) / "big.dbg",
            file_size=20 * 1024 * 1024,
            chunk_threshold=10 * 1024 * 1024,
            chunk_count=4,
        )
        mock_chunked.assert_called_once()
        mock_single.assert_called_once()
        mock_sleep.assert_called()

    @patch("ftp_reader_20260626.download_single_file_parallel")
    @patch("ftp_reader_20260626.download_chunked_file")
    def test_does_not_fall_back_on_transient_chunked_error(
        self,
        mock_chunked,
        mock_single,
    ) -> None:
        exc = OSError(10060, "timed out")
        exc.winerror = 10060
        mock_chunked.side_effect = exc
        with self.assertRaises(OSError):
            download_file_with_progress(
                DEFAULT_CONFIG,
                "/remote/big.dbg",
                Path(PROJECT_ROOT) / "big.dbg",
                file_size=20 * 1024 * 1024,
                chunk_threshold=10 * 1024 * 1024,
                chunk_count=4,
            )
        mock_single.assert_not_called()

    @patch("ftp_reader_20260626.download_chunked_file")
    @patch("ftp_reader_20260626.download_single_file_parallel")
    def test_skips_when_local_file_already_complete(
        self,
        mock_single,
        mock_chunked,
    ) -> None:
        target = Path(PROJECT_ROOT) / "already_complete.dbg"
        size = 20 * 1024 * 1024
        target.write_bytes(b"x" * size)
        try:
            download_file_with_progress(
                DEFAULT_CONFIG,
                "/remote/big.dbg",
                target,
                file_size=size,
                chunk_threshold=10 * 1024 * 1024,
                chunk_count=4,
            )
        finally:
            if target.exists():
                target.unlink()
        mock_chunked.assert_not_called()
        mock_single.assert_not_called()

    @patch("ftp_reader_20260626._try_get_size", return_value=20 * 1024 * 1024)
    @patch("ftp_reader_20260626.ftp_connection")
    def test_chunked_download_is_truncated_when_remote_grew(
        self,
        mock_ftp_connection,
        mock_get_size,
    ) -> None:
        local_file = Path(PROJECT_ROOT) / "truncated.dbg"
        local_file.write_bytes(b"x" * (10 * 1024 * 1024))
        try:
            self.assertTrue(
                _chunked_download_is_truncated(
                    DEFAULT_CONFIG,
                    "/remote/big.dbg",
                    local_file,
                    scanned_size=10 * 1024 * 1024,
                )
            )
        finally:
            if local_file.exists():
                local_file.unlink()

    @patch("ftp_reader_20260626.time.sleep")
    @patch("ftp_reader_20260626.download_single_file_parallel")
    @patch("ftp_reader_20260626._chunked_download_is_truncated", return_value=True)
    @patch("ftp_reader_20260626.download_chunked_file")
    def test_falls_back_when_chunked_download_truncated(
        self,
        mock_chunked,
        mock_truncated,
        mock_single,
        mock_sleep,
    ) -> None:
        target = Path(PROJECT_ROOT) / "big.dbg"
        target.write_bytes(b"partial")
        try:
            download_file_with_progress(
                DEFAULT_CONFIG,
                "/remote/big.dbg",
                target,
                file_size=20 * 1024 * 1024,
                chunk_threshold=10 * 1024 * 1024,
                chunk_count=4,
            )
        finally:
            if target.exists():
                target.unlink()
        mock_chunked.assert_called_once()
        mock_truncated.assert_called_once()
        mock_single.assert_called_once()
        self.assertEqual(mock_single.call_args.kwargs.get("file_size"), 20 * 1024 * 1024)
        mock_sleep.assert_called()


class TransientNetworkErrorTest(unittest.TestCase):
    def test_winerror_10054_is_transient(self) -> None:
        exc = OSError(10054, "remote host closed")
        exc.winerror = 10054
        self.assertTrue(_is_transient_network_error(exc))

    def test_permission_style_message_not_transient(self) -> None:
        self.assertFalse(_is_transient_network_error(RuntimeError("550 Permission denied")))


class PartFileResumeTest(unittest.TestCase):
    def test_part_file_size_missing(self) -> None:
        missing = Path(PROJECT_ROOT) / "definitely_missing.resume.part"
        self.assertEqual(_part_file_size(missing), 0)

    def test_progress_set_bytes(self) -> None:
        progress = DownloadProgress(total_files=1, total_bytes=1000)
        progress.add_bytes(100)
        progress.set_bytes(250)
        _, bytes_done, _ = progress.snapshot()
        self.assertEqual(bytes_done, 250)


if __name__ == "__main__":
    unittest.main()
