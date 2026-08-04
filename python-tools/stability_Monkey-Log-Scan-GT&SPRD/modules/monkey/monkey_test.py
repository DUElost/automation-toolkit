# -*- coding: utf-8 -*-
"""AIMonkey 部署与启动（原 problem/monkey/AIMonkeyTest.py 重构）。

资源目录 tools/monkey；删除 play_video/memory_rw/offline-monkey 分支
（对应资源文件不存在，原代码不可达）；aimonkey.apk push 行删除。
"""

import os
import subprocess
import sys
import time

from modules.common.exec_cmd import exec_cmd
from modules.common.logger import TEST_LOGGER

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))


class MonkeyTest:
    def __init__(self, config):
        self.config = config
        self.resource_dir = self._resource_dir()

    def _resource_dir(self):
        if getattr(sys, 'frozen', False):
            base = os.path.dirname(os.path.realpath(sys.executable))
        else:
            base = PROJECT_ROOT
        return os.path.join(base, self.config["monkey"]["resource_dir"])

    def _res(self, name):
        return os.path.join(self.resource_dir, name)

    def start_test(self, device):
        self._install_apks(device)
        self._push_resources(device)
        self._launch_monkey(device)

    def _install_apks(self, device):
        m = self.config["monkey"]
        for package in (m["test_package"], m["test_package_test"]):
            cmdline = ["adb", "-s", device, "uninstall", package]
            TEST_LOGGER.info(f"执行命令：{cmdline}")
            exec_cmd(cmdline, timeout=5 * 60)
        time.sleep(1)
        for apk_key in ("apk", "android_test_apk"):
            cmdline = ["adb", "-s", device, "install", "-r", "-g", "-t", self._res(m[apk_key])]
            TEST_LOGGER.info(f"执行命令：{cmdline}")
            rlt = exec_cmd(cmdline, timeout=5 * 60)
            for line in rlt:
                TEST_LOGGER.info(line.decode().strip())

    def _push_resources(self, device):
        m = self.config["monkey"]
        exec_cmd(["adb", "-s", device, "push", self._res(m["blacklist"]), m["device_blacklist_path"]],
                 timeout=30)
        for lib_dir in m["native_libs"]:
            subprocess.run(["adb", "-s", device, "push", self._res(lib_dir), m["device_tmp_dir"]])
        for name in ("aim_jar", "aim", "aimwd"):
            subprocess.run(["adb", "-s", device, "push", self._res(m[name]), m["device_tmp_dir"]])
        subprocess.run(["adb", "-s", device, "shell", "chmod", "777", m["device_tmp_dir"] + "/aim"])
        subprocess.run(["adb", "-s", device, "shell", "chmod", "777", m["device_tmp_dir"] + "/aimwd"])
        subprocess.run(["adb", "-s", device, "shell", "mkdir", "/sdcard/systeminfo"])
        exec_cmd(["adb", "-s", device, "push", self._res(m["monkey_script"]),
                  m["device_tmp_dir"] + "/MonkeyTest.sh"], timeout=30)

    def _launch_monkey(self, device):
        m = self.config["monkey"]
        cmdline = ["adb", "-s", device, "shell",
                   f"nohup sh {m['device_tmp_dir']}/MonkeyTest.sh >/dev/null 2>&1 &"]
        TEST_LOGGER.info(f"执行命令：{cmdline}")
        exec_cmd(cmdline, timeout=60)
        cmdline = ["adb", "-s", device, "shell",
                   f"nohup {m['device_tmp_dir']}/aimwd >/dev/null 2>&1 &"]
        TEST_LOGGER.info(f"执行命令：{cmdline}")
        exec_cmd(cmdline, timeout=30)
        TEST_LOGGER.info("Monkey test is triggered on Device:" + device)


if __name__ == '__main__':
    import argparse
    import json

    parser = argparse.ArgumentParser(description="AIMonkey 独立部署工具")
    parser.add_argument("-d", "--device", help="目标设备序列号；缺省时全部在线设备")
    args = parser.parse_args()
    with open(os.path.join(PROJECT_ROOT, "config.json"), encoding="utf-8") as f:
        cfg = json.load(f)
    monkey = MonkeyTest(cfg)
    if args.device:
        monkey.start_test(args.device)
    else:
        from modules.common.adb_client import AdbClient
        for device in AdbClient().get_devices():
            monkey.start_test(device)
