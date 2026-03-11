# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\sys_memory_info.py
import os
from modules.common.Logger import TEST_LOGGER

class SysMemoryInfo(object):

    def __init__(self, file_path):
        super(SysMemoryInfo, self).__init__()
        self._SysMemoryInfo__file_path = file_path
        self._SysMemoryInfo__aee_dir = os.path.dirname(file_path)
        self._SysMemoryInfo__aee_dir_name = os.path.basename(self._SysMemoryInfo__aee_dir)

    def get_swap_rate(self):
        TEST_LOGGER.debug(("开始在 SYS_MEMORY_INFO 中读取并计算Swap Rate信息，{}".format(self._SysMemoryInfo__file_path)), tag=(self._SysMemoryInfo__aee_dir_name))
        swap_total, swap_free, swap_rate = (None, None, None)
        with open((self._SysMemoryInfo__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "SwapTotal:" in line:
                    swap_total = line.split()[1]
                if "SwapFree:" in line:
                    swap_free = line.split()[1]
                    break

        try:
            swap_total = int(swap_total)
            swap_free = int(swap_free)
            swap_rate = (swap_total - swap_free) * 100 / swap_total
            TEST_LOGGER.debug(("获取：swap_free：{}, swap_total：{}，swap_rate：{}".format(swap_free, swap_total, swap_rate)), tag=(self._SysMemoryInfo__aee_dir_name))
            return (True, swap_rate, swap_free, swap_total)
        except:
            TEST_LOGGER.debug(("Swap Rate 获取异常，swap_rate：{}，swap_free：{}，swap_total：{}".format(swap_rate, swap_free, swap_total)), tag=(self._SysMemoryInfo__aee_dir_name))
            return (False, swap_rate, swap_free, swap_total)

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\sys_memory_info.pyc
