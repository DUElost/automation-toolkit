# -*- coding: utf-8 -*-
"""报错汇总 txt 生成器。

每个报错生成一份 {type}_{ts}_summary.txt：
  1. 基础信息（类型/时间/设备/进程包/信号源）
  2. 堆栈（按类型摘取：JE 栈 / NE backtrace / ANR 主线程栈 / SWT 栈）
  3. 关键信息（CausedBy / signal / 关联导出文件清单）

摘录自各日志源（dropbox 详情、ANR trace、tombstone、logcat），供第二阶段汇总去重。
"""

import os
import re

_SEP = "=" * 60
_SECTION = "-" * 40

_TS_RE = re.compile(r"(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})")
_PROCESS_RE = re.compile(r"Process:\s*(.+)")
_PID_RE = re.compile(r"PID:\s*(\d+)")
_SUBJECT_RE = re.compile(r"Subject:\s*(.+)")
_SIGNAL_RE = re.compile(r"signal\s+(\d+)\s*\(([^)]*)\)")


def _extract_dropbox_head(detail_lines):
    """从 dropbox 详情摘录基础信息行（Process/PID/UID/Timestamp/Build/Subject 等）。"""
    keys = ("Process:", "PID:", "UID:", "Timestamp:", "Build:", "Subject:", "Cmdline:")
    return [l for l in detail_lines if any(k in l for k in keys)][:12]


def _extract_java_stack(detail_lines):
    """JE：FATAL EXCEPTION 或 Java 异常行起提取堆栈（含 CausedBy）。"""
    out = []
    started = False
    java_exc = re.compile(r"^\s*(android\.|java\.|com\.|dalvik\.|org\.)\S*(Exception|Error)\b")
    for l in detail_lines:
        if "FATAL EXCEPTION" in l:
            started = True
        if not started and java_exc.match(l):
            started = True
        if started:
            out.append(l)
            if "Caused by:" in l and len(out) > 5:
                break
    return out[:40]


def _extract_native_backtrace(detail_lines):
    """NE：backtrace 段 + signal 行。"""
    out = []
    started = False
    for l in detail_lines:
        if "backtrace:" in l:
            started = True
            out.append(l)
            continue
        if "signal" in l and re.search(r"signal\s+\d+", l):
            out.append(l)
        if started:
            out.append(l)
            if len(out) > 25:
                break
    return out


def _extract_anr_main_thread(trace_lines, pid):
    """ANR：主线程栈（'"main"' 线程块）。"""
    out = []
    started = False
    for l in trace_lines:
        if '"main" prio=' in l:
            started = True
        if started:
            out.append(l)
            if "| sysTid=" in l and len(out) > 1 and "sysTid=" not in l.split("|")[-1]:
                pass
            if l.strip().startswith("|") is False and started and len(out) > 1:
                if "prio=" not in l:
                    break
            if len(out) > 30:
                break
    return out


def _extract_watchdog(detail_lines):
    """SWT：watchdog 相关行。"""
    out = [l for l in detail_lines if re.search(r"watchdog|WATCHDOG|blocked state", l)]
    return out[:30]


def _extract_kernel_panic(lines):
    out = [l for l in lines if re.search(r"panic|Kernel panic|sysrq|Unable to handle", l)]
    return out[:30]


def _extract_restart(lines):
    out = [l for l in lines if re.search(r"Restarting|reboot|RESTART|BOOT", l)]
    return out[:20]


def build_summary(device, type_name, ts, package, scenes, detail_lines,
                  extra_sources=None, out_dir=None):
    """生成报错汇总文本。

    Args:
        device: 设备序列号
        type_name: dropbox 类型名（如 data_app_crash）
        ts: 报错时间（YYYY-MM-DD HH:MM:SS）
        package: 进程/包名
        scenes: 场景列表（ANR/FC/...）
        detail_lines: dropbox 详情行
        extra_sources: {名称: 内容行列表} 补充源（ANR trace/tombstone/logcat 等）
        out_dir: 输出目录（None 时仅返回文本）
    """
    lines = []
    lines.append(_SEP)
    lines.append("报错汇总 (scan_result_GT 第一阶段)")
    lines.append(_SEP)
    lines.append(f"类型: {type_name}  场景: {'/'.join(scenes)}")
    lines.append(f"时间: {ts}")
    lines.append(f"设备: {device}")
    lines.append(f"进程/包: {package or 'unknown'}")
    if extra_sources:
        lines.append(f"信号源: {', '.join(extra_sources.keys())}")
    lines.append("")

    lines.append(_SECTION)
    lines.append("--- 基础信息 ---")
    head = _extract_dropbox_head(detail_lines)
    lines.extend(head if head else ["(dropbox 详情为空)"])
    lines.append("")

    if "ANR" in scenes:
        lines.append(_SECTION)
        lines.append("--- 主线程堆栈 (ANR) ---")
        trace = (extra_sources or {}).get("anr_trace", [])
        stack = _extract_anr_main_thread(trace, "")
        lines.extend(stack[:30] if stack else ["(trace 未提供)"])
    elif "FC" in scenes:
        lines.append(_SECTION)
        lines.append("--- 堆栈 (JE) ---")
        stack = _extract_java_stack(detail_lines)
        lines.extend(stack[:40] if stack else ["(未找到 FATAL EXCEPTION)"])
    elif "NE" in scenes or "System_Server" in scenes:
        lines.append(_SECTION)
        lines.append("--- 堆栈 (NE/backtrace) ---")
        stack = _extract_native_backtrace(detail_lines)
        lines.extend(stack[:25] if stack else ["(未找到 backtrace)"])
    elif "KP" in scenes:
        lines.append(_SECTION)
        lines.append("--- 内核 panic 关键行 ---")
        kp = _extract_kernel_panic(detail_lines)
        lines.extend(kp[:30] if kp else ["(未找到 panic 行)"])
    elif "SR" in scenes:
        lines.append(_SECTION)
        lines.append("--- 重启信息 ---")
        rst = _extract_restart(detail_lines)
        lines.extend(rst[:20] if rst else ["(未找到重启信息)"])
    lines.append("")

    lines.append(_SECTION)
    lines.append("--- 关键信息 ---")
    if extra_sources:
        for name, content in extra_sources.items():
            if content:
                lines.append(f"[{name}] 共 {len(content)} 行")
    lines.append(f"导出文件: {out_dir or '(未落盘)'}")
    lines.append(_SEP)

    text = "\n".join(lines)
    if out_dir:
        os.makedirs(out_dir, exist_ok=True)
        ts_safe = ts.replace(" ", "-").replace(":", "") if ts else "unknown"
        path = os.path.join(out_dir, f"{type_name.replace('_', '-')}_{ts_safe}_summary.txt")
        with open(path, "w", encoding="utf-8") as f:
            f.write(text + "\n")
        return path
    return text
