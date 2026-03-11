# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\sys_android_log.py
import os, re
from modules.common.Logger import TEST_LOGGER

class SysAndroidLog(object):

    def __init__(self, file_path):
        super(SysAndroidLog, self).__init__()
        self._SysAndroidLog__file_path = file_path
        self._SysAndroidLog__aee_dir = os.path.dirname(file_path)
        self._SysAndroidLog__aee_dir_name = os.path.basename(self._SysAndroidLog__aee_dir)
        self._SysAndroidLog__cur_process = None

    def get_cur_process(self, pid, tid):
        if pid and tid:
            regex_cur_process = re.compile("pid:\\s+" + "{},".format(pid) + "\\s+tid:\\s+" + "{},".format(tid) + ".*>>>(.*)<<<")
        else:
            if pid:
                regex_cur_process = re.compile("pid:\\s+" + "{},".format(pid) + "\\s+tid:\\s+\\d+" + ".*>>>(.*)<<<")
        TEST_LOGGER.debug(("开始在 SYS_ANDROID_LOG 中获取pid：{} tid：{} 的process信息".format(pid, tid)), tag=(self._SysAndroidLog__aee_dir_name))
        with open((self._SysAndroidLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                regex_rlt = re.search(regex_cur_process, line)
                if regex_rlt:
                    self._SysAndroidLog__cur_process = regex_rlt.group(1).strip()
                    break

        return self._SysAndroidLog__cur_process

    def is_hprof_anr(self, pid):
        with open((self._SysAndroidLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "hprof: heap dump completed" in line and pid in line:
                    return True

        return False

    def is_nfc_too_close(self):
        with open((self._SysAndroidLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "len =   9 > 600006A0" in line:
                    return True

        return False

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\sys_android_log.pyc
