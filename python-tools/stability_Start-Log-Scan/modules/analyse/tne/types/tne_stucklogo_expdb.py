# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne_stucklogo_expdb.py
import os
from modules.analyse.tne.files.proc_cur_tsk import ProcCurTsk
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.files.sys_hang_detect_raw import SysHangDetectRaw
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class TneStuckLogoExpdb(TneBase):

    def __init__(self, path):
        super(TneStuckLogoExpdb, self).__init__(path)
        self._exp_class = "expdb_stucklogo"
        self._exp_type = "expdb_stucklogo"
        self._cur_process = "Kernel KE"
        self._package = "Kernel KE"

    def analyse(self):
        """
        解析expdb，KE或者Hang
        :return:
        """
        get_detail_msg = False
        analysed_file_obj = None
        if self._pstore_path and os.path.isfile(self._pstore_path):
            pstore = Pstore(self._pstore_path)
            exp_time, package, self._detail = pstore.analyse_tne04()
            if self._detail:
                get_detail_msg = True
                analysed_file_obj = pstore
                self._exp_time = "undefined" if exp_time is None else exp_time
        else:
            TEST_LOGGER.debug("pstore 或者 pstore0 文件不存在", tag=(self.tne_dir_name))
        expdb_kernel_log_path = get_detail_msg or None
        for f in os.listdir(self._path):
            if f.startswith("SYS_KERNEL_LOG"):
                expdb_kernel_log_path = os.path.join(self._path, f)
                break

        if expdb_kernel_log_path:
            expdb_kernel_log = Pstore(expdb_kernel_log_path)
            exp_time, package, self._detail = expdb_kernel_log.analyse_tne04()
            if self._detail:
                get_detail_msg = True
                self._exp_time = "undefined" if exp_time is None else exp_time
                analysed_file_obj = expdb_kernel_log
            else:
                TEST_LOGGER.debug("SYS_KERNEL_LOG_xxx 文件不存在", tag=(self.tne_dir_name))
        else:
            if not get_detail_msg:
                if os.path.isfile(self._sys_last_kmsg):
                    sys_last_kmsg = Pstore(self._sys_last_kmsg)
                    exp_time, package, self._detail = sys_last_kmsg.analyse_tne04()
                    if self._detail:
                        get_detail_msg = True
                        self._exp_time = "undefined" if exp_time is None else exp_time
                        analysed_file_obj = sys_last_kmsg
            else:
                TEST_LOGGER.debug("SYS_LAST_KMSG 文件不存在", tag=(self.tne_dir_name))
            is_ke_issue = True
            if get_detail_msg:
                TEST_LOGGER.debug("判断是否为Reboot问题", tag=(self.tne_dir_name))
                if analysed_file_obj.is_reboot():
                    TEST_LOGGER.info("Reboot问题，设置自定义标签：Reboot", tag=(self.tne_dir_name))
                    self._extra_tag = "Reboot"
                else:
                    if self._detail == "tsbat_sysrst_set_cur_state":
                        TEST_LOGGER.info("过温问题，不再检查el1内容", tag=(self.tne_dir_name))
                    else:
                        if os.path.isfile(self._proc_cur_tsk):
                            proc_cur_tsk = ProcCurTsk(self._proc_cur_tsk)
                            proc_cur_tsk_detail = proc_cur_tsk.analyse()
                            if proc_cur_tsk_detail:
                                self._detail = self._detail + "\n\n" + proc_cur_tsk_detail
                            else:
                                is_ke_issue = False
                        else:
                            if "el1_" not in self._detail:
                                is_ke_issue = False
            else:
                TEST_LOGGER.debug("获取Detail信息失败，判断为非KE问题", tag=(self.tne_dir_name))
                is_ke_issue = False
            if not is_ke_issue:
                if analysed_file_obj:
                    TEST_LOGGER.debug("非KE问题，检查是否Hang问题", tag=(self.tne_dir_name))
                    detail_list, counts_value = analysed_file_obj.get_counts_for_tne0c()
                    if detail_list:
                        if counts_value and counts_value == 11:
                            pass
                        elif self._sys_hang_detect_raw_path and os.path.isfile(self._sys_hang_detect_raw_path):
                            sys_hang_detect_raw = SysHangDetectRaw(self._sys_hang_detect_raw_path)
                            hang_detect_list = sys_hang_detect_raw.analyse(counts_value)
                            if hang_detect_list:
                                if detail_list:
                                    detail_list.append("")
                                detail_list.extend(hang_detect_list)
                        else:
                            TEST_LOGGER.debug("SYS_HANG_DETECT_RAW 文件不存在", tag=(self.tne_dir_name))
                            self._exp_type_set.add("TNE_ERROR_file_missing: SYS_HANG_DETECT_RAW")
                            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
                        self._extra_tag = "Hang"
                        self._detail = "\n".join(detail_list)
                        self._package = "HANG_DETECT"
                        self._cur_process = "HANG_DETECT"
                    else:
                        TEST_LOGGER.warn("未获取Hang信息，设置自定义标签：Invalid", tag=(self.tne_dir_name))
                    self._extra_tag = "Invalid"
                else:
                    TEST_LOGGER.warn("未找到可分析文件，设置自定义标签：Invalid", tag=(self.tne_dir_name))
                    self._extra_tag = "Invalid"
        if self._detail:
            if "tsbat_sysrst_set_cur_state" in self._detail:
                self._package = "Thermal"
                self._cur_process = "Thermal"
        self._detail_to_random()

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne_stucklogo_expdb.pyc
