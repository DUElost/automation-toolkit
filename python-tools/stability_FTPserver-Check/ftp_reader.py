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
    python ftp_reader.py download /remote/path/demo.zip .\demo.zip
"""

import argparse
import os
import sys
from contextlib import contextmanager
from dataclasses import dataclass, replace
from ftplib import FTP, all_errors
from io import BytesIO
from pathlib import Path
from typing import Callable, Generator, Iterable, List, Optional, Tuple, TypeVar


T = TypeVar("T")

DEFAULT_FTP_ENCODING_CANDIDATES = ("utf-8", "gbk", "gb18030")
DEFAULT_FILE_ENCODING_CANDIDATES = ("utf-8", "gbk", "gb18030")
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
    ftp.retrbinary(f"RETR {remote_file}", buffer.write)
    return buffer.getvalue()


def download_single_file(ftp: FTP, remote_file: str, local_file: Path) -> None:
    local_file.parent.mkdir(parents=True, exist_ok=True)
    temp_file = local_file.with_name(f"{local_file.name}.part")
    try:
        with temp_file.open("wb") as file_obj:
            ftp.retrbinary(f"RETR {remote_file}", file_obj.write)
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


def download_remote_file(ftp: FTP, remote_path: str, local_path: Optional[Path] = None) -> DownloadResult:
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

    download_single_file(ftp, remote_info.path, target_path)
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


def build_ftp_config_from_args(args: argparse.Namespace) -> FTPConfig:
    return FTPConfig(
        host=args.ftp_host,
        port=args.ftp_port,
        username=args.ftp_username,
        password=args.ftp_password,
        ftp_encoding=args.ftp_encoding,
        timeout=args.timeout,
    )


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

    list_parser = subparsers.add_parser("list", help="列出远程目录内容")
    list_parser.add_argument("remote_dir", nargs="?", default="/", help="远程目录，默认 /")

    read_parser = subparsers.add_parser("read", help="读取远程文本文件内容")
    read_parser.add_argument("remote_file", help="远程文件路径")
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
    download_parser.add_argument("remote_path", help="远程文件或目录路径")
    download_parser.add_argument(
        "local_file",
        nargs="?",
        help="本地保存路径。远程文件默认保存为同名文件，远程目录默认递归保存为同名目录",
    )

    return parser


def safe_main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    config = build_ftp_config_from_args(args)

    try:
        if args.command == "list":
            (entries, used_list_encoding), _ = run_ftp_operation(
                config,
                lambda ftp: list_remote_dir(ftp, args.remote_dir, args.ftp_encoding),
            )
            if (args.ftp_encoding or "").strip().lower() == "auto":
                print(f"已自动选择目录编码：{used_list_encoding}", file=sys.stderr)

            if not entries:
                print("远程目录为空。")
            else:
                print("\n".join(entries))
            return 0

        if args.command == "read":
            content, _ = run_ftp_operation(
                config,
                lambda ftp: read_remote_file(ftp, args.remote_file),
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

        if args.command == "download":
            local_path = Path(args.local_file) if args.local_file else None
            download_result, _ = run_ftp_operation(
                config,
                lambda ftp: download_remote_file(ftp, args.remote_path, local_path),
            )
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

    config = build_ftp_config_from_args(args)

    try:
        with ftp_connection(config) as ftp:
            if args.command == "list":
                entries = list_remote_dir(ftp, args.remote_dir)
                if not entries:
                    print("远程目录为空。")
                else:
                    print("\n".join(entries))
                return 0

            if args.command == "read":
                content = read_remote_file(ftp, args.remote_file)
                if args.save:
                    save_path = Path(args.save)
                    save_path.parent.mkdir(parents=True, exist_ok=True)
                    save_path.write_bytes(content)
                    print(f"文件已保存到本地：{save_path.resolve()}")

                text = content.decode(args.file_encoding, errors="replace")
                print(text)
                return 0

            if args.command == "download":
                local_path = Path(args.local_file) if args.local_file else None
                download_result = download_remote_file(ftp, args.remote_path, local_path)
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
