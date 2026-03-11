# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\sys_properties.py
import os
from modules.common.Logger import TEST_LOGGER

class SysProperties(object):

    def __init__(self, file_path):
        super(SysProperties, self).__init__()
        self._SysProperties__file_path = file_path
        self._SysProperties__build_version = None
        self._SysProperties__device_id = None
        self._SysProperties__build_type = None
        self._SysProperties__build_user = None
        self._SysProperties__is_root = False
        self._SysProperties__hardware_marked = False
        self._SysProperties__fans_version = False
        self._SysProperties__analyse(self._SysProperties__file_path)

    def __analyse(self, file_path):
        TEST_LOGGER.debug("开始解析 SYS_PROPERTIES 文件：{}".format(file_path))
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "[ro.build.display.id]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProperties__build_version = line.strip("[").strip("]")
                if "[ro.serialno]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProperties__device_id = line.strip("[").strip("]")
                if "[ro.build.type]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProperties__build_type = line.strip("[").strip("]")
                if "[ro.build.user]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProperties__build_user = line.strip("[").strip("]")
                if "[persist.user.root.support]: [1]" in line:
                    self._SysProperties__is_root = True
                if "[persist.sys.crashsplit.hardware]: [1]" in line:
                    self._SysProperties__hardware_marked = True
                if "[persist.vendor.fans.support]: [1]" in line or "[persist.sys.fans.support]: [1]" in line:
                    self._SysProperties__fans_version = True

    @property
    def build_version(self):
        return self._SysProperties__build_version

    @property
    def device_id(self):
        return self._SysProperties__device_id

    @property
    def build_type(self):
        return self._SysProperties__build_type

    @property
    def build_user(self):
        return self._SysProperties__build_user

    @property
    def is_root(self):
        return self._SysProperties__is_root

    @property
    def fans_version(self):
        if self._SysProperties__build_type == "user" and self._SysProperties__fans_version:
            self._SysProperties__fans_version = True
        else:
            self._SysProperties__fans_version = False
        return self._SysProperties__fans_version


if __name__ == "__main__":
    sys_properties = SysProperties("D:\\Ongoing\\aee\\db.00.JE.dbg.DEC\\SYS_PROPERTIES")
    print(sys_properties.build_version)

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\sys_properties.pyc
