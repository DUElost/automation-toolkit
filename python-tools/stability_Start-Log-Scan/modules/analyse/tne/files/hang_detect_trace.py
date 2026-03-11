# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\hang_detect_trace.py
import os, re
from modules.common.Logger import TEST_LOGGER

class HangDetectTrace(object):

    def __init__(self, file_path):
        super(HangDetectTrace, self).__init__()
        self._HangDetectTrace__file_path = file_path

    def analyse(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._HangDetectTrace__file_path))
        TEST_LOGGER.debug(("开始解析hang_detect_trace文件：{}".format(self._HangDetectTrace__file_path)), tag=tne_dir_name)
        found_watchdog = False
        analyse_rlt_list = []
        regex_key = re.compile(">(.*)\\+")
        with open((self._HangDetectTrace__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                if found_watchdog:
                    regex_rlt = re.search(regex_key, line)
                    if regex_rlt:
                        analyse_rlt_list.append(regex_rlt.group(1))
                    if line == "---":
                        break
                    elif line.startswith("watchdog"):
                        found_watchdog = True

        detail = "\n".join(analyse_rlt_list) if analyse_rlt_list else None
        return detail

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\hang_detect_trace.pyc
