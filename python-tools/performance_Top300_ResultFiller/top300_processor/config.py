"""
配置模块 - Top300 Result Filler
包含列名、常量等配置
"""

from typing import List

# Sheet名称前缀
NO_LOAD_PREFIX = "空载"
LOAD_PREFIX = "负载"
SHEET_DELIMITER = "'"

# 源文件表头（用于识别有效sheet）
SOURCE_HEADERS: List[str] = [
    "测试APK", "时间类型", "平均启动时间", "最大启动时间",
    "最小启动时间", "跳变次数", "Round_1", "Round_2",
    "Round_3", "Round_4", "Round_5", "Round_6", "Round_7", "Round_8"
]

# 目标文件配置
RESULT_SHEET_NAME = "测试结果"
COLUMN_STANDARD = "标准"
COLUMN_HASH_1 = "#1"
COLUMN_HASH_2 = "#2"
COLUMN_AVERAGE = "均值"

# 行标识
ROW_NO_LOAD_LABEL = "空载"
ROW_LOAD_LABEL = "负载"

# 时间类型筛选
TIME_TYPE_AM = "AM"

# 新增列名
COLUMN_NON_FIRST_AVG = "非首轮平均启动时间"


def get_round_columns() -> List[str]:
    """获取Round列名列表"""
    return [f"Round_{i}" for i in range(1, 9)]


def get_round_columns_for_average() -> List[str]:
    """获取用于计算平均值的Round列名（Round_2到Round_8）"""
    return [f"Round_{i}" for i in range(2, 9)]
