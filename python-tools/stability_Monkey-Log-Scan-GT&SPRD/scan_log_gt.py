import argparse
import json
import os
import time
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime

from modules.common.adb_client import AdbClient
from modules.common.logger import TEST_LOGGER
from modules.analyse.dropbox_monitor import DropboxMonitor
from modules.monkey.monkey_test import MonkeyTest

PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
CONFIG_PATH = os.path.join(PROJECT_ROOT, "config.json")

OUTPUT_SUBDIRS = ["data_anr", "data_crash", "block", "sys_anr",
                  "sys_crash", "sys_native_crash", "data_native_crash"]


def load_config():
    with open(CONFIG_PATH, encoding="utf-8") as f:
        return json.load(f)


class ScanLogGT:
    def __init__(self, config, output_root, skip_monkey=False):
        self.config = config
        self.output_root = output_root
        self.skip_monkey = skip_monkey
        self.adb = AdbClient()
        self.types = config["dropbox"]["types"]
        self.poll_interval = config["general"]["polling_interval_seconds"]

    # ---- 输出目录 ----
    def _prepare_output_dir(self, device):
        version = self.adb.getprop(device, "ro.build.display.id")
        base = os.path.join(self.output_root, version) if version else self.output_root
        for sub in OUTPUT_SUBDIRS:
            os.makedirs(os.path.join(base, device, sub), exist_ok=True)
        return base

    # ---- 状态持久化（json，替代原 eval 文本）----
    def _state_file(self, folderpath, device):
        return os.path.join(folderpath, f"{self.config['general']['state_prefix']}_{device}.json")

    def _load_state(self, state_file):
        default = {t: 0 for t in self.types}
        try:
            with open(state_file, encoding="utf-8") as f:
                data = json.load(f)
            return {t: data.get(t, 0) for t in self.types}
        except (FileNotFoundError, ValueError):
            return default

    def _save_state(self, state_file, counts):
        with open(state_file, "w", encoding="utf-8") as f:
            json.dump(counts, f, indent=2)

    # ---- 扫描 ----
    def get_problem_counts(self, device):
        return {t: len(self.adb.get_dropbox_entries(device, t)) for t in self.types}

    def run_scan(self, device, folderpath):
        state_file = self._state_file(folderpath, device)
        old_counts = self._load_state(state_file)
        new_counts = self.get_problem_counts(device)
        self._save_state(state_file, new_counts)
        for type_name, type_config in self.types.items():
            old_count = old_counts.get(type_name, 0)
            new_count = new_counts.get(type_name, 0)
            if new_count == 0 or new_count <= old_count:
                continue
            monitor = DropboxMonitor(device, folderpath, type_name, type_config)
            monitor.analyse(old_count, new_count)

    # ---- monkey 保活 ----
    def check_monkey(self, device):
        if self.skip_monkey:
            return
        monkey = MonkeyTest(self.config)
        try:
            pid = self.adb.run_command(
                f"adb -s {device} shell 'sh /data/local/tmp/log_manager.sh status'")
            if pid and "守护脚本正在运行" in pid[0]:
                TEST_LOGGER.info(device + "守护脚本正在运行")
            else:
                self.adb.run_command(
                    f"adb -s {device} shell 'nohup sh /data/local/tmp/log_manager.sh start > /dev/null 2>&1 &'")
        except Exception:
            pass
        try:
            pid = self.adb.run_command(f"adb -s {device} shell 'ps | grep monkey'")
        except Exception:
            pid = []
        if not pid:
            monkey.start_test(device)

    # ---- 单设备主循环 ----
    def monitor_device(self, device):
        TEST_LOGGER.info(device)
        folderpath = self._prepare_output_dir(device)
        self.check_monkey(device)
        self.run_scan(device, folderpath)
        time.sleep(60)
        self.check_monkey(device)
        while True:
            try:
                TEST_LOGGER.info(datetime.now().strftime("%Y-%m-%d %H:%M:%S") + " 开始扫描log_" + device)
                if not self.adb.is_device_online(device):
                    time.sleep(2 * 60)
                    continue
                self.run_scan(device, folderpath)
                time.sleep(self.poll_interval)
                self.check_monkey(device)
            except Exception as e:
                TEST_LOGGER.error(f"扫描异常 {device}: {e}")
                time.sleep(self.poll_interval)


def main():
    parser = argparse.ArgumentParser(description="高通/展锐平台稳定性日志扫描工具")
    parser.add_argument("-p", "--path", required=True, help="保存目录（必填）")
    parser.add_argument("-i", "--interval", type=int, default=None, help="轮询间隔秒数（默认取 config.json）")
    parser.add_argument("-s", "--skip-monkey", action="store_true", help="跳过 monkey 检查/启动")
    args = parser.parse_args()

    config = load_config()
    if args.interval:
        config["general"]["polling_interval_seconds"] = args.interval

    scan_log = ScanLogGT(config, args.path, skip_monkey=args.skip_monkey)
    devices = scan_log.adb.get_devices()
    if not devices:
        print("未检测到 adb 设备")
        return
    with ThreadPoolExecutor(max_workers=len(devices)) as executor:
        for device in devices:
            executor.submit(scan_log.monitor_device, device)


if __name__ == '__main__':
    main()
