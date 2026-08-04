# -*- coding: utf-8 -*-
# @Time     : 2020/10/14 10:49
# @Author   : yunqing.gui
# @Email    : yunqing.gui@transsion.com
# @File     : logger.py
import datetime
import os
import logging

from modules.common.path import PathManager


DEFAULT_TAG = "MonkeyTest"


class Logger(object):

    def __init__(self, log_path, cmd_level=logging.INFO, file_level=logging.INFO):
        self.__tag = DEFAULT_TAG
        self.__logger = logging.getLogger()
        self.__logger.setLevel(logging.INFO)
        self.__file_level = file_level
        self.__formatter = logging.Formatter('[%(asctime)s][%(levelname)s] %(message)s', '%Y-%m-%d %H:%M:%S')

        self.__sh = logging.StreamHandler()
        self.__sh.setFormatter(self.__formatter)
        self.__sh.setLevel(cmd_level)

        self.__fh = logging.FileHandler(log_path, encoding="utf-8")
        self.__fh.setFormatter(self.__formatter)
        self.__fh.setLevel(file_level)

        self.__logger.addHandler(self.__sh)
        self.__logger.addHandler(self.__fh)

    def setDebugMode(self):
        self.__file_level = logging.DEBUG
        self.__logger.setLevel(self.__file_level)
        self.__sh.setLevel(self.__file_level)
        self.__fh.setLevel(self.__file_level)

    def resetLogFile(self, log_path):
        self.__logger.removeHandler(self.__fh)
        self.__fh = logging.FileHandler(log_path, encoding="utf-8")
        self.__fh.setFormatter(self.__formatter)
        self.__fh.setLevel(self.__file_level)
        self.__logger.addHandler(self.__fh)

    def resetTag(self, tag=None):
        if tag is None:
            self.__tag = DEFAULT_TAG
        else:
            self.__tag = tag

    def debug(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.debug("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self.__logger.debug("[{}] --- {}".format(tag, message))

    def info(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.info("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self.__logger.info("[{}] --- {}".format(tag, message))

    def warn(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.warning("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self.__logger.warning("[{}] --- {}".format(tag, message))

    def error(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.error("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self.__logger.error("[{}] --- {}".format(tag, message))

    def critical(self, message, sn=None, tag=None):
        if tag is None:
            tag = self.__tag
        if sn is not None:
            self.__logger.critical("[{}][{}] --- {}".format(tag, sn, message))
        else:
            self.__logger.critical("[{}] --- {}".format(tag, message))


if not os.path.isdir(PathManager.log_folder):
    os.makedirs(PathManager.log_folder)
loggerName = datetime.datetime.now().strftime("MonkeyTest_%Y_%m_%d.log")
loggerPath = os.path.join(PathManager.log_folder, loggerName)
TEST_LOGGER = Logger(loggerPath)
