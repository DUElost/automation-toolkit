# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_log_dur_lkdump.py
import os, re
from modules.common.Logger import TEST_LOGGER

class SysLogDurLkdump(object):

    def __init__(self, file_path):
        super(SysLogDurLkdump, self).__init__()
        self._SysLogDurLkdump__file_path = file_path

    def analyse(self):
        build_time = None
        version = None
        tne_dir_name = os.path.basename(os.path.dirname(self._SysLogDurLkdump__file_path))
        TEST_LOGGER.debug(f"开始解析SYS_LOG_DUR_LKDUMP文件：{self._SysLogDurLkdump__file_path}", tag=tne_dir_name)
        regex_build_time = re.compile("Build Time:\\s+(\\d+)-\\d+")
        regex_version = re.compile("tkv base =ro.build.display.id=(\\S+)")
        with open((self._SysLogDurLkdump__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                regex_rlt = re.search(regex_build_time, line)
                if regex_rlt:
                    build_time = regex_rlt.group(1)
                    continue
                regex_rlt = re.search(regex_version, line)
                if regex_rlt:
                    version = regex_rlt.group(1)

        if version is None:
            version = build_time
        return version

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_log_dur_lkdump.pyc
