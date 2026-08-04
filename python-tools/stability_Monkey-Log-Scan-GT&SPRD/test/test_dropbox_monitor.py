import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.dropbox_monitor import DropboxMonitor


class FakeAdb:
    def __init__(self):
        self.detail = ["Process: com.foo", "Build: x", "Timestamp: 2025-06-12 09:04:02"]
        self.logcat = ["06-12 09:04:02.123 100 200 I tag: msg"]

    def get_dropbox_detail(self, device, type_name, entry_time):
        return list(self.detail)

    def get_logcat_before(self, device, buffer, timestamp, count):
        return list(self.logcat)


def test_write_problem_creates_file(tmp_path):
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    monitor.adb = FakeAdb()
    monitor.write_problem("2025-06-12 09:04:01 data_app_anr")
    files = os.listdir(os.path.join(str(tmp_path), "sn1", "data_anr"))
    assert len(files) == 1
    assert files[0].startswith("sn1_com.foo_data-app-anr_2025-06-12-090402")
    with open(os.path.join(str(tmp_path), "sn1", "data_anr", files[0]), encoding="utf-8") as f:
        content = f.read()
    assert "Process: com.foo" in content
    assert "logcat -t 1000 -v threadtime -b main" in content


def test_write_problem_duplicate_skipped(tmp_path):
    monitor = DropboxMonitor("sn1", str(tmp_path), "data_app_anr",
                             {"folder": "data_anr", "name_field": "Process"})
    monitor.adb = FakeAdb()
    monitor.write_problem("2025-06-12 09:04:01 data_app_anr")
    monitor.write_problem("2025-06-12 09:04:01 data_app_anr")
    files = os.listdir(os.path.join(str(tmp_path), "sn1", "data_anr"))
    assert len(files) == 1


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
