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

from modules.classify import classify

_TS_RE = re.compile(r"(\d{4}-\d{2}-\d{2})-(\d{6})$")
_SIGNAL_RE = re.compile(r"signal\s+\d+\s*\(([^)]*)\)")
_JANK_RE = re.compile(r"Jank|focus timeout|102200004", re.IGNORECASE)
_ASSERT_RE = re.compile(r"Assert|109000001", re.IGNORECASE)
_WCN_RE = re.compile(r"WCN|109000003", re.IGNORECASE)
_PACKAGE_RE = re.compile(r"^(.+)[_-](\d{4}-\d{2}-\d{2}-\d{6})$")


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


def _read_lines(path, max_lines=None):
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            lines = f.read().splitlines()
        return lines[:max_lines] if max_lines else lines
    except OSError:
        return []


def _uniview_info(package_dir):
    """读取 uniview 事件元信息 json（unievent_info.json，包根）。"""
    p = os.path.join(package_dir, "unievent_info.json")
    if not os.path.isfile(p):
        return None
    try:
        import json
        return json.loads(open(p, encoding="utf-8").read())
    except (OSError, ValueError):
        return None


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
                    # 2) DATA_TOMBSTONES/tombstone_*（backtrace 现场兜底）
                    for member in tf.getmembers():
                        base = os.path.basename(member.name)
                        if ("/DATA_TOMBSTONES/" in member.name
                                and base.startswith("tombstone")):
                            f = tf.extractfile(member)
                            if f:
                                return f.read().decode("utf-8", "replace").splitlines()
            else:
                # Reboot 等类型在设备上即展开目录（名 {seq}-{ts}.tar.gz）
                for target in ("exp_detail.txt", "exp_main.txt"):
                    exp = os.path.join(p, target)
                    if os.path.isfile(exp):
                        with open(exp, encoding="utf-8", errors="replace") as f:
                            lines = f.read().splitlines()
                        if target == "exp_detail.txt" or _has_crash_signal(lines):
                            return lines
                # DATA_TOMBSTONES/tombstone_* 现场兜底
                for root, _dirs, files in os.walk(p):
                    if "DATA_TOMBSTONES" in root:
                        for f in files:
                            if f.startswith("tombstone"):
                                try:
                                    with open(os.path.join(root, f),
                                              encoding="utf-8", errors="replace") as fh:
                                        return fh.read().splitlines()
                                except OSError:
                                    continue
        except (OSError, tarfile.TarError, EOFError):
            continue
    return []


def _norm_pkg(p):
    """Package 统一为原始路径形式（/vendor/...），反替换第一阶段可能的 % 化。"""
    return p.replace("%", "/") if "%" in p else p


def _extract_package(detail_lines, package_dir):
    """包名：detail Process: 行；ANR 包用 anr_trace Cmd line:；uniview 包用 unievent_info proc；summary 兜底。"""
    for line in detail_lines:
        if "Process:" in line:
            return _norm_pkg(line.split("Process:", 1)[1].strip())
    trace = _find_file(package_dir, ("anr_trace.txt",))
    if trace:
        for line in _read_lines(trace, 100):
            if "Cmd line:" in line:
                return _norm_pkg(line.split("Cmd line:", 1)[1].strip())
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
    summary = _find_file(package_dir, ("{}_summary.txt".format(os.path.basename(package_dir)),))
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
    """SWT CausedBy：Blocked in 阻塞详情（Subject 行）完整显示，其次 Subject 行。

    完整显示必要性：去重的同类型问题须用相同规则匹配到（MTK 语义）。
    无阻塞详情（仅压力统计/无 Subject）时返回 ''，走 MTK 兜底（各自保留）。
    """
    for line in lines:
        if "Blocked in" in line:
            s = line.strip()
            if s.startswith("Subject:"):
                s = s[len("Subject:"):].strip()
            return s[:600]
    for line in lines:
        if line.strip().startswith("Subject:"):
            return line.strip()[:600]
    return ""


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
        subj = ""
        for line in lines:
            if "Subject:" in line:
                subj = line.strip()[len("Subject:"):].strip() or subj
        if subj:
            return subj[:200]
    elif expclass == "NE":
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
    elif expclass == "SWT":
        return _extract_caused_by_swt(lines)
    elif expclass == "KE":
        for line in lines:
            if "panic" in line.lower():
                return line.strip()[:200]
    else:  # JE 等：优先 Caused by 行，其次 Java 异常行
        for line in lines:
            if "Caused by:" in line:
                return line.strip()[:200]
        for line in lines:
            if re.match(r"^\s*(android\.|java\.|com\.|dalvik\.)\S*(Exception|Error)\b", line):
                return line.strip()[:200]
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
    if expclass == "NE":
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
    if expclass == "NE":
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
    elif expclass == "NE" and not lines:
        tb = _find_file(package_dir, ("tombstone.txt",))
        if tb:
            tb_lines = _read_lines(tb)
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
    ev = _uniview_info(package_dir)
    caused_by = extract_caused_by(expclass, package_dir, exp_detail)
    if not caused_by:
        # uniview 包：从 unievent_info 的 message/reboot_reason/event_name 提取
        if ev:
            caused_by = (ev.get("message")
                         or ev.get("reboot_reason")
                         or ev.get("event_name") or "")[:200]
            caused_by = caused_by.strip()
    if expclass in ("Jank", "Assert", "WCN", "SR"):
        # 参照 MTK：特殊类型无法确定进程时，CurProcess/Package 直接填 ExpClass
        package = expclass
    if expclass == "SR" or not caused_by:
        # MTK 兜底：SR（严重重启）每个问题单独看待；其他类型无根因时防误合并
        caused_by = _fallback_caused_by(expclass, package)

    summary = _find_file(package_dir, (
        "{}_summary.txt".format(os.path.basename(package_dir)),))
    pid = _extract_pid(package_dir, ev, detail_lines)
    rom_ram = _extract_rom_ram(package_dir)
    # Detail 主体：MTK 识别报告模板（Device_id/版本/包名/进程/pid/Backtrace + 现场段）
    detail_text = _build_detail(expclass, package_dir, exp_detail, ev, summary,
                                version, device, package, pid, detail_lines)
    if not detail_text and detail:
        detail_text = "\n".join(detail_lines)[:2000]

    return {
        "Path": summary or detail or package_dir,
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
    }


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


def collect_problems(root):
    """扫描问题包目录，返回记录列表（12 列 dict，多设备支持）。"""
    packages = _find_problem_dirs(root)
    if not packages:
        return []
    device_rom_ram = _load_device_rom_ram(root)
    records = []
    for pkg in packages:
        # 设备/版本从路径层级推导：{root}/{version}/{device}/{pkg}
        device = os.path.basename(os.path.dirname(pkg))
        version = os.path.basename(os.path.dirname(os.path.dirname(pkg)))
        rec = _collect_package(pkg, version, device)
        # 设备级 Rom_Ram 优先（覆盖无聚合包的 dropbox/tombstone/小包）
        if device in device_rom_ram:
            rec["Rom_Ram"] = device_rom_ram[device]
        records.append(rec)
    records.sort(key=lambda r: (r["ExpClass"], r["Package"], r["ExpTime"]))
    return records
