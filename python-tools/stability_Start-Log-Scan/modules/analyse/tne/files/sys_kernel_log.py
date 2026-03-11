# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_kernel_log.py
import os, re
from modules.common.Logger import TEST_LOGGER

class SysKernelLog(object):

    def __init__(self, file_path):
        super(SysKernelLog, self).__init__()
        self._SysKernelLog__file_path = file_path
        self._SysKernelLog__tne_dir_name = os.path.basename(os.path.dirname(self._SysKernelLog__file_path))

    def analyse_tne03(self):
        TEST_LOGGER.debug(("TNE03, 开始解析sys_kernel_log文件：{}".format(self._SysKernelLog__file_path)), tag=(self._SysKernelLog__tne_dir_name))
        last_crash_time, last_crash_detail, process = (None, None, None)
        regex_time = re.compile("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")
        tnek = "tnek: tnek_create_node"
        with open((self._SysKernelLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                regex_rlt = re.search(regex_time, line)
                if regex_rlt:
                    last_crash_time = regex_rlt.group()
                if tnek in line:
                    break

        return last_crash_time

    def analyse_tne06(self):
        TEST_LOGGER.debug(("TNE06, 开始解析sys_kernel_log文件：{}".format(self._SysKernelLog__file_path)), tag=(self._SysKernelLog__tne_dir_name))
        regex_bootprof = re.compile(".*BOOTPROF:\\s+")
        regex_timestamp = re.compile("\\d+\\.\\d+:\\s+")
        regex_ms = re.compile("\\d+.\\d+ms")
        regex_addr = re.compile("\\(0x.*\\)")
        regex_pid = re.compile(":pid:\\d+")
        detail_list = []
        with open((self._SysKernelLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                if "BOOTPROF" in line:
                    if "PMS:performDexOpt" in line:
                        return "PMS:performDexOpt"
                    line = re.sub(regex_bootprof, "BOOTPROF:", line)
                    line = re.sub(regex_timestamp, "", line)
                    line = re.sub(regex_ms, "", line)
                    line = re.sub(regex_addr, "", line)
                    line = re.sub(regex_pid, "", line)
                    line = line.strip()
                    if line == "BOOTPROF:ON":
                        detail_list.clear()
                    detail_list.append(line)

        if detail_list:
            detail = "\n".join(detail_list)
        else:
            detail = None
        return detail

    def get_bind_hung_30_list(self):
        TEST_LOGGER.debug(("FREEZE 0xffffff31, 开始解析sys_kernel_log文件：{}".format(self._SysKernelLog__file_path)), tag=(self._SysKernelLog__tne_dir_name))
        bind_hung_30_list = []
        with open((self._SysKernelLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                if "binder hung 30" in line:
                    bind_hung_30_list.append(line)

        return bind_hung_30_list

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_kernel_log.pyc
