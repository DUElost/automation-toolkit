# -*- coding: utf-8 -*-
"""
ScanTneUpload - TNE 上传扫描模块
原始文件反编译失败，此为简化实现
"""
from modules.common.Logger import TEST_LOGGER
from modules.mode.BaseScan import ScanBase


class ScanTneUpload(ScanBase):
    """TNE 上传扫描类"""

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir,
                 skip_extract, skip_unzip):
        TEST_LOGGER.info("初始化 ScanTneUpload")
        super(ScanTneUpload, self).__init__(scan_mode, scan_place, days_before,
                                             scan_root_dir, cur_tool_dir, skip_extract,
                                             skip_unzip)

    def _get_scan_dir_failed(self, error_msg):
        TEST_LOGGER.error(f"扫描目录获取失败: {error_msg}")

    def _init_scan_attrs(self):
        TEST_LOGGER.info("初始化 ScanTneUpload 扫描属性")

    def _scan(self):
        TEST_LOGGER.info("开始 TNE 上传扫描")
