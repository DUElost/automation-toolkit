# -*- coding: utf-8 -*-
"""adb 命令统一封装：超时控制、结果规范化为行列表。

注意：设备端命令（含管道）必须走列表参数形式（adb 将整个 shell 命令传到设备端执行），
Windows 下 shell=True 会把 ``|`` 在本地截获导致输出为空。
"""

import subprocess


class AdbClient:
    """封装原 Operate 中的全部 adb 命令。"""

    def __init__(self, command_timeout=30):
        self.command_timeout = command_timeout

    def _run_argv(self, argv, timeout=None):
        """列表参数执行，返回输出行列表；失败/超时返回空列表。"""
        try:
            result = subprocess.run(
                argv, capture_output=True, text=True,
                encoding="utf-8", errors="replace",
                timeout=timeout or self.command_timeout,
            )
            output = result.stdout.strip()
            return output.splitlines() if output else []
        except Exception:
            return []

    def run_command(self, command_str):
        """执行完整命令字符串（兼容旧调用）；含管道的设备端命令请用专门方法。"""
        try:
            result = subprocess.run(command_str, shell=True, capture_output=True,
                                    text=True, encoding="utf-8", errors="replace",
                                    timeout=self.command_timeout)
            output = result.stdout.strip()
            return output.splitlines() if output else []
        except Exception:
            return []

    def get_devices(self):
        lines = self._run_argv(["adb", "devices"])
        return [line.split("\t")[0] for line in lines[1:] if line.strip()]

    def is_device_online(self, device):
        return any(device in line for line in self._run_argv(["adb", "devices"]))

    def getprop(self, device, key):
        lines = self._run_argv(["adb", "-s", device, "shell", f"getprop {key}"])
        return lines[0] if lines else ""

    def get_dropbox_entries(self, device, dropbox_type):
        """查询 dropbox 条目列表；PROTO_WITH_HEADERS 行全局过滤。"""
        lines = self._run_argv(
            ["adb", "-s", device, "shell", f"dumpsys dropbox | grep {dropbox_type}"])
        return [item for item in lines if "PROTO_WITH_HEADERS" not in item]

    def get_dropbox_detail(self, device, dropbox_type, entry_time):
        return self._run_argv(
            ["adb", "-s", device, "shell",
             f"dumpsys dropbox --print {dropbox_type} '{entry_time}'"])
