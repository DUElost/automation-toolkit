# -*- coding: utf-8 -*-
"""流式日志：控制台即时输出 + log/ 目录落盘（对齐 Start-Log-Scan / Monkey-Log-Scan）。"""

import datetime
import logging
import os
import sys

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LOG_DIR = os.path.join(PROJECT_ROOT, "log")
DEFAULT_TAG = "ScanResult"
_LOGGER_NAME = "scan_result_gt"


class _FlushStreamHandler(logging.StreamHandler):
    """Windows 终端下每条日志立即刷新，避免长时间无输出。"""

    def emit(self, record):
        super().emit(record)
        self.flush()


def _ensure_logger():
    logger = logging.getLogger(_LOGGER_NAME)
    if logger.handlers:
        return logger
    os.makedirs(LOG_DIR, exist_ok=True)
    log_path = os.path.join(
        LOG_DIR, datetime.datetime.now().strftime("ScanResult_%Y_%m_%d.log"))
    logger.setLevel(logging.INFO)
    fmt = logging.Formatter(
        "[%(asctime)s][%(levelname)s] %(message)s", "%Y-%m-%d %H:%M:%S")
    sh = _FlushStreamHandler(sys.stdout)
    sh.setFormatter(fmt)
    fh = logging.FileHandler(log_path, encoding="utf-8")
    fh.setFormatter(fmt)
    logger.addHandler(sh)
    logger.addHandler(fh)
    logger.propagate = False
    return logger


class ScanLogger(object):
    def __init__(self):
        self._logger = _ensure_logger()
        self._tag = DEFAULT_TAG

    def reset_tag(self, tag=None):
        self._tag = tag or DEFAULT_TAG

    def _log(self, level, message, tag=None):
        tag = tag or self._tag
        self._logger.log(level, "[%s] --- %s" % (tag, message))

    def info(self, message, tag=None):
        self._log(logging.INFO, message, tag)

    def warn(self, message, tag=None):
        self._log(logging.WARNING, message, tag)

    def error(self, message, tag=None):
        self._log(logging.ERROR, message, tag)


TEST_LOGGER = ScanLogger()
