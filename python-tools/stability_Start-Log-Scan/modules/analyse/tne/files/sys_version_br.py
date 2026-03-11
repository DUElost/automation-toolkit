# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_version_br.py
import os, re
from modules.common.Logger import TEST_LOGGER

class SysVersionBr(object):

    def __init__(self, file_path):
        super(SysVersionBr, self).__init__()
        self._SysVersionBr__file_path = file_path

    def analyse(self):
        build_time = None
        tne_dir_name = os.path.basename(os.path.dirname(self._SysVersionBr__file_path))
        TEST_LOGGER.debug(f"开始解析SYS_VERSION_BR文件：{self._SysVersionBr__file_path}", tag=tne_dir_name)
        regex_build_time = re.compile("SMP PREEMPT\\s+(.*)")
        with open((self._SysVersionBr__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                regex_rlt = re.search(regex_build_time, line)
                if regex_rlt:
                    build_time = regex_rlt.group(1)

        return build_time

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_version_br.pyc
