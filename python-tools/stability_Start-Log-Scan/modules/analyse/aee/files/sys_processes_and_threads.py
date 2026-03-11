# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\sys_processes_and_threads.py
import os, traceback
from modules.common.Logger import TEST_LOGGER

class SysProcessesAndThreads(object):

    def __init__(self, file_path):
        super(SysProcessesAndThreads, self).__init__()
        self._SysProcessesAndThreads__file_path = file_path

    def get_process_by_pid(self, pid):
        TEST_LOGGER.debug("开始在 SYS_PROCESSES_AND_THREADS 文件：{} 中获取 pid：{} 对应的进程名".format(self._SysProcessesAndThreads__file_path, pid))
        with open((self._SysProcessesAndThreads__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                split_line = line.split()
                try:
                    if split_line[2] == pid:
                        return split_line[16]
                except:
                    TEST_LOGGER.debug("解析文件：{}时，发生异常：\n{}".format(self._SysProcessesAndThreads__file_path, traceback.format_tb()))

        return

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\sys_processes_and_threads.pyc
