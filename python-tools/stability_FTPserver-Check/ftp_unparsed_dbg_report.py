#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
递归扫描 FTP 指定目录下未解析的 dbg 文件，并导出 Excel 报表。

判定规则：
1. 当前目录存在 *.dbg 文件
2. 同级目录不存在同名的 *.dbg.DEC 文件夹
3. 满足以上条件则视为“未解析 dbg”

示例：
    python ftp_unparsed_dbg_report.py
    python ftp_unparsed_dbg_report.py --root-path /X6851B-OP_16.3.0.019_SU_0319_MonkeyAEEinfo
    python ftp_unparsed_dbg_report.py --output .\\未解析dbg清单.xlsx
    python ftp_unparsed_dbg_report.py --ftp-encoding gbk
"""

import argparse
import posixpath
import re
import sys
from collections import deque
from dataclasses import dataclass
from pathlib import Path
from typing import Deque, Dict, Iterable, List, Optional, Sequence, Tuple

from openpyxl import Workbook
from openpyxl.styles import Font

from ftp_reader_20260626 import (
    DEFAULT_CONFIG,
    DEFAULT_FTP_ENCODING_CANDIDATES,
    FTPConfig,
    decode_bytes_with_fallback,
    ftp_connection,
)


WINDOWS_LISTING_RE = re.compile(
    r"^(?P<date>\d{2}-\d{2}-\d{2,4})\s+"
    r"(?P<time>\d{2}:\d{2}(?:AM|PM))\s+"
    r"(?:(?P<dir>\<DIR\>)|(?P<size>\d+))\s+"
    r"(?P<name>.+)$",
    re.IGNORECASE,
)

UNIX_LISTING_RE = re.compile(
    r"^(?P<type>[bcdlfmpSs-])[rwxStTs-]{9}\s+"
    r"\d+\s+\S+\s+\S+\s+\d+\s+"
    r"[A-Z][a-z]{2}\s+\d{1,2}\s+(?:\d{2}:\d{2}|\d{4})\s+"
    r"(?P<name>.+)$"
)


@dataclass
class FTPEntry:
    name: str
    full_path: str
    is_dir: bool


def normalize_remote_path(remote_path: str) -> str:
    normalized = (remote_path or "/").strip()
    if not normalized.startswith("/"):
        normalized = "/" + normalized
    normalized = posixpath.normpath(normalized)
    return normalized if normalized != "." else "/"


def join_remote_path(parent: str, name: str) -> str:
    if parent == "/":
        return "/" + name
    return posixpath.join(parent.rstrip("/"), name)


def list_directory_lines(ftp, remote_dir: str, decode_encoding: str) -> Tuple[List[str], str]:
    command = "LIST" if remote_dir in ("", ".") else f"LIST {remote_dir}"
    chunks: List[bytes] = []
    ftp.retrbinary(command, chunks.append)

    raw_data = b"".join(chunks)
    if not raw_data:
        return [], decode_encoding

    text, used_encoding = decode_bytes_with_fallback(
        raw_data,
        decode_encoding,
        DEFAULT_FTP_ENCODING_CANDIDATES,
    )
    lines = [line for line in text.replace("\r\n", "\n").replace("\r", "\n").split("\n") if line.strip()]
    return lines, used_encoding


def parse_listing_line(line: str, parent_dir: str) -> Optional[FTPEntry]:
    windows_match = WINDOWS_LISTING_RE.match(line)
    if windows_match:
        name = windows_match.group("name").strip()
        if name in (".", ".."):
            return None
        return FTPEntry(
            name=name,
            full_path=join_remote_path(parent_dir, name),
            is_dir=windows_match.group("dir") is not None,
        )

    unix_match = UNIX_LISTING_RE.match(line)
    if unix_match:
        raw_name = unix_match.group("name").strip()
        if " -> " in raw_name and unix_match.group("type").lower() == "l":
            raw_name = raw_name.split(" -> ", 1)[0].strip()
        if raw_name in (".", ".."):
            return None
        return FTPEntry(
            name=raw_name,
            full_path=join_remote_path(parent_dir, raw_name),
            is_dir=unix_match.group("type").lower() == "d",
        )

    return None


def collect_entries(ftp, remote_dir: str, decode_encoding: str) -> Tuple[List[FTPEntry], str, List[str]]:
    lines, used_encoding = list_directory_lines(ftp, remote_dir, decode_encoding)
    entries: List[FTPEntry] = []
    unparsed_lines: List[str] = []

    for line in lines:
        entry = parse_listing_line(line, remote_dir)
        if entry is None:
            unparsed_lines.append(line)
            continue
        entries.append(entry)

    return entries, used_encoding, unparsed_lines


def find_unparsed_dbg_files(ftp, root_dir: str, decode_encoding: str) -> Tuple[List[Dict[str, str]], List[str]]:
    normalized_root = normalize_remote_path(root_dir)
    queue: Deque[str] = deque([normalized_root])
    visited = {normalized_root}
    results: List[Dict[str, str]] = []
    warnings: List[str] = []

    while queue:
        current_dir = queue.popleft()
        print(f"正在扫描：{current_dir}", file=sys.stderr)

        entries, used_encoding, unparsed_lines = collect_entries(ftp, current_dir, decode_encoding)
        if (decode_encoding or "").strip().lower() == "auto":
            print(f"目录编码：{used_encoding} -> {current_dir}", file=sys.stderr)

        for raw_line in unparsed_lines:
            warnings.append(f"目录 {current_dir} 存在无法识别的列表行：{raw_line}")

        dir_name_set = {entry.name.lower() for entry in entries if entry.is_dir}

        for entry in entries:
            lower_name = entry.name.lower()
            if entry.is_dir:
                if lower_name.endswith(".dbg.dec"):
                    continue
                if entry.full_path not in visited:
                    visited.add(entry.full_path)
                    queue.append(entry.full_path)
                continue

            if not lower_name.endswith(".dbg"):
                continue

            expected_dec_dir_name = f"{entry.name}.DEC"
            if expected_dec_dir_name.lower() in dir_name_set:
                continue

            results.append(
                {
                    "dbg文件名": entry.name,
                    "dbg文件路径": entry.full_path,
                    "所在目录": current_dir,
                    "期望DEC目录": join_remote_path(current_dir, expected_dec_dir_name),
                    "状态": "未解析",
                }
            )

    return results, warnings


def autosize_columns(worksheet) -> None:
    for column_cells in worksheet.columns:
        max_length = 0
        column_letter = column_cells[0].column_letter
        for cell in column_cells:
            value = "" if cell.value is None else str(cell.value)
            max_length = max(max_length, len(value))
        worksheet.column_dimensions[column_letter].width = min(max(max_length + 2, 12), 80)


def export_to_excel(records: Sequence[Dict[str, str]], warnings: Sequence[str], output_file: Path) -> None:
    workbook = Workbook()

    data_sheet = workbook.active
    data_sheet.title = "未解析DBG"
    headers = ["序号", "dbg文件名", "dbg文件路径", "所在目录", "期望DEC目录", "状态"]
    data_sheet.append(headers)

    for cell in data_sheet[1]:
        cell.font = Font(bold=True)

    if records:
        for index, record in enumerate(records, start=1):
            data_sheet.append(
                [
                    index,
                    record["dbg文件名"],
                    record["dbg文件路径"],
                    record["所在目录"],
                    record["期望DEC目录"],
                    record["状态"],
                ]
            )
    else:
        data_sheet.append([1, "-", "-", "-", "-", "未发现未解析dbg"])

    autosize_columns(data_sheet)

    summary_sheet = workbook.create_sheet("扫描摘要")
    summary_rows = [
        ("未解析dbg数量", len(records)),
        ("警告数量", len(warnings)),
    ]
    for row in summary_rows:
        summary_sheet.append(row)

    summary_sheet["A1"].font = Font(bold=True)
    summary_sheet["A2"].font = Font(bold=True)

    if warnings:
        summary_sheet.append(())
        summary_sheet.append(("警告明细",))
        summary_sheet["A4"].font = Font(bold=True)
        for warning in warnings:
            summary_sheet.append((warning,))

    autosize_columns(summary_sheet)

    output_file.parent.mkdir(parents=True, exist_ok=True)
    workbook.save(output_file)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description="扫描 FTP 目录中的未解析 dbg 文件并导出 Excel。")
    parser.add_argument("--host", default=DEFAULT_CONFIG.host, help="FTP 服务器地址")
    parser.add_argument("--port", type=int, default=DEFAULT_CONFIG.port, help="FTP 端口")
    parser.add_argument("--user", default=DEFAULT_CONFIG.username, help="FTP 用户名")
    parser.add_argument("--password", default=DEFAULT_CONFIG.password, help="FTP 密码")
    parser.add_argument(
        "--ftp-encoding",
        default="auto",
        help="FTP 目录列表编码，默认 auto，会自动尝试 utf-8、gbk、gb18030",
    )
    parser.add_argument("--timeout", type=int, default=30, help="连接超时秒数")
    parser.add_argument(
        "--root-path",
        default="/X6851B-OP_16.3.0.019_SU_0319_MonkeyAEEinfo",
        help="需要递归扫描的 FTP 根目录",
    )
    parser.add_argument(
        "--output",
        default="未解析dbg清单.xlsx",
        help="Excel 输出路径，默认当前目录下的 未解析dbg清单.xlsx",
    )
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    config = FTPConfig(
        host=args.host,
        port=args.port,
        username=args.user,
        password=args.password,
        ftp_encoding="utf-8" if (args.ftp_encoding or "").strip().lower() == "auto" else args.ftp_encoding,
        timeout=args.timeout,
    )

    output_file = Path(args.output)
    root_dir = normalize_remote_path(args.root_path)

    try:
        with ftp_connection(config) as ftp:
            records, warnings = find_unparsed_dbg_files(ftp, root_dir, args.ftp_encoding)

        export_to_excel(records, warnings, output_file)

        print(f"扫描完成，未解析dbg数量：{len(records)}")
        print(f"Excel 已生成：{output_file.resolve()}")
        if warnings:
            print(f"扫描中发现 {len(warnings)} 条目录解析警告，详情已写入 Excel 的“扫描摘要”页。")
        return 0
    except Exception as exc:
        print(f"执行失败：{exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
