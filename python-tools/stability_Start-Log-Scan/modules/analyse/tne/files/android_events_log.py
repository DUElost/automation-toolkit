# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\android_events_log.py
import os, re, datetime
from modules.common.Logger import TEST_LOGGER

class AndroidEventsLog(object):

    def __init__(self, file_path):
        super(AndroidEventsLog, self).__init__()
        self._AndroidEventsLog__file_path = file_path

    def found_watchdog(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidEventsLog__file_path))
        TEST_LOGGER.debug(("开始解析android_events_log文件：{}".format(self._AndroidEventsLog__file_path)), tag=tne_dir_name)
        regex_key_watchdog_block_thread = re.compile("\\(([^\\)]*)\\)")
        regex_key_watchdog_time = re.compile("(\\d+-\\d+\\s+\\d\\d:\\d\\d:\\d\\d)\\.\\d+\\s+(\\d+)")
        found_watchdog = False
        block_pid = None
        block_time = None
        exp_time = None
        block_thread_list = []
        binder_wait = False
        watchdog_error_msg = None
        last_watchdog_line = None
        with open((self._AndroidEventsLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "watchdog" in line:
                    last_watchdog_line = line.strip()
                    TEST_LOGGER.debug(("watchdog:{}".format(last_watchdog_line)), tag=tne_dir_name)

        if last_watchdog_line:
            TEST_LOGGER.debug(("获取最后含有watchdog的行：{}".format(last_watchdog_line)), tag=tne_dir_name)
            regex_rlt = re.match(regex_key_watchdog_time, last_watchdog_line)
            if regex_rlt:
                found_watchdog = True
                block_time_str = regex_rlt.group(1)
                exp_time = block_time_str
                try:
                    block_time = datetime.datetime.strptime(block_time_str, "%m-%d %H:%M:%S")
                except:
                    block_time = datetime.datetime.strptime(str(datetime.datetime.now().year) + "-" + block_time_str, "%Y-%m-%d %H:%M:%S")

                block_pid = regex_rlt.group(2)
                block_thread_list = re.findall(regex_key_watchdog_block_thread, last_watchdog_line)
                if "BinderThreadMonitor" in last_watchdog_line:
                    binder_wait = True
            else:
                TEST_LOGGER.warn("watchdog的行不符合内容需求", tag=tne_dir_name)
                watchdog_error_msg = "watchdog_not_match"
        else:
            TEST_LOGGER.debug("未找到watchdog信息", tag=tne_dir_name)
            watchdog_error_msg = "watchdog_not_found"
        return (found_watchdog, block_pid, block_time, exp_time, block_thread_list, binder_wait, watchdog_error_msg)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\android_events_log.pyc
