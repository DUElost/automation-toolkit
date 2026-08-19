# -*- coding: utf-8 -*-
"""问题包扫描与 12 列记录提取。

输入：第一阶段保存根目录 `{save}/{version}/{device}/{type}_{ts}/`
（设备级 ylog/ 目录跳过）。
输出：记录列表（dict，12 列对齐 Y 盘金标准）。
"""

import json
import os
import random
import re
import string
from datetime import datetime

from modules.classify import classify, expclass_family
from modules.caused_by_rules import (
    anr_subtypes,
    cpassert_patterns,
    get_active_rules,
    set_active_rules,
    sysinfo_patterns,
)
from modules.logger import TEST_LOGGER

SUMMARY_FILENAME = "summary.txt"

_TS_RE = re.compile(r"(\d{4}-\d{2}-\d{2})-(\d{6})$")
_SIGNAL_RE = re.compile(r"signal\s+\d+\s*\(([^)]*)\)")
_JANK_RE = re.compile(r"Jank|focus timeout|102200004", re.IGNORECASE)
_ASSERT_RE = re.compile(r"Assert|109000001", re.IGNORECASE)
_WCN_RE = re.compile(r"WCN|109000003", re.IGNORECASE)
_PACKAGE_RE = re.compile(r"^(.+)[_-](\d{4}-\d{2}-\d{2}-\d{6})$")

# uniview 元信息不作 CausedBy 兜底（event_name 过粗，SWT 会误并）
_SKIP_UNIVIEW_CAUSE_FALLBACK = frozenset(("SWT", "Jank", "Assert", "WCN", "SR"))
_AM_CRASH_RE = re.compile(r"am_crash:\s*\[([^]]+)\]")


def _find_problem_dirs(root):
    """扫描问题包目录：{save}/{version}/{device}/{type}-{ts}/。

    设备级 ylog/ 目录跳过；返回包目录列表（device/version 由路径层级推导）。
    """
    packages = []
    try:
        versions = sorted(os.listdir(root))
    except OSError:
        return []
    for version in versions:
        vpath = os.path.join(root, version)
        if not os.path.isdir(vpath):
            continue
        for device in sorted(os.listdir(vpath)):
            dpath = os.path.join(vpath, device)
            if not os.path.isdir(dpath):
                continue
            for name in sorted(os.listdir(dpath)):
                p = os.path.join(dpath, name)
                if os.path.isdir(p) and name != "ylog" and _PACKAGE_RE.match(name):
                    packages.append(p)
    return packages


def _parse_package_name(package_dir):
    """包名 {type}-{ts} -> (type 还原, ts)。"""
    base = os.path.basename(package_dir)
    m = _PACKAGE_RE.match(base)
    if m:
        type_dash, ts = m.groups()
        return type_dash.replace("-", "_"), ts
    return base, ""


def _read_first_line(path):
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            for line in f:
                if line.strip():
                    return line.strip()
    except OSError:
        pass
    return ""


def _find_file(package_dir, names):
    for name in names:
        p = os.path.join(package_dir, name)
        if os.path.isfile(p):
            return p
    return None


def _find_summary(package_dir):
    """问题包 summary 固定为 summary.txt。"""
    p = os.path.join(package_dir, SUMMARY_FILENAME)
    return p if os.path.isfile(p) else None


_FATAL_NE_EVENT_ID = "103100003"
_FATAL_NE_SCENE_RE = re.compile(r"场景:\s*FATAL\b")


def _uniview_type_from_tars(package_dir):
    """从 tar.gz 内路径/exp_main 推断 uniview 源类型目录（如 FATAL.NE）。"""
    import tarfile

    if not os.path.isdir(package_dir):
        return None
    for name in sorted(os.listdir(package_dir)):
        if not name.endswith(".tar.gz"):
            continue
        try:
            with tarfile.open(os.path.join(package_dir, name), "r:gz") as tf:
                for member in tf.getmembers():
                    if "FATAL.NE" in member.name:
                        return "FATAL.NE"
                for member in tf.getmembers():
                    if not member.name.endswith("exp_main.txt"):
                        continue
                    f = tf.extractfile(member)
                    if not f:
                        continue
                    text = f.read().decode("utf-8", "replace")
                    if "FATAL.NE" in text or '"event_id":"103100003"' in text:
                        return "FATAL.NE"
                    for line in text.splitlines():
                        line = line.strip()
                        if not line.startswith("{"):
                            continue
                        try:
                            obj = json.loads(line)
                        except (ValueError, json.JSONDecodeError):
                            continue
                        eid = str(obj.get("event_id", ""))
                        if eid == _FATAL_NE_EVENT_ID:
                            return "FATAL.NE"
                        en = (obj.get("event_name") or "").strip().upper()
                        if en in ("FATAL", "FATAL.NE", "FATAL NE"):
                            return "FATAL.NE"
        except (OSError, tarfile.TarError, EOFError):
            continue
    return None


def _resolve_uniview_exp_type(package_dir, exp_type, ev):
    """uniview 包名可能为 native-crash（tag），实际源目录可能是 FATAL.NE。"""
    if exp_type in ("FATAL.NE",):
        return exp_type
    if exp_type not in ("native_crash", "NE"):
        return exp_type
    if ev:
        if (ev.get("uniview_type_dir") or "").replace("-", "_") == "FATAL.NE":
            return "FATAL.NE"
        if str(ev.get("event_id", "")) == _FATAL_NE_EVENT_ID:
            return "FATAL.NE"
        en = (ev.get("event_name") or "").strip().upper()
        if en in ("FATAL", "FATAL.NE", "FATAL NE"):
            return "FATAL.NE"
    uv = _uniview_type_from_tars(package_dir)
    if uv:
        return uv.replace("-", "_")
    summary = _find_summary(package_dir)
    if summary:
        for line in _read_lines(summary, 30):
            if _FATAL_NE_SCENE_RE.search(line):
                return "FATAL.NE"
    return exp_type


def _read_lines(path, max_lines=None):
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            lines = f.read().splitlines()
        return lines[:max_lines] if max_lines else lines
    except OSError:
        return []


def _uniview_info(package_dir):
    """读取 uniview 事件元信息（unievent_info.json，包根）。

    兼容：单对象 JSON；设备 JSONL 多行（设备信息 + 多事件 kick_datetime 行）。
    多事件时按问题包 ExpTime 匹配对应 kick_datetime 行。
    """
    p = os.path.join(package_dir, "unievent_info.json")
    if not os.path.isfile(p):
        return None
    try:
        text = open(p, encoding="utf-8").read()
    except OSError:
        return None
    try:
        return json.loads(text)
    except (ValueError, json.JSONDecodeError):
        pass
    _, exp_time = _parse_package_name(package_dir)
    events = []
    for line in text.splitlines():
        line = line.strip()
        if not line.startswith("{"):
            continue
        try:
            obj = json.loads(line)
        except (ValueError, json.JSONDecodeError):
            continue
        if obj.get("kick_datetime") or obj.get("event_time") or obj.get("reboot_reason"):
            events.append(obj)
        elif obj.get("tag") and obj.get("proc"):
            events.append(obj)
    if not events:
        return None
    if exp_time:
        for ev in events:
            kd = ev.get("kick_datetime") or ev.get("event_time") or ""
            if _kick_matches_exp_time(kd, exp_time):
                return ev
    return events[0]


def _kick_matches_exp_time(kick_datetime, exp_time):
    """kick_datetime（2026-08-12_09:28:52.511）与包 ExpTime（2026-08-12-092852）对齐。"""
    m = re.match(r"^(\d{4}-\d{2}-\d{2})-(\d{6})$", exp_time or "")
    if not m or not kick_datetime:
        return False
    d, t = m.groups()
    prefix = "%s_%s:%s:%s" % (d, t[0:2], t[2:4], t[4:6])
    return kick_datetime.startswith(prefix)


def _has_crash_signal(lines):
    """内容是否含崩溃现场信号（backtrace/Abort message/signal 等）。

    exp_main.txt 部分类型仅事件元信息（json 行），须继续找 tombstone 兜底。
    """
    return any(re.search(r"backtrace:|Abort message|Caused by|FATAL EXCEPTION|signal \d+",
                         line) for line in lines)


def _extract_exp_detail(package_dir):
    """流式读取 uniview tar.gz 内的异常现场内容（优先）：
    exp_detail.txt -> exp_main.txt（含崩溃信号时）-> DATA_TOMBSTONES/tombstone_*。

    FATAL.NE 类聚合包 exp_main 仅事件元信息，backtrace 在 DATA_TOMBSTONES/ 下；
    返回内容行列表；无 tar.gz 或无现场文件时返回 []。
    """
    import tarfile

    if not os.path.isdir(package_dir):
        return []
    # 包根下 tar.gz；目录形式的 uniview 聚合包（Reboot 等在设备上即展开，名带序号前缀）
    tars = sorted(
        f for f in os.listdir(package_dir)
        if f.endswith(".tar.gz")
        or (re.match(r"^\d+-", f) and os.path.isdir(os.path.join(package_dir, f))))
    for name in tars:
        p = os.path.join(package_dir, name)
        try:
            if name.endswith(".tar.gz"):
                with tarfile.open(p, "r:gz") as tf:
                    # 1) exp_detail / exp_main（exp_main 需含崩溃信号，否则继续找现场）
                    for target in ("exp_detail.txt", "exp_main.txt"):
                        for member in tf.getmembers():
                            if member.name.endswith(target):
                                f = tf.extractfile(member)
                                if f:
                                    lines = f.read().decode("utf-8", "replace").splitlines()
                                    if target == "exp_detail.txt" or _has_crash_signal(lines):
                                        return lines
                    # 2) DATA_TOMBSTONES/tombstone_*（backtrace 现场兜底，多份时按事件匹配）
                    tb_lines = _pick_tombstone_lines(package_dir, _uniview_info(package_dir))
                    if tb_lines:
                        return tb_lines
            else:
                # Reboot 等类型在设备上即展开目录（名 {seq}-{ts}.tar.gz）
                for target in ("exp_detail.txt", "exp_main.txt"):
                    exp = os.path.join(p, target)
                    if os.path.isfile(exp):
                        with open(exp, encoding="utf-8", errors="replace") as f:
                            lines = f.read().splitlines()
                        if target == "exp_detail.txt" or _has_crash_signal(lines):
                            return lines
                # DATA_TOMBSTONES/tombstone_* 现场兜底（多份时按事件匹配）
                tb_lines = _pick_tombstone_lines(package_dir, _uniview_info(package_dir))
                if tb_lines:
                    return tb_lines
        except (OSError, tarfile.TarError, EOFError):
            continue
    return []


def _norm_pkg(p):
    """Package 统一为原始路径形式（/vendor/...），反替换第一阶段可能的 % 化。"""
    return p.replace("%", "/") if "%" in p else p


def _cmdline_from_tombstone(lines):
    """tombstone 头部 Cmdline: 行 → 包名。"""
    for line in lines[:80]:
        if "Cmdline:" in line:
            return _norm_pkg(line.split("Cmdline:", 1)[1].strip())
    return ""


_TOMBSTONE_TS_RE = re.compile(
    r"^Timestamp:\s*(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2})")
_TOMBSTONE_PID_RE = re.compile(r"^\s*pid:\s*(\d+)", re.I)
_KICK_DT_RE = re.compile(r"^(\d{4}-\d{2}-\d{2})_(\d{2}):(\d{2}):(\d{2})")


def _parse_exp_time_stamp(exp_time):
    """包名 ExpTime（2026-08-12-093004）→ datetime。"""
    m = re.match(r"^(\d{4}-\d{2}-\d{2})-(\d{6})$", exp_time or "")
    if not m:
        return None
    d, t = m.groups()
    try:
        return datetime.strptime(
            "%s %s:%s:%s" % (d, t[0:2], t[2:4], t[4:6]), "%Y-%m-%d %H:%M:%S")
    except ValueError:
        return None


def _parse_kick_datetime(kick_datetime):
    """unievent kick_datetime（2026-08-12_09:30:04.605）→ datetime。"""
    m = _KICK_DT_RE.match(kick_datetime or "")
    if not m:
        return None
    try:
        return datetime.strptime(
            "%s %s:%s:%s" % (m.group(1), m.group(2), m.group(3), m.group(4)),
            "%Y-%m-%d %H:%M:%S")
    except ValueError:
        return None


def _parse_tombstone_meta(lines):
    """tombstone 头部元信息：Cmdline、pid、Timestamp。"""
    meta = {"cmdline": "", "pid": "", "timestamp": None}
    for line in lines[:80]:
        if line.startswith("Cmdline:"):
            meta["cmdline"] = _norm_pkg(line.split("Cmdline:", 1)[1].strip())
        m = _TOMBSTONE_PID_RE.match(line)
        if m and not meta["pid"]:
            meta["pid"] = m.group(1)
        m = _TOMBSTONE_TS_RE.match(line.strip())
        if m:
            try:
                meta["timestamp"] = datetime.strptime(
                    "%s %s" % (m.group(1), m.group(2)), "%Y-%m-%d %H:%M:%S")
            except ValueError:
                pass
    return meta


def _tombstone_match_score(meta, ev, anchor_dt):
    """多 tombstone 时按 unievent pid/proc 与事件时间打分。"""
    score = 0
    if ev:
        ev_pid = str(ev.get("pid") or "")
        if ev_pid and meta.get("pid") == ev_pid:
            score += 1000
        ev_proc = (ev.get("proc") or "").strip()
        cmd = meta.get("cmdline") or ""
        if ev_proc and (ev_proc == cmd or ev_proc in cmd or cmd.endswith(ev_proc)):
            score += 100
    if anchor_dt and meta.get("timestamp"):
        delta = abs((meta["timestamp"] - anchor_dt).total_seconds())
        if delta <= 600:
            score += max(0, 600 - int(delta))
    return score


def _list_tombstones_from_package(package_dir):
    """收集包内全部 tombstone 内容 [(name, lines), ...]。"""
    import tarfile

    out = []
    p = _find_file(package_dir, ("tombstone.txt",))
    if p:
        out.append(("tombstone.txt", _read_lines(p)))
    if not os.path.isdir(package_dir):
        return out
    tars = sorted(
        f for f in os.listdir(package_dir)
        if f.endswith(".tar.gz")
        or (re.match(r"^\d+-", f) and os.path.isdir(os.path.join(package_dir, f))))
    for name in tars:
        p = os.path.join(package_dir, name)
        try:
            if name.endswith(".tar.gz"):
                with tarfile.open(p, "r:gz") as tf:
                    members = [
                        m for m in tf.getmembers()
                        if "/DATA_TOMBSTONES/" in m.name
                        and os.path.basename(m.name).startswith("tombstone")]
                    for member in sorted(members, key=lambda m: m.name):
                        f = tf.extractfile(member)
                        if f:
                            lines = f.read().decode("utf-8", "replace").splitlines()
                            out.append((member.name, lines))
            else:
                for root, _dirs, files in os.walk(p):
                    if "DATA_TOMBSTONES" in root:
                        for f in sorted(files):
                            if f.startswith("tombstone"):
                                try:
                                    with open(os.path.join(root, f),
                                              encoding="utf-8", errors="replace") as fh:
                                        out.append((os.path.join(root, f),
                                                    fh.read().splitlines()))
                                except OSError:
                                    continue
        except (OSError, tarfile.TarError, EOFError):
            continue
    return out


def _pick_tombstone_lines(package_dir, ev=None):
    """多 tombstone 时选与 unievent/ExpTime 最匹配的一份；单份则直接返回。"""
    tombstones = _list_tombstones_from_package(package_dir)
    if not tombstones:
        return []
    if len(tombstones) == 1:
        return tombstones[0][1]
    _, exp_time = _parse_package_name(package_dir)
    anchor_dt = None
    if ev:
        anchor_dt = _parse_kick_datetime(
            ev.get("kick_datetime") or ev.get("event_time") or "")
    if anchor_dt is None:
        anchor_dt = _parse_exp_time_stamp(exp_time)
    best_item = tombstones[0]
    best_score = -1
    for item in tombstones:
        score = _tombstone_match_score(_parse_tombstone_meta(item[1]), ev, anchor_dt)
        if score > best_score:
            best_score = score
            best_item = item
    if best_score <= 0:
        best_item = max(
            tombstones,
            key=lambda item: _parse_tombstone_meta(item[1]).get("timestamp") or datetime.min)
    return best_item[1]


def _extract_tombstone_cmdline(package_dir, ev=None):
    """从匹配后的 tombstone 提取 Cmdline 包名。"""
    if ev is None:
        ev = _uniview_info(package_dir)
    lines = _pick_tombstone_lines(package_dir, ev)
    if lines:
        return _cmdline_from_tombstone(lines)
    return ""


def _extract_package(detail_lines, package_dir):
    """包名：detail Process: 行；ANR 包用 anr_trace Cmd line:；tombstone Cmdline:；uniview unievent_info proc；summary 兜底。"""
    for line in detail_lines:
        if "Process:" in line:
            return _norm_pkg(line.split("Process:", 1)[1].strip())
    trace = _find_file(package_dir, ("anr_trace.txt",))
    if trace:
        for line in _read_lines(trace, 100):
            if "Cmd line:" in line:
                return _norm_pkg(line.split("Cmd line:", 1)[1].strip())
    cmd = _extract_tombstone_cmdline(package_dir)
    if cmd:
        return cmd
    ev = _uniview_info(package_dir)
    if ev:
        proc = ev.get("proc") or ev.get("appname") or ""
        if proc:
            if "/" in proc or "%" in proc:
                # 路径型（/vendor/bin/...）：原始路径形式
                return _norm_pkg(proc[:100])
            # appname 形如 ActivityRecord{... com.foo/...} 提取包名
            m = re.search(r"([\w.]+)/", proc)
            return m.group(1) if m else proc[:100]
    summary = _find_summary(package_dir)
    if summary:
        for line in _read_lines(summary, 30):
            if "进程/包" in line or "Package" in line:
                return _norm_pkg(line.split(":", 1)[1].strip())
    return ""


_LIB_VERSION = "scan_result_GT v1.0"

# 市场 SKU（MTK rom_ram 同表）
_ROM_SKU_GB = (32, 64, 128, 256, 512, 1024)
_RAM_SKU_GB = (2, 3, 4, 6, 8, 12, 16, 24, 32)


def _ceil_sku_gb(value_gb, sku_table):
    for sku in sku_table:
        if value_gb <= sku:
            return sku
    return sku_table[-1]


def _extract_rom_ram(package_dir):
    """Rom_Ram：SYS_FILE_SYSTEMS /data 分区（ROM）+ SYS_PROPERTIES ddrsize（RAM）。

    返回 '64GB+4GB'；任一缺失时返回可得部分；全缺返回 ''。
    /data 1K-blocks 为可用容量，向上取整到市场 SKU（43.5GB -> 64GB）。
    支持 tar.gz 文件与展开目录（Reboot 等）两种聚合包形态。
    """
    import tarfile

    data_kb = None
    ddr_raw = None
    for name in os.listdir(package_dir):
        p = os.path.join(package_dir, name)
        if name.endswith(".tar.gz") and os.path.isfile(p):
            try:
                with tarfile.open(p, "r:gz") as tf:
                    for m in tf.getmembers():
                        if data_kb is None and m.name.endswith("SYS_FILE_SYSTEMS"):
                            f = tf.extractfile(m)
                            data_kb = _parse_data_kb(f.read().decode("utf-8", "replace"))
                        elif ddr_raw is None and m.name.endswith("SYS_PROPERTIES"):
                            f = tf.extractfile(m)
                            for line in f.read().decode("utf-8", "replace").splitlines():
                                if "ro.boot.ddrsize" in line and "]: [" in line:
                                    ddr_raw = line.split("]: [", 1)[1].rstrip("]")
                                    break
            except (OSError, tarfile.TarError, EOFError):
                continue
        elif os.path.isdir(p):
            # 展开目录（Reboot 等）：直接读文件
            for root, _dirs, files in os.walk(p):
                for f in files:
                    if f == "SYS_FILE_SYSTEMS" and data_kb is None:
                        data_kb = _parse_data_kb(open(os.path.join(root, f),
                                                      encoding="utf-8", errors="replace").read())
                    elif f == "SYS_PROPERTIES" and ddr_raw is None:
                        for line in open(os.path.join(root, f),
                                         encoding="utf-8", errors="replace"):
                            if "ro.boot.ddrsize" in line and "]: [" in line:
                                ddr_raw = line.split("]: [", 1)[1].rstrip("]")
                                break
    return _format_rom_ram(data_kb, ddr_raw)


def _parse_data_kb(text):
    for line in text.splitlines():
        if re.search(r"\s+/data\s*$", line.strip()):
            parts = line.split()
            if len(parts) >= 2:
                try:
                    return int(parts[1])
                except ValueError:
                    return None
    return None


def _format_rom_ram(data_kb, ddr_raw):
    rom_gb = ram_gb = 0
    if data_kb:
        data_gb = data_kb / 1024.0 / 1024.0
        rom_gb = _ceil_sku_gb(data_gb, _ROM_SKU_GB)
    if ddr_raw:
        m = re.match(r"(\d+(?:\.\d+)?)\s*(G|GB|M|MB)?", ddr_raw.strip(), re.I)
        if m:
            val = float(m.group(1))
            unit = (m.group(2) or "G").upper()
            ram_gb = val / 1024.0 if unit.startswith("M") else val
            ram_gb = _ceil_sku_gb(ram_gb, _RAM_SKU_GB)
    parts = []
    if rom_gb:
        parts.append("%dGB" % rom_gb)
    if ram_gb:
        parts.append("%dGB" % ram_gb)
    return "+".join(parts)


def _extract_pid(package_dir, ev, detail_lines):
    """pid：unievent_info.pid -> detail PID: 行 -> tombstone pid: 行（三级兜底）。"""
    if ev and ev.get("pid"):
        return str(ev["pid"])
    for line in detail_lines:
        s = line.strip()
        if s.startswith("PID:"):
            p = s[len("PID:"):].strip()
            if p and p != "0":
                return p
    tb = _find_file(package_dir, ("tombstone.txt",))
    if tb:
        for line in _read_lines(tb, 30):
            m = re.search(r"\bpid:\s*(\d+)", line)
            if m:
                return m.group(1)
    return ""


def _pkg_version_suffix(detail_lines):
    """应用版本段：detail.txt Package: 行 'v{code} ({name})'（MTK 格式 ['pkg v36 (16)']）。"""
    for line in detail_lines:
        s = line.strip()
        if s.startswith("Package:"):
            rest = s[len("Package:"):].strip()
            m = re.search(r"\sv\d+(?: \([^)]*\))?", rest)
            return m.group(0) if m else ""
    return ""


def _fallback_caused_by(expclass, package):
    """MTK 兜底逻辑：未获取到详细信息时随机串（200 字符），防止去重误合并。

    参照 MTK AnalyseAee：detail/caused_by 为空或 SWT/OCP reboot/HWT 等严重类型
    强制默认格式——每个问题单独看待，不与其他条目合并为一类。
    """
    rand = "".join(random.choice(string.ascii_letters + string.digits) for _ in range(200))
    return ("class:[%s] process:[%s] 未获取到详细信息格式，仅供 Jira 提交去重\n%s"
            % (expclass, package or "unknown", rand))


def _truncate(text, limit=4000):
    """截断并加标记，避免强行截断无提示。"""
    if len(text) > limit:
        return text[:limit] + "\n... (详情已截断，完整内容见问题包日志)"
    return text


def _extract_caused_by_swt(lines):
    """SWT CausedBy：Blocked in / WATCHDOG KILLING / watchdog: Blocked in。

    无阻塞详情时返回 ''，走 MTK 兜底（各自保留）。
    """
    for line in lines:
        if "WATCHDOG KILLING SYSTEM PROCESS" in line:
            return line.strip()[:600]
    for line in lines:
        if "Blocked in" in line:
            s = line.strip()
            m = re.search(r"watchdog:\s*(Blocked in.+)", s, re.IGNORECASE)
            if m:
                return m.group(1)[:600]
            if s.startswith("Subject:"):
                s = s[len("Subject:"):].strip()
            return s[:600]
    for line in lines:
        if line.strip().startswith("Subject:"):
            return line.strip()[:600]
    return ""


def _swt_caused_by_lines(package_dir, primary_lines, extra_lines):
    """SWT CausedBy 多源：detail/exp_detail → SYS_ANDROID_LOG。"""
    for src in (primary_lines, extra_lines or ()):
        if not src:
            continue
        caused = _extract_caused_by_swt(src)
        if caused:
            return caused
    alog = _read_uniview_basename(package_dir, "SYS_ANDROID_LOG")
    return _extract_caused_by_swt(alog)


def _read_uniview_basename(package_dir, basename, max_lines=None):
    """读 uniview 聚合包内具名文件（tar/展开目录/包根）。"""
    import tarfile

    direct = os.path.join(package_dir, basename)
    if os.path.isfile(direct):
        return _read_lines(direct, max_lines)
    if not os.path.isdir(package_dir):
        return []
    for name in os.listdir(package_dir):
        p = os.path.join(package_dir, name)
        try:
            if name.endswith(".tar.gz") and os.path.isfile(p):
                with tarfile.open(p, "r:gz") as tf:
                    for member in tf.getmembers():
                        if (member.name == basename
                                or member.name.endswith("/" + basename)):
                            f = tf.extractfile(member)
                            if f:
                                lines = f.read().decode("utf-8", "replace").splitlines()
                                return lines[:max_lines] if max_lines else lines
            elif os.path.isdir(p) and re.match(r"^\d+-", name):
                for root, _dirs, files in os.walk(p):
                    if basename in files:
                        return _read_lines(os.path.join(root, basename), max_lines)
        except (OSError, tarfile.TarError, EOFError):
            continue
    return []


def _read_anr_traces_from_pkg(package_dir):
    """uniview tar/展开目录内 DATA_ANR_TRACES/* 内容列表。"""
    import tarfile

    traces = []
    if not os.path.isdir(package_dir):
        return traces
    for name in os.listdir(package_dir):
        p = os.path.join(package_dir, name)
        try:
            if name.endswith(".tar.gz") and os.path.isfile(p):
                with tarfile.open(p, "r:gz") as tf:
                    for member in tf.getmembers():
                        if "/DATA_ANR_TRACES/" in member.name and not member.isdir():
                            f = tf.extractfile(member)
                            if f:
                                traces.append(
                                    f.read().decode("utf-8", "replace").splitlines())
            elif os.path.isdir(p) and re.match(r"^\d+-", name):
                for root, _dirs, files in os.walk(p):
                    if "DATA_ANR_TRACES" in root:
                        for fn in files:
                            try:
                                with open(os.path.join(root, fn),
                                          encoding="utf-8", errors="replace") as fh:
                                    traces.append(fh.read().splitlines())
                            except OSError:
                                continue
        except (OSError, tarfile.TarError, EOFError):
            continue
    return traces


def _detect_anr_subtype(lines):
    """ABPS ANR 7 子类型；无匹配返回 ''。"""
    for tag, pattern in anr_subtypes():
        for line in lines:
            if pattern in line:
                return tag
    return ""


def _lines_for_anr_subtype(package_dir, detail_lines, exp_detail):
    """ANR 子类型检测用行集合。"""
    lines = list(detail_lines)
    if exp_detail:
        lines.extend(exp_detail)
    trace = _find_file(package_dir, ("anr_trace.txt",))
    if trace:
        lines.extend(_read_lines(trace))
    for tr in _read_anr_traces_from_pkg(package_dir):
        lines.extend(tr)
    lines.extend(_read_uniview_basename(package_dir, "SYS_ANDROID_LOG", max_lines=80000))
    return lines


def _extract_sysinfo_context(package_dir, max_per_kind=3):
    """ABPS sysinfo 上下文行（lmk/oom/io），写入 Detail 附录。"""
    found = []
    seen = set()
    for kind, pattern, log_name in sysinfo_patterns():
        if kind in seen:
            continue
        count = 0
        for line in _read_uniview_basename(package_dir, log_name, max_lines=80000):
            if pattern in line:
                found.append(line.strip())
                count += 1
                if count >= max_per_kind:
                    seen.add(kind)
                    break
    return found


def _extract_cpassert_context(package_dir, max_lines=5):
    """ABPS stab_cpassert 命中行，写入 Detail。"""
    out = []
    for line in _read_uniview_basename(package_dir, "SYS_ANDROID_LOG", max_lines=80000):
        if any(p in line for p in cpassert_patterns()):
            out.append(line.strip())
            if len(out) >= max_lines:
                break
    return out


def _extract_swt_half_note(package_dir):
    """SWT half（WAITED_HALF）说明，写入 Detail。"""
    for line in _read_uniview_basename(package_dir, "SYS_ANDROID_LOG", max_lines=80000):
        if "WAITED_HALF" in line:
            return "half watchdog (WAITED_HALF)"
    for line in _read_uniview_basename(package_dir, "exp_detail.txt", max_lines=5000):
        if "WAITED_HALF" in line:
            return "half watchdog (WAITED_HALF)"
    return ""


def _je_am_crash_exception(line):
    """解析 am_crash: [...,Exception,...] 中异常类（ABPS events.log / SYS_ANDROID_LOG）。"""
    m = _AM_CRASH_RE.search(line)
    if not m:
        return ""
    parts = m.group(1).split(",")
    if len(parts) < 5:
        return ""
    exc = parts[4].strip()
    if re.match(r"^(android\.|java\.|com\.|dalvik\.)\S*(Exception|Error)\b", exc):
        return exc
    if "." in exc and ("Exception" in exc or "Error" in exc):
        return exc
    return ""


def _je_caused_by_from_am_crash_lines(lines):
    for line in lines:
        exc = _je_am_crash_exception(line)
        if exc:
            return exc[:200]
    return ""


def _je_caused_by_from_lines(lines):
    """JE CausedBy：Caused by / FATAL EXCEPTION / Java 异常行 / am_crash 异常类。"""
    for line in lines:
        if "Caused by:" in line:
            return line.strip()[:200]
    for line in lines:
        if "FATAL EXCEPTION" in line:
            return line.strip()[:200]
    for line in lines:
        if re.match(r"^\s*(android\.|java\.|com\.|dalvik\.)\S*(Exception|Error)\b", line):
            return line.strip()[:200]
    return _je_caused_by_from_am_crash_lines(lines)


def _ke_caused_by_from_lines(lines, rules=None):
    """KE CausedBy：NativeHang 优先，其次 panic，最后 killed by signal（ABPS kernelcommon）。"""
    ke_rules = (rules or get_active_rules()).get("KE", {})
    patterns = ke_rules.get("patterns", [
        "Native hang monitor trigger", "panic", "killed by signal"])
    for pat in patterns:
        for line in lines:
            if pat == "panic":
                if "panic" in line.lower():
                    return line.strip()[:200]
            elif pat in line:
                return line.strip()[:200]
    return ""


def _detail_appendix(package_dir, expclass, detail_lines, exp_detail):
    """Detail 类型附加段（ANR 子类型 / SWT half / sysinfo / cpassert）。"""
    extra = []
    if expclass == "ANR":
        subtype = _detect_anr_subtype(_lines_for_anr_subtype(package_dir, detail_lines, exp_detail))
        if subtype:
            extra = ["--- ANR 子类型 ---", "ANR子类型: %s" % subtype]
    elif expclass == "SWT":
        half = _extract_swt_half_note(package_dir)
        if half:
            extra = ["--- SWT 状态 ---", half]
    sysinfo = _extract_sysinfo_context(package_dir)
    if sysinfo:
        extra += ["--- 系统态上下文 ---"] + sysinfo[:12]
    if expclass in ("Assert", "WCN", "MSP"):
        cpassert = _extract_cpassert_context(package_dir)
        if cpassert:
            extra += ["--- Assert/Modem 现场 ---"] + cpassert
    return extra


def _anr_main_stack_top(tr):
    """half ANR trace 的 main 线程栈顶帧（at 行），作为 ANR 去重特征。"""
    in_main = False
    for line in tr:
        s = line.strip()
        if s.startswith('"main"'):
            in_main = True
            continue
        if in_main:
            if s.startswith("at ") or re.match(r"^#\d+", s):
                return s[:120]
            if s.startswith('"'):
                break
    return ""


def extract_caused_by(expclass, package_dir, extra_lines=None):
    """按 ExpClass 提取 CausedBy 关键行。

    extra_lines: 无 detail.txt 时兜底内容（uniview 包用 tar 内 exp_detail 行）。
    """
    detail = _find_file(package_dir, ("detail.txt",))
    if detail is None:
        lines = list(extra_lines or [])
    else:
        lines = _read_lines(detail)
    if expclass == "ANR":
        # 特征：main 线程栈顶帧（at 行）；进程/Subject/dumping pid 为 half ANR 通用
        # 格式文本（每次 pid 变化），在 SequenceMatcher 去重中是噪音，不作为 CausedBy
        trace = _find_file(package_dir, ("anr_trace.txt",))
        if trace:
            tr = _read_lines(trace)
            top = _anr_main_stack_top(tr)
            if top:
                return top
        for tr in _read_anr_traces_from_pkg(package_dir):
            top = _anr_main_stack_top(tr)
            if top:
                return top
        subj = ""
        for line in lines:
            if "Subject:" in line:
                subj = line.strip()[len("Subject:"):].strip() or subj
        if subj:
            return subj[:200]
        return ""
    elif expclass_family(expclass) == "NE":
        # CausedBy：backtrace 首帧（含 pc + 库），对齐金标准语义
        for i, line in enumerate(lines):
            if line.strip() == "backtrace:":
                for j in range(i + 1, min(i + 6, len(lines))):
                    if lines[j].strip():
                        return lines[j].strip()[:200]
        for line in lines:
            m = _SIGNAL_RE.search(line)
            if m:
                return line.strip()[:200]
        # uniview 包（无 detail.txt）：从 exp_detail/tombstone 兜底提取
        if extra_lines and lines is not extra_lines:
            for i, line in enumerate(extra_lines):
                if line.strip() == "backtrace:":
                    for j in range(i + 1, min(i + 6, len(extra_lines))):
                        if extra_lines[j].strip():
                            return extra_lines[j].strip()[:200]
            for line in extra_lines:
                m = _SIGNAL_RE.search(line)
                if m:
                    return line.strip()[:200]
        # 平台源 tombstone 包：包内 tombstone.txt（完整现场）兜底
        for fallback in ("tombstone.txt", "anr_trace.txt"):
            p = os.path.join(package_dir, fallback)
            if os.path.isfile(p):
                fb = _read_lines(p)
                for i, line in enumerate(fb):
                    if line.strip() == "backtrace:":
                        for j in range(i + 1, min(i + 6, len(fb))):
                            if fb[j].strip():
                                return fb[j].strip()[:200]
                for line in fb:
                    m = _SIGNAL_RE.search(line)
                    if m:
                        return line.strip()[:200]
        return ""
    elif expclass == "SWT":
        return _swt_caused_by_lines(package_dir, lines, extra_lines)
    elif expclass == "KE":
        caused = _ke_caused_by_from_lines(lines)
        if caused:
            return caused
        if extra_lines and lines is not extra_lines:
            caused = _ke_caused_by_from_lines(extra_lines)
            if caused:
                return caused
        dump = _read_pkg_file(package_dir, "dump_report.txt")
        caused = _ke_caused_by_from_lines(dump)
        if caused:
            return caused
        for src in get_active_rules().get("KE", {}).get(
                "kernel_sources", ["SYS_KERNEL_LOG"]):
            klog = _read_uniview_basename(package_dir, src, max_lines=80000)
            caused = _ke_caused_by_from_lines(klog)
            if caused:
                return caused
        return ""
    else:  # JE 等
        caused = _je_caused_by_from_lines(lines)
        if caused:
            return caused
        if extra_lines and lines is not extra_lines:
            caused = _je_caused_by_from_lines(extra_lines)
            if caused:
                return caused
        alog = _read_uniview_basename(package_dir, "SYS_ANDROID_LOG", max_lines=80000)
        caused = _je_caused_by_from_lines(alog)
        if caused:
            return caused
        for src in get_active_rules().get("JE", {}).get(
                "am_crash_sources", ["SYS_ANDROID_LOG", "events.log"]):
            if src == "SYS_ANDROID_LOG":
                continue
            log_lines = _read_uniview_basename(package_dir, src, max_lines=80000)
            caused = _je_caused_by_from_am_crash_lines(log_lines)
            if caused:
                return caused
        return ""
    return ""


def _read_pkg_file(package_dir, suffix):
    """读聚合包内匹配 suffix 的首个文件内容行：tar.gz 文件流式 / 展开目录直接读。

    展锐 Reboot 等类型聚合包在设备上即展开为目录（名 {seq}-{ts}.tar.gz，非压缩文件）。
    """
    import tarfile

    for name in os.listdir(package_dir):
        p = os.path.join(package_dir, name)
        if name.endswith(".tar.gz") and os.path.isfile(p):
            try:
                with tarfile.open(p, "r:gz") as tf:
                    for member in tf.getmembers():
                        if member.name.endswith(suffix):
                            f = tf.extractfile(member)
                            if f:
                                return f.read().decode("utf-8", "replace").splitlines()
            except (OSError, tarfile.TarError, EOFError):
                continue
        elif os.path.isdir(p):
            for root, _dirs, files in os.walk(p):
                for f in files:
                    if f.endswith(suffix):
                        try:
                            with open(os.path.join(root, f),
                                      encoding="utf-8", errors="replace") as fh:
                                return fh.read().splitlines()
                        except OSError:
                            continue
    return []


def _extract_tombstone_key(tb_lines):
    """tombstone 关键段：头部（Build/signal/Abort message/寄存器）+ backtrace 前 15 帧。"""
    out = []
    for i, line in enumerate(tb_lines[:80]):
        out.append(line)
        if line.strip() == "backtrace:":
            for j in range(i + 1, min(i + 16, len(tb_lines))):
                out.append(tb_lines[j])
            break
    return out


def _extract_subject(expclass, lines, ev):
    """Subject（一眼定位行，参照 MTK __exp_main 的 Subject 语义）。"""
    if expclass_family(expclass) == "NE":
        for line in lines:
            s = line.strip()
            if s.startswith("Abort message:"):
                return s
        for line in lines:
            m = _SIGNAL_RE.search(line)
            if m:
                return line.strip()
    elif expclass == "JE":
        for line in lines:
            s = line.strip()
            if s.startswith("Caused by:"):
                return s
        for line in lines:
            s = line.strip()
            if re.match(r"^(android\.|java\.|com\.|dalvik\.)\S*(Exception|Error)\b", s):
                return s
    elif expclass == "ANR":
        for line in lines:
            s = line.strip()
            if s.startswith("Subject:"):
                return s[len("Subject:"):].strip() or s
        for line in lines:
            if "not responding" in line.lower() or "am_anr" in line.lower():
                return line.strip()
    elif expclass == "SWT":
        for line in lines:
            if "watchdog" in line.lower() and ":" in line:
                return line.strip()
    elif expclass == "SR":
        if ev and ev.get("reboot_reason"):
            return "reboot_reason: %s" % ev["reboot_reason"].strip()
        for line in lines:
            if "bootcause" in line.lower() or "reboot" in line.lower():
                return line.strip()
    if ev:
        for key in ("event_name", "message"):
            if ev.get(key):
                return "%s: %s" % (key, ev[key])
    return ""


def _extract_frames(expclass, lines):
    """栈帧（MTK 风格：native 帧带 native: 前缀，Java 帧 at 原样），最多 20 行。"""
    frames = []
    if expclass_family(expclass) == "NE":
        in_bt = False
        for line in lines:
            s = line.strip()
            if s == "backtrace:":
                in_bt = True
                continue
            if in_bt:
                if re.match(r"^#\d+", s):
                    frames.append("native: %s" % s)
                elif not s:
                    break
    else:
        for line in lines:
            s = line.strip()
            if re.match(r"^at [\w.]+\(", s):
                frames.append(s)
            elif frames and not s:
                break
    return frames[:20]


def _build_detail(expclass, package_dir, exp_detail, ev, summary,
                  version, sn, package, pid, detail_lines):
    """Detail 主体（对齐 MTK 识别报告模板）。

    Device_id / 解析库版本 / 手机版本 / 异常包名（含应用版本）/ 异常进程 / pid /
    Backtrace（根因行 + 栈帧）+ 类型附加现场段（SR dump_report / NE tombstone 等）。
    """
    lines = exp_detail or []
    header = [
        "Device_id: %s" % sn,
        "解析库版本：%s" % _LIB_VERSION,
        "手机版本：['%s']" % version,
        "异常包名：['%s%s']" % (package, _pkg_version_suffix(detail_lines)),
        "异常进程：['%s']" % package,
    ]
    if pid:
        header.append("pid：['%s']" % pid)

    subject = _extract_subject(expclass, lines, ev)
    frames = _extract_frames(expclass, lines)
    bt = []
    if subject:
        bt.append(subject)
    bt.extend(frames)

    extra = []
    if expclass == "SR":
        dump = _read_pkg_file(package_dir, "dump_report.txt")
        if dump:
            extra = ["--- dump_report.txt（重启现场）---"] + dump[:60]
        else:
            klog = _read_pkg_file(package_dir, "SYS_KERNEL_LOG")
            if klog:
                extra = ["--- SYS_KERNEL_LOG 尾部（重启原因）---"] + klog[-60:]
            elif ev:
                # 设备空 tar 等：事件元信息（reboot_reason/file_path 线索）
                extra = ["--- unievent_info ---",
                         json.dumps(ev, ensure_ascii=False)]
    elif expclass in ("Jank", "Assert", "WCN"):
        em = _read_pkg_file(package_dir, "exp_main.txt")
        if em:
            extra = ["--- exp_main（事件描述）---"] + em
        if ev:
            extra += ["--- unievent_info ---",
                      json.dumps(ev, ensure_ascii=False)]
    elif expclass_family(expclass) == "NE" and not lines:
        tb_lines = _pick_tombstone_lines(package_dir, ev)
        if tb_lines:
            if not subject:
                subject = _extract_subject(expclass, tb_lines, ev)
            if not frames:
                frames = _extract_frames(expclass, tb_lines)
            extra = ["--- tombstone 关键段 ---"] + _extract_tombstone_key(tb_lines)[:60]
    elif expclass == "ANR" and not lines:
        trace = _find_file(package_dir, ("anr_trace.txt",))
        if trace:
            tr = _read_lines(trace)
            if not subject:
                subject = _extract_subject(expclass, tr, ev)
            if not frames:
                frames = _extract_frames(expclass, tr)
            extra = ["--- ANR trace 头部 ---"] + tr[:20]
    elif expclass == "JE" and not lines:
        detail = _find_file(package_dir, ("detail.txt",))
        if detail:
            dl = _read_lines(detail)
            if not subject:
                subject = _extract_subject(expclass, dl, ev)
            if not frames:
                frames = _extract_frames(expclass, dl)
    elif expclass == "SWT" and not lines:
        detail = _find_file(package_dir, ("detail.txt",))
        if detail:
            dl = _read_lines(detail)
            if not subject:
                subject = _extract_subject(expclass, dl, ev)
            if not frames:
                frames = _extract_frames(expclass, dl)

    appendix = _detail_appendix(package_dir, expclass, detail_lines, exp_detail)
    if appendix:
        if extra:
            extra.extend([""] + appendix)
        else:
            extra = appendix

    bt = []
    if subject:
        bt.append(subject)
    bt.extend(frames)
    parts = header + ["Backtrace："] + bt
    if extra:
        parts.append("")
        parts.extend(extra)
    # 统一 Device_id 模板：即使无现场也输出模板（不回退 summary）
    return _truncate("\n".join(parts))


def _collect_package(package_dir, version, device):
    type_dash, ts = _parse_package_name(package_dir)
    exp_type = type_dash
    ev = _uniview_info(package_dir)
    exp_type = _resolve_uniview_exp_type(package_dir, exp_type, ev)
    expclass = classify(exp_type)
    if expclass == exp_type:
        # uniview 独有类型（Jank/Assert/WCN/Boot Category）在包名里
        base = os.path.basename(package_dir)
        for name, pat in (("Jank", _JANK_RE), ("Assert", _ASSERT_RE), ("WCN", _WCN_RE)):
            if pat.search(base):
                expclass = name
                break

    detail = _find_file(package_dir, ("detail.txt",))
    detail_lines = _read_lines(detail) if detail else []
    package = _extract_package(detail_lines, package_dir)
    # exp_detail 先取（uniview 包 CausedBy/Detail 兜底，流式解包）
    exp_detail = _extract_exp_detail(package_dir)
    caused_by = extract_caused_by(expclass, package_dir, exp_detail)
    if not caused_by and expclass not in _SKIP_UNIVIEW_CAUSE_FALLBACK:
        # uniview：message/reboot_reason 可作弱兜底；不用 event_name（过粗）
        if ev:
            caused_by = (ev.get("message") or ev.get("reboot_reason") or "").strip()[:200]
    if expclass in ("Jank", "Assert", "WCN", "SR"):
        # 参照 MTK：特殊类型无法确定进程时，CurProcess/Package 直接填 ExpClass
        package = expclass
    if expclass == "SR" or not caused_by:
        # MTK 兜底：SR（严重重启）每个问题单独看待；其他类型无根因时防误合并
        caused_by = _fallback_caused_by(expclass, package)

    summary = _find_summary(package_dir)
    pid = _extract_pid(package_dir, ev, detail_lines)
    rom_ram = _extract_rom_ram(package_dir)
    # Detail 主体：MTK 识别报告模板（Device_id/版本/包名/进程/pid/Backtrace + 现场段）
    detail_text = _build_detail(expclass, package_dir, exp_detail, ev, summary,
                                version, device, package, pid, detail_lines)
    if not detail_text and detail:
        detail_text = "\n".join(detail_lines)[:2000]

    rec = {
        "Path": _abs_path(summary or detail or package_dir),
        "Version": version,
        "ExpTime": ts,
        "ExpType": exp_type,
        "CurProcess": package,
        "Package": package,
        "Detail": detail_text,
        "CausedBy": caused_by,
        "extraTag": "",
        "sum": 1,
        "snNum": device,
        "ExpClass": expclass,
        "Rom_Ram": rom_ram,
        "_package_dir": package_dir,
    }
    return rec


def _apply_ylog_enrich(records, save_root, config=None):
    """设备级 ylog/ 方案 B enrich；失败单条不影响整体。"""
    if not records:
        return records
    cfg = (config or {}).get("ylog_enrich", {})
    if cfg.get("enabled", True) is False:
        TEST_LOGGER.info("ylog enrich 已关闭，跳过")
        return records
    from modules.ylog_enrich import enrich_record

    total = len(records)
    TEST_LOGGER.info("ylog enrich 开始（%d 条）" % total)
    out = []
    for idx, rec in enumerate(records, 1):
        pkg_dir = rec.pop("_package_dir", None)
        label = "%s/%s %s" % (
            rec.get("ExpClass", ""), rec.get("ExpTime", ""),
            os.path.basename(pkg_dir) if pkg_dir else "?")
        TEST_LOGGER.info("ylog enrich [%d/%d] %s" % (idx, total, label))
        if pkg_dir:
            try:
                enrich_record(rec, pkg_dir, save_root, config)
            except Exception as exc:
                TEST_LOGGER.warn("ylog enrich 失败: %s (%s)" % (label, exc))
        # SR 等 enrich 后若误补 CausedBy，SR 仍强制兜底
        if rec.get("ExpClass") == "SR":
            rec["CausedBy"] = _fallback_caused_by(rec["ExpClass"], rec.get("Package", ""))
        elif not rec.get("CausedBy"):
            rec["CausedBy"] = _fallback_caused_by(
                rec.get("ExpClass", ""), rec.get("Package", ""))
        out.append(rec)
    TEST_LOGGER.info("ylog enrich 完成")
    return out


def _abs_path(path):
    """相对/绝对路径统一为绝对路径；空则返回 ''。"""
    return os.path.abspath(path) if path else ""


def _load_device_rom_ram(root):
    """第一阶段采集的设备级 rom_ram.json：{version}/{device}/rom_ram.json -> {device: '64GB+4GB'}。

    全部问题包统一使用设备级值（覆盖 dropbox/tombstone/小包等无聚合包的场景）。
    """
    result = {}
    try:
        for version in os.listdir(root):
            vpath = os.path.join(root, version)
            if not os.path.isdir(vpath):
                continue
            for device in os.listdir(vpath):
                p = os.path.join(vpath, device, "rom_ram.json")
                if not os.path.isfile(p):
                    continue
                try:
                    with open(p, encoding="utf-8") as f:
                        info = json.load(f)
                    parts = []
                    if info.get("rom"):
                        parts.append("%dGB" % int(info["rom"]))
                    if info.get("ram"):
                        parts.append("%dGB" % int(info["ram"]))
                    if parts:
                        result[device] = "+".join(parts)
                except (OSError, ValueError, TypeError):
                    continue
    except OSError:
        pass
    return result


def collect_problems(root, config=None):
    """扫描问题包目录，返回记录列表（12 列 dict，多设备支持）。"""
    root = os.path.abspath(root)
    set_active_rules(config)
    TEST_LOGGER.info("扫描根目录: %s" % root)
    packages = _find_problem_dirs(root)
    if not packages:
        TEST_LOGGER.warn("未发现问题包目录")
        return []
    TEST_LOGGER.info("发现问题包: %d" % len(packages))
    device_rom_ram = _load_device_rom_ram(root)
    records = []
    total = len(packages)
    for idx, pkg in enumerate(packages, 1):
        device = os.path.basename(os.path.dirname(pkg))
        version = os.path.basename(os.path.dirname(os.path.dirname(pkg)))
        pkg_name = os.path.basename(pkg)
        TEST_LOGGER.info("采集 [%d/%d] %s/%s %s" % (idx, total, version, device, pkg_name))
        rec = _collect_package(pkg, version, device)
        if device in device_rom_ram:
            rec["Rom_Ram"] = device_rom_ram[device]
        records.append(rec)
        TEST_LOGGER.info("  -> ExpClass=%s Package=%s" % (
            rec.get("ExpClass"), rec.get("Package")))
    records = _apply_ylog_enrich(records, root, config)
    records.sort(key=lambda r: (r["ExpClass"], r["Package"], r["ExpTime"]))
    TEST_LOGGER.info("采集完成，共 %d 条记录" % len(records))
    return records
