# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\TneSubsystemCrash.py
from modules.analyse.tne.types.tne_base import TneBase

class TneSubsystemCrash(TneBase):

    def __init__(self, path, tne_type, build_version):
        super(TneSubsystemCrash, self).__init__(path)
        self._exp_class = tne_type
        self._exp_type = tne_type
        self._cur_process = tne_type
        self._package = tne_type
        if build_version:
            if self._version == "undefined" or self._version is None:
                self._version = build_version

    def analyse(self):
        self._detail = f"BuildVersion: {self._version}\nExpClass: {self._exp_class}"
        if self._exp_class in ('0xffffff0b', ):
            self._extra_tag = "subsystem_crash_modem"
            self._caused_by = "埋点名称：Modem ee\n埋点描述：收集modem ee子系统异常相关信息"
        else:
            if self._exp_class in ('0xffffff40', ):
                self._extra_tag = "subsystem_crash_wifi"
                self._caused_by = "埋点名称：wcn_ee_reset\n埋点描述：收集wifi子系统重启相关信息"
            else:
                if self._exp_class in ('0xffffff41', ):
                    self._extra_tag = "subsystem_crash_tee"
                    self._caused_by = "埋点名称：secure_tee\n埋点描述：收集TEE os panic以及TA异常相关信息"
                else:
                    if self._exp_class in ('0xffffff42', ):
                        self._extra_tag = "subsystem_crash_sensor_hub"
                        self._caused_by = "埋点名称：sensorhub_ee\n埋点描述：收集sensor hub子系统异常相关信息"
                    else:
                        if self._exp_class in ('0xffffff44', ):
                            self._extra_tag = "subsystem_crash_bt"
                            self._caused_by = "埋点名称：wcn_bt_exc\n埋点描述：收集bt子系统异常相关信息"
                        else:
                            self._extra_tag = "subsystem_crash"
                            self._caused_by = "未知的SubsystemCrash埋点类型"

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\TneSubsystemCrash.pyc
