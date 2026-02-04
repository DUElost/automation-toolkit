"""
配置模块 - Excel数据转移工具
包含路径、列名等配置常量

支持通过环境变量覆盖默认路径配置：
- SOURCE_DIR: 测试机动效丢帧源目录
- SOURCE_DIR_SLIDING: 测试机滑动丢帧源目录
- SOURCE_DIR_COMPETITOR: 竞品机动效丢帧源目录
- SOURCE_DIR_SLIDING_COMPETITOR: 竞品机滑动丢帧源目录
- TARGET_FILE: 目标 Excel 文件路径
- BACKUP_DIR: 备份目录路径
"""
import os
from pathlib import Path
from typing import Dict

# 获取脚本所在目录的根目录
SCRIPT_DIR = Path(__file__).parent.parent
ROOT_DIR = SCRIPT_DIR

# 路径配置 - 测试机（支持环境变量覆盖）
SOURCE_DIR = Path(os.environ.get("SOURCE_DIR",
    r"W:\KN5项目\静态模型\KN5\动效丢帧"))
SOURCE_DIR_SLIDING = Path(os.environ.get("SOURCE_DIR_SLIDING",
    r"W:\KN5项目\静态模型\KN5\滑动丢帧"))

# 路径配置 - 竞品机（支持环境变量覆盖）
SOURCE_DIR_COMPETITOR = Path(os.environ.get("SOURCE_DIR_COMPETITOR",
    r"W:\三星A07\动效丢帧"))
SOURCE_DIR_SLIDING_COMPETITOR = Path(os.environ.get("SOURCE_DIR_SLIDING_COMPETITOR",
    r"W:\三星A07\滑动丢帧"))

# 目标文件和模板（支持环境变量覆盖）
# 默认使用相对于脚本位置的路径
TARGET_FILE = Path(os.environ.get("TARGET_FILE",
    ROOT_DIR / "data" / "静态模型 - V2.0 - KN8.xlsx"))
BACKUP_DIR = Path(os.environ.get("BACKUP_DIR",
    ROOT_DIR / "backup"))
TEMPLATE_FILE = BACKUP_DIR / "静态模型 - V2.0 - KN8.xlsx"

# 数据类型枚举
DATA_TYPE_ANIMATION = "animation"  # 动效丢帧
DATA_TYPE_SLIDING = "sliding"     # 滑动丢帧

DATA_TYPE_LABELS = {
    DATA_TYPE_ANIMATION: "动效丢帧",
    DATA_TYPE_SLIDING: "滑动丢帧"
}

# Excel 配置 - 动效丢帧
ANIMATION_SHEET_NAME = "动效丢帧"
SOURCE_SHEET_NAME = "TraceAnalyseResult"
SOURCE_DATA_COLUMN = "总丢帧数"

# Excel 配置 - 滑动丢帧
SLIDING_SHEET_NAME = "滑动连续丢帧"
SLIDING_SOURCE_COLUMN_33MS = "FrameOver33ms"
SLIDING_SOURCE_COLUMN_50MS = "FrameOver50ms"
SLIDING_SOURCE_COLUMN_TOTAL = "总丢帧数"  # 丢帧总数
SLIDING_MATCH_COLUMN = "Purpose"  # 用 Purpose 列匹配文件夹名

# 通用配置
TCID_COLUMN = "Tcid"
LEVEL_COLUMN = "用例等级"

# 列名配置
TEST_DEVICE_COLUMNS = [
    "测试机1", "测试机2", "测试机3", "测试机4", "测试机5",
    "测试机6", "测试机7", "测试机8", "测试机9", "测试机10"
]

COMPETITOR_DEVICE_COLUMNS = [
    "竞品机1", "竞品机2", "竞品机3", "竞品机4", "竞品机5",
    "竞品机6", "竞品机7", "竞品机8", "竞品机9", "竞品机10"
]

# 滑动丢帧子列配置 (测试机1后的列: 丢帧总数, 33ms次数, 50ms次数)
SLIDING_SUB_COLUMNS = {
    "drop_frame_total": "丢帧总数",     # 填入 FrameOver33ms 第一个值
    "count_33ms": "33ms次数",            # 填入 FrameOver33ms > 0 的个数
    "count_50ms": "50ms次数"             # 可能需要
}

# 源文件匹配模式
TRACE_FILE_PATTERN = "trace_analyse_result"

# 设备类型枚举
DEVICE_TYPE_TEST = "test"
DEVICE_TYPE_COMPETITOR = "competitor"

DEVICE_TYPE_LABELS = {
    DEVICE_TYPE_TEST: "测试机",
    DEVICE_TYPE_COMPETITOR: "竞品机"
}

# 数据类型到sheet配置的映射
DATA_TYPE_CONFIG = {
    DATA_TYPE_ANIMATION: {
        "sheet_name": ANIMATION_SHEET_NAME,
        "source_column": SOURCE_DATA_COLUMN,
        "match_column": TCID_COLUMN,
        "match_type": "index"  # 按文件夹索引匹配
    },
    DATA_TYPE_SLIDING: {
        "sheet_name": SLIDING_SHEET_NAME,
        "source_column": SLIDING_SOURCE_COLUMN_33MS,
        "match_column": SLIDING_MATCH_COLUMN,
        "match_type": "name"   # 按文件夹名称匹配
    }
}

def get_config_for_data_type(data_type: str) -> Dict:
    """
    根据数据类型获取对应的配置

    Args:
        data_type: 数据类型 (animation 或 sliding)

    Returns:
        配置字典
    """
    return DATA_TYPE_CONFIG.get(data_type, DATA_TYPE_CONFIG[DATA_TYPE_ANIMATION])
