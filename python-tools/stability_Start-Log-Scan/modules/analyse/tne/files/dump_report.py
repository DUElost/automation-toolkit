# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\dump_report.py
import os
from modules.common.Logger import TEST_LOGGER

class DumpReport(object):

    def __init__(self, file_path):
        super(DumpReport, self).__init__()
        self._DumpReport__file_path = file_path

    def analyse(self):
        split_path_list = self._DumpReport__file_path.split(os.sep)
        tne_dir_name = "dump_report"
        for dir_name in split_path_list:
            if dir_name.startswith("0x"):
                tne_dir_name = dir_name
                break

        TEST_LOGGER.debug(("开始解析dump_report.txt文件：{}".format(self._DumpReport__file_path)), tag=tne_dir_name)
        start_stack_info = False
        exception_reboot_reason, exception_panic_reason, exception_pc_symbol = ('',
                                                                                '',
                                                                                '')
        exception_stack_info_list = []
        with open((self._DumpReport__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip().rstrip("\r\n")
                if "exception_reboot_reason" in line:
                    exception_reboot_reason = line.split(":")[-1].strip()
                    continue
                if "exception_panic_reason" in line:
                    exception_panic_reason = line.split(":")[-1].strip()
                    continue
                if "exception_pc_symbol" in line:
                    exception_pc_symbol = line.split(":")[-1].strip()
                    exception_pc_symbol = exception_pc_symbol.split("]")[-1].strip()
                    continue
                if "exception_stack_info" in line:
                    start_stack_info = True
                    if ":" in line:
                        line = line.split(":")[-1].strip()
                        line = line.split("]")[-1].strip()
                        exception_stack_info_list.append(line)
                        continue
                if start_stack_info:
                    if line.startswith("["):
                        exception_stack_info_list.append(line.split("]")[-1].strip())
                    else:
                        start_stack_info = False

        return (
         exception_reboot_reason, exception_panic_reason, exception_pc_symbol, exception_stack_info_list)


if __name__ == "__main__":
    DumpReport("D:\\log\\tne\\data\\TNE\\0xffffff04_2023_12_13_22_34_23_0\\1\\dump_report.txt").analyse()

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\dump_report.pyc
