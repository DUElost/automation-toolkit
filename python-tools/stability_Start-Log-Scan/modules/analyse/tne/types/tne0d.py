# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne0d.py
import os
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.files.sys_atf_last import SysAtfLast
from modules.analyse.tne.files.tfa_debug_buf import TfaDebugBuf
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne0d(TneBase):

    def __init__(self, path):
        super(Tne0d, self).__init__(path)
        self._exp_class = "0xffffff0d_hwt"
        self._exp_type = "0xffffff0d_hwt"
        self._cur_process = "HWT"
        self._package = "HWT"

    def analyse(self):
        if self._pstore_path:
            if os.path.isfile(self._pstore_path):
                pstore = Pstore(self._pstore_path)
                self._exp_time = pstore.get_last_utc_time()
            else:
                TEST_LOGGER.debug("pstore 或者 pstore0 文件不存在", tag=(self.tne_dir_name))
                self._exp_type_set.add("TNE_ERROR_file_missing: pstore or pstore0")
                self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        else:
            detail_list = None
            if self._tfa_debug_buf_path:
                if os.path.isfile(self._tfa_debug_buf_path):
                    tfa_debug_buf = TfaDebugBuf(self._tfa_debug_buf_path)
                    detail_list = tfa_debug_buf.analyse_tne0d()
            if self._sys_atf_last_path and os.path.isfile(self._sys_atf_last_path):
                sys_atf_last = SysAtfLast(self._sys_atf_last_path)
                if detail_list:
                    self._detail = "\n".join(detail_list) + "\n" + sys_atf_last.analyse()
                else:
                    self._detail = sys_atf_last.analyse()
                self._detail_to_random()
                return True
        TEST_LOGGER.debug("SYS_ATF_LAST 文件不存在", tag=(self.tne_dir_name))
        self._exp_type_set.add("TNE_ERROR_file_missing: SYS_ATF_LAST")
        self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        if detail_list:
            self._detail = "\n".join(detail_list)
        self._detail_to_random()
        return False

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne0d.pyc
