# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne13.py
import os
from modules.analyse.tne.files.android_main_log import AndroidMainLog
from modules.analyse.tne.files.anr import Anr
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne13(TneBase):
    __doc__ = "\n    modified 20230619_1712\n    "

    def __init__(self, path):
        super(Tne13, self).__init__(path)
        self._exp_class = "0xffffff13_ANR"
        self._exp_type = "0xffffff13_ANR"

    def analyse(self):
        if not os.path.isfile(self._android_main_log_path):
            TEST_LOGGER.debug(("android_main_log 文件不存在：{}".format(self._android_main_log_path)), tag=(self.tne_dir_name))
        else:
            androidMainLog = AndroidMainLog(self._android_main_log_path)
            last_crash_time, pkg = androidMainLog.analyse_anr()
            if last_crash_time:
                self._exp_time = last_crash_time
            else:
                self._exp_type_set.add("TNE_ERROR_no_TABE.CrashHandler_in_android_main_log")
            if pkg:
                self._package = pkg
                self._cur_process = pkg
            else:
                self._get_anr_file_list()
                if self._anr_file_list:
                    TEST_LOGGER.info(f"获取anr文件列表：{self._anr_file_list}", tag=(self.tne_dir_name))
                    last_anr_file = self._anr_file_list[-1]
                    TEST_LOGGER.debug(f"获取最后一个anr文件：{last_anr_file}", tag=(self.tne_dir_name))
                    last_anr_file_path = os.path.join(self._path, last_anr_file)
                    if os.path.isfile(last_anr_file_path):
                        anr = Anr(last_anr_file_path)
                        self._detail = anr.analyse_tne13()
                else:
                    TEST_LOGGER.error(f"在目录:{self._path} 下没有找到anr文件", tag=(self.tne_dir_name))
                    self._detail = None
            if self._detail:
                self._detail = self._detail + f"\nPackage:{self._package}"
            self._detail_to_random()
            return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne13.pyc
