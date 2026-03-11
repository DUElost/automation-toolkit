# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\android_system_log.py
import os, re, datetime
from modules.common.Logger import TEST_LOGGER

class AndroidSystemLog(object):

    def __init__(self, file_path):
        super(AndroidSystemLog, self).__init__()
        self._AndroidSystemLog__file_path = file_path

    def found_last_watchdog(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidSystemLog__file_path))
        TEST_LOGGER.debug(("开始从android_system_log文件解析 Watchdog：{}".format(self._AndroidSystemLog__file_path)), tag=tne_dir_name)
        regex_key_watchdog_time = re.compile("(\\d+-\\d+\\s+\\d\\d:\\d\\d:\\d\\d)\\.\\d+\\s+(\\d+)")
        last_watchdog_line = None
        last_watchdog_time = None
        with open((self._AndroidSystemLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "E Watchdog: **SWT happen" in line:
                    last_watchdog_line = line.strip()
                    regex_rlt = re.match(regex_key_watchdog_time, last_watchdog_line)
                    if regex_rlt:
                        last_watchdog_time = regex_rlt.group(1)
                    TEST_LOGGER.debug(("watchdog:{}".format(last_watchdog_line)), tag=tne_dir_name)

        return (
         last_watchdog_line, last_watchdog_time)

    def found_watchdog(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidSystemLog__file_path))
        TEST_LOGGER.debug(("开始从android_system_log文件解析 Watchdog：{}".format(self._AndroidSystemLog__file_path)), tag=tne_dir_name)
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
        with open((self._AndroidSystemLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                if "E Watchdog: **SWT happen" in line:
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
                TEST_LOGGER.debug("watchdog的行不符合内容需求", tag=tne_dir_name)
                watchdog_error_msg = "watchdog_not_match"
        else:
            TEST_LOGGER.debug("未找到watchdog信息", tag=tne_dir_name)
            watchdog_error_msg = "watchdog_not_found"
        return (found_watchdog, block_pid, block_time, exp_time, block_thread_list, binder_wait, watchdog_error_msg)

    def found_watchdog_stack_info(self, block_pid):
        """
        在 android_system_log 中尝试获取watchdog的堆栈信息
        :param block_pid:
        :return:
        """
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidSystemLog__file_path))
        TEST_LOGGER.debug(("开始从android_system_log文件解析 Watchdog 堆栈内容".format(self._AndroidSystemLog__file_path)), tag=tne_dir_name)
        regex_key = re.compile(str(block_pid) + "\\s+\\d+ W Watchdog: (.+)")
        regex_key_start = re.compile(str(block_pid) + "\\s+\\d+ W Watchdog: \\*\\*\\* WATCHDOG")
        block_detail = []
        stack_detail_start = False
        with open((self._AndroidSystemLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if stack_detail_start:
                    if "W Watchdog: *** GOODBYE" in line:
                        stack_detail_start = False
                        continue
                    regex_rlt = re.search(regex_key, line)
                    if regex_rlt:
                        block_detail.append(regex_rlt.group(1))
                    else:
                        regex_rlt_start = re.search(regex_key_start, line)
                        if regex_rlt_start:
                            stack_detail_start = True
                            block_detail.clear()

        return block_detail

    def found_waited_half(self, block_pid, watchdog_time):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidSystemLog__file_path))
        TEST_LOGGER.debug(("开始从android_system_log文件解析 watchdog_time：{} 对应的 WAITED_HALF".format(watchdog_time)), tag=tne_dir_name)
        regex_key = re.compile("(\\d+-\\d+\\s+\\d\\d:\\d\\d:\\d\\d)\\.\\d+\\s+(\\d+).*WAITED_HALF")
        perfect_half_time = watchdog_time - datetime.timedelta(seconds=60)
        bad_half_time = watchdog_time + datetime.timedelta(seconds=60)
        found_waited_half = False
        found_waited_half_perfect = False
        block_time = None
        watchdog_error_msg = None
        with open((self._AndroidSystemLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "WAITED_HALF" in line:
                    if block_pid in line:
                        TEST_LOGGER.debug(("找到含有 WAITED_HALF 的行:{}".format(line)), tag=tne_dir_name)
                        regex_rlt = re.search(regex_key, line)
                        if regex_rlt:
                            waited_half_time_str = regex_rlt.group(1)
                            try:
                                waited_half_time = datetime.datetime.strptime(waited_half_time_str, "%m-%d %H:%M:%S")
                            except:
                                waited_half_time = datetime.datetime.strptime(str(datetime.datetime.now().year) + "-" + waited_half_time_str, "%Y-%m-%d %H:%M:%S")

                            if watchdog_time >= waited_half_time >= perfect_half_time:
                                found_waited_half = True
                                found_waited_half_perfect = True
                                block_time = waited_half_time
                                TEST_LOGGER.debug(("android_system_log文件 获取最佳 WAITED_HALF block_time:{}".format(block_time)), tag=tne_dir_name)
                                break
                    if bad_half_time >= waited_half_time > watchdog_time:
                        found_waited_half = True
                        found_waited_half_perfect = False
                        block_time = waited_half_time
                        TEST_LOGGER.debug(("android_system_log文件 获取次等 WAITED_HALF block_time:{}".format(block_time)), tag=tne_dir_name)
                        break

        if not found_waited_half:
            TEST_LOGGER.debug(("android_system_log 文件中未找到对应pid：{} 的 WAITED_HALF 信息".format(block_pid)), tag=tne_dir_name)
            watchdog_error_msg = "waited_half_not_found"
        return (found_waited_half, found_waited_half_perfect, block_time, watchdog_error_msg)

    def found_stucklogo_ne(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidSystemLog__file_path))
        TEST_LOGGER.debug(("开始从android_system_log文件解析 F libc Fatal Cmdline：{}".format(self._AndroidSystemLog__file_path)), tag=tne_dir_name)
        regex_libc = re.compile("(\\d+-\\d+\\s+\\d\\d:\\d\\d:\\d\\d)\\.\\d+\\s+(\\d+).*F libc\\s+:Fatal")
        f_libc_info_list = []
        last_f_libc_time = None
        with open((self._AndroidSystemLog__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "F libc" in line:
                    last_watchdog_line = line.strip()
                    regex_rlt = re.match(regex_libc, last_watchdog_line)
                    if regex_rlt:
                        f_libc_info_list.clear()
                        f_libc_info_list.append(line)
                        last_f_libc_time = regex_rlt.group(1)
                    elif "Cmdline: system_server" in line and f_libc_info_list:
                        f_libc_info_list.append(line)
                    if ">>> system_server <<<" in line and f_libc_info_list:
                        f_libc_info_list.append(line)

        return (
         last_f_libc_time, f_libc_info_list)


if __name__ == "__main__":
    androidSystemLog = AndroidSystemLog("d:\\\\android_system_log.txt")
    stack_detail = androidSystemLog.found_watchdog_stack_info(1173)
    print(stack_detail)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\android_system_log.pyc
