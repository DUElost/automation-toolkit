# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\exp_detail.py
import os, re
from modules.common.Logger import TEST_LOGGER

class ExpDetail(object):

    def __init__(self, file_path):
        super(ExpDetail, self).__init__()
        self._ExpDetail__file_path = file_path
        self._ExpDetail__aee_dir = os.path.dirname(file_path)
        self._ExpDetail__aee_dir_name = os.path.basename(self._ExpDetail__aee_dir)
        self._ExpDetail__cur_process = None
        self._ExpDetail__ignore_ne_hwasan = False

    def get_cur_process(self):
        regex_cur_process = re.compile(">>>(.*)<<<")
        TEST_LOGGER.debug("开始在 _exp_detail.txt 中获取process信息", tag=(self._ExpDetail__aee_dir_name))
        with open((self._ExpDetail__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "tag-mismatch on address" in line:
                    self._ExpDetail__ignore_ne_hwasan = True
                regex_rlt = re.search(regex_cur_process, line)
                if regex_rlt:
                    self._ExpDetail__cur_process = regex_rlt.group(1).strip()
                if self._ExpDetail__cur_process is not None and self._ExpDetail__ignore_ne_hwasan:
                    break

        return (
         self._ExpDetail__cur_process, self._ExpDetail__ignore_ne_hwasan)

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\exp_detail.pyc
