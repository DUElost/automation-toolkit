"""
Excel读取模块 - 读取源数据文件
从trace_analyse_result文件中提取总丢帧数
"""
from pathlib import Path
import pandas as pd
import logging
from typing import List, Optional, Union

from .config import (
    SOURCE_SHEET_NAME,
    SOURCE_DATA_COLUMN,
    SLIDING_SOURCE_COLUMN_33MS,
    SLIDING_SOURCE_COLUMN_50MS,
    SLIDING_SOURCE_COLUMN_TOTAL,
    TRACE_FILE_PATTERN
)

logger = logging.getLogger(__name__)


def find_trace_file(directory: Path) -> Optional[Path]:
    """
    在指定目录中查找Excel文件（.xls 或 .xlsx）
    不限制文件名，获取目录中第一个Excel文件

    Args:
        directory: 要搜索的目录路径

    Returns:
        找到的文件路径，未找到则返回None
    """
    if not directory.is_dir():
        return None

    for file in directory.iterdir():
        if file.is_file() and file.suffix in ['.xls', '.xlsx']:
            return file
    return None


def read_drop_frames(file_path: Path) -> List[Union[int, None]]:
    """
    读取trace_analyse_result文件，返回总丢帧数列的所有值（包含空值）
    保留源数据中的None值，在目标表格中对应位置也写入None

    Args:
        file_path: trace_analyse_result文件路径

    Returns:
        总丢帧数值列表（可能包含None）
    """
    try:
        # 尝试读取Excel文件
        df = pd.read_excel(file_path, sheet_name=SOURCE_SHEET_NAME)

        if SOURCE_DATA_COLUMN not in df.columns:
            logger.warning(f"文件 {file_path} 中未找到列 '{SOURCE_DATA_COLUMN}'")
            return []

        # 提取总丢帧数列，保留空值
        result = []
        for val in df[SOURCE_DATA_COLUMN]:
            if pd.isna(val):
                result.append(None)
            else:
                result.append(int(val))

        logger.debug(f"从 {file_path.name} 读取到 {len(result)} 个数据（含空值）")
        return result

    except Exception as e:
        logger.error(f"读取文件 {file_path} 时出错: {e}")
        return []


def collect_all_drop_frames(folder: Path) -> List[Union[int, None]]:
    """
    收集指定文件夹下所有时间戳子文件夹中的丢帧数据
    支持两种文件结构:
    1. 数据文件在父文件夹根目录 (如: 1短信启动/trace_analyse_result_*.xls)
    2. 数据文件在各时间戳子文件夹内 (如: 9滑动解锁/20251209_xxxxx/trace_analyse_result_*.xls)

    Args:
        folder: 源文件夹路径（如 1短信启动）

    Returns:
        所有总丢帧数值的列表（按时间戳文件夹名称排序）
    """
    all_data = []

    if not folder.is_dir():
        logger.warning(f"路径不是文件夹: {folder}")
        return all_data

    # 策略1: 先检查父文件夹根目录是否有 trace_analyse_result 文件
    root_trace_file = find_trace_file(folder)
    if root_trace_file:
        logger.info(f"在根目录找到数据文件: {root_trace_file.name}")
        data = read_drop_frames(root_trace_file)
        all_data.extend(data)
        return all_data

    # 策略2: 如果根目录没有文件，则遍历子文件夹查找
    subdirs = sorted([d for d in folder.iterdir() if d.is_dir()])

    for subdir in subdirs:
        trace_file = find_trace_file(subdir)
        if trace_file:
            logger.info(f"在子文件夹 {subdir.name} 找到数据文件: {trace_file.name}")
            data = read_drop_frames(trace_file)
            all_data.extend(data)
        else:
            logger.debug(f"子文件夹 {subdir.name} 中未找到trace_analyse_result文件")

    return all_data


def read_sliding_drop_frames(file_path: Path) -> dict:
    """
    读取滑动丢帧数据，返回 FrameOver33ms、FrameOver50ms 和总丢帧数的所有值列表

    Args:
        file_path: trace_analyse_result文件路径

    Returns:
        包含 values_33ms, values_50ms, values_total, count_33ms, count_50ms 的字典
    """
    try:
        df = pd.read_excel(file_path, sheet_name=SOURCE_SHEET_NAME)

        logger.info(f"文件 {file_path.name} 中的列: {list(df.columns)}")

        result = {
            "values_33ms": [],
            "values_50ms": [],
            "values_total": [],
            "count_33ms": 0,
            "count_50ms": 0,
            "found_file": str(file_path)
        }

        # 读取 FrameOver33ms 列
        if SLIDING_SOURCE_COLUMN_33MS in df.columns:
            values_33ms = []
            for val in df[SLIDING_SOURCE_COLUMN_33MS]:
                if pd.notna(val):
                    values_33ms.append(int(val))
                else:
                    values_33ms.append(None)
            result["values_33ms"] = values_33ms
            result["count_33ms"] = int((df[SLIDING_SOURCE_COLUMN_33MS] > 0).sum())
            logger.info(f"从 {file_path.name} 读取 FrameOver33ms: 值个数={len(values_33ms)}, >0计数={result['count_33ms']}")
        else:
            logger.warning(f"文件 {file_path} 中未找到列 '{SLIDING_SOURCE_COLUMN_33MS}'")

        # 读取 FrameOver50ms 列
        if SLIDING_SOURCE_COLUMN_50MS in df.columns:
            values_50ms = []
            for val in df[SLIDING_SOURCE_COLUMN_50MS]:
                if pd.notna(val):
                    values_50ms.append(int(val))
                else:
                    values_50ms.append(None)
            result["values_50ms"] = values_50ms
            result["count_50ms"] = int((df[SLIDING_SOURCE_COLUMN_50MS] > 0).sum())
            logger.info(f"从 {file_path.name} 读取 FrameOver50ms: 值个数={len(values_50ms)}, >0计数={result['count_50ms']}")
        else:
            logger.warning(f"文件 {file_path} 中未找到列 '{SLIDING_SOURCE_COLUMN_50MS}'")

        # 读取 总丢帧数 列
        if SLIDING_SOURCE_COLUMN_TOTAL in df.columns:
            values_total = []
            for val in df[SLIDING_SOURCE_COLUMN_TOTAL]:
                if pd.notna(val):
                    values_total.append(int(val))
                else:
                    values_total.append(None)
            result["values_total"] = values_total
            logger.info(f"从 {file_path.name} 读取 总丢帧数: 值个数={len(values_total)}")
        else:
            logger.warning(f"文件 {file_path} 中未找到列 '{SLIDING_SOURCE_COLUMN_TOTAL}'")

        return result

    except Exception as e:
        logger.error(f"读取文件 {file_path} 时出错: {e}")
        return {
            "values_33ms": [],
            "values_50ms": [],
            "values_total": [],
            "count_33ms": 0,
            "count_50ms": 0,
            "found_file": str(file_path)
        }


def collect_sliding_drop_frames(folder: Path) -> dict:
    """
    收集指定文件夹下的滑动丢帧数据
    支持两种文件结构:
    1. 数据文件在父文件夹根目录
    2. 数据文件在各时间戳子文件夹内

    Args:
        folder: 源文件夹路径

    Returns:
        包含 first_value 和 count 的字典
    """
    if not folder.is_dir():
        logger.warning(f"路径不是文件夹: {folder}")
        return {"first_value": None, "count": 0, "found_file": None}

    # 策略1: 先检查父文件夹根目录是否有 Excel 文件
    root_trace_file = find_trace_file(folder)
    if root_trace_file:
        logger.info(f"在根目录找到数据文件: {root_trace_file.name}")
        return read_sliding_drop_frames(root_trace_file)

    # 策略2: 如果根目录没有文件，则遍历子文件夹查找
    subdirs = sorted([d for d in folder.iterdir() if d.is_dir()])

    for subdir in subdirs:
        trace_file = find_trace_file(subdir)
        if trace_file:
            logger.info(f"在子文件夹 {subdir.name} 找到数据文件: {trace_file.name}")
            return read_sliding_drop_frames(trace_file)

    logger.warning(f"文件夹 {folder.name} 中未找到Excel文件")
    return {
        "values_33ms": [],
        "values_50ms": [],
        "values_total": [],
        "count_33ms": 0,
        "count_50ms": 0,
        "found_file": None
    }
