# -*- coding: utf-8 -*-
"""dropbox 问题分析器：由 config.json 的 dropbox.types 配置驱动，
合并原 problem/{block,data,sys} 下 14 个同模板类。

上下文取舍：dropbox 报错条目须有 ylog ap 分段覆盖才建包（logcat 不参与，
logd 环形缓冲对历史事件无效，见 docs/platform_diff_analysis.md 5.8）。
"""

import os
import re
from datetime import datetime, timedelta

from modules.common.adb_client import AdbClient
from modules.common.logger import TEST_LOGGER

_TS_RE = re.compile(r"Timestamp:\s*(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})")
# ap 分段名：{seq}-{MMdd_HHmmss}--{MMdd_HHmmss}.ylog；活跃段无 end（如 082-0804_180232_poweron.ylog）
_AP_RE = re.compile(r"^(\d+)-(\d{4})_(\d{6})(?:--(\d{4})_(\d{6}))?(?:_\w+)?\.ylog$")


def _interpret_seg_time(mmdd, hhmmss, anchor, now=None):
    """分段名 MMdd_HHmmss 无年份：按 anchor 年解释，结合当前时刻修正 ±1 年。

    now 默认取 datetime.now()（设备扫描时刻），测试可注入。
    """
    now = now or datetime.now()
    dt = datetime(anchor.year, int(mmdd[:2]), int(mmdd[2:4]),
                  int(hhmmss[:2]), int(hhmmss[2:4]), int(hhmmss[4:6]))
    if dt > now:
        dt = datetime(anchor.year - 1, dt.month, dt.day, dt.hour, dt.minute, dt.second)
    elif dt < now - timedelta(days=365):
        dt = datetime(anchor.year + 1, dt.month, dt.day, dt.hour, dt.minute, dt.second)
    return dt


def find_ap_window(adb, device, ts):
    """设备 ap/ 分段中覆盖 ts（YYYY-MM-DD HH:MM:SS）的分段名；无则 None。

    取舍规则：报错须有 ylog 分段覆盖才有上下文（dropbox 补充/平台源建包共用）。
    无 end 的分段（poweron/异常命名）：end 取下一段 start，最大 seq 视为活跃段。
    """
    try:
        anchor = datetime.strptime(ts, "%Y-%m-%d %H:%M:%S")
    except (TypeError, ValueError):
        return None
    lines = adb.run_command(f"adb -s {device} shell ls /data/ylog/ap/")
    segs = []
    for line in lines:
        m = _AP_RE.match(line.strip())
        if m:
            segs.append((int(m.group(1)), m))
    if not segs:
        return None
    segs.sort()
    for i, (seq, m) in enumerate(segs):
        try:
            start = _interpret_seg_time(m.group(2), m.group(3), anchor)
            if start > anchor:
                continue
            if m.group(4):
                end = _interpret_seg_time(m.group(4), m.group(5), anchor)
                if anchor > end:
                    continue
            elif i + 1 < len(segs):
                # 无 end 段：end = 下一段 start（如 poweron 段）
                next_m = segs[i + 1][1]
                end = _interpret_seg_time(next_m.group(2), next_m.group(3), anchor)
                if anchor > end:
                    continue
            # 最大 seq 无 end = 活跃段，覆盖至现在
        except ValueError:
            continue
        return m.group(0)
    return None


def export_ap_segment(adb, device, seg, ylog_dir, package_dir):
    """导出 ap 分段到共享 ylog_dir（已存在则跳过，避免重复导出）。

    包内写 ylog.txt 引用（相对路径），供研发定位上下文。
    """
    os.makedirs(ylog_dir, exist_ok=True)
    local = os.path.join(ylog_dir, seg)
    if not os.path.exists(local):
        adb._run_argv(
            ["adb", "-s", device, "pull", f"/data/ylog/ap/{seg}", local],
            timeout=300)
        if not (os.path.exists(local) and os.path.getsize(local) > 0):
            return None
        TEST_LOGGER.info(f"ylog 上下文: {local}")
    rel = os.path.relpath(local, os.path.dirname(package_dir))
    with open(os.path.join(package_dir, "ylog.txt"), "w", encoding="utf-8") as f:
        f.write(f"{os.path.basename(local)}\n{rel}\n")
    return local


class DropboxMonitor:
    def __init__(self, device, folderpath, type_name, type_config):
        self.device = device
        self.folderpath = os.path.join(folderpath, device, type_config["folder"])
        self.type_name = type_name
        self.type_config = type_config
        self.adb = AdbClient()

    def _extract_name_timestamp(self, detail, entry_time):
        """提取包名与时间戳，保留原 Process/Cmdline 两种遍历语义。"""
        field = self.type_config["name_field"]
        name = ""
        timestamp = None
        for item in detail:
            if f"{field}:" in item:
                name = item.split(f"{field}:")[1].strip()
                if field == "Cmdline":
                    name = name.replace("/", "%")
                    break
            if "Timestamp:" in item:
                match = _TS_RE.search(item)
                if match:
                    timestamp = match.group(1)
                if field == "Process":
                    break
        if timestamp is None:
            timestamp = entry_time
        return name, timestamp

    def _build_filename(self, package, timestamp):
        tag = self.type_config.get("filename_tag") or self.type_name.replace("_", "-")
        ts = timestamp.replace(" ", "-").replace(":", "")
        return os.path.join(self.folderpath, f"{self.device}_{package}_{tag}_{ts}.txt")

    def _is_duplicate(self, filename, field):
        try:
            if os.path.getsize(filename) > 0:
                with open(filename, "r") as context:
                    content = context.read()
                    return f"{field}:" in content and "Build:" in content
        except OSError:
            pass
        return False

    def _resolve_package_dir(self, ts_safe):
        """问题包目录：同秒已有包（uniview 先建的）则复用，否则新建。

        以 uniview 为准：同秒时间戳即同一事件，dropbox 条目补充进已有包。
        问题包：{folderpath}/{device}/{type}_{ts}/
        """
        problems_root = os.path.dirname(self.folderpath)
        if os.path.isdir(problems_root):
            for name in os.listdir(problems_root):
                if name.endswith(f"_{ts_safe}"):
                    return os.path.join(problems_root, name)
        return os.path.join(
            problems_root,
            f"{self.type_name.replace('_', '-')}_{ts_safe}")

    def _ylog_dir(self):
        """设备 ylog 目录：{version}/{device}/ylog/（设备目录下，同版本多设备不混）。"""
        return os.path.join(os.path.dirname(self.folderpath), "ylog")

    def _export_ap_segment(self, seg, package_dir):
        """导出 ap 分段到共享 {version}/ylog/（已存在则跳过）。"""
        return export_ap_segment(self.adb, self.device, seg, self._ylog_dir(), package_dir)

    def write_problem(self, entry_line):
        """单个 dropbox 条目：拉详情、按问题包组织落盘（detail）。

        问题包：{folderpath}/{device}/{type}_{ts}/
        同秒已有包（uniview 事件实体）时补充进包，不新建。
        取舍规则：无 ylog ap 分段覆盖的报错舍弃（无上下文无意义）。
        返回条目信息 dict（供报错汇总用），失败/重复/忽略/舍弃返回 None。
        """
        entry_time = entry_line.split(" ")[0] + " " + entry_line.split(" ")[1]
        detail = self.adb.get_dropbox_detail(self.device, self.type_name, entry_time)
        package, timestamp = self._extract_name_timestamp(detail, entry_time)

        ignore_packages = self.type_config.get("ignore_packages", [])
        if package in ignore_packages:
            TEST_LOGGER.info(f"忽略包 {package}（{self.type_name}）")
            return None

        ts_safe = (timestamp or entry_time).replace(" ", "-").replace(":", "")
        package_dir = self._resolve_package_dir(ts_safe)
        detail_file = os.path.join(package_dir, "detail.txt")
        field = self.type_config["name_field"]
        if self._is_duplicate(detail_file, field):
            print("已存在" + detail_file)
            return None

        # 上下文判定：同秒 uniview 实体（聚合包）或 ylog ap 分段覆盖，否则舍弃
        ap_seg = None
        if not os.path.isdir(package_dir):
            ap_seg = find_ap_window(self.adb, self.device, timestamp or entry_time)
            if ap_seg is None:
                TEST_LOGGER.info(
                    f"舍弃 {self.type_name} {timestamp or entry_time}：无 ylog 分段覆盖")
                return None

        os.makedirs(package_dir, exist_ok=True)
        self._write_file(detail_file, detail, "w")
        if ap_seg:
            self._export_ap_segment(ap_seg, package_dir)
        return {
            "type_name": self.type_name,
            "ts": timestamp or entry_time,
            "package": package,
            "detail": detail,
            "detail_file": detail_file,
            "package_dir": package_dir,
        }

    def _write_file(self, filename, content, mode):
        try:
            with open(filename, mode, encoding="utf-8") as f:
                if isinstance(content, list):
                    for line in content:
                        f.write(str(line) + "\n")
                else:
                    f.write(str(content) + "\n")
            TEST_LOGGER.info(f"写入: {filename}")
        except Exception as e:
            TEST_LOGGER.info(f"写入失败: {filename}\n错误: {e}")

    def analyse(self, count, end):
        """分析 dropbox 条目区间 [count, end)；返回条目信息列表。"""
        entries = self.adb.get_dropbox_entries(self.device, self.type_name)
        if len(entries) < end:
            end = len(entries)
        infos = []
        for i in range(count, end):
            info = self.write_problem(entries[i])
            if info:
                infos.append(info)
        return infos
