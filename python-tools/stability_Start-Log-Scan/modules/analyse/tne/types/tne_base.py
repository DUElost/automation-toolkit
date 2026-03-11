# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\tne_base.py
import os, re
from abc import ABC, abstractmethod
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

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\tne_base.pyc
