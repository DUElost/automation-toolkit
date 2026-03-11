# -*- coding: utf-8 -*-
# 反编译后清理的文件

import os
from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.files.android_system_log import AndroidSystemLog
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.files.sys_kernel_log import SysKernelLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER


class Tne06(TneBase):

    def __init__(self, path):
        super(Tne06, self).__init__(path)
        self._exp_class = "0xffffff06_stucklogo"
        self._exp_type = "0xffffff06_stucklogo"
        self._cur_process = "system_server"
        self._package = "system_server"

    def analyse(self):
        """分析方法 - 简化实现"""
        return True
