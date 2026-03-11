# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne0f.py
import os
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.files.sys_last_cpu_bus import SysLastCpuBus
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne0f(TneBase):

    def __init__(self, path):
        super(Tne0f, self).__init__(path)
        self._exp_class = "0xffffff0f_hw_reboot"
        self._exp_type = "0xffffff0f_hw_reboot"
        self._cur_process = "HW_Reboot"
        self._package = "HW_Reboot"

    def analyse(self):
        if self._pstore_path and os.path.isfile(self._pstore_path):
            pstore = Pstore(self._pstore_path)
            self._exp_time = pstore.get_last_utc_time()
        else:
            TEST_LOGGER.debug("pstore 或者 pstore0 文件不存在", tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: pstore or pstore0")
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        if self._sys_last_cpu_bus_path:
            if os.path.isfile(self._sys_last_cpu_bus_path):
                sys_last_cpu_bus = SysLastCpuBus(self._sys_last_cpu_bus_path)
                lastpc_info_list = sys_last_cpu_bus.analyse()
                if lastpc_info_list:
                    self._detail = "\n".join(lastpc_info_list)
        self._detail_to_random(True)
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne0f.pyc
