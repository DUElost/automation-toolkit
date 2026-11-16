# -*- coding: utf-8 -*-
# memleak_monitor_2d.py —— v6（重点盯防名单 + 堆时序 + 270s 节奏 + L1 45%）
# v5（system_server OOM 提前抓取：堆占比分级+30s加密轮询+本地镜像）
# 基线: gpuinfo_0614_1H_main_rename_daily_15min_scan.py（带增量拉取去重，避免每30分钟全量重拉打爆共享盘）
# v3 改动: 只采 meminfo、不导出 mobilelog/aee；1)不跑Monkey 2)移除4条setprop 3)移除固定1h/2h dump 4)任一应用RSS>1GB才dump 5)修正RSS段落越界解析 6)目录命名对齐 sonic_tinno 约定
# v7（2026-10-20）：只监控 system_server OOM；移除应用 RSS/Logcat OOM 触发与 systemui meminfo 采集
# v8（2026-10-21）：接入 monkey 压测（复用平台 AIMonkey 资源，设备端 mobilelog 已禁用）；监控面仍只针对 system_server
import sys

import time
import subprocess
import re
import os
import logging
import threading
import shutil
import json
import signal

from datetime import datetime
from concurrent.futures import ThreadPoolExecutor, as_completed

# Switch to control mobilelog export: True to export only main_log files, False for original logic.
EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG = True
# Regex for main_log files (case-sensitive for filenames)
MAIN_LOG_FILE_PATTERN = re.compile(r"^main_log.*")

# 【内存泄露触发配置】
HPROF_DUMP_COOLDOWN_SECONDS = 1800      # 按 (设备, 进程) 冷却 30 分钟，沿用原脚本机制
DUMP_MIN_FREE_GB = 20                   # 15.4 共享剩余低于 20GB 时跳过 dump，只记日志
# 2026-10-19 变更：system_server 纳入监控对象，已从排除名单移出；
SYSTEM_SERVER_MEMINFO_NAME = "system"            # dumpsys meminfo 中 system_server 显示为 "system"
SYSTEM_SERVER_PROC_NAME = "system_server"        # am dumpheap 前先 pidof 解析
SYSTEM_SERVER_RSS_DUMP_THRESHOLD_KB = 1_000_000  # 1GB，与应用同口径（基线 400-650MB，越线即异常）
SYSTEM_SERVER_DUMP_COOLDOWN_SECONDS = 7200       # system_server 单独 2 小时冷却（dump 会 Full GC，体量大）

# ── Monkey 压测（复用平台 AIMonkey 资源；设备端 mobilelog 已禁用）──
MONKEY_ENABLED = os.environ.get("MEMLEAK_MONKEY", "0") != "0"   # 2026-10-22: Monkey 移交平台专项，默认停用；临时启用 MEMLEAK_MONKEY=1
AIMONKEY_DIR = os.environ.get("AIMONKEY_DIR", "/opt/stability-test-agent/agent/resources/aimonkey/AIMonkeyTest_20260317")
MONKEY_LAUNCHER_LOCAL = "/home/android/memleak/MonkeyTest.sh"
MONKEY_THROTTLE_MS = 750
MONKEY_RUNTIME_MINUTES = 11520
MONKEY_PS_TIMEOUT = 15
MONKEY_PUSH_TIMEOUT = 300
MONKEY_START_VERIFY_TIMEOUT = 120
MONKEY_PUSH_FILES = [
    ("aim", "/data/local/tmp/aim", "755"),
    ("aimonkey.apk", "/data/local/tmp/monkey.apk", "644"),
    ("aim.jar", "/data/local/tmp/aim.jar", "644"),
    (MONKEY_LAUNCHER_LOCAL, "/data/local/tmp/MonkeyTest.sh", "755"),
    ("aimwd", "/data/local/tmp/aimwd", "777"),
    ("blacklist.txt", "/sdcard/blacklist.txt", "644"),
]
MONKEY_ARCH_DIRS = {
    "arm64-v8a": "/data/local/tmp/arm64-v8a",
    "armeabi-v7a": "/data/local/tmp/armeabi-v7a",
}
MONKEY_CLEAN_PATHS = [
    "/data/local/tmp/MonkeyTest.sh",
    "/data/local/tmp/aim",
    "/data/local/tmp/aimwd",
    "/data/local/tmp/aim.jar",
    "/data/local/tmp/monkey.apk",
    "/data/local/tmp/arm64-v8a",
    "/data/local/tmp/armeabi-v7a",
    "/sdcard/blacklist.txt",
]
MONKEY_SCREEN_OFF_STORE = "/home/android/memleak/screen_off_timeout.json"

# —— v5：system_server OOM 提前抓取（堆占比分级 + 加密轮询 + 本地镜像双写）——
# 依据实测：RSS≥1GB 时 system_server 堆已到 ~99%（167 崩溃仅剩 4855KB / 512MB），且 RSS 与堆不成比例，
# 因此改用 Dalvik Heap 占 target footprint 的比例做分级"上穿即抓一次"，并对发热设备加密到 30 秒。
# D) L1 由 55% 下调到 45%（≈230MB）：102 曾冲到 40% 后回落，55% 抓不到冲高过程
SS_HEAP_LEVELS = [(1, 0.85), (2, 0.95)]   # v6(2026-10-21 用户改): 85% 与 95% 各上穿 dump 一次
SS_LEVEL_RESET_RATIO = 0.35
LAUNCHER_PKG = "com.android.launcher3"          # v7(2026-10-27 用户加): launcher3 泄漏监控
LAUNCHER_RSS_DUMP_THRESHOLD_KB = 1_000_000      # launcher RSS 超 976MB 触发（同 system_server 档）
LAUNCHER_EARLY_MIN_RATIO = 0.60                 # launcher 仅 ≥60% 才做早期信号补抓（压应用噪声）
HEAP_SERIES_LAUNCHER_FILENAME = "meminfo_heap_launcher.txt"
SYSTEMUI_PKG = "com.android.systemui"           # v8(2026-11-02 用户加): systemui 泄漏监控（判据同 launcher 档）
SETTINGS_PKG = "com.android.settings"           # v8(2026-11-02 用户加): settings 泄漏监控（判据同 launcher 档）
APP_EXTRA_PKGS = (SYSTEMUI_PKG, SETTINGS_PKG)   # v8: 与 launcher3 共用一套判据/触发逻辑的附加应用
APP_HEAP_SERIES_MULTI_FILENAME = "meminfo_heap_apps.txt"  # v8: systemui/settings 堆时序（launcher 仍走原文件；复位线 35%，85/95 各上穿抓一次）
SS_FAST_POLL_INTERVAL = 30       # 进入 L1 后，对该设备每 30 秒只看一次 system 的堆（实测 0.35~0.67s）
SS_TARGET_HEAP_FALLBACK_KB = 524288          # 读不到 dalvik.vm.heapsize 时按 512MB 计算
SS_EARLY_SIGNAL_MIN_INTERVAL = 600           # logcat 早期信号补抓的最小间隔（秒）
LOGCAT_EARLY_SIGNAL_PATTERN = re.compile(r"Waiting for a blocking GC|Clamp target GC heap|Throwing OutOfMemoryError|am_low_memory|LOW MEMORY")
LOCAL_HPROF_STAGING_ROOT = os.environ.get("MEMLEAK_STAGING", "/home/android/memleak_local")  # 本地镜像目录
MIRROR_MIN_FREE_GB = 20          # 15.4 剩余低于此值时不再拷共享盘，只保留本地镜像
LOCAL_MIN_FREE_GB = 10           # 本地剩余低于此值才真正跳过 dump
# A) 重点盯防名单：命中者无条件进入 30 秒加密轮询（不必等 L1）
# 运行时可在主机维护 /home/android/memleak/hot_devices.txt（每行一个序列号，# 注释），下一轮即生效
HOT_DEVICES_FILE = os.environ.get("MEMLEAK_HOT_FILE", "/home/android/memleak/hot_devices.txt")
HOT_DEVICE_SERIALS_DEFAULT = {
    "AHFFNX6930000217", "AHFFNX6930000188", "AHFFNX6930000167",
    "AHFFNX6930000161", "AHFFNX6930000374", "AHFFNX6930000163",
    "AHFFNX6930000230", "ATHTNX6930000002", "ATHTNX6930000032",
    "AHFFNX6930000182", "ATHTNX6930000102",
}


def get_hot_device_set():
    """默认名单 + 外部文件，名单可运行时增删。"""
    result = set(HOT_DEVICE_SERIALS_DEFAULT)
    try:
        with open(HOT_DEVICES_FILE, encoding="utf-8") as fh:
            for line in fh:
                name = line.strip()
                if name and not name.startswith("#"):
                    result.add(name)
    except OSError:
        pass
    return result


HOT_DEVICE_SERIALS = get_hot_device_set()
HEAP_SERIES_FILENAME = "meminfo_heap.txt"   # B) 堆时序：真正有预测力的曲线
HEAP_SERIES_MIN_INTERVAL = 30               # 每台最多 30 秒写一行
heap_series_last_write = {}
ss_heap_level = {}               # device -> 已触发的最高档位
ss_hot_devices = set()           # 需要加密轮询的设备
la_heap_level = {}               # v7: launcher3 堆档位状态
app_heap_level = {}              # v8: (device, pkg) 堆档位状态（systemui/settings）
device_log_path_map = {}         # device -> 产物目录（供加密轮询复用）
MEMINFO_RSS_PATTERN = re.compile(r"^\s*([\d,]+)K:\s*([\w.-]+)") # 用于解析meminfo中进程内存的正则表达式
last_hprof_dump_times = {} # 【新增】记录每个设备上次dump hprof的时间

# 日志模块代码（从modules.common.logger导入）
class Logger(object):
    def __init__(self, log_path, cmd_level=logging.INFO, file_level=logging.INFO):
        self.__tag = "MonkeyTest"
        self.__logger = logging.getLogger(str(time.time())) # Use unique name for logger
        self.__logger.setLevel(logging.INFO)
        self.__file_level = file_level
        self.__formatter = logging.Formatter('[%(asctime)s][%(levelname)s] %(message)s', '%Y-%m-%d %H:%M:%S')

        self.__sh = logging.StreamHandler()
        self.__sh.setFormatter(self.__formatter)
        self.__sh.setLevel(cmd_level)

        self.__fh = logging.FileHandler(log_path, encoding="utf-8")
        self.__fh.setFormatter(self.__formatter)
        self.__fh.setLevel(file_level)

        self.__logger.addHandler(self.__sh)
        self.__logger.addHandler(self.__fh)

    def setDebugMode(self):
        self.__file_level = logging.DEBUG
        self.__logger.setLevel(self.__file_level)
        self.__sh.setLevel(self.__file_level)
        self.__fh.setLevel(self.__file_level)

    def resetLogFile(self, log_path):
        self.__logger.removeHandler(self.__fh)
        self.__fh = logging.FileHandler(log_path, encoding="utf-8")
        self.__fh.setFormatter(self.__formatter)
        self.__fh.setLevel(self.__file_level)
        self.__logger.addHandler(self.__fh)

    def resetTag(self, tag=None):
        if tag is None:
            self.__tag = "MonkeyTest"
        else:
            self.__tag = tag

    def debug(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.debug(f"[{tag}][{sn}] --- {message}")
        else:
            self.__logger.debug(f"[{tag}] --- {message}")

    def info(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.info(f"[{tag}][{sn}] --- {message}")
        else:
            self.__logger.info(f"[{tag}] --- {message}")

    def warn(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.warning(f"[{tag}][{sn}] --- {message}")
        else:
            self.__logger.warning(f"[{tag}] --- {message}")
    
    def warning(self, message, sn=None, tag=None):
        self.warn(message, sn, tag)

    def error(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.error(f"[{tag}][{sn}] --- {message}")
        else:
            self.__logger.error(f"[{tag}] --- {message}")

    def critical(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.critical(f"[{tag}][{sn}] --- {message}")
        else:
            self.__logger.critical(f"[{tag}] --- {message}")

# 创建脚本自身日志的目录和记录器
log_folder = os.path.join(os.path.dirname(os.path.abspath(__file__)), "logs")
if not os.path.isdir(log_folder):
    os.makedirs(log_folder)
loggerName = datetime.now().strftime("MonkeyTest_%Y_%m_%d.log") # This is for the script's own operational log
loggerPath = os.path.join(log_folder, loggerName)
TEST_LOGGER = Logger(loggerPath)


# --- 辅助函数，用于动态生成文件夹名称 ---
def _run_adb_prop_command(device_id, prop_name):
    """
    为指定设备执行 ADB shell getprop 命令。
    返回属性值字符串或 None。
    """
    try:
        command = ["adb", "-s", device_id, "shell", "getprop", prop_name]
        TEST_LOGGER.debug(f"设备 {device_id}: 执行 ADB getprop: {' '.join(command)}")
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=True,
            encoding='utf-8'
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        TEST_LOGGER.error(f"设备 {device_id}: ADB命令 '{' '.join(command)}' 失败: {e.stderr.strip()}")
        return None
    except FileNotFoundError:
        TEST_LOGGER.error("'adb' 命令未找到。请确保它在您的系统路径中。")
        return None
    except Exception as e:
        TEST_LOGGER.error(f"设备 {device_id}: 执行ADB命令 '{' '.join(command)}' 时发生意外错误: {e}")
        return None

def generate_device_log_folder_name_components(device_id):
    """
    产物目录命名，对齐 15.4 共享既有约定（例: MLY-LX3_16_260914V2_260922_Systeminfo）:
        <ro.product.name>_<段2>_<build>_<运行日YYMMDD>_Systeminfo
    兼容两种 display id：
        "MLD-NX2-16-261013V21"        -> MLD-NX2_16_261013V21_<YYMMDD>_Systeminfo
        "MLY-LX3-16(260914V2)260922"  -> MLY-LX3_16_260914V2_<YYMMDD>_Systeminfo
    """
    product_name = _run_adb_prop_command(device_id, "ro.product.name")
    display_id = _run_adb_prop_command(device_id, "ro.build.display.id")

    if not product_name or not display_id:
        TEST_LOGGER.error(f"设备 {device_id}: 未能获取 ro.product.name 或 ro.build.display.id。无法生成文件夹名称。")
        return None

    rest = display_id
    if rest.startswith(product_name):
        rest = rest[len(product_name):]
    tokens = [t for t in re.split(r"[-()]", rest) if t]

    segment2 = tokens[0] if tokens else "UNKNOWN"
    build_token = ""
    for token in tokens[1:]:
        if re.search(r"\d{6}", token):   # 形如 261013V21 / 260914V2
            build_token = token
            break
    if not build_token:
        build_token = tokens[-1] if len(tokens) > 1 else "UNKNOWN_BUILD"

    current_date_str = datetime.now().strftime("%y%m%d")
    final_folder_name = "_".join([product_name, segment2, build_token, current_date_str, "Systeminfo"])

    TEST_LOGGER.info(f"设备 {device_id}: display.id='{display_id}' 生成的目录名称: {final_folder_name}")
    return final_folder_name

# --- 日志目录结构配置 ---
TARGET_FTP_LOG_ROOT_DIR = "/home/android/sonic_agent/logs/ftp_log/sonic_tinno"
COLLECTION_INTERVAL = 300  # 与平台 Job 共存：主循环 300 秒一轮
DEVICE_CHECK_INTERVAL = 300 

# 各批次命令的执行间隔
BATCH_INTERVALS = {
    "batch_leak_check": 270,
    "batch_monkey": 300, # C) 必须小于 COLLECTION_INTERVAL，否则实测退化为 600s
    "batch_7s": 7,
    "batch_1min": 60,
    "batch_2min": 120,
    "batch_5min": 300,
    "batch_10min": 600,
    "batch_15min": 900
}

# 需要在脚本启动时为每台设备执行的初始设置命令 (shell部分)
INITIAL_SETUP_COMMAND_ACTIONS = [
    "shell dumpsys activity dumpheapops on",
    # 已移除 loggerui 日志采集开关：本次任务不导出 mobilelog（该广播会驱动设备持续生成日志包）
]

last_execution_times = {}
last_device_check_time = 0 
active_devices = set()


def get_connected_devices():
    """获取所有连接的Android设备"""
    try:
        result = subprocess.run(["adb", "devices"], capture_output=True, text=True, check=True)
        devices = []
        for line in result.stdout.strip().split('\n')[1:]:
            if line.strip() and "device" in line:
                device_id = line.split()[0]
                devices.append(device_id)
        return devices
    except Exception as e:
        TEST_LOGGER.error(f"获取设备列表失败: {e}")
        return []

def run_initial_setup_commands(device_id):
    """为指定设备执行初始设置命令"""
    TEST_LOGGER.info(f"设备 {device_id}: 开始执行初始设置命令...")
    for action in INITIAL_SETUP_COMMAND_ACTIONS:
        cmd = f"adb -s {device_id} {action}"
        try:
            TEST_LOGGER.info(f"设备 {device_id}: 执行中: {cmd}")
            subprocess.run(cmd, shell=True, check=True, timeout=60)
            TEST_LOGGER.info(f"设备 {device_id}: 命令成功: {cmd}")
        except subprocess.CalledProcessError as e:
            TEST_LOGGER.error(f"设备 {device_id}: 执行初始设置命令失败: {cmd}, 错误: {e}")
        except subprocess.TimeoutExpired:
            TEST_LOGGER.error(f"设备 {device_id}: 执行初始设置命令超时: {cmd}")
        except Exception as e_generic:
            TEST_LOGGER.error(f"设备 {device_id}: 执行初始设置命令时发生未知错误: {cmd}, 错误: {e_generic}")
    TEST_LOGGER.info(f"设备 {device_id}: 初始设置命令执行完毕。")


def get_remote_dir_structure(device_id, remote_path_abs):
    """Gets the directory structure from the Android device using 'find'."""
    remote_path_abs_stripped = remote_path_abs.rstrip('/')
    is_mobilelog_target = "mobilelog" in remote_path_abs.lower() 
    
    if EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG and is_mobilelog_target:
        cmd = f"adb -s {device_id} shell \"cd \\\"{remote_path_abs_stripped}\\\" && find . -type f -name 'main_log*' -print\""
        TEST_LOGGER.info(f"设备 {device_id}: 获取远程 mobilelog (仅 main_log 文件) 结构: {cmd}")
    else:
        cmd = f"adb -s {device_id} shell \"cd \\\"{remote_path_abs_stripped}\\\" && find . -print\""
        TEST_LOGGER.debug(f"设备 {device_id}: 获取远程目录结构: {cmd}")

    structure = set()
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, check=True, timeout=300) 
        output_lines = result.stdout.strip().splitlines()
        for line in output_lines:
            relative_path = line.lstrip('./') 
            if relative_path: 
                structure.add(relative_path)
        return structure
    except subprocess.CalledProcessError as e:
        error_output = (e.stderr or "") + (e.stdout or "")
        if "No such file or directory" in error_output or "not found" in error_output.lower():
            TEST_LOGGER.warning(f"设备 {device_id} 远程目录 \"{remote_path_abs}\" 不存在或为空 (adb find)。")
            return set() 
        TEST_LOGGER.error(f"设备 {device_id} 获取远程目录结构失败 (\"{remote_path_abs}\"): {error_output.strip()}")
        return None 
    except subprocess.TimeoutExpired:
        TEST_LOGGER.error(f"设备 {device_id} 获取远程目录结构超时 (\"{remote_path_abs}\")。")
        return None 
    except Exception as e_generic:
        TEST_LOGGER.error(f"设备 {device_id} 获取远程目录结构时发生未知错误 (\"{remote_path_abs}\"): {e_generic}")
        return None

def get_local_dir_structure(local_path_abs):
    """Gets the local directory structure."""
    local_path_abs_stripped = local_path_abs.rstrip('/').rstrip('\\')
    structure = set()
    if not os.path.exists(local_path_abs_stripped):
        TEST_LOGGER.info(f"本地目录 \"{local_path_abs_stripped}\" 不存在。")
        return structure

    is_mobilelog_target = "mobilelog" in local_path_abs.lower()

    for root, dirs, files in os.walk(local_path_abs_stripped):
        processed_in_this_dir = False
        if EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG and is_mobilelog_target:
            for name in files:
                if MAIN_LOG_FILE_PATTERN.match(name):
                    full_path = os.path.join(root, name)
                    relative_path = os.path.relpath(full_path, local_path_abs_stripped).replace('\\', '/')
                    structure.add(relative_path)
            processed_in_this_dir = True # Mark that files were processed under mobilelog rules
        
        if not processed_in_this_dir: # Process all if not mobilelog or mobilelog rule doesn't apply
            for name in dirs:
                full_path = os.path.join(root, name)
                relative_path = os.path.relpath(full_path, local_path_abs_stripped).replace('\\', '/')
                structure.add(relative_path)
            for name in files:
                full_path = os.path.join(root, name)
                relative_path = os.path.relpath(full_path, local_path_abs_stripped).replace('\\', '/')
                structure.add(relative_path)
    return structure


def _clean_path_for_os_operations(path_str):
    """Removes surrounding quotes (if any) and trailing slashes for OS path functions."""
    if path_str.startswith('"') and path_str.endswith('"'):
        path_str = path_str[1:-1]
    return path_str.rstrip('/').rstrip('\\')


def run_pull_in_background(full_cmd, device_id_arg):
    """
    Helper function to run a pull command in a background thread.
    Compares remote and local directory structures before pulling.
    If structures differ, pulls only new items from remote.
    Respects EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG for mobilelog paths.
    """
    try:
        match = re.match(r"adb -s\s+([\w.-]+)\s+pull\s+(\S+)\s+(.+)", full_cmd) 
        if not match:
            TEST_LOGGER.error(f"设备 {device_id_arg} 无法解析后台拉取命令: {full_cmd}")
            return

        _parsed_device_id = match.group(1)
        remote_src_from_cmd = match.group(2) 
        local_dest_from_cmd = match.group(3) 

        remote_path_for_os = _clean_path_for_os_operations(remote_src_from_cmd)
        local_path_for_os = _clean_path_for_os_operations(local_dest_from_cmd)
        
        is_mobilelog_context = "mobilelog" in remote_path_for_os.lower()

        if local_dest_from_cmd.rstrip('/').rstrip('\\').endswith(('/', '\\')) or not os.path.splitext(local_path_for_os)[1]:
            os.makedirs(local_path_for_os, exist_ok=True)
        else:
            os.makedirs(os.path.dirname(local_path_for_os), exist_ok=True)


        perform_full_pull = False
        reason_for_full_pull = ""

        local_target_exists_and_not_empty = os.path.exists(local_path_for_os) and \
                                            ( (os.path.isdir(local_path_for_os) and os.listdir(local_path_for_os)) or \
                                                os.path.isfile(local_path_for_os) )

        if not local_target_exists_and_not_empty:
            TEST_LOGGER.info(f"设备 {device_id_arg}: 本地目标 \"{local_path_for_os}\" 不存在或为空，为 \"{remote_path_for_os}\" 准备执行完整拉取。")
            perform_full_pull = True
            reason_for_full_pull = "本地目标不存在或为空"
        else:
            TEST_LOGGER.info(f"设备 {device_id_arg}: 本地 \"{local_path_for_os}\" 存在，开始比对 \"{remote_path_for_os}\" 的目录结构。")
            remote_structure = get_remote_dir_structure(device_id_arg, remote_path_for_os)
            
            if remote_structure is None: 
                TEST_LOGGER.warning(f"设备 {device_id_arg}: 无法获取远程目录 \"{remote_path_for_os}\" 结构，准备执行完整拉取作为回退。")
                perform_full_pull = True
                reason_for_full_pull = "无法获取远程目录结构"
            else:
                local_structure = get_local_dir_structure(local_path_for_os)
                if remote_structure == local_structure:
                    log_msg = f"设备 {device_id_arg}: 远程 \"{remote_path_for_os}\" 与本地 \"{local_path_for_os}\" 结构一致"
                    if EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG and is_mobilelog_context:
                        log_msg += " (main_log files)"
                    log_msg += "，跳过拉取。"
                    TEST_LOGGER.info(log_msg)
                    return 
                else:
                    log_msg_diff = f"设备 {device_id_arg}: 远程 \"{remote_path_for_os}\" 与本地 \"{local_path_for_os}\" 结构不一致"
                    if EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG and is_mobilelog_context:
                        log_msg_diff += " (main_log files)"
                    TEST_LOGGER.info(log_msg_diff)
                    
                    added_on_remote = remote_structure - local_structure
                    
                    if not added_on_remote:
                        TEST_LOGGER.info(f"设备 {device_id_arg}: 结构不一致但远程没有新增项 (可能是本地有额外文件或远程有删除项)，本次跳过拉取。")
                        return
                    
                    TEST_LOGGER.info(f"设备 {device_id_arg}: 将选择性拉取远程新增的 {len(added_on_remote)} 项从 \"{remote_path_for_os}\" 到 \"{local_path_for_os}\"。")
                    items_pulled_successfully = 0
                    items_failed_to_pull = 0

                    for item_relative_path in sorted(list(added_on_remote)):
                        remote_item_full_path = os.path.join(remote_path_for_os.rstrip('/'), item_relative_path).replace('\\', '/')
                        local_item_full_path = os.path.join(local_path_for_os.rstrip('/'), item_relative_path) 
                        
                        local_target_parent_dir_for_item = os.path.dirname(local_item_full_path)
                        if local_target_parent_dir_for_item : 
                                os.makedirs(local_target_parent_dir_for_item, exist_ok=True)
                        
                        pull_item_cmd = f"adb -s {device_id_arg} pull \"{remote_item_full_path}\" \"{local_target_parent_dir_for_item if local_target_parent_dir_for_item else local_path_for_os}/\""
                        
                        TEST_LOGGER.debug(f"设备 {device_id_arg}: 尝试拉取新增项: {pull_item_cmd}")
                        try:
                            subprocess.run(pull_item_cmd, shell=True, check=True, timeout=1800) 
                            TEST_LOGGER.info(f"设备 {device_id_arg}: 成功拉取新增项 \"{item_relative_path}\" 到 \"{local_target_parent_dir_for_item if local_target_parent_dir_for_item else local_path_for_os}\"")
                            items_pulled_successfully += 1
                        except subprocess.TimeoutExpired:
                            TEST_LOGGER.error(f"设备 {device_id_arg}: 拉取新增项 \"{item_relative_path}\" 超时: {pull_item_cmd}")
                            items_failed_to_pull += 1
                        except subprocess.CalledProcessError as e_pull_item:
                            error_output_item = (e_pull_item.stderr or "") + (e_pull_item.stdout or "")
                            TEST_LOGGER.error(f"设备 {device_id_arg}: 拉取新增项 \"{item_relative_path}\" 失败: {pull_item_cmd}, 错误: {error_output_item.strip()}")
                            items_failed_to_pull += 1
                        except Exception as e_generic_item:
                            TEST_LOGGER.error(f"设备 {device_id_arg}: 拉取新增项 \"{item_relative_path}\" 时发生未知错误: {pull_item_cmd}, 错误: {e_generic_item}")
                            items_failed_to_pull += 1
                    
                    if items_failed_to_pull > 0:
                        TEST_LOGGER.warning(f"设备 {device_id_arg}: 完成对 \"{remote_path_for_os}\" 的差异拉取, {items_pulled_successfully} 项成功, {items_failed_to_pull} 项失败。")
                    else:
                        TEST_LOGGER.info(f"设备 {device_id_arg}: 成功完成对 \"{remote_path_for_os}\" 的 {items_pulled_successfully} 项差异拉取。")
                    return 

        if perform_full_pull:
            if EXPORT_ONLY_MAIN_LOG_FROM_MOBILELOG and is_mobilelog_context:
                TEST_LOGGER.info(f"设备 {device_id_arg}: 执行筛选后的完整后台拉取 (仅 main_log 文件) 从 \"{remote_path_for_os}\" ({reason_for_full_pull})")
                filtered_remote_items = get_remote_dir_structure(device_id_arg, remote_path_for_os) 
                
                if filtered_remote_items is None:
                    TEST_LOGGER.error(f"设备 {device_id_arg}: 无法获取远程 \"{remote_path_for_os}\" 结构以进行筛选后的完整拉取，跳过。")
                    return
                if not filtered_remote_items:
                    TEST_LOGGER.info(f"设备 {device_id_arg}: 远程 \"{remote_path_for_os}\" 没有找到 main_log 文件进行拉取。")
                    return

                items_pulled_successfully = 0
                items_failed_to_pull = 0
                for item_relative_path in sorted(list(filtered_remote_items)): # These are file paths relative to remote_path_for_os
                    remote_item_full_path = os.path.join(remote_path_for_os.rstrip('/'), item_relative_path).replace('\\', '/')
                    local_item_full_path = os.path.join(local_path_for_os.rstrip('/'), item_relative_path) 
                    
                    local_target_parent_dir_for_item = os.path.dirname(local_item_full_path)
                    if local_target_parent_dir_for_item:
                            os.makedirs(local_target_parent_dir_for_item, exist_ok=True)
                    
                    pull_item_cmd = f"adb -s {device_id_arg} pull \"{remote_item_full_path}\" \"{local_target_parent_dir_for_item if local_target_parent_dir_for_item else local_path_for_os}/\""
                    TEST_LOGGER.debug(f"设备 {device_id_arg}: (筛选完整拉取) 尝试拉取: {pull_item_cmd}")
                    try:
                        subprocess.run(pull_item_cmd, shell=True, check=True, timeout=1800)
                        items_pulled_successfully +=1
                    except Exception as e_item_pull:
                        TEST_LOGGER.error(f"设备 {device_id_arg}: (筛选完整拉取) 拉取项 \"{item_relative_path}\" 失败: {e_item_pull}")
                        items_failed_to_pull +=1
                
                if items_failed_to_pull > 0:
                        TEST_LOGGER.warning(f"设备 {device_id_arg}: 完成对 \"{remote_path_for_os}\" 的筛选后完整拉取, {items_pulled_successfully} 项成功, {items_failed_to_pull} 项失败。")
                else:
                    TEST_LOGGER.info(f"设备 {device_id_arg}: 成功完成对 \"{remote_path_for_os}\" 的 {items_pulled_successfully} 项筛选后完整拉取。")
                return 
            else: # Standard full pull for non-mobilelog or when mobilelog filter is off
                final_local_dest = local_dest_from_cmd.rstrip('/').rstrip('\\') + os.sep
                os.makedirs(final_local_dest, exist_ok=True)

                adjusted_remote_src_for_adb = remote_src_from_cmd.rstrip('/') + "/."
                                            
                final_cmd_to_run = f"adb -s {_parsed_device_id} pull \"{adjusted_remote_src_for_adb}\" \"{final_local_dest}\""

                TEST_LOGGER.info(f"设备 {device_id_arg}: 执行调整后的完整后台拉取 ({reason_for_full_pull}): {final_cmd_to_run}")
                subprocess.run(final_cmd_to_run, shell=True, check=True, timeout=3600) 
                TEST_LOGGER.info(f"设备 {device_id_arg}: 完整后台拉取成功: {final_cmd_to_run}")

    except subprocess.TimeoutExpired:
        TEST_LOGGER.error(f"设备 {device_id_arg} 后台拉取操作 (可能是完整拉取或解析阶段) 超时。命令大致为: {full_cmd}")
    except subprocess.CalledProcessError as e:
        error_output_pull = (e.stderr or "") + (e.stdout or "")
        TEST_LOGGER.error(f"设备 {device_id_arg} 后台拉取操作 (可能是完整拉取或解析阶段) 失败。命令大致为: {full_cmd}, 错误: {error_output_pull.strip()}")
    except Exception as e_outer:
        current_remote_src_display = remote_src_from_cmd if 'remote_src_from_cmd' in locals() else "未知远程路径"
        TEST_LOGGER.error(f"设备 {device_id_arg} 后台拉取 \"{current_remote_src_display}\" (命令大致为: {full_cmd}) 时发生未知错误: {e_outer}", exc_info=True)


# Pattern to identify commands that attempt to redirect adb shell output to a host path
STDOUT_REDIRECT_PATTERN = re.compile(
    r"adb -s\s+(?P<device_id_in_cmd>[\w.-]+)\s+shell\s+\"(?P<shell_cmd_part>.+?)\s+(?P<redirect_op>>>|>)\s*(?P<host_path>.+?)\"$"
)

def execute_commands(device_id, commands, batch_name):
    """【优化后】执行一组命令并记录执行时间，为耗时操作智能分配更长的超时。"""
    TEST_LOGGER.info(f"设备 {device_id} 开始执行 {batch_name} 批次命令")

    long_pull_commands_patterns = [
        f"adb -s {device_id} pull /data/debuglogger/mobilelog/",
        f"adb -s {device_id} pull /data/aee_exp/",
        f"adb -s {device_id} pull /data/vendor/aee_exp/"
    ]
    
    for cmd in commands:
        is_long_pull = any(cmd.startswith(pattern) for pattern in long_pull_commands_patterns)
        
        if is_long_pull:
            TEST_LOGGER.info(f"设备 {device_id} 将在后台执行增量拉取操作: {cmd}")
            thread = threading.Thread(target=run_pull_in_background, args=(cmd, device_id))
            thread.daemon = True 
            thread.start()
            continue # 后台任务已启动，继续处理下一个命令

        match = STDOUT_REDIRECT_PATTERN.match(cmd)
        if match and match.group('device_id_in_cmd') == device_id:
            # 此部分逻辑正确，保持不变
            # ... (省略之前版本中处理重定向的完整代码)
            actual_shell_cmd_part = match.group('shell_cmd_part').strip()
            redirect_op = match.group('redirect_op')
            host_file_path = match.group('host_path').strip()

            device_shell_cmd_to_run = f"adb -s {device_id} shell \"{actual_shell_cmd_part}\""
            
            TEST_LOGGER.info(f"设备 {device_id}: 捕获 stdout: \"{actual_shell_cmd_part}\" -> {host_file_path} (模式: {redirect_op})")

            try:
                process_timeout = 60 
                if "dumpsys meminfo" in actual_shell_cmd_part or "dumpsys gpu" in actual_shell_cmd_part or \
                   "dumpsys gfxinfo" in actual_shell_cmd_part or "dumpsys SurfaceFlinger" in actual_shell_cmd_part:
                    process_timeout = 300 

                result = subprocess.run(device_shell_cmd_to_run, shell=True, capture_output=True, text=True, timeout=process_timeout, check=False, encoding='utf-8', errors='replace')
                
                file_mode = "a" if redirect_op == ">>" else "w"
                try:
                    parent_dir = os.path.dirname(host_file_path)
                    if parent_dir: os.makedirs(parent_dir, exist_ok=True)
                    with open(host_file_path, file_mode, encoding="utf-8") as f: f.write(result.stdout)
                    
                    if result.returncode != 0:
                        TEST_LOGGER.warning(f"设备 {device_id}: 命令 \"{actual_shell_cmd_part}\" 以代码 {result.returncode} 退出，但stdout已写入 {host_file_path}. Stderr: {result.stderr.strip()}")
                    else:
                        TEST_LOGGER.info(f"设备 {device_id}: 命令 \"{actual_shell_cmd_part}\" stdout成功写入 {host_file_path}")
                except Exception as e_file_write:
                    TEST_LOGGER.error(f"设备 {device_id}: 写入文件 {host_file_path} 时出错: {e_file_write}")
            except Exception as e_generic_capture:
                TEST_LOGGER.error(f"设备 {device_id}: 执行stdout捕获命令 \"{actual_shell_cmd_part}\" 时出错: {e_generic_capture}", exc_info=True)

        else: 
            # 【优化核心】移除错误的检查，为 dumpheap 和 pull hprof 分配正确的超时
            try:
                timeout = 60  # 默认超时时间
                if "am dumpheap" in cmd:
                    timeout = 600  # 延长 dumpheap 的超时为 10 分钟
                    TEST_LOGGER.info(f"设备 {device_id}: 检测到 dumpheap 命令，使用长超时 {timeout}s")
                elif "pull" in cmd and ".hprof" in cmd:
                    timeout = 600  # 延长拉取 hprof 文件的超时为 10 分钟
                    TEST_LOGGER.info(f"设备 {device_id}: 检测到拉取 hprof 命令，使用长超时 {timeout}s")

                TEST_LOGGER.info(f"设备 {device_id} 执行直接命令: {cmd}")
                subprocess.run(cmd, shell=True, check=True, timeout=timeout) 
                TEST_LOGGER.info(f"设备 {device_id} 执行命令成功: {cmd}")

            except subprocess.CalledProcessError as e:
                TEST_LOGGER.error(f"设备 {device_id} 执行命令失败: {cmd}, 错误: {e.stderr or e.stdout or e}")
            except subprocess.TimeoutExpired as e_timeout: 
                TEST_LOGGER.error(f"设备 {device_id} 执行命令超时 ({timeout}s): {cmd}, 错误: {e_timeout}")
            except Exception as e_generic: 
                TEST_LOGGER.error(f"设备 {device_id} 执行命令时发生未知错误: {cmd}, 错误: {e_generic}", exc_info=True)
    
    # 注意：这个时间戳更新现在只对常规命令批次有效，hprof_dump_batch的更新在其调用处
    if batch_name != "hprof_dump_batch":
        device_key = f"{device_id}_{batch_name}"
        last_execution_times[device_key] = time.time()
    
    TEST_LOGGER.info(f"设备 {device_id} 完成 {batch_name} 批次命令提交/执行")
    return True

def should_execute_batch(device_id, batch_name):
    """检查是否应该执行特定批次的命令"""
    device_key = f"{device_id}_{batch_name}"
    current_time = time.time()
    
    if device_key not in last_execution_times or \
        (current_time - last_execution_times[device_key]) >= BATCH_INTERVALS[batch_name]:
        return True
    return False

# 【新增】触发 hprof dump 的可复用函数
def _resolve_system_server_pid(device_id):
    "返回 system_server 的 pid 字符串；取不到返回 None。"
    try:
        result = subprocess.run(f"adb -s {device_id} shell pidof {SYSTEM_SERVER_PROC_NAME}",
                                shell=True, capture_output=True, text=True, timeout=30,
                                encoding="utf-8", errors="replace")
        for token in (result.stdout or "").split():
            if token.isdigit():
                return token
    except Exception as e:
        TEST_LOGGER.error(f"设备 {device_id}: 解析 system_server pid 失败: {e}")
    return None


def _trigger_hprof_dump(device_id, log_path, reason, target_package=SYSTEM_SERVER_PROC_NAME, ignore_cooldown=False):
    """
    条件触发式 hprof dump。v5 流程：dumpheap → pull 到主机本地暂存 → 删除设备侧文件 → 再镜像拷贝到 15.4。
    这样即使 15.4（被别人写到 98% 满、soft 挂载）掉线或写满，关键堆也不会丢。
    """
    current_time = time.time()
    cooldown_key = f"{device_id}_{target_package}"
    cooldown_seconds = SYSTEM_SERVER_DUMP_COOLDOWN_SECONDS if target_package == SYSTEM_SERVER_PROC_NAME else HPROF_DUMP_COOLDOWN_SECONDS

    if not ignore_cooldown and (current_time - last_hprof_dump_times.get(cooldown_key, 0)) < cooldown_seconds:
        TEST_LOGGER.info(f"设备 {device_id}: [{target_package}] 处于hprof dump冷却期，跳过本次触发。距上次触发: {int(current_time - last_hprof_dump_times.get(cooldown_key, 0))}秒。")
        return

    # 本地暂存目录：/home/android/memleak_local/<构建目录>/<序列号>/（主机盘 ~210GB 空闲）
    base_folder = os.path.basename(os.path.dirname(log_path.rstrip("/\"/"))) or "unknown_build"
    staging_dir = os.path.join(LOCAL_HPROF_STAGING_ROOT, base_folder, device_id)
    try:
        os.makedirs(staging_dir, exist_ok=True)
        os.makedirs(log_path, exist_ok=True)
        local_free_gb = shutil.disk_usage(staging_dir).free / (1024 ** 3)
        share_free_gb = shutil.disk_usage(log_path).free / (1024 ** 3)
    except OSError as e:
        TEST_LOGGER.error(f"设备 {device_id}: 无法准备产物目录({e})，跳过 dump。")
        return

    if local_free_gb < LOCAL_MIN_FREE_GB:
        TEST_LOGGER.error(f"设备 {device_id}: DUMP_SKIPPED_DISK 本地剩余 {local_free_gb:.1f}GB < {LOCAL_MIN_FREE_GB}GB，跳过 dump。原因: [{reason}]")
        return
    if share_free_gb < MIRROR_MIN_FREE_GB:
        TEST_LOGGER.warn(f"设备 {device_id}: SHARE_LOW_SKIP_COPY 15.4 剩余 {share_free_gb:.1f}GB < {MIRROR_MIN_FREE_GB}GB，本次只保留本地镜像。原因: [{reason}]")

    TEST_LOGGER.warning(f"设备 {device_id}: 触发 hprof dump，原因: [{reason}]（本地剩余 {local_free_gb:.1f}GB / 15.4 剩余 {share_free_gb:.1f}GB）...")

    safe_pkg = re.sub(r"[^\w.-]", "_", target_package)
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
    hprof_filename = f"leak_{safe_pkg}_{timestamp}.hprof"
    remote_hprof_path = f"/data/local/tmp/{hprof_filename}"
    staging_path = os.path.join(staging_dir, hprof_filename)
    share_path = os.path.join(log_path, hprof_filename)

    dump_target = target_package
    if target_package == SYSTEM_SERVER_PROC_NAME:
        pid = _resolve_system_server_pid(device_id)
        if not pid:
            TEST_LOGGER.error(f"设备 {device_id}: 未能解析 system_server pid，跳过 dump。原因: [{reason}]")
            return
        dump_target = pid
        TEST_LOGGER.info(f"设备 {device_id}: system_server pid={pid}，使用 am dumpheap <pid> 形态")

    dump_commands = [
        f"adb -s {device_id} shell am dumpheap {dump_target} {remote_hprof_path}",
        f"adb -s {device_id} pull {remote_hprof_path} \"{staging_path}\"",
        f"adb -s {device_id} shell rm {remote_hprof_path}"
    ]

    execute_commands(device_id, dump_commands, "hprof_dump_batch")
    last_hprof_dump_times[cooldown_key] = current_time

    # 镜像到 15.4（失败不影响本地留存）
    if share_free_gb < MIRROR_MIN_FREE_GB:
        TEST_LOGGER.warn(f"设备 {device_id}: 已跳过共享盘拷贝，样本仅存本地: {staging_path}")
        return
    # 注意：CIFS(smb) 挂载常不允许 chmod/utimes，用 copy2 会抛 Errno 1 但数据其实已写完，
    # 因此这里只拷数据、忽略元数据失败，并做大小一致性校验（文件名本身已含时间戳）。
    try:
        shutil.copyfile(staging_path, share_path)
        try:
            shutil.copystat(staging_path, share_path)
        except OSError:
            TEST_LOGGER.debug(f"设备 {device_id}: 共享盘不允许保留文件元数据，已忽略（不影响数据）")
        src_mb = os.path.getsize(staging_path) / 1048576.0
        dst_mb = os.path.getsize(share_path) / 1048576.0
        if abs(src_mb - dst_mb) > 0.01:
            TEST_LOGGER.error(f"设备 {device_id}: MIRROR_SIZE_MISMATCH 本地 {src_mb:.1f}MB ≠ 15.4 {dst_mb:.1f}MB；以本地为准 {staging_path}")
        else:
            TEST_LOGGER.info(f"设备 {device_id}: hprof 已镜像到 15.4（{dst_mb:.1f}MB，与本地一致）: {share_path}")
    except (OSError, shutil.Error) as e:
        TEST_LOGGER.error(f"设备 {device_id}: MIRROR_FAILED_TO_SHARE 拷贝到 15.4 失败: {e}；本地留存 {staging_path}")


DALVIK_HEAP_ROW = re.compile(r"^\s*Dalvik Heap\s+(.*)$")


def _read_dalvik_heap_kb(device_id, meminfo_name=SYSTEM_SERVER_MEMINFO_NAME):
    """从 dumpsys meminfo <proc> 解析 Dalvik Heap 行；取 Pss Total 与 Rss Total 的较大值(KB)。"""
    try:
        result = subprocess.run(f"adb -s {device_id} shell dumpsys meminfo {meminfo_name}",
                                shell=True, capture_output=True, text=True, timeout=45,
                                encoding="utf-8", errors="replace")
    except Exception as e:
        TEST_LOGGER.debug(f"设备 {device_id}: 读取 system 堆失败: {e}")
        return None
    for line in (result.stdout or "").splitlines():
        m = DALVIK_HEAP_ROW.match(line)
        if not m:
            continue
        nums = [int(t.replace(",", "")) for t in re.findall(r"\d[\d,]*", m.group(1))]
        if not nums:
            return None
        pss = nums[0]
        rss = nums[4] if len(nums) >= 5 else pss   # 表头: PssTotal/PrivateDirty/PrivateClean/SwapPss/RssTotal/...
        return max(pss, rss)
    return None


def _read_target_heap_kb(device_id, prop="dalvik.vm.heapsize", fallback=None, _cache={}):
    """堆上限 prop（system 用 heapsize=512m；launcher 用 heapgrowthlimit，读不到回退 fallback/512MB）。"""
    key=(device_id,prop)
    if key in _cache:
        return _cache[key]
    kb = SS_TARGET_HEAP_FALLBACK_KB if fallback is None else fallback
    try:
        result = subprocess.run(f"adb -s {device_id} shell getprop {prop}",
                                shell=True, capture_output=True, text=True, timeout=20,
                                encoding="utf-8", errors="replace")
        m = re.search(r"(\d+)\s*([mg])", (result.stdout or "").strip(), re.I)
        if m:
            val = int(m.group(1))
            kb = val * 1024 * 1024 if m.group(2).lower() == "g" else val * 1024
    except Exception:
        pass
    _cache[key] = kb
    return kb


def _scan_logcat_early_signal(device_id):
    """崩溃前的 ART/AMS 早期信号（只取最近 400 行，成本很低）。"""
    try:
        result = subprocess.run(f"adb -s {device_id} shell logcat -d -b main,system -v brief -t 400",
                                shell=True, capture_output=True, text=True, timeout=30,
                                encoding="utf-8", errors="replace")
        m = LOGCAT_EARLY_SIGNAL_PATTERN.search(result.stdout or "")
        return m.group(0) if m else None
    except Exception:
        return None


def _append_heap_series(device_id, log_path, heap_kb, target_kb, level, early,
                        filename=HEAP_SERIES_FILENAME):
    """B) 落一行堆时序：时间 | heap | 占比 | 上限 | 档位 | 是否盯防 | 早期信号。"""
    now = time.time()
    ck=(device_id,filename)
    if now - heap_series_last_write.get(ck, 0) < HEAP_SERIES_MIN_INTERVAL:
        return
    heap_series_last_write[ck] = now
    try:
        os.makedirs(log_path, exist_ok=True)
        line = "%s | heap=%dMB | pct=%.1f%% | target=%dMB | level=L%d | hot=%d%s" % (
            datetime.now().strftime("%Y-%m-%d %H:%M:%S"), heap_kb // 1024, 100.0 * heap_kb / target_kb,
            target_kb // 1024, level, 1 if device_id in HOT_DEVICE_SERIALS else 0,
            (" | early=%s" % early) if early else "")
        with open(os.path.join(log_path, filename), "a", encoding="utf-8") as fh:
            fh.write(line + "\n")
    except OSError as e:
        TEST_LOGGER.error(f"设备 {device_id}: 写入 {filename} 失败: {e}")


def check_launcher_heap(device_id, log_path, pkg=LAUNCHER_PKG):
    """v7/v8: 应用堆占比分档（launcher3 及 systemui/settings 同判据（与 system_server 同档 85/95，上穿各抓一次，<35% 复位；
    独立时序 meminfo_heap_launcher.txt；早期信号仅 ≥60% 补抓；RSS≥976MB 独立触发在 check_for_memory_leaks）。"""
    heap_kb = _read_dalvik_heap_kb(device_id, pkg)
    if not heap_kb:
        return
    target_kb = _read_target_heap_kb(device_id, "dalvik.vm.heapgrowthlimit")
    ratio = heap_kb / float(target_kb)
    series_file = HEAP_SERIES_LAUNCHER_FILENAME if pkg == LAUNCHER_PKG else APP_HEAP_SERIES_MULTI_FILENAME
    label = "launcher3" if pkg == LAUNCHER_PKG else pkg
    if pkg == LAUNCHER_PKG:
        prev = la_heap_level.get(device_id, 0)
    else:
        prev = app_heap_level.get((device_id, pkg), 0)
    if ratio < SS_LEVEL_RESET_RATIO:
        if prev:
            TEST_LOGGER.info(f"设备 {device_id}: {label} 堆回落至 {ratio:.0%}（{heap_kb / 1024:.0f}MB），档位复位")
        if pkg == LAUNCHER_PKG:
            la_heap_level[device_id] = 0
        else:
            app_heap_level[(device_id, pkg)] = 0
        _append_heap_series(device_id, log_path, heap_kb, target_kb, 0, None,
                            series_file)
        return
    level = 0
    for lv, th in SS_HEAP_LEVELS:
        if ratio >= th:
            level = lv
    headroom_mb = (target_kb - heap_kb) / 1024.0
    early = _scan_logcat_early_signal(device_id)
    _append_heap_series(device_id, log_path, heap_kb, target_kb, level, early,
                        series_file)
    if ratio >= 0.75:
        ss_hot_devices.add(device_id)
    if level > prev:
        if pkg == LAUNCHER_PKG:
            la_heap_level[device_id] = level
        else:
            app_heap_level[(device_id, pkg)] = level
        ss_hot_devices.add(device_id)
        reason = (f"{label} 堆占比 {ratio:.0%} 上穿 L{level}"
                  f"（Dalvik Heap={heap_kb / 1024:.0f}MB / 上限 {target_kb / 1024:.0f}MB，剩余 {headroom_mb:.0f}MB 即 OOM）")
        _trigger_hprof_dump(device_id, log_path, reason,
                            target_package=pkg, ignore_cooldown=True)
        return
    if early and ratio >= LAUNCHER_EARLY_MIN_RATIO:
        key = f"{device_id}_{pkg}"
        since = time.time() - last_hprof_dump_times.get(key, 0)
        if since >= HPROF_DUMP_COOLDOWN_SECONDS:
            _trigger_hprof_dump(device_id, log_path,
                                f"{label} 早期信号[{early}]（堆占比 {ratio:.0%}，剩余 {headroom_mb:.0f}MB）补抓",
                                target_package=pkg)


def check_system_server_heap(device_id, log_path):
    """v5 主判据：按堆占比分档，上穿即抓一次；堆回落 <40% 复位。"""
    heap_kb = _read_dalvik_heap_kb(device_id)
    if not heap_kb:
        return
    target_kb = _read_target_heap_kb(device_id)
    ratio = heap_kb / float(target_kb)
    prev = ss_heap_level.get(device_id, 0)
    is_hot = device_id in HOT_DEVICE_SERIALS

    if ratio < SS_LEVEL_RESET_RATIO:
        if prev:
            TEST_LOGGER.info(f"设备 {device_id}: system_server 堆回落至 {ratio:.0%}（{heap_kb / 1024:.0f}MB），档位复位")
        ss_heap_level[device_id] = 0
        if is_hot:
            ss_hot_devices.add(device_id)      # A) 名单内设备无条件常驻 30 秒盯防（含冷启动）
        else:
            ss_hot_devices.discard(device_id)
        _append_heap_series(device_id, log_path, heap_kb, target_kb, 0, None)
        return

    level = 0
    for lv, th in SS_HEAP_LEVELS:
        if ratio >= th:
            level = lv

    headroom_mb = (target_kb - heap_kb) / 1024.0
    early = _scan_logcat_early_signal(device_id)
    _append_heap_series(device_id, log_path, heap_kb, target_kb, level, early)
    if is_hot or ratio >= 0.75:   # v6: 接近爬坡区提前进入 30s 加密轮询，避免 5min 采样跨档漏抓
        ss_hot_devices.add(device_id)
    if level > prev:
        ss_heap_level[device_id] = level
        ss_hot_devices.add(device_id)
        reason = (f"system_server 堆占比 {ratio:.0%} 上穿 L{level}"
                  f"（Dalvik Heap={heap_kb / 1024:.0f}MB / 上限 {target_kb / 1024:.0f}MB，剩余 {headroom_mb:.0f}MB 即 OOM）")
        _trigger_hprof_dump(device_id, log_path, reason, target_package=SYSTEM_SERVER_PROC_NAME, ignore_cooldown=True)
        return

    ss_hot_devices.add(device_id)
    if early:
        key = f"{device_id}_{SYSTEM_SERVER_PROC_NAME}"
        since = time.time() - last_hprof_dump_times.get(key, 0)
        if since >= SS_EARLY_SIGNAL_MIN_INTERVAL:
            _trigger_hprof_dump(device_id, log_path,
                                f"system_server 早期信号[{early}]（堆占比 {ratio:.0%}，剩余 {headroom_mb:.0f}MB）补抓",
                                target_package=SYSTEM_SERVER_PROC_NAME, ignore_cooldown=True)
        return

    if ratio >= 0.55:
        TEST_LOGGER.debug(f"设备 {device_id}: system_server 堆 {ratio:.0%}，仍处于 L{prev}，等待上穿下一档")

def check_for_memory_leaks(device_id, log_path):
    """监控 system_server、launcher3、systemui、settings（v8）：堆占比分级 + RSS 超阈值。

    其余应用仍不监控。launcher 上限按 heapgrowthlimit，若其为 largeHeap 会偏保守（提前触发，不漏抓）。
    """
    ss_over_threshold = []
    ss_rss_kb = None
    la_over_threshold = []
    la_rss_kb = None
    app_rss = {}                    # v8: pkg -> RSS(KB)，含 launcher3/systemui/settings
    app_over = []                   # v8: [(pkg, rss_kb)] 超阈值者
    try:
        meminfo_cmd = f"adb -s {device_id} shell dumpsys meminfo"
        result = subprocess.run(meminfo_cmd, shell=True, capture_output=True, text=True, timeout=60, check=True, encoding='utf-8', errors='replace')
        meminfo_output = result.stdout

        rss_section_start = meminfo_output.find("Total RSS by process:")
        if rss_section_start == -1:
            TEST_LOGGER.warning(f"设备 {device_id}: 在dumpsys meminfo输出中未找到 'Total RSS by process' 部分。")
        else:
            for line in meminfo_output[rss_section_start:].splitlines()[1:]:
                if not line.strip() or line.startswith("Total "):
                    break  # 段落结束，后面的内容不属于 by process
                match = MEMINFO_RSS_PATTERN.search(line)
                if not match:
                    continue
                pname = match.group(2)
                if pname == SYSTEM_SERVER_MEMINFO_NAME:
                    try:
                        ss_rss_kb = int(match.group(1).replace(',', ''))
                    except ValueError:
                        continue
                    if ss_rss_kb >= SYSTEM_SERVER_RSS_DUMP_THRESHOLD_KB:
                        ss_over_threshold.append((SYSTEM_SERVER_PROC_NAME, ss_rss_kb))
                elif pname in (LAUNCHER_PKG, SYSTEMUI_PKG, SETTINGS_PKG):
                    try:
                        rss_kb = int(match.group(1).replace(',', ''))
                    except ValueError:
                        continue
                    app_rss[pname] = rss_kb
                    if pname == LAUNCHER_PKG:
                        la_rss_kb = rss_kb
                        if rss_kb >= LAUNCHER_RSS_DUMP_THRESHOLD_KB:
                            la_over_threshold.append((LAUNCHER_PKG, rss_kb))
                    elif rss_kb >= LAUNCHER_RSS_DUMP_THRESHOLD_KB:   # v8: systemui/settings 同 976MB 档
                        app_over.append((pname, rss_kb))
                else:
                    continue
                if ss_rss_kb is not None and len(app_rss) == 3:
                    break

    except subprocess.TimeoutExpired:
        TEST_LOGGER.warning(f"设备 {device_id}: dumpsys meminfo 命令执行超时。")
    except Exception as e:
        TEST_LOGGER.error(f"设备 {device_id}: 检查dumpsys meminfo时出错: {e}")

    if ss_rss_kb is not None:
        # 只留 system_server 的 RSS 时序，不记录应用 Top5
        try:
            stamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            os.makedirs(log_path, exist_ok=True)
            with open(os.path.join(log_path, "meminfo_rss_top.txt"), "a", encoding="utf-8") as f:
                f.write(f"{stamp} | system={ss_rss_kb / 1024:.1f}MB"
                        + (f"; launcher={la_rss_kb / 1024:.1f}MB" if la_rss_kb is not None else "")
                        + "".join(f"; {p.split('.')[-1]}={kb / 1024:.1f}MB"
                                  for p, kb in sorted(app_rss.items())
                                  if p not in (LAUNCHER_PKG,)) + "\n")
        except OSError as e:
            TEST_LOGGER.error(f"设备 {device_id}: 写入 meminfo_rss_top.txt 失败: {e}")

    check_system_server_heap(device_id, log_path)   # system_server 堆占比分级
    check_launcher_heap(device_id, log_path)        # v7: launcher3 堆占比分级
    for _pkg in APP_EXTRA_PKGS:                     # v8: systemui/settings 同判据堆分级
        check_launcher_heap(device_id, log_path, pkg=_pkg)

    if ss_over_threshold:
        ss_pkg, ss_kb = max(ss_over_threshold, key=lambda x: x[1])
        _trigger_hprof_dump(device_id, log_path,
                            f"system_server 内存超阈值: RSS={ss_kb / 1024:.1f}MB (>= {SYSTEM_SERVER_RSS_DUMP_THRESHOLD_KB // 1024}MB)",
                            target_package=SYSTEM_SERVER_PROC_NAME)

    if la_over_threshold:
        la_pkg, la_kb = max(la_over_threshold, key=lambda x: x[1])
        _trigger_hprof_dump(device_id, log_path,
                            f"launcher3 内存超阈值: RSS={la_kb / 1024:.1f}MB (>= {LAUNCHER_RSS_DUMP_THRESHOLD_KB // 1024}MB)",
                            target_package=LAUNCHER_PKG)

    for _pkg, _kb in app_over:                      # v8: systemui/settings RSS 超阈值触发
        _trigger_hprof_dump(device_id, log_path,
                            f"{_pkg} 内存超阈值: RSS={_kb / 1024:.1f}MB (>= {LAUNCHER_RSS_DUMP_THRESHOLD_KB // 1024}MB)",
                            target_package=_pkg)


def _adb_shell_quiet(device_id, cmd, timeout=30):
    """执行设备 shell，返回 (rc, stdout)；不抛异常。"""
    try:
        # 必须用 list 传参：cmd 含 | ; & 等元字符时，走本地 shell 会被宿主解释
        result = subprocess.run(["adb", "-s", device_id, "shell", cmd],
                                capture_output=True, text=True, timeout=timeout,
                                encoding="utf-8", errors="replace")
        return result.returncode, (result.stdout or "").strip()
    except subprocess.TimeoutExpired:
        return 124, "timeout"
    except Exception as e:
        TEST_LOGGER.error("设备 %s: adb shell 执行失败: %s" % (device_id, e))
        return 1, ""


def _monkey_ps_state(device_id):
    """返回 (monkey_alive, watchdog_alive)。watchdog 的 cmdline 也含 monkey，需排除。"""
    rc, out = _adb_shell_quiet(device_id,
                              "ps -ef | grep com.android.commands.monkey | grep -v grep",
                              MONKEY_PS_TIMEOUT)
    monkey_alive = rc == 0 and any("MonkeyWatchdog" not in l and l.strip() for l in out.splitlines())
    rc2, out2 = _adb_shell_quiet(device_id,
                                "ps -ef | grep -E 'MonkeyTest.sh|MonkeyWatchdog' | grep -v grep",
                                MONKEY_PS_TIMEOUT)
    watchdog_alive = rc2 == 0 and any(l.strip() for l in out2.splitlines())
    return monkey_alive, watchdog_alive


def _monkey_local_path(name):
    return name if os.path.isabs(name) else os.path.join(AIMONKEY_DIR, name)


def _monkey_missing(device_id):
    """一次 adb 调用列出设备端缺失的资源；返回 (arch, missing_remote_paths)。"""
    rc, abi = _adb_shell_quiet(device_id, "getprop ro.product.cpu.abi", MONKEY_PS_TIMEOUT)
    arch = "arm64-v8a" if abi.strip().startswith("arm64") else "armeabi-v7a"
    files = " ".join(remote for _n, remote, _m in MONKEY_PUSH_FILES)
    arch_dir = MONKEY_ARCH_DIRS[arch]
    cmd = ("for f in %s; do [ -f \"$f\" ] || echo MISSING:$f; done; "
           "for d in %s; do [ -d \"$d\" ] || echo MISSING:$d; done" % (files, arch_dir))
    rc, out = _adb_shell_quiet(device_id, cmd, 25)
    missing = [l.strip().split(":", 1)[1] for l in out.splitlines()
               if l.strip().startswith("MISSING:") and ":" in l]
    return arch, missing


def _monkey_push(device_id, local_path, remote_path, mode):
    """推送单个文件；返回 True/False。"""
    if not os.path.exists(local_path):
        TEST_LOGGER.error("设备 %s: monkey 资源不存在: %s" % (device_id, local_path))
        return False
    try:
        result = subprocess.run(["adb", "-s", device_id, "push", local_path, remote_path],
                                capture_output=True, text=True, timeout=MONKEY_PUSH_TIMEOUT)
    except Exception as e:
        TEST_LOGGER.error("设备 %s: 推送 %s 失败: %s" % (device_id, local_path, e))
        return False
    if result.returncode != 0:
        TEST_LOGGER.error("设备 %s: 推送 %s 失败: %s" % (device_id, local_path,
                                                        (result.stderr or "").strip()[:200]))
        return False
    _adb_shell_quiet(device_id, "chmod %s %s" % (mode, remote_path), MONKEY_PS_TIMEOUT)
    return True


def _ensure_monkey_resources(device_id):
    """缺什么推什么（不覆盖正在运行的二进制）；返回推送计数。"""
    arch, missing = _monkey_missing(device_id)
    if not missing:
        return 0
    pushed = 0
    for name, remote, mode in MONKEY_PUSH_FILES:
        if remote not in missing:
            continue
        if _monkey_push(device_id, _monkey_local_path(name), remote, mode):
            pushed += 1
    arch_remote = MONKEY_ARCH_DIRS[arch]
    if arch_remote in missing:
        local_dir = os.path.join(AIMONKEY_DIR, arch)
        if os.path.isdir(local_dir):
            try:
                result = subprocess.run(["adb", "-s", device_id, "push", local_dir, "/data/local/tmp/"],
                                        capture_output=True, text=True, timeout=MONKEY_PUSH_TIMEOUT)
                if result.returncode == 0:
                    pushed += 1
                else:
                    TEST_LOGGER.error("设备 %s: 推送架构库 %s 失败" % (device_id, arch))
            except Exception as e:
                TEST_LOGGER.error("设备 %s: 推送架构库 %s 失败: %s" % (device_id, arch, e))
    return pushed


def _load_screen_off_map():
    try:
        with open(MONKEY_SCREEN_OFF_STORE, encoding="utf-8") as fh:
            return json.load(fh)
    except Exception:
        return {}


def _save_screen_off_map(mapping):
    try:
        with open(MONKEY_SCREEN_OFF_STORE, "w", encoding="utf-8") as fh:
            json.dump(mapping, fh)
    except OSError as e:
        TEST_LOGGER.error("写入 %s 失败: %s" % (MONKEY_SCREEN_OFF_STORE, e))


def _remember_screen_off(device_id):
    """记录设备原始息屏超时，供收尾恢复。"""
    mapping = _load_screen_off_map()
    if device_id in mapping:
        return
    rc, out = _adb_shell_quiet(device_id, "settings get system screen_off_timeout", MONKEY_PS_TIMEOUT)
    value = out.strip()
    if value.isdigit():
        mapping[device_id] = value
        _save_screen_off_map(mapping)


def _start_monkey(device_id):
    """启动 MonkeyTest.sh（内含 aim 拉起与自恢复循环）+ aimwd 看门狗，并轮询验证。"""
    _adb_shell_quiet(device_id, "settings put system screen_off_timeout 1999999999", MONKEY_PS_TIMEOUT)
    _adb_shell_quiet(device_id, "aee -m 3; aee -d 99", 25)
    _adb_shell_quiet(device_id,
                     "cd /data/local/tmp; nohup sh /data/local/tmp/MonkeyTest.sh >/dev/null 2>&1 &",
                     30)
    _adb_shell_quiet(device_id, "nohup /data/local/tmp/aimwd >/dev/null 2>&1 &", 20)
    deadline = time.time() + MONKEY_START_VERIFY_TIMEOUT
    while time.time() < deadline:
        monkey_alive, watchdog_alive = _monkey_ps_state(device_id)
        if monkey_alive and watchdog_alive:
            return True
        time.sleep(3)
    return False


def _monkey_patrol(device_id, log_path):
    """每轮巡检：补资源 → 双亡才重启 → 落状态行。"""
    if not MONKEY_ENABLED:
        return
    try:
        pushed = _ensure_monkey_resources(device_id)
        monkey_alive, watchdog_alive = _monkey_ps_state(device_id)
        action = "ok"
        if not monkey_alive and not watchdog_alive:
            _remember_screen_off(device_id)
            action = "restarted" if _start_monkey(device_id) else "start_failed"
        elif not monkey_alive:
            action = "watchdog_only"
        line = ("%s | monkey=%d watchdog=%d pushed=%d action=%s"
                % (datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
                   int(monkey_alive), int(watchdog_alive), pushed, action))
        try:
            os.makedirs(log_path, exist_ok=True)
            with open(os.path.join(log_path, "monkey_status.txt"), "a", encoding="utf-8") as fh:
                fh.write(line + "\n")
        except OSError as e:
            TEST_LOGGER.error("设备 %s: 写入 monkey_status.txt 失败: %s" % (device_id, e))
        if action != "ok":
            TEST_LOGGER.info("设备 %s: monkey 巡检 %s" % (device_id, line))
    except Exception as e:
        TEST_LOGGER.error("设备 %s: monkey 巡检异常: %s" % (device_id, e))


def _teardown_monkey_device(device_id):
    """停 monkey + 清理设备端资源 + 恢复息屏超时。"""
    _adb_shell_quiet(device_id, "pkill -f com.android.commands.monkey", 20)
    _adb_shell_quiet(device_id, "pkill -f MonkeyTest.sh", 20)
    _adb_shell_quiet(device_id, "rm -rf " + " ".join(MONKEY_CLEAN_PATHS), 60)
    value = _load_screen_off_map().get(device_id)
    if value:
        _adb_shell_quiet(device_id, "settings put system screen_off_timeout %s" % value,
                         MONKEY_PS_TIMEOUT)


def _teardown_all_monkey():
    """脚本退出（SIGTERM/正常结束/异常）时收尾：停 monkey 并清理设备端。"""
    if not MONKEY_ENABLED:
        return
    devices = list(active_devices)
    if not devices:
        return
    TEST_LOGGER.info("收尾：停止 %d 台设备上的 monkey 并清理设备端资源" % len(devices))
    try:
        with ThreadPoolExecutor(max_workers=8) as executor:
            list(executor.map(_teardown_monkey_device, devices))
    except Exception as e:
        TEST_LOGGER.error("monkey 收尾异常: %s" % e)
    try:
        os.remove(MONKEY_SCREEN_OFF_STORE)
    except OSError:
        pass
    TEST_LOGGER.info("monkey 收尾完成")


def _handle_termination(signum, frame):
    """SIGTERM/SIGINT：抛 SystemExit 触发 finally 里的 monkey 收尾。"""
    raise SystemExit(128 + signum)

def collect_device_logs(device_id, final_log_path_for_this_device): # MODIFIED SIGNATURE
    """【优化后】收集单个设备的日志，按批次执行。日志存储在 final_log_path_for_this_device 中。"""
    try:
        device_log_dir = final_log_path_for_this_device
        
        batch_commands = {
            "batch_leak_check": [],
            "batch_monkey": [], 
            "batch_7s": [],
            "batch_1min": [],
            "batch_2min": [],
            # batch_5min 已移除：不再采集 systemui meminfo，只监控 system_server
            "batch_10min": [],
            "batch_15min": [],
            # batch_30min 已整体移除：不再 pull /data/debuglogger/mobilelog、/data/aee_exp、/data/vendor/aee_exp，
            # 也不再 cat db_history。本次任务只监控 meminfo，hprof 仅在命中阈值时按需导出。
        }
        
        executed_batches = []
        
        # 优化核心：循环遍历所有批次，确保逻辑独立
        for batch_name, commands_in_batch in batch_commands.items():
            
            # 1. 检查当前批次是否到了执行时间
            if not should_execute_batch(device_id, batch_name):
                continue # 如果时间未到，直接跳过此批次，检查下一个

            TEST_LOGGER.info(f"设备 {device_id}: 批次 '{batch_name}' 已到执行时间，开始处理...")
            
            # 2. 根据批次名称执行特定操作
            # --- 特殊逻辑处理区 ---
            if batch_name == "batch_leak_check":
                check_for_memory_leaks(device_id, device_log_dir)

            if batch_name == "batch_monkey":
                _monkey_patrol(device_id, device_log_dir)
            

            # --- 常规命令处理区 ---
            else:
                if commands_in_batch:
                    # 为追加写入的文件添加时间戳分隔符
                    for cmd_str in commands_in_batch:
                        match = STDOUT_REDIRECT_PATTERN.match(cmd_str)
                        if match and match.group('redirect_op') == ">>":
                            host_file_path = match.group('host_path').strip()
                            try:
                                parent_dir = os.path.dirname(host_file_path)
                                if parent_dir:
                                    os.makedirs(parent_dir, exist_ok=True)
                                with open(host_file_path, "a", encoding="utf-8") as f:
                                    timestamp_sep = datetime.now().strftime("%Y-%m-%d_%H-%M-%S")
                                    shell_cmd_part_for_sep = match.group('shell_cmd_part').strip()
                                    f.write(f"\n\n{'='*50}\n{timestamp_sep} - {batch_name} - CMD: {shell_cmd_part_for_sep}\n{'='*50}\n\n")
                            except Exception as e:
                                TEST_LOGGER.error(f"设备 {device_id} 添加时间戳分隔符失败: {host_file_path}, 错误: {e}")
                    
                    # 执行常规命令
                    execute_commands(device_id, commands_in_batch, batch_name)

            # 3. 统一更新状态
            # 注意：execute_commands内部已经更新了时间戳，这里为没有命令的特殊批次或确保所有批次都被记录
            last_execution_times[f"{device_id}_{batch_name}"] = time.time()
            executed_batches.append(batch_name)

        if executed_batches:
            TEST_LOGGER.info(f"设备 {device_id} 本次在目录 '{device_log_dir}' 成功处理了以下批次: {', '.join(executed_batches)}")
        else:
            TEST_LOGGER.info(f"设备 {device_id} 本次轮询在目录 '{device_log_dir}' 没有需要执行的批次")
            
        return True
    except Exception as e:
        log_path_info = final_log_path_for_this_device if 'final_log_path_for_this_device' in locals() and final_log_path_for_this_device else "未知路径"
        TEST_LOGGER.error(f"设备 {device_id} 在路径 '{log_path_info}' 的日志收集过程中发生严重错误: {e}", exc_info=True)
        return False

def collect_all_devices_logs():
    """收集所有设备的日志，并根据新的路径逻辑处理"""
    global active_devices 
    global last_device_check_time
    current_time = time.time()

    if (current_time - last_device_check_time) >= DEVICE_CHECK_INTERVAL or not active_devices:
        TEST_LOGGER.info("正在更新设备列表...")
        latest_devices_list = get_connected_devices()
        latest_devices_set = set(latest_devices_list)

        newly_added = latest_devices_set - active_devices
        removed = active_devices - latest_devices_set

        if newly_added:
            TEST_LOGGER.info(f"检测到新设备: {', '.join(newly_added)}")
            for device_id in newly_added:
                run_initial_setup_commands(device_id) 
        if removed:
            TEST_LOGGER.info(f"设备已移除/断开: {', '.join(removed)}")
        
        active_devices = latest_devices_set
        last_device_check_time = current_time
        
        if not active_devices:
            TEST_LOGGER.warning("没有找到连接的设备")
            return

    TEST_LOGGER.info(f"当前活跃设备 ({len(active_devices)}): {', '.join(sorted(list(active_devices)))}")
    
    if not active_devices:
        return

    device_to_base_folder_map = {}
    current_processing_devices = list(active_devices) 
    valid_devices_for_map = []

    for device_id in current_processing_devices:
        base_name = generate_device_log_folder_name_components(device_id) 
        if base_name:
            device_to_base_folder_map[device_id] = base_name
            valid_devices_for_map.append(device_id)
        else:
            TEST_LOGGER.error(f"设备 {device_id}: 无法为其生成基础动态文件夹名称，将跳过此设备的所有后续处理。")
            if device_id in active_devices:
                    active_devices.remove(device_id)

    if not device_to_base_folder_map:
        TEST_LOGGER.info("没有设备能成功生成基础文件夹名称。")
        return

    base_folder_name_counts = {}
    for base_folder_name in device_to_base_folder_map.values():
        base_folder_name_counts[base_folder_name] = base_folder_name_counts.get(base_folder_name, 0) + 1

    tasks_for_executor = []
    devices_successfully_prepared = set()

    for device_id, base_folder_name in device_to_base_folder_map.items():
        primary_log_folder = os.path.join(TARGET_FTP_LOG_ROOT_DIR, base_folder_name)
        
        # 与既有 sonic_tinno 目录一致：基础目录下恒定按设备序列号分子目录
        final_device_log_path = os.path.join(primary_log_folder, device_id)
        TEST_LOGGER.info(f"设备 {device_id}: 日志目录: {final_device_log_path}")
        
        try:
            os.makedirs(final_device_log_path, exist_ok=True)
            device_log_path_map[device_id] = final_device_log_path   # v5: 加密轮询复用
            tasks_for_executor.append({'device_id': device_id, 'log_path': final_device_log_path})
            devices_successfully_prepared.add(device_id)
        except OSError as e:
            TEST_LOGGER.error(f"设备 {device_id}: 创建最终日志目录 {final_device_log_path} 失败: {e}。跳过此设备。")
            if device_id in active_devices:
                active_devices.remove(device_id)
            continue 
    
    if not tasks_for_executor:
        TEST_LOGGER.info("没有为任何设备成功准备日志路径和任务。")
        return

    max_workers_val = min(8, len(tasks_for_executor))
    with ThreadPoolExecutor(max_workers=max_workers_val) as executor:
        futures = {
            executor.submit(collect_device_logs, task['device_id'], task['log_path']): task['device_id']
            for task in tasks_for_executor
        }
        for future in as_completed(futures):
            processed_device_id = futures[future]
            try:
                future.result() 
            except Exception as e:
                TEST_LOGGER.error(f"设备 {processed_device_id} 日志收集任务在线程池中异常: {e}", exc_info=True)


def main():
    TEST_LOGGER.info("GPU信息与内存泄漏监控脚本启动")
    signal.signal(signal.SIGTERM, _handle_termination)
    signal.signal(signal.SIGINT, _handle_termination)
    
    initial_devices_list = get_connected_devices()
    if not initial_devices_list:
        TEST_LOGGER.warning("启动时未检测到任何设备。脚本将继续运行并定期检查。")
    else:
        TEST_LOGGER.info(f"启动时检测到以下设备: {', '.join(initial_devices_list)}")
        for device_id in initial_devices_list:
            if device_id not in active_devices:
                run_initial_setup_commands(device_id) 
                active_devices.add(device_id) 
    global last_device_check_time
    last_device_check_time = time.time()


    try:
        while True:
            start_time = time.time()
            TEST_LOGGER.info(f"开始新一轮检查，时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
            
            collect_all_devices_logs()
            
            elapsed = time.time() - start_time
            wait_time = max(1, COLLECTION_INTERVAL - elapsed) 
            TEST_LOGGER.info(f"本轮检查完成，耗时: {elapsed:.2f}秒；等待窗口内对发热设备做 {SS_FAST_POLL_INTERVAL}s 堆加密轮询")
            deadline = time.time() + wait_time
            while time.time() < deadline:
                remain = deadline - time.time()
                if remain <= 0:
                    break
                time.sleep(min(SS_FAST_POLL_INTERVAL, remain))
                hot = [d for d in list(ss_hot_devices) if d in device_log_path_map]
                for d in hot:
                    try:
                        check_system_server_heap(d, device_log_path_map[d])
                        check_launcher_heap(d, device_log_path_map[d])
                        for _pkg in APP_EXTRA_PKGS:
                            check_launcher_heap(d, device_log_path_map[d], pkg=_pkg)
                    except Exception as e:
                        TEST_LOGGER.error(f"设备 {d}: 堆加密轮询异常: {e}")
    except KeyboardInterrupt:
        TEST_LOGGER.info("收到中断信号，脚本停止运行")
    except Exception as e:
        TEST_LOGGER.error(f"脚本主循环发生严重错误: {e}", exc_info=True)
        return 1
    finally:
        _teardown_all_monkey()
    
    return 0

if __name__ == "__main__":
    sys.exit(main())