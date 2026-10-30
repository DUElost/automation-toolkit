# -*- coding: utf-8 -*-
import copy
import os
import re

from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

_TDS_EXCEPTION_RE = re.compile(
    r"(?P<exp_time>\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\.\d+).*TDS Exception for\s*\[(?P<code>[^\]\r\n]+)\]"
)


class TneBacklightSensorDetect(TneBase):

    def __init__(self, path, tne_type="", build_version=None):
        super(TneBacklightSensorDetect, self).__init__(path)
        self._tne_id = tne_type
        self._exp_class = tne_type
        self._exp_type = tne_type
        self._cur_process = tne_type
        self._package = tne_type
        self._extra_results = []
        self._preserve_parse_fields = True
        if build_version and (self._version == "undefined" or self._version is None):
            self._version = build_version

    def analyse(self):
        if not os.path.isfile(self._android_system_log_path):
            TEST_LOGGER.info("android_system_log 文件不存在：{}".format(self._android_system_log_path), tag=self.tne_dir_name)
            self._caused_by = "miss file android_system_log"
            self._detail = "miss file android_system_log"
            return False
        hits = self._read_tds_exceptions(self._android_system_log_path)
        if not hits:
            TEST_LOGGER.info("android_system_log 未找到 TDS Exception for", tag=self.tne_dir_name)
            self._caused_by = "miss keyword TDS Exception for"
            self._detail = "miss keyword TDS Exception for"
            return False
        TEST_LOGGER.info(
            "TDS Exception for 命中 {} 条，每条单独写入结果表".format(len(hits)),
            tag=self.tne_dir_name)
        self._apply_hit(hits[0])
        self._extra_results = []
        for hit in hits[1:]:
            clone = copy.copy(self)
            clone._extra_results = []
            clone._apply_hit(hit)
            self._extra_results.append(clone)

    def _apply_hit(self, hit):
        tne_id = self._tne_id
        error_code = hit["code"]
        self._exp_time = hit["exp_time"]
        self._exp_class = "{}_{}".format(tne_id, error_code)
        self._exp_type = "{}_{}".format(tne_id, error_code)
        self._cur_process = "{}_{}".format(tne_id, error_code)
        self._package = "{}_{}".format(tne_id, error_code)
        self._detail = "ExpClass: {}\nErrorCode：{}".format(tne_id, error_code)
        self._caused_by = hit["line"]

    @staticmethod
    def _read_tds_exceptions(log_path):
        hits = []
        with open(log_path, "r", encoding="utf-8", errors="ignore") as log_file:
            for raw_line in log_file:
                if "TDS Exception for" not in raw_line:
                    continue
                line = raw_line.rstrip("\r\n")
                matched = _TDS_EXCEPTION_RE.search(line)
                if not matched:
                    continue
                hits.append({
                    "exp_time": matched.group("exp_time"),
                    "code": matched.group("code").strip(),
                    "line": line,
                })
        return hits
