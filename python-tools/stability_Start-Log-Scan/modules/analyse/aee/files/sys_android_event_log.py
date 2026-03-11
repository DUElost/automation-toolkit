# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\sys_android_event_log.py
import datetime, os, re
from modules.common.Logger import TEST_LOGGER

class SysAndroidEventLog(object):

    def __init__(self, file_path):
        super(SysAndroidEventLog, self).__init__()
        self._SysAndroidEventLog__file_path = file_path
        self._SysAndroidEventLog__aee_dir = os.path.dirname(file_path)
        self._SysAndroidEventLog__aee_dir_name = os.path.basename(self._SysAndroidEventLog__aee_dir)

    def is_am_anr(self, exp_time_str, pid):
        is_am_anr = False
        screen_toggled_0_before_am_anr = False
        last_am_anr_line = None
        last_am_anr_pid = None
        no_focused_window = False
        TEST_LOGGER.debug("开始在 SYS_ANDROID_EVENT_LOG 文件中 检查是否 am_anr 与对应 pid", tag=(self._SysAndroidEventLog__aee_dir_name))
        TEST_LOGGER.debug(("exp_time: {}".format(exp_time_str)), tag=(self._SysAndroidEventLog__aee_dir_name))
        regex_am_anr = re.compile("(\\d{2}:\\d{2}:\\d{2}).\\d+.*am_anr\\s+:\\s+\\[\\d+,(\\d+)")
        with open((self._SysAndroidEventLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            screen_toggled_0 = False
            for line in f.readlines():
                line = line.strip()
                if "screen_toggled: 0" in line:
                    screen_toggled_0 = True
                    continue
                if "screen_toggled: 1" in line:
                    screen_toggled_0 = False
                    continue
                if "am_anr" in line:
                    TEST_LOGGER.debug(line)
                    regex_rlt = re.search(regex_am_anr, line)
                    if regex_rlt:
                        am_anr_time_str = regex_rlt.group(1)
                        am_anr_pid_str = regex_rlt.group(2)
                        am_anr_time = datetime.datetime.strptime(am_anr_time_str, "%H:%M:%S")
                        exp_time = datetime.datetime.strptime(exp_time_str, "%H:%M:%S")
                        delta_time_second = (exp_time - am_anr_time).seconds
                        TEST_LOGGER.debug(("Input pid: {}，analysed pid：{}，Input time：{}，analysed time：{}，delta time：{}".format(pid, am_anr_pid_str, exp_time_str, am_anr_time_str, delta_time_second)), tag=(self._SysAndroidEventLog__aee_dir_name))
                        if 0 <= delta_time_second < 120:
                            if pid:
                                if pid != am_anr_pid_str:
                                    continue
                                else:
                                    is_am_anr = True
                                    last_am_anr_line = line
                                    last_am_anr_pid = pid
                                    screen_toggled_0_before_am_anr = screen_toggled_0
                            else:
                                is_am_anr = True
                                last_am_anr_line = line
                                last_am_anr_pid = am_anr_pid_str
                                screen_toggled_0_before_am_anr = screen_toggled_0
                        if delta_time_second <= 0:
                            break

        if last_am_anr_line:
            if "does not have a focused window" in last_am_anr_line:
                TEST_LOGGER.debug(("行：{} 中含有 does not have a focused window".format(last_am_anr_line)), tag=(self._SysAndroidEventLog__aee_dir_name))
                no_focused_window = True
        return (
         is_am_anr, last_am_anr_pid, no_focused_window, screen_toggled_0_before_am_anr)

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\sys_android_event_log.pyc
