# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne0c.py
import os
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.files.sys_hang_detect_raw import SysHangDetectRaw
from modules.analyse.tne.files.sys_kernel_log import SysKernelLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne0c(TneBase):

    def __init__(self, path):
        super(Tne0c, self).__init__(path)
        self._exp_class = "0xffffff0c_hang_detect"
        self._exp_type = "0xffffff0c_hang_detect"
        self._cur_process = "HANG_DETECT"
        self._package = "HANG_DETECT"

    def analyse(self):
        detail_list = []
        counts_line, counts_value = (None, None)
        if self._pstore_path and os.path.isfile(self._pstore_path):
            pstore = Pstore(self._pstore_path)
            more_than_30_list = pstore.check_more_than_30()
            self._exp_time = pstore.get_last_utc_time()
            detail_list, counts_value = pstore.get_counts_for_tne0c()
            TEST_LOGGER.debug(f"counts_value: {counts_value}", tag=(self.tne_dir_name))
            if more_than_30_list:
                detail_list = more_than_30_list + detail_list
        else:
            TEST_LOGGER.debug("pstore 或者 pstore0 文件不存在", tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: pstore or pstore0")
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        if counts_value:
            if counts_value == 11:
                self._detail = "\n".join(detail_list)
                self._detail_to_random()
                return True
        if self._sys_hang_detect_raw_path:
            if os.path.isfile(self._sys_hang_detect_raw_path):
                sys_hang_detect_raw = SysHangDetectRaw(self._sys_hang_detect_raw_path)
                hang_detect_list = sys_hang_detect_raw.analyse(counts_value)
                if hang_detect_list:
                    if detail_list:
                        detail_list.append("")
                    detail_list.extend(hang_detect_list)
                self._detail = "\n".join(detail_list)
                self._detail_to_random()
                return True
        TEST_LOGGER.debug("SYS_HANG_DETECT_RAW 文件不存在", tag=(self.tne_dir_name))
        self._exp_type_set.add("TNE_ERROR_file_missing: SYS_HANG_DETECT_RAW")
        self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail = "\n".join(detail_list)
        self._detail_to_random()
        return False

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne0c.pyc
