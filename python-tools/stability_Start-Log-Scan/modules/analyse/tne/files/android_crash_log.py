# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\android_crash_log.py
import os, re
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import ignore_num_hex_string

class AndroidCrashLog(object):

    def __init__(self, file_path):
        super(AndroidCrashLog, self).__init__()
        self._AndroidCrashLog__file_path = file_path

    def analyse_tne00(self):
        """
        Fatal JE
        :return:
        """
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug(("开始解析android_crash_log文件：{}".format(self._AndroidCrashLog__file_path)), tag=tne_dir_name)
        last_crash_time, last_crash_detail = (None, None)
        regex_time = re.compile("\\d\\d-\\d\\d\\s+\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d")
        regex_crash_identity = re.compile("\\d+\\s+\\d+\\s+E\\s+AndroidRuntime:")
        crash_identity = None
        end_of_exception = True
        with open((self._AndroidCrashLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if "FATAL EXCEPTION IN SYSTEM PROCESS" in line:
                    end_of_exception = False
                    re_rlt_time = re.match(regex_time, line)
                    re_rlt_identity = re.search(regex_crash_identity, line)
                    if re_rlt_time:
                        if re_rlt_identity:
                            last_crash_time = re_rlt_time.group()
                            crash_identity = re_rlt_identity.group()
                            last_crash_detail = line.split(crash_identity)[1].strip()
                            continue
                        if end_of_exception or crash_identity:
                            if crash_identity in line:
                                last_crash_detail = last_crash_detail + "\n" + line.split(crash_identity)[1].strip()
                        end_of_exception = True
                        crash_identity = None

        return (
         last_crash_time, last_crash_detail)

    def analyse_tne06(self):
        return self.analyse_tne00()

    def analyse_tne07(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug(("开始解析android_crash_log文件：{}".format(self._AndroidCrashLog__file_path)), tag=tne_dir_name)
        last_crash_time, last_crash_detail, process = (None, None, None)
        regex_time = re.compile("\\d\\d-\\d\\d\\s+\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d")
        regex_crash_identity = re.compile("\\d+\\s+\\d+\\s+E\\s+AndroidRuntime:")
        crash_identity = None
        regex_process = re.compile("Process: (.*), PID: (\\d+)")
        end_of_exception = True
        with open((self._AndroidCrashLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if "FATAL EXCEPTION" in line:
                    end_of_exception = False
                    re_rlt_time = re.match(regex_time, line)
                    re_rlt_identity = re.search(regex_crash_identity, line)
                    if re_rlt_time:
                        if re_rlt_identity:
                            last_crash_time = re_rlt_time.group()
                            crash_identity = re_rlt_identity.group()
                            last_crash_detail = ignore_num_hex_string(line.split(crash_identity)[1].strip())
                            continue
                        process_regex_rlt = end_of_exception or re.search(regex_process, line)
                        if process_regex_rlt:
                            process = process_regex_rlt.group(1)
                        if crash_identity:
                            if crash_identity in line:
                                last_crash_detail = last_crash_detail + "\n" + ignore_num_hex_string(line.split(crash_identity)[1].strip())
                        end_of_exception = True
                        crash_identity = None

        return (
         last_crash_time, last_crash_detail, process)

    def analyse_tne08(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug(("开始解析android_crash_log文件：{}".format(self._AndroidCrashLog__file_path)), tag=tne_dir_name)
        last_crash_time, last_crash_detail, process = (None, None, None)
        debug_identity = "DEBUG   :"
        regex_timestamp = re.compile("Timestamp:\\s+(\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2})")
        regex_process_start = re.compile("DEBUG\\s+: pid:\\s+(\\d+), tid:\\s+(\\d+), name:\\s+(\\S+).*>>>\\s+(\\S+)\\s+<<<")
        exception_start = False
        with open((self._AndroidCrashLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if debug_identity in line and not exception_start:
                    rlt_regex_timestamp = re.search(regex_timestamp, line)
                    if rlt_regex_timestamp:
                        last_crash_time = rlt_regex_timestamp.group(1)
                    else:
                        rlt_regex_process_start = re.search(regex_process_start, line)
                        if rlt_regex_process_start:
                            process = rlt_regex_process_start.group(4)
                            last_crash_detail = ignore_num_hex_string(line.split(debug_identity)[1].strip())
                            exception_start = True
                        else:
                            last_crash_detail = last_crash_detail + "\n" + ignore_num_hex_string(line.split(debug_identity)[1].strip())
                else:
                    exception_start = False

        return (
         last_crash_time, last_crash_detail, process)

    def analyse_je_or_ne(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug(("开始解析判断android_crash_log文件：{} 是JE还是NE".format(self._AndroidCrashLog__file_path)), tag=tne_dir_name)
        crash_type = None
        with open((self._AndroidCrashLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if "FATAL EXCEPTION" in line:
                    crash_type = "je"
                    break
                if "DEBUG   :" in line:
                    crash_type = "ne"
                    break

        return crash_type

    def analyse_tne12(self):
        """
        OOM
        :return:
        """
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug(("开始解析android_crash_log文件：{}".format(self._AndroidCrashLog__file_path)), tag=tne_dir_name)
        last_crash_time, last_crash_detail, last_process = (None, None, None)
        regex_time = re.compile("\\d\\d-\\d\\d\\s+\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d")
        regex_crash_identity = re.compile("\\d+\\s+\\d+\\s+E\\s+AndroidRuntime:")
        crash_identity = None
        end_of_exception = True
        crash_time, crash_detail = (None, None)
        with open((self._AndroidCrashLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if "FATAL EXCEPTION" in line:
                    end_of_exception = False
                    re_rlt_time = re.match(regex_time, line)
                    re_rlt_identity = re.search(regex_crash_identity, line)
                    if re_rlt_time:
                        if re_rlt_identity:
                            crash_time = re_rlt_time.group()
                            crash_identity = re_rlt_identity.group()
                            crash_detail = line.split(crash_identity)[1].strip()
                            continue
                        if end_of_exception or crash_identity:
                            if crash_identity in line:
                                crash_detail = crash_detail + "\n" + line.split(crash_identity)[1].strip()
                        if crash_detail:
                            if "OutOfMemoryError" in crash_detail:
                                last_crash_time = crash_time
                                last_crash_detail = crash_detail
                        crash_time, crash_detail = (None, None)
                        end_of_exception = True
                        crash_identity = None

        if crash_detail:
            if "OutOfMemoryError" in crash_detail:
                last_crash_time = crash_time
                last_crash_detail = crash_detail
        if last_crash_detail:
            regex_pattern = re.compile("Process:\\s+(.*),\\s+PID:")
            regex_rlt = re.search(regex_pattern, last_crash_detail)
            if regex_rlt:
                last_process = regex_rlt.group(1)
                TEST_LOGGER.info(f"获取进程名：{last_process}")
        return (
         last_crash_time, last_crash_detail, last_process)

    def analyse_tne14(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug(("开始解析android_crash_log文件：{}".format(self._AndroidCrashLog__file_path)), tag=tne_dir_name)
        last_crash_time, last_crash_detail = (None, None)
        regex_time = re.compile("Timestamp:\\s+(.*)")
        with open((self._AndroidCrashLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in reversed(list(f)):
                if last_crash_detail:
                    regex = re.search(regex_time, line)
                    if regex:
                        last_crash_time = regex.group(1)
                        break
                if "Cmdline:" in line and "zygote" in line:
                    line = line.strip()
                    cmdline_index = line.index("Cmdline:")
                    last_crash_detail = line[cmdline_index[:None]]
                    continue

        return (
         last_crash_time, last_crash_detail)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\android_crash_log.pyc
