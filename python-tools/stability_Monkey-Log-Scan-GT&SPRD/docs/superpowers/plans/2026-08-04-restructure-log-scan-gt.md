# stability_Log_scan_GT 结构重构实施计划

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 将 stability_Log_scan_GT 从 `problem/` 平铺包重构为 Offline-MonkeyTestTool 风格结构（config 驱动 + modules 分层 + tools 资源集中），修复已知 bug，为后续上传与迭代做好准备。

**Architecture:** 目录骨架对齐 stability_Offline-MonkeyTestTool：主入口 argparse CLI、config.json 分节配置（14 类 dropbox 问题表驱动通用 DropboxMonitor）、modules/common（adb 封装+日志）、modules/monkey（AIMonkey 部署）、tools/monkey（运行时资源）。删除 14 个同模板分析类、死代码（MonkeyTest.sh、time_convert.py、android_device.py、global_attrs.py、ifrun）。

**Tech Stack:** Python 3.9+、pytest、argparse、json、adb。

---

## 现状清单（重构输入）

| 文件 | 处置 |
|---|---|
| `scan_log_gt.py` | 重写为 argparse + 主循环 + 状态 json |
| `scan_log_gt.spec` | 保留 |
| `.gitignore` | 更新（tools/monkey 反选、output_*.json） |
| `problem/util/operate.py` | 拆分：adb 部分→`modules/common/adb_client.py`，其余并入 scan_log_gt.py |
| `problem/util/time_convert.py` | 删除（无引用） |
| `problem/{block,data,sys}/` 14 个模板类 | 合并为 `modules/analyse/dropbox_monitor.py`（配置驱动） |
| `problem/monkey/AIMonkeyTest.py` | 重构为 `modules/monkey/monkey_test.py` |
| `problem/monkey/modules/common/{logger,path,exec_cmd}.py` | 上移为 `modules/common/`，改 import |
| `problem/monkey/modules/common/{global_attrs,android_device}.py` | 删除（未实际使用） |
| `problem/monkey/MonkeyTest.sh` | 删除（MTK 遗留，GT 用 MonkeyTestAi.sh） |
| `problem/monkey/*` 资源（aim/aimwd/aim.jar/apk/so/blacklist/whitelist/MonkeyTestAi.sh） | 迁移到 `tools/monkey/` |
| `problem/monkey/stopAIMonkey.py` | 迁移到根目录 |
| 所有 `problem/*/__init__.py` | 随 problem 删除 |

**14 类问题差异表（config 化依据）：**

| dropbox type | folder | name_field | 特殊 |
|---|---|---|---|
| data_app_anr | data_anr | Process | |
| data_app_crash | data_crash | Process | ignore: reliabilityuiautomatortest |
| data_app_native_crash | data_native_crash | Process | |
| system_app_anr | sys_anr | Process | |
| system_app_crash | sys_crash | Process | |
| system_app_native_crash | sys_native_crash | Process | |
| system_server_crash | block | Process | |
| system_server_native_crash | block | Process | |
| system_server_watchdog | block | Process | |
| system_server_anr | sys_anr | Process | 原分支 key bug 修复后生效 |
| KERNEL_PANIC | block | Process | |
| MODEM_SILENT_PANIC | block | Process | 原 grep bug 修复 |
| SUBSYS_SILENT_PANIC | block | Process | |
| SYSTEM_TOMBSTONE | sys_native_crash | Cmdline | 文件名固定 SIGSEGV、`/`→`%`、过滤 PROTO_WITH_HEADERS |

**原模板类关键语义（重构必须保持一致）：**
1. 文件名：Process 类 `{device}_{package}_{type.replace("_","-")}_{ts}`；Cmdline 类 `{device}_{package}_SIGSEGV_{ts}`（ts=`YYYY-MM-DD-HHMMSS`，空格→`-`、`:`→空）
2. detail 解析：Process 类循环内先提取 Process（不 break），遇 Timestamp 提取并 break；Cmdline 类遇 Cmdline 提取并 break，遇 Timestamp 提取但不 break
3. 去重：文件已存在且非空，内容含 `{name_field}:` 与 `Build:` → 跳过
4. logcat 追加：main/system/events 各 1000 行，写分隔标记行 + `different_time`（距 timestamp±60s 内）校验
5. timestamp 回退：detail 无 Timestamp 时用 dropbox 条目时间；随后 second_reduce_one(-1s)
6. 增量扫描：状态文件记录每类计数，新计数>旧计数时分析 `[旧,新)` 区间条目

**已知 bug 修复清单：**
- B1: `get_MODEM_SILENT_PANIC` grep 写错为 `SUBSYS_SILENT_PANIC` → 修复
- B2: `run_problem` 分支 key `"system_server_anr"` 与 `"system_server_anr_lines"` 不匹配永不触发 → 修复
- B3: 状态文件 `eval()` → json
- B4: `version[0]` 无 getprop 输出时 IndexError → 防御
- B5: `second_reduce_one` 对非 `%Y-%m-%d %H:%M:%S` 输入抛 ValueError → 失败返回原值
- B6: `uninstall` 命令拼接资源路径（应为纯包名）→ 修复
- B7: `aimonkey.apk` push（资源缺失必然失败）→ 删除该行

---

## 目标结构

```
stability_Log_scan_GT/
├── scan_log_gt.py            # 主入口：argparse + 主监控循环
├── stopAIMonkey.py           # 独立停止脚本（原 problem/monkey/）
├── scan_log_gt.spec
├── config.json               # 分节配置
├── modules/
│   ├── __init__.py
│   ├── common/
│   │   ├── __init__.py
│   │   ├── adb_client.py     # 新：adb 封装（原 operate.py 拆分）
│   │   ├── logger.py         # 原 problem/monkey/modules/common/logger.py
│   │   ├── path.py           # 原文件上移
│   │   └── exec_cmd.py       # 原文件上移
│   ├── analyse/
│   │   ├── __init__.py
│   │   └── dropbox_monitor.py  # 新：14 类通用分析
│   └── monkey/
│       ├── __init__.py
│       └── monkey_test.py    # 原 AIMonkeyTest.py 重构
├── tools/monkey/             # 运行时资源（原 problem/monkey/）
│   ├── aim  aimwd  aim.jar
│   ├── app-debug.apk  app-debug-androidTest.apk
│   ├── arm64-v8a/libfastbot_native.so
│   ├── armeabi-v7a/libfastbot_native.so
│   ├── MonkeyTestAi.sh
│   ├── blacklist.txt  whitelist.txt
├── test/
│   ├── test_config.py
│   ├── test_time_utils.py
│   └── test_dropbox_monitor.py
├── logs/                     # 运行时生成
├── .gitignore
└── README.md
```

---

### Task 1: 目录骨架与文件迁移

**Files:** 创建 `modules/`、`modules/common/`、`modules/analyse/`、`modules/monkey/`、`tools/monkey/`、`test/` 目录；移动资源与公共文件

- [ ] **Step 1: 创建目录骨架**

```powershell
New-Item -ItemType Directory -Force modules/common, modules/analyse, modules/monkey, tools/monkey, test
```

- [ ] **Step 2: 迁移不改内容的文件（原样移动）**

```powershell
Move-Item problem/monkey/modules/common/logger.py modules/common/logger.py
Move-Item problem/monkey/modules/common/path.py modules/common/path.py
Move-Item problem/monkey/modules/common/exec_cmd.py modules/common/exec_cmd.py
Move-Item problem/monkey/modules/common/__init__.py modules/common/__init__.py
Move-Item problem/monkey/modules/__init__.py modules/__init__.py
Move-Item problem/monkey/stopAIMonkey.py stopAIMonkey.py
Move-Item problem/monkey/aim tools/monkey/aim
Move-Item problem/monkey/aimwd tools/monkey/aimwd
Move-Item problem/monkey/aim.jar tools/monkey/aim.jar
Move-Item problem/monkey/app-debug.apk tools/monkey/app-debug.apk
Move-Item problem/monkey/app-debug-androidTest.apk tools/monkey/app-debug-androidTest.apk
Move-Item problem/monkey/arm64-v8a tools/monkey/arm64-v8a
Move-Item problem/monkey/armeabi-v7a tools/monkey/armeabi-v7a
Move-Item problem/monkey/MonkeyTestAi.sh tools/monkey/MonkeyTestAi.sh
Move-Item problem/monkey/blacklist.txt tools/monkey/blacklist.txt
Move-Item problem/monkey/whitelist.txt tools/monkey/whitelist.txt
```

- [ ] **Step 3: 删除 problem/ 全部（含死文件与模板类）**

```powershell
Remove-Item -Recurse -Force problem
```

- [ ] **Step 4: 验证资源完整**

```powershell
Get-ChildItem tools/monkey -Recurse | Measure-Object
```
Expected: 10 个文件（aim、aimwd、aim.jar、app-debug.apk、app-debug-androidTest.apk、arm64-v8a/libfastbot_native.so、armeabi-v7a/libfastbot_native.so、MonkeyTestAi.sh、blacklist.txt、whitelist.txt）

---

### Task 2: modules/common/adb_client.py（新建）

**Files:** Create: `modules/common/adb_client.py`

- [ ] **Step 1: 写文件**

```python
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
        """查询 dropbox 条目列表；SYSTEM_TOMBSTONE 的 PROTO_WITH_HEADERS 行全局过滤。"""
        lines = self.run_command(f"adb -s {device} shell dumpsys dropbox | grep {dropbox_type}")
        return [item for item in lines if "PROTO_WITH_HEADERS" not in item]

    def get_dropbox_detail(self, device, dropbox_type, entry_time):
        return self.run_command(f"adb -s {device} shell dumpsys dropbox --print {dropbox_type} {entry_time}")

    def get_logcat_before(self, device, buffer, timestamp, count):
        return self.run_command(
            f'adb -s {device} logcat -T "{timestamp}.000" -v threadtime -b {buffer} -d | head -n {count}')
```

注：`get_dropbox_entries` 的 PROTO 过滤等价于原 `get_SYSTEM_TOMBSTONE` 的过滤（原实现仅对该方法过滤，但 PROTO_WITH_HEADERS 只会出现在 SYSTEM_TOMBSTONE 条目中，全局过滤行为等价）。

---

### Task 3: config.json（新建）

**Files:** Create: `config.json`

- [ ] **Step 1: 写文件**

```json
{
    "_comment": "stability_Log_scan_GT 配置文件",
    "general": {
        "polling_interval_seconds": 60,
        "state_prefix": "output",
        "scan_buffers": ["main", "system", "events"],
        "logcat_lines": 1000
    },
    "dropbox": {
        "types": {
            "data_app_anr": {"folder": "data_anr", "name_field": "Process"},
            "data_app_crash": {"folder": "data_crash", "name_field": "Process", "ignore_packages": ["reliabilityuiautomatortest"]},
            "data_app_native_crash": {"folder": "data_native_crash", "name_field": "Process"},
            "system_app_anr": {"folder": "sys_anr", "name_field": "Process"},
            "system_app_crash": {"folder": "sys_crash", "name_field": "Process"},
            "system_app_native_crash": {"folder": "sys_native_crash", "name_field": "Process"},
            "system_server_crash": {"folder": "block", "name_field": "Process"},
            "system_server_native_crash": {"folder": "block", "name_field": "Process"},
            "system_server_watchdog": {"folder": "block", "name_field": "Process"},
            "system_server_anr": {"folder": "sys_anr", "name_field": "Process"},
            "KERNEL_PANIC": {"folder": "block", "name_field": "Process"},
            "MODEM_SILENT_PANIC": {"folder": "block", "name_field": "Process"},
            "SUBSYS_SILENT_PANIC": {"folder": "block", "name_field": "Process"},
            "SYSTEM_TOMBSTONE": {"folder": "sys_native_crash", "name_field": "Cmdline", "filename_tag": "SIGSEGV"}
        }
    },
    "monkey": {
        "resource_dir": "tools/monkey",
        "apk": "app-debug.apk",
        "android_test_apk": "app-debug-androidTest.apk",
        "test_package": "com.transsion.testcaserepository",
        "test_package_test": "com.transsion.testcaserepository.test",
        "blacklist": "blacklist.txt",
        "monkey_script": "MonkeyTestAi.sh",
        "aim_jar": "aim.jar",
        "aim": "aim",
        "aimwd": "aimwd",
        "native_libs": ["arm64-v8a", "armeabi-v7a"],
        "device_tmp_dir": "/data/local/tmp",
        "device_blacklist_path": "/sdcard/blacklist.txt",
        "process_name": "com.android.commands.monkey"
    }
}
```

---

### Task 4: modules/analyse/dropbox_monitor.py（新建，合并 14 个模板类）

**Files:** Create: `modules/analyse/dropbox_monitor.py`

- [ ] **Step 1: 写文件**

```python
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
    """时间戳减 1 秒；格式非法时返回原值（修复原实现抛 ValueError 的问题）。"""
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
```

**与原始行为差异（有意为之）：**
- `second_reduce_one` 非法格式不再崩溃（B5）
- dropbox 查询统一走 `get_dropbox_entries`（含 PROTO 过滤，行为等价）
- logcat 1000 行阈值由原硬编码值保留（config 的 logcat_lines 供主入口扩展用）

---

### Task 5: modules/monkey/monkey_test.py（原 AIMonkeyTest.py 重构）

**Files:** Create: `modules/monkey/monkey_test.py`

- [ ] **Step 1: 写文件**

```python
# -*- coding: utf-8 -*-
"""AIMonkey 部署与启动（原 problem/monkey/AIMonkeyTest.py 重构）。

资源目录 tools/monkey；删除 play_video/memory_rw/offline-monkey 分支
（对应资源文件不存在，原代码不可达）；aimonkey.apk push 行删除（B7）。
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
```

**行为变更说明：** 原 do_monkey 的 `is_sleep=False` 分支与 `play_video/memory_rw/aimonkey=False` 分支删除（资源不存在不可达）；`uninstall` 使用纯包名（B6）；checkMonkey 调用路径由原 `run_monkey(device)` 改为 `start_test(device)`（等价）。

---

### Task 6: scan_log_gt.py 主入口重构

**Files:** Modify: `scan_log_gt.py`（全量重写）

- [ ] **Step 1: 写文件**

```python
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
        self.buffers = config["general"]["scan_buffers"]
        self.logcat_lines = config["general"]["logcat_lines"]

    # ---- 输出目录 ----
    def _prepare_output_dir(self, device):
        version = self.adb.getprop(device, "ro.build.display.id")
        base = os.path.join(self.output_root, version) if version else self.output_root
        for sub in OUTPUT_SUBDIRS:
            os.makedirs(os.path.join(base, device, sub), exist_ok=True)
        return base

    # ---- 状态持久化（json，替代原 eval 文本，B3）----
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

    # ---- monkey 保活（原 checkMonkey）----
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

    # ---- 单设备主循环（原 main）----
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
```

**行为变更说明：** `set_folderpath` 交互输入 → `-p` 参数；`ifrun` 死代码删除；`run_problem/run_first_problem` 合并为 `run_scan`（原二者逻辑相同）；getprop 空值时不再崩溃（B4）；`get_problem_counts` 一次性查询全部 14 类（原 run_problem 每类在分支内再查一次列表，等价）。

---

### Task 7: 残留清理与 import 修正

**Files:** Modify: `modules/common/logger.py`、`modules/common/path.py`、`modules/common/exec_cmd.py`、`modules/common/__init__.py`、`modules/__init__.py`、`modules/analyse/__init__.py`、`modules/monkey/__init__.py`、`stopAIMonkey.py`

- [ ] **Step 1: 修正上移文件的 import 路径（原 `problem.monkey.modules.common.*` → `modules.common.*`）**

`modules/common/path.py`:
```python
from problem.monkey.modules.common.path import PathManager
```
改为无 import（self 文件）；`logger.py` 的 `from problem.monkey.modules.common.path import PathManager` → `from modules.common.path import PathManager`；`exec_cmd.py` 的 `from problem.monkey.modules.common.logger import TEST_LOGGER` → `from modules.common.logger import TEST_LOGGER`。

- [ ] **Step 2: 空包 `__init__.py` 创建**

```powershell
Set-Content modules/analyse/__init__.py ""
Set-Content modules/monkey/__init__.py ""
```

- [ ] **Step 3: 删除未使用模块**

```powershell
Remove-Item modules/common/global_attrs.py, modules/common/android_device.py
```
（先确认无引用：`grep -r "global_attrs|android_device" --include=*.py` 应为空）

- [ ] **Step 4: stopAIMonkey.py 确认无包依赖（原文件仅用 subprocess，无需改动）**

---

### Task 8: pytest 测试

**Files:** Create: `test/test_config.py`、`test/test_time_utils.py`、`test/test_dropbox_monitor.py`

- [ ] **Step 1: test_config.py**

```python
import json
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_config():
    with open(os.path.join(PROJECT_ROOT, "config.json"), encoding="utf-8") as f:
        return json.load(f)


def test_config_has_14_dropbox_types():
    types = load_config()["dropbox"]["types"]
    assert len(types) == 14
    for t in ("data_app_anr", "data_app_crash", "data_app_native_crash",
              "system_app_anr", "system_app_crash", "system_app_native_crash",
              "system_server_crash", "system_server_native_crash", "system_server_watchdog",
              "system_server_anr", "KERNEL_PANIC", "MODEM_SILENT_PANIC",
              "SUBSYS_SILENT_PANIC", "SYSTEM_TOMBSTONE"):
        assert t in types


def test_monkey_resource_dir():
    config = load_config()
    assert config["monkey"]["resource_dir"] == "tools/monkey"
    for key in ("apk", "android_test_apk", "blacklist", "monkey_script", "aim_jar"):
        assert os.path.isfile(os.path.join(PROJECT_ROOT, config["monkey"]["resource_dir"],
                                           config["monkey"][key]))


def test_dropbox_type_config_keys():
    for t, c in load_config()["dropbox"]["types"].items():
        assert "folder" in c and "name_field" in c
```

- [ ] **Step 2: test_time_utils.py**

```python
import sys
import os

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from modules.analyse.dropbox_monitor import second_reduce_one, DropboxMonitor


def test_second_reduce_one_normal():
    assert second_reduce_one("2025-06-12 09:04:02") == "2025-06-12 09:04:01"


def test_second_reduce_one_cross_minute():
    assert second_reduce_one("2025-06-12 09:04:00") == "2025-06-12 09:03:59"


def test_second_reduce_one_invalid_returns_original():
    assert second_reduce_one("06-12 09:04:02") == "06-12 09:04:02"


def test_extract_name_timestamp_process():
    monitor = DropboxMonitor("sn1", "out", "data_app_anr", {"folder": "data_anr", "name_field": "Process"})
    detail = ["Process: com.foo", "Build: x", "Timestamp: 2025-06-12 09:04:02"]
    name, ts = monitor._extract_name_timestamp(detail, "2025-06-12 09:04:01")
    assert name == "com.foo"
    assert ts == "2025-06-12 09:04:02"


def test_extract_name_timestamp_cmdline():
    monitor = DropboxMonitor("sn1", "out", "SYSTEM_TOMBSTONE",
                             {"folder": "sys_native_crash", "name_field": "Cmdline"})
    detail = ["Timestamp: 2025-06-12 09:04:02", "Cmdline: /system/bin/foo/bar"]
    name, ts = monitor._extract_name_timestamp(detail, "2025-06-12 09:04:01")
    assert name == "%system%bin%foo%bar"
    assert ts == "2025-06-12 09:04:02"


def test_different_time_within_60s():
    monitor = DropboxMonitor("sn1", "out", "data_app_anr", {"folder": "data_anr", "name_field": "Process"})
    logcat = ["06-12 09:04:02.123 100 200 I tag: msg"]
    assert monitor.different_time(logcat, "2025-06-12 09:04:02") is True


def test_different_time_over_60s():
    monitor = DropboxMonitor("sn1", "out", "data_app_anr", {"folder": "data_anr", "name_field": "Process"})
    logcat = ["06-12 09:05:30.123 100 200 I tag: msg"]
    assert monitor.different_time(logcat, "2025-06-12 09:04:02") is False
```

- [ ] **Step 3: test_dropbox_monitor.py**

```python
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
    assert files[0].startswith("sn1_com.foo_data_app-anr_2025-06-12-090402")
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
```

- [ ] **Step 4: 运行测试**

```powershell
python -m pytest test/ -v
```
Expected: 全部 PASS

---

### Task 9: README.md 与 .gitignore 更新

**Files:** Create: `README.md`；Modify: `.gitignore`

- [ ] **Step 1: README.md**

```markdown
# stability_Log_scan_GT

高通/展锐（GT）平台稳定性日志扫描工具：常驻监控 adb 设备，自动部署 AIMonkey 压力测试，
增量扫描 dropbox 问题（ANR/Crash/Native Crash/Watchdog/Kernel Panic/Tombstone 等 14 类），
归档问题详情与问题发生前后的 logcat 到指定目录。

## 环境要求

- Python 3.9+
- adb 已加入 PATH

## 使用

```bash
python scan_log_gt.py -p D:\logs
```

| 参数 | 说明 |
|------|------|
| `-p` | 保存目录（必填） |
| `-i` | 轮询间隔秒数（默认 60，取 config.json） |
| `-s` | 跳过 monkey 检查/启动 |

独立部署 AIMonkey（不进入扫描循环）：

```bash
python -m modules.monkey.monkey_test -d <device>
```

停止设备上的 monkey：

```bash
python stopAIMonkey.py
```

## 配置（config.json）

- `general`：轮询间隔、logcat buffer 与行数
- `dropbox.types`：14 类问题的目录映射（新增问题类型只需在此加条目）
- `monkey`：AIMonkey 资源目录与设备端路径

## 目录结构

```
scan_log_gt.py            # 主入口
config.json               # 配置
modules/common/           # adb 封装、日志、路径、命令执行
modules/analyse/          # dropbox 问题分析器（配置驱动）
modules/monkey/           # AIMonkey 部署
tools/monkey/             # 设备端运行时资源（apk/jar/so/脚本/黑名单）
test/                     # pytest
logs/                     # 运行日志（自动生成）
```

## 已知说明

- 问题归档目录：`<保存目录>/<版本>/<设备>/<类型>/`
- 状态文件 `output_<设备>.json` 记录各问题计数，用于增量扫描
- 设备端脚本 `tools/monkey/MonkeyTestAi.sh` 内含 MTK 遗留命令（aee/mtk_battery_cmd），在 GT 平台上执行失败无害，后续可清理
```

- [ ] **Step 2: .gitignore 更新（反选路径从 problem/monkey 改为 tools/monkey，加状态文件）**

```gitignore
# Python
__pycache__/
*.py[cod]
*$py.class
.Python
build/
dist/
*.egg-info/
.installed.cfg
*.egg
.pytest_cache/
.coverage
htmlcov/
.env
.venv
env/
venv/

# IDE / 系统
.idea/
.vscode/
*.iml
*.swp
*.swo
*~*
.DS_Store

# 打包产物
scan_log_gt
scan_log_gt1

# 运行日志与输出
logs/
log/
*.log
output_*.txt
output_*.json
result/
scan_result/

# 压缩包
*.rar
*.zip

# 运行时必需资源（父仓库 .gitignore 忽略 *.jar/*.apk/*.so，此处反选）
!tools/monkey/aim.jar
!tools/monkey/app-debug.apk
!tools/monkey/app-debug-androidTest.apk
!tools/monkey/arm64-v8a/libfastbot_native.so
!tools/monkey/armeabi-v7a/libfastbot_native.so
```

---

### Task 10: 全量验证

- [ ] **Step 1: 语法编译检查**

```powershell
python -m compileall scan_log_gt.py modules stopAIMonkey.py
```
Expected: 无错误输出

- [ ] **Step 2: 测试**

```powershell
python -m pytest test/ -v
```
Expected: 全部 PASS

- [ ] **Step 3: 静态 import 验证（无需 adb）**

```powershell
python -c "import scan_log_gt; import modules.analyse.dropbox_monitor; import modules.monkey.monkey_test; import modules.common.adb_client; print('OK')"
```
Expected: OK

- [ ] **Step 4: 残留检查**

```powershell
Select-String -Path modules\common\*.py -Pattern "problem\." 
Select-String -Path modules\**\*.py -Pattern "problem\."
```
Expected: 无匹配

- [ ] **Step 5: 父仓库忽略规则复核**

```powershell
git -C F:\automation-toolkit status --porcelain --untracked-files=all -- python-tools/stability_Log_scan_GT
```
Expected: 无 `problem/`、无 `tools/monkey` 缺失；`.gitignore`、`config.json`、`scan_log_gt.py`、`modules/`、`test/`、`README.md` 均在列

---

## 自检记录

**覆盖度：** 14 类合并（Task 4）、MonkeyTest 迁移（Task 5）、CLI 化（Task 6）、config 化（Task 3）、bug 修复 B1-B7（Task 2/4/5/6）、死代码删除（Task 1/7）、测试（Task 8）、文档（Task 9）、验证（Task 10）——全部覆盖。

**占位符：** 无 TBD/TODO；每个文件给出完整代码。

**类型一致性：** `DropboxMonitor(device, folderpath, type_name, type_config).analyse(count, end)` 在 Task 4 定义、Task 6 调用一致；`AdbClient.get_dropbox_entries/get_dropbox_detail/get_logcat_before` 签名在 Task 2 与 Task 4 一致；`MonkeyTest(config).start_test(device)` Task 5 定义、Task 6 调用一致；`config["monkey"][key]` 键名在 Task 3 定义与 Task 5 使用一致。
