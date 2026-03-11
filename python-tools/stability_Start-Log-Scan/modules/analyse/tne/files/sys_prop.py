# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_prop.py
import os
from modules.common.Logger import TEST_LOGGER

class SysProp(object):

    def __init__(self, file_path):
        super(SysProp, self).__init__()
        self._SysProp__file_path = file_path
        self._SysProp__build_version = "undefined"
        self._SysProp__device_id = "undefined"
        self._SysProp__build_type = None
        self._SysProp__build_user = None
        self._SysProp__is_root = False
        self._SysProp__hardware_marked = False
        self._SysProp__gms_serial = "undefined"
        self._SysProp__country = "undefined"
        self._SysProp__system_server_start_count = None
        self._SysProp__analyse(self._SysProp__file_path)

    def __analyse(self, file_path):
        tne_dir_name = os.path.basename(os.path.dirname(file_path))
        TEST_LOGGER.debug(("开始解析sys_prop文件：{}".format(file_path)), tag=tne_dir_name)
        with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "[persist.sys.crashsplit.hardware]: [1]" in line:
                    self._SysProp__hardware_marked = True
                    continue
                if "[ro.build.display.id]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProp__build_version = line.strip("[").strip("]")
                    continue
                if "[ro.serialno]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProp__device_id = line.strip("[").strip("]")
                    continue
                if "[ro.build.type]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProp__build_type = line.strip("[").strip("]")
                    continue
                if "[ro.build.user]" in line:
                    line = line.split(":")[1].strip()
                    self._SysProp__build_user = line.strip("[").strip("]")
                    continue
                if "[persist.user.root.support]: [1]" in line:
                    self._SysProp__is_root = True
                    continue
                if "[sys.system_server.start_count]" in line:
                    line = line.split(":")[1].strip()
                    try:
                        self._SysProp__system_server_start_count = int(line.strip("[").strip("]"))
                    except:
                        TEST_LOGGER.warn(f"sys.system_server.start_count 值读取异常：\n{line}", tag=tne_dir_name)
                    else:
                        continue

                    if "[vendor.gsm.serial]" in line:
                        try:
                            line = line.split(":")[1].strip()
                            self._SysProp__gms_serial = line.strip("[").strip("]").split()[0]
                        except:
                            TEST_LOGGER.warn(f"vendor.gsm.serial 值读取异常：\n{line}", tag=tne_dir_name)

                        continue
                    if "[persist.sys.oobe_country]" in line:
                        try:
                            line = line.split(":")[1].strip()
                            self._SysProp__country = line.strip("[").strip("]").split()[0]
                        except:
                            TEST_LOGGER.warn(f"persist.sys.oobe_country 值读取异常：\n{line}", tag=tne_dir_name)

    @property
    def build_version(self):
        return self._SysProp__build_version

    @property
    def device_id(self):
        return self._SysProp__device_id

    @property
    def build_type(self):
        return self._SysProp__build_type

    @property
    def build_user(self):
        return self._SysProp__build_user

    @property
    def is_root(self):
        return self._SysProp__is_root

    @property
    def is_hardware_marked(self):
        return self._SysProp__hardware_marked

    @property
    def gms_serial(self):
        return self._SysProp__gms_serial

    @property
    def system_server_start_count(self):
        return self._SysProp__system_server_start_count

    @property
    def country(self):
        return self._SysProp__country


if __name__ == "__main__":
    sys_prop = SysProp("D:\\Ongoing\\TNE\\tne\\0xffffff01_2020_01_01_00_01_33_1\\0xffffff01_2020_01_01_00_01_33_1\\sys_prop")
    print(sys_prop.build_version)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_prop.pyc
