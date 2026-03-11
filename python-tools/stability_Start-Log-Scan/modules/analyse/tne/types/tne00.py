# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne00.py
import os
from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne00(TneBase):

    def __init__(self, path):
        super(Tne00, self).__init__(path)
        self._exp_class = "0xffffff00_fatal_JE"
        self._exp_type = "0xffffff00_fatal_JE"
        self._cur_process = "system_server"
        self._package = "system_server"

    def analyse(self):
        if not os.path.isfile(self._android_crash_log_path):
            TEST_LOGGER.debug(("android_crash_log 文件不存在：{}".format(self._android_crash_log_path)), tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: android_crash_log")
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
            self._detail_to_random()
            return False
        androidCrashLog = AndroidCrashLog(self._android_crash_log_path)
        self._exp_time, self._detail = androidCrashLog.analyse_tne00()
        if self._exp_type_set:
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail_to_random()
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne00.pyc
