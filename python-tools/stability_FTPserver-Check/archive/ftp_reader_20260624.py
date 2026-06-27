#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
FTP 读取工具

功能：
1. 列出 FTP 目录内容
2. 读取 FTP 文本文件内容
3. 下载 FTP 文件到本地

示例：
    python ftp_reader.py list /
    python ftp_reader.py read /remote/path/demo.txt --file-encoding utf-8
    python ftp_reader.py download /remote/path/demo.zip ./demo.zip
"""

import argparse
import os
import sys
import threading
import time
from contextlib import contextmanager
from dataclasses import dataclass, replace
from ftplib import FTP, all_errors
from io import BytesIO
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
from typing import Callable, Generator, Iterable, List, Optional, Tuple, TypeVar
from urllib.parse import urlsplit


T = TypeVar("T")

DEFAULT_FTP_ENCODING_CANDIDATES = ("utf-8", "gbk", "gb18030")
DEFAULT_FILE_ENCODING_CANDIDATES = ("utf-8", "gbk", "gb18030")
DOWNLOAD_BLOCKSIZE = 256 * 1024
DEFAULT_MAX_WORKERS = 4
CHUNKED_DOWNLOAD_THRESHOLD = 10 * 1024 * 1024
DEFAULT_CHUNK_COUNT = 4
SUSPICIOUS_MOJIBAKE_PATTERNS = (
    "涓",
    "鏂",
    "鐩",
    "褰",
    "鍐",
    "鍒",
    "鍚",
    "鍔",
    "璇",
    "杩",
    "锛",
    "銆",
    "宸蹭",
    "涓嬭",
    "瀹屾",
    "鏂囦欢",
    "Ã",
    "Â",
    "æ",
    "ç",
    "å",
)


def _format_size(value: float) -> str:
    if value < 1024:
        return f"{int(value)} B"
    if value < 1024 * 1024:
        return f"{value / 1024:.1f} KB"
    if value < 1024 * 1024 * 1024:
        return f"{value / (1024 * 1024):.1f} MB"
    return f"{value / (1024 * 1024 * 1024):.2f} GB"


def _format_time(seconds: float) -> str:
    seconds = max(0, int(seconds))
    minutes, secs = divmod(seconds, 60)
    hours, minutes = divmod(minutes, 60)
    if hours:
        return f"{hours}h{minutes:02d}m{secs:02d}s"
    if minutes:
        return f"{minutes}m{secs:02d}s"
    return f"{secs}s"


class DownloadProgress:
    def __init__(self, total_files: int, total_bytes: int, prefix: str = ""):
        self.total_files = total_files
        self.total_bytes = total_bytes
        self.prefix = prefix
        self.completed_files = 0
        self.completed_bytes = 0
        self._start_time = time.time()
        self._lock = threading.Lock()
        self._rendered = False

    def add_file(self) -> None:
        with self._lock:
            self.completed_files += 1

    def add_bytes(self, delta: int) -> None:
        with self._lock:
            self.completed_bytes += delta

    def snapshot(self) -> Tuple[int, int, float]:
        with self._lock:
            return self.completed_files, self.completed_bytes, time.time() - self._start_time

    def render(self) -> str:
        files, bytes_done, elapsed = self.snapshot()
        pct = min(99, bytes_done * 100 // self.total_bytes) if self.total_bytes > 0 else 0
        bar_width = 30
        filled = int(bar_width * bytes_done / self.total_bytes) if self.total_bytes > 0 else 0
        bar = "#" * filled + "-" * (bar_width - filled)
        speed = bytes_done / elapsed if elapsed > 0 else 0
        eta = (self.total_bytes - bytes_done) / speed if speed > 0 and self.total_bytes > 0 else 0
        parts = [
            f"[{bar}] {pct:3d}%",
        ]
        if self.total_files > 1:
            parts.append(f"{files}/{self.total_files} files")
        parts.extend([
            f"{_format_size(bytes_done)}/{_format_size(self.total_bytes)}",
            f"{_format_size(speed)}/s",
            f"ETA {_format_time(eta)}",
        ])
        line = f"\r{self.prefix} {' | '.join(parts)}"
        line = line.ljust(120)
        self._rendered = True
        return line

    def clear(self) -> str:
        if self._rendered:
            return "\r" + " " * 120 + "\r"
        return ""


@dataclass
class FTPConfig:
    host: str
    port: int
    username: str
    password: str
    ftp_encoding: str = "auto"
    timeout: int = 30


DEFAULT_CONFIG = FTPConfig(
    host=os.getenv("FTP_HOST", "220.175.120.251"),
    port=int(os.getenv("FTP_PORT", "21")),
    username=os.getenv("FTP_USER", "jxtinno"),
    password=os.getenv("FTP_PASSWORD", "tinno@2025"),
)

KNOWN_FTP_CREDENTIALS = {
    ("61.157.181.82", 18080): (
        os.getenv("FTP_USER_61_157_181_82_18080", "ftp_external"),
        os.getenv("FTP_PASSWORD_61_157_181_82_18080", "ftp_external"),
    ),
    ("61.157.181.82", 18081): (
        os.getenv("FTP_USER_61_157_181_82_18081", "ftp_external"),
        os.getenv("FTP_PASSWORD_61_157_181_82_18081", "ftp_external"),
    ),
    ("172.20.11.240", 21): (
        os.getenv("FTP_USER_172_20_11_240_21", "xasoftware"),
        os.getenv("FTP_PASSWORD_172_20_11_240_21", "Tinno@2022"),
    ),
    ("113.140.11.141", 21): (
        os.getenv("FTP_USER_113_140_11_141_21", "tianlong"),
        os.getenv("FTP_PASSWORD_113_140_11_141_21", "tianlong123"),
    ),
}

KNOWN_FTP_PATH_PREFIX_ALIASES = {
    ("61.157.181.82", 18080): (
        ("/share", "/"),
    ),
    ("61.157.181.82", 18081): (
        ("/sonic_agent", "/"),
    ),
    ("220.175.120.251", 21): (
        ("/home/jxtinno/sonic_tinno", "/"),
    ),
    ("172.20.11.240", 21): (),
    ("113.140.11.141", 21): (),
}


@contextmanager
def ftp_connection(config: FTPConfig) -> Generator[FTP, None, None]:
    ftp = FTP()
    ftp.encoding = config.ftp_encoding
    ftp.connect(config.host, config.port, timeout=config.timeout)
    ftp.login(config.username, config.password)
    try:
        yield ftp
    finally:
        try:
            ftp.quit()
        except all_errors:
            ftp.close()


def apply_known_ftp_credentials(config: FTPConfig) -> FTPConfig:
    credentials = KNOWN_FTP_CREDENTIALS.get((config.host, config.port))
    if credentials is None:
        return config
    if config.username != DEFAULT_CONFIG.username or config.password != DEFAULT_CONFIG.password:
        return config

    username, password = credentials
    return replace(config, username=username, password=password)


def apply_known_ftp_path_aliases(config: FTPConfig, remote_path: str) -> str:
    aliases = KNOWN_FTP_PATH_PREFIX_ALIASES.get((config.host, config.port), ())
    normalized_path = remote_path or "/"

    for source_prefix, target_prefix in aliases:
        source = source_prefix.rstrip("/") or "/"
        target = target_prefix.rstrip("/") or "/"

        if normalized_path == source:
            return target
        if normalized_path.startswith(f"{source}/"):
            suffix = normalized_path[len(source):]
            if target == "/":
                return suffix or "/"
            return f"{target}{suffix}"

    return normalized_path


def build_encoding_candidates(value: str, defaults: Iterable[str]) -> List[str]:
    normalized = (value or "").strip().lower()
    if not normalized or normalized == "auto":
        return list(defaults)
    return [value]


def run_ftp_operation(config: FTPConfig, operation: Callable[[FTP], T]) -> Tuple[T, str]:
    tried_encodings: List[str] = []
    last_decode_error: Optional[UnicodeDecodeError] = None

    for ftp_encoding in build_encoding_candidates(config.ftp_encoding, DEFAULT_FTP_ENCODING_CANDIDATES):
        tried_encodings.append(ftp_encoding)
        current_config = replace(config, ftp_encoding=ftp_encoding)
        try:
            with ftp_connection(current_config) as ftp:
                return operation(ftp), ftp_encoding
        except UnicodeDecodeError as exc:
            last_decode_error = exc

    if last_decode_error is not None:
        raise RuntimeError(
            "FTP 目录解码失败，已尝试编码：{}".format(", ".join(tried_encodings))
        ) from last_decode_error

    raise RuntimeError("FTP 操作失败，未执行到任何可用编码。")


def decode_text_content(content: bytes, encoding: str) -> Tuple[str, str]:
    tried_encodings: List[str] = []

    for current_encoding in build_encoding_candidates(encoding, DEFAULT_FILE_ENCODING_CANDIDATES):
        tried_encodings.append(current_encoding)
        try:
            return content.decode(current_encoding), current_encoding
        except UnicodeDecodeError:
            continue

    return decode_bytes_with_fallback(content, encoding, DEFAULT_FILE_ENCODING_CANDIDATES)


def score_decoded_text(text: str) -> Tuple[int, int, int]:
    suspicious_count = sum(text.count(pattern) for pattern in SUSPICIOUS_MOJIBAKE_PATTERNS)
    replace_count = text.count("\ufffd")
    control_count = sum(1 for char in text if ord(char) < 32 and char not in "\r\n\t")
    return suspicious_count, replace_count, control_count


def decode_bytes_with_fallback(content: bytes, encoding: str, defaults: Iterable[str]) -> Tuple[str, str]:
    candidates = build_encoding_candidates(encoding, defaults)
    best_text = ""
    best_encoding = ""
    best_score: Optional[Tuple[int, int, int]] = None

    for current_encoding in list(candidates) + ["latin-1"]:
        try:
            text = content.decode(current_encoding)
            encoding_label = current_encoding
        except UnicodeDecodeError:
            text = content.decode(current_encoding, errors="replace")
            encoding_label = f"{current_encoding}(replace)"

        current_score = score_decoded_text(text)
        if best_score is None or current_score < best_score:
            best_text = text
            best_encoding = encoding_label
            best_score = current_score

    return best_text, best_encoding


def list_remote_dir(ftp: FTP, remote_dir: str, decode_encoding: str = "auto") -> Tuple[List[str], str]:
    command = "LIST" if remote_dir in ("", ".") else f"LIST {remote_dir}"
    chunks: List[bytes] = []
    ftp.retrbinary(command, chunks.append)

    raw_data = b"".join(chunks)
    if not raw_data:
        return [], decode_encoding

    text, used_encoding = decode_bytes_with_fallback(raw_data, decode_encoding, DEFAULT_FTP_ENCODING_CANDIDATES)
    lines = [line for line in text.replace("\r\n", "\n").replace("\r", "\n").split("\n") if line]
    return lines, used_encoding


@dataclass
class RemotePathInfo:
    path: str
    path_type: str
    entries: Optional[List[str]] = None
    size: Optional[int] = None


@dataclass
class DownloadResult:
    remote_path: str
    local_path: Path
    path_type: str
    file_count: int = 0
    dir_count: int = 0


def normalize_remote_path(remote_path: str) -> str:
    normalized = (remote_path or "").strip()
    if not normalized:
        return "/"
    if normalized == "/":
        return normalized
    return normalized.rstrip("/")


def split_remote_path(remote_path: str) -> Tuple[str, str]:
    normalized = normalize_remote_path(remote_path)
    if normalized == "/":
        return "/", ""
    if "/" not in normalized:
        return ".", normalized
    parent, name = normalized.rsplit("/", 1)
    return parent or "/", name


def join_remote_path(parent: str, name: str) -> str:
    if parent in ("", "."):
        return name
    if parent == "/":
        return f"/{name}"
    return f"{parent.rstrip('/')}/{name}"


def parse_list_entry_name(entry: str) -> str:
    parts = entry.split(maxsplit=8)
    if len(parts) >= 9:
        name = parts[8]
        if parts[0].startswith("l") and " -> " in name:
            return name.split(" -> ", 1)[0]
        return name
    return entry.strip()


def is_remote_dir_entry(entry: str) -> bool:
    return bool(entry) and entry.startswith("d")


def is_remote_path_entry(entry: str) -> bool:
    return bool(entry) and entry[:1] in ("d", "-", "l")


def remote_path_basename(remote_path: str) -> str:
    _, name = split_remote_path(remote_path)
    return name or "ftp_root"


def build_remote_file_examples(remote_dir: str, entries: Optional[List[str]], limit: int = 3) -> List[str]:
    if not entries:
        return []

    examples: List[str] = []
    for entry in entries:
        if not is_remote_path_entry(entry) or is_remote_dir_entry(entry):
            continue
        entry_name = parse_list_entry_name(entry)
        if not entry_name:
            continue
        examples.append(join_remote_path(remote_dir, entry_name))
        if len(examples) >= limit:
            break
    return examples


def inspect_remote_path(ftp: FTP, remote_path: str) -> RemotePathInfo:
    normalized = normalize_remote_path(remote_path)
    original_dir: Optional[str] = None

    try:
        original_dir = ftp.pwd()
    except all_errors:
        original_dir = None

    is_directory = False
    try:
        ftp.cwd(normalized)
        is_directory = True
    except all_errors:
        is_directory = False
    finally:
        if original_dir is not None:
            try:
                ftp.cwd(original_dir)
            except all_errors:
                pass

    if is_directory:
        try:
            entries, _ = list_remote_dir(ftp, normalized, ftp.encoding)
        except all_errors:
            entries = []
        return RemotePathInfo(path=normalized, path_type="directory", entries=entries)

    try:
        ftp.voidcmd("TYPE I")
        size = ftp.size(normalized)
        if size is not None:
            return RemotePathInfo(path=normalized, path_type="file", size=size)
    except all_errors:
        pass

    parent_dir, expected_name = split_remote_path(normalized)
    try:
        entries, _ = list_remote_dir(ftp, parent_dir, ftp.encoding)
    except all_errors:
        return RemotePathInfo(path=normalized, path_type="missing")

    for entry in entries:
        if not is_remote_path_entry(entry):
            continue
        if parse_list_entry_name(entry) != expected_name:
            continue
        if is_remote_dir_entry(entry):
            try:
                child_entries, _ = list_remote_dir(ftp, normalized, ftp.encoding)
            except all_errors:
                child_entries = []
            return RemotePathInfo(path=normalized, path_type="directory", entries=child_entries)
        return RemotePathInfo(path=normalized, path_type="file")

    return RemotePathInfo(path=normalized, path_type="missing")


def ensure_remote_file(ftp: FTP, remote_path: str, action: str) -> str:
    info = inspect_remote_path(ftp, remote_path)
    if info.path_type == "file":
        return info.path

    if info.path_type == "directory":
        examples = build_remote_file_examples(info.path, info.entries)
        hint = ""
        if examples:
            hint = "。请改用目录中的具体文件，例如：{}".format("；".join(examples))
        raise RuntimeError(f"远程路径是目录，不能直接{action}：{info.path}{hint}")

    raise RuntimeError(f"远程路径不存在，或当前账号无权访问：{info.path}")


def read_remote_file(ftp: FTP, remote_file: str) -> bytes:
    remote_file = ensure_remote_file(ftp, remote_file, "读取文件")
    buffer = BytesIO()
    ftp.retrbinary(f"RETR {remote_file}", buffer.write, blocksize=DOWNLOAD_BLOCKSIZE)
    return buffer.getvalue()


def download_single_file(
    ftp: FTP,
    remote_file: str,
    local_file: Path,
    progress: "Optional[DownloadProgress]" = None,
) -> None:
    local_file.parent.mkdir(parents=True, exist_ok=True)
    temp_file = local_file.with_name(f"{local_file.name}.part")
    try:
        with temp_file.open("wb") as file_obj:
            _write_with_progress(ftp, remote_file, file_obj, progress)
        temp_file.replace(local_file)
    except Exception:
        if temp_file.exists():
            temp_file.unlink()
        raise


def resolve_local_download_path(remote_info: RemotePathInfo, local_path: Optional[Path]) -> Path:
    default_name = remote_path_basename(remote_info.path)
    if remote_info.path_type == "directory":
        target_dir = local_path if local_path is not None else Path(default_name)
        if target_dir.exists() and not target_dir.is_dir():
            raise RuntimeError(f"本地目标路径已存在且不是目录：{target_dir.resolve()}")
        return target_dir

    if local_path is None:
        return Path(default_name)
    if local_path.exists() and local_path.is_dir():
        return local_path / default_name
    return local_path


def download_remote_directory(
    ftp: FTP,
    remote_dir: str,
    local_dir: Path,
    entries: Optional[List[str]] = None,
) -> Tuple[int, int]:
    local_dir.mkdir(parents=True, exist_ok=True)
    file_count = 0
    dir_count = 1

    current_entries = entries
    if current_entries is None:
        current_entries, _ = list_remote_dir(ftp, remote_dir, ftp.encoding)

    for entry in current_entries:
        if not is_remote_path_entry(entry):
            continue

        entry_name = parse_list_entry_name(entry)
        if not entry_name or entry_name in (".", ".."):
            continue

        child_remote_path = join_remote_path(remote_dir, entry_name)
        child_local_path = local_dir / entry_name

        if is_remote_dir_entry(entry):
            child_file_count, child_dir_count = download_remote_directory(
                ftp,
                child_remote_path,
                child_local_path,
            )
            file_count += child_file_count
            dir_count += child_dir_count
            continue

        download_single_file(ftp, child_remote_path, child_local_path)
        file_count += 1

    return file_count, dir_count


def download_remote_file(
    ftp: FTP,
    remote_path: str,
    local_path: Optional[Path] = None,
    progress: "Optional[DownloadProgress]" = None,
) -> DownloadResult:
    remote_info = inspect_remote_path(ftp, remote_path)
    if remote_info.path_type == "missing":
        raise RuntimeError(f"远程路径不存在，或当前账号无权访问：{remote_info.path}")

    target_path = resolve_local_download_path(remote_info, local_path)
    if remote_info.path_type == "directory":
        file_count, dir_count = download_remote_directory(
            ftp,
            remote_info.path,
            target_path,
            remote_info.entries,
        )
        return DownloadResult(
            remote_path=remote_info.path,
            local_path=target_path,
            path_type="directory",
            file_count=file_count,
            dir_count=dir_count,
        )

    download_single_file(ftp, remote_info.path, target_path, progress)
    return DownloadResult(
        remote_path=remote_info.path,
        local_path=target_path,
        path_type="file",
        file_count=1,
    )


def format_download_message(result: DownloadResult) -> str:
    resolved_local_path = result.local_path.resolve()
    if result.path_type == "directory":
        return (
            f"递归下载完成：{resolved_local_path} "
            f"(目录 {result.dir_count} 个，文件 {result.file_count} 个)"
        )
    return f"下载完成：{resolved_local_path}"


def _try_get_size(ftp: FTP, remote_path: str) -> int:
    try:
        ftp.voidcmd("TYPE I")
        size = ftp.size(remote_path)
        return size if size is not None else 0
    except all_errors:
        return 0


def walk_remote_tree(ftp: FTP, remote_dir: str) -> "List[Tuple[str, str, int]]":
    files: "List[Tuple[str, str, int]]" = []

    def _walk(current_dir: str, rel_prefix: str) -> None:
        entries, _ = list_remote_dir(ftp, current_dir, ftp.encoding)
        for entry in entries:
            if not is_remote_path_entry(entry):
                continue
            entry_name = parse_list_entry_name(entry)
            if not entry_name or entry_name in (".", ".."):
                continue
            child_remote = join_remote_path(current_dir, entry_name)
            child_rel = f"{rel_prefix}/{entry_name}" if rel_prefix else entry_name
            if is_remote_dir_entry(entry):
                _walk(child_remote, child_rel)
            else:
                files.append((child_remote, child_rel, _try_get_size(ftp, child_remote)))

    _walk(remote_dir, "")
    return files


def _write_with_progress(
    ftp: FTP, remote_file: str, file_obj, progress: "Optional[DownloadProgress]"
) -> None:
    if progress is None:
        ftp.retrbinary(f"RETR {remote_file}", file_obj.write, blocksize=DOWNLOAD_BLOCKSIZE)
        return

    def _cb(data: bytes) -> None:
        file_obj.write(data)
        progress.add_bytes(len(data))

    ftp.retrbinary(f"RETR {remote_file}", _cb, blocksize=DOWNLOAD_BLOCKSIZE)


def download_single_file_parallel(
    config: FTPConfig,
    remote_file: str,
    local_file: Path,
    progress: "Optional[DownloadProgress]" = None,
) -> None:
    with ftp_connection(config) as ftp:
        local_file.parent.mkdir(parents=True, exist_ok=True)
        temp_file = local_file.with_name(f"{local_file.name}.part")
        try:
            with temp_file.open("wb") as fh:
                _write_with_progress(ftp, remote_file, fh, progress)
            temp_file.replace(local_file)
        except Exception:
            if temp_file.exists():
                temp_file.unlink()
            raise


def download_chunked_file(
    config: FTPConfig,
    remote_file: str,
    local_file: Path,
    file_size: int,
    chunk_count: int = DEFAULT_CHUNK_COUNT,
    progress: "Optional[DownloadProgress]" = None,
) -> None:
    chunk_size = file_size // chunk_count
    chunks: "List[Tuple[int, int]]" = []
    for i in range(chunk_count):
        start = i * chunk_size
        end = start + chunk_size - 1 if i < chunk_count - 1 else file_size - 1
        chunks.append((start, end))

    local_file.parent.mkdir(parents=True, exist_ok=True)
    part_files: "List[Tuple[int, Path]]" = []

    def _download_chunk(start: int, end: int, index: int) -> Path:
        part_file = local_file.with_name(f"{local_file.name}.part{index:04d}")
        expected = end - start + 1
        with ftp_connection(config) as ftp:
            ftp.voidcmd("TYPE I")
            with part_file.open("wb") as fh:
                with ftp.transfercmd(f"RETR {remote_file}", rest=start) as conn:
                    bytes_read = 0
                    while bytes_read < expected:
                        chunk_data = conn.recv(min(DOWNLOAD_BLOCKSIZE, expected - bytes_read))
                        if not chunk_data:
                            break
                        fh.write(chunk_data)
                        bytes_read += len(chunk_data)
                        if progress is not None:
                            progress.add_bytes(len(chunk_data))
                try:
                    ftp.voidresp()
                except all_errors:
                    pass

            actual_size = part_file.stat().st_size
            if actual_size != expected:
                raise RuntimeError(
                    f"Chunk {index} size mismatch: expected {expected}, got {actual_size}"
                )
            return part_file

    try:
        with ThreadPoolExecutor(max_workers=min(chunk_count, len(chunks))) as executor:
            futures = {
                executor.submit(_download_chunk, start, end, i): i
                for i, (start, end) in enumerate(chunks)
            }
            for future in as_completed(futures):
                i = futures[future]
                part_files.append((i, future.result()))

        part_files.sort(key=lambda x: x[0])
        temp_file = local_file.with_name(f"{local_file.name}.part")
        with temp_file.open("wb") as outf:
            for _, pf in part_files:
                with pf.open("rb") as inf:
                    while True:
                        data = inf.read(DOWNLOAD_BLOCKSIZE)
                        if not data:
                            break
                        outf.write(data)
                pf.unlink()
        temp_file.replace(local_file)
    except Exception:
        for _, pf in part_files:
            if pf.exists():
                pf.unlink()
        raise


def should_use_chunked_file_download(
    file_size: int,
    chunk_threshold: int = CHUNKED_DOWNLOAD_THRESHOLD,
    chunk_count: int = DEFAULT_CHUNK_COUNT,
) -> bool:
    """Whether a single file should use REST chunked download (independent of --workers)."""
    return file_size >= chunk_threshold and chunk_count > 1


def _chunked_download_is_truncated(
    config: FTPConfig,
    remote_file: str,
    local_file: Path,
    scanned_size: int,
) -> bool:
    """Detect stale/partial SIZE from directory scan that would truncate REST chunks."""
    if not local_file.is_file():
        return True
    local_size = local_file.stat().st_size
    if scanned_size > 0 and local_size < scanned_size:
        return True
    with ftp_connection(config) as ftp:
        remote_size = _try_get_size(ftp, remote_file)
    return remote_size > 0 and local_size < remote_size


def download_file_with_progress(
    config: FTPConfig,
    remote_file: str,
    local_file: Path,
    file_size: int,
    chunk_threshold: int,
    chunk_count: int,
    progress: "Optional[DownloadProgress]" = None,
) -> None:
    """Download one remote file; use chunked REST when eligible, else single connection."""
    if should_use_chunked_file_download(file_size, chunk_threshold, chunk_count):
        try:
            download_chunked_file(
                config, remote_file, local_file, file_size, chunk_count, progress
            )
            if _chunked_download_is_truncated(config, remote_file, local_file, file_size):
                local_size = local_file.stat().st_size if local_file.is_file() else 0
                if local_file.exists():
                    local_file.unlink()
                raise RuntimeError(
                    f"chunked download truncated (local={local_size}, scanned={file_size})"
                )
            return
        except (RuntimeError,) + all_errors as exc:
            _safe_print(
                f"[warn] 分块下载失败，回退单连接：{remote_file} ({exc})\n"
            )
    download_single_file_parallel(config, remote_file, local_file, progress)


def _render_loop(progress: DownloadProgress, stop_event: threading.Event) -> None:
    while not stop_event.wait(0.25):
        _safe_print(progress.render())
    _safe_print(progress.render())


def _safe_print(text: str) -> None:
    try:
        print(text, end="", file=sys.stderr, flush=True)
    except UnicodeEncodeError:
        print(text.encode("ascii", errors="replace").decode("ascii"), end="", file=sys.stderr, flush=True)


def parallel_download_directory(
    config: FTPConfig,
    remote_dir: str,
    local_dir: Path,
    max_workers: int,
    chunk_threshold: int = CHUNKED_DOWNLOAD_THRESHOLD,
    chunk_count: int = DEFAULT_CHUNK_COUNT,
) -> DownloadResult:
    print(f"[scanning] {remote_dir} ...", file=sys.stderr, flush=True)
    with ftp_connection(config) as ftp:
        file_list = walk_remote_tree(ftp, remote_dir)

    if not file_list:
        return DownloadResult(
            remote_path=remote_dir,
            local_path=local_dir,
            path_type="directory",
            file_count=0,
            dir_count=1,
        )

    total_bytes = sum(sz for _, _, sz in file_list)
    dirs: "List[Path]" = []
    seen: set = set()
    for _, rel_path, _ in file_list:
        parent = os.path.dirname(rel_path)
        if parent and parent not in seen:
            seen.add(parent)
            dir_path = local_dir / parent
            dir_path.mkdir(parents=True, exist_ok=True)
            dirs.append(dir_path)

    large_count = sum(1 for _, _, sz in file_list if sz >= chunk_threshold and chunk_count > 1)
    if large_count:
        print(
            f"[{remote_dir}] {len(file_list)} files, {_format_size(total_bytes)}, "
            f"{large_count} large (>= {_format_size(chunk_threshold)}, {chunk_count}-chunked)",
            file=sys.stderr,
        )

    progress = DownloadProgress(len(file_list), total_bytes)

    def _download_one(rp: str, rel: str, sz: int) -> None:
        local = local_dir / rel
        download_file_with_progress(
            config, rp, local, sz, chunk_threshold, chunk_count, progress
        )
        progress.add_file()

    stop_event = threading.Event()
    render_thread = threading.Thread(
        target=_render_loop, args=(progress, stop_event), daemon=True
    )
    render_thread.start()
    try:
        with ThreadPoolExecutor(max_workers=max_workers) as executor:
            futures = [
                executor.submit(_download_one, rp, rel, sz)
                for rp, rel, sz in file_list
            ]
            for future in as_completed(futures):
                future.result()
    finally:
        stop_event.set()
        render_thread.join(timeout=2)

    elapsed = max(time.time() - progress._start_time, 0.001)
    print(
        f"\r  {len(file_list)}/{len(file_list)} files | {_format_size(total_bytes)} | "
        f"{_format_size(total_bytes / elapsed)}/s | done in {_format_time(elapsed)}",
        file=sys.stderr,
    )

    return DownloadResult(
        remote_path=remote_dir,
        local_path=local_dir,
        path_type="directory",
        file_count=len(file_list),
        dir_count=len(dirs) + 1,
    )


def is_ipv4_address(value: str) -> bool:
    parts = (value or "").split(".")
    if len(parts) != 4:
        return False
    for part in parts:
        if not part.isdigit():
            return False
        part_value = int(part)
        if part_value < 0 or part_value > 255:
            return False
    return True


def split_host_and_port(value: str, default_port: int) -> Tuple[str, int]:
    normalized = (value or "").strip()
    if ":" not in normalized:
        return normalized, default_port

    host_part, port_part = normalized.rsplit(":", 1)
    if not host_part or not port_part.isdigit():
        return normalized, default_port
    return host_part, int(port_part)


def normalize_ftp_target(raw_target: str) -> str:
    normalized = (raw_target or "").strip()
    if not normalized:
        return normalized
    return normalized.replace("\\", "/")


def resolve_ftp_target(config: FTPConfig, raw_target: str) -> Tuple[FTPConfig, str, Optional[str]]:
    normalized = normalize_ftp_target(raw_target)
    if not normalized:
        return config, "/", None

    if normalized.lower().startswith("ftp://"):
        parsed = urlsplit(normalized)
        if not parsed.hostname:
            raise RuntimeError(f"无法从 FTP 地址中识别主机：{raw_target}")

        resolved_config = apply_known_ftp_credentials(replace(
            config,
            host=parsed.hostname,
            port=parsed.port or config.port,
        ))
        remote_path = apply_known_ftp_path_aliases(resolved_config, parsed.path or "/")
        note = f"已从输入中识别 FTP 主机：{resolved_config.host}:{resolved_config.port}"
        return resolved_config, remote_path, note

    if normalized.startswith("/"):
        components = [c for c in normalized.strip("/").split("/") if c]
        if components:
            first, first_port = split_host_and_port(components[0], config.port)
            if is_ipv4_address(first):
                remainder = "/" + "/".join(components[1:]) if len(components) > 1 else "/"
                resolved_config = apply_known_ftp_credentials(
                    replace(config, host=first, port=first_port)
                )
                remote_path = apply_known_ftp_path_aliases(resolved_config, remainder)
                note = f"已从输入中识别 FTP 主机：{resolved_config.host}:{resolved_config.port}"
                return resolved_config, remote_path, note
        return config, apply_known_ftp_path_aliases(config, normalized), None

    candidate_host, candidate_port = split_host_and_port(normalized.split("/", 1)[0], config.port)
    if candidate_host == config.host or is_ipv4_address(candidate_host):
        _, _, remainder = normalized.partition("/")
        remote_path = f"/{remainder}" if remainder else "/"
        resolved_config = apply_known_ftp_credentials(
            replace(config, host=candidate_host, port=candidate_port)
        )
        remote_path = apply_known_ftp_path_aliases(resolved_config, remote_path)
        note = f"已从输入中识别 FTP 主机：{resolved_config.host}:{resolved_config.port}"
        return resolved_config, remote_path, note

    return config, normalized, None


def resolve_command_target(
    config: FTPConfig,
    args: argparse.Namespace,
) -> Tuple[FTPConfig, str, Optional[str]]:
    normalized_command = normalize_command_name(args.command)
    if normalized_command == "list":
        return resolve_ftp_target(config, args.remote_dir)
    if normalized_command == "read":
        return resolve_ftp_target(config, args.remote_file)
    if normalized_command == "download":
        return resolve_ftp_target(config, args.remote_path)
    return config, "/", None


def normalize_command_name(command: Optional[str]) -> str:
    alias_map = {
        "ls": "list",
        "cat": "read",
    }
    normalized = (command or "").strip().lower()
    return alias_map.get(normalized, normalized)


def build_ftp_config_from_args(args: argparse.Namespace) -> FTPConfig:
    return apply_known_ftp_credentials(FTPConfig(
        host=args.ftp_host,
        port=args.ftp_port,
        username=args.ftp_username,
        password=args.ftp_password,
        ftp_encoding=args.ftp_encoding,
        timeout=args.timeout,
    ))


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="FTP 文件读取脚本，支持列目录、读取文本文件、下载文件。"
    )
    parser.add_argument(
        "--ftp-host",
        "--host",
        dest="ftp_host",
        default=DEFAULT_CONFIG.host,
        help="FTP 服务器 IP 或域名",
    )
    parser.add_argument(
        "--ftp-port",
        "--port",
        dest="ftp_port",
        type=int,
        default=DEFAULT_CONFIG.port,
        help="FTP 端口号",
    )
    parser.add_argument(
        "--ftp-username",
        "--user",
        dest="ftp_username",
        default=DEFAULT_CONFIG.username,
        help="FTP 账户名",
    )
    parser.add_argument(
        "--ftp-password",
        "--password",
        dest="ftp_password",
        default=DEFAULT_CONFIG.password,
        help="FTP 密码",
    )
    parser.add_argument(
        "--ftp-encoding",
        default=DEFAULT_CONFIG.ftp_encoding,
        help="FTP 控制连接编码，默认 auto，会依次尝试 utf-8、gbk、gb18030",
    )
    parser.add_argument("--timeout", type=int, default=DEFAULT_CONFIG.timeout, help="连接超时秒数")

    subparsers = parser.add_subparsers(dest="command", required=True)

    list_parser = subparsers.add_parser("list", aliases=["ls"], help="列出远程目录内容")
    list_parser.add_argument(
        "remote_dir",
        nargs="?",
        default="/",
        help="远程目录，默认 /；支持直接传入 主机/目录 或 ftp://主机/目录",
    )

    read_parser = subparsers.add_parser("read", aliases=["cat"], help="读取远程文本文件内容")
    read_parser.add_argument(
        "remote_file",
        help="远程文件路径；支持直接传入 主机/文件路径 或 ftp://主机/文件路径",
    )
    read_parser.add_argument(
        "--file-encoding",
        default="auto",
        help="文本文件编码，默认 auto，会依次尝试 utf-8、gbk、gb18030",
    )
    read_parser.add_argument(
        "--save",
        help="可选：将读取到的文件同时保存到本地，例如 .\\output.txt",
    )

    download_parser = subparsers.add_parser("download", help="下载远程文件或目录到本地")
    download_parser.add_argument(
        "remote_path",
        help="远程文件或目录路径；支持直接传入 主机/路径 或 ftp://主机/路径",
    )
    download_parser.add_argument(
        "local_file",
        nargs="?",
        help="本地保存路径。远程文件默认保存为同名文件，远程目录默认递归保存为同名目录",
    )
    download_parser.add_argument(
        "-w", "--workers",
        type=int,
        default=DEFAULT_MAX_WORKERS,
        help=(
            f"目录并行下载线程数，默认 {DEFAULT_MAX_WORKERS}，设为 1 则目录串行；"
            "单文件 ≥ 阈值时分块并行由 --chunks 控制，不受此参数影响"
        ),
    )
    download_parser.add_argument(
        "--large-threshold",
        type=int,
        default=CHUNKED_DOWNLOAD_THRESHOLD,
        help=f"大文件分块阈值（字节），默认 {CHUNKED_DOWNLOAD_THRESHOLD}（10MB）",
    )
    download_parser.add_argument(
        "--chunks",
        type=int,
        default=DEFAULT_CHUNK_COUNT,
        help=f"大文件分块数，默认 {DEFAULT_CHUNK_COUNT}，设为 1 禁用分块",
    )

    return parser


def safe_main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    normalized_command = normalize_command_name(args.command)

    config = build_ftp_config_from_args(args)
    config, resolved_target, target_note = resolve_command_target(config, args)

    try:
        if target_note:
            print(target_note, file=sys.stderr)

        if normalized_command == "list":
            (entries, used_list_encoding), _ = run_ftp_operation(
                config,
                lambda ftp: list_remote_dir(ftp, resolved_target, args.ftp_encoding),
            )
            if (args.ftp_encoding or "").strip().lower() == "auto":
                print(f"已自动选择目录编码：{used_list_encoding}", file=sys.stderr)

            if not entries:
                print("远程目录为空。")
            else:
                print("\n".join(entries))
            return 0

        if normalized_command == "read":
            content, _ = run_ftp_operation(
                config,
                lambda ftp: read_remote_file(ftp, resolved_target),
            )

            if args.save:
                save_path = Path(args.save)
                save_path.parent.mkdir(parents=True, exist_ok=True)
                save_path.write_bytes(content)
                print(f"文件已保存到本地：{save_path.resolve()}", file=sys.stderr)

            text, used_file_encoding = decode_text_content(content, args.file_encoding)
            if (args.file_encoding or "").strip().lower() == "auto":
                print(f"已自动选择文件编码：{used_file_encoding}", file=sys.stderr)
            print(text)
            return 0

        if normalized_command == "download":
            local_path = Path(args.local_file) if args.local_file else None
            workers = getattr(args, 'workers', DEFAULT_MAX_WORKERS)
            chunk_threshold = getattr(args, 'large_threshold', CHUNKED_DOWNLOAD_THRESHOLD)
            chunks = getattr(args, 'chunks', DEFAULT_CHUNK_COUNT)

            def _inspect(ftp: FTP) -> RemotePathInfo:
                return inspect_remote_path(ftp, resolved_target)

            remote_info, used_encoding = run_ftp_operation(config, _inspect)
            if remote_info.path_type == "missing":
                raise RuntimeError(f"远程路径不存在，或当前账号无权访问：{remote_info.path}")

            config = replace(config, ftp_encoding=used_encoding)

            if remote_info.path_type == "directory" and workers > 1:
                target_path = resolve_local_download_path(remote_info, local_path)
                target_path.mkdir(parents=True, exist_ok=True)
                download_result = parallel_download_directory(
                    config, remote_info.path, target_path, workers,
                    chunk_threshold=chunk_threshold,
                    chunk_count=chunks,
                )
            elif (
                remote_info.path_type == "file"
                and should_use_chunked_file_download(
                    remote_info.size or 0, chunk_threshold, chunks
                )
            ):
                file_size = remote_info.size or 0
                target_path = resolve_local_download_path(remote_info, local_path)
                progress = DownloadProgress(1, file_size)
                stop_event = threading.Event()
                render_thread = threading.Thread(
                    target=_render_loop, args=(progress, stop_event), daemon=True,
                )
                render_thread.start()
                try:
                    download_file_with_progress(
                        config,
                        remote_info.path,
                        target_path,
                        file_size,
                        chunk_threshold,
                        chunks,
                        progress,
                    )
                    progress.add_file()
                finally:
                    stop_event.set()
                    render_thread.join(timeout=2)
                download_result = DownloadResult(
                    remote_path=remote_info.path,
                    local_path=target_path,
                    path_type="file",
                    file_count=1,
                )
            else:
                progress = None
                stop_event = None
                render_thread = None
                if remote_info.path_type == "file" and remote_info.size:
                    progress = DownloadProgress(1, remote_info.size)
                    stop_event = threading.Event()
                    render_thread = threading.Thread(
                        target=_render_loop, args=(progress, stop_event), daemon=True,
                    )
                    render_thread.start()
                try:
                    download_result, _ = run_ftp_operation(
                        config,
                        lambda ftp: download_remote_file(
                            ftp, resolved_target, local_path, progress,
                        ),
                    )
                    if progress is not None:
                        progress.add_file()
                finally:
                    if stop_event is not None:
                        stop_event.set()
                    if render_thread is not None:
                        render_thread.join(timeout=2)

            print(format_download_message(download_result))
            return 0

        parser.print_help()
        return 1
    except RuntimeError as exc:
        print(f"处理失败：{exc}", file=sys.stderr)
        return 1
    except all_errors as exc:
        print(f"FTP 操作失败：{exc}", file=sys.stderr)
        return 1
    except OSError as exc:
        print(f"本地文件操作失败：{exc}", file=sys.stderr)
        return 1


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()
    normalized_command = normalize_command_name(args.command)

    config = build_ftp_config_from_args(args)
    config, resolved_target, _ = resolve_command_target(config, args)

    try:
        with ftp_connection(config) as ftp:
            if normalized_command == "list":
                entries = list_remote_dir(ftp, resolved_target)
                if not entries:
                    print("远程目录为空。")
                else:
                    print("\n".join(entries))
                return 0

            if normalized_command == "read":
                content = read_remote_file(ftp, resolved_target)
                if args.save:
                    save_path = Path(args.save)
                    save_path.parent.mkdir(parents=True, exist_ok=True)
                    save_path.write_bytes(content)
                    print(f"文件已保存到本地：{save_path.resolve()}")

                text = content.decode(args.file_encoding, errors="replace")
                print(text)
                return 0

            if normalized_command == "download":
                local_path = Path(args.local_file) if args.local_file else None
                download_result = download_remote_file(ftp, resolved_target, local_path)
                print(format_download_message(download_result))
                return 0

            parser.print_help()
            return 1
    except all_errors as exc:
        print(f"FTP 操作失败：{exc}", file=sys.stderr)
        return 1
    except OSError as exc:
        print(f"本地文件操作失败：{exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(safe_main())
