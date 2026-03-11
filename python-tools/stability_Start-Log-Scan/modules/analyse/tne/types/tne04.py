# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne04.py
import os
from modules.analyse.tne.files.dump_report import DumpReport
from modules.analyse.tne.files.minidump_extend_last_kmsg import MinidumpExtendLastKmsg
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne04(TneBase):

    def __init__(self, path):
        super(Tne04, self).__init__(path)
        self._exp_class = "0xffffff04_KE"
        self._exp_type = "0xffffff04_KE"
        self._cur_process = "Kernel KE"
        self._package = "Kernel KE"

    def analyse(self):
        is_sprd = False
        dump_report_path, minidump_extend_last_kmsg_path = (None, None)
        TEST_LOGGER.info(f"检查{self._path}目录下是否有dump_report.txt和minidump_extend_last_kmsg文件", tag=(self.tne_dir_name))
        for root, dirs, files in os.walk(self._path):
            for file in files:
                if file == "dump_report.txt":
                    dump_report_path = os.path.join(root, file)
                    TEST_LOGGER.info(f"检查到dump_report.txt文件，路径为{dump_report_path}", tag=(self.tne_dir_name))
                    is_sprd = True
                    continue
                if "minidump_extend_last_kmsg" in file:
                    minidump_extend_last_kmsg_path = os.path.join(root, file)
                    TEST_LOGGER.info(f"检查到minidump_extend_last_kmsg文件，路径为{minidump_extend_last_kmsg_path}", tag=(self.tne_dir_name))
                    is_sprd = True
                    continue

        if is_sprd:
            exception_stack_info_list = []
            exception_reboot_reason, exception_panic_reason, exception_pc_symbol = (None,
                                                                                    None,
                                                                                    None)
            if dump_report_path:
                if os.path.isfile(dump_report_path):
                    dump_report = DumpReport(dump_report_path)
                    exception_reboot_reason, exception_panic_reason, exception_pc_symbol, exception_stack_info_list = dump_report.analyse()
            self._detail = f"*** sprd minidump ke ***\nexception_reboot_reason: {exception_reboot_reason}\nexception_panic_reason: {exception_panic_reason}\nexception_pc_symbol: {exception_pc_symbol}\nexception_stack_info_list:\n"
            self._detail = self._detail + "\n".join(exception_stack_info_list)
            self._caused_by = self._detail
            if minidump_extend_last_kmsg_path:
                if os.path.isfile(minidump_extend_last_kmsg_path):
                    minidump_extend_last_kmsg = MinidumpExtendLastKmsg(minidump_extend_last_kmsg_path)
                    last_kmsg_info = minidump_extend_last_kmsg.analyse()
                    if last_kmsg_info:
                        self._caused_by = self._caused_by + "\n" + last_kmsg_info
            return True
        if self._pstore_path:
            if os.path.isfile(self._pstore_path):
                pstore = Pstore(self._pstore_path)
                self._exp_time, self._package, self._detail = pstore.analyse_tne04()
                self._exp_time = "undefined" if self._exp_time is None else self._exp_time
                self._package = "system_server" if self._package is None else self._package
                self._cur_process = self._package
                if self._exp_type_set:
                    self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
                else:
                    self._detail_to_random()
                    if "tsbat_sysrst_set_cur_state" in self._detail:
                        self._package = "Thermal"
                        self._cur_process = "Thermal"
                    else:
                        self._package = "Kernel KE"
                return True
        TEST_LOGGER.debug("pstore 或者 pstore0 文件不存在", tag=(self.tne_dir_name))
        self._exp_type_set.add("TNE_ERROR_file_missing: pstore or pstore0")
        self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail_to_random()
        self._package = "Kernel KE"
        return False

    def get_battery_temperature_detail(self):
        is_temperature_problem = False
        battery_temperature_detail_list = []
        if self._pstore_path:
            if os.path.isfile(self._pstore_path):
                pstore = Pstore(self._pstore_path)
                is_temperature_problem, battery_temperature_detail_list = pstore.get_battery_temperature_detail()
        return (
         is_temperature_problem, battery_temperature_detail_list)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne04.pyc
