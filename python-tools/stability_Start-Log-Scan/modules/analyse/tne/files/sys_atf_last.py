# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_atf_last.py
import os, re
from modules.common.Decorators import func_timer
from modules.common.Logger import TEST_LOGGER

class SysAtfLast(object):

    def __init__(self, file_path):
        super(SysAtfLast, self).__init__()
        self._SysAtfLast__file_path = file_path

    @func_timer
    def analyse(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._SysAtfLast__file_path))
        TEST_LOGGER.debug(("开始解析SYS_ATF_LAST文件：{}".format(self._SysAtfLast__file_path)), tag=tne_dir_name)
        regex_cpu = re.compile("INFO:.*cpu\\((\\d)\\) pc:<.*?>")
        analyse_rlt_list = []
        with open((self._SysAtfLast__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines()[:]:
                regex_rlt = re.search(regex_cpu, line)
                if regex_rlt:
                    cpu_index = regex_rlt.group(1)
                    analyse_rlt_list.append(regex_rlt.group())
                    if cpu_index == 0:
                        break

        cpu_address_info = "\n".join(analyse_rlt_list[:]) if analyse_rlt_list else None
        return cpu_address_info

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_atf_last.pyc
