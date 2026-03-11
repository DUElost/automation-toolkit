# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_last_cpu_bus.py
import os
from modules.common.Logger import TEST_LOGGER

class SysLastCpuBus(object):

    def __init__(self, file_path):
        super(SysLastCpuBus, self).__init__()
        self._SysLastCpuBus__file_path = file_path

    def analyse(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._SysLastCpuBus__file_path))
        TEST_LOGGER.debug(f"开始解析SYS_LAST_CPU_BUS文件：{self._SysLastCpuBus__file_path}", tag=tne_dir_name)
        lastpc_info_list = []
        with open((self._SysLastCpuBus__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                if line.startswith("[LAST PC]"):
                    lastpc_info_list.append(line)

        return lastpc_info_list

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_last_cpu_bus.pyc
