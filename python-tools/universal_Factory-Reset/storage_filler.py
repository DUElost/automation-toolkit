# 文件名: storage_filler.py
import os
import re
import time
import random
import subprocess
import logging

# 创建一个默认的日志记录器，以防外部没有提供
# 这样即使独立运行，也能看到日志
DEFAULT_LOGGER = logging.getLogger('storage_filler')
if not DEFAULT_LOGGER.handlers:
    handler = logging.StreamHandler()
    formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s')
    handler.setFormatter(formatter)
    DEFAULT_LOGGER.addHandler(handler)
    DEFAULT_LOGGER.setLevel(logging.INFO)

def _log(message, level='info', logger=None):
    """一个统一的日志/打印函数"""
    effective_logger = logger if logger else DEFAULT_LOGGER
    if level == 'info':
        effective_logger.info(message)
    elif level == 'warning':
        effective_logger.warning(message)
    elif level == 'error':
        effective_logger.error(message)
    else:
        effective_logger.debug(message)


def _get_storage_info(device_id, logger=None):
    """获取存储信息，并使用指定的logger记录日志"""
    try:
        command = ["adb", "-s", device_id, "shell", "df", "/data"]
        output = subprocess.check_output(command, text=True, stderr=subprocess.STDOUT)
        lines = output.strip().split('\n')
        if len(lines) < 2:
            raise RuntimeError("无法解析存储信息：'df' 命令输出格式不符。")

        parts = lines[1].split()
        total_kb = int(parts[1])
        used_kb = int(parts[2])
        total_gb = total_kb / (1024 * 1024)
        used_gb = used_kb / (1024 * 1024)
        return round(total_gb, 2), round(used_gb, 2)
    except (subprocess.CalledProcessError, ValueError, IndexError) as e:
        _log(f"获取或解析存储信息时出错: {e}", level='error', logger=logger)
        raise e


def _calculate_fill_size_mb(total_space_gb, used_space_gb, target_percentage):
    """根据目标百分比计算需要填充的大小（MB）"""
    if not 0 < target_percentage <= 100:
        raise ValueError("目标百分比必须在 0 到 100 之间。")
    target_used_space_gb = total_space_gb * (target_percentage / 100)
    fill_size_gb = target_used_space_gb - used_space_gb
    return max(0, int(fill_size_gb * 1024))


def _fill_in_chunks(device_id, fill_size_mb, logger=None, chunk_size_mb=2048):
    """分块填充存储空间"""
    filled_total_mb = 0
    remaining_mb = fill_size_mb

    while remaining_mb > 0:
        current_chunk = min(remaining_mb, chunk_size_mb)
        unique_id = f"{int(time.time())}_{random.randint(1000, 9999)}"
        file_name = f"/sdcard/fill_file_{unique_id}.tmp"
        
        command = f'adb -s {device_id} shell "dd if=/dev/zero of={file_name} bs=1M count={current_chunk}"'
        _log(f"正在向设备 {device_id} 写入 {current_chunk}MB...", logger=logger)

        process = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        stdout, stderr = process.communicate()

        if process.returncode != 0:
            error_msg = stderr.decode('utf-8', 'ignore').strip()
            _log(f"填充失败: {error_msg}", level='error', logger=logger)
            # 在非交互模式下，失败时直接抛出异常
            raise RuntimeError(f"填充块失败: {error_msg}")
        
        filled_total_mb += current_chunk
        remaining_mb -= current_chunk
        _log(f"已填充 {filled_total_mb} MB / {fill_size_mb} MB", logger=logger)
    
    _log(f"成功填充完毕！总计写入 {filled_total_mb} MB。", logger=logger)
    return True


def fill_device_storage_to_percentage(target_percentage, device_id, logger=None, non_interactive=True):
    """
    将指定设备的存储空间填充到目标百分比。

    Args:
        target_percentage (float): 目标存储占用百分比 (例如 80)。
        device_id (str): 目标设备的ADB序列号 (SN)。
        logger (logging.Logger, optional): 用于记录日志的记录器实例。如果为None，则使用默认的打印输出。
        non_interactive (bool, optional): 是否为非交互模式。在此模式下，不会有任何用户输入提示。默认为True。

    Returns:
        bool: 如果操作成功完成则返回 True，否则返回 False。
    """
    _log(f"开始执行内存填充任务，目标: {target_percentage}%", logger=logger)
    try:
        # 1. 获取存储信息
        total_gb, used_gb = _get_storage_info(device_id, logger)
        current_percentage = (used_gb / total_gb) * 100 if total_gb > 0 else 0
        _log(f"设备 {device_id} 当前存储: {used_gb:.2f}GB / {total_gb:.2f}GB ({current_percentage:.2f}%)", logger=logger)

        # 2. 计算需要填充的大小
        fill_mb = _calculate_fill_size_mb(total_gb, used_gb, target_percentage)

        if fill_mb == 0:
            _log(f"当前占用率已达标，无需填充。", logger=logger)
            return True

        _log(f"需填充大小: {fill_mb} MB ({fill_mb/1024:.2f} GB)", logger=logger)
        
        if not non_interactive:
            confirm = input("是否开始执行填充操作？(Y/N): ").strip().upper()
            if confirm != 'Y':
                _log("用户取消了操作。", logger=logger)
                return False

        # 3. 执行填充
        success = _fill_in_chunks(device_id, fill_mb, logger)
        
        # 4. 再次检查最终状态
        final_total_gb, final_used_gb = _get_storage_info(device_id, logger)
        final_percentage = (final_used_gb / final_total_gb) * 100 if final_total_gb > 0 else 0
        _log(f"任务完成。最终存储: {final_used_gb:.2f}GB ({final_percentage:.2f}%)", logger=logger)
        
        return success

    except Exception as e:
        _log(f"内存填充操作失败: {e}", level='error', logger=logger)
        return False