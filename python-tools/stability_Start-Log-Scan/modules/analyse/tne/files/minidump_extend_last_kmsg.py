# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\minidump_extend_last_kmsg.py
import os
from modules.common.Logger import TEST_LOGGER

class MinidumpExtendLastKmsg(object):

    def __init__(self, file_path):
        super(MinidumpExtendLastKmsg, self).__init__()
        self._MinidumpExtendLastKmsg__file_path = file_path

    def analyse(self):
        split_path_list = self._MinidumpExtendLastKmsg__file_path.split(os.sep)
        tne_dir_name = "dump_report"
        for dir_name in split_path_list:
            if dir_name.startswith("0x"):
                tne_dir_name = dir_name
                break

        TEST_LOGGER.debug(("开始解析minidump_extend_last_kmsg文件：{}".format(self._MinidumpExtendLastKmsg__file_path)), tag=tne_dir_name)
        last_kmsg_info = None
        with open((self._MinidumpExtendLastKmsg__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip().rstrip("\r\n")
                if "Unable to handle kernel paging request" in line:
                    last_kmsg_info = line

        return last_kmsg_info

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\minidump_extend_last_kmsg.pyc
