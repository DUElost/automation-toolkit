# -*- coding: utf-8 -*-
"""dropbox 问题分析器：由 config.json 的 dropbox.types 配置驱动，
合并原 problem/{block,data,sys} 下 14 个同模板类。"""

import os
import re
from datetime import datetime, timedelta

from modules.common.adb_client import AdbClient
from modules.common.logger import TEST_LOGGER

_TS_RE = re.compile(r"Timestamp:\s*(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})")


def second_reduce_one(timestamp_str):
    """时间戳减 1 秒；格式非法时返回原值。"""
    try:
        dt = datetime.strptime(timestamp_str, "%Y-%m-%d %H:%M:%S")
        return (dt - timedelta(seconds=1)).strftime("%Y-%m-%d %H:%M:%S")
    except ValueError:
        return timestamp_str


class DropboxMonitor:
    def __init__(self, device, folderpath, type_name, type_config):
        self.device = device
        self.folderpath = os.path.join(folderpath, device, type_config["folder"])
        self.type_name = type_name
        self.type_config = type_config
        self.adb = AdbClient()

    def different_time(self, logcat_text, timestamp):
        """logcat 首行时间与目标时间差超过 60s 视为无效，返回 False。"""
        try:
            text = logcat_text.split("\n") if isinstance(logcat_text, str) else logcat_text
            time2 = text[2].split(" ")[0] + " " + (text[2].split(" ")[1]).split(".")[0]
            time_format = "%m-%d %H:%M:%S"
            time1 = timestamp.split("-")[1] + "-" + timestamp.split("-")[2]
            dt1 = datetime.strptime(time1, time_format)
            dt2 = datetime.strptime(time2, time_format)
            if dt1 < dt2 and (dt2 - dt1).total_seconds() > 60:
                return False
            return True
        except Exception:
            return False

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

    def write_problem(self, entry_line):
        """单个 dropbox 条目：拉详情、写文件、追加 logcat。"""
        entry_time = entry_line.split(" ")[0] + " " + entry_line.split(" ")[1]
        detail = self.adb.get_dropbox_detail(self.device, self.type_name, entry_time)
        package, timestamp = self._extract_name_timestamp(detail, entry_time)

        ignore_packages = self.type_config.get("ignore_packages", [])
        if package in ignore_packages:
            TEST_LOGGER.info(f"忽略包 {package}（{self.type_name}）")
            return

        filename = self._build_filename(package, timestamp)
        field = self.type_config["name_field"]
        if self._is_duplicate(filename, field):
            print("已存在" + filename)
            return

        os.makedirs(self.folderpath, exist_ok=True)
        self._write_file(filename, detail, "w")
        logcat_ts = second_reduce_one(timestamp)
        for buffer in ("main", "system", "events"):
            logcat = self.adb.get_logcat_before(self.device, buffer, logcat_ts, 1000)
            self._write_file(filename, f"logcat -t 1000 -v threadtime -b {buffer}", "a")
            if self.different_time(logcat, logcat_ts):
                self._write_file(filename, logcat, "a")

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
        """分析 dropbox 条目区间 [count, end)。"""
        entries = self.adb.get_dropbox_entries(self.device, self.type_name)
        if len(entries) < end:
            end = len(entries)
        for i in range(count, end):
            self.write_problem(entries[i])
