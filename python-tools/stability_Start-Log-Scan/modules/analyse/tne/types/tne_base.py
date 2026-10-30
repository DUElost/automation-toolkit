# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne_base.py
import os
import re
from abc import ABC, abstractmethod
from modules.analyse.tne.files.android_crash_log import AndroidCrashLog
from modules.analyse.tne.files.android_main_log import AndroidMainLog
from modules.analyse.tne.files.anr import Anr
from modules.analyse.tne.files.sys_log_dur_lkdump import SysLogDurLkdump
from modules.analyse.tne.files.sys_version_br import SysVersionBr
from modules.common.Logger import TEST_LOGGER
from modules.analyse.tne.files.sys_prop import SysProp
from modules.analyse.tne.files.tombstone import Tombstone
from modules.common.Utils import random_str

class TneBase(ABC):

    def __init__(self, tne_path, is_aee=False):
        super(TneBase, self).__init__()
        self._is_aee = is_aee
        self._path = tne_path
        self.tne_dir_name = os.path.basename(self._path)
        self._version = "undefined"
        self._exp_time = "undefined"
        self._exp_class = "undefined"
        self._exp_type = "undefined"
        self._cur_process = "undefined"
        self._package = "undefined"
        self._detail = "undefined"
        self._caused_by = ""
        self._extra_tag = ""
        self._device_id = "undefined"
        self._gms_serial = "undefined"
        self._system_server_start_count = None
        self._count = 1
        self._build_type = None
        self._build_user = None
        self._is_root = False
        self._is_hardware_marked = False
        self._sys_prop_path = None
        self._android_crash_log_path = None
        self._android_events_log_path = None
        self._android_system_log_path = None
        self._android_main_log_path = None
        self._tombstone_path = None
        self._hprof_path = None
        self._binder_state_path = None
        self._pstore_path = None
        self._sys_kernel_log_path = None
        self._sys_hang_detect_raw_path = None
        self._sys_atf_last_path = None
        self._hang_detect_trace_path = None
        self._tfa_debug_buf_path = None
        self._anr_file_list = []
        self._exp_type_set = set()
        self._init()

    def _init(self):
        if not self._is_aee:
            TEST_LOGGER.debug(("获取TNE目录：{}".format(self._path)), tag=(self.tne_dir_name))
            self._sys_prop_path = self._path + os.sep + "sys_prop"
            self._android_crash_log_path = self._path + os.sep + "android_crash_log"
            self._android_events_log_path = self._path + os.sep + "android_events_log"
            self._android_system_log_path = self._path + os.sep + "android_system_log"
            self._android_main_log_path = self._path + os.sep + "android_main_log"
            self._binder_state_path = self._path + os.sep + "binder_state"
            self._sys_kernel_log_path = self._path + os.sep + "sys_kernel_log"
            self._sys_hang_detect_raw_path = self._path + os.sep + "SYS_HANG_DETECT_RAW"
            self._sys_atf_last_path = self._path + os.sep + "SYS_ATF_LAST"
            self._hang_detect_trace_path = self._path + os.sep + "hang_detect_trace"
            self._sys_log_dur_lkdump_path = self._path + os.sep + "SYS_LOG_DUR_LKDUMP"
            self._sys_version_br_path = self._path + os.sep + "SYS_VERSION_BR"
            self._sys_last_cpu_bus_path = self._path + os.sep + "SYS_LAST_CPU_BUS"
            self._tfa_debug_buf_path = self._path + os.sep + "TFA_DEBUG_BUF"
            self._sys_last_kmsg = self._path + os.sep + "SYS_LAST_KMSG"
            self._proc_cur_tsk = self._path + os.sep + "PROC_CUR_TSK"
            self._pstore_path = self._get_pstore()
            for file in os.listdir(self._path):
                if file.startswith("tombstone"):
                    self._tombstone_path = os.path.join(self._path, file)

            self._read_sys_prop()
            self._get_build_version()
        else:
            TEST_LOGGER.debug(("套用TNE流程解析AEE问题：{}，初始化AEE文件路径".format(self._path)), tag=(self.tne_dir_name))
            self._android_events_log_path = self._path + os.sep + "SYS_ANDROID_EVENT_LOG"
            self._android_system_log_path = self._path + os.sep + "SYS_ANDROID_LOG"
            self._binder_state_path = self._path + os.sep + "binder_state"

    def get_tne_attrs(self):
        return [
         self._path, self._version, self._exp_time, self._exp_class, self._exp_type, self._cur_process,
         self._package, self._caused_by, self._detail, self._extra_tag, self._device_id, self._count]

    def set_extra_jira_tag(self, extra_jira_tag):
        if self._extra_tag is None or self._extra_tag == "":
            self._extra_tag = extra_jira_tag
        else:
            self._extra_tag = f"{self._extra_tag}|{extra_jira_tag}"

    @property
    def exp_class(self):
        return self._exp_class

    @property
    def gms_serial(self):
        return self._gms_serial

    @property
    def version(self):
        return self._version

    @property
    def build_type(self):
        return self._build_type

    @property
    def build_user(self):
        return self._build_user

    @property
    def is_root(self):
        return self._is_root

    @property
    def is_hardware_marked(self):
        return self._is_hardware_marked

    @abstractmethod
    def analyse(self):
        return

    def _read_sys_prop(self):
        """
        读取 sys_prop 文件内容
        :return:
        """
        if not os.path.isfile(self._sys_prop_path):
            TEST_LOGGER.debug(("sys_prop 文件不存在：{}".format(self._sys_prop_path)), tag=(self.tne_dir_name))
            self._exp_type_set.add("TNE_ERROR_file_missing: sys_prop")
            TEST_LOGGER.debug("缺少sys_prop文件，未能获取版本号", tag=(self.tne_dir_name))
        else:
            sys_prop = SysProp(self._sys_prop_path)
            self._version = sys_prop.build_version
            TEST_LOGGER.debug(("获取版本号：{}".format(self._version)), tag=(self.tne_dir_name))
            self._device_id = sys_prop.device_id
            TEST_LOGGER.debug(("获取设备号：{}".format(self._device_id)), tag=(self.tne_dir_name))
            self._build_type = sys_prop.build_type
            TEST_LOGGER.debug(("获取版本类型：{}".format(self._build_type)), tag=(self.tne_dir_name))
            self._build_user = sys_prop.build_user
            TEST_LOGGER.debug(("获取版本用户：{}".format(self._build_user)), tag=(self.tne_dir_name))
            self._is_root = sys_prop.is_root
            TEST_LOGGER.debug(("获取是否root版本：{}".format(self._is_root)), tag=(self.tne_dir_name))
            self._is_hardware_marked = sys_prop.is_hardware_marked
            TEST_LOGGER.debug(("获取是否硬件标记版本：{}".format(self._is_hardware_marked)), tag=(self.tne_dir_name))
            self._gms_serial = sys_prop.gms_serial
            TEST_LOGGER.debug(("获取GMS Serial：{}".format(self._gms_serial)), tag=(self.tne_dir_name))
            self._system_server_start_count = sys_prop.system_server_start_count
            TEST_LOGGER.debug(("获取System Start Count：{}".format(self._system_server_start_count)), tag=(self.tne_dir_name))

    def _get_build_version(self):
        """
        获取问题版本
        :return:
        """
        if not self._version or self._version == "undefined":
            regex_version = re.compile("([a-zA-Z0-9]+-)+\\d{6}V\\d+[a-zA-Z]*")
            regex_version_tag = re.compile("\\d{6}V\\d+")
            regex_rlt = re.search(regex_version, self._path)
            if regex_rlt:
                self._version = regex_rlt.group()
                if self._tombstone_path:
                    if os.path.isfile(self._tombstone_path):
                        tombstone = Tombstone(self._tombstone_path)
                        version_tag = tombstone.version_tag
                        if version_tag:
                            if version_tag not in self._version:
                                self._version = re.sub(regex_version_tag, version_tag, self._version)
            elif "TneStuckLogoExpdb" == self.__class__.__name__:
                TEST_LOGGER.debug("expdb_stucklogo 类型，解析SYS_LOG_DUR_LKDUMP文件")
                if os.path.isfile(self._sys_log_dur_lkdump_path):
                    sys_log_dur_lkdump = SysLogDurLkdump(self._sys_log_dur_lkdump_path)
                    self._version = sys_log_dur_lkdump.analyse()
                    self._version = "undefined" if self._version is None else self._version
        else:
            TEST_LOGGER.debug(f"SYS_LOG_DUR_LKDUMP 文件不存在：{self._sys_log_dur_lkdump_path}")
        if not self._version or self._version == "undefined":
            if os.path.isfile(self._sys_version_br_path):
                sys_version_br = SysVersionBr(self._sys_version_br_path)
                self._version = sys_version_br.analyse()
                self._version = "undefined" if self._version is None else self._version
            else:
                TEST_LOGGER.debug(f"SYS_VERSION_BR 文件不存在：{self._sys_version_br_path}")

    def _detail_to_random(self, must_add_random=False):
        if not self._detail or self._detail == "undefined":
            self._detail = "解析结果，详细内容为空，请自己查看日志文件，本内容只为了Jira不能去重：\n" + random_str(slen=200)
        else:
            if must_add_random:
                self._detail += "\n该问题不进行去重，增加随机字符保证Jira不能去重：\n" + random_str(slen=200)

    def _get_pstore(self):
        pstore_size, pstore0_size, sys_pstore_raw_size = (0, 0, 0)
        pstore_path = self._path + os.sep + "pstore"
        pstore0_path = self._path + os.sep + "pstore0"
        sys_pstore_raw_path = self._path + os.sep + "SYS_PSTORE_RAW"
        if os.path.isfile(pstore_path):
            pstore_size = os.path.getsize(pstore_path)
        if os.path.isfile(pstore0_path):
            pstore0_size = os.path.getsize(pstore0_path)
        if os.path.isfile(sys_pstore_raw_path):
            sys_pstore_raw_size = os.path.getsize(sys_pstore_raw_path)
        if pstore_size == 0:
            if pstore0_size == 0:
                if sys_pstore_raw_size == 0:
                    return
        if pstore_size == 0:
            if pstore0_size == 0:
                return sys_pstore_raw_path
        if pstore_size > pstore0_size:
            return pstore_path
        return pstore0_path

    def _get_anr_file_list(self):
        TEST_LOGGER.debug(f"在目录：{self._path} 下获取anr文件列表", tag=(self.tne_dir_name))
        for file in os.listdir(self._path):
            if file.startswith("anr_"):
                self._anr_file_list.append(file)

        if self._anr_file_list:
            self._anr_file_list.sort()

    def _apply_transucc_if_possible(self):
        if self.try_analyse_transucc_crash():
            if self._exp_type_set:
                self._exp_type = self._exp_type + "\n" + "\n".join(self._exp_type_set)
            self._detail_to_random()
            return True
        return False

    def try_analyse_transucc_crash(self):
        """
        用 TranSucc. 简易堆栈对齐 crash_log/anr 完整段。
        命中后：_detail 写入清洗后的完整堆栈（结果表 CausedBy / 去重键），
        _caused_by 写入 BIHash（结果表 Detail）。对不上则返回 False，调用方走旧解析。
        """
        groups = self._collect_transucc_groups()
        if not groups:
            return False
        chosen = self._pick_transucc_group(groups)
        if not chosen:
            TEST_LOGGER.info("TranSucc. 未找到可对齐的一组，走旧解析", tag=self.tne_dir_name)
            return False
        stack_key = (chosen.get("stack") or "").strip()
        if not stack_key:
            TEST_LOGGER.info("TranSucc. 简易堆栈为空，走旧解析", tag=self.tne_dir_name)
            return False
        mode, match_text = self._transucc_stack_match(stack_key)
        if mode == "empty":
            TEST_LOGGER.info("TranSucc. 简易堆栈为空，走旧解析", tag=self.tne_dir_name)
            return False
        crash_type = (chosen.get("crash_type") or "").strip().lower()
        proc_name = (chosen.get("procName") or "").strip()
        pkg_name = (chosen.get("pkgName") or "").strip()
        process_name = proc_name or pkg_name
        prefer_time = chosen.get("time") or self._prefer_time_from_tne_dir()
        if mode == "truncated":
            TEST_LOGGER.info(
                "TranSucc. 简易堆栈被截断，按异常首行和进程 {} 匹配".format(process_name),
                tag=self.tne_dir_name)
            if not process_name:
                TEST_LOGGER.info("TranSucc. 截断堆栈缺少进程名，走旧解析", tag=self.tne_dir_name)
                return False
        section_time, stack_detail = (None, None)
        if crash_type == "anr":
            section_time, stack_detail = self._detail_from_anr_by_stack(
                match_text, process_name, prefer_time)
        else:
            section_time, stack_detail = self._detail_from_crash_by_stack(
                match_text, process_name, prefer_time)
        if not stack_detail:
            TEST_LOGGER.info(
                "TranSucc. crash_type={} 未匹配到 detail，走旧解析".format(crash_type),
                tag=self.tne_dir_name)
            return False
        bi_hash = (chosen.get("BIHash") or "").strip()
        if process_name:
            self._cur_process = process_name
        if pkg_name:
            self._package = pkg_name
        self._detail = stack_detail
        if section_time:
            self._exp_time = section_time
        elif prefer_time:
            self._exp_time = prefer_time
        if bi_hash:
            self._caused_by = bi_hash
            TEST_LOGGER.info("TranSucc. BIHash 写入 _caused_by(结果表Detail)：{}".format(bi_hash), tag=self.tne_dir_name)
        TEST_LOGGER.info(
            "TranSucc. 命中 crash_type={} proc={} pkg={} time={}".format(
                crash_type, proc_name, pkg_name, self._exp_time),
            tag=self.tne_dir_name)
        return True

    def _list_files_with_prefix(self, prefix):
        """目录下指定前缀的日志文件。轮转文件无后缀的在前，随后按 .N 从小到大。"""
        names = []
        if not os.path.isdir(self._path):
            return names
        for name in os.listdir(self._path):
            if name.endswith(".zs"):
                continue
            if not name.startswith(prefix):
                continue
            path = os.path.join(self._path, name)
            if os.path.isfile(path):
                names.append(name)

        def _sort_key(name):
            rest = name[len(prefix):]
            rotated = re.match(r"\.(\d+)$", rest)
            return (1, int(rotated.group(1))) if rotated else (0, 0)

        names.sort(key=_sort_key)
        return [os.path.join(self._path, name) for name in names]

    def _collect_transucc_groups(self):
        groups = []
        for path in self._list_files_with_prefix("android_main_log"):
            groups.extend(AndroidMainLog(path).analyse_transucc())
        return groups

    def _hash_from_tne_name(self):
        hash_re = re.compile(r"(?<![0-9a-fA-F])([0-9a-fA-F]{32})(?![0-9a-fA-F])")
        match = hash_re.search(self.tne_dir_name or "")
        if match:
            return match.group(1).lower()
        parent = os.path.dirname(self._path)
        if not os.path.isdir(parent):
            return None
        for name in os.listdir(parent):
            if not name.lower().endswith(".tne"):
                continue
            match = hash_re.search(name)
            if match:
                return match.group(1).lower()
        return None

    def _prefer_time_from_tne_dir(self):
        name = self.tne_dir_name or ""
        match = re.search(
            r"(\d{4})_(\d{1,2})_(\d{1,2})_(\d{1,2})_(\d{1,2})_(\d{1,2})_(\d+)", name)
        if match:
            frac = match.group(7).ljust(3, "0")[:6]
            return "{:02d}-{:02d} {:02d}:{:02d}:{:02d}.{}".format(
                int(match.group(2)), int(match.group(3)), int(match.group(4)),
                int(match.group(5)), int(match.group(6)), frac)
        match = re.search(r"_(\d{8})(\d{6})(\d{2,})$", name)
        if match:
            day, clock, frac = match.group(1), match.group(2), match.group(3)
            return "{}-{} {}:{}:{}.{}".format(
                day[4:6], day[6:8], clock[0:2], clock[2:4], clock[4:6],
                frac.ljust(3, "0")[:6])
        return None

    def _pick_transucc_group(self, groups):
        file_hash = self._hash_from_tne_name()
        if file_hash:
            for group in groups:
                bi_hash = str(group.get("BIHash") or "").strip().lower()
                if bi_hash == file_hash:
                    TEST_LOGGER.info(
                        "文件名 hash 命中 TranSucc.：hash={} time={} crash_type={}".format(
                            file_hash, group.get("time"), group.get("crash_type")),
                        tag=self.tne_dir_name)
                    return group
        prefer_time = self._prefer_time_from_tne_dir()
        if prefer_time:
            parsed = []
            for group in groups:
                delta = AndroidCrashLog.log_clock_delta(group.get("time"), prefer_time)
                parsed.append((delta, group))
            timed = [item for item in parsed if item[0] is not None]
            if timed:
                timed.sort(key=lambda item: item[0])
                return timed[0][1]
        return groups[-1] if groups else None

    def _anr_files_newest_first(self):
        anr_name_re = re.compile(
            r"^anr_(\d{4})-(\d{2})-(\d{2})-(\d{2})-(\d{2})-(\d{2})-(\d{3})(?:[._].*)?$")
        dated = []
        undated = []
        if not os.path.isdir(self._path):
            return []
        for name in os.listdir(self._path):
            if not name.startswith("anr_") or name.startswith("anr_bn"):
                continue
            path = os.path.join(self._path, name)
            if not os.path.isfile(path):
                continue
            match = anr_name_re.match(name)
            if not match:
                undated.append(path)
                continue
            try:
                anr_dt = (
                    int(match.group(1)), int(match.group(2)), int(match.group(3)),
                    int(match.group(4)), int(match.group(5)), int(match.group(6)),
                    int(match.group(7)))
            except ValueError:
                undated.append(path)
                continue
            dated.append((anr_dt, path))
        dated.sort(reverse=True)
        return [item[1] for item in dated] + undated

    @staticmethod
    def _anr_subject_line(anr_path):
        try:
            with open(anr_path, "r", encoding="utf-8", errors="ignore") as f:
                for line in f:
                    if line.strip().startswith("Subject:"):
                        return line.strip()
        except Exception:
            return None
        return None

    @staticmethod
    def _transucc_stack_match(stack):
        """
        单行或后续帧完整时，用整段简易堆栈做包含匹配。
        后续帧被截断（如 at andro）时，只用异常首行，并交给调用方加上进程名。
        return: (mode, match_text)，mode 为 full / truncated / empty
        """
        text = (stack or "").strip()
        lines = [line.strip() for line in text.splitlines() if line.strip()]
        if not lines:
            return ("empty", "")
        if len(lines) == 1:
            return ("full", text)
        for frame in lines[1:]:
            lowered = frame.lower()
            body = frame[3:].strip() if lowered.startswith("at ") else frame
            incomplete_at = lowered.startswith("at ") and "(" not in frame
            if "." not in body or incomplete_at or frame.endswith("..."):
                return ("truncated", lines[0])
        return ("full", text)

    @staticmethod
    def transucc_stacks_equivalent(stack_a, stack_b):
        """截断堆栈与完整堆栈：核验异常首行后视为同一问题。"""
        mode_a, key_a = TneBase._transucc_stack_match(stack_a)
        mode_b, key_b = TneBase._transucc_stack_match(stack_b)
        if mode_a == "empty" or mode_b == "empty":
            return False
        if mode_a != "truncated" and mode_b != "truncated":
            return False
        first_a = key_a if mode_a == "truncated" else (stack_a or "").strip().splitlines()[0].strip()
        first_b = key_b if mode_b == "truncated" else (stack_b or "").strip().splitlines()[0].strip()
        if not first_a or not first_b:
            return False
        if first_a == first_b:
            return True
        if first_a in (stack_b or "") or first_b in (stack_a or ""):
            return True
        return False

    def _detail_from_anr_by_stack(self, stack_key, process_name, prefer_time):
        best_detail = None
        best_delta = None
        for anr_path in self._anr_files_newest_first():
            subject = self._anr_subject_line(anr_path)
            if not subject or stack_key not in subject:
                continue
            if process_name and not AndroidCrashLog.process_name_matched(
                    process_name, [subject, os.path.basename(anr_path)]):
                if process_name not in subject:
                    continue
            detail_msg = Anr(anr_path).analyse_tne13()
            if not detail_msg:
                continue
            delta = AndroidCrashLog.log_clock_delta(self._anr_clock_text(anr_path), prefer_time)
            if best_detail is None or (delta is not None and (best_delta is None or delta < best_delta)):
                best_detail = detail_msg
                best_delta = delta
                TEST_LOGGER.info("anr Subject 命中简易堆栈：{}".format(os.path.basename(anr_path)), tag=self.tne_dir_name)
                if delta is None:
                    break
        return (None, best_detail)

    @staticmethod
    def _anr_clock_text(anr_path):
        match = re.match(
            r"^anr_(\d{4})-(\d{2})-(\d{2})-(\d{2})-(\d{2})-(\d{2})-(\d{3})",
            os.path.basename(anr_path))
        if not match:
            return None
        return "{}-{} {}:{}:{}.{}".format(
            match.group(2), match.group(3), match.group(4),
            match.group(5), match.group(6), match.group(7))

    def _detail_from_crash_by_stack(self, stack_key, process_name, prefer_time):
        best_time = None
        best_detail = None
        best_delta = None
        for crash_path in self._list_files_with_prefix("android_crash_log"):
            exp_time, detail = AndroidCrashLog(crash_path).analyse_fatal_by_stack(
                stack_key, process_name, prefer_time)
            if not detail:
                continue
            delta = AndroidCrashLog.log_clock_delta(exp_time, prefer_time)
            if best_detail is None or (delta is not None and (best_delta is None or delta < best_delta)):
                best_time, best_detail, best_delta = exp_time, detail, delta
                TEST_LOGGER.info("crash_log 命中简易堆栈：{}".format(os.path.basename(crash_path)), tag=self.tne_dir_name)
        return (best_time, best_detail)
