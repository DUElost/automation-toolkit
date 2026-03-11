# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\common\Logger.py
import os, logging, datetime
from modules.common import GlobalAttrs
from modules.common.Path import PathManager
DEFAULT_TAG = "LOG_SCAN"

class Logger(object):

    def __init__(self, log_path, cmd_level=logging.INFO, file_level=logging.INFO):
        self._Logger__tag = DEFAULT_TAG
        self._Logger__logger = logging.getLogger()
        self._Logger__logger.setLevel(logging.INFO)
        self._Logger__file_level = file_level
        self._Logger__formatter = logging.Formatter("[%(asctime)s][%(levelname)s] %(message)s", "%Y-%m-%d %H:%M:%S")
        self._Logger__sh = logging.StreamHandler()
        self._Logger__sh.setFormatter(self._Logger__formatter)
        self._Logger__sh.setLevel(cmd_level)
        self._Logger__fh = logging.FileHandler(log_path, encoding="utf-8")
        self._Logger__fh.setFormatter(self._Logger__formatter)
        self._Logger__fh.setLevel(file_level)
        self._Logger__logger.addHandler(self._Logger__sh)
        self._Logger__logger.addHandler(self._Logger__fh)

    def setDebugMode(self):
        self._Logger__logger.setLevel(logging.DEBUG)
        self._Logger__sh.setLevel(logging.DEBUG)
        self._Logger__fh.setLevel(logging.DEBUG)

    def resetLogFile(self, log_path):
        self._Logger__logger.removeHandler(self._Logger__fh)
        fh = logging.FileHandler(log_path, encoding="utf-8")
        fh.setFormatter(self._Logger__formatter)
        fh.setLevel(self._Logger__file_level)
        self._Logger__logger.addHandler(fh)

    def resetTag(self, tag=None):
        if tag is None:
            self._Logger__tag = DEFAULT_TAG
        else:
            self._Logger__tag = tag

    def debug(self, message, sn=None, tag=None):
        if tag is None:
            tag = self._Logger__tag
        if sn is not None:
            self._Logger__logger.debug("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self._Logger__logger.debug("[{}] --- {}".format(tag, message))

    def info(self, message, sn=None, tag=None):
        if tag is None:
            tag = self._Logger__tag
        if sn is not None:
            self._Logger__logger.info("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self._Logger__logger.info("[{}] --- {}".format(tag, message))

    def warn(self, message, sn=None, tag=None):
        if tag is None:
            tag = self._Logger__tag
        if sn is not None:
            self._Logger__logger.warning("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self._Logger__logger.warning("[{}] --- {}".format(tag, message))

    def error(self, message, sn=None, tag=None):
        if tag is None:
            tag = self._Logger__tag
        if sn is not None:
            self._Logger__logger.error("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self._Logger__logger.error("[{}] --- {}".format(tag, message))

    def critical(self, message, sn=None, tag=None):
        if tag is None:
            tag = self._Logger__tag
        if sn is not None:
            self._Logger__logger.critical("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self._Logger__logger.critical("[{}] --- {}".format(tag, message))


if not os.path.isdir(PathManager.log_folder):
    os.makedirs(PathManager.log_folder)
loggerName = datetime.datetime.now().strftime("LogScan_%Y_%m_%d.log")
loggerPath = os.path.join(PathManager.log_folder, loggerName)
TEST_LOGGER = Logger(loggerPath)

# okay decompiling extracted_pyz_modules\modules\common\Logger.pyc
