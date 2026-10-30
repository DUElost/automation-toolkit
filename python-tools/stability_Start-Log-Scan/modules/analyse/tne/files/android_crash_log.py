# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\android_crash_log.py
import datetime
import os
import re
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

    @staticmethod
    def process_name_matched(target_name, candidates):
        target = (target_name or "").strip()
        if not target:
            return False
        target_base = os.path.basename(target)
        for candidate in candidates:
            if not candidate:
                continue
            name = str(candidate).strip()
            name_base = os.path.basename(name)
            if target == name or target_base == name or target == name_base or target_base == name_base:
                return True
            if target.endswith(name) or name.endswith(target):
                return True
        return False

    @staticmethod
    def log_clock_delta(time_text, prefer_time):
        """比较两段 MM-DD HH:MM:SS.mmm，返回绝对秒数。解析失败返回 None。"""
        fmt = "%m-%d %H:%M:%S.%f"
        try:
            left = datetime.datetime.strptime(AndroidCrashLog._clock_text(time_text), fmt)
            right = datetime.datetime.strptime(AndroidCrashLog._clock_text(prefer_time), fmt)
        except (TypeError, ValueError):
            return None
        return abs((left - right).total_seconds())

    @staticmethod
    def _clock_text(time_text):
        raw = (time_text or "").strip()
        match = re.search(r"(\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2}\.\d{1,6})", raw)
        if match:
            clock = match.group(1)
            if "." in clock:
                head, frac = clock.rsplit(".", 1)
                return "{}.{}".format(head, frac.ljust(3, "0")[:6])
            return clock + ".000"
        match = re.search(r"(\d{4})-(\d{2})-(\d{2})\s+(\d{2}:\d{2}:\d{2})(?:\.(\d+))?", raw)
        if match:
            frac = (match.group(5) or "000").ljust(3, "0")[:6]
            return "{}-{} {}.{}".format(match.group(2), match.group(3), match.group(4), frac)
        return raw

    @staticmethod
    def _pick_stack_candidate(candidates, process_name=None, prefer_time=None):
        if not candidates:
            return (None, None)
        if not process_name and not prefer_time:
            return candidates[-1]
        parsed = []
        for exp_time, detail in candidates:
            delta = AndroidCrashLog.log_clock_delta(exp_time, prefer_time)
            parsed.append((delta, exp_time, detail))
        if all(item[0] is None for item in parsed):
            return candidates[-1]
        parsed.sort(key=lambda item: (item[0] is None, item[0] if item[0] is not None else 0))
        return (parsed[0][1], parsed[0][2])

    def analyse_fatal_by_stack(self, stack_text, process_name=None, prefer_time=None):
        """
        在 crash_log 中定位包含简易堆栈原文的一整段 FATAL/DEBUG。
        未指定进程时，同一文件多段命中取最后一段。
        指定进程时，还要求 Process / Cmdline / >>> path <<< 与进程名一致，多段取离 prefer_time 最近的一段。
        匹配用原文，写入的 detail 仍按现有规则去掉数字和地址。
        return: (exp_time, detail)；匹配不上返回 (None, None)
        """
        stack_text = (stack_text or "").strip()
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidCrashLog__file_path))
        TEST_LOGGER.debug("按简易堆栈匹配 crash 段：{}".format(stack_text), tag=tne_dir_name)
        if not stack_text or not os.path.isfile(self._AndroidCrashLog__file_path):
            return (None, None)

        regex_time = re.compile(r"\d\d-\d\d\s+\d\d:\d\d:\d\d.\d\d\d")
        regex_je_identity = re.compile(r"\d+\s+\d+\s+E\s+AndroidRuntime:")
        regex_je_process = re.compile(r"Process:\s+(.*),\s+PID:\s+(\d+)")
        regex_debug_identity = re.compile(r"\d+\s+\d+\s+F\s+DEBUG\s*:")
        regex_debug_gt = re.compile(r">>>\s+(\S+)\s+<<<")
        regex_debug_cmdline = re.compile(r"Cmdline:\s+(\S+)")
        regex_debug_exec = re.compile(r"Executable:\s+(\S+)")
        regex_timestamp = re.compile(r"Timestamp:\s+(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})")
        candidates = []

        def _stack_in_raw(raw_lines):
            raw = "\n".join(raw_lines)
            if stack_text in raw:
                return True
            stack_lines = [item.strip() for item in stack_text.splitlines() if item.strip()]
            return bool(stack_lines) and all(item in raw for item in stack_lines)

        def _commit(raw_lines, detail, exp_time, proc):
            if not _stack_in_raw(raw_lines):
                return
            if process_name and not AndroidCrashLog.process_name_matched(process_name, [proc]):
                return
            if detail:
                candidates.append((exp_time, detail))

        je_active = False
        je_id = None
        je_time = None
        je_detail = None
        je_proc = None
        je_raw = []
        dbg_active = False
        dbg_id = None
        dbg_time = None
        dbg_detail = None
        dbg_proc = None
        dbg_raw = []

        def _reset_je():
            nonlocal je_active, je_id, je_time, je_detail, je_proc, je_raw
            je_active, je_id, je_time, je_detail, je_proc, je_raw = False, None, None, None, None, []

        def _reset_dbg():
            nonlocal dbg_active, dbg_id, dbg_time, dbg_detail, dbg_proc, dbg_raw
            dbg_active, dbg_id, dbg_time, dbg_detail, dbg_proc, dbg_raw = False, None, None, None, None, []

        def _finish_je():
            if je_active:
                _commit(je_raw, je_detail, je_time, je_proc)
            _reset_je()

        def _finish_dbg():
            if dbg_active:
                _commit(dbg_raw, dbg_detail, dbg_time, dbg_proc)
            _reset_dbg()

        def _debug_piece(line):
            if dbg_id and dbg_id in line:
                return ignore_num_hex_string(line.split(dbg_id, 1)[-1].strip())
            if "DEBUG   :" in line:
                return ignore_num_hex_string(line.split("DEBUG   :", 1)[-1].strip())
            return ignore_num_hex_string(line.strip())

        with open(self._AndroidCrashLog__file_path, errors="ignore", encoding="utf-8") as f:
            for line in f:
                if "FATAL EXCEPTION" in line:
                    _finish_je()
                    _finish_dbg()
                    re_rlt_time = regex_time.match(line)
                    re_rlt_identity = regex_je_identity.search(line)
                    if re_rlt_time and re_rlt_identity:
                        je_active = True
                        je_id = re_rlt_identity.group()
                        je_time = re_rlt_time.group()
                        je_raw = [line.rstrip("\n")]
                        je_detail = ignore_num_hex_string(line.split(je_id, 1)[-1].strip())
                    continue

                dbg_id_m = regex_debug_identity.search(line)
                if not dbg_id_m and "DEBUG   :" in line:
                    dbg_id_m = True
                if dbg_id_m:
                    if not dbg_active:
                        _finish_je()
                        dbg_active = True
                        dbg_id = dbg_id_m.group() if hasattr(dbg_id_m, "group") else "DEBUG   :"
                        dbg_raw = []
                        dbg_detail = None
                    dbg_raw.append(line.rstrip("\n"))
                    time_m = regex_time.match(line)
                    if time_m:
                        dbg_time = time_m.group()
                    ts_m = regex_timestamp.search(line)
                    if ts_m:
                        dbg_time = ts_m.group(1)
                    gt_m = regex_debug_gt.search(line)
                    if gt_m:
                        dbg_proc = gt_m.group(1)
                    else:
                        cmd_m = regex_debug_cmdline.search(line)
                        if cmd_m:
                            dbg_proc = cmd_m.group(1)
                        else:
                            exec_m = regex_debug_exec.search(line)
                            if exec_m:
                                dbg_proc = exec_m.group(1)
                    piece = _debug_piece(line)
                    dbg_detail = piece if not dbg_detail else dbg_detail + "\n" + piece
                    continue

                if je_active and je_id and je_id in line:
                    je_raw.append(line.rstrip("\n"))
                    process_regex_rlt = regex_je_process.search(line)
                    if process_regex_rlt:
                        je_proc = process_regex_rlt.group(1)
                    je_detail = (je_detail or "") + "\n" + ignore_num_hex_string(
                        line.split(je_id, 1)[-1].strip())
                    continue

                if je_active:
                    _finish_je()
                if dbg_active:
                    _finish_dbg()

        _finish_je()
        _finish_dbg()
        matched_time, matched_detail = self._pick_stack_candidate(candidates, process_name, prefer_time)
        if matched_detail:
            TEST_LOGGER.info("crash_log 已按简易堆栈匹配到 FATAL/DEBUG 段，time={}".format(matched_time), tag=tne_dir_name)
        return (matched_time, matched_detail)
