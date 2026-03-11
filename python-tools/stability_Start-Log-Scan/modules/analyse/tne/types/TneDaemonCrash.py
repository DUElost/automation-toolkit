# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\TneDaemonCrash.py
import os
from modules.analyse.tne.files.android_main_log import AndroidMainLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class TneDaemonCrash(TneBase):

    def __init__(self, path, tne_type, build_version):
        super(TneDaemonCrash, self).__init__(path)
        self._exp_class = tne_type
        self._exp_type = tne_type
        self._cur_process = tne_type
        self._package = tne_type
        if build_version:
            if self._version == "undefined" or self._version is None:
                self._version = build_version

    def analyse(self):
        if not os.path.isfile(self._android_main_log_path):
            TEST_LOGGER.debug(("android_main_log 文件不存在：{}".format(self._android_main_log_path)), tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: android_main_log")
        else:
            androidMainLog = AndroidMainLog(self._android_main_log_path)
            last_crash_time, last_crash_detail, pkg, build_version = androidMainLog.analyse_daemon_crash()
            if last_crash_time:
                self._exp_time = last_crash_time
            if last_crash_detail:
                self._detail = last_crash_detail
            if pkg:
                self._package = pkg
                self._cur_process = pkg
            if build_version:
                self._version = build_version
        self._detail_to_random()
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\TneDaemonCrash.pyc
