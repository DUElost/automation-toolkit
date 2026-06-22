# -*- coding: utf-8 -*-

"""
一个用于监控安卓设备、导出AEE/Mobilelog日志并管理Monkey测试的综合脚本。
[修复版本] 解决了Linux环境下100%卡死的问题，提高了长期运行的稳定性。

主要修复内容：
1. 增强了异常处理和超时控制
2. 优化了线程池管理和资源清理
3. 添加了心跳监控和死锁检测
4. 改进了ADB命令的错误恢复机制
5. 增加了内存和资源监控
"""
from storage_filler import fill_device_storage_to_percentage
import json
import logging
import os
import platform
import re
import shutil
import shlex
import socket
import subprocess
import sys
import tempfile
import threading
import time
import signal
from concurrent.futures import ThreadPoolExecutor, as_completed, TimeoutError as FutureTimeoutError
from contextlib import contextmanager
from datetime import datetime, timedelta
import glob
import fnmatch

# 尝试导入psutil，如果不存在则使用简化的监控
try:
    import psutil
    HAS_PSUTIL = True
except ImportError:
    HAS_PSUTIL = False
    print("警告: psutil未安装，系统监控功能将被简化")

# 尝试导入pexpect，用于处理交互式挂载
try:
    import pexpect
    HAS_PEXPECT = True
except ImportError:
    HAS_PEXPECT = False
    print("警告: pexpect未安装，将使用备用挂载方式")

# --- 全局配置常量 ---
SCRIPT_BASE_DIR = os.path.dirname(os.path.abspath(__file__))
CONFIG_FILE_PATH = os.path.join(SCRIPT_BASE_DIR, "config.json")

# 检测操作系统
IS_WINDOWS = platform.system() == "Windows"


def _get_platform_path(base_dir, relative_path):
    """根据操作系统获取正确的路径"""
    if IS_WINDOWS:
        # Windows: 使用脚本所在目录作为基础
        return os.path.join(base_dir, relative_path.lstrip("/").replace("/", os.sep))
    else:
        # Linux: 使用绝对路径
        return relative_path


def _load_config():
    """从配置文件加载配置，如果文件不存在则使用默认值，并根据操作系统适配路径"""
    
    # Linux默认配置
    default_config = {
        "general": {
            "polling_interval_seconds": 180,
            "filter_db_logs_enabled": False,
            "enable_precise_mobilelog_scheme": True,
            "main_log_root_dir": "/home/android/sonic_agent/logs/ftp_log/sonic_tinno/",
            "main_log_root_dir_windows": ""  # Windows下为空则使用脚本目录
        },
        "mount": {"server_ip": "172.21.15.4", "timeout": 30, "retry_count": 3},
        "wifi": {"security": "wpa2"},
        "stability": {
            "max_thread_pool_workers": 8, "thread_timeout_seconds": 300,
            "heartbeat_interval": 30, "max_consecutive_failures": 5,
            "runtime_cache_persist_interval_seconds": 5,
            "adb_command_timeout": 30, "memory_threshold_mb": 1024
        },
        "aee_decrypt": {
            "tool_path": "/home/android/sonic_agent/logs/ftp_log/sonic_tinno/start_log_scan/tools/aee_extract/aee_extract",
            "tool_path_relative": "tools/aee_extract/aee_extract",  # Windows相对路径
            "enable_local_decrypt_scan": True, "limit_per_cycle": 30,
            "single_log_timeout": 300, "retry_limit": 2,
            "min_free_disk_space_gb": 10, "scan_recent_folders_limit": 20,
            "pull_retry_limit": 10
        },
        "scan_optimization": {
            "enable_cache": True, "enable_parallel_scan": True,
            "cache_timeout": 600, "parallel_workers": 5, "batch_check_size": 100,
            "task_timeout": 300, "find_timeout": 60, "enable_fast_path_filter": True,
            "max_depth": 3, "pre_scan_enabled": True
        },
        "node_coordination": {
            "enabled": True,
            "lock_dir": "/home/android/sonic_agent/logs/ftp_log/sonic_tinno/.node_locks",
            "lock_dir_relative": ".node_locks",  # Windows相对路径
            "lock_timeout": 300
        },
        "device_paths": {
            "aee_paths": ["/data/aee_exp/", "/data/vendor/aee_exp/"],
            "mobilelog_path": "/data/debuglogger/mobilelog/"
        },
        "bugreport": {
            "enabled": True, "dirname": "correlated_bugreports",
            "timeout_seconds": 600, "cooldown_seconds": 300,
            "cooldown_event_types": ["ANR", "CRASH"]
        },
        "monkey": {
            "process_name": "com.android.commands.monkey.transsion",
            "restart_command": "nohup /data/local/tmp/aim --pkg-blacklist-file /sdcard/blacklist.txt --smartuiautomator true --hprof --ignore-crashes --ignore-security-exceptions --ignore-timeouts --throttle 500 --runtime-minutes 10080 --switchuimode -v >/dev/null 2>&1 &",
            "dumpsys_command": "dumpsys activity appops on"
        },
        "mobilelog_filter": {"main_enabled": True, "kernel_enabled": True, "sys_enabled": False},
        "storage": {"fill_percentage": 60, "enable_fill_storage": True},
        "device_setup": {"enable_clear_logs_before_test": False},
        "cifs_protection": {
            "enabled": True,
            "probe_timeout": 10,
            "io_timeout": 10,
            "health_cache_ttl_seconds": 5,
            "enable_auto_remount": True,
            "max_stale_heartbeat_seconds": 600
        }
    }
    
    if os.path.exists(CONFIG_FILE_PATH):
        try:
            with open(CONFIG_FILE_PATH, 'r', encoding='utf-8') as f:
                file_config = json.load(f)
            # 深度合并配置
            for section, values in file_config.items():
                if section.startswith('_'):  # 跳过注释字段
                    continue
                if section in default_config and isinstance(values, dict):
                    # 过滤掉以_开头的注释字段
                    filtered_values = {k: v for k, v in values.items() if not k.startswith('_')}
                    default_config[section].update(filtered_values)
                else:
                    default_config[section] = values
            print(f"已从 {CONFIG_FILE_PATH} 加载配置")
        except Exception as e:
            print(f"警告: 加载配置文件失败，使用默认配置: {e}")
    else:
        print(f"配置文件 {CONFIG_FILE_PATH} 不存在，使用默认配置")
    
    # 根据操作系统适配路径
    _adapt_paths_for_platform(default_config)
    
    return default_config


def _adapt_paths_for_platform(config):
    """根据操作系统适配路径配置"""
    if IS_WINDOWS:
        print(f"检测到Windows系统，使用脚本目录作为基础路径: {SCRIPT_BASE_DIR}")
        
        # 主日志目录：优先使用配置的Windows路径，否则使用脚本目录
        windows_main_dir = config["general"].get("main_log_root_dir_windows", "")
        if windows_main_dir:
            config["general"]["main_log_root_dir"] = windows_main_dir
        else:
            config["general"]["main_log_root_dir"] = SCRIPT_BASE_DIR
        
        # AEE解密工具路径
        tool_relative = config["aee_decrypt"].get("tool_path_relative", "tools/aee_extract/aee_extract")
        config["aee_decrypt"]["tool_path"] = os.path.join(SCRIPT_BASE_DIR, tool_relative)
        
        # 节点锁目录
        lock_relative = config["node_coordination"].get("lock_dir_relative", ".node_locks")
        config["node_coordination"]["lock_dir"] = os.path.join(SCRIPT_BASE_DIR, lock_relative)
        
        # Windows下禁用某些Linux特有功能
        config["aee_decrypt"]["enable_local_decrypt_scan"] = False  # Windows下通常没有解密工具
        print("Windows系统：已禁用本地AEE解密功能")
    else:
        print(f"检测到Linux系统，使用配置文件中的绝对路径")


# 加载配置
_CONFIG = _load_config()

# --- 通用配置 ---
POLLING_INTERVAL_SECONDS = _CONFIG["general"]["polling_interval_seconds"]
FILTER_DB_LOGS_ENABLED = _CONFIG["general"]["filter_db_logs_enabled"]
ENABLE_PRECISE_MOBILELOG_SCHEME = _CONFIG["general"]["enable_precise_mobilelog_scheme"]
MAIN_LOG_ROOT_DIR_DEFAULT = _CONFIG["general"]["main_log_root_dir"]

# --- 挂载配置 (优先从环境变量读取，否则从配置文件读取) ---
MOUNT_SERVER_IP = os.environ.get("MOUNT_SERVER_IP") or _CONFIG["mount"].get("server_ip", "")
MOUNT_USERNAME = os.environ.get("MOUNT_USERNAME") or _CONFIG["mount"].get("username", "")
MOUNT_PASSWORD = os.environ.get("MOUNT_PASSWORD") or _CONFIG["mount"].get("password", "")
_sudo_passwords_env = os.environ.get("SUDO_PASSWORDS", "")
_sudo_passwords_config = _CONFIG["mount"].get("sudo_passwords", [])
SUDO_PASSWORDS = [p.strip() for p in _sudo_passwords_env.split(",") if p.strip()] if _sudo_passwords_env else _sudo_passwords_config
MOUNT_TIMEOUT = _CONFIG["mount"]["timeout"]
MOUNT_RETRY_COUNT = _CONFIG["mount"]["retry_count"]

# --- WiFi 配置 (优先从环境变量读取，否则从配置文件读取) ---
WIFI_SSID = os.environ.get("WIFI_SSID") or _CONFIG["wifi"].get("ssid", "")
WIFI_PASSWORD = os.environ.get("WIFI_PASSWORD") or _CONFIG["wifi"].get("password", "")
WIFI_SECURITY = os.environ.get("WIFI_SECURITY") or _CONFIG["wifi"].get("security", "wpa2")

# --- 稳定性配置 ---
MAX_THREAD_POOL_WORKERS = _CONFIG["stability"]["max_thread_pool_workers"]
THREAD_TIMEOUT_SECONDS = _CONFIG["stability"]["thread_timeout_seconds"]
HEARTBEAT_INTERVAL = _CONFIG["stability"]["heartbeat_interval"]
MAX_CONSECUTIVE_FAILURES = _CONFIG["stability"]["max_consecutive_failures"]
ADB_COMMAND_TIMEOUT = _CONFIG["stability"]["adb_command_timeout"]
MEMORY_THRESHOLD_MB = _CONFIG["stability"]["memory_threshold_mb"]
RUNTIME_CACHE_PERSIST_INTERVAL_SECONDS = max(
    0,
    _CONFIG["stability"].get("runtime_cache_persist_interval_seconds", 5)
)

# --- AEE 解密相关配置 ---
AEE_EXTRACT_TOOL_PATH = _CONFIG["aee_decrypt"]["tool_path"]
ENABLE_LOCAL_DECRYPT_SCAN = _CONFIG["aee_decrypt"]["enable_local_decrypt_scan"]
LOCAL_DECRYPT_LIMIT_PER_CYCLE = _CONFIG["aee_decrypt"]["limit_per_cycle"]
DECRYPT_SINGLE_LOG_TIMEOUT = _CONFIG["aee_decrypt"]["single_log_timeout"]
DECRYPT_RETRY_LIMIT = _CONFIG["aee_decrypt"]["retry_limit"]
MIN_FREE_DISK_SPACE_GB = _CONFIG["aee_decrypt"]["min_free_disk_space_gb"]
SCAN_RECENT_FOLDERS_LIMIT = _CONFIG["aee_decrypt"]["scan_recent_folders_limit"]

# --- 扫描优化配置 ---
ENABLE_SCAN_CACHE = _CONFIG["scan_optimization"]["enable_cache"]
ENABLE_PARALLEL_SCAN = _CONFIG["scan_optimization"]["enable_parallel_scan"]
SCAN_CACHE_TIMEOUT = _CONFIG["scan_optimization"]["cache_timeout"]
PARALLEL_SCAN_WORKERS = _CONFIG["scan_optimization"]["parallel_workers"]
BATCH_CHECK_SIZE = _CONFIG["scan_optimization"]["batch_check_size"]
SCAN_TASK_TIMEOUT = _CONFIG["scan_optimization"]["task_timeout"]
FIND_TIMEOUT = _CONFIG["scan_optimization"]["find_timeout"]
ENABLE_FAST_PATH_FILTER = _CONFIG["scan_optimization"]["enable_fast_path_filter"]
MAX_SCAN_DEPTH = _CONFIG["scan_optimization"]["max_depth"]
PRE_SCAN_ENABLED = _CONFIG["scan_optimization"]["pre_scan_enabled"]

# --- 多节点协调配置 ---
ENABLE_NODE_COORDINATION = _CONFIG["node_coordination"]["enabled"]
NODE_LOCK_DIR = _CONFIG["node_coordination"]["lock_dir"]
NODE_LOCK_TIMEOUT = _CONFIG["node_coordination"]["lock_timeout"]

# --- CIFS 保护配置 ---
_cifs_prot = _CONFIG.get("cifs_protection", {})
CIFS_PROTECTION_ENABLED = _cifs_prot.get("enabled", True)
CIFS_PROBE_TIMEOUT = _cifs_prot.get("probe_timeout", 10)
_CIFS_IO_TIMEOUT = _cifs_prot.get("io_timeout", 10)
CIFS_HEALTH_CACHE_TTL_SECONDS = max(0, _cifs_prot.get("health_cache_ttl_seconds", 5))
CIFS_ENABLE_AUTO_REMOUNT = _cifs_prot.get("enable_auto_remount", True)
CIFS_MAX_STALE_HEARTBEAT = _cifs_prot.get("max_stale_heartbeat_seconds", 600)
def get_local_ip():
    """获取本机IP地址"""
    try:
        # 创建一个UDP socket连接到外部地址来获取本机IP
        with socket.socket(socket.AF_INET, socket.SOCK_DGRAM) as s:
            s.connect(("8.8.8.8", 80))
            return s.getsockname()[0]
    except Exception:
        try:
            # 备用方法：获取主机名对应的IP
            return socket.gethostbyname(socket.gethostname())
        except Exception:
            # 最后备用：返回localhost
            return "127.0.0.1"

NODE_ID = get_local_ip()  # 使用节点IP地址作为节点ID

# --- Android 设备路径 ---
AEE_PATHS_ON_DEVICE = _CONFIG["device_paths"]["aee_paths"]
REMOTE_MOBILELOG_PATH = _CONFIG["device_paths"]["mobilelog_path"]
if not REMOTE_MOBILELOG_PATH.endswith('/'):
    REMOTE_MOBILELOG_PATH += '/'

# --- Bugreport 导出配置 ---
BUGREPORT_EXPORT_ENABLED = _CONFIG["bugreport"]["enabled"]
BUGREPORT_EXPORT_DIRNAME = _CONFIG["bugreport"]["dirname"]
BUGREPORT_EXPORT_TIMEOUT_SECONDS = _CONFIG["bugreport"]["timeout_seconds"]
BUGREPORT_TEMP_SUFFIX = ".partial"
BUGREPORT_COOLDOWN_SECONDS = _CONFIG["bugreport"]["cooldown_seconds"]
BUGREPORT_COOLDOWN_EVENT_TYPES = set(_CONFIG["bugreport"]["cooldown_event_types"])

# --- Monkey 监控相关配置 ---
MONKEY_PROCESS_NAME_TO_CHECK = _CONFIG["monkey"]["process_name"]
MONKEY_FULL_RESTART_COMMAND = _CONFIG["monkey"]["restart_command"]
DUMPSYS_APPOPS_COMMAND = _CONFIG["monkey"]["dumpsys_command"]

# --- Mobilelog 类型过滤开关 ---
FILTER_MOBILELOG_MAIN_ENABLED = _CONFIG["mobilelog_filter"]["main_enabled"]
FILTER_MOBILELOG_KERNEL_ENABLED = _CONFIG["mobilelog_filter"]["kernel_enabled"]
FILTER_MOBILELOG_SYS_ENABLED = _CONFIG["mobilelog_filter"]["sys_enabled"]

# --- 存储和设备设置 ---
FILL_PERCENTAGE = _CONFIG["storage"]["fill_percentage"]
ENABLE_FILL_STORAGE = _CONFIG["storage"].get("enable_fill_storage", True)
ENABLE_CLEAR_LOGS_BEFORE_TEST = _CONFIG.get("device_setup", {}).get("enable_clear_logs_before_test", False)


# --- 全局缓存和状态监控 ---
PROCESSED_DB_HISTORY_CACHE = {}
_scan_cache = {}  # 新增：扫描结果缓存
_scan_cache_lock = threading.Lock()  # 新增：扫描缓存锁
_script_start_time = time.time()
_last_heartbeat = time.time()
_consecutive_failures = 0
_active_threads = set()
_thread_lock = threading.Lock()
_should_exit = False
_bugreport_cooldown_lock = threading.Lock()
_last_bugreport_export_ts = {}
_CACHE_MANAGER_REF = None
_RUNTIME_CIFS_PROBE = None
_runtime_cache_persist_lock = threading.Lock()
_last_runtime_cache_persist_at = 0.0
_runtime_cache_pending_reason = ""

# --- 信号处理 ---
def signal_handler(signum, frame):
    """优雅退出信号处理器"""
    global _should_exit
    _should_exit = True
    print(f"接收到信号 {signum}，开始优雅退出...")

signal.signal(signal.SIGTERM, signal_handler)
signal.signal(signal.SIGINT, signal_handler)


# ==============================================================================
#  增强的日志记录器 (Enhanced Log Management)
# ==============================================================================

class ContextFilter(logging.Filter):
    def __init__(self):
        super().__init__()
        self.thread_local = threading.local()

    def filter(self, record):
        record.tag = getattr(self.thread_local, 'tag', 'MainScript')
        record.sn = getattr(self.thread_local, 'sn', '----')
        record.thread_id = threading.current_thread().ident
        return True

    def set_context(self, tag=None, sn=None):
        if tag is not None:
            self.thread_local.tag = tag
        if sn is not None:
            self.thread_local.sn = sn

    def get_context(self):
        return {
            'tag': getattr(self.thread_local, 'tag', 'MainScript'),
            'sn': getattr(self.thread_local, 'sn', '----')
        }


log_filter = ContextFilter()


class Logger(object):
    def __init__(self, log_path, cmd_level=logging.INFO, file_level=logging.INFO):
        log_format = '[%(asctime)s][%(levelname)s][%(tag)s][T%(thread_id)d] --- [%(sn)s] %(message)s'
        self._formatter = logging.Formatter(log_format, '%Y-%m-%d %H:%M:%S')

        self._logger = logging.getLogger("MainScriptLogger")
        self._logger.handlers = []
        self._logger.setLevel(logging.DEBUG)
        self._logger.addFilter(log_filter)
        self._logger.propagate = False

        self._file_level = file_level
        self._sh = self._create_stream_handler(cmd_level)
        self._fh = self._create_file_handler(log_path)

        self._logger.addHandler(self._sh)
        self._logger.addHandler(self._fh)

    def _create_stream_handler(self, level):
        handler = logging.StreamHandler(sys.stdout)
        handler.setFormatter(self._formatter)
        handler.setLevel(level)
        return handler

    def _create_file_handler(self, path):
        handler = logging.FileHandler(path, encoding="utf-8")
        handler.setFormatter(self._formatter)
        handler.setLevel(self._file_level)
        return handler

    @contextmanager
    def context(self, tag=None, sn=None):
        original_context = log_filter.get_context()
        try:
            new_context = original_context.copy()
            if tag is not None:
                new_context['tag'] = tag
            if sn is not None:
                new_context['sn'] = sn
            log_filter.set_context(**new_context)
            yield
        finally:
            log_filter.set_context(**original_context)

    def debug(self, message, *args, **kwargs):
        self._logger.debug(message, *args, **kwargs)

    def info(self, message, *args, **kwargs):
        self._logger.info(message, *args, **kwargs)

    def warn(self, message, *args, **kwargs):
        self._logger.warning(message, *args, **kwargs)

    def warning(self, message, *args, **kwargs):
        self.warn(message, *args, **kwargs)

    def error(self, message, *args, **kwargs):
        self._logger.error(message, *args, **kwargs)

    def critical(self, message, *args, **kwargs):
        self._logger.critical(message, *args, **kwargs)


def setup_logger():
    log_folder = os.path.join(SCRIPT_BASE_DIR, "logs")
    os.makedirs(log_folder, exist_ok=True)
    log_file_name = datetime.now().strftime("综合日志导出器_%Y_%m_%d.log")
    log_file_path = os.path.join(log_folder, log_file_name)
    return Logger(log_file_path)


APP_LOGGER = setup_logger()


# ==============================================================================
#  系统监控和健康检查 (System Monitoring)
# ==============================================================================

def check_system_health():
    """检查系统健康状态"""
    try:
        if HAS_PSUTIL:
            # 检查内存使用
            memory_info = psutil.virtual_memory()
            memory_used_mb = (memory_info.total - memory_info.available) / 1024 / 1024
            
            if memory_used_mb > MEMORY_THRESHOLD_MB:
                APP_LOGGER.warning(f"内存使用过高: {memory_used_mb:.1f}MB")
                
            # 检查磁盘空间
            disk_usage = psutil.disk_usage('/')
            free_gb = disk_usage.free / 1024 / 1024 / 1024
            
            if free_gb < MIN_FREE_DISK_SPACE_GB:
                APP_LOGGER.warning(f"磁盘空间不足: {free_gb:.1f}GB")
        else:
            # 简化的磁盘空间检查
            try:
                _, _, free = shutil.disk_usage('/')
                free_gb = free / 1024 / 1024 / 1024
                if free_gb < MIN_FREE_DISK_SPACE_GB:
                    APP_LOGGER.warning(f"磁盘空间不足: {free_gb:.1f}GB")
            except Exception:
                pass
                
        return True
    except Exception as e:
        APP_LOGGER.error(f"系统健康检查失败: {e}")
        return False


def cleanup_scan_cache():
    """清理过期的扫描缓存"""
    if not ENABLE_SCAN_CACHE:
        return
        
    try:
        with _scan_cache_lock:
            current_time = time.time()
            expired_keys = []
            
            for cache_key, cache_data in _scan_cache.items():
                if current_time - cache_data['timestamp'] > SCAN_CACHE_TIMEOUT * 2:  # 双倍超时时间清理
                    expired_keys.append(cache_key)
            
            for key in expired_keys:
                del _scan_cache[key]
            
            if expired_keys:
                APP_LOGGER.debug(f"清理了 {len(expired_keys)} 个过期的扫描缓存项")
                
    except Exception as e:
        APP_LOGGER.error(f"清理扫描缓存失败: {e}")


HEARTBEAT_FILE = os.path.join(SCRIPT_BASE_DIR, ".heartbeat")


def update_heartbeat():
    """更新心跳时间戳，同时写入本地磁盘供外层看门狗监控"""
    global _last_heartbeat
    _last_heartbeat = time.time()
    try:
        with open(HEARTBEAT_FILE, 'w') as f:
            f.write(str(_last_heartbeat))
    except Exception:
        pass


def check_heartbeat():
    """检查心跳是否正常"""
    current_time = time.time()
    if current_time - _last_heartbeat > HEARTBEAT_INTERVAL * 2:
        APP_LOGGER.error(f"心跳检测失败，上次心跳: {_last_heartbeat}")
        return False
    return True


def register_thread():
    """注册当前线程"""
    with _thread_lock:
        _active_threads.add(threading.current_thread().ident)


def unregister_thread():
    """注销当前线程"""
    with _thread_lock:
        _active_threads.discard(threading.current_thread().ident)


def get_active_thread_count():
    """获取活跃线程数量"""
    with _thread_lock:
        return len(_active_threads)


# ==============================================================================
#  CIFS 挂载健康探测与安全 I/O（轻量级 subprocess 版）
# ==============================================================================

class CIFSHealthProbe:
    """轻量级 CIFS 挂载健康探测器 - 基于 subprocess stat 命令（~100KB 开销）"""

    def __init__(self, mount_path, probe_timeout=None):
        self.mount_path = mount_path
        self.probe_timeout = probe_timeout or CIFS_PROBE_TIMEOUT
        self.health_cache_ttl = CIFS_HEALTH_CACHE_TTL_SECONDS
        self._is_healthy = True
        self._last_healthy_time = time.time()
        self._last_health_check_time = 0
        self._consecutive_failures = 0
        self._last_write_probe_time = 0
        self._last_write_probe_result = True
        self._write_probe_interval = max(15, self.probe_timeout)
        self._health_check_lock = threading.Lock()
        self.last_failure_reason = None
        self._last_io_slow_at = 0

    def _probe_write_access(self):
        probe_basename = f".cifs_write_probe_{os.getpid()}_{int(time.time() * 1000)}"
        probe_src = os.path.join(self.mount_path, probe_basename)
        probe_dst = probe_src + ".ok"
        probe_cmd = (
            f"p0={shlex.quote(probe_src)}; p1={shlex.quote(probe_dst)}; "
            f"printf ok > \"$p0\" && mv -f \"$p0\" \"$p1\"; "
            f"rc=$?; rm -f \"$p0\" \"$p1\"; exit $rc"
        )
        try:
            result = subprocess.run(
                ["bash", "-lc", probe_cmd],
                capture_output=True, text=True, timeout=self.probe_timeout
            )
            return result.returncode == 0
        except subprocess.TimeoutExpired:
            APP_LOGGER.error(
                f"CIFS 可写探测超时({self.probe_timeout}s): {self.mount_path}")
            return False
        except Exception as e:
            APP_LOGGER.error(f"CIFS 可写探测异常: {e}")
            return False

    def is_mount_healthy(self):
        """用 stat 命令探测挂载点是否可达"""
        now = time.time()
        if (
            self.health_cache_ttl > 0 and
            self._last_health_check_time and
            now - self._last_health_check_time < self.health_cache_ttl
        ):
            APP_LOGGER.debug(
                f"CIFS 健康检查命中缓存 (结果={self._is_healthy}, "
                f"缓存已存续={now - self._last_health_check_time:.1f}s, TTL={self.health_cache_ttl}s)"
            )
            return self._is_healthy

        with self._health_check_lock:
            now = time.time()
            if (
                self.health_cache_ttl > 0 and
                self._last_health_check_time and
                now - self._last_health_check_time < self.health_cache_ttl
            ):
                APP_LOGGER.debug(
                    f"CIFS 健康检查锁内命中缓存 (结果={self._is_healthy}, "
                    f"缓存已存续={now - self._last_health_check_time:.1f}s)"
                )
                return self._is_healthy

            APP_LOGGER.debug("CIFS 健康缓存过期或首次检查，执行实际探测...")
            try:
                result = subprocess.run(
                    ['stat', self.mount_path],
                    capture_output=True, timeout=self.probe_timeout
                )
                if result.returncode == 0:
                    write_ok = self._last_write_probe_result
                    if (
                        not self._last_write_probe_result or
                        now - self._last_write_probe_time >= self._write_probe_interval
                    ):
                        APP_LOGGER.debug(
                            "stat 通过，触发 CIFS 写探针 "
                            f"(上次写探针={now - self._last_write_probe_time:.0f}s前, "
                            f"间隔={self._write_probe_interval}s)"
                        )
                        write_ok = self._probe_write_access()
                        self._last_write_probe_time = now
                        self._last_write_probe_result = write_ok
                    else:
                        APP_LOGGER.debug(
                            f"CIFS 写探针沿用缓存结果={write_ok} "
                            f"(距上次={now - self._last_write_probe_time:.0f}s)"
                        )

                    if write_ok:
                        self._is_healthy = True
                        self._last_healthy_time = now
                        self._last_health_check_time = now
                        self._consecutive_failures = 0
                        self.last_failure_reason = None
                        return True

                    self.last_failure_reason = "write_readonly"
                    self._last_write_probe_result = False
                    APP_LOGGER.error(f"CIFS 挂载点可读但不可写: {self.mount_path}")
            except subprocess.TimeoutExpired:
                self.last_failure_reason = "io_slow"
                self._last_io_slow_at = time.time()
                APP_LOGGER.error(
                    f"CIFS 挂载探测超时({self.probe_timeout}s): {self.mount_path} (I/O 缓慢，非挂载断开)")
            except Exception as e:
                self.last_failure_reason = "error"
                APP_LOGGER.error(f"CIFS 探测异常: {e}")

            self._is_healthy = False
            self._last_health_check_time = time.time()
            self._consecutive_failures += 1
            return False

    @property
    def healthy(self):
        return self._is_healthy

    def try_recover_mount(self, target_path, server_ip,
                          username, password, sudo_passwords):
        """lazy umount + remount，但在磁盘空间不足时跳过（重挂载不能解决磁盘满问题）"""
        disk_ok = _check_disk_space(target_path, MIN_FREE_DISK_SPACE_GB)
        if not disk_ok:
            APP_LOGGER.warning(
                f"磁盘空间不足 ({MIN_FREE_DISK_SPACE_GB} GB)，跳过挂载恢复 —— "
                "重挂载无法解决磁盘满问题，等待空间释放后重试")
            self.last_failure_reason = "disk_full"
            return False

        APP_LOGGER.warning("尝试恢复 CIFS 挂载...")
        try:
            subprocess.run(
                ['sudo', 'umount', '-l', target_path],
                timeout=15, capture_output=True)
            time.sleep(3)
            recovered = auto_mount_directory(
                target_path, server_ip, username, password,
                sudo_passwords, retry_count=2)
            if recovered:
                with self._health_check_lock:
                    self._is_healthy = True
                    self._last_health_check_time = 0
                    self._last_write_probe_time = 0
                    self._last_write_probe_result = True
                APP_LOGGER.info(
                    "CIFS 恢复成功，已重置健康缓存，下次 is_mount_healthy 将执行真实探测"
                )
            return recovered
        except Exception as e:
            APP_LOGGER.error(f"挂载恢复失败: {e}")
            return False


def _safe_path_exists(path, timeout=None):
    """替代 os.path.exists()，用 test -e 命令，超时可杀"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        r = subprocess.run(['test', '-e', path], timeout=timeout)
        return r.returncode == 0
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"path_exists 超时({timeout}s): {path}")
        return False
    except Exception:
        return False


def _safe_is_dir(path, timeout=None):
    """替代 os.path.isdir()，用 test -d 命令"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        r = subprocess.run(['test', '-d', path], timeout=timeout)
        return r.returncode == 0
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"is_dir 超时({timeout}s): {path}")
        return False
    except Exception:
        return False


def _safe_listdir(path, timeout=None):
    """替代 os.listdir()，用 ls -1 命令，返回文件名列表或 None"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        r = subprocess.run(
            ['ls', '-1', path],
            capture_output=True, text=True, timeout=timeout)
        if r.returncode == 0:
            return [f for f in r.stdout.strip().split('\n') if f]
        return None
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"listdir 超时({timeout}s): {path}")
        return None
    except Exception:
        return None


def _safe_read_file(path, timeout=None):
    """替代 open(path, 'r').read()，用 cat 命令"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        r = subprocess.run(
            ['cat', path],
            capture_output=True, text=True, timeout=timeout)
        if r.returncode == 0:
            return r.stdout
        return None
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"read_file 超时({timeout}s): {path}")
        return None
    except Exception:
        return None


def _safe_write_json(path, data, timeout=None):
    """安全写 JSON 到 CIFS：先写本地 tmp，再用 mv 原子移动"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    fd = None
    tmp_path = None
    try:
        fd, tmp_path = tempfile.mkstemp(prefix="cache_", suffix=".json", dir=SCRIPT_BASE_DIR)
        with os.fdopen(fd, 'w', encoding='utf-8') as f:
            json.dump(data, f)
        fd = None
        if IS_WINDOWS:
            shutil.move(tmp_path, path)
            tmp_path = None
            return True
        r = subprocess.run(['mv', '-f', tmp_path, path], timeout=timeout, capture_output=True)
        if r.returncode == 0:
            tmp_path = None
            return True
        return False
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"write_json 超时({timeout}s): {path}")
        return False
    except Exception:
        return False
    finally:
        try:
            if fd is not None:
                os.close(fd)
        except Exception:
            pass
        try:
            if tmp_path and os.path.exists(tmp_path):
                os.remove(tmp_path)
        except Exception:
            pass


def _safe_makedirs(path, timeout=None):
    """Linux 涓嬬敤瀛愯繘绋?mkdir -p锛岄伩鍏?Python 绾跨▼鐩存帴鍗￠棶浠剁郴缁?"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        if IS_WINDOWS:
            os.makedirs(path, exist_ok=True)
            return True
        r = subprocess.run(['mkdir', '-p', path], timeout=timeout, capture_output=True)
        return r.returncode == 0
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"makedirs 瓒呮椂({timeout}s): {path}")
        return False
    except Exception as e:
        APP_LOGGER.error(f"鍒涘缓鐩綍澶辫触 {path}: {e}")
        return False


def _safe_write_text(path, content, timeout=None):
    """鍏堝啓鍒版湰鍦颁复鏃舵枃浠讹紝鍐嶇Щ鍔ㄥ埌鐩爣璺緞"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    fd = None
    tmp_path = None
    try:
        fd, tmp_path = tempfile.mkstemp(prefix="text_", suffix=".tmp", dir=SCRIPT_BASE_DIR)
        with os.fdopen(fd, 'w', encoding='utf-8') as f:
            f.write(content)
        fd = None
        parent_dir = os.path.dirname(path)
        if parent_dir and not _safe_makedirs(parent_dir, timeout=timeout):
            return False
        if IS_WINDOWS:
            shutil.move(tmp_path, path)
            tmp_path = None
            return True
        r = subprocess.run(['mv', '-f', tmp_path, path], timeout=timeout, capture_output=True)
        if r.returncode == 0:
            tmp_path = None
            return True
        return False
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"write_text 瓒呮椂({timeout}s): {path}")
        return False
    except Exception as e:
        APP_LOGGER.error(f"鍐欐枃鏈け璐? {path}: {e}")
        return False
    finally:
        try:
            if fd is not None:
                os.close(fd)
        except Exception:
            pass
        try:
            if tmp_path and os.path.exists(tmp_path):
                os.remove(tmp_path)
        except Exception:
            pass


def _safe_remove(path, timeout=None):
    """替代 os.remove()，用 rm -f 命令"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        r = subprocess.run(['rm', '-f', path], timeout=timeout,
                           capture_output=True)
        return r.returncode == 0
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"remove 超时({timeout}s): {path}")
        return False
    except Exception:
        return False


def _safe_stat(path, timeout=None):
    """用 stat 命令获取文件元信息，返回 (size, is_file) 或 (None, None)"""
    timeout = timeout or _CIFS_IO_TIMEOUT
    try:
        r = subprocess.run(
            ['stat', '--printf', '%s %F', path],
            capture_output=True, text=True, timeout=timeout)
        if r.returncode == 0:
            parts = r.stdout.strip().split(' ', 1)
            size = int(parts[0]) if parts[0].isdigit() else 0
            is_file = 'regular' in parts[1] if len(parts) > 1 else False
            return size, is_file
        return None, None
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(f"stat 超时({timeout}s): {path}")
        return None, None
    except Exception:
        return None, None


def _persist_runtime_cache(reason="", force=False):
    """灏嗗緟澶勭悊浠诲姟灏藉揩钀界洏锛屽悓鏃堕€氳繃鐭椂闂寸獥鍙ｅ悎骞朵繚瀛橈紝闄嶄綆楂橀鍐欑洏寮€閿€"""
    global _last_runtime_cache_persist_at, _runtime_cache_pending_reason

    if _CACHE_MANAGER_REF is None:
        return False

    persist_reason = reason
    with _runtime_cache_persist_lock:
        now = time.time()
        if reason:
            _runtime_cache_pending_reason = reason
        if (
            not force and
            RUNTIME_CACHE_PERSIST_INTERVAL_SECONDS > 0 and
            _last_runtime_cache_persist_at and
            now - _last_runtime_cache_persist_at < RUNTIME_CACHE_PERSIST_INTERVAL_SECONDS
        ):
            APP_LOGGER.debug(
                f"运行时缓存落盘已节流 (跳过, reason已合并, "
                f"距上次落盘 {now - _last_runtime_cache_persist_at:.1f}s, "
                f"窗口 {RUNTIME_CACHE_PERSIST_INTERVAL_SECONDS}s)"
            )
            return False
        if _runtime_cache_pending_reason:
            persist_reason = _runtime_cache_pending_reason
            _runtime_cache_pending_reason = ""

    try:
        _CACHE_MANAGER_REF.save(PROCESSED_DB_HISTORY_CACHE)
        with _runtime_cache_persist_lock:
            _last_runtime_cache_persist_at = time.time()
        if persist_reason:
            APP_LOGGER.info(f"宸插皢寰呭鐞嗙紦瀛樿惤鐩? {persist_reason}")
        return True
    except Exception as e:
        with _runtime_cache_persist_lock:
            if persist_reason:
                _runtime_cache_pending_reason = persist_reason
        APP_LOGGER.error(f"钀界洏寰呭鐞嗙紦瀛樺け璐? {persist_reason}: {e}")
        return False


def _ensure_output_subdir_ready(path):
    """鍐欏叆 CIFS 涓婄殑鐩爣鐩綍鍓嶅厛鍋ュ悍妫€鏌ャ€?"""
    if IS_WINDOWS:
        return _safe_makedirs(path)
    if _RUNTIME_CIFS_PROBE and not _RUNTIME_CIFS_PROBE.is_mount_healthy():
        APP_LOGGER.warning(f"CIFS 鍐欏叆涓嶅仴搴凤紝鏆傛椂涓嶅啓鍏ョ洰褰? {path}")
        return False
    return _safe_makedirs(path)


# ==============================================================================
#  节点协调工具函数 (Node Coordination Utilities)
# ==============================================================================

class NodeCoordinator:
    """节点间协调管理器，用于避免多节点并发冲突
    [CIFS 防护版] 所有文件操作通过 _safe_* 系列函数，带超时保护。
    """

    def __init__(self, lock_dir, node_id, timeout=300, cifs_probe=None):
        self.lock_dir = lock_dir
        self.node_id = node_id
        self.timeout = timeout
        self._cifs_probe = cifs_probe
        self._ensure_lock_dir()

    def _check_mount_health(self):
        if IS_WINDOWS or not self._cifs_probe:
            return True
        return self._cifs_probe.healthy

    def _ensure_lock_dir(self):
        """确保锁目录存在"""
        try:
            if IS_WINDOWS:
                os.makedirs(self.lock_dir, exist_ok=True)
            else:
                subprocess.run(
                    ['mkdir', '-p', self.lock_dir],
                    timeout=_CIFS_IO_TIMEOUT, capture_output=True)
        except Exception as e:
            APP_LOGGER.error(f"创建节点锁目录失败: {e}")

    def acquire_serial_lock(self, serial_number):
        """为特定序列号获取锁"""
        if not self._check_mount_health():
            return False
        lock_file = os.path.join(self.lock_dir, f"{serial_number}.lock")
        try:
            if _safe_path_exists(lock_file, timeout=5):
                content = _safe_read_file(lock_file, timeout=5)
                if content:
                    try:
                        lock_info = json.loads(content)
                        lock_time = datetime.fromisoformat(lock_info['timestamp'])
                        if datetime.now() - lock_time < timedelta(seconds=self.timeout):
                            if lock_info['node_id'] != self.node_id:
                                APP_LOGGER.debug(
                                    f"序列号 {serial_number} 已被节点 {lock_info['node_id']} 锁定")
                                return False
                    except (json.JSONDecodeError, KeyError):
                        pass

            lock_info = {
                'node_id': self.node_id,
                'timestamp': datetime.now().isoformat(),
                'serial_number': serial_number
            }

            if IS_WINDOWS:
                with open(lock_file, 'w') as f:
                    json.dump(lock_info, f)
            else:
                if not _safe_write_json(lock_file, lock_info, timeout=5):
                    return False

            APP_LOGGER.debug(f"成功获取序列号 {serial_number} 的锁")
            return True

        except Exception as e:
            APP_LOGGER.error(f"获取序列号锁失败 {serial_number}: {e}")
            return False

    def release_serial_lock(self, serial_number):
        """释放特定序列号的锁"""
        if not self._check_mount_health():
            return False
        lock_file = os.path.join(self.lock_dir, f"{serial_number}.lock")
        try:
            if not _safe_path_exists(lock_file, timeout=5):
                return True
            content = _safe_read_file(lock_file, timeout=5)
            if content:
                try:
                    lock_info = json.loads(content)
                    if lock_info['node_id'] != self.node_id:
                        APP_LOGGER.warning(f"尝试释放不属于本节点的锁: {serial_number}")
                        return False
                except (json.JSONDecodeError, KeyError):
                    pass

            if IS_WINDOWS:
                try:
                    os.remove(lock_file)
                except Exception:
                    pass
            else:
                _safe_remove(lock_file, timeout=5)
            APP_LOGGER.debug(f"释放序列号 {serial_number} 的锁")
            return True
        except Exception as e:
            APP_LOGGER.error(f"释放序列号锁失败 {serial_number}: {e}")
            return False

    def cleanup_and_get_locked_serials(self):
        """合并清理过期锁和获取锁定列表，减少 CIFS I/O 次数"""
        if not self._check_mount_health():
            return []

        lock_files = _safe_listdir(self.lock_dir, timeout=10)
        if lock_files is None:
            return []

        locked_serials = []
        cleaned = 0
        current_time = datetime.now()

        for fname in lock_files:
            if not fname.endswith('.lock'):
                continue
            lock_path = os.path.join(self.lock_dir, fname)
            content = _safe_read_file(lock_path, timeout=5)
            if content is None:
                continue
            try:
                info = json.loads(content)
                lock_time = datetime.fromisoformat(info['timestamp'])
                if current_time - lock_time >= timedelta(seconds=self.timeout):
                    _safe_remove(lock_path, timeout=5)
                    cleaned += 1
                else:
                    locked_serials.append(info['serial_number'])
            except Exception:
                _safe_remove(lock_path, timeout=5)
                cleaned += 1

        if cleaned:
            APP_LOGGER.info(f"清理了 {cleaned} 个过期锁")
        return locked_serials

    def cleanup_expired_locks(self):
        """清理过期的锁文件（兼容旧接口，内部委托给合并方法）"""
        self.cleanup_and_get_locked_serials()

    def get_locked_serials(self):
        """获取当前被锁定的序列号列表（兼容旧接口）"""
        return self.cleanup_and_get_locked_serials()


# ==============================================================================
#  挂载检查和自动挂载功能 (Mount Check and Auto Mount)
# ==============================================================================

def check_mount_status(target_path):
    """检查指定路径是否已挂载"""
    try:
        result = subprocess.run(['df', '-h'], capture_output=True, text=True, timeout=10)
        if result.returncode == 0:
            # 标准化路径：去掉末尾斜杠进行比较
            normalized_target = target_path.rstrip('/')
            return normalized_target in result.stdout
        else:
            APP_LOGGER.error(f"执行 df -h 命令失败: {result.stderr}")
            return False
    except subprocess.TimeoutExpired:
        APP_LOGGER.error("df -h 命令执行超时")
        return False
    except Exception as e:
        APP_LOGGER.error(f"检查挂载状态时发生错误: {e}")
        return False

def mount_with_pexpect(mount_command, sudo_passwords, timeout=30):
    """使用pexpect处理交互式挂载，支持多个密码尝试"""
    for i, password in enumerate(sudo_passwords):
        try:
            APP_LOGGER.debug(f"尝试使用密码 {i+1}/{len(sudo_passwords)}")
            APP_LOGGER.debug(f"执行命令: {mount_command}")
            
            child = pexpect.spawn(mount_command, timeout=timeout)
            child.logfile_read = sys.stdout.buffer  # 添加调试输出
            
            # 更精确的密码提示匹配模式
            password_patterns = [
                r'.*[Pp]assword.*:',  # 匹配各种密码提示格式
                r'.*password for.*:',  # 匹配 "password for user:" 格式
                r'\[sudo\] password for.*:',  # 匹配 "[sudo] password for user:" 格式
                pexpect.EOF,
                pexpect.TIMEOUT
            ]
            
            # 等待密码提示，增加超时时间
            index = child.expect(password_patterns, timeout=15)
            
            if index in [0, 1, 2]:  # 收到密码提示
                APP_LOGGER.debug(f"检测到密码提示，发送密码 {i+1}")
                child.sendline(password)
                
                # 等待命令完成，给更多时间
                try:
                    child.expect(pexpect.EOF, timeout=timeout)
                except pexpect.TIMEOUT:
                    APP_LOGGER.debug(f"密码 {i+1} 执行超时，可能仍在处理中")
                    pass
                
                child.close()
                
                if child.exitstatus == 0:
                    APP_LOGGER.info(f"密码验证成功，使用密码 {i+1}")
                    return True, child.before.decode() if child.before else ""
                else:
                    APP_LOGGER.debug(f"密码 {i+1} 验证失败，退出码: {child.exitstatus}，尝试下一个")
                    continue
                    
            elif index == 3:  # EOF，命令可能已完成
                child.close()
                if child.exitstatus == 0:
                    APP_LOGGER.info("命令执行成功（无需密码）")
                    return True, child.before.decode() if child.before else ""
                else:
                    APP_LOGGER.debug(f"命令执行失败，退出码: {child.exitstatus}")
                    
            else:  # 超时
                APP_LOGGER.debug(f"密码 {i+1} 等待提示超时")
                child.close()
                continue
                
        except pexpect.exceptions.TIMEOUT:
            APP_LOGGER.debug(f"密码 {i+1} 执行超时，尝试下一个")
            try:
                child.close()
            except:
                pass
            continue
        except Exception as e:
            APP_LOGGER.debug(f"密码 {i+1} 执行异常: {e}，尝试下一个")
            try:
                child.close()
            except:
                pass
            continue
    
    return False, "所有密码都尝试失败"

def mount_with_echo(mount_command, sudo_passwords, timeout=30):
    """
    使用subprocess.Popen配合stdin管道处理sudo密码，避免shell注入风险
    支持多个密码尝试
    """
    # 从mount_command中提取target_path
    target_path = mount_command.split()[-1]
    
    for i, password in enumerate(sudo_passwords):
        try:
            APP_LOGGER.debug(f"尝试使用密码 {i+1}/{len(sudo_passwords)} (安全管道方式)")
            
            # 使用列表形式传递参数，避免shell注入
            mount_options = f"username={MOUNT_USERNAME},password={MOUNT_PASSWORD},dir_mode=0777,file_mode=0777"
            mount_source = f"//{MOUNT_SERVER_IP}/jxtinno/sonic_tinno"
            
            cmd = [
                'sudo', '-S',
                'busybox', 'mount', '-t', 'cifs',
                '-o', mount_options,
                mount_source, target_path
            ]
            
            APP_LOGGER.debug(f"执行命令: sudo -S busybox mount -t cifs -o [options] {mount_source} {target_path}")
            
            # 使用Popen配合stdin传递密码，避免shell=True
            proc = subprocess.Popen(
                cmd,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                text=True
            )
            
            # 通过stdin传递密码
            stdout, stderr = proc.communicate(input=password + '\n', timeout=timeout)
            
            if proc.returncode == 0:
                APP_LOGGER.info(f"密码验证成功，使用密码 {i+1} (安全管道方式)")
                return True, stderr if stderr else stdout
            else:
                APP_LOGGER.debug(f"密码 {i+1} 验证失败 (安全管道方式)，返回码: {proc.returncode}，错误: {stderr}")
                continue
                
        except subprocess.TimeoutExpired:
            APP_LOGGER.debug(f"密码 {i+1} 执行超时 (安全管道方式)，尝试下一个")
            try:
                proc.kill()
                proc.communicate()
            except:
                pass
            continue
        except Exception as e:
            APP_LOGGER.debug(f"密码 {i+1} 执行异常 (安全管道方式): {e}，尝试下一个")
            continue
    
    return False, "所有密码都尝试失败 (安全管道方式)"

def auto_mount_directory(target_path, server_ip, username, password, sudo_passwords, retry_count=3):
    """自动挂载目录，支持多个sudo密码尝试"""
    mount_command = (
        f"sudo busybox mount -t cifs -o username={username},password={password},"
        f"dir_mode=0777,file_mode=0777 //{server_ip}/jxtinno/sonic_tinno {target_path}"
    )
    
    for attempt in range(retry_count):
        APP_LOGGER.info(f"尝试挂载 (第{attempt + 1}次): {target_path}")
        
        success = False
        error_msg = ""
        
        # 方法1: 使用pexpect (推荐)
        if HAS_PEXPECT:
            APP_LOGGER.debug("使用pexpect方式进行挂载")
            success, error_msg = mount_with_pexpect(mount_command, sudo_passwords, MOUNT_TIMEOUT)
        
        # 方法2: 使用echo管道 (备用)
        if not success:
            APP_LOGGER.debug("使用echo管道方式进行挂载")
            success, error_msg = mount_with_echo(mount_command, sudo_passwords, MOUNT_TIMEOUT)
        
        if success:
            APP_LOGGER.info(f"挂载成功: {target_path}")
            
            # 验证挂载是否真正成功
            time.sleep(2)  # 等待挂载完成
            if check_mount_status(target_path):
                APP_LOGGER.info(f"挂载验证成功: {target_path}")
                return True
            else:
                APP_LOGGER.warning(f"挂载命令执行成功但验证失败: {target_path}")
        else:
            APP_LOGGER.error(f"挂载失败 (第{attempt + 1}次): {error_msg}")
        
        if attempt < retry_count - 1:
            APP_LOGGER.info(f"等待5秒后重试...")
            time.sleep(5)
    
    APP_LOGGER.error(f"挂载最终失败，已尝试 {retry_count} 次")
    return False

def ensure_directory_mounted(target_path, server_ip, username, password, sudo_passwords):
    """确保目录已挂载，如果未挂载则自动挂载，支持多个sudo密码"""
    with APP_LOGGER.context(tag="MountChecker"):
        # Linux 下先检查挂载状态，避免对异常 CIFS 挂载点做同步 exists/makedirs。
        APP_LOGGER.info(f"检查挂载状态: {target_path}")
        if check_mount_status(target_path):
            APP_LOGGER.info(f"目录已挂载: {target_path}")
            return True

        # 仅在确认未挂载后，才去准备本地挂载点目录。
        if IS_WINDOWS:
            if not os.path.exists(target_path):
                APP_LOGGER.error(f"目标目录不存在: {target_path}")
                try:
                    os.makedirs(target_path, exist_ok=True)
                    APP_LOGGER.info(f"已创建目标目录: {target_path}")
                except Exception as e:
                    APP_LOGGER.error(f"创建目标目录失败: {e}")
                    return False
        else:
            if not _safe_path_exists(target_path, timeout=5):
                APP_LOGGER.warning(f"挂载点目录不存在或不可达，尝试安全创建: {target_path}")
                if not _safe_makedirs(target_path, timeout=5):
                    APP_LOGGER.error(f"创建挂载点目录失败: {target_path}")
                    return False
                APP_LOGGER.info(f"已创建挂载点目录: {target_path}")

        # 3. 如果未挂载，执行自动挂载
        APP_LOGGER.warning(f"目录未挂载，开始自动挂载: {target_path}")
        APP_LOGGER.info(f"将尝试 {len(sudo_passwords)} 个不同的sudo密码")
        return auto_mount_directory(target_path, server_ip, username, password, sudo_passwords, MOUNT_RETRY_COUNT)


# ==============================================================================
#  增强的核心工具函数 (Enhanced Core Utility Functions)
# ==============================================================================

class CacheManager:
    def __init__(self, cache_path):
        self.cache_path = cache_path
        self.temp_path = cache_path + ".tmp"
        self._lock = threading.Lock()

    def load(self):
        with self._lock:
            with APP_LOGGER.context(tag="CacheManager"):
                if not os.path.exists(self.cache_path):
                    APP_LOGGER.info(f"缓存文件 '{self.cache_path}' 不存在，将创建新的缓存。")
                    return {"processed_history": {}, "decryption_tasks": {}, "pending_pull_tasks": {}}

                try:
                    with open(self.cache_path, 'r', encoding='utf-8') as f:
                        data = json.load(f)

                    if "processed_history" not in data and "decryption_tasks" not in data:
                        APP_LOGGER.warning("检测到旧版缓存格式，将进行转换。")
                        old_data = data
                        data = {"processed_history": {}, "decryption_tasks": {}, "pending_pull_tasks": {}}
                        for device, aee_types in old_data.items():
                            data["processed_history"][device] = {}
                            for aee_type, lines in aee_types.items():
                                data["processed_history"][device][aee_type] = set(lines)
                    else:
                        history = data.get("processed_history", {})
                        for device, aee_types in history.items():
                            for aee_type, lines in aee_types.items():
                                history[device][aee_type] = set(lines)

                    if "decryption_tasks" not in data:
                        data["decryption_tasks"] = {}
                    if "pending_pull_tasks" not in data:
                        data["pending_pull_tasks"] = {}

                    APP_LOGGER.info(f"成功从 '{self.cache_path}' 加载了缓存。")
                    return data
                except (json.JSONDecodeError, IOError) as e:
                    APP_LOGGER.error(f"加载缓存文件 '{self.cache_path}' 失败，将使用空缓存。错误: {e}")
                    if os.path.exists(self.cache_path):
                        os.rename(self.cache_path, f"{self.cache_path}.corrupted_{int(time.time())}")
                    return {"processed_history": {}, "decryption_tasks": {}, "pending_pull_tasks": {}}

    def save(self, cache_data):
        with self._lock:
            with APP_LOGGER.context(tag="CacheManager"):
                try:
                    data_to_save = {
                        "processed_history": {},
                        "decryption_tasks": cache_data.get("decryption_tasks", {}),
                        "pending_pull_tasks": cache_data.get("pending_pull_tasks", {})
                    }

                    history = cache_data.get("processed_history", {})
                    for device, aee_types in history.items():
                        data_to_save["processed_history"][device] = {}
                        for aee_type, lines in aee_types.items():
                            if isinstance(lines, set):
                                data_to_save["processed_history"][device][aee_type] = list(lines)
                            else:
                                data_to_save["processed_history"][device][aee_type] = lines

                    with open(self.temp_path, 'w', encoding='utf-8') as f:
                        json.dump(data_to_save, f, indent=4)

                    os.replace(self.temp_path, self.cache_path)
                    APP_LOGGER.debug(f"已成功将缓存状态保存到 '{self.cache_path}'。")
                except Exception as e:
                    APP_LOGGER.error(f"保存缓存到 '{self.cache_path}' 时发生错误: {e}")


def run_adb_command_safe(command_parts, device_id=None, timeout=None, attempts=1):
    """增强版ADB命令执行函数，具有更好的错误处理和超时控制"""
    if timeout is None:
        timeout = ADB_COMMAND_TIMEOUT
        
    cmd_base = ["adb"]
    if device_id:
        cmd_base.extend(["-s", device_id])

    cmd = cmd_base + command_parts
    
    with APP_LOGGER.context(tag="ADBUtil", sn=device_id):
        for attempt in range(attempts):
            if _should_exit:
                APP_LOGGER.info("检测到退出信号，停止ADB命令执行")
                return None
                
            try:
                # 添加进程监控
                start_time = time.time()
                result = subprocess.run(
                    cmd, capture_output=True, text=True, check=False,
                    timeout=timeout, encoding='utf-8', errors='ignore'
                )
                
                elapsed = time.time() - start_time
                if elapsed > timeout * 0.8:  # 如果执行时间超过80%的超时时间，记录警告
                    APP_LOGGER.warning(f"ADB命令执行时间较长: {elapsed:.2f}s, 命令: {' '.join(cmd[:3])}...")
                
                if result.returncode == 0:
                    return result.stdout.strip() if result.stdout else ""
                    
                if "find" in cmd and result.returncode == 1 and not result.stderr.strip():
                    return ""
                    
                APP_LOGGER.error(
                    f"命令失败(尝试{attempt + 1}/{attempts}): {' '.join(cmd[:5])}...\n"
                    f"返回码: {result.returncode}, 错误: {result.stderr.strip()[:200]}"
                )
                
            except subprocess.TimeoutExpired:
                APP_LOGGER.error(f"命令超时(尝试{attempt + 1}/{attempts}, {timeout}s): {' '.join(cmd[:3])}...")
            except Exception as e:
                APP_LOGGER.error(f"命令异常(尝试{attempt + 1}/{attempts}): {e}")
                
            if attempt < attempts - 1:
                time.sleep(min(2 ** attempt, 10))  # 指数退避
                
    return None


# 为了兼容性，保留原函数名
run_adb_command = run_adb_command_safe


def get_connected_devices():
    """获取连接的设备列表，增加错误处理"""
    devices = []
    try:
        output = run_adb_command(["devices"], timeout=10)
        if output:
            for line in output.strip().split('\n')[1:]:
                parts = line.strip().split('\t')
                if len(parts) == 2 and parts[1] == 'device':
                    devices.append(parts[0])
        else:
            APP_LOGGER.warning("获取设备列表失败 (adb devices 命令出错)。")
    except Exception as e:
        APP_LOGGER.error(f"获取设备列表时发生异常: {e}")
    return devices


def load_whitelist(filepath):
    whitelist = set()
    with APP_LOGGER.context(tag="Util"):
        if not os.path.exists(filepath):
            APP_LOGGER.warning(f"白名单文件未找到: {filepath}。")
            return whitelist
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                for line in f:
                    pkg_name = line.strip()
                    if pkg_name and not pkg_name.startswith('#'):
                        whitelist.add(pkg_name)
            APP_LOGGER.info(f"从白名单文件 {filepath} 加载了 {len(whitelist)} 个包名。")
        except Exception as e:
            APP_LOGGER.error(f"加载白名单文件 {filepath} 时出错: {e}")
    return whitelist


# ==============================================================================
#  MonkeyTest 类 (保持原有功能，增加异常处理)
# ==============================================================================

class MonkeyTest:
    def __init__(self, push_res, is_sleep, is_aimonkey, play_video, memory_rw, target_fill_percentage=FILL_PERCENTAGE):
        self.push_res = push_res
        self.is_sleep = is_sleep
        self.is_aimonkey = is_aimonkey
        self.play_video = play_video
        self.memory_rw = memory_rw
        self.target_fill_percentage = target_fill_percentage 

    def start_test_for_device(self, sn):
        try:
            register_thread()
            with APP_LOGGER.context(tag=f"MonkeyTest-{sn[:6]}", sn=sn):
                self._perform_initial_device_setup(sn)
                if self.push_res:
                    self._push_general_resources(sn)
                self._setup_and_launch_monkey(sn)
        except Exception as e:
            APP_LOGGER.error(f"设备 {sn} Monkey测试启动失败: {e}")
        finally:
            unregister_thread()

    def _perform_initial_device_setup(self, sn):
        with APP_LOGGER.context(tag="DeviceSetup", sn=sn):
            APP_LOGGER.info("开始执行设备前置配置...")
            try:
                # 首先尝试获取root权限
                if not self._ensure_root_access(sn):
                    APP_LOGGER.warning(f"设备 {sn} 无法获取root权限，某些功能可能受限")
                
                commands = [
                    (["shell", "settings", "put", "global", "development_settings_enabled", "1"], 10),
                    (["shell", "setprop", "persist.vendor.mtk.aee.mode", "3"], 10),
                    (["shell", "am", "broadcast", "-a", "com.debug.loggerui.ADB_CMD", "-e", "cmd_name", "start",
                      "--ei", "cmd_target", "1", "-n", "com.debug.loggerui/.framework.LogReceiver"], 15),
                    (["shell", "am", "broadcast", "-a", "com.debug.loggerui.ADB_CMD", "-e", "cmd_name",
                      "set_total_log_size_4096", "--ei", "cmd_target", "1", "-n",
                      "com.debug.loggerui/.framework.LogReceiver"], 15),
                    (["shell", "am", "broadcast", "-a", "com.debug.loggerui.ADB_CMD", "-e", "cmd_name", "set_sublog_4_5_0",
                      "--ei", "cmd_target", "1", "-n", "com.debug.loggerui/.framework.LogReceiver"], 15),
                    (["shell", "settings", "put", "global", "development_settings_enabled", "0"], 10),
                    (["shell", "cmd", "wifi", "set-wifi-enabled", "enabled"], 10),
                    (["shell", "cmd", "wifi", "start-scan"], 10),
                ]
                
                # WiFi连接命令单独处理，使用环境变量中的配置
                if WIFI_SSID and WIFI_PASSWORD:
                    commands.append(
                        (["shell", "cmd", "wifi", "connect-network", WIFI_SSID, WIFI_SECURITY, WIFI_PASSWORD], 10)
                    )
                else:
                    APP_LOGGER.warning("WiFi配置未设置(WIFI_SSID/WIFI_PASSWORD)，跳过WiFi连接")
                
                for cmd, timeout in commands:
                    if _should_exit:
                        return
                    run_adb_command(cmd, device_id=sn, timeout=timeout)
                        
                APP_LOGGER.info("设备前置ADB命令执行完毕")

                # 内存填充（可通过配置禁用）
                if ENABLE_FILL_STORAGE:
                    APP_LOGGER.info("开始进行内存填充...")
                    fill_success = fill_device_storage_to_percentage(
                        target_percentage=self.target_fill_percentage,
                        device_id=sn,
                        logger=APP_LOGGER,
                        non_interactive=True
                    )

                    if fill_success:
                        APP_LOGGER.info(f"内存填充成功，达到目标 {self.target_fill_percentage}%。")
                    else:
                        APP_LOGGER.error("内存填充失败！请检查日志。")
                else:
                    APP_LOGGER.info("内存填充已禁用（enable_fill_storage=false）")
                    
                # 清理历史日志（可通过配置禁用）
                if ENABLE_CLEAR_LOGS_BEFORE_TEST:
                    APP_LOGGER.info("开始清理设备历史日志...")
                    self._clear_device_logs(sn)
                else:
                    APP_LOGGER.info("日志清理已禁用（enable_clear_logs_before_test=false）")

                APP_LOGGER.info("设备前置配置完成。")
            except Exception as e:
                APP_LOGGER.error(f"设备前置配置失败: {e}")

    def _ensure_root_access(self, sn, max_attempts=3):
        """确保设备具有root权限，支持多次重试"""
        with APP_LOGGER.context(tag="RootAccess", sn=sn):
            for attempt in range(max_attempts):
                try:
                    # 检查当前是否已有root权限
                    whoami_result = run_adb_command(["shell", "whoami"], device_id=sn, timeout=10)
                    if whoami_result and "root" in whoami_result:
                        APP_LOGGER.info(f"设备已具有root权限 (尝试 {attempt + 1}/{max_attempts})")
                        return True
                    
                    # 尝试获取root权限
                    APP_LOGGER.info(f"尝试获取root权限 (尝试 {attempt + 1}/{max_attempts})")
                    root_result = run_adb_command(["root"], device_id=sn, timeout=10)
                    
                    if root_result is not None:
                        # 等待adb重启
                        time.sleep(3)
                        
                        # 重新检查权限
                        whoami_result = run_adb_command(["shell", "whoami"], device_id=sn, timeout=10)
                        if whoami_result and "root" in whoami_result:
                            APP_LOGGER.info(f"成功获取root权限 (尝试 {attempt + 1}/{max_attempts})")
                            return True
                        else:
                            APP_LOGGER.warning(f"root命令执行后仍无root权限 (尝试 {attempt + 1}/{max_attempts})")
                    else:
                        APP_LOGGER.warning(f"root命令执行失败 (尝试 {attempt + 1}/{max_attempts})")
                    
                    # 如果不是最后一次尝试，等待后重试
                    if attempt < max_attempts - 1:
                        time.sleep(5)
                        
                except Exception as e:
                    APP_LOGGER.error(f"获取root权限时发生异常 (尝试 {attempt + 1}/{max_attempts}): {e}")
                    if attempt < max_attempts - 1:
                        time.sleep(5)
            
            APP_LOGGER.error(f"经过 {max_attempts} 次尝试后仍无法获取root权限")
            return False

    def _check_root_permission_for_path(self, sn, path):
        """检查特定路径的访问权限"""
        try:
            # 尝试列出目录内容来检查权限
            result = run_adb_command(["shell", "ls", "-la", path], device_id=sn, timeout=15)
            if result is None:
                return False
            
            # 检查是否有权限拒绝的错误
            if "Permission denied" in result or "No such file or directory" in result:
                return False
                
            return True
        except Exception as e:
            APP_LOGGER.error(f"检查路径权限失败 {path}: {e}")
            return False
            
    def _clear_device_logs(self, sn):
        """移除填充阶段产生的旧日志和dbg，确保后续采集干净"""
        with APP_LOGGER.context(tag="LogCleanup", sn=sn):
            cleanup_commands = [
                ("if [ -d /data/debuglogger/mobilelog ]; then rm -rf /data/debuglogger/mobilelog/*; fi", 60),
                (
                    "for base in /data/aee_exp/* /data/vendor/aee_exp/*; do "
                    "if [ -d \"$base\" ]; then "
                    "find \"$base\" -maxdepth 1 -type d -name 'db.[0-9]*' -exec rm -rf {} +; "
                    "find \"$base\" -maxdepth 1 -type f -name 'db.[0-9]*' -delete; "
                    "find \"$base\" -maxdepth 1 -type f -name '*.zip' -delete; "
                    "find \"$base\" -maxdepth 1 -type f -name '*.tgz' -delete; "
                    "find \"$base\" -maxdepth 1 -type f -name '*.tar' -delete; "
                    "fi; "
                    "done",
                    90
                ),
                ("sync", 30)
            ]

            for cmd, timeout in cleanup_commands:
                if _should_exit:
                    return
                result = self._adb_shell(sn, cmd, timeout=timeout)
                if result is None:
                    APP_LOGGER.warning(f"执行日志清理命令失败或无返回: {cmd}")
            # 确保关键目录存在，避免后续日志记录失败
            for path in ["/data/aee_exp", "/data/vendor/aee_exp", "/data/debuglogger/mobilelog"]:
                self._adb_shell(sn, f"mkdir -p {path}", timeout=30)
                
    def _push_general_resources(self, sn):
        try:
            resource_dir = os.path.join(os.curdir, "resource")
            if not os.path.isdir(resource_dir):
                APP_LOGGER.warning(f"本地资源目录 'resource' 未找到，跳过推送。")
                return
            run_adb_command(["shell", "mkdir", "-p", "/sdcard/resource"], device_id=sn, timeout=10)
            run_adb_command(["push", resource_dir, "/sdcard/resource"], device_id=sn, timeout=300)
        except Exception as e:
            APP_LOGGER.error(f"推送资源失败: {e}")

    def _adb_push(self, sn, local_path, remote_path, timeout=120):
        try:
            if not os.path.exists(local_path):
                APP_LOGGER.warning(f"本地文件/目录 '{local_path}' 未找到，无法推送。")
                return False
            result = run_adb_command(["push", local_path, remote_path], device_id=sn, timeout=timeout)
            return result is not None
        except Exception as e:
            APP_LOGGER.error(f"推送文件失败 {local_path}: {e}")
            return False

    def _adb_shell(self, sn, shell_cmd, timeout=60):
        try:
            return run_adb_command(["shell", shell_cmd], device_id=sn, timeout=timeout)
        except Exception as e:
            APP_LOGGER.error(f"执行shell命令失败 {shell_cmd}: {e}")
            return None

    def _setup_aimonkey_suite(self, sn):
        try:
            self._adb_push(sn, "aim.jar", "/data/local/tmp/aim.jar")
            if self._adb_push(sn, "aim", "/data/local/tmp/aim"):
                self._adb_shell(sn, "chmod 777 /data/local/tmp/aim")
            if self._adb_push(sn, "aimwd", "/data/local/tmp/aimwd"):
                self._adb_shell(sn, "chmod 777 /data/local/tmp/aimwd")
            for item in ["arm64-v8a", "armeabi-v7a"]:
                if os.path.isdir(item):
                    self._adb_push(sn, item, "/data/local/tmp/", timeout=300)
            self._adb_push(sn, "aimonkey.apk", "/data/local/tmp/monkey.apk")
        except Exception as e:
            APP_LOGGER.error(f"设置AIMonkey套件失败: {e}")

    def _setup_sleep_mode_tests(self, sn):
        try:
            for pkg in ["com.transsion.testcaserepository", "com.transsion.testcaserepository.test"]:
                self._adb_shell(sn, f"pm uninstall {pkg}")
            time.sleep(1)
            for apk in ["app-debug.apk", "app-debug-androidTest.apk"]:
                if os.path.exists(apk):
                    run_adb_command(["install", "-r", "-g", "-t", apk], device_id=sn, timeout=300)
        except Exception as e:
            APP_LOGGER.error(f"设置睡眠模式测试失败: {e}")

    def _push_common_resources_for_monkey(self, sn):
        try:
            self._adb_push(sn, "blacklist.txt", "/sdcard/blacklist.txt")
            if self.play_video:
                self._adb_push(sn, "monkey_video.3gpp", "/sdcard/monkey_video.3gpp")
            if self.memory_rw:
                if self._adb_push(sn, "monkey_rw_test_64bit", "/data/local/tmp/monkey_rw_test_64bit"):
                    self._adb_shell(sn, "chmod 777 /data/local/tmp/monkey_rw_test_64bit")
        except Exception as e:
            APP_LOGGER.error(f"推送Monkey通用资源失败: {e}")

    def _launch_monkey_script(self, sn):
        try:
            script_name = self._get_monkey_script_name()
            if not script_name:
                APP_LOGGER.error("无法确定要使用的 Monkey 脚本，测试无法启动。")
                return
            if self._adb_push(sn, script_name, "/data/local/tmp/MonkeyTest.sh"):
                self._adb_shell(sn, "chmod 777 /data/local/tmp/MonkeyTest.sh")
                self._adb_shell(sn, "cd /data/local/tmp && nohup sh ./MonkeyTest.sh > /dev/null 2>&1 &")
                if self.is_aimonkey:
                    self._adb_shell(sn, "nohup /data/local/tmp/aimwd > /dev/null 2>&1 &")
            else:
                APP_LOGGER.error(f"未能推送主 Monkey 脚本 '{script_name}'，测试无法启动。")
        except Exception as e:
            APP_LOGGER.error(f"启动Monkey脚本失败: {e}")

    def _setup_and_launch_monkey(self, sn):
        with APP_LOGGER.context(tag=f"MonkeySetup-{sn[:6]}", sn=sn):
            try:
                self._push_common_resources_for_monkey(sn)
                if self.is_aimonkey:
                    self._setup_aimonkey_suite(sn)
                if self.is_sleep:
                    self._setup_sleep_mode_tests(sn)
                self._launch_monkey_script(sn)
            except Exception as e:
                APP_LOGGER.error(f"设置和启动Monkey失败: {e}")

    def _get_monkey_script_name(self):
        if self.is_sleep:
            if self.is_aimonkey:
                return "MonkeyTestAi_PlayVideo_MemoryRW.sh" if self.play_video or self.memory_rw else "MonkeyTestAi.sh"
            else:
                return "offlinemonkey.sh"
        else:
            return "MonkeyTestAi.sh" if self.is_aimonkey else "MonkeyTest.sh"


def _ensure_device_root_access(device_id, max_attempts=3):
    """
    确保设备具有root权限，支持多次重试
    独立函数版本，不依赖于MonkeyTest类
    """
    with APP_LOGGER.context(tag="RootAccess", sn=device_id):
        for attempt in range(max_attempts):
            try:
                # 检查当前是否已有root权限
                whoami_result = run_adb_command(["shell", "whoami"], device_id=device_id, timeout=10)
                if whoami_result and "root" in whoami_result:
                    APP_LOGGER.info(f"设备已具有root权限 (尝试 {attempt + 1}/{max_attempts})")
                    return True
                
                # 尝试获取root权限
                APP_LOGGER.info(f"尝试获取root权限 (尝试 {attempt + 1}/{max_attempts})")
                root_result = run_adb_command(["root"], device_id=device_id, timeout=10)
                
                if root_result is not None:
                    # 等待adb重启
                    time.sleep(3)
                    
                    # 再次检查权限
                    whoami_result = run_adb_command(["shell", "whoami"], device_id=device_id, timeout=10)
                    if whoami_result and "root" in whoami_result:
                        APP_LOGGER.info(f"成功获取root权限 (尝试 {attempt + 1}/{max_attempts})")
                        return True
                
                if attempt < max_attempts - 1:
                    APP_LOGGER.warning(f"第 {attempt + 1} 次尝试失败，等待后重试...")
                    time.sleep(2)
                    
            except Exception as e:
                APP_LOGGER.error(f"获取root权限时发生异常 (尝试 {attempt + 1}/{max_attempts}): {e}")
                if attempt < max_attempts - 1:
                    time.sleep(2)
        
        APP_LOGGER.error(f"经过 {max_attempts} 次尝试后仍无法获取root权限")
        return False


# ==============================================================================
#  辅助函数 (保持原有功能，增加异常处理)
# ==============================================================================

def _get_aee_log_folder_name(device_id, run_date_stamp):
    try:
        with APP_LOGGER.context(sn=device_id):
            product_name_prop = run_adb_command(["shell", "getprop", "ro.product.name"], device_id=device_id, timeout=10)
            display_id_prop = run_adb_command(["shell", "getprop", "ro.build.display.id"], device_id=device_id, timeout=10)
            version_incremental_id_prop = run_adb_command(["shell", "getprop", "ro.build.version.incremental"],
                                                          device_id=device_id, timeout=10)
            version_release_prop = run_adb_command(["shell", "getprop", "ro.build.version.release"],
                                                   device_id=device_id, timeout=10)
            if not product_name_prop or not display_id_prop:
                return None

            product_name_prop = product_name_prop.strip()
            display_id_prop = display_id_prop.strip()
            version_incremental_id_prop = version_incremental_id_prop.strip() if version_incremental_id_prop else ""
            version_release_prop = version_release_prop.strip() if version_release_prop else ""

            folder_part_1 = product_name_prop
            folder_part_2_prefix = ""
            post_paren_content = ""
            timestamp_from_display = ""
            su_suffix = ""

            # 含括号的机型保持旧逻辑，不启用新格式的 incremental 回退逻辑。
            if "(" in display_id_prop:
                display_prefix = display_id_prop.split("(", 1)[0].strip()
                if display_prefix.startswith(f"{product_name_prop}-"):
                    folder_part_2_prefix = display_prefix[len(product_name_prop) + 1:].strip()
                elif "-" in display_prefix:
                    folder_part_2_prefix = display_prefix.split("-", 1)[1].strip()

                match_post_paren = re.search(r"\)(.*)", display_id_prop)
                if match_post_paren:
                    post_paren_content = match_post_paren.group(1).strip()

                all_six_digit_numbers = re.findall(r"\d{6}", post_paren_content)
                if all_six_digit_numbers:
                    timestamp_from_display = all_six_digit_numbers[-1]

                su_suffix = "SU" if "_SU" in post_paren_content else ("UD" if "_UD" in post_paren_content else "")
            else:
                # 兼容 MLD-LX3-16-260518V3 这类不带括号的新版本格式。
                remaining_display = ""
                if display_id_prop.startswith(f"{product_name_prop}-"):
                    remaining_display = display_id_prop[len(product_name_prop) + 1:].strip()
                elif "-" in display_id_prop:
                    remaining_display = display_id_prop.split("-", 1)[1].strip()

                if remaining_display:
                    display_tokens = [token.strip() for token in remaining_display.split("-") if token.strip()]
                    if version_release_prop and display_tokens and display_tokens[0] == version_release_prop:
                        folder_part_2_prefix = version_release_prop
                        if len(display_tokens) > 1:
                            timestamp_from_display = "-".join(display_tokens[1:])
                    else:
                        folder_part_2_prefix = display_tokens[0]
                        if len(display_tokens) > 1:
                            timestamp_from_display = "-".join(display_tokens[1:])

                if not timestamp_from_display:
                    build_tokens = re.findall(
                        r"\d{6}(?:V\d+)?",
                        " ".join(filter(None, [display_id_prop, version_incremental_id_prop])),
                        flags=re.IGNORECASE
                    )
                    if build_tokens:
                        timestamp_from_display = build_tokens[-1]

                su_suffix_source = " ".join(filter(None, [display_id_prop, version_incremental_id_prop]))
                su_suffix = "SU" if "_SU" in su_suffix_source else ("UD" if "_UD" in su_suffix_source else "")

            if product_name_prop in ["ELA-LX2", "ELA-LX3"] and version_incremental_id_prop:
                folder_part_1, folder_part_2_prefix = "", version_incremental_id_prop
                timestamp_from_display = ""

            if "(" not in display_id_prop and not folder_part_2_prefix and version_incremental_id_prop:
                folder_part_1, folder_part_2_prefix = "", version_incremental_id_prop
                timestamp_from_display = ""

            if folder_part_2_prefix == timestamp_from_display:
                timestamp_from_display = ""

            parts = [folder_part_1, folder_part_2_prefix, timestamp_from_display, su_suffix, run_date_stamp,
                     "MonkeyAEEinfo"]
            return "_".join(filter(None, parts))
    except Exception as e:
        APP_LOGGER.error(f"获取AEE日志文件夹名称失败: {e}")
        return None


def _parse_timestamp(timestamp_field_str):
    try:
        cleaned_str = timestamp_field_str.strip().split('@', 1)[-1].strip()
        for fmt in ("%Y-%m-%d %H:%M:%S.%f", "%Y-%m-%d %H:%M:%S"):
            try:
                return datetime.strptime(cleaned_str, fmt)
            except ValueError:
                continue
        try:
            match = re.match(
                r"^(?:\w{3}\s+)?(?P<mon>\w{3})\s+(?P<day>\d{1,2})\s+(?P<time>\d{2}:\d{2}:\d{2})(?:\s+\S+)?\s+(?P<year>\d{4})$",
                cleaned_str)
            if match:
                dt_str = f"{match.group('mon')} {match.group('day')} {match.group('time')} {match.group('year')}"
                return datetime.strptime(dt_str, "%b %d %H:%M:%S %Y")
        except (ValueError, AttributeError):
            pass
        APP_LOGGER.warning(f"无法使用已知格式解析时间戳: '{timestamp_field_str}'")
        return None
    except Exception as e:
        APP_LOGGER.error(f"解析时间戳时发生异常: {e}")
        return None


def _format_timestamp_for_filename(timestamp_field_str):
    try:
        dt_obj = _parse_timestamp(timestamp_field_str)
        if not dt_obj:
            return datetime.now().strftime("%Y_%m%d_%H%M%S_%f")[:21]
        ms_part = "000"
        if '.' in timestamp_field_str:
            ms_match = re.search(r'\.(\d+)', timestamp_field_str)
            if ms_match:
                ms_part = ms_match.group(1)[:3].ljust(3, '0')
        return dt_obj.strftime("%Y_%m%d_%H%M%S") + f"_{ms_part}"
    except Exception as e:
        APP_LOGGER.error(f"格式化时间戳失败: {e}")
        return datetime.now().strftime("%Y_%m%d_%H%M%S_%f")[:21]


def _parse_mobilelog_filename_to_datetime(filename):
    try:
        pattern = r".*?(\d{4})_(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2})(?:[\._].*)?$"
        match = re.search(pattern, filename)
        if match:
            try:
                (y, mo, d, h, mi, s) = map(int, match.groups())
                return datetime(y, mo, d, h, mi, s)
            except (ValueError, IndexError):
                pass
        return None
    except Exception as e:
        APP_LOGGER.error(f"解析Mobilelog文件名失败: {e}")
        return None


def _parse_db_history_line(line_content):
    try:
        parts = line_content.split(',')
        if len(parts) < 10:
            return None
        db_path = parts[0].strip()
        pkg_name = parts[8].strip()
        ts_str = parts[9].strip()
        event_type = parts[1].strip().upper() if len(parts) > 1 else ""
        if not all([db_path, pkg_name, ts_str]):
            return None
        return {
            "db_path": db_path,
            "pkg_name": pkg_name,
            "timestamp": ts_str,
            "event_type": event_type
        }
    except Exception as e:
        APP_LOGGER.error(f"解析db_history行失败: {e}")
        return None


def _parse_vendor_db_history_line(line_content):
    try:
        normalized_line = (line_content or "").strip()
        if not normalized_line or normalized_line.startswith("androidboot.bootreason="):
            return None
        if not normalized_line.startswith("/data/vendor/aee_exp/db."):
            return None

        parts = normalized_line.split(',')
        if len(parts) < 10:
            return None

        db_path = parts[0].strip()
        ts_str = parts[9].strip()
        event_type = parts[1].strip().upper() if len(parts) > 1 else ""
        pkg_name = parts[8].strip() if len(parts) > 8 else ""
        if not db_path or not ts_str:
            return None

        return {
            "db_path": db_path,
            "pkg_name": pkg_name,
            "timestamp": ts_str,
            "event_type": event_type
        }
    except Exception as e:
        APP_LOGGER.error(f"解析vendor db_history行失败: {e}")
        return None


def _parse_effective_db_history_line(line_content, aee_type):
    if aee_type == "vendor_aee_exp":
        return _parse_vendor_db_history_line(line_content)
    return _parse_db_history_line(line_content)


def _decrypt_aee_log(dbg_file_path):
    try:
        register_thread()
        with APP_LOGGER.context(tag="AEEExtractor"):
            if not os.path.isfile(AEE_EXTRACT_TOOL_PATH):
                APP_LOGGER.warning(f"AEE提取工具未找到: {AEE_EXTRACT_TOOL_PATH}。")
                return False
            decrypted_dir_path = dbg_file_path + ".DEC"
            if os.path.isdir(decrypted_dir_path) and os.listdir(decrypted_dir_path):
                return True
            if os.path.isdir(decrypted_dir_path):
                try:
                    shutil.rmtree(decrypted_dir_path)
                except OSError as e:
                    APP_LOGGER.error(f"清理失败的空目录时出错: {decrypted_dir_path}, 错误: {e}")
                    return False
            APP_LOGGER.info(f"开始解密: {os.path.basename(dbg_file_path)}")
            command = [AEE_EXTRACT_TOOL_PATH, dbg_file_path]
            result = None
            try:
                result = subprocess.run(
                    command, capture_output=True, text=True,
                    timeout=DECRYPT_SINGLE_LOG_TIMEOUT, encoding='utf-8', errors='ignore'
                )
            except subprocess.TimeoutExpired:
                APP_LOGGER.error(f"解密超时 (>{DECRYPT_SINGLE_LOG_TIMEOUT}s)。文件: {os.path.basename(dbg_file_path)}")
                return False
            except Exception as e:
                APP_LOGGER.error(f"解密时发生未知异常。文件: {os.path.basename(dbg_file_path)}, 错误: {e}")
                return False
            if os.path.isdir(decrypted_dir_path) and os.listdir(decrypted_dir_path):
                if result and result.returncode != 0:
                    APP_LOGGER.warning(f"输出文件已成功生成，文件: {os.path.basename(dbg_file_path)}")
                else:
                    APP_LOGGER.info(f"解密成功: {os.path.basename(decrypted_dir_path)}")
                return True
            else:
                APP_LOGGER.error(f"解密真失败：未生成有效输出。文件: {os.path.basename(dbg_file_path)}")
                if result:
                    APP_LOGGER.error(f"工具返回码: {result.returncode}, Stderr: {result.stderr.strip()[:200]}")
                if os.path.isdir(decrypted_dir_path):
                    try:
                        shutil.rmtree(decrypted_dir_path)
                    except OSError:
                        pass
                return False
    except Exception as e:
        APP_LOGGER.error(f"解密AEE日志时发生异常: {e}")
        return False
    finally:
        unregister_thread()


def export_correlated_mobilelogs(device_id, aee_ts_str, base_output_dir):
    try:
        register_thread()
        with APP_LOGGER.context(tag=f"MobilelogLinker", sn=device_id):
            aee_dt = _parse_timestamp(aee_ts_str)
            if not aee_dt:
                APP_LOGGER.error(f"无法解析AEE时间戳 '{aee_ts_str}'，跳过关联Mobilelog导出。")
                return
            correlated_dir = os.path.join(base_output_dir, "correlated_mobilelogs")
            if not _ensure_output_subdir_ready(correlated_dir):
                APP_LOGGER.warning(f"关联Mobilelog输出目录不可用，跳过导出: {correlated_dir}")
                return
            log_types_config = {
                "MAIN": {"prefix": "main_log", "enabled": FILTER_MOBILELOG_MAIN_ENABLED},
                "KERNEL": {"prefix": "kernel_log", "enabled": FILTER_MOBILELOG_KERNEL_ENABLED},
                "SYS": {"prefix": "sys_log", "enabled": FILTER_MOBILELOG_SYS_ENABLED}
            }
            for log_type, config in log_types_config.items():
                if not config['enabled'] or _should_exit:
                    continue
                find_cmd = f"find {REMOTE_MOBILELOG_PATH} -name '{config['prefix']}*' -type f -print0"
                output = run_adb_command(["shell", find_cmd], device_id=device_id, timeout=120)
                if output is None:
                    continue
                all_files = [p for p in output.split('\0') if p]
                file_infos = []
                for path in all_files:
                    dt = _parse_mobilelog_filename_to_datetime(os.path.basename(path))
                    if dt:
                        file_infos.append({"path": path, "timestamp": dt})
                if not file_infos:
                    continue
                file_infos.sort(key=lambda x: x["timestamp"])
                target_idx = next((i for i, f in enumerate(file_infos) if f["timestamp"] > aee_dt), len(file_infos))
                start_idx = max(0, target_idx - 2)
                end_idx = min(len(file_infos), target_idx + 2)
                selected_files = file_infos[start_idx:end_idx]
                for file_info in selected_files:
                    if _should_exit:
                        break
                    local_path = os.path.join(correlated_dir, os.path.basename(file_info['path']))
                    local_exists = os.path.exists(local_path) if IS_WINDOWS else _safe_path_exists(local_path, timeout=5)
                    if not local_exists:
                        run_adb_command(["pull", file_info['path'], local_path], device_id=device_id, timeout=180)
    except Exception as e:
        APP_LOGGER.error(f"导出关联Mobilelog失败: {e}")
    finally:
        unregister_thread()


def _acquire_bugreport_export_slot(device_id, event_type):
    try:
        if BUGREPORT_COOLDOWN_SECONDS <= 0:
            return True

        normalized_type = (event_type or "").strip().upper()
        if not normalized_type or normalized_type not in BUGREPORT_COOLDOWN_EVENT_TYPES:
            return True

        now = time.time()
        with _bugreport_cooldown_lock:
            last_ts = _last_bugreport_export_ts.get(device_id)
            if last_ts and (now - last_ts) < BUGREPORT_COOLDOWN_SECONDS:
                remaining = int(BUGREPORT_COOLDOWN_SECONDS - (now - last_ts))
                APP_LOGGER.info(
                    f"Bugreport冷却中，跳过本次导出 (设备: {device_id}, 事件: {normalized_type})，剩余 {remaining} 秒"
                )
                return False
            _last_bugreport_export_ts[device_id] = now
        return True
    except Exception as e:
        APP_LOGGER.error(f"Bugreport冷却判定异常: {e}")
        return True


def export_bugreport_for_timestamp(device_id, timestamp_str, base_output_dir, event_type=None):
    if not BUGREPORT_EXPORT_ENABLED or _should_exit:
        return

    try:
        register_thread()
        with APP_LOGGER.context(tag="BugreportExporter", sn=device_id):
            if _should_exit:
                return

            if not _acquire_bugreport_export_slot(device_id, event_type):
                return

            bugreport_dir = os.path.join(base_output_dir, BUGREPORT_EXPORT_DIRNAME)
            if not _ensure_output_subdir_ready(bugreport_dir):
                APP_LOGGER.warning(f"Bugreport输出目录不可用，跳过导出: {bugreport_dir}")
                return

            formatted_ts = _format_timestamp_for_filename(timestamp_str)
            final_path = os.path.join(bugreport_dir, f"{formatted_ts}_bugreport.zip")
            final_exists = os.path.exists(final_path) if IS_WINDOWS else _safe_path_exists(final_path, timeout=5)

            if final_exists:
                APP_LOGGER.info(f"Bugreport已存在，无需重复导出: {os.path.basename(final_path)}")
                return

            temp_path = final_path + BUGREPORT_TEMP_SUFFIX
            temp_exists = os.path.exists(temp_path) if IS_WINDOWS else _safe_path_exists(temp_path, timeout=5)
            if temp_exists:
                try:
                    if IS_WINDOWS:
                        os.remove(temp_path)
                    else:
                        _safe_remove(temp_path, timeout=10)
                except OSError as e:
                    APP_LOGGER.warning(f"清理旧的临时bugreport文件失败: {temp_path}, 错误: {e}")

            result = run_adb_command(
                ["bugreport", temp_path],
                device_id=device_id,
                timeout=BUGREPORT_EXPORT_TIMEOUT_SECONDS
            )

            if result is None:
                APP_LOGGER.error("导出bugreport失败: adb命令执行失败。")
                temp_exists = os.path.exists(temp_path) if IS_WINDOWS else _safe_path_exists(temp_path, timeout=5)
                if temp_exists:
                    try:
                        if IS_WINDOWS:
                            os.remove(temp_path)
                        else:
                            _safe_remove(temp_path, timeout=10)
                    except OSError as e:
                        APP_LOGGER.warning(f"清理失败的bugreport临时文件出错: {temp_path}, 错误: {e}")
                return

            temp_exists = os.path.exists(temp_path) if IS_WINDOWS else _safe_path_exists(temp_path, timeout=5)
            if not temp_exists:
                APP_LOGGER.error("导出bugreport失败: 未生成输出文件。")
                return

            try:
                if IS_WINDOWS:
                    os.replace(temp_path, final_path)
                else:
                    move_result = subprocess.run(
                        ['mv', '-f', temp_path, final_path],
                        timeout=15,
                        capture_output=True,
                        text=True
                    )
                    if move_result.returncode != 0:
                        raise OSError(f"mv rc={move_result.returncode}, err={move_result.stderr.strip()}")
            except OSError as e:
                APP_LOGGER.error(f"保存bugreport失败: {e}")
                try:
                    temp_exists = os.path.exists(temp_path) if IS_WINDOWS else _safe_path_exists(temp_path, timeout=5)
                    if temp_exists:
                        if IS_WINDOWS:
                            os.remove(temp_path)
                        else:
                            _safe_remove(temp_path, timeout=10)
                except OSError as cleanup_error:
                    APP_LOGGER.warning(f"清理bugreport临时文件失败: {temp_path}, 错误: {cleanup_error}")
                return
            except subprocess.TimeoutExpired:
                APP_LOGGER.error(f"保存bugreport超时: {temp_path}")
                return

            APP_LOGGER.info(f"成功导出bugreport: {final_path}")
    except Exception as e:
        APP_LOGGER.error(f"导出bugreport时发生异常: {e}")
    finally:
        unregister_thread()


def _verify_pulled_aee_log(local_dir, remote_path, device_id):
    """
    验证AEE日志拉取是否成功
    
    验证条件:
    1. 本地目录存在
    2. 目录非空
    3. 包含关键文件 (如 .dbg 文件)
    4. 文件大小合理 (> 0 bytes)
    
    返回: (success: bool, message: str)
    """
    try:
        # 检查目录是否存在
        if not os.path.exists(local_dir):
            return False, "本地目录不存在"
        
        if not os.path.isdir(local_dir):
            return False, "路径不是目录"
        
        # 获取目录内容
        contents = os.listdir(local_dir)
        if not contents:
            return False, "目录为空"
        
        # 检查是否有关键文件
        dbg_files = [f for f in contents if f.endswith('.dbg')]
        has_dbg = len(dbg_files) > 0
        
        # 检查文件大小
        total_size = 0
        file_count = 0
        for item in contents:
            item_path = os.path.join(local_dir, item)
            if os.path.isfile(item_path):
                size = os.path.getsize(item_path)
                total_size += size
                file_count += 1
        
        if file_count == 0:
            return False, "目录中没有文件"
        
        if total_size == 0:
            return False, "所有文件大小为0"
        
        # 可选：与设备端文件数量对比
        remote_file_count = _get_remote_file_count(device_id, remote_path)
        if remote_file_count is not None and remote_file_count > 0:
            if file_count < remote_file_count * 0.5:  # 如果本地文件数少于远程的50%
                return False, f"文件数量不完整 (本地:{file_count}, 远程:{remote_file_count})"
        
        # 验证通过
        size_kb = total_size / 1024
        return True, f"验证通过 (文件数:{file_count}, 大小:{size_kb:.1f}KB, dbg文件:{len(dbg_files)})"
        
    except Exception as e:
        return False, f"验证过程异常: {e}"


def _get_remote_file_stats(device_id, remote_path):
    """
    单次ADB调用获取设备端目录的文件数量和总大小。
    返回 (file_count: int|None, total_size: int|None)
    """
    try:
        result = run_adb_command(
            ["shell", f"find {remote_path} -type f 2>/dev/null -exec ls -l {{}} \\; | awk '{{c++;s+=$5}}END{{print c,s}}'"],
            device_id=device_id,
            timeout=30
        )
        if result is not None:
            stripped = result.strip()
            if not stripped:
                return 0, 0
            parts = stripped.split()
            if len(parts) >= 2 and parts[0].isdigit() and parts[1].isdigit():
                return int(parts[0]), int(parts[1])
        # 降级：只取数量（兼容性最好）
        result = run_adb_command(
            ["shell", f"find {remote_path} -type f 2>/dev/null | wc -l"],
            device_id=device_id,
            timeout=30
        )
        if result and result.strip().isdigit():
            return int(result.strip()), None
        return None, None
    except Exception:
        return None, None


def _get_remote_file_count(device_id, remote_path):
    """兼容包装，返回文件数量"""
    count, _ = _get_remote_file_stats(device_id, remote_path)
    return count


def _verify_pulled_aee_log_strict(local_dir, remote_path, device_id):
    """
    返回 (success: bool, message: str, remote_verified: bool)
    [CIFS 防护版] 用 find+stat 替代 os.walk/os.path.getsize，带超时保护。
    """
    try:
        if IS_WINDOWS:
            if not os.path.isdir(local_dir):
                return False, "本地目录不存在", False
            if not os.listdir(local_dir):
                return False, "目录为空", False
            dbg_files = []
            total_size = 0
            file_count = 0
            for root_dir, _, files in os.walk(local_dir):
                for filename in files:
                    fp = os.path.join(root_dir, filename)
                    try:
                        size = os.path.getsize(fp)
                    except OSError:
                        size = 0
                    total_size += size
                    file_count += 1
                    if filename.endswith('.dbg'):
                        dbg_files.append(fp)
        else:
            if not _safe_is_dir(local_dir, timeout=5):
                return False, "本地目录不存在", False
            try:
                r = subprocess.run(
                    f"find {local_dir} -type f -exec ls -l {{}} \\; "
                    f"| awk '{{c++;s+=$5}}END{{print c,s}}'",
                    shell=True, capture_output=True, text=True, timeout=15)
                parts = r.stdout.strip().split()
                file_count = int(parts[0]) if len(parts) >= 1 and parts[0].isdigit() else 0
                total_size = int(parts[1]) if len(parts) >= 2 and parts[1].isdigit() else 0
            except (subprocess.TimeoutExpired, Exception):
                return False, "验证目录超时（CIFS 可能不健康）", False

            try:
                r2 = subprocess.run(
                    f"find {local_dir} -name '*.dbg' -type f | head -1",
                    shell=True, capture_output=True, text=True, timeout=10)
                has_dbg = bool(r2.stdout.strip())
            except Exception:
                has_dbg = False
            dbg_files = ['found'] if has_dbg else []

        if file_count == 0:
            return False, "目录中没有文件", False

        if not dbg_files:
            return False, "缺少dbg关键文件", False

        if total_size == 0:
            return False, "所有文件大小为0", False

        remote_file_count, remote_total_size = _get_remote_file_stats(device_id, remote_path)

        if remote_file_count is None:
            size_kb = total_size / 1024
            return True, f"本地数据存在但未能与设备端比对 (文件数:{file_count}, 大小:{size_kb:.1f}KB)", False

        if remote_file_count == 0:
            size_kb = total_size / 1024
            return True, f"设备端目录已清理，本地数据视为最终版本 (文件数:{file_count}, 大小:{size_kb:.1f}KB)", True

        if file_count < remote_file_count:
            return False, f"文件数量不完整 (本地:{file_count}, 远程:{remote_file_count})", True

        if remote_total_size is not None and remote_total_size > 0:
            if total_size < remote_total_size * 0.9:
                return False, f"文件总大小不匹配 (本地:{total_size}, 远程:{remote_total_size})", True

        size_kb = total_size / 1024
        return True, f"验证通过 (文件数:{file_count}/{remote_file_count}, 大小:{size_kb:.1f}KB, dbg:{len(dbg_files)})", True
    except Exception as e:
        return False, f"验证过程异常: {e}", False


def _get_pending_pull_tasks():
    pending_pull_tasks = PROCESSED_DB_HISTORY_CACHE.get("pending_pull_tasks")
    if pending_pull_tasks is None:
        pending_pull_tasks = {}
        PROCESSED_DB_HISTORY_CACHE["pending_pull_tasks"] = pending_pull_tasks
    return pending_pull_tasks


def _get_pending_pull_tasks_for_type(device_id, aee_type):
    pending_pull_tasks = _get_pending_pull_tasks()
    if device_id not in pending_pull_tasks:
        pending_pull_tasks[device_id] = {}
    if aee_type not in pending_pull_tasks[device_id]:
        pending_pull_tasks[device_id][aee_type] = {}
    return pending_pull_tasks[device_id][aee_type]


def _build_pending_pull_task(line, parsed):
    return {
        "line": line,
        "db_path": parsed["db_path"],
        "pkg_name": parsed.get("pkg_name", ""),
        "timestamp": parsed["timestamp"],
        "event_type": parsed.get("event_type", ""),
        "retry_count": 0,
        "last_error": "",
        "last_attempt_at": "",
        "created_at": datetime.now().isoformat(),
        "awaiting_remote_verify": False,
        "last_remote_verify_at": "",
    }


def _mark_pending_pull_task_failure(task, error_msg):
    task["retry_count"] = int(task.get("retry_count", 0)) + 1
    task["last_error"] = error_msg
    task["last_attempt_at"] = datetime.now().isoformat()


def _cleanup_partial_aee_dir(local_target_dir):
    try:
        if IS_WINDOWS:
            if not os.path.exists(local_target_dir):
                return True
            shutil.rmtree(local_target_dir)
            return True
        if not _safe_path_exists(local_target_dir, timeout=5):
            return True
        result = subprocess.run(
            ['rm', '-rf', local_target_dir],
            timeout=_CIFS_IO_TIMEOUT,
            capture_output=True,
            text=True
        )
        if result.returncode == 0:
            return True
        APP_LOGGER.error(f"清理不完整目录失败: {local_target_dir}, rc={result.returncode}, err={result.stderr.strip()}")
        return False
    except subprocess.TimeoutExpired:
        APP_LOGGER.error(f"清理不完整目录超时: {local_target_dir}")
        return False
    except Exception as e:
        APP_LOGGER.error(f"清理不完整目录失败: {local_target_dir}, 错误: {e}")
        return False


def process_device_logs(device_id, whitelist, base_output_dir):
    """
    [V3.7 优化] 移除了此函数中的"即时解密"逻辑。
    本函数现在只负责从设备拉取新的AEE日志文件到本地。
    所有的解密任务将由 process_local_undecrypted_logs 统一调度和限流。
    [修复版本] 增加了异常处理、超时控制和权限检查
    [V3.8] 增加了日志拉取验证机制，只有验证通过才标记为已处理
    """
    try:
        register_thread()
        with APP_LOGGER.context(tag=f"LogProcessor", sn=device_id):
            processed_history = PROCESSED_DB_HISTORY_CACHE.get("processed_history", {})
            if device_id not in processed_history:
                processed_history[device_id] = {}
                
            for remote_aee_path in AEE_PATHS_ON_DEVICE:
                if _should_exit:
                    break
                    
                aee_type = "vendor_aee_exp" if "vendor" in remote_aee_path else "aee_exp"
                output_subdir = os.path.join(base_output_dir, aee_type)
                
                if aee_type not in processed_history[device_id]:
                    processed_history[device_id][aee_type] = set()

                history_content = run_adb_command(["shell", "cat", os.path.join(remote_aee_path, "db_history")], 
                                                device_id=device_id, timeout=30)
                if history_content is None: 
                    APP_LOGGER.warning(f"无法读取 {remote_aee_path}/db_history，可能存在权限问题")
                    continue

                pending_pull_tasks = _get_pending_pull_tasks_for_type(device_id, aee_type)
                processed_lines = processed_history[device_id][aee_type]
                current_lines_list = history_content.strip().splitlines()
                passed_filter_lines = []
                newly_queued_count = 0
                for line in current_lines_list:
                    parsed_for_filter = _parse_effective_db_history_line(line, aee_type)
                    if not parsed_for_filter: 
                        continue
                    is_whitelisted_for_save = (aee_type != "aee_exp") or (not FILTER_DB_LOGS_ENABLED) or (parsed_for_filter['pkg_name'] in whitelist)
                    if not is_whitelisted_for_save:
                        continue
                    passed_filter_lines.append(line)
                    if line not in processed_lines and line not in pending_pull_tasks:
                        pending_pull_tasks[line] = _build_pending_pull_task(line, parsed_for_filter)
                        newly_queued_count += 1

                if newly_queued_count > 0:
                    _persist_runtime_cache(
                        f"{device_id}/{aee_type} 新增待拉取任务 {newly_queued_count} 条"
                    )

                # 磁盘空间预检（每设备每AEE路径仅一次）
                disk_space_ok = _check_disk_space(output_subdir, MIN_FREE_DISK_SPACE_GB)
                if not disk_space_ok:
                    APP_LOGGER.warning(f"服务器磁盘空间不足，跳过本轮 {aee_type} 日志拉取，任务保留在待处理队列")
                    continue

                if not _ensure_output_subdir_ready(output_subdir):
                    APP_LOGGER.warning(f"输出目录不可用，跳过本轮 {aee_type} 日志拉取，任务保留在待处理队列: {output_subdir}")
                    continue

                if not _safe_write_text(os.path.join(output_subdir, "db_save_org.txt"), history_content):
                    APP_LOGGER.error("写入 db_save_org.txt 失败")

                if not _safe_write_text(os.path.join(output_subdir, "db_save.txt"), '\n'.join(passed_filter_lines)):
                    APP_LOGGER.error("写入 db_save.txt 失败")

                new_lines = list(pending_pull_tasks.items())
                pull_retry_limit = _CONFIG.get("aee_decrypt", {}).get("pull_retry_limit", 10)
                successfully_processed_lines = set()

                for line, task in new_lines:
                    if _should_exit:
                        break

                    if line in processed_lines:
                        pending_pull_tasks.pop(line, None)
                        continue

                    parsed = {
                        "db_path": task.get("db_path", ""),
                        "pkg_name": task.get("pkg_name", ""),
                        "timestamp": task.get("timestamp", ""),
                        "event_type": task.get("event_type", "")
                    }
                    if not parsed["db_path"] or not parsed["timestamp"]:
                        pending_pull_tasks.pop(line, None)
                        continue
                    
                    is_whitelisted = (aee_type != "aee_exp") or (not FILTER_DB_LOGS_ENABLED) or (parsed['pkg_name'] in whitelist)
                    if not is_whitelisted: 
                        continue

                    if int(task.get("retry_count", 0)) >= pull_retry_limit:
                        APP_LOGGER.critical(
                            f"日志拉取已达重试上限({pull_retry_limit}): {parsed['db_path']}，"
                            f"最后错误: {task.get('last_error', 'N/A')}")
                        pending_pull_tasks.pop(line, None)
                        continue

                    new_dirname = f"{_format_timestamp_for_filename(parsed['timestamp'])}_{os.path.basename(parsed['db_path'])}"
                    local_target_dir = os.path.join(output_subdir, new_dirname)
                    local_target_dir_exists = os.path.exists(local_target_dir) if IS_WINDOWS else _safe_path_exists(local_target_dir, timeout=5)

                    # 如果目录已存在，验证其完整性
                    if local_target_dir_exists:
                        # 节流：等待远程重验的任务检查冷却时间
                        if task.get("awaiting_remote_verify"):
                            last_verify = task.get("last_remote_verify_at", "")
                            if last_verify:
                                try:
                                    elapsed = (datetime.now() - datetime.fromisoformat(last_verify)).total_seconds()
                                    if elapsed < POLLING_INTERVAL_SECONDS * 3:
                                        continue
                                except (ValueError, TypeError):
                                    pass

                        verify_success, verify_msg, remote_verified = _verify_pulled_aee_log_strict(
                            local_target_dir, parsed['db_path'], device_id)

                        if verify_success and remote_verified:
                            successfully_processed_lines.add(line)
                            pending_pull_tasks.pop(line, None)
                            APP_LOGGER.debug(f"已存在且验证通过: {new_dirname}")
                        elif verify_success and not remote_verified:
                            task["awaiting_remote_verify"] = True
                            task["last_remote_verify_at"] = datetime.now().isoformat()
                            APP_LOGGER.info(f"保留待远程重验: {new_dirname} - {verify_msg}")
                        else:
                            APP_LOGGER.warning(f"已存在但验证失败，将重新拉取: {new_dirname} - {verify_msg}")
                            task["awaiting_remote_verify"] = False
                            if not _cleanup_partial_aee_dir(local_target_dir):
                                _mark_pending_pull_task_failure(task, f"删除不完整目录失败: {verify_msg}")
                                continue
                            local_target_dir_exists = False
                    
                    # 拉取日志
                    if not local_target_dir_exists:
                        pull_result = run_adb_command(["pull", parsed['db_path'], local_target_dir], device_id=device_id, timeout=300)
                        
                        if pull_result is not None:
                            verify_success, verify_msg, remote_verified = _verify_pulled_aee_log_strict(
                                local_target_dir, parsed['db_path'], device_id)

                            if verify_success and remote_verified:
                                APP_LOGGER.info(f"成功拉取并验证AEE日志: {new_dirname} - {verify_msg}")
                                successfully_processed_lines.add(line)
                                pending_pull_tasks.pop(line, None)
                                
                                if ENABLE_PRECISE_MOBILELOG_SCHEME:
                                    export_correlated_mobilelogs(device_id, parsed['timestamp'], base_output_dir)
                                    
                                export_bugreport_for_timestamp(
                                    device_id,
                                    parsed['timestamp'],
                                    base_output_dir,
                                    event_type=parsed.get('event_type')
                                )
                            elif verify_success and not remote_verified:
                                task["awaiting_remote_verify"] = True
                                task["last_remote_verify_at"] = datetime.now().isoformat()
                                APP_LOGGER.warning(f"拉取完成但未能与设备端比对，保留待重验: {new_dirname}")
                            else:
                                error_msg = f"拉取AEE日志验证失败: {parsed['db_path']} - {verify_msg}"
                                APP_LOGGER.error(error_msg)
                                task["awaiting_remote_verify"] = False
                                _mark_pending_pull_task_failure(task, error_msg)
                                if not _cleanup_partial_aee_dir(local_target_dir):
                                    APP_LOGGER.error(f"清理残留目录失败: {local_target_dir}")
                        else:
                            error_msg = f"拉取AEE日志失败: {parsed['db_path']}"
                            APP_LOGGER.error(error_msg)
                            task["awaiting_remote_verify"] = False
                            _mark_pending_pull_task_failure(task, error_msg)
                            if not _cleanup_partial_aee_dir(local_target_dir):
                                APP_LOGGER.error(f"清理残留目录失败: {local_target_dir}")
                
                if successfully_processed_lines:
                    processed_lines.update(successfully_processed_lines)
                    APP_LOGGER.info(f"本轮成功处理 {len(successfully_processed_lines)} 条日志记录")
                
    except Exception as e:
        APP_LOGGER.error(f"处理设备日志失败 {device_id}: {e}")
    finally:
        unregister_thread()


def _get_adaptive_max_workers(default_max, device_count):
    """根据可用内存动态调整线程池大小"""
    try:
        available_gb = None
        if HAS_PSUTIL:
            mem = psutil.virtual_memory()
            available_gb = mem.available / (1024 ** 3)
        elif not IS_WINDOWS:
            try:
                with open('/proc/meminfo') as f:
                    for line in f:
                        if line.startswith('MemAvailable:'):
                            available_gb = int(line.split()[1]) / (1024 ** 2)
                            break
            except Exception:
                pass

        if available_gb is not None:
            if available_gb < 1.0:
                APP_LOGGER.warning(
                    f"可用内存过低({available_gb:.1f}GB)，降级为串行模式")
                return 1
            elif available_gb < 2.0:
                APP_LOGGER.info(
                    f"可用内存偏低({available_gb:.1f}GB)，限制并行度为 2")
                return min(2, device_count)
            elif available_gb < 3.0:
                return min(4, device_count)
    except Exception:
        pass
    return min(default_max, device_count)


def _check_disk_space(path, min_gb):
    try:
        if IS_WINDOWS:
            if not os.path.exists(path):
                return True
            try:
                _, _, free = shutil.disk_usage(path)
                if (free / (1024 ** 3)) < min_gb:
                    APP_LOGGER.warning(f"磁盘空间不足 (少于 {min_gb} GB，路径: {path})。")
                    return False
            except Exception as e:
                APP_LOGGER.error(f"检查磁盘空间时出错: {e}")
                return False
            return True
        target_path = path if _safe_path_exists(path, timeout=5) else MAIN_LOG_ROOT_DIR_DEFAULT
        result = subprocess.run(
            ['df', '-Pk', target_path],
            capture_output=True,
            text=True,
            timeout=_CIFS_IO_TIMEOUT
        )
        if result.returncode != 0:
            APP_LOGGER.error(f"检查磁盘空间失败: {target_path}, rc={result.returncode}, err={result.stderr.strip()}")
            return False
        lines = [line for line in result.stdout.splitlines() if line.strip()]
        if len(lines) < 2:
            APP_LOGGER.error(f"检查磁盘空间失败: df 输出异常, path={target_path}")
            return False
        parts = lines[-1].split()
        if len(parts) < 4 or not parts[3].isdigit():
            APP_LOGGER.error(f"检查磁盘空间失败: 无法解析 df 输出, path={target_path}, line={lines[-1]}")
            return False
        free_kb = int(parts[3])
        if (free_kb / (1024 ** 2)) < min_gb:
            APP_LOGGER.warning(f"磁盘空间不足 (少于 {min_gb} GB，路径: {target_path})。")
            return False
        return True
    except subprocess.TimeoutExpired:
        APP_LOGGER.error(f"磁盘空间检查超时: {path}")
        return False
    except Exception as e:
        APP_LOGGER.error(f"磁盘空间检查异常: {e}")
        return False


def _fast_find_dbg_files(folder_path, serial_number, scan_cache):
    """
    优化版快速查找dbg文件：使用glob和缓存机制提高扫描效率
    """
    if not ENABLE_SCAN_CACHE:
        # 如果缓存被禁用，直接执行查找
        return _perform_fast_file_search(folder_path, serial_number)
    
    cache_key = f"{folder_path}:{serial_number}"
    current_time = time.time()
    
    # 检查缓存
    with _scan_cache_lock:
        if cache_key in _scan_cache:
            cached_data = _scan_cache[cache_key]
            if current_time - cached_data['timestamp'] < SCAN_CACHE_TIMEOUT:
                APP_LOGGER.debug(f"使用缓存结果: {cache_key}")
                return cached_data['files']
    
    # 执行快速文件搜索
    dbg_files = _perform_fast_file_search(folder_path, serial_number)
    
    # 更新缓存
    with _scan_cache_lock:
        _scan_cache[cache_key] = {
            'files': dbg_files,
            'timestamp': current_time
        }
    
    return dbg_files


def _perform_fast_file_search(folder_path, serial_number):
    """
    执行快速文件搜索 - 仅使用 subprocess find（有 timeout 保护）。
    移除了 glob.glob 回退和 os.path.exists 逐条验证，避免 CIFS D 状态。
    """
    dbg_files = []

    if IS_WINDOWS:
        if not os.path.exists(folder_path):
            return dbg_files
        try:
            glob_pattern = os.path.join(
                folder_path, f"**/*{serial_number}*/db.*.dbg")
            for fp in glob.glob(glob_pattern, recursive=True):
                dbg_files.append(fp)
                if len(dbg_files) >= LOCAL_DECRYPT_LIMIT_PER_CYCLE:
                    break
        except Exception as e:
            APP_LOGGER.debug(f"Windows glob 搜索失败: {e}")
        return dbg_files

    if not _safe_is_dir(folder_path, timeout=5):
        return dbg_files

    try:
        find_cmd = (
            f"find {folder_path} -maxdepth {MAX_SCAN_DEPTH} "
            f"-path '*{serial_number}*' -name 'db.*.dbg' "
            f"-type f 2>/dev/null | head -200"
        )
        result = subprocess.run(
            find_cmd, shell=True,
            capture_output=True, text=True,
            timeout=FIND_TIMEOUT)
        if result.returncode == 0 and result.stdout.strip():
            for fp in result.stdout.strip().split('\n'):
                if fp:
                    dbg_files.append(fp)
                    if len(dbg_files) >= LOCAL_DECRYPT_LIMIT_PER_CYCLE:
                        break
    except subprocess.TimeoutExpired:
        APP_LOGGER.warning(
            f"find 超时({FIND_TIMEOUT}s)，CIFS 可能不健康: {folder_path}")
    except Exception as e:
        APP_LOGGER.debug(f"find 命令失败: {e}")

    return dbg_files


def _pre_filter_folders(folders):
    """
    预过滤文件夹：浅层检查（不递归），避免 CIFS 上 os.walk 导致 D 状态
    """
    valid_folders = []

    for folder in folders:
        try:
            if IS_WINDOWS:
                if not os.path.exists(folder):
                    continue
                try:
                    entries = os.listdir(folder)
                except (PermissionError, OSError):
                    continue
            else:
                if not _safe_is_dir(folder, timeout=5):
                    continue
                entries = _safe_listdir(folder, timeout=5)
                if entries is None:
                    continue

            if not entries:
                continue

            if len(entries) > 5000:
                APP_LOGGER.debug(
                    f"跳过条目过多的文件夹: {folder} ({len(entries)} entries)")
                continue

            valid_folders.append(folder)

        except Exception as e:
            APP_LOGGER.debug(f"预过滤文件夹失败: {folder} - {e}")

    APP_LOGGER.debug(
        f"预过滤完成: {len(valid_folders)}/{len(folders)} 个文件夹有效")
    return valid_folders


def _batch_check_decrypted_status(dbg_files):
    """
    批量检查文件解密状态，用 _safe_* 替代 os.path.isdir/os.listdir
    """
    decrypted_files = []
    undecrypted_files = []

    for dbg_path in dbg_files:
        dec_dir = dbg_path + ".DEC"
        try:
            if IS_WINDOWS:
                if os.path.isdir(dec_dir) and os.listdir(dec_dir):
                    decrypted_files.append(dbg_path)
                    continue
            else:
                if _safe_is_dir(dec_dir, timeout=5):
                    entries = _safe_listdir(dec_dir, timeout=5)
                    if entries:
                        decrypted_files.append(dbg_path)
                        continue
            undecrypted_files.append(dbg_path)
        except Exception:
            undecrypted_files.append(dbg_path)

    return decrypted_files, undecrypted_files


def _parallel_folder_scan(current_active_folders, available_serials, max_workers=None):
    """
    并行扫描多个文件夹，提高扫描效率
    优化版本：增加超时控制、任务分批、快速过滤
    """
    if not ENABLE_PARALLEL_SCAN or max_workers is None:
        max_workers = 1
    
    all_dbg_files = set()
    scanned_paths = []
    skipped_decrypted_count = 0
    
    # 预扫描：快速过滤无效路径
    if ENABLE_FAST_PATH_FILTER:
        current_active_folders = _pre_filter_folders(current_active_folders)
        if not current_active_folders:
            APP_LOGGER.info("预扫描过滤后无有效文件夹")
            return all_dbg_files, scanned_paths, skipped_decrypted_count
    
    def scan_single_folder(folder_path, serial_number):
        nonlocal all_dbg_files, scanned_paths, skipped_decrypted_count
        
        if _should_exit or len(all_dbg_files) >= LOCAL_DECRYPT_LIMIT_PER_CYCLE:
            return
            
        # 快速查找dbg文件
        dbg_files = _fast_find_dbg_files(folder_path, serial_number, _scan_cache)
        
        if dbg_files:
            scanned_paths.extend([os.path.dirname(f) for f in dbg_files])
            
            # 批量检查解密状态
            decrypted, undecrypted = _batch_check_decrypted_status(dbg_files)
            skipped_decrypted_count += len(decrypted)
            
            # 添加未解密的文件
            for dbg_path in undecrypted:
                all_dbg_files.add(dbg_path)
                if len(all_dbg_files) >= LOCAL_DECRYPT_LIMIT_PER_CYCLE:
                    break
    
    # 创建并行任务 - 优化：限制任务数量，避免过多并发
    scan_tasks = []
    task_count = 0
    max_tasks = min(len(current_active_folders) * len(available_serials), 50)  # 限制最多50个任务
    
    for folder_path in current_active_folders:
        for serial_number in available_serials:
            if task_count >= max_tasks:
                break
            scan_tasks.append((folder_path, serial_number))
            task_count += 1
        if task_count >= max_tasks:
            break
    
    if not scan_tasks:
        return all_dbg_files, scanned_paths, skipped_decrypted_count
    
    APP_LOGGER.info(f"开始并行扫描 {len(scan_tasks)} 个任务，使用 {max_workers} 个工作线程")
    
    # 使用线程池并行扫描 - 优化：增加超时控制
    with ThreadPoolExecutor(max_workers=max_workers, thread_name_prefix="FolderScanner") as executor:
        futures = []
        for folder_path, serial_number in scan_tasks:
            if _should_exit or len(all_dbg_files) >= LOCAL_DECRYPT_LIMIT_PER_CYCLE:
                break
            future = executor.submit(scan_single_folder, folder_path, serial_number)
            futures.append(future)
        
        # 等待所有任务完成 - 优化：增加超时时间
        completed_count = 0
        failed_count = 0
        
        for future in as_completed(futures, timeout=SCAN_TASK_TIMEOUT):
            try:
                future.result(timeout=10)
                completed_count += 1
            except Exception as e:
                failed_count += 1
                APP_LOGGER.error(f"文件夹扫描任务失败: {e}")
        
        # 检查未完成的任务
        if len(futures) > completed_count + failed_count:
            timeout_count = len(futures) - completed_count - failed_count
            APP_LOGGER.warning(f"有 {timeout_count} 个扫描任务超时未完成")
        
        APP_LOGGER.info(f"扫描任务完成: 成功 {completed_count} 个，失败 {failed_count} 个")
    
    return all_dbg_files, list(set(scanned_paths)), skipped_decrypted_count


def process_local_undecrypted_logs(main_log_root_dir, cache_data, node_coordinator=None):
    """
    优化版智能本地解密扫描：使用缓存、并行处理和高效文件查找
    集成节点协调机制，避免多节点并发时的重复扫描问题
    """
    try:
        with APP_LOGGER.context(tag="LocalDecryptScan"):
            if not ENABLE_LOCAL_DECRYPT_SCAN or not _check_disk_space(main_log_root_dir, MIN_FREE_DISK_SPACE_GB):
                return
                
            decryption_tasks = cache_data.setdefault("decryption_tasks", {})
            processed_history = cache_data.get("processed_history", {})
            
            # 获取缓存中所有的序列号
            cached_serial_numbers = set(processed_history.keys())
            if not cached_serial_numbers:
                APP_LOGGER.info("缓存中没有序列号信息，跳过本地解密扫描。")
                return
            
            # 如果启用了节点协调，先清理过期锁并获取可处理的序列号
            available_serials = cached_serial_numbers
            locked_serials = []
            acquired_locks = []
            
            if ENABLE_NODE_COORDINATION and node_coordinator:
                # 清理过期的锁
                node_coordinator.cleanup_expired_locks()
                
                # 获取当前被锁定的序列号
                locked_serials = set(node_coordinator.get_locked_serials())
                
                # 尝试为可用的序列号获取锁
                available_serials = []
                for serial in cached_serial_numbers:
                    if serial in locked_serials:
                        APP_LOGGER.debug(f"序列号 {serial} 已被其他节点锁定，跳过")
                        continue
                        
                    if node_coordinator.acquire_serial_lock(serial):
                        available_serials.append(serial)
                        acquired_locks.append(serial)
                    else:
                        APP_LOGGER.debug(f"无法获取序列号 {serial} 的锁")
                
                if not available_serials:
                    APP_LOGGER.info("所有序列号都被其他节点锁定，本轮跳过解密扫描")
                    return
                    
                APP_LOGGER.info(f"节点协调: 获取了 {len(acquired_locks)} 个序列号的锁，跳过了 {len(locked_serials)} 个被锁定的序列号")
            
            APP_LOGGER.info(f"基于 {len(available_serials)} 个可用序列号进行智能扫描: {', '.join(list(available_serials)[:5])}{'...' if len(available_serials) > 5 else ''}")
            
            try:
                # 基于_get_aee_log_folder_name参数生成当前脚本可能创建或使用的文件夹列表
                current_active_folders = []
                try:
                    # 获取当前连接的设备列表
                    current_devices = get_connected_devices()
                    if not current_devices:
                        APP_LOGGER.info("当前无连接设备，跳过本轮扫描")
                        return
                    
                    # 为每个当前连接的设备生成对应的文件夹路径
                    for device_id in current_devices:
                        base_folder_name = _get_aee_log_folder_name(device_id, run_date_stamp)
                        if base_folder_name:
                            device_folder_path = os.path.join(main_log_root_dir, base_folder_name)
                            if os.path.isdir(device_folder_path) and device_folder_path not in current_active_folders:
                                current_active_folders.append(device_folder_path)
                    
                    if not current_active_folders:
                        APP_LOGGER.info("未找到当前脚本创建或使用的MonkeyAEEinfo文件夹，跳过本轮扫描")
                        return
                    
                    APP_LOGGER.info(f"基于当前连接设备识别到 {len(current_active_folders)} 个活跃的 MonkeyAEEinfo 文件夹")
                    
                except Exception as e:
                    APP_LOGGER.warning(f"获取当前活跃文件夹列表失败，跳过本轮扫描: {e}")
                    return
                
                # 使用优化的并行扫描
                scan_start_time = time.time()
                all_dbg_files, scanned_paths, skipped_decrypted_count = _parallel_folder_scan(
                    current_active_folders, available_serials, max_workers=PARALLEL_SCAN_WORKERS
                )
                scan_duration = time.time() - scan_start_time
                
                # 记录扫描性能
                APP_LOGGER.info(f"优化扫描完成，耗时: {scan_duration:.2f}秒，扫描路径: {len(scanned_paths)}，"
                              f"发现未解密文件: {len(all_dbg_files)}，跳过已解密文件: {skipped_decrypted_count}")
                
                # 筛选需要解密的文件
                to_decrypt_list = []
                for dbg_path in all_dbg_files:
                    if _should_exit:
                        break
                        
                    # 检查是否已达到重试限制
                    if decryption_tasks.get(dbg_path, {}).get("attempts", 0) >= DECRYPT_RETRY_LIMIT:
                        continue
                        
                    to_decrypt_list.append(dbg_path)
                    
                if not to_decrypt_list:
                    APP_LOGGER.info("未发现需要解密的本地存量日志。")
                    return
                    
                APP_LOGGER.info(f"本轮将处理 {len(to_decrypt_list)} 个待解密文件")
                logs_this_cycle = to_decrypt_list
                
                # 使用优化的线程池进行解密
                max_workers = min(4, len(logs_this_cycle))  # 增加并发数
                with ThreadPoolExecutor(max_workers=max_workers, thread_name_prefix="DecryptWorker") as executor:
                    future_to_path = {executor.submit(_decrypt_aee_log, path): path for path in logs_this_cycle}
                    
                    # 添加超时控制 - 优化：使用更合理的总超时时间
                    completed_futures = []
                    try:
                        # 计算总超时时间：单个文件超时 × 文件数量 × 安全系数
                        total_timeout = DECRYPT_SINGLE_LOG_TIMEOUT * len(logs_this_cycle) * 1.5
                        # 设置最大总超时时间为1小时
                        total_timeout = min(total_timeout, 3600)
                        
                        APP_LOGGER.info(f"开始解密 {len(logs_this_cycle)} 个文件，总超时时间: {total_timeout/60:.1f}分钟")
                        
                        for future in as_completed(future_to_path, timeout=total_timeout):
                            if _should_exit:
                                break
                                
                            path = future_to_path[future]
                            completed_futures.append(future)
                            
                            try:
                                if not future.result(timeout=10):
                                    task_info = decryption_tasks.get(path, {"attempts": 0})
                                    task_info["attempts"] += 1
                                    decryption_tasks[path] = task_info
                                    if task_info["attempts"] >= DECRYPT_RETRY_LIMIT:
                                        APP_LOGGER.critical(
                                            f"文件 {os.path.basename(path)} 已达到最大重试次数({DECRYPT_RETRY_LIMIT})，将不再处理。")
                            except Exception as e:
                                APP_LOGGER.error(f"解密执行器线程中发生错误，路径: {path}, 错误: {e}")
                                
                    except FutureTimeoutError:
                        timeout_count = len(future_to_path) - len(completed_futures)
                        APP_LOGGER.error(f"解密任务整体超时，有 {timeout_count} 个任务未完成")
                        
                    # 取消未完成的任务
                    for future in future_to_path:
                        if future not in completed_futures:
                            future.cancel()
                            
            finally:
                # 释放获取的锁
                if ENABLE_NODE_COORDINATION and node_coordinator and acquired_locks:
                    for serial in acquired_locks:
                        node_coordinator.release_serial_lock(serial)
                    APP_LOGGER.info(f"释放了 {len(acquired_locks)} 个序列号的锁")
                        
    except Exception as e:
        unfinished_count = len(future_to_path) - len(completed_futures) if 'future_to_path' in locals() else 0
        total_count = len(future_to_path) if 'future_to_path' in locals() else 0
        APP_LOGGER.error(f"处理本地未解密日志失败: {unfinished_count} (of {total_count}) futures unfinished, 错误: {e}")


def check_and_manage_monkey_process(device_id, monkey_runner):
    try:
        register_thread()
        with APP_LOGGER.context(tag=f"MonkeyManager", sn=device_id):
            pids_str = run_adb_command(["shell", "pgrep", "-f", MONKEY_PROCESS_NAME_TO_CHECK], 
                                     device_id=device_id, timeout=15)
            found_pids = pids_str.split() if pids_str else []
            
            if len(found_pids) > 1:
                APP_LOGGER.warning(f"检测到 {len(found_pids)} 个重复Monkey进程，将进行清理。")
                for pid_to_kill in found_pids[1:]:
                    run_adb_command(["shell", "kill", "-9", pid_to_kill], device_id=device_id, timeout=10)
                return
                
            if len(found_pids) == 1:
                return
                
            APP_LOGGER.warning(f"未发现Monkey进程。正在检查设备环境...")
            key_resource_path = "/data/local/tmp/MonkeyTest.sh"
            resource_exists = run_adb_command(["shell", f"[ -f {key_resource_path} ] && echo 'exists'"],
                                            device_id=device_id, timeout=10)
            if resource_exists == 'exists':
                if run_adb_command(["shell", "pgrep", "-f", "system_server"], device_id=device_id, timeout=10):
                    APP_LOGGER.info("system_server存活，开始重启Monkey...")
                    run_adb_command(["shell", DUMPSYS_APPOPS_COMMAND], device_id=device_id, timeout=15)
                    time.sleep(3)
                    run_adb_command(["shell", MONKEY_FULL_RESTART_COMMAND], device_id=device_id, timeout=20)
            else:
                APP_LOGGER.info(f"关键资源不存在，执行完整设置。")
                try:
                    monkey_runner.start_test_for_device(device_id)
                except Exception as e:
                    APP_LOGGER.error(f"为设备 {device_id} 执行完整Monkey设置时出错: {e}")
    except Exception as e:
        APP_LOGGER.error(f"检查和管理Monkey进程失败 {device_id}: {e}")
    finally:
        unregister_thread()


def _run_device_tasks(device_id, main_log_root_dir, whitelist, monkey_runner, run_date_stamp):
    """增强版设备任务处理函数，增加异常处理、超时控制和root权限检查"""
    try:
        register_thread()
        with APP_LOGGER.context(sn=device_id):
            if _should_exit:
                return
                
            # 检查设备连接状态
            device_status = run_adb_command(["get-state"], device_id=device_id, timeout=10)
            if device_status != "device":
                APP_LOGGER.warning(f"设备状态异常: {device_status}")
                return
                
            # 确保设备具有root权限
            if not _ensure_device_root_access(device_id):
                APP_LOGGER.error(f"设备 {device_id} 无法获取root权限，跳过日志处理")
                return
                
            check_and_manage_monkey_process(device_id, monkey_runner)
            
            if _should_exit:
                return
                
            base_folder_name = _get_aee_log_folder_name(device_id, run_date_stamp)
            if base_folder_name:
                device_output_dir = os.path.join(main_log_root_dir, base_folder_name, device_id)
                if not _ensure_output_subdir_ready(device_output_dir):
                    APP_LOGGER.warning(f"设备输出目录不可用，跳过本轮日志处理: {device_output_dir}")
                    return
                process_device_logs(device_id, whitelist, device_output_dir)
                
    except Exception as e:
        APP_LOGGER.error(f"设备任务处理失败 {device_id}: {e}")
        global _consecutive_failures
        _consecutive_failures += 1
    finally:
        unregister_thread()


def main_loop(main_log_root_dir, whitelist, monkey_runner, cache_manager, cache_data, run_date_stamp, node_coordinator=None, cifs_probe=None):
    """
    脚本主循环。
    [修复版本] 增强了异常处理、超时控制和资源管理，解决了卡死问题。
    [节点协调版本] 集成节点协调机制，避免多节点并发冲突。
    [CIFS防护版] 每轮检查CIFS健康，不健康时跳过CIFS操作并尝试恢复。
    """
    first_cycle_setup_done = False
    global _consecutive_failures

    try:
        while not _should_exit:
            try:
                with APP_LOGGER.context(tag="ScanCycle"):
                    loop_start_time = time.time()
                    update_heartbeat()
                    
                    APP_LOGGER.info(f"--- 开始新的扫描周期 ({datetime.now().strftime('%Y-%m-%d %H:%M:%S')}) ---")
                    APP_LOGGER.info(f"活跃线程数: {get_active_thread_count()}, 连续失败次数: {_consecutive_failures}")

                    # ---- CIFS 挂载健康检查 ----
                    if not IS_WINDOWS and cifs_probe and CIFS_PROTECTION_ENABLED:
                        if not cifs_probe.is_mount_healthy():
                            reason = cifs_probe.last_failure_reason or "unknown"

                            # io_slow/disk_full: 磁盘满或 I/O 卡顿，重挂载无效，退避等待
                            if reason in ("io_slow", "disk_full"):
                                backoff_secs = min(600, 60 * (cifs_probe._consecutive_failures + 1))
                                APP_LOGGER.warning(
                                    f"CIFS I/O 缓慢或磁盘空间不足 (reason={reason})，"
                                    f"重挂载无法解决此问题，跳过本轮，退避 {backoff_secs}s")
                                time.sleep(backoff_secs)
                                continue

                            # error/write_readonly: 挂载可能真的异常，尝试恢复
                            APP_LOGGER.error(f"CIFS 挂载不健康 (reason={reason})，尝试恢复...")
                            if CIFS_ENABLE_AUTO_REMOUNT:
                                recovered = cifs_probe.try_recover_mount(
                                    main_log_root_dir, MOUNT_SERVER_IP,
                                    MOUNT_USERNAME, MOUNT_PASSWORD, SUDO_PASSWORDS)
                                if not recovered:
                                    APP_LOGGER.error(
                                        "CIFS 恢复失败，跳过本轮 CIFS 操作，60秒后重试")
                                    time.sleep(60)
                                    continue
                                APP_LOGGER.info("CIFS 挂载已恢复")
                            else:
                                APP_LOGGER.error("自动重挂载已禁用，跳过本轮，60秒后重试")
                                time.sleep(60)
                                continue

                    # 系统健康检查
                    if not check_system_health():
                        APP_LOGGER.warning("系统健康检查失败，但继续执行")
                    
                    # 清理过期的扫描缓存
                    cleanup_scan_cache()

                    # 检查连续失败次数
                    if _consecutive_failures >= MAX_CONSECUTIVE_FAILURES:
                        APP_LOGGER.error(f"连续失败次数达到阈值({MAX_CONSECUTIVE_FAILURES})，等待恢复...")
                        time.sleep(60)  # 等待1分钟后重试
                        _consecutive_failures = 0
                        continue

                    devices = get_connected_devices()
                    if not devices:
                        APP_LOGGER.warning("未检测到连接的设备，等待下一轮扫描。")
                        time.sleep(POLLING_INTERVAL_SECONDS)
                        continue

                    if not first_cycle_setup_done:
                        APP_LOGGER.info("--- 首个扫描周期：开始为所有在线设备执行一次性前置配置 ---")
                        # 使用较小的线程池进行设备初始化
                        with ThreadPoolExecutor(max_workers=min(4, len(devices)), thread_name_prefix="DeviceInit") as init_executor:
                            init_futures = {init_executor.submit(monkey_runner.start_test_for_device, device): device for device in devices}
                            
                            try:
                                for future in as_completed(init_futures, timeout=300):  # 5分钟超时
                                    if _should_exit:
                                        break
                                    device = init_futures[future]
                                    try:
                                        future.result(timeout=10)
                                    except Exception as e:
                                        APP_LOGGER.error(f"设备初始化失败 {device}: {e}")
                            except FutureTimeoutError:
                                APP_LOGGER.error("设备初始化整体超时")
                                
                        first_cycle_setup_done = True

                    APP_LOGGER.info(f"发现 {len(devices)} 台设备，开始常规检查: {', '.join(devices)}")

                    # 使用自适应线程池处理设备任务
                    max_workers = _get_adaptive_max_workers(MAX_THREAD_POOL_WORKERS, len(devices))
                    APP_LOGGER.info(f"当前自适应线程池大小: {max_workers}")
                    with ThreadPoolExecutor(max_workers=max_workers, thread_name_prefix="DeviceWorker") as executor:
                        device_futures = {
                            executor.submit(_run_device_tasks, device, main_log_root_dir, whitelist, monkey_runner, run_date_stamp): device 
                            for device in devices
                        }

                        completed_count = 0
                        try:
                            for future in as_completed(device_futures, timeout=THREAD_TIMEOUT_SECONDS):
                                if _should_exit:
                                    break
                                    
                                device = device_futures[future]
                                completed_count += 1
                                
                                try:
                                    future.result(timeout=30)  # 获取结果时设置较短超时
                                    APP_LOGGER.debug(f"设备任务完成 ({completed_count}/{len(devices)}): {device}")
                                except Exception as e:
                                    APP_LOGGER.error(f"设备任务执行异常 {device}: {e}")
                                    
                        except FutureTimeoutError:
                            APP_LOGGER.error("设备任务整体超时，取消剩余任务")
                            
                        # 取消未完成的任务
                        for future in device_futures:
                            if not future.done():
                                future.cancel()

                    # 处理本地解密任务（传递节点协调器）
                    if not _should_exit:
                        process_local_undecrypted_logs(main_log_root_dir, cache_data, node_coordinator)

                    # 保存缓存
                    if not _should_exit:
                        try:
                            cache_manager.save(cache_data)
                        except Exception as e:
                            APP_LOGGER.error(f"保存缓存失败: {e}")

                    # 重置连续失败计数器（如果本轮成功）
                    _consecutive_failures = 0
                    
                    # 计算循环耗时并等待
                    loop_duration = time.time() - loop_start_time
                    APP_LOGGER.info(f"扫描周期完成，耗时: {loop_duration:.2f}秒")
                    
                    if loop_duration < POLLING_INTERVAL_SECONDS and not _should_exit:
                        sleep_time = POLLING_INTERVAL_SECONDS - loop_duration
                        APP_LOGGER.info(f"等待 {sleep_time:.1f} 秒后开始下一轮扫描...")
                        
                        # 分段睡眠，以便及时响应退出信号
                        sleep_segments = int(sleep_time / 5) + 1
                        for _ in range(sleep_segments):
                            if _should_exit:
                                break
                            time.sleep(min(5, sleep_time / sleep_segments))

            except KeyboardInterrupt:
                APP_LOGGER.info("接收到键盘中断信号，开始退出...")
                break
            except Exception as e:
                APP_LOGGER.error(f"主循环发生未预期异常: {e}")
                _consecutive_failures += 1
                time.sleep(30)  # 异常后等待30秒
                
    except Exception as e:
        APP_LOGGER.critical(f"主循环致命错误: {e}")
    finally:
        APP_LOGGER.info("主循环退出，开始清理资源...")


def _validate_security_config():
    """验证安全相关的配置是否已正确设置（仅警告，不强制退出）"""
    missing_configs = []
    
    if not MOUNT_USERNAME:
        missing_configs.append("MOUNT_USERNAME (mount.username)")
    if not MOUNT_PASSWORD:
        missing_configs.append("MOUNT_PASSWORD (mount.password)")
    if not SUDO_PASSWORDS:
        missing_configs.append("SUDO_PASSWORDS (mount.sudo_passwords)")
    
    if missing_configs:
        print("=" * 60)
        print("配置警告: 以下配置项未设置，挂载功能可能无法正常工作")
        print("=" * 60)
        for config in missing_configs:
            print(f"  - {config}")
        print()
        print("可通过以下方式设置:")
        print("  1. 在 config.json 中配置 (推荐内部使用)")
        print("  2. 通过环境变量设置 (优先级更高)")
        print("=" * 60)
        # 返回True，仅警告不强制退出
        return True
    
    return True


if __name__ == "__main__":
    try:
        with APP_LOGGER.context(tag="Initialization"):
            if len(sys.argv) < 2:
                print("用法: python3 MonkeyAEEinfo_V551A_fixed.py <MMDD>")
                sys.exit(1)

            run_date_stamp = sys.argv[1]
            main_log_root_dir = MAIN_LOG_ROOT_DIR_DEFAULT  # 使用配置文件中的路径
            
            # 验证配置（仅警告）
            _validate_security_config()
            
            APP_LOGGER.info(f"主日志目录: {main_log_root_dir}")
            
            # 检查主日志目录
            if IS_WINDOWS:
                # Windows系统：不需要挂载，只检查目录是否存在
                APP_LOGGER.info("Windows系统：跳过挂载检查")
                if not os.path.exists(main_log_root_dir):
                    APP_LOGGER.info(f"创建主日志目录: {main_log_root_dir}")
                    os.makedirs(main_log_root_dir, exist_ok=True)
                APP_LOGGER.info(f"主日志目录检查完成: {main_log_root_dir}")
            else:
                # Linux系统：检查挂载状态
                APP_LOGGER.info("开始检查主日志目录和挂载状态...")
                if not ensure_directory_mounted(
                    main_log_root_dir, 
                    MOUNT_SERVER_IP, 
                    MOUNT_USERNAME, 
                    MOUNT_PASSWORD, 
                    SUDO_PASSWORDS
                ):
                    APP_LOGGER.error(f"主日志目录挂载失败: {main_log_root_dir}")
                    sys.exit(1)
                APP_LOGGER.info(f"主日志目录检查完成: {main_log_root_dir}")
                
            if ENABLE_LOCAL_DECRYPT_SCAN and not os.path.isfile(AEE_EXTRACT_TOOL_PATH):
                APP_LOGGER.warning(f"AEE解密工具未找到: {AEE_EXTRACT_TOOL_PATH}，将禁用本地解密功能")
                ENABLE_LOCAL_DECRYPT_SCAN = False

            # 初始化缓存管理器
            cache_file_path = os.path.join(SCRIPT_BASE_DIR, "processed_log_cache.json")
            cache_manager = CacheManager(cache_file_path)
            _CACHE_MANAGER_REF = cache_manager
            cache_data = cache_manager.load()
            PROCESSED_DB_HISTORY_CACHE.update(cache_data)

            # 初始化 CIFS 健康探测器（仅 Linux）
            cifs_probe = None
            if not IS_WINDOWS and CIFS_PROTECTION_ENABLED:
                cifs_probe = CIFSHealthProbe(main_log_root_dir, CIFS_PROBE_TIMEOUT)
                _RUNTIME_CIFS_PROBE = cifs_probe
                APP_LOGGER.info(f"CIFS 健康探测器已初始化 (超时={CIFS_PROBE_TIMEOUT}s)")

            # 初始化节点协调器
            node_coordinator = None
            if ENABLE_NODE_COORDINATION:
                try:
                    node_coordinator = NodeCoordinator(
                        NODE_LOCK_DIR, NODE_ID, NODE_LOCK_TIMEOUT,
                        cifs_probe=cifs_probe)
                    APP_LOGGER.info(f"节点协调器初始化成功，节点ID: {NODE_ID}")
                except Exception as e:
                    APP_LOGGER.error(f"节点协调器初始化失败: {e}，将禁用节点协调功能")
                    ENABLE_NODE_COORDINATION = False

            # 加载白名单
            whitelist_file_path = os.path.join(SCRIPT_BASE_DIR, "AEE_whitelist.txt")
            whitelist = load_whitelist(whitelist_file_path)

            # 初始化Monkey测试器
            monkey_runner = MonkeyTest(
                push_res=True, is_sleep=False, is_aimonkey=True, 
                play_video=False, memory_rw=False
            )

            APP_LOGGER.info("初始化完成，即将进入主监控循环。")
            APP_LOGGER.info(f"配置信息: 线程池大小={MAX_THREAD_POOL_WORKERS}, 任务超时={THREAD_TIMEOUT_SECONDS}s, 心跳间隔={HEARTBEAT_INTERVAL}s")
            if ENABLE_NODE_COORDINATION:
                APP_LOGGER.info(f"节点协调: 启用, 锁目录={NODE_LOCK_DIR}, 锁超时={NODE_LOCK_TIMEOUT}s")

        # 启动主循环
        main_loop(main_log_root_dir, whitelist, monkey_runner, cache_manager, cache_data, run_date_stamp, node_coordinator, cifs_probe)
        
    except KeyboardInterrupt:
        APP_LOGGER.info("程序被用户中断")
    except Exception as e:
        APP_LOGGER.critical(f"程序启动失败: {e}")
        sys.exit(1)
    finally:
        APP_LOGGER.info("程序退出完成")
        # 确保所有线程都已结束
        active_count = get_active_thread_count()
        if active_count > 0:
            APP_LOGGER.warning(f"仍有 {active_count} 个活跃线程未结束")
            time.sleep(2)  # 给线程一些时间自然结束
