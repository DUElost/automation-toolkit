"""
Excel数据转移工具
自动化从源目录读取测试数据并填写到目标Excel文件
"""

__version__ = "1.0.0"

from .config import (
    SOURCE_DIR,
    TARGET_FILE,
    ANIMATION_SHEET_NAME,
    SLIDING_SHEET_NAME,
    DEVICE_TYPE_TEST,
    DEVICE_TYPE_COMPETITOR,
    DATA_TYPE_ANIMATION,
    DATA_TYPE_SLIDING
)
from .transfer import (
    process_folder_transfer,
    process_sliding_transfer,
    print_summary,
    print_sliding_summary
)

__all__ = [
    'process_folder_transfer',
    'process_sliding_transfer',
    'print_summary',
    'print_sliding_summary',
    'SOURCE_DIR',
    'TARGET_FILE',
    'ANIMATION_SHEET_NAME',
    'SLIDING_SHEET_NAME',
    'DEVICE_TYPE_TEST',
    'DEVICE_TYPE_COMPETITOR',
    'DATA_TYPE_ANIMATION',
    'DATA_TYPE_SLIDING'
]
