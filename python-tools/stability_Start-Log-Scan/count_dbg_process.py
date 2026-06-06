#!/usr/bin/env python3
"""
独立脚本：统计 dbg 目录中各进程/包名的出现次数，按数量降序排列。
用法: python3 count_dbg_process.py -d <扫描目录> [-n <前N条>] [-c] [-o <输出文件>] [-p <示例路径数>]
"""

import os
import argparse
from collections import Counter, defaultdict


def is_dbg_file(file_name):
    return file_name.endswith(".dbg") or (
        file_name.startswith("db.")
        and "_analyze_report" not in file_name
        and not file_name.endswith(".txt")
    )


def parse_zz_internal(file_path):
    """
    解析 ZZ_INTERNAL 文件，返回 (cur_process, exp_class)。
    逻辑与 zz_internal.py 中 __analyse 方法保持一致。
    """
    if not os.path.isfile(file_path):
        return ("ZZ_INTERNAL_MISSING", "")

    try:
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            content = f.read().strip()
            if not content:
                return ("EMPTY_ZZ_INTERNAL", "")

            parts = content.split(",")

            exp_class = parts[0] if len(parts) > 0 else ""
            cur_process = ""

            if exp_class in ("Externel (EE)", "External (EE)"):
                lower = content.lower()
                if "scp" in lower:
                    cur_process = "scp"
                elif "comb" in lower:
                    cur_process = "combo"
                else:
                    cur_process = "modem"
            elif exp_class == "System API Dump":
                cur_process = "SYSTEM_API_DUMP"
            elif len(parts) > 7:
                cur_process = parts[7]
                if cur_process.startswith("KE at"):
                    cur_process = "PROCESS_KE"
                if ":" in cur_process:
                    cur_process = cur_process.split(":")[0]

            if not cur_process:
                cur_process = "PROCESS_UNKNOWN"

            if not exp_class:
                exp_class = "UNKNOWN"

            return (cur_process, exp_class)
    except Exception:
        return ("PARSE_ERROR", "")


def find_all_dbg_files(scan_root_dir):
    dbg_files = []
    for root, dirs, files in os.walk(scan_root_dir):
        if ".DEC" in root:
            continue
        for file in files:
            if is_dbg_file(file):
                dbg_files.append(os.path.join(root, file))
    return dbg_files


def main():
    parser = argparse.ArgumentParser(description="统计 dbg 文件的进程/包名出现次数（含异常类型）")
    parser.add_argument("-d", "--dir", required=True, help="扫描目录路径")
    parser.add_argument("-n", "--top", type=int, default=0, help="仅显示前 N 条 (0=全部)")
    parser.add_argument("-c", "--csv", action="store_true", help="输出 CSV 格式")
    parser.add_argument("-o", "--output", default="", help="将 CSV 写入指定文件")
    parser.add_argument("-p", "--paths", type=int, default=1, help="每个进程保留的示例日志路径数 (默认1)")
    parser.add_argument("-m", "--merge", action="store_true", help="合并所有进程（不区分异常类型，只看进程名）")
    args = parser.parse_args()

    scan_dir = args.dir
    if not os.path.isdir(scan_dir):
        print(f"[ERROR] 目录不存在: {scan_dir}")
        return

    print(f"[INFO] 开始扫描目录: {scan_dir}", flush=True)
    dbg_files = find_all_dbg_files(scan_dir)
    print(f"[INFO] 共找到 {len(dbg_files)} 个 dbg 文件", flush=True)

    if not dbg_files:
        print("[INFO] 未找到任何 dbg 文件，退出")
        return

    key_counter = Counter()
    key_paths = defaultdict(list)

    for i, dbg_path in enumerate(dbg_files):
        zz_path = os.path.join(os.path.dirname(dbg_path), "ZZ_INTERNAL")
        process, exp_class = parse_zz_internal(zz_path)

        if args.merge:
            key = process
        else:
            key = f"{process} | {exp_class}"

        key_counter[key] += 1

        max_paths = args.paths
        if len(key_paths[key]) < max_paths:
            key_paths[key].append(dbg_path)

        if (i + 1) % 1000 == 0:
            print(f"[INFO] 已处理 {i + 1}/{len(dbg_files)} 个文件...", flush=True)

    sorted_items = key_counter.most_common(args.top if args.top > 0 else None)
    total_count = sum(key_counter.values())
    unique_count = len(key_counter)

    use_csv = args.csv or args.output != ""

    if use_csv:
        if args.merge:
            header = "rank,count,process,example_paths"
            lines = [header]
            for rank, (process, count) in enumerate(sorted_items, 1):
                paths = " | ".join(key_paths.get(process, []))
                safe_process = process.replace('"', '""')
                safe_paths = paths.replace('"', '""')
                lines.append(f'{rank},{count},"{safe_process}","{safe_paths}"')
        else:
            header = "rank,count,process,exp_class,example_paths"
            lines = [header]
            for rank, (key, count) in enumerate(sorted_items, 1):
                process, exp_class = key.split(" | ", 1)
                paths = " | ".join(key_paths.get(key, []))
                safe_process = process.replace('"', '""')
                safe_exp = exp_class.replace('"', '""')
                safe_paths = paths.replace('"', '""')
                lines.append(f'{rank},{count},"{safe_process}","{safe_exp}","{safe_paths}"')

        csv_content = "\n".join(lines)
        if args.output:
            with open(args.output, "w", encoding="utf-8") as f:
                f.write(csv_content + "\n")
            print(f"[INFO] CSV 已写入: {args.output}")
        else:
            print(csv_content)
    else:
        if args.merge:
            print(f"\n{'=' * 80}")
            print(f"{'排名':<6} {'次数':>8}  {'进程/包名':<50} {'示例日志路径'}")
            print(f"{'=' * 80}")
            for rank, (key, count) in enumerate(sorted_items, 1):
                example = key_paths.get(key, [""])[0]
                if len(example) > 55:
                    example = "..." + example[-52:]
                print(f"{rank:<6} {count:>8}  {key:<50} {example}")
        else:
            print(f"\n{'=' * 120}")
            print(f"{'排名':<6} {'次数':>8}  {'进程/包名':<50} {'异常类型':<25} {'示例日志路径'}")
            print(f"{'=' * 120}")
            for rank, (key, count) in enumerate(sorted_items, 1):
                process, exp_class = key.split(" | ", 1)
                example = key_paths.get(key, [""])[0]
                if len(example) > 55:
                    example = "..." + example[-52:]
                print(f"{rank:<6} {count:>8}  {process:<50} {exp_class:<25} {example}")

    print(f"\n{'=' * 60}")
    print(f"[INFO] 不同组合数: {unique_count}")
    print(f"[INFO] dbg 文件总数: {total_count}")
    print(f"{'=' * 60}")


if __name__ == "__main__":
    main()
