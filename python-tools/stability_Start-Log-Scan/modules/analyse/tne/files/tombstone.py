# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\tombstone.py
import os, re
from modules.common.Logger import TEST_LOGGER

class Tombstone(object):

    def __init__(self, file_path):
        super(Tombstone, self).__init__()
        self._Tombstone__file_path = file_path
        self._Tombstone__build_fingerprint = None
        self._Tombstone__timestamp = None
        self._Tombstone__process = None
        self._Tombstone__package = None
        self._Tombstone__version_tag = None
        self._Tombstone__detail = ""
        self._Tombstone__analyse()

    @property
    def build_fingerprint(self):
        return self._Tombstone__build_fingerprint

    @property
    def timestamp(self):
        return self._Tombstone__timestamp

    @property
    def process(self):
        return self._Tombstone__process

    @property
    def package(self):
        return self._Tombstone__package

    @property
    def detail(self):
        return self._Tombstone__detail

    @property
    def version_tag(self):
        return self._Tombstone__version_tag

    def __analyse(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Tombstone__file_path))
        TEST_LOGGER.debug(("开始解析tombstone文件：{}".format(self._Tombstone__file_path)), tag=tne_dir_name)
        regex_time = re.compile("\\d{4}-\\d{2}-\\d{2}\\s+\\d{2}:\\d{2}:\\d{2}")
        regex_process = re.compile(">>>\\s+(\\S+)\\s+<<<")
        regex_detail = re.compile("#\\d\\d\\s+\\S+\\s+\\S+\\s+(/.+\\+)")
        regex_version = re.compile("\\d{6}V\\d+")
        detail_start_flag = False
        detail_count = 1
        detail_got_flag = False
        with open((self._Tombstone__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if self._Tombstone__build_fingerprint:
                    if self.timestamp:
                        if self.process:
                            if self.package:
                                if detail_got_flag:
                                    break
                else:
                    line = line.strip()
                    if "Build fingerprint:" in line:
                        regex_rlt = re.search(regex_version, line)
                        if regex_rlt:
                            self._Tombstone__version_tag = regex_rlt.group()
                        line = line.split(":")[1].strip()
                        self._Tombstone__build_fingerprint = line.strip().strip("'")
                        continue
                    if "Timestamp:" in line:
                        re_rlt_time = re.search(regex_time, line)
                        if re_rlt_time:
                            self._Tombstone__timestamp = re_rlt_time.group()
                            continue
                    if not self._Tombstone__process:
                        if re.search(regex_process, line):
                            self._Tombstone__process = re.search(regex_process, line).group(1)
                            self._Tombstone__package = self._Tombstone__process
                            continue
                if detail_start_flag:
                    if re.search(regex_detail, line):
                        if self._Tombstone__detail == "":
                            self._Tombstone__detail = re.search(regex_detail, line).group(1)
                        else:
                            self._Tombstone__detail = self._Tombstone__detail + "\n" + re.search(regex_detail, line).group(1)
                        detail_count = detail_count + 1
                        if detail_count >= 11:
                            detail_got_flag = True
                            continue
                if "backtrace:" in line:
                    detail_start_flag = True
                    continue

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\tombstone.pyc
