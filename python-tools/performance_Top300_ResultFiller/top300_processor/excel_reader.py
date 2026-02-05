"""
Excel读取模块 - Top300 Result Filler
负责读取源文件数据，识别有效sheet
"""
import logging
from pathlib import Path
from typing import List, Optional

import pandas as pd

from .config import SOURCE_HEADERS

logger = logging.getLogger(__name__)


def validate_file_exists(file_path: Path) -> bool:
    """
    验证文件是否存在

    Args:
        file_path: 文件路径

    Returns:
        文件是否存在
    """
    if not file_path.exists():
        logger.error(f"文件不存在: {file_path}")
        return False
    if not file_path.is_file():
        logger.error(f"路径不是文件: {file_path}")
        return False
    return True


def get_valid_sheets(file_path: Path) -> List[str]:
    """
    获取包含特定表头的sheet名称列表

    Args:
        file_path: Excel文件路径

    Returns:
        有效的sheet名称列表
    """
    try:
        excel_file = pd.ExcelFile(file_path)
        valid_sheets = []

        for sheet_name in excel_file.sheet_names:
            try:
                df = pd.read_excel(excel_file, sheet_name=sheet_name, nrows=1)
                # 检查是否包含预期的表头
                if all(header in df.columns for header in SOURCE_HEADERS):
                    valid_sheets.append(sheet_name)
                    logger.debug(f"找到有效sheet: {sheet_name}")
            except Exception as e:
                logger.warning(f"读取sheet {sheet_name} 时出错: {e}")
                continue

        logger.info(f"从 {file_path.name} 中找到 {len(valid_sheets)} 个有效sheet")
        return valid_sheets

    except Exception as e:
        logger.error(f"读取文件 {file_path} 时出错: {e}")
        return []


def read_sheet_data(file_path: Path, sheet_name: str) -> Optional[pd.DataFrame]:
    """
    读取指定sheet的数据

    Args:
        file_path: Excel文件路径
        sheet_name: sheet名称

    Returns:
        DataFrame对象，读取失败返回None
    """
    try:
        df = pd.read_excel(file_path, sheet_name=sheet_name)
        logger.info(f"从 {file_path.name} 的 sheet '{sheet_name}' 读取到 {len(df)} 行数据")
        return df
    except Exception as e:
        logger.error(f"读取sheet {sheet_name} 时出错: {e}")
        return None


def find_column_index(df: pd.DataFrame, column_name: str) -> Optional[int]:
    """
    查找列的索引位置（1-based）

    Args:
        df: DataFrame对象
        column_name: 列名

    Returns:
        列索引（1-based），未找到返回None
    """
    for i, col in enumerate(df.columns):
        if col == column_name:
            return i + 1
    return None


def get_time_type_column(df: pd.DataFrame) -> Optional[str]:
    """
    获取时间类型列的实际列名

    Args:
        df: DataFrame对象

    Returns:
        时间类型列名，未找到返回None
    """
    possible_names = ["时间类型", "time_type", "TimeType"]
    for name in possible_names:
        if name in df.columns:
            return name
    return None


def get_avg_start_time_column(df: pd.DataFrame) -> Optional[str]:
    """
    获取平均启动时间列的实际列名

    Args:
        df: DataFrame对象

    Returns:
        平均启动时间列名，未找到返回None
    """
    possible_names = ["平均启动时间", "avg_start_time", "AvgStartTime"]
    for name in possible_names:
        if name in df.columns:
            return name
    return None
