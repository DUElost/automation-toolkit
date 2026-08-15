import argparse
import json
import os
import time
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime

from modules.common.adb_client import AdbClient
from modules.common.logger import TEST_LOGGER
from modules.analyse.dropbox_monitor import DropboxMonitor
from modules.analyse.platform_sources import PlatformSources, detect_platform

PROJECT_ROOT = os.path.dirname(os.path.abspath(__file__))
CONFIG_PATH = os.path.join(PROJECT_ROOT, "config.json")


def load_config():
    with open(CONFIG_PATH, encoding="utf-8") as f:
        return json.load(f)


class ScanLogGT:
    def __init__(self, config, output_root, platform=None):
        self.config = config
        self.output_root = output_root
        self.platform = platform
        self.adb = AdbClient()
        self.types = config["dropbox"]["types"]
        self.poll_interval = config["general"]["polling_interval_seconds"]

    # ---- 输出目录（仅建设备目录；问题包/ylog 在设备目录下按需创建）----
    def _prepare_output_dir(self, device):
        version = self.adb.getprop(device, "ro.build.display.id")
        base = os.path.join(self.output_root, version) if version else self.output_root
        os.makedirs(os.path.join(base, device), exist_ok=True)
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

    def collect_device_rom_ram(self, device, folderpath):
        """采集设备 ROM/RAM 落盘 {version}/{device}/rom_ram.json（SN 对应）。

        启动（首次扫描）时执行一次：单台设备 Rom/Ram 不变，后续轮次复用。
        RAM：getprop ro.boot.ddrsize（如 4096M -> 4GB SKU）；
        ROM：/sys/block/mmcblk0/size（块数*512 字节 -> SKU）。
        幂等：已存在且非空则跳过；解析失败保持已有值。
        """
        target = os.path.join(folderpath, device, "rom_ram.json")
        info = {"rom": 0, "ram": 0}
        try:
            if os.path.isfile(target):
                with open(target, encoding="utf-8") as f:
                    info = json.load(f)
        except (OSError, ValueError):
            info = {"rom": 0, "ram": 0}
        changed = False
        if not info.get("ram"):
            ddr = self.adb.getprop(device, "ro.boot.ddrsize")
            gb = self._parse_gb(ddr)
            if gb:
                info["ram"] = self._sku(gb, (2, 3, 4, 6, 8, 12, 16, 24, 32))
                changed = True
        if not info.get("rom"):
            blocks = self.adb.run_command(
                f"adb -s {device} shell cat /sys/block/mmcblk0/size")
            if blocks and blocks[0].strip().isdigit():
                bytes_gb = int(blocks[0].strip()) * 512 / 1024.0 ** 3
                info["rom"] = self._sku(bytes_gb, (32, 64, 128, 256, 512, 1024))
                changed = True
        if changed:
            os.makedirs(os.path.dirname(target), exist_ok=True)
            with open(target, "w", encoding="utf-8") as f:
                json.dump(info, f, indent=2)
            TEST_LOGGER.info(f"设备 Rom_Ram: {info} -> {target}")
        return info

    @staticmethod
    def _parse_gb(value):
        import re
        m = re.match(r"(\d+(?:\.\d+)?)\s*(G|GB|M|MB)?", (value or "").strip(), re.I)
        if not m:
            return 0.0
        val = float(m.group(1))
        unit = (m.group(2) or "G").upper()
        return val / 1024.0 if unit.startswith("M") else val

    @staticmethod
    def _sku(gb, table):
        for sku in table:
            if gb <= sku:
                return sku
        return table[-1]

    def run_scan(self, device, folderpath):
        state_file = self._state_file(folderpath, device)
        is_first_scan = not os.path.exists(state_file)
        # Rom_Ram 启动时采集一次（单设备不变，后续轮次复用；仅文件缺失时执行 adb）
        if not os.path.exists(os.path.join(folderpath, device, "rom_ram.json")):
            self.collect_device_rom_ram(device, folderpath)
        old_counts = self._load_state(state_file)
        new_counts = self.get_problem_counts(device)
        self._save_state(state_file, new_counts)
        new_types = [t for t in self.types if new_counts.get(t, 0) > old_counts.get(t, 0)]
        # 平台源（uniview）先扫：以 uniview 事件为实体先建包，dropbox 条目随后补充
        new_platform_sources = self._scan_platform_sources(device, folderpath)
        success_infos = []
        for type_name, type_config in self.types.items():
            old_count = old_counts.get(type_name, 0)
            new_count = new_counts.get(type_name, 0)
            if new_count == 0 or new_count <= old_count:
                continue
            monitor = DropboxMonitor(device, folderpath, type_name, type_config)
            infos = monitor.analyse(old_count, new_count)
            for info in infos:
                self._build_problem_summary(device, folderpath, info)
                success_infos.append(info)
        # 冷启动（首次部署）只拉存量不触发场景动作，避免误报
        if not is_first_scan:
            self._handle_events(device, folderpath, new_types, new_platform_sources,
                                success_infos)

    def _build_problem_summary(self, device, folderpath, info):
        """为单个报错生成汇总 txt（基础信息 + 堆栈 + 关键信息），落问题包内。"""
        try:
            from modules.analyse.summary_builder import build_summary

            scenes = self._map_scenes([info["type_name"]])
            out_dir = info["package_dir"]
            extra = {"dropbox_detail": info["detail"]}
            path = build_summary(
                device=device,
                type_name=info["type_name"],
                ts=info["ts"],
                package=info["package"],
                scenes=scenes,
                detail_lines=info["detail"],
                extra_sources=extra,
                out_dir=out_dir,
            )
            TEST_LOGGER.info(f"报错汇总: {path}")
        except Exception as e:
            TEST_LOGGER.error(f"报错汇总失败 {device}: {e}")

    def _scan_platform_sources(self, device, folderpath):
        """平台额外日志源（SPRD: /data/anr、/data/tombstones、/data/ylog）。返回新增源名列表。"""
        if self.platform is None or self.platform == "none":
            return []
        if self.platform == "auto":
            platform = detect_platform(self.adb, device)
            if platform is None:
                return []
        else:
            platform = self.platform
        try:
            sources = PlatformSources(device, folderpath, platform, self.config, adb=self.adb)
            n, event_sources = sources.scan()
            if n:
                TEST_LOGGER.info(f"平台源 {platform} 新增 {n} 个文件")
            return event_sources
        except Exception as e:
            TEST_LOGGER.error(f"平台源扫描异常 {device}: {e}")
            return []

    def _map_scenes(self, signals):
        """信号（dropbox 类型名 / 平台源名）-> 官方场景列表。"""
        scene_map = (self.config.get("events") or {}).get("scene_map", {})
        scenes = []
        for signal in signals:
            for scene, keywords in scene_map.items():
                if any(kw in signal for kw in keywords) and scene not in scenes:
                    scenes.append(scene)
        return scenes

    def _handle_events(self, device, folderpath, new_dropbox_types, new_platform_sources,
                       success_infos=None):
        """事件驱动按需采集：场景命中 -> bugreport（冷却）+ meminfo 快照。"""
        signals = list(new_dropbox_types) + list(new_platform_sources)
        if not signals:
            return
        scenes = self._map_scenes(signals)
        if not scenes:
            return
        TEST_LOGGER.info(f"事件检测 {device}: 信号={signals} 场景={scenes}")
        events_cfg = self.config.get("events") or {}
        if self.platform in (None, "none"):
            return
        if self.platform == "auto":
            platform = detect_platform(self.adb, device)
        else:
            platform = self.platform
        if platform is None:
            return
        try:
            sources = PlatformSources(device, folderpath, platform, self.config, adb=self.adb)
            # bugreport/ap 关联导出耗时长，后台线程执行，不阻塞扫描轮次
            import threading
            t = threading.Thread(
                target=self._event_snapshot_thread,
                args=(device, folderpath, signals, sources, events_cfg,
                      success_infos or []),
                daemon=True,
            )
            t.start()
        except Exception as e:
            TEST_LOGGER.error(f"事件处理异常 {device}: {e}")

    def _latest_package_dir(self, device, folderpath):
        """设备目录下最新问题包（事件快照无关联 dropbox 条目时兜底落点）。"""
        device_dir = os.path.join(folderpath, device)
        try:
            entries = [d for d in os.listdir(device_dir)
                       if os.path.isdir(os.path.join(device_dir, d)) and d != "ylog"]
            entries.sort(key=lambda d: os.path.getmtime(os.path.join(device_dir, d)),
                         reverse=True)
            return entries[0] if entries else None
        except OSError:
            return None

    def _resolve_snapshot_target(self, device, folderpath, signals, success_infos):
        """快照落点：只返回已成功建包目录名，绝不按 dropbox 列表时间新建空壳。

        返回 (prefix, entry_ts)；无可写包时 (None, None)。
        - 本轮 dropbox 成功建包：落最新一条成功包（package_dir  basename）
        - 仅平台源触发：落已存在的最新问题包
        - dropbox 有增量但本轮均未建包：跳过（避免空壳 / 误挂旧包）
        """
        success_infos = success_infos or []
        dropbox_signals = [s for s in signals if s in self.types]
        if success_infos:
            info = success_infos[-1]
            prefix = os.path.basename(info["package_dir"])
            return prefix, info.get("ts")
        if not dropbox_signals:
            latest = self._latest_package_dir(device, folderpath)
            return (latest, None) if latest else (None, None)
        return None, None

    def _event_snapshot_thread(self, device, folderpath, signals, sources, events_cfg,
                               success_infos=None):
        """后台执行事件快照：bugreport + meminfo + ap 时间窗（仅写入已建问题包）。"""
        prefix, entry_ts = self._resolve_snapshot_target(
            device, folderpath, signals, success_infos or [])
        if not prefix:
            TEST_LOGGER.info(f"事件快照跳过 {device}: 无已建问题包可写入")
            return
        try:
            dest = sources.snapshot_bugreport(prefix)
            if dest:
                TEST_LOGGER.info(f"事件 bugreport: {dest}")
        except Exception as e:
            TEST_LOGGER.error(f"事件 bugreport 失败: {e}")
        if events_cfg.get("meminfo_snapshot", True):
            try:
                mem = sources.snapshot_meminfo(prefix)
                if mem:
                    TEST_LOGGER.info(f"事件 meminfo: {mem}")
            except Exception as e:
                TEST_LOGGER.error(f"事件 meminfo 失败: {e}")
        if entry_ts:
            try:
                pulled = sources.export_correlated_ap(entry_ts, prefix)
                if pulled:
                    TEST_LOGGER.info(f"事件 ap 关联段: {len(pulled)} 个")
            except Exception as e:
                TEST_LOGGER.error(f"事件 ap 关联失败: {e}")

    # ---- 单设备主循环（纯采集；monkey 由外部独立触发，见 README）----
    # 对齐 MTK MonkeyAEEinfo：补齐式轮询（180s - 扫描耗时）、连续失败 5 次等 60s、异常等 30s
    def monitor_device(self, device):
        TEST_LOGGER.info(device)
        folderpath = self._prepare_output_dir(device)
        self.run_scan(device, folderpath)
        time.sleep(self.poll_interval)
        max_failures = self.config["general"].get("max_consecutive_failures", 5)
        failure_wait = self.config["general"].get("failure_wait_seconds", 60)
        exception_wait = self.config["general"].get("exception_wait_seconds", 30)
        consecutive_failures = 0
        while True:
            loop_start = time.time()
            try:
                TEST_LOGGER.info(datetime.now().strftime("%Y-%m-%d %H:%M:%S") + " 开始扫描log_" + device)
                if not self.adb.is_device_online(device):
                    TEST_LOGGER.warn(f"设备离线 {device}，等待下一轮")
                    time.sleep(self.poll_interval)
                    continue
                self.run_scan(device, folderpath)
                consecutive_failures = 0
            except Exception as e:
                TEST_LOGGER.error(f"扫描异常 {device}: {e}")
                consecutive_failures += 1
                if consecutive_failures >= max_failures:
                    TEST_LOGGER.warn(f"连续失败 {consecutive_failures} 次，等待 {failure_wait}s 恢复")
                    time.sleep(failure_wait)
                    consecutive_failures = 0
                    continue
                time.sleep(exception_wait)
                continue
            # 补齐到轮询间隔（避免频繁轮询影响稳定性）
            loop_duration = time.time() - loop_start
            sleep_time = self.poll_interval - loop_duration
            if sleep_time > 0:
                time.sleep(sleep_time)


def main():
    parser = argparse.ArgumentParser(description="高通/展锐平台稳定性日志扫描工具（纯采集；monkey 独立触发）")
    parser.add_argument("-p", "--path", required=True, help="保存目录（必填）")
    parser.add_argument("-i", "--interval", type=int, default=None, help="轮询间隔秒数（默认取 config.json）")
    parser.add_argument("-m", "--platform", default="auto", choices=["auto", "sprd", "qcom", "mtk", "none"],
                        help="平台（auto 自动探测；none 关闭额外源）")
    args = parser.parse_args()

    config = load_config()
    if args.interval:
        config["general"]["polling_interval_seconds"] = args.interval

    scan_log = ScanLogGT(config, args.path, platform=args.platform)
    devices = scan_log.adb.get_devices()
    if not devices:
        print("未检测到 adb 设备")
        return
    # 限制并行采集数，避免多设备同时扫描负载过高（对齐 MTK max_workers<=4）
    max_workers = min(config["general"].get("max_thread_pool_workers", 4), len(devices))
    with ThreadPoolExecutor(max_workers=max_workers) as executor:
        for device in devices:
            executor.submit(scan_log.monitor_device, device)


if __name__ == '__main__':
    main()
