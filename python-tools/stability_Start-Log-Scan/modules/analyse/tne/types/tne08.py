# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne08.py
import os
from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.files.android_main_log import AndroidMainLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne08(TneBase):

    def __init__(self, path):
        super(Tne08, self).__init__(path)
        self._exp_class = "0xffffff08_NE"
        self._exp_type = "0xffffff08_NE"
        self._cur_process = "3RD Application"
        self._package = "3RD Application"

    def analyse(self):
        if not os.path.isfile(self._android_crash_log_path):
            TEST_LOGGER.debug(("android_crash_log 文件不存在：{}".format(self._android_crash_log_path)), tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: android_crash_log")
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
            self._detail_to_random()
            return False
        androidCrashLog = AndroidCrashLog(self._android_crash_log_path)
        self._exp_time, self._detail, self._cur_process = androidCrashLog.analyse_tne08()
        TEST_LOGGER.debug(self._exp_time, self._detail, self._cur_process)
        if not os.path.isfile(self._android_main_log_path):
            TEST_LOGGER.debug(("android_main_log 文件不存在：{}".format(self._android_main_log_path)), tag=(self.tne_dir_name))
            self._package = "3RD Application"
            self._exp_type_set.add("TNE_ERROR_file_missing: android_main_log")
        else:
            androidMainLog = AndroidMainLog(self._android_main_log_path)
            time_main_log, detail_main_log, pkg = androidMainLog.analyse_tne07()
            if detail_main_log and self._detail:
                detail_main_log = "android_main_log:\n" + detail_main_log
                self._detail = self._detail + "\n\n" + detail_main_log if self._detail else detail_main_log
            else:
                self._exp_type_set.add("TNE_ERROR_no_TABE.CrashHandler_in_android_main_log")
            self._package = pkg if pkg else "3RD Application"
        if self._exp_type_set:
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail_to_random()
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne08.pyc
