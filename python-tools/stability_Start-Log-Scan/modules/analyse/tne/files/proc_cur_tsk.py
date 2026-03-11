# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\proc_cur_tsk.py
import os, re
from modules.common.Logger import TEST_LOGGER

class ProcCurTsk(object):

    def __init__(self, file_path):
        super(ProcCurTsk, self).__init__()
        self._ProcCurTsk__file_path = file_path

    def analyse(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._ProcCurTsk__file_path))
        TEST_LOGGER.debug(("开始解析PROC_CUR_TSK文件：{}".format(self._ProcCurTsk__file_path)), tag=tne_dir_name)
        detail = None
        pattern_el1 = re.compile("]\\s+el1_")
        find_el1_line = False
        msg_list = []
        with open((self._ProcCurTsk__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                if find_el1_line:
                    line_split = line.split(" ")
                    if len(line_split) > 1:
                        msg_list.append(line_split[1])
                    else:
                        msg_list.append(line)
                    if len(msg_list) == 7:
                        break
                    else:
                        continue
                if re.search(pattern_el1, line):
                    find_el1_line = True
                    line_split = line.split(" ")
                    if len(line_split) > 1:
                        msg_list.append(line_split[1])
                    else:
                        msg_list.append(line)

        if msg_list:
            detail = "\n".join(msg_list)
        return detail

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\proc_cur_tsk.pyc
