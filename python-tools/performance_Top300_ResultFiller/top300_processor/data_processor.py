"""
数据处理模块 - Top300 Result Filler
负责数据筛选、计算非首轮平均值等
"""
import logging
from pathlib import Path
from typing import Dict, List, Optional

import pandas as pd

from .config import (
    SHEET_DELIMITER,
    TIME_TYPE_AM,
    get_round_columns_for_average,
)
from .excel_reader import get_avg_start_time_column, get_time_type_column

logger = logging.getLogger(__name__)


def generate_new_sheet_name(original_name: str, prefix: str, index: int) -> str:
    """
    生成新sheet名称
    如: "0000NX261H000078" + "空载" + 1 -> "空载1'0078"
    提取原始sheet名称后4位作为后缀

    Args:
        original_name: 原始sheet名称
        prefix: 前缀（空载/负载）
        index: 索引（1, 2, 3...）

    Returns:
        新sheet名称
    """
    suffix = original_name[-4:]  # 后4位
    return f"{prefix}{index}{SHEET_DELIMITER}{suffix}"


def find_round_columns(df: pd.DataFrame) -> List[str]:
    """
    动态查找 Round_1 到 Round_8 列
    支持列名格式变化（如 Round1, round_1 等）

    Args:
        df: DataFrame对象

    Returns:
        找到的Round列名列表
    """
    round_columns = []
    for i in range(1, 9):  # Round_1 到 Round_8
        possible_names = [
            f"Round_{i}",
            f"Round{i}",
            f"round_{i}",
            f"round{i}",
            f"ROUND_{i}",
            f"ROUND{i}",
        ]
        for name in possible_names:
            if name in df.columns:
                round_columns.append(name)
                break
    return round_columns


def calculate_non_first_average(row: pd.Series, round_columns: List[str]) -> float:
    """
    计算单行的非首轮平均值（Round_2到Round_8的平均值）

    Args:
        row: 数据行
        round_columns: Round列名列表

    Returns:
        平均值
    """
    # 从Round_2开始（索引1）
    values = []
    for col in round_columns[1:]:  # 跳过Round_1
        val = row.get(col)
        if pd.notna(val) and isinstance(val, (int, float)):
            values.append(float(val))

    if not values:
        return 0.0
    return sum(values) / len(values)


def calculate_column_average(values: List[float]) -> float:
    """
    计算列平均值

    Args:
        values: 数值列表

    Returns:
        平均值
    """
    valid_values = [v for v in values if pd.notna(v) and v != 0]
    if not valid_values:
        return 0.0
    return sum(valid_values) / len(valid_values)


def process_sheet_data(df: pd.DataFrame, sheet_name: str) -> Dict:
    """
    处理单个sheet的数据
    1. 筛选 时间类型=AM 的数据
    2. 统计 平均启动时间=0 的个数
    3. 筛选 平均启动时间≠0 的数据
    4. 计算非首轮平均启动时间（Round_2到Round_8的平均值）
    5. 计算非首轮平均启动时间的列平均值

    Args:
        df: 原始数据DataFrame
        sheet_name: sheet名称

    Returns:
        处理结果字典
    """
    result = {
        "sheet_name": sheet_name,
        "zero_count": 0,
        "filtered_df": None,
        "non_first_averages": [],
        "column_average": 0.0,
        "success": False,
        "error": None
    }

    try:
        # 获取列名
        time_type_col = get_time_type_column(df)
        avg_time_col = get_avg_start_time_column(df)

        if not time_type_col:
            result["error"] = "未找到'时间类型'列"
            return result

        if not avg_time_col:
            result["error"] = "未找到'平均启动时间'列"
            return result

        # 查找Round列
        round_columns = find_round_columns(df)
        if len(round_columns) < 8:
            result["error"] = f"Round列不完整，找到{len(round_columns)}列"
            return result

        # 1. 筛选 时间类型=AM 的数据
        am_data = df[df[time_type_col] == TIME_TYPE_AM].copy()

        # 2. 统计 平均启动时间=0 的个数
        zero_count = (am_data[avg_time_col] == 0).sum()
        result["zero_count"] = int(zero_count)

        # 3. 筛选 平均启动时间≠0 的数据
        filtered_data = am_data[am_data[avg_time_col] != 0].copy()

        if filtered_data.empty:
            result["error"] = "筛选后无有效数据"
            return result

        # 4. 计算每行的非首轮平均值
        non_first_averages = []
        for _, row in filtered_data.iterrows():
            avg = calculate_non_first_average(row, round_columns)
            non_first_averages.append(avg)

        filtered_data["非首轮平均启动时间"] = non_first_averages

        # 5. 计算列平均值
        column_average = calculate_column_average(non_first_averages)

        result["filtered_df"] = filtered_data
        result["non_first_averages"] = non_first_averages
        result["column_average"] = column_average
        result["success"] = True

        logger.info(f"Sheet '{sheet_name}' 处理完成: AM数据={len(am_data)}行, "
                   f"0值个数={zero_count}, 有效数据={len(filtered_data)}行, "
                   f"列平均值={column_average:.2f}")

    except Exception as e:
        result["error"] = str(e)
        logger.error(f"处理sheet '{sheet_name}' 时出错: {e}")

    return result
