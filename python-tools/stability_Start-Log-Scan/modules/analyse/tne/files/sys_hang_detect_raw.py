# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\sys_hang_detect_raw.py
import os, re
from modules.common.Logger import TEST_LOGGER
PATTERN_WATCHDOG_D_LINE = re.compile("watchdog\\s+D")
PATTERN_WATCHDOG_S_LINE = re.compile("watchdog\\s+S")
PATTERN_SYSTEM_SERVER_D_LINE = re.compile("system_server\\s+D")
PATTERN_INIT_LINE_START = re.compile("init\\s+S")

class SysHangDetectRaw(object):

    def __init__(self, file_path):
        super(SysHangDetectRaw, self).__init__()
        self._SysHangDetectRaw__file_path = file_path

    def analyse(self, counts_value):
        tne_dir_name = os.path.basename(os.path.dirname(self._SysHangDetectRaw__file_path))
        TEST_LOGGER.debug(("开始解析SYS_HANG_DETECT_RAW文件：{}".format(self._SysHangDetectRaw__file_path)), tag=tne_dir_name)
        if counts_value == 5:
            init_info_list = []
            with open((self._SysHangDetectRaw__file_path), errors="ignore", encoding="utf-8") as f:
                init_start = False
                for line in f.readlines():
                    line = line.strip()
                    if init_start:
                        if line.startswith("<ffffffffffffffff>"):
                            init_info_list.append(line)
                            break
                        if line.startswith("init sysTid"):
                            break
                        init_info_list.append(line)
                    elif re.match(PATTERN_INIT_LINE_START, line):
                        init_start = True
                        init_info_list.append(line)

            return init_info_list
        watchdog_d_start = False
        watchdog_d_list = []
        watchdog_s_start = False
        watchdog_s_list = []
        system_server_d_start = False
        system_server_d_list = []
        with open((self._SysHangDetectRaw__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                line = line.strip()
                if re.match(PATTERN_WATCHDOG_D_LINE, line):
                    watchdog_s_start, system_server_d_start = (False, False)
                    if line in watchdog_d_list:
                        continue
                    else:
                        watchdog_d_list.append(line)
                        watchdog_d_start = True
                        continue
                if watchdog_d_start:
                    if line.startswith("<"):
                        watchdog_d_list.append(line)
                        continue
                if watchdog_d_start:
                    if not line.startswith("<"):
                        watchdog_d_start = False
                        continue
                if re.match(PATTERN_WATCHDOG_S_LINE, line):
                    watchdog_d_start, system_server_d_start = (False, False)
                    if line in watchdog_s_list:
                        continue
                    else:
                        watchdog_s_list.append(line)
                        watchdog_s_start = True
                        continue
                if watchdog_s_start:
                    if line.startswith("<"):
                        watchdog_s_list.append(line)
                        continue
                if watchdog_s_start:
                    if not line.startswith("<"):
                        watchdog_s_start = False
                        continue
                if re.match(PATTERN_SYSTEM_SERVER_D_LINE, line):
                    watchdog_d_start, watchdog_s_start = (False, False)
                    if line in system_server_d_list:
                        continue
                    else:
                        system_server_d_list.append(line)
                        system_server_d_start = True
                        continue
                if system_server_d_start:
                    if line.startswith("<"):
                        system_server_d_list.append(line)
                        continue
                if system_server_d_start:
                    system_server_d_start = line.startswith("<") or False
                    continue

        if watchdog_d_list:
            return watchdog_d_list
        if watchdog_s_list:
            return watchdog_s_list
        return system_server_d_list

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\sys_hang_detect_raw.pyc
