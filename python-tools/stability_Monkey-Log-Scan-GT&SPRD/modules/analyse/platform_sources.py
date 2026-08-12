# -*- coding: utf-8 -*-
"""平台额外日志源采集器（config.json -> platform.<name>.sources 驱动）。

当前实现 SPRD（展锐）源：/data/anr/ trace、/data/tombstones/、/data/ylog/。
设计见 docs/platform_diff_analysis.md。

- anr/tombstone 源：解析设备文件头部，构造与上游 dropbox 条目一致的包装形态，
  落盘到与 dropbox 采集同目录（下游 scan_result_GT 可直接消费）。
- raw 源：原样复制（单文件或目录递归）。
- 增量：状态文件记录 {name}:{size}:{mtime} 指纹，相同则跳过。
"""

import json
import os
import re
from datetime import datetime
from modules.common.adb_client import AdbClient
from modules.common.logger import TEST_LOGGER

_SEP = "=" * 40

# ---- 头部解析 ----

_TS_RE = re.compile(r"(\d{4}-\d{2}-\d{2}[ _]\d{2}:\d{2}:\d{2})")
_PID_TS_RE = re.compile(r"pid_(\d+)_(\d{4}-\d{2}-\d{2})-(\d{2})-(\d{2})-(\d{2})-(\d{2})")
_ANR_TS_RE = re.compile(r"----- pid \d+ at (\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})")
_TOMB_TS_RE = re.compile(r"Timestamp:\s*(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})")


def _same_second(ts_a, ts_b):
    """两个时间字符串（兼容 _/-/:/ 分隔，不含毫秒）是否同一秒。"""
    norm = lambda s: re.sub(r"[ _:/-]", "", s)[:14]
    try:
        return norm(ts_a) == norm(ts_b)
    except Exception:
        return False


def _fmt_ts(ts):
    return ts.replace(" ", "-").replace(":", "")


def parse_anr_trace(text):
    """从 ANR trace 文本提取 (pkg, pid, ts, subject)。"""
    pkg = ""
    pid = ""
    ts = ""
    subject = ""
    for line in text.splitlines()[:200]:
        stripped = line.strip()
        if not pkg and "Cmd line:" in stripped:
            pkg = stripped.split("Cmd line:", 1)[1].strip()
        if not pid and "----- dumping pid:" in stripped:
            m = re.search(r"----- dumping pid:\s*(\d+)", stripped)
            if m:
                pid = m.group(1)
        if not ts:
            m = _PID_TS_RE.search(line)
            if m:
                pid = m.group(1)
                ts = "-".join(m.groups()[1:])
            else:
                m = _ANR_TS_RE.search(stripped)
                if m:
                    ts = m.group(1)
        if not subject and "Subject:" in stripped:
            subject = stripped.split("Subject:", 1)[1].strip()
    return pkg, pid, ts, subject


def parse_tombstone(text):
    """从 tombstone 文本提取 (pkg, pid, ts)。"""
    pkg = ""
    pid = ""
    ts = ""
    for line in text.splitlines()[:200]:
        stripped = line.strip()
        if not pkg and stripped.startswith("Cmdline:"):
            pkg = stripped.split("Cmdline:", 1)[1].strip()
        if not pid and stripped.startswith("pid:"):
            m = re.search(r"pid:\s*(\d+)", stripped)
            if m:
                pid = m.group(1)
        if not ts:
            m = _TOMB_TS_RE.search(stripped)
            if m:
                ts = m.group(1)
        if pkg and pid and ts:
            break
    return pkg, pid, ts


def _safe_pkg(pkg):
    return pkg.replace("/", "%").replace(" ", "_") if pkg else "unknown"


def wrap_dropbox_entry(tag, text):
    return f"2026-08-05 00:00:00 {tag} (text, {len(text)} bytes)\n{_SEP}\n{text}"


def wrap_anr(pkg, pid, ts, subject, text):
    head = f"Process: {pkg}\nPID: {pid or '0'}\n"
    if ts:
        head += f"Timestamp: {ts}\n"
    if subject:
        head += f"Subject: {subject}\n"
    return wrap_dropbox_entry("data_app_anr", head + text)


def wrap_tombstone(pkg, pid, ts, text):
    head = f"Process: {pkg}\n"
    if pid:
        head += f"PID: {pid}\n"
    if ts:
        head += f"Timestamp: {ts}\n"
    return wrap_dropbox_entry("SYSTEM_TOMBSTONE", head + text)


# ---- 设备文件列举 ----

class PlatformSources:
    """平台额外日志源采集器。"""

    def __init__(self, device, save_root, platform, config, adb=None):
        self.device = device
        self.save_root = save_root
        self.platform = platform
        self.config = config
        self.adb = adb or AdbClient()

    # ---- 状态 ----

    def _state_file(self):
        return os.path.join(self.save_root, f"output_{self.device}_platform.json")

    def _load_state(self):
        try:
            import json
            with open(self._state_file(), encoding="utf-8") as f:
                return json.load(f)
        except (FileNotFoundError, ValueError):
            return {}

    def _save_state(self, state):
        import json
        with open(self._state_file(), "w", encoding="utf-8") as f:
            json.dump(state, f, indent=2)

    # ---- 拉取 ----

    def _device_cat(self, path):
        return "\n".join(self.adb.run_command(f"adb -s {self.device} shell cat {path}"))

    def _dest_dir(self, folder):
        """目标目录：ylog 相关源落 {save}/{device}/ylog/（设备目录下，同版本多设备不混），其余落 {save}/{device}/。"""
        folder = folder.replace("\\", "/")
        if folder == "ylog" or folder.startswith("ylog/"):
            return os.path.join(self.save_root, self.device, "ylog", folder[5:])
        return os.path.join(self.save_root, self.device, folder)

    def _problem_package_dir(self, type_name, ts):
        """问题包目录：{save}/{device}/{type}_{ts}/"""
        if type_name and not ts:
            # prefix 已含完整包名（如 data-app-crash_2026-08-05-110144）
            return os.path.join(self.save_root, self.device, type_name)
        ts_safe = _fmt_ts(ts) if ts else "unknown"
        return os.path.join(self.save_root, self.device,
                            f"{type_name.replace('_', '-')}_{ts_safe}")

    def _resolve_package_dir(self, type_name, ts):
        """问题包目录：同秒已有包（uniview 为准的实体）则复用，否则新建。"""
        ts_safe = _fmt_ts(ts) if ts else "unknown"
        problems_root = os.path.join(self.save_root, self.device)
        if os.path.isdir(problems_root):
            for name in os.listdir(problems_root):
                if name.endswith(f"_{ts_safe}"):
                    return os.path.join(problems_root, name)
        return self._problem_package_dir(type_name, ts)

    def _handle_anr_trace(self, src_cfg, item_path, name):
        text = self._device_cat(item_path)
        pkg, pid, ts, subject = parse_anr_trace(text)
        if not ts:
            m = _PID_TS_RE.search(name)
            ts = "-".join(m.groups()[1:]) if m else ""
        package_dir = self._problem_package_dir("data_app_anr", ts)
        os.makedirs(package_dir, exist_ok=True)
        with open(os.path.join(package_dir, "anr_trace.txt"), "w", encoding="utf-8") as f:
            f.write(text)
        self._link_ap_segment(ts, package_dir)
        self._build_platform_summary("data_app_anr", ts, pkg, ["ANR"],
                                     detail_lines=text.splitlines(),
                                     extra_sources={"anr_trace": text.splitlines()},
                                     package_dir=package_dir)
        return os.path.join(package_dir, "anr_trace.txt")

    def _handle_tombstone(self, src_cfg, item_path, name):
        text = self._device_cat(item_path)
        pkg, pid, ts = parse_tombstone(text)
        package_dir = self._resolve_package_dir("SYSTEM_TOMBSTONE", ts)
        os.makedirs(package_dir, exist_ok=True)
        with open(os.path.join(package_dir, "tombstone.txt"), "w", encoding="utf-8") as f:
            f.write(text)
        self._link_ap_segment(ts, package_dir)
        self._build_platform_summary("SYSTEM_TOMBSTONE", ts, pkg, ["FC"],
                                     detail_lines=text.splitlines(),
                                     extra_sources={"tombstone": text.splitlines()},
                                     package_dir=package_dir)
        return os.path.join(package_dir, "tombstone.txt")

    def _link_ap_segment(self, ts, package_dir):
        """ap 分段覆盖事件时间时导出到共享 {version}/ylog/ 并写包内 ylog.txt 引用。

        与 dropbox 补充包同规则（anr_trace/tombstone 本身是完整现场，ylog 段作补充）。
        """
        try:
            from modules.analyse.dropbox_monitor import export_ap_segment, find_ap_window

            seg = find_ap_window(self.adb, self.device, ts)
            if seg:
                export_ap_segment(self.adb, self.device, seg,
                                  os.path.join(self.save_root, self.device, "ylog"), package_dir)
        except Exception as e:
            TEST_LOGGER.info(f"ylog 段关联失败 {self.device}: {e}")

    def _build_platform_summary(self, type_name, ts, pkg, scenes, detail_lines,
                                extra_sources, package_dir=None):
        """平台源包装条目生成汇总 txt（与 dropbox 条目汇总同目录）。"""
        try:
            from modules.analyse.summary_builder import build_summary

            out_dir = package_dir or os.path.join(self.save_root, self.device, "summary")
            path = build_summary(
                device=self.device,
                type_name=type_name,
                ts=ts or "unknown",
                package=pkg,
                scenes=scenes,
                detail_lines=detail_lines,
                extra_sources=extra_sources,
                out_dir=out_dir,
            )
            TEST_LOGGER.info(f"平台源报错汇总: {path}")
        except Exception as e:
            TEST_LOGGER.info(f"平台源汇总失败 {type_name}: {e}")

    # ---- uniview（展锐异常监控，AEE 等价物）----

    def _handle_uniview(self, src_cfg, type_dir):
        """处理单个 uniview 类型目录：unievent_info 增量检测 + 新 tar.gz 拉取。

        type_dir: /data/ylog/uniview_exception/{Type.event_id}
        返回新增事件 dict 列表（含 tag/event_name 信号），供事件检测。
        """
        import json as _json

        info_lines = self.adb.run_command(
            f"adb -s {self.device} shell cat {type_dir}/unievent_info")
        events = []
        for line in info_lines:
            line = line.strip()
            if not line or not line.startswith("{"):
                continue
            try:
                obj = _json.loads(line)
            except ValueError:
                continue
            # 事件行特征：含 kick_datetime / event_time / reboot_reason
            if any(k in obj for k in ("kick_datetime", "event_time", "reboot_reason")):
                events.append(obj)
        if not events:
            # 无 unievent_info 记录但有 tmp/（half 事件，如 ANR 半程中断）：
            # 按类型目录补采 pre_logs 到已存在的问题包
            has_tmp = self.adb.run_command(
                f'adb -s {self.device} shell "ls {type_dir}/tmp 2>/dev/null"')
            if has_tmp:
                type_dir_name = os.path.basename(type_dir).split(".")[0]
                self._archive_uniview_prelogs(src_cfg, type_dir,
                                              {"tag": type_dir_name})
            return []

        seen = src_cfg.get("_uniview_seen", 0)
        new_events = events[seen:]
        if not new_events:
            return []
        # 过滤正常重启（reboot_reason=normalboot 非报错，uniview 记录每次开机）
        new_events = [ev for ev in new_events
                      if ev.get("reboot_reason") != "normalboot"]
        if not new_events:
            src_cfg["_uniview_seen"] = len(events)
            return []

        # 目录下 tar.gz 文件（{seq}-{ts}.tar.gz），按序号对应事件
        tars = self.adb.run_command(
            f'adb -s {self.device} shell "ls {type_dir}"')
        tar_names = sorted(t for t in (x.strip() for x in tars)
                           if t.endswith(".tar.gz"))
        # seen 逐事件推进：仅 tar 成功拉取（ok）或确认设备无对应包（none）才推进；
        # 设备有 tar 但匹配失败（nomatch）不推进，下次重试（避免永久漏导）
        processed = seen
        for ev in new_events:
            try:
                status = self._archive_uniview_event(src_cfg, type_dir, ev, tar_names)
                if status == "ok":
                    processed += 1
                    src_cfg["_uniview_seen"] = processed
                elif status == "none":
                    processed += 1
                    src_cfg["_uniview_seen"] = processed
                else:  # nomatch：设备有包但未匹配，保留 seen 下次重试
                    break
                # none（设备无对应包）：half 事件先补采 pre_logs，
                # 仍无现场（除元信息外无文件）且无 ylog -> 舍弃空壳包
                if status == "none":
                    if not tar_names:
                        self._archive_uniview_prelogs(src_cfg, type_dir, ev)
                    self._prune_event_shell(ev)
            except Exception as e:
                TEST_LOGGER.info(f"uniview 事件归档失败 {type_dir}: {e}")
                break
        return new_events

    def _archive_uniview_prelogs(self, src_cfg, type_dir, ev):
        """half 事件（无 tar.gz）：拉取 tmp/*/pre_logs/ 关键日志到问题包根。

        pre_logs 含 SYS_ANDROID_LOG / SYS_KERNEL_LOG（half ANR 流程中断未打包的日志）。
        ts 缺失时（无 unievent_info）归档到同类型最新问题包。
        """
        ts_raw = ev.get("kick_datetime", "") or ""
        m = re.search(r"(\d{4}-\d{2}-\d{2})_(\d{2})[:-](\d{2})[:-](\d{2})", ts_raw)
        ts_safe = f"{m.group(1)}-{m.group(2)}{m.group(3)}{m.group(4)}" if m else ""
        tag = ev.get("tag") or os.path.basename(type_dir).split(".")[0]
        type_name = tag.replace(" ", "-").replace("/", "-")

        if ts_safe:
            package_dir = self._problem_package_dir(type_name, ts_safe)
        else:
            # 无事件记录：归档到同类型最新问题包（子串匹配，如 ANR -> data-app-anr）
            candidates = []
            problems_root = os.path.join(self.save_root, self.device)
            if os.path.isdir(problems_root):
                for name in os.listdir(problems_root):
                    if type_name.lower() in name.lower():
                        candidates.append(os.path.join(problems_root, name))
            candidates.sort(key=os.path.getmtime, reverse=True)
            if not candidates:
                return None
            package_dir = candidates[0]
        os.makedirs(package_dir, exist_ok=True)

        # 查找 tmp/*/pre_logs/ 下文件
        prelogs = self.adb.run_command(
            f'adb -s {self.device} shell "find {type_dir}/tmp -path */pre_logs/* -type f"')
        for p in prelogs:
            p = p.strip()
            if not p:
                continue
            local = os.path.join(package_dir, os.path.basename(p))
            if os.path.exists(local):
                continue
            self.adb._run_argv(
                ["adb", "-s", self.device, "pull", p, local], timeout=300)
            if os.path.exists(local) and os.path.getsize(local) > 0:
                TEST_LOGGER.info(f"uniview prelogs: {local}")
        return package_dir

    def _archive_uniview_event(self, src_cfg, type_dir, ev, tar_names):
        """单个 uniview 事件：tar.gz 落问题包根（不解包）。"""
        import re as _re

        ts_raw = ev.get("kick_datetime", "") or ""
        # ts 优先从 kick_datetime 解析（兼容 - 与 : 分隔），其次 tar 文件名
        # 2026-08-05_17-21-44.946 / 2026-08-04_20:55:11.404 -> 2026-08-05-172144
        ts_safe = ""
        m = _re.search(r"(\d{4}-\d{2}-\d{2})_(\d{2})[:-](\d{2})[:-](\d{2})", ts_raw)
        if m:
            ts_safe = f"{m.group(1)}-{m.group(2)}{m.group(3)}{m.group(4)}"
        # tag -> 类型目录名（Type.event_id）-> event_name，均 sanitize
        tag = ev.get("tag") or ""
        type_dir_name = os.path.basename(type_dir).split(".")[0]
        type_name = (tag or type_dir_name or ev.get("event_name", "uniview"))
        type_name = type_name.replace(" ", "-").replace("/", "-")
        package_dir = self._problem_package_dir(type_name, ts_safe or "unknown")
        os.makedirs(package_dir, exist_ok=True)

        # 事件元信息落盘（供第二阶段提取 Package/CausedBy）
        info_path = os.path.join(package_dir, "unievent_info.json")
        if not os.path.exists(info_path):
            with open(info_path, "w", encoding="utf-8") as f:
                f.write(json.dumps(ev, ensure_ascii=False, indent=2))
        # summary 生成（uniview 事件基础信息）
        from modules.analyse.summary_builder import build_summary
        scenes = [ev.get("event_name") or type_dir_name]
        summary_path = os.path.join(
            package_dir,
            f"{os.path.basename(package_dir)}_summary.txt")
        if not os.path.exists(summary_path):
            build_summary(
                device=self.device,
                type_name=type_name,
                ts=ts_safe or "unknown",
                package=ev.get("proc", ""),
                scenes=scenes,
                detail_lines=[json.dumps(ev, ensure_ascii=False)],
                extra_sources={"unievent_info": [json.dumps(ev, ensure_ascii=False)]},
                out_dir=package_dir,
            )

        # 匹配对应 tar.gz：时间戳多变体精确匹配
        # 返回状态：ok（已导出/拉取成功）、nomatch（设备有疑似包但未匹配）、none（设备无对应包）
        target = None
        ts_raw_base = ts_raw.split(".")[0] if ts_raw else ""
        # 变体覆盖：原始(:) / tar 名格式(: -> -) / 下划线 / 压缩格式
        ts_variants = [ts_raw_base,
                       ts_raw_base.replace(":", "-"),
                       ts_raw_base.replace("-", "_"),
                       ts_safe]
        for name in tar_names:
            if any(v and v in name for v in ts_variants):
                target = name
                break
        if target is None:
            # 设备有同秒 tar 但未匹配（时间戳格式未知）-> nomatch 不推进 seen 下次重试；
            # 否则设备无对应包 -> none 推进（连环 crash 设备只留首个包，同日其他事件无包）
            if ts_raw_base:
                for n in tar_names:
                    m = _re.search(r"\d{4}-\d{2}-\d{2}[_-]\d{2}[-:]\d{2}[-:]\d{2}", n)
                    if m and _same_second(m.group(0), ts_raw_base):
                        return "nomatch"
            return "none"

        local = os.path.join(package_dir, target)
        if os.path.exists(local):
            return "ok"
        self.adb._run_argv(
            ["adb", "-s", self.device, "pull", f"{type_dir}/{target}", local],
            timeout=300)
        if os.path.exists(local) and (os.path.isfile(local) and os.path.getsize(local) > 0
                                      or os.path.isdir(local)):
            return "ok"
        return "none"

    def _prune_event_shell(self, ev):
        """仅事件记录（无 tar/无现场/无 ylog 覆盖）的事件包舍弃。

        现场判定：包内除 unievent_info/summary 元信息外有任何文件（tar/日志/prelogs）；
        ylog 兜底：ap 分段覆盖则导出引用保留，否则删包。
        """
        try:
            import shutil

            ts_raw = ev.get("kick_datetime", "") or ""
            m = re.search(r"(\d{4}-\d{2}-\d{2})_(\d{2})[:-](\d{2})[:-](\d{2})", ts_raw)
            ts_safe = f"{m.group(1)}-{m.group(2)}{m.group(3)}{m.group(4)}" if m else ""
            tag = ev.get("tag") or ""
            type_name = tag.replace(" ", "-").replace("/", "-")
            package_dir = self._problem_package_dir(type_name, ts_safe or "unknown")
            if not os.path.isdir(package_dir):
                return False

            files = os.listdir(package_dir)
            if any(not (f.endswith("_summary.txt") or f == "unievent_info.json")
                   for f in files):
                return False
            if m:
                from modules.analyse.dropbox_monitor import export_ap_segment, find_ap_window

                ts_str = f"{m.group(1)} {m.group(2)}:{m.group(3)}:{m.group(4)}"
                seg = find_ap_window(self.adb, self.device, ts_str)
                if seg:
                    export_ap_segment(self.adb, self.device, seg,
                                      os.path.join(self.save_root, self.device, "ylog"), package_dir)
                    return False
            shutil.rmtree(package_dir, ignore_errors=True)
            TEST_LOGGER.info(
                f"舍弃空壳事件包 {os.path.basename(package_dir)}：无 tar/无现场/无 ylog")
            return True
        except Exception as e:
            TEST_LOGGER.info(f"空壳事件包处理异常 {os.path.basename(package_dir)}: {e}")
            return False

    def _handle_raw(self, src_cfg, item_path):
        text = self._device_cat(item_path)
        dest_dir = self._dest_dir(src_cfg["dest_folder"])
        os.makedirs(dest_dir, exist_ok=True)
        if src_cfg.get("recursive"):
            rel = os.path.relpath(item_path, src_cfg["device_path"])
            dest = os.path.join(dest_dir, rel)
        else:
            dest = os.path.join(dest_dir, os.path.basename(item_path))
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        with open(dest, "w", encoding="utf-8", errors="replace") as f:
            f.write(text)
        return dest

    def _handle_bugreport(self, src_cfg, item_path):
        """adb bugreport 快照（异常类型 TS/SR 等需要全量系统状态）。

        adb bugreport <file> 直接写 PC 端文件（bugreport 输出不经 stdout）。
        """
        import datetime as _dt
        import subprocess as _sp

        dest_dir = self._dest_dir(src_cfg["dest_folder"])
        os.makedirs(dest_dir, exist_ok=True)
        ts = _dt.datetime.now().strftime("%Y%m%d_%H%M%S")
        dest = os.path.join(dest_dir, f"{self.device}_bugreport_{ts}.txt")
        _sp.run(
            ["adb", "-s", self.device, "bugreport", dest],
            capture_output=True, timeout=600,
        )
        return dest

    def snapshot_bugreport(self, prefix=None):
        """事件驱动：按需抓取 bugreport（关联条目命名 + 冷却白名单）。

        prefix: 关联条目标识（如 data_app_crash_2026-08-05-110144），
                命名 {device}_{prefix}_bugreport.zip（参照 MTK correlated_bugreports）。
        冷却：events.bugreport_cooldown_minutes + cooldown_event_types 白名单
              （白名单内类型受冷却限制；白名单外每次触发都导）。
        """
        import datetime as _dt
        import subprocess as _sp
        import time as _time

        events_cfg = self.config.get("events") or {}
        cooldown = events_cfg.get("bugreport_cooldown_minutes", 10) * 60
        cooldown_types = set(events_cfg.get("bugreport_cooldown_event_types", ["ANR", "CRASH"]))
        state = self._load_state()
        last = state.get("_bugreport_last", 0)

        def _scene_of(prefix):
            scene_map = events_cfg.get("scene_map", {})
            for scene, keywords in scene_map.items():
                if any(kw in (prefix or "") for kw in keywords):
                    return scene
            return None

        scene = _scene_of(prefix)
        if scene in cooldown_types and _time.time() - last < cooldown:
            return None

        package_dir = self._problem_package_dir(prefix or "event", "")
        os.makedirs(package_dir, exist_ok=True)
        final_path = os.path.join(package_dir, "bugreport.zip")
        if os.path.exists(final_path):
            return final_path
        # adb bugreport <path> 实际生成 <path>.zip —— temp 命名需含 .zip 才能被 os.replace 命中
        temp_path = final_path + ".partial.zip"
        try:
            _sp.run(
                ["adb", "-s", self.device, "bugreport", temp_path],
                capture_output=True, timeout=600,
            )
            if os.path.exists(temp_path):
                os.replace(temp_path, final_path)
            else:
                # 兜底：adb 生成的实际文件可能与预期名不同
                import glob as _glob
                cands = _glob.glob(temp_path + "*")
                if cands:
                    os.replace(cands[0], final_path)
        except Exception:
            if os.path.exists(temp_path):
                try:
                    os.remove(temp_path)
                except OSError:
                    pass
            return None
        state["_bugreport_last"] = int(_time.time())
        self._save_state(state)
        return final_path

    def export_correlated_ap(self, ts, prefix=None):
        """事件驱动：ylog ap 分段按时间窗定位导出（参照 MTK correlated_mobilelogs）。

        解析 ap 分段名 {seq}-{start}--{end}.ylog，找异常时间后第一个段，
        导出其前后各 2 段到问题包 ylog_ap/ 目录。
        """
        import datetime as _dt
        import re as _re

        files = self.adb.run_command(
            f'adb -s {self.device} shell "ls /data/ylog/ap/"')
        files = [f.strip() for f in files if f.strip() and f.strip().endswith(".ylog")]
        if not files:
            return []
        pattern = _re.compile(r"\d+-(\d{4}_\d{6})--")
        infos = []
        now = _dt.datetime.now()
        for f in files:
            m = pattern.search(f)
            if not m:
                continue
            raw = m.group(1)  # MMdd_HHmmss（分段名无年份，用当前年补全）
            try:
                start = _dt.datetime.strptime(f"{now.year}_{raw}", "%Y_%m%d_%H%M%S")
                infos.append({"name": f, "start": start})
            except ValueError:
                continue
        if not infos:
            return []
        infos.sort(key=lambda x: x["start"])
        aee_dt = None
        for fmt in ("%Y-%m-%d %H:%M:%S", "%Y-%m-%d-%H%M%S", "%Y%m%d_%H%M%S"):
            try:
                aee_dt = _dt.datetime.strptime(ts, fmt)
                break
            except ValueError:
                continue
        if aee_dt is None:
            return []
        target = next((i for i, f in enumerate(infos) if f["start"] > aee_dt), len(infos))
        start_idx = max(0, target - 2)
        end_idx = min(len(infos), target + 2)
        dest_dir = os.path.join(self._problem_package_dir(prefix or "event", ""), "ylog_ap")
        os.makedirs(dest_dir, exist_ok=True)
        pulled = []
        for info in infos[start_idx:end_idx]:
            local = os.path.join(dest_dir, info["name"])
            if os.path.exists(local):
                continue
            self.adb._run_argv(
                ["adb", "-s", self.device, "pull", f"/data/ylog/ap/{info['name']}", local],
                timeout=300)
            if os.path.exists(local) and os.path.getsize(local) > 0:
                pulled.append(local)
        return pulled

    def snapshot_meminfo(self, prefix=None):
        """事件驱动：dumpsys meminfo 快照，落问题包内。"""
        lines = self.adb._run_argv(
            ["adb", "-s", self.device, "shell", "dumpsys meminfo"], timeout=120)
        if not lines:
            return None
        package_dir = self._problem_package_dir(prefix or "event", "")
        os.makedirs(package_dir, exist_ok=True)
        dest = os.path.join(package_dir, "meminfo.txt")
        with open(dest, "w", encoding="utf-8", errors="replace") as f:
            f.write("\n".join(lines))
        return dest

    # ---- 主入口 ----

    def scan(self):
        """拉取全部新增源文件；返回 (新增文件数, 新增事件源名列表)。"""
        sources = (self.config.get("platform") or {}).get(self.platform, {}).get("sources", [])
        if not sources:
            return 0, []
        state = self._load_state()
        new_count = 0
        event_sources = []
        for src in sources:
            name = src["name"]
            wrap = src.get("wrap", "raw")
            dev_path = src["device_path"]
            src_state = state.get(name)
            if not isinstance(src_state, dict):
                src_state = {}  # 旧格式（单指纹字符串）迁移：视为未记录
            if wrap == "uniview":
                # uniview：按类型目录处理（unievent_info 增量 + tar.gz 归档）
                type_dirs = self.adb.run_command(
                    f'adb -s {self.device} shell "ls {dev_path}"')
                type_dirs = [d.strip() for d in type_dirs if d.strip()]
                for td in type_dirs:
                    cfg = dict(src)
                    cfg["_uniview_seen"] = src_state.get(td, {}).get("seen", 0)
                    new_events = self._handle_uniview(cfg, f"{dev_path}/{td}")
                    if new_events:
                        src_state[td] = {"seen": cfg["_uniview_seen"]}
                        state[name] = src_state
                        # 事件信号：tag 与 event_name 均加入（scene_map 匹配）
                        for ev in new_events:
                            for sig in (ev.get("tag"), ev.get("event_name")):
                                if sig and sig not in event_sources:
                                    event_sources.append(sig)
                continue
            if src.get("single_file"):
                items = [dev_path]
            elif src.get("recursive"):
                items = self.adb.run_command(
                    f'adb -s {self.device} shell "find {dev_path} -type f"')
            else:
                items = self.adb.run_command(f'adb -s {self.device} shell "ls {dev_path}"')
            items = [l.strip() for l in items if l.strip()]
            for item in items:
                item_name = os.path.basename(item)
                if item_name.endswith(".pb"):
                    continue
                fingerprint = f"{item}"
                if src_state.get(item) == fingerprint:
                    continue
                item_path = item if (src.get("recursive") or src.get("single_file")) else f"{dev_path}/{item}"
                try:
                    if wrap == "anr":
                        self._handle_anr_trace(src, item_path, item_name)
                    elif wrap == "tombstone":
                        self._handle_tombstone(src, item_path, item_name)
                    else:
                        self._handle_raw(src, item_path)
                    src_state[item] = fingerprint
                    state[name] = src_state
                    new_count += 1
                    if name not in event_sources:
                        event_sources.append(name)
                except Exception as e:
                    TEST_LOGGER.info(f"源 {name} 拉取失败 {item}: {e}")
        self._save_state(state)
        return new_count, event_sources


def detect_platform(adb, device):
    """自动探测平台：/data/ylog 存在 -> sprd；否则 None。"""
    lines = adb.run_command(f"adb -s {device} shell ls /data/ylog")
    return "sprd" if lines else None
