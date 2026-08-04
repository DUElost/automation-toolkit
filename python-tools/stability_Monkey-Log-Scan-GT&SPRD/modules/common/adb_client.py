# -*- coding: utf-8 -*-
"""adb 命令统一封装：超时控制、结果规范化为行列表。"""

import subprocess


class AdbClient:
    """封装原 Operate 中的全部 adb 命令。"""

    def __init__(self, command_timeout=30):
        self.command_timeout = command_timeout

    def run_command(self, command_str):
        """执行 shell 命令，成功返回输出行列表，失败/超时返回空列表。"""
        try:
            result = subprocess.run(command_str, shell=True, capture_output=True,
                                    text=True, timeout=self.command_timeout)
            output = result.stdout.strip()
            return output.splitlines() if output else []
        except Exception:
            return []

    def get_devices(self):
        lines = self.run_command("adb devices")
        return [line.split("\t")[0] for line in lines[1:] if line.strip()]

    def is_device_online(self, device):
        return any(device in line for line in self.run_command("adb devices"))

    def getprop(self, device, key):
        lines = self.run_command(f"adb -s {device} shell getprop {key}")
        return lines[0] if lines else ""

    def get_dropbox_entries(self, device, dropbox_type):
        """查询 dropbox 条目列表；PROTO_WITH_HEADERS 行全局过滤。"""
        lines = self.run_command(f"adb -s {device} shell dumpsys dropbox | grep {dropbox_type}")
        return [item for item in lines if "PROTO_WITH_HEADERS" not in item]

    def get_dropbox_detail(self, device, dropbox_type, entry_time):
        return self.run_command(f"adb -s {device} shell dumpsys dropbox --print {dropbox_type} {entry_time}")

    def get_logcat_before(self, device, buffer, timestamp, count):
        return self.run_command(
            f'adb -s {device} logcat -T "{timestamp}.000" -v threadtime -b {buffer} -d | head -n {count}')
