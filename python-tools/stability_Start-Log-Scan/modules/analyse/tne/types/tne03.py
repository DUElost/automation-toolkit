# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne03.py
import os
from modules.analyse.tne.files.hang_detect_trace import HangDetectTrace
from modules.common.Utils import random_str
from modules.analyse.tne.types.tne_base import TneBase
from modules.analyse.tne.files.sys_kernel_log import SysKernelLog
from modules.common.Logger import TEST_LOGGER

class Tne03(TneBase):

    def __init__(self, path):
        super(Tne03, self).__init__(path)
        self._exp_class = "0xffffff03_hang_detect"
        self._exp_type = "0xffffff03_hang_detect"
        self._cur_process = "HANG_DETECT"
        self._package = "HANG_DETECT"

    def analyse(self):
        analyse_rlt = True
        self._detail = "获取Hang内容失败，请自己查看日志文件，本内容只为了Jira不能去重：\n" + random_str(slen=200)
        self._package = "HANG_DETECT"
        if self._sys_kernel_log_path:
            if os.path.isfile(self._sys_kernel_log_path):
                sysKernelLog = SysKernelLog(self._sys_kernel_log_path)
                self._exp_time = sysKernelLog.analyse_tne03()
            else:
                TEST_LOGGER.debug("sys_kernel_log 文件不存在", tag=(self.tne_dir_name))
                self._exp_type_set.add("TNE_ERROR_file_missing: sys_kernel_log")
                self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
                analyse_rlt = False
            if self._hang_detect_trace_path and os.path.isfile(self._hang_detect_trace_path):
                hangDetectTrace = HangDetectTrace(self._hang_detect_trace_path)
                watchdog_info = hangDetectTrace.analyse()
                if watchdog_info:
                    self._detail = watchdog_info
        else:
            TEST_LOGGER.debug("hang_detect_trace 文件不存在", tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: hang_detect_trace")
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
            analyse_rlt = False
        return analyse_rlt

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne03.pyc
