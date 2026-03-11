# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne02.py
import os
from modules.analyse.tne.files.tombstone import Tombstone
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class Tne02(TneBase):

    def __init__(self, path):
        super(Tne02, self).__init__(path)
        self._exp_class = "0xffffff02_fatal_ne"
        self._exp_type = "0xffffff02_fatal_ne"

    def analyse(self):
        if not (self._tombstone_path and os.path.isfile(self._tombstone_path)):
            TEST_LOGGER.debug(("tombstone 文件不存在：{}".format(self._path)), tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: tombstone")
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
            self._detail_to_random()
            return False
        TEST_LOGGER.debug(("tombstone文件：{}".format(self._tombstone_path)), tag=(self.tne_dir_name))
        tombstone = Tombstone(self._tombstone_path)
        self._exp_time = tombstone.timestamp
        self._cur_process = tombstone.process
        self._package = tombstone.package
        self._detail = tombstone.detail
        if self._exp_type_set:
            self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
        self._detail_to_random()
        return True

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne02.pyc
