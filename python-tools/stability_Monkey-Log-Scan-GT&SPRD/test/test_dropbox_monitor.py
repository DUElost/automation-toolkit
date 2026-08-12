# -*- coding: utf-8 -*-
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.dropbox_monitor import DropboxMonitor, _interpret_seg_time, find_ap_window
from datetime import datetime


class FakeAdb:
    def __init__(self, ap_segments=None):
        self.detail = ["Process: com.foo", "Build: x", "Timestamp: 2025-06-12 09:04:02"]
        self.ap_segments = ap_segments or []

    def get_dropbox_detail(self, device, type_name, entry_time):
        return list(self.detail)

    def run_command(self, cmd):
        if "ls /data/ylog/ap/" in cmd:
            return list(self.ap_segments)
        return []

    def _run_argv(self, argv, timeout=None):
        import pathlib
        p = pathlib.Path(argv[-1])
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text("ylog data")
        return []


def test_write_problem_creates_file(tmp_path):
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    monitor.adb = FakeAdb(ap_segments=["001-0604_090000--0613_000000.ylog"])
    fake = monitor.adb
    fake.detail = ["Process: com.foo", "Build: x", "Timestamp: 2026-06-12 09:04:02"]
    monitor.write_problem("2026-06-12 09:04:01 data_app_anr")
    package_dir = os.path.join(str(tmp_path), "sn1",
                               "data-app-anr_2026-06-12-090402")
    files = os.listdir(package_dir)
    assert "detail.txt" in files
    with open(os.path.join(package_dir, "detail.txt"), encoding="utf-8") as f:
        content = f.read()
    assert "Process: com.foo" in content


def test_write_problem_duplicate_skipped(tmp_path):
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    fake = FakeAdb(ap_segments=["001-0604_090000--0613_000000.ylog"])
    fake.detail = ["Process: com.foo", "Build: x", "Timestamp: 2026-06-12 09:04:02"]
    monitor.adb = fake
    monitor.write_problem("2026-06-12 09:04:01 data_app_anr")
    monitor.write_problem("2026-06-12 09:04:01 data_app_anr")
    package_dir = os.path.join(str(tmp_path), "sn1",
                               "data-app-anr_2026-06-12-090402")
    assert os.path.isdir(package_dir)
    assert os.path.isfile(os.path.join(package_dir, "detail.txt"))


def test_write_problem_ylog_fallback(tmp_path):
    """ylog ap 分段覆盖事件时间 -> 建包并导出到共享 {version}/ylog/，包内写引用。"""
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    fake = FakeAdb(ap_segments=["001-0604_090000--0613_000000.ylog"])
    fake.detail = ["Process: com.foo", "Build: x", "Timestamp: 2026-06-12 09:04:02"]
    monitor.adb = fake
    info = monitor.write_problem("2026-06-12 09:04:01 data_app_anr")
    assert info is not None
    seg = os.path.join(str(tmp_path), "sn1", "ylog", "001-0604_090000--0613_000000.ylog")
    assert os.path.isfile(seg)
    package_dir = os.path.join(str(tmp_path), "sn1",
                               "data-app-anr_2026-06-12-090402")
    with open(os.path.join(package_dir, "ylog.txt"), encoding="utf-8") as f:
        ref = f.read()
    assert "001-0604_090000--0613_000000.ylog" in ref


def test_write_problem_ylog_dedup(tmp_path):
    """同段多次命中：共享 ylog/ 已存在则不再 pull（避免重复导出）。"""
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    fake = FakeAdb(ap_segments=["001-0604_090000--0613_000000.ylog"])
    fake.detail = ["Process: com.foo", "Build: x", "Timestamp: 2026-06-12 09:04:02"]
    fake.pull_count = 0
    real_run = fake._run_argv

    def counting_run(argv, timeout=None):
        if "pull" in argv:
            fake.pull_count += 1
        return real_run(argv, timeout=timeout)

    fake._run_argv = counting_run
    monitor.adb = fake
    monitor.write_problem("2026-06-12 09:04:01 data_app_anr")
    monitor2 = DropboxMonitor("sn1", str(tmp_path), "data_app_crash",
                              {"folder": "data_crash", "name_field": "Process"})
    fake.detail = ["Process: com.foo2", "Build: x", "Timestamp: 2026-06-12 09:04:03"]
    monitor2.adb = fake
    monitor2.write_problem("2026-06-12 09:04:03 data_app_crash")
    assert fake.pull_count == 1


def test_find_ap_window_no_end_seg(tmp_path):
    """无 end 段（poweron/异常命名）：end 取下一段 start，活跃段覆盖至现在。"""
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    monitor.adb = FakeAdb(ap_segments=[
        "081-0703_160231.ylog",          # 无 end：07-03 16:02 ~ 082 start
        "082-0804_180232_poweron.ylog",  # 无 end：08-04 18:02 ~ 083 start
        "083-0804_220908--0805_031346_poweron.ylog",
        "084-0805_031346--0805_200720.ylog",
    ])
    assert find_ap_window(monitor.adb, "sn1", "2026-08-05 10:55:52") == "084-0805_031346--0805_200720.ylog"
    assert find_ap_window(monitor.adb, "sn1", "2026-08-04 20:53:20") == "082-0804_180232_poweron.ylog"
    assert find_ap_window(monitor.adb, "sn1", "2026-07-03 17:00:00") == "081-0703_160231.ylog"
    assert find_ap_window(monitor.adb, "sn1", "2026-07-02 10:00:00") is None


def test_write_problem_no_context_dropped(tmp_path):
    """无 ylog 分段覆盖 -> 舍弃（不建包）。"""
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    fake = FakeAdb(ap_segments=[])
    fake.detail = ["Process: com.foo", "Build: x", "Timestamp: 2026-06-12 09:04:02"]
    monitor.adb = fake
    info = monitor.write_problem("2026-06-12 09:04:01 data_app_anr")
    assert info is None
    package_dir = os.path.join(str(tmp_path), "sn1",
                               "data-app-anr_2026-06-12-090402")
    assert not os.path.isdir(package_dir)


def test_write_problem_ignored_package(tmp_path):
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_crash",
                             {"folder": "data_crash", "name_field": "Process",
                              "ignore_packages": ["reliabilityuiautomatortest"]})
    fake = FakeAdb()
    fake.detail = ["Process: reliabilityuiautomatortest", "Build: x",
                   "Timestamp: 2025-06-12 09:04:02"]
    monitor.adb = fake
    monitor.write_problem("2025-06-12 09:04:01 data_app_crash")
    assert not os.path.exists(os.path.join(str(tmp_path), "sn1", "data_crash"))


def test_build_filename_cmdline_tag(tmp_path):
    monitor = DropboxMonitor("sn1", str(tmp_path), "SYSTEM_TOMBSTONE",
                             {"folder": "sys_native_crash", "name_field": "Cmdline",
                              "filename_tag": "SIGSEGV"})
    name = monitor._build_filename("com.foo", "2025-06-12 09:04:02")
    assert os.path.basename(name) == "sn1_com.foo_SIGSEGV_2025-06-12-090402.txt"


def test_interpret_seg_time_cross_year():
    """分段 MMdd 无年份：跨年修正（now 可注入）。"""
    now = datetime(2026, 8, 7, 10, 0, 0)
    anchor = datetime(2026, 1, 10, 12, 0, 0)
    dt = _interpret_seg_time("1225", "110000", anchor, now=now)
    assert dt.year == 2025  # 2026-12-25 > now -> 前一年
    dt2 = _interpret_seg_time("0105", "080000", anchor, now=now)
    assert dt2.year == 2026
