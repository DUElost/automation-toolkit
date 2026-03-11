# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne14.py
import os
from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.files.anr import Anr
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne14(TneBase):
    __doc__ = "\n    modified 20231026_1702\n    "

    def __init__(self, path):
        super(Tne14, self).__init__(path)
        self._exp_class = "0xffffff14_zygote_crash"
        self._exp_type = "0xffffff14_zygote_crash"
        self._cur_process = "zygote"
        self._package = "zygote"

    def analyse(self):
        if not os.path.isfile(self._android_crash_log_path):
            TEST_LOGGER.debug(("android_crash_log 文件不存在：{}".format(self._android_crash_log_path)), tag=(self.tne_dir_name))
        else:
            androidCrashLog = AndroidCrashLog(self._android_crash_log_path)
            self._exp_time, self._detail = androidCrashLog.analyse_tne14()
        self._detail_to_random(True)
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne14.pyc
