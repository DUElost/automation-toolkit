# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne12.py
import os, re
from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne12(TneBase):

    def __init__(self, path):
        super(Tne12, self).__init__(path)
        self._exp_class = "0xffffff12_OOM_JE"
        self._exp_type = "0xffffff12_OOM_JE"
        self._cur_process = None
        self._package = None

    def analyse(self):
        self._caused_by = "附件hprof文件经过去0压缩，如需使用，请在 http://10.132.8.111/#/tool-manage 下载工具 hprofConvert 进行补零操作！"
        regex_pattern = re.compile("(.*)_OOM")
        if self._hprof_path:
            hprof_file_name = os.path.basename(self._hprof_path)
            regex_rlt = re.match(regex_pattern, hprof_file_name)
            if regex_rlt:
                self._cur_process = regex_rlt.group(1)
                self._package = self._cur_process
        os.path.isfile(self._android_crash_log_path) or TEST_LOGGER.debug(("android_crash_log 文件不存在：{}".format(self._android_crash_log_path)), tag=(self.tne_dir_name))
        self._exp_type_set.add("TNE_ERROR_file_missing: android_crash_log")
        self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail_to_random()
        if self._cur_process is None:
            self._cur_process = "system_server"
            self._package = "system_server"
        else:
            return False
            androidCrashLog = AndroidCrashLog(self._android_crash_log_path)
            self._exp_time, self._detail, last_process = androidCrashLog.analyse_tne12()
            if self._cur_process is None:
                if last_process:
                    self._cur_process = last_process
                else:
                    self._cur_process = "system_server"
        self._package = self._cur_process
        if self._exp_type_set:
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail_to_random()
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne12.pyc
