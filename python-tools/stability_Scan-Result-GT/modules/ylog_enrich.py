# -*- coding: utf-8 -*-
"""设备级 ylog 目录关联 enrich（方案 B：以问题 ExpTime 为锚）。

读取第一阶段落盘：{save}/{version}/{device}/ylog/
  - ap/*.ylog（按分段名匹配时间窗）
  - fwreboot/**/android.log、kernel.log
  - lastkernel.log / dmesg.log 等文本

用途：丰富 Detail；CausedBy 为空或 MTK 随机兜底时，复用 collect.extract_caused_by 补充。
"""

import os
import re
from datetime import datetime, timedelta

from modules.caused_by_rules import sysinfo_patterns, ylog_patterns_for
from modules.collect import (
    _detect_anr_subtype,
    _extract_caused_by_swt,
    _je_caused_by_from_lines,
    _ke_caused_by_from_lines,
    extract_caused_by,
)

_AP_RE = re.compile(r"^(\d+)-(\d{4})_(\d{6})(?:--(\d{4})_(\d{6}))?(?:_\w+)?\.ylog$")
_LOG_TS_RE = re.compile(
    r"(?:^|\s)(\d{4}-)?(\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2})(?:\.\d+)?")
_KERNEL_BRACKET_TS = re.compile(
    r"\[(?:Mon|Tue|Wed|Thu|Fri|Sat|Sun)\s+(\w+)\s+(\d+)\s+(\d{2}:\d{2}:\d{2})\s+(\d{4})\]")
# 充电/温控等误命中 watchdog 关键字的噪音行
_YLOG_NOISE_RE = re.compile(
    r"charger_feed_watchdog|bq2560x_charger|ThermalAction|sqc_abnormal|"
    r"UnisocWatchdog:\s*UNISOCWATCHDOG_MESSAGE",
    re.IGNORECASE)
_FALLBACK_MARK = "未获取到详细信息格式"


def _parse_exp_time(exp_time):
    """问题包 ExpTime：YYYY-MM-DD-HHMMSS -> datetime。"""
    m = re.match(r"^(\d{4}-\d{2}-\d{2})-(\d{6})$", exp_time or "")
    if not m:
        return None
    d, t = m.groups()
    try:
        return datetime.strptime(
            "%s %s:%s:%s" % (d, t[0:2], t[2:4], t[4:6]), "%Y-%m-%d %H:%M:%S")
    except ValueError:
        return None


def _interpret_seg_time(mmdd, hhmmss, anchor):
    """ap 分段名 MMdd_HHmmss 补全年份（对齐一阶段 dropbox_monitor）。"""
    now = datetime.now()
    dt = datetime(anchor.year, int(mmdd[:2]), int(mmdd[2:4]),
                  int(hhmmss[:2]), int(hhmmss[2:4]), int(hhmmss[4:6]))
    if dt > now:
        dt = datetime(anchor.year - 1, dt.month, dt.day, dt.hour, dt.minute, dt.second)
    elif dt < now - timedelta(days=365):
        dt = datetime(anchor.year + 1, dt.month, dt.day, dt.hour, dt.minute, dt.second)
    return dt


def _find_ap_segment(ylog_root, anchor_dt):
    """设备 ylog/ 下覆盖 anchor_dt 的 ap 分段文件名；无则 None。"""
    if not os.path.isdir(ylog_root):
        return None
    ts_str = anchor_dt.strftime("%Y-%m-%d %H:%M:%S")
    segs = []
    for name in os.listdir(ylog_root):
        m = _AP_RE.match(name)
        if m and os.path.isfile(os.path.join(ylog_root, name)):
            segs.append((int(m.group(1)), m))
    if not segs:
        return None
    segs.sort()
    for i, (_seq, m) in enumerate(segs):
        try:
            start = _interpret_seg_time(m.group(2), m.group(3), anchor_dt)
            if start > anchor_dt:
                continue
            if m.group(4):
                end = _interpret_seg_time(m.group(4), m.group(5), anchor_dt)
                if anchor_dt > end:
                    continue
            elif i + 1 < len(segs):
                next_m = segs[i + 1][1]
                end = _interpret_seg_time(next_m.group(2), next_m.group(3), anchor_dt)
                if anchor_dt > end:
                    continue
        except ValueError:
            continue
        return m.group(0)
    return None


def _parse_line_time(line, anchor_dt):
    """从 logcat / kernel 括号时间戳解析 datetime；无法解析返回 None。"""
    m = _LOG_TS_RE.search(line)
    if m:
        year = anchor_dt.year
        if m.group(1):
            year = int(m.group(1).rstrip("-"))
        try:
            line_dt = datetime.strptime(
                "%04d-%s %s" % (year, m.group(2), m.group(3)), "%Y-%m-%d %H:%M:%S")
            for y in (anchor_dt.year, anchor_dt.year - 1, anchor_dt.year + 1):
                if y != year:
                    try:
                        alt = datetime.strptime(
                            "%04d-%s %s" % (y, m.group(2), m.group(3)), "%Y-%m-%d %H:%M:%S")
                        if abs((alt - anchor_dt).total_seconds()) < abs((line_dt - anchor_dt).total_seconds()):
                            line_dt = alt
                    except ValueError:
                        pass
            return line_dt
        except ValueError:
            pass
    m = _KERNEL_BRACKET_TS.search(line)
    if m:
        try:
            return datetime.strptime(
                "%s %s %s %s" % (m.group(4), m.group(1), m.group(2), m.group(3)),
                "%Y %b %d %H:%M:%S")
        except ValueError:
            pass
    return None


def _line_in_window(line, anchor_dt, window_sec):
    """logcat/kernel 行时间是否在 anchor ± window 内；无时间戳则丢弃。"""
    line_dt = _parse_line_time(line, anchor_dt)
    if line_dt is None:
        return False
    return abs((line_dt - anchor_dt).total_seconds()) <= window_sec


def _is_ylog_noise(line):
    return bool(_YLOG_NOISE_RE.search(line))


def _iter_ylog_sources(ylog_root, package_dir, anchor_dt):
    """(label, path) 待检索文件列表。"""
    sources = []
    if os.path.isdir(ylog_root):
        seg = _find_ap_segment(ylog_root, anchor_dt)
        if seg:
            sources.append(("ap/%s" % seg, os.path.join(ylog_root, seg)))
        for name in sorted(os.listdir(ylog_root)):
            p = os.path.join(ylog_root, name)
            # dmesg/lastkernel 多为启动相对时间戳，日历窗过滤无效，跳过
            if name in ("dmesg.log", "lastkernel.log") and os.path.isfile(p):
                continue
            if name.endswith(".log") and os.path.isfile(p):
                sources.append((name, p))
        fw = os.path.join(ylog_root, "fwreboot")
        if os.path.isdir(fw):
            for root, _dirs, files in os.walk(fw):
                for fn in files:
                    if fn in ("android.log", "kernel.log"):
                        rel = os.path.relpath(os.path.join(root, fn), ylog_root)
                        sources.append((rel.replace("\\", "/"), os.path.join(root, fn)))
    ylog_ap = os.path.join(package_dir, "ylog_ap")
    if os.path.isdir(ylog_ap):
        for fn in sorted(os.listdir(ylog_ap)):
            if fn.endswith(".ylog"):
                sources.append(("ylog_ap/%s" % fn, os.path.join(ylog_ap, fn)))
    return sources


def _read_hits(path, patterns, anchor_dt, window_sec, max_hits, max_bytes):
    """从文本或二进制 ylog 中按模式+时间窗提取命中行。"""
    hits = []
    try:
        size = os.path.getsize(path)
        if size > max_bytes:
            return hits
        with open(path, "rb") as f:
            raw = f.read()
    except OSError:
        return hits
    text = raw.decode("utf-8", errors="replace")
    for line in text.splitlines():
        if _is_ylog_noise(line):
            continue
        if not any(p in line for p in patterns):
            continue
        if not _line_in_window(line, anchor_dt, window_sec):
            continue
        s = line.strip()
        if s:
            hits.append(s)
        if len(hits) >= max_hits:
            break
    return hits


def _is_mtk_fallback(caused_by):
    return bool(caused_by and _FALLBACK_MARK in caused_by)


def _caused_by_from_ylog_lines(expclass, lines):
    """对 ylog 命中行复用 collect 提取链。"""
    if not lines:
        return ""
    if expclass == "SWT":
        return _extract_caused_by_swt(lines)
    if expclass == "KE":
        return _ke_caused_by_from_lines(lines)
    if expclass in ("JE", "Jank"):
        return _je_caused_by_from_lines(lines)
    if expclass == "ANR":
        subtype = _detect_anr_subtype(lines)
        if subtype:
            return ""  # 子类型仅 Detail，不当作 CausedBy
    return ""


def enrich_record(rec, package_dir, save_root, config=None):
    """就地更新 rec 的 Detail / CausedBy（设备 ylog 关联）。"""
    cfg = (config or {}).get("ylog_enrich", {})
    if cfg.get("enabled", True) is False:
        return rec
    anchor = _parse_exp_time(rec.get("ExpTime"))
    if anchor is None:
        return rec
    version = rec.get("Version", "")
    device = rec.get("snNum", "")
    ylog_root = os.path.join(save_root, version, device, "ylog")
    if not os.path.isdir(ylog_root):
        return rec

    window = int(cfg.get("window_seconds", 120))
    max_hits = int(cfg.get("max_hits_per_file", 8))
    max_bytes = int(cfg.get("max_file_bytes", 40 * 1024 * 1024))
    expclass = rec.get("ExpClass", "")

    patterns = list(ylog_patterns_for(expclass))
    for _kind, pat, _log in sysinfo_patterns():
        patterns.append(pat)
    patterns = list(dict.fromkeys(patterns))

    detail_blocks = []
    all_hits = []
    for label, path in _iter_ylog_sources(ylog_root, package_dir, anchor):
        hits = _read_hits(path, patterns, anchor, window, max_hits, max_bytes)
        if hits:
            detail_blocks.append("[%s]" % label)
            detail_blocks.extend(hits[:max_hits])
            all_hits.extend(hits)

    if detail_blocks:
        block = "--- ylog 设备关联 (±%ds) ---" % window + "\n" + "\n".join(detail_blocks)
        rec["Detail"] = (rec.get("Detail") or "").rstrip() + "\n\n" + block

    caused = rec.get("CausedBy") or ""
    need_cb = (not caused) or _is_mtk_fallback(caused)
    if need_cb and expclass != "SR":
        cb = _caused_by_from_ylog_lines(expclass, all_hits)
        if not cb:
            cb = extract_caused_by(expclass, package_dir, all_hits)
        if cb:
            rec["CausedBy"] = cb[:600] if expclass == "SWT" else cb[:200]

    return rec
