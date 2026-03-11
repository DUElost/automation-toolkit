# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\AnalyseAee.py
import os, re, traceback
from recognize_except import recognizeexception
from modules.analyse.aee.files.dumpsys_display import DumpsysDisplay
from modules.analyse.aee.files.dumpsys_surfaceflinger import DumpsysSurfaceFlinger
from modules.analyse.aee.files.exp_main import ExpMain
from modules.analyse.aee.files.swt_jbt_traces import SwtJbtTraces
from modules.analyse.aee.files.sys_android_event_log import SysAndroidEventLog
from modules.analyse.aee.files.sys_android_log import SysAndroidLog
from modules.analyse.aee.files.sys_memory_info import SysMemoryInfo
from modules.analyse.aee.files.sys_processes_and_threads import SysProcessesAndThreads
from modules.analyse.aee.files.sys_kernel_log import SysKernelLog
from modules.analyse.aee.files.sys_properties import SysProperties
from modules.analyse.aee.recognize_exception import recognize_except
from modules.analyse.tne.files.pstore import Pstore
from modules.analyse.tne.files.sys_last_cpu_bus import SysLastCpuBus
from modules.analyse.tne.types.tne01 import Tne01
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import random_str

def analyse_aee(exp_main_file, to_recognize_except=True, extra_jira_tag=None):
    TEST_LOGGER.debug("开始解析Aee文件：{}".format(exp_main_file))
    aee = Aee(exp_main_file, to_recognize_except, extra_jira_tag)
    try:
        aee.analyse()
    except:
        TEST_LOGGER.error("解析Aee文件：{} 时发生异常：\n{}".format(exp_main_file, traceback.format_exc()))
        return (False, exp_main_file, None, "Exception", traceback.format_exc())
    return (True, exp_main_file, aee, None, None)


class Aee(object):

    def __init__(self, exp_main_path, to_recognize_except=True, extra_jira_tag=None):
        self._Aee__exp_main_path = exp_main_path
        self._Aee__exp_main_build_version = None
        self._Aee__recognize_except = to_recognize_except
        if extra_jira_tag:
            self._Aee__extra_tag = extra_jira_tag
        else:
            self._Aee__extra_tag = ""
        self._Aee__version = None
        self._Aee__exp_time = None
        self._Aee__exp_class = None
        self._Aee__exp_type = None
        self._Aee__cur_process = None
        self._Aee__package = None
        self._Aee__activity = None
        self._Aee__subject = None
        self._Aee__detail = None
        self._Aee__caused_by = None
        self._Aee__device_id = None
        self._Aee__ne_system_issue = False
        self._Aee__ignore_ke_ne_hwasan = False
        self._Aee__count = 1
        self._Aee__fans_version = False
        self._Aee__foreground_no = False
        self._Aee__pid = None
        self._Aee__tid = None
        self._Aee__aee_dir = os.path.dirname(self._Aee__exp_main_path)
        self._Aee__aee_dir_name = os.path.basename(self._Aee__aee_dir)
        self._Aee__recognize_exception_rlt = True
        self._Aee__handle_recognize_rlt = True
        self._Aee__init()

    def __init(self):
        TEST_LOGGER.debug(("获取Aee目录：{}".format(self._Aee__aee_dir)), tag=(self._Aee__aee_dir_name))
        self._Aee__sys_properties_path = self._Aee__aee_dir + os.sep + "SYS_PROPERTIES"
        self._Aee__sys_memory_info_path = self._Aee__aee_dir + os.sep + "SYS_MEMORY_INFO"
        self._Aee__sys_android_event_log_path = self._Aee__aee_dir + os.sep + "SYS_ANDROID_EVENT_LOG"
        self._Aee__sys_android_log_path = self._Aee__aee_dir + os.sep + "SYS_ANDROID_LOG"
        self._Aee__swt_jbt_traces_path = self._Aee__aee_dir + os.sep + "SWT_JBT_TRACES"
        self._Aee__dumpsys_display_path = self._Aee__aee_dir + os.sep + "DUMPSYS_DISPLAY"
        self._Aee__dumpsys_surface_flinger_path = self._Aee__aee_dir + os.sep + "DUMPSYS_SURFACEFLINGER"
        self._Aee__sys_processes_and_threads_path = self._Aee__aee_dir + os.sep + "SYS_PROCESSES_AND_THREADS"
        self._Aee__sys_kernel_log_path = self._Aee__aee_dir + os.sep + "SYS_KERNEL_LOG"
        self._Aee__sys_last_cpu_bus_path = self._Aee__aee_dir + os.sep + "SYS_LAST_CPU_BUS"
        self._Aee__sys_pstore_raw_path = self._Aee__aee_dir + os.sep + "SYS_PSTORE_RAW"
        self._Aee__exp_detail_path = self._Aee__aee_dir + os.sep + "_exp_detail.txt"
        if not os.path.isfile(self._Aee__exp_detail_path):
            if self._Aee__aee_dir_name.startswith("CURRENT."):
                parent_dir = os.path.dirname(self._Aee__aee_dir)
                self._Aee__exp_detail_path = parent_dir + os.sep + "_exp_detail.txt"

    def analyse(self):
        """
        解析aee
        :return:
        """
        self._Aee__read_sys_properties()
        exp_main = ExpMain(self._Aee__exp_main_path, self._Aee__exp_detail_path)
        rlt = exp_main.analyse()
        if rlt:
            self._Aee__exp_time, self._Aee__exp_class, self._Aee__exp_type, self._Aee__cur_process, self._Aee__package, self._Aee__activity, self._Aee__subject, self._Aee__detail, self._Aee__pid, self._Aee__tid, self._Aee__foreground_no, self._Aee__exp_main_build_version, self._Aee__ne_system_issue, self._Aee__ignore_ke_ne_hwasan = exp_main.get_analyse_rlt()
        else:
            TEST_LOGGER.debug("解析 exp_main 文件异常", tag=(self._Aee__aee_dir_name))
            return
        
        self._Aee__get_build_version()
        TEST_LOGGER.debug(("获取问题版本：{}".format(self._Aee__version)), tag=(self._Aee__aee_dir_name))
        
        # 处理 Hardware Reboot
        if self._Aee__exp_type == "Hardware Reboot":
            sys_last_cpu_bus = SysLastCpuBus(self._Aee__sys_last_cpu_bus_path)
            lastpc_info_list = sys_last_cpu_bus.analyse()
            if lastpc_info_list:
                self._Aee__detail = "\n".join(lastpc_info_list)
        
        # 处理 ANR
        if self._Aee__exp_class == "ANR":
            try:
                optimize_rlt, optimize_detail = self._Aee__anr_optimize()
                if optimize_rlt:
                    self._Aee__detail = f"{self._Aee__detail}\n{optimize_detail}"
            except:
                TEST_LOGGER.warn(f"解析 ANR 详情异常:\n{traceback.format_exc()}", tag=(self._Aee__aee_dir_name))
        
        # 处理 SWT - 注释掉，让 SWT 使用默认的随机字符串格式
        # if self._Aee__exp_class == "SWT":
        #     self._Aee__swt_optimize()
        if self._Aee__exp_class == "Kernel (KE)" and os.path.isfile(self._Aee__sys_pstore_raw_path):
            pstore = Pstore(self._Aee__sys_pstore_raw_path)
            exp_time, package, detail = pstore.analyse_tne04()
            if self._Aee__exp_time is None:
                self._Aee__exp_time = exp_time
                self._Aee__exp_time = "undefined" if self._Aee__exp_time is None else self._Aee__exp_time
            if detail:
                if "tsbat_sysrst_set_cur_state" in detail:
                    self._Aee__package = "Thermal"
                    self._Aee__cur_process = "Thermal"
                else:
                    self._Aee__package = "Kernel (KE)"
                    self._Aee__cur_process = "Kernel (KE)"
                self._Aee__detail = detail if detail else self._Aee__detail
        
        # 处理 combo 问题
        if self._Aee__exp_type and "comb" in self._Aee__exp_type and os.path.isfile(self._Aee__sys_kernel_log_path):
            sys_kernel_log = SysKernelLog(self._Aee__sys_kernel_log_path)
            if sys_kernel_log.is_invalid_issue():
                TEST_LOGGER.warn(("解析文件：{}，该combo属于无效问题".format(self._Aee__sys_kernel_log_path)), tag=(self._Aee__aee_dir_name))
                self._Aee__detail = "invalid_combo_wifi"
                return
        
        # 处理 nfc 问题
        if self._Aee__cur_process and "nfc" in self._Aee__cur_process:
            sys_android_log = SysAndroidLog(self._Aee__sys_android_log_path)
            if sys_android_log.is_nfc_too_close():
                TEST_LOGGER.warn(("解析文件：{}，nfc距离太近问题".format(self._Aee__sys_android_log_path)), tag=(self._Aee__aee_dir_name))
                self._Aee__detail = "nfc_too_close"
                return
        
        # 处理 unknownexp
        if self._Aee__cur_process == "unknownexp" or self._Aee__cur_process == "unknown":
            if self._Aee__exp_type == "unknown_app_crash":
                self._Aee__detail = "unknown_app_crash"
            elif self._Aee__pid:
                if os.path.isfile(self._Aee__sys_android_log_path):
                    TEST_LOGGER.debug("Process: unknownexp, 尝试在SYS_ANDROID_LOG中获取process", tag=(self._Aee__aee_dir_name))
                    sys_android_log = SysAndroidLog(self._Aee__sys_android_log_path)
                    cur_process = sys_android_log.get_cur_process(self._Aee__pid, self._Aee__tid)
                    if cur_process:
                        self._Aee__cur_process = cur_process
                if self._Aee__cur_process == "unknownexp":
                    TEST_LOGGER.debug("Process: unknownexp, 尝试在SYS_PROCESSES_AND_THREADS中获取process", tag=(self._Aee__aee_dir_name))
                    if os.path.isfile(self._Aee__sys_processes_and_threads_path):
                        sys_processes_and_threads = SysProcessesAndThreads(self._Aee__sys_processes_and_threads_path)
                        process_name = sys_processes_and_threads.get_process_by_pid(self._Aee__pid)
                        if process_name:
                            self._Aee__cur_process = process_name
            else:
                TEST_LOGGER.debug("未获取有效pid，无法通过pid获取process", tag=(self._Aee__aee_dir_name))
        
        # 检查 package 和 process 的一致性
        if self._Aee__cur_process and self._Aee__package:
            if self._Aee__cur_process not in self._Aee__package:
                if self._Aee__package not in self._Aee__cur_process:
                    TEST_LOGGER.debug(("解析出的package：{}，中不包含process：{}，设置package=process".format(self._Aee__package, self._Aee__cur_process)), tag=(self._Aee__aee_dir_name))
                    self._Aee__package = self._Aee__cur_process
        
        self._Aee__package = "android_framework" if self._Aee__package == "android" else self._Aee__package
        self._Aee__cur_process = "android_framework" if self._Aee__cur_process == "android" else self._Aee__cur_process
        self._Aee__caused_by = f"Device_id: {self._Aee__device_id}"
        
        # 调用 recognize_except
        if self._Aee__recognize_except:
            try:
                recognize_except_list = recognize_except(self._Aee__aee_dir, self._Aee__aee_dir_name)
                if recognize_except_list:
                    self._Aee__caused_by = self._Aee__caused_by + "\n" + "\n".join(recognize_except_list)
                    TEST_LOGGER.info(("获取问题原因：\n{}".format(self._Aee__caused_by)), tag=(self._Aee__aee_dir_name))
                else:
                    TEST_LOGGER.warn("调用 recognizeexception 解析问题为空", tag=(self._Aee__aee_dir_name))
                    self._Aee__recognize_exception_rlt = False
            except Exception as e:
                if str(e) == "RecognizeException":
                    self._Aee__recognize_exception_rlt = False
                else:
                    TEST_LOGGER.warn(f"调用 recognizeexception 解析结果处理异常：\n{traceback.format_exc()}", tag=(self._Aee__aee_dir_name))
                    self._Aee__handle_recognize_rlt = False
        
        # SWT、OCP reboot、External (EE) modem/scp、HWT、HANG_DETECT 类型强制使用默认的随机字符串格式
        # 注意：External (EE) 只有 modem 和 scp 类型使用默认格式，combo 类型保留详细信息
        if self._Aee__exp_class in ('SWT', 'OCP reboot', 'HWT', 'HANG_DETECT'):
            self._Aee__detail = None
        elif self._Aee__exp_class == 'External (EE)' and self._Aee__exp_type in ('modem', 'scp'):
            self._Aee__detail = None
        
        # 设置默认 detail
        if self._Aee__detail is None or self._Aee__detail == "" or self._Aee__detail == "None":
            self._Aee__detail = f"class:[{self._Aee__exp_class}] process:[{self._Aee__cur_process}] 当前类型没有获取详细信息方式，请自己查看日志文件，本内容只为了Jira不能去重：\n{random_str(slen=200)}"

    def get_aee_attrs(self):
        # 返回顺序：
        # [0] Path, [1] Version, [2] ExpTime, [3] ExpClass, [4] ExpType,
        # [5] CurProcess, [6] Package, [7] Detail列内容, [8] CausedBy列内容, [9] extraTag,
        # [10] Count, [11] Activity, [12] DeviceId, [13] FansVersion
        # 
        # Excel 列映射：
        # - [7] → Detail 列：recognize_except 结果（Device_id、解析库版本、手机版本、异常包名等）
        # - [8] → CausedBy 列：Activity + Subject + 堆栈信息
        #
        # 变量对应：
        # - __caused_by 存储 recognize_except 结果 → 对应 Detail 列
        # - __detail 存储 Activity + Subject + 堆栈信息 → 对应 CausedBy 列
        return [
         self._Aee__exp_main_path, self._Aee__version, self._Aee__exp_time, self._Aee__exp_class, self._Aee__exp_type,
         self._Aee__cur_process, self._Aee__package, self._Aee__caused_by, self._Aee__detail, self._Aee__extra_tag, self._Aee__count, self._Aee__activity, self._Aee__device_id, self._Aee__fans_version]

    @property
    def recognize_exception_rlt(self):
        return self._Aee__recognize_exception_rlt

    @property
    def handle_recognize_rlt(self):
        return self._Aee__handle_recognize_rlt

    def is_foreground_no(self):
        return self._Aee__foreground_no

    def is_ne_system_issue(self):
        return self._Aee__ne_system_issue

    def is_ignore_ke_ne_hwasan(self):
        return self._Aee__ignore_ke_ne_hwasan

    def __read_sys_properties(self):
        if os.path.isfile(self._Aee__sys_properties_path):
            sys_properties = SysProperties(self._Aee__sys_properties_path)
            self._Aee__version = sys_properties.build_version
            self._Aee__device_id = sys_properties.device_id
            self._Aee__fans_version = sys_properties.fans_version
        else:
            TEST_LOGGER.debug(("SYS_PROPERTIES 文件不存在：{}".format(self._Aee__sys_properties_path)), tag=(self._Aee__aee_dir_name))
            self._Aee__fans_version = False

    def __get_build_version(self):
        """
        获取问题版本
        :return:
        """
        if not self._Aee__version:
            regex_version = re.compile("([a-zA-Z0-9]+-)+\\d{6}V\\d+[a-zA-Z]*")
            regex_rlt = re.search(regex_version, self._Aee__exp_main_path)
            if regex_rlt:
                self._Aee__version = regex_rlt.group()
                if self._Aee__exp_main_build_version:
                    if self._Aee__exp_main_build_version not in self._Aee__version:
                        TEST_LOGGER.debug(("路径中获取版本为：{}".format(self._Aee__version)), tag=(self._Aee__aee_dir_name))
                        self._Aee__version = re.sub("\\d{6}V\\d+[a-zA-Z]*", self._Aee__exp_main_build_version, self._Aee__version)
                        TEST_LOGGER.debug(("替换为 {}".format(self._Aee__version)), tag=(self._Aee__aee_dir_name))

    def __anr_optimize(self):
        TEST_LOGGER.debug("开始获取 ANR 类型问题的 detail 信息", tag=(self._Aee__aee_dir_name))
        if not os.path.isfile(self._Aee__sys_android_event_log_path):
            TEST_LOGGER.debug("SYS_ANDROID_EVENT_LOG 文件不存在", tag=(self._Aee__aee_dir_name))
            return (False, 'SYS_ANDROID_EVENT_LOG not found')
        
        exp_time_str = None
        TEST_LOGGER.debug(f"self.__exp_time: {self._Aee__exp_time}")
        regex_time = re.compile("\\d{2}:\\d{2}:\\d{2}")
        regex_rlt = re.search(regex_time, self._Aee__exp_time) if self._Aee__exp_time else None
        if regex_rlt:
            exp_time_str = regex_rlt.group()
        
        if not exp_time_str:
            TEST_LOGGER.debug("获取 self.__exp_time 中的 时间信息异常", tag=(self._Aee__aee_dir_name))
            return (False, 'unexpected time info in exp_time when analyse am_anr')
        
        sys_android_event_log = SysAndroidEventLog(self._Aee__sys_android_event_log_path)
        is_am_anr, last_am_anr_pid, no_focused_window, screen_toggled_0_before_am_anr = sys_android_event_log.is_am_anr(exp_time_str, self._Aee__pid)
        
        if not is_am_anr:
            TEST_LOGGER.debug("在 SYS_ANDROID_EVENT_LOG 中未发现 am_anr 内容", tag=(self._Aee__aee_dir_name))
            return (False, 'can not find am_anr')
        
        self._Aee__pid = last_am_anr_pid if not self._Aee__pid else self._Aee__pid
        
        if no_focused_window:
            TEST_LOGGER.debug("在 SYS_ANDROID_EVENT_LOG 中发现 does not have a focused window，检查当前是否息屏", tag=(self._Aee__aee_dir_name))
            if screen_toggled_0_before_am_anr:
                TEST_LOGGER.debug("SYS_ANDROID_EVENT_LOG 中，am_anr之前 screen_toggled: 0，确认处于息屏状态", tag=(self._Aee__aee_dir_name))
                return (True, 'anr when screen off')
            else:
                TEST_LOGGER.debug("检查 DUMPSYS_SURFACEFLINGER 文件", tag=(self._Aee__aee_dir_name))
                dumpsysSurfaceFlinger = DumpsysSurfaceFlinger(self._Aee__dumpsys_surface_flinger_path)
                is_screen_on = dumpsysSurfaceFlinger.is_screen_on()
                if is_screen_on:
                    TEST_LOGGER.debug("检查 DUMPSYS_DISPLAY 文件", tag=(self._Aee__aee_dir_name))
                    dumpsysDisplay = DumpsysDisplay(self._Aee__dumpsys_display_path)
                    is_screen_on = dumpsysDisplay.is_screen_on()
                    if not is_screen_on:
                        TEST_LOGGER.debug("检查 DUMPSYS_DISPLAY 文件后，确认处于息屏状态", tag=(self._Aee__aee_dir_name))
                else:
                    TEST_LOGGER.debug("检查 DUMPSYS_SURFACEFLINGER 文件后，确认处于息屏状态", tag=(self._Aee__aee_dir_name))
                if not is_screen_on:
                    return (True, 'anr when screen off')
        
        if not self._Aee__pid:
            TEST_LOGGER.debug("获取pid失败")
            return (False, 'can not find pid')
        
        if os.path.isfile(self._Aee__sys_android_log_path):
            sys_android_log = SysAndroidLog(self._Aee__sys_android_log_path)
            if sys_android_log.is_hprof_anr(self._Aee__pid):
                TEST_LOGGER.debug("在 SYS_ANDROID_LOG 中发现 hprof: heap dump completed")
                return (False, 'hprof anr')
        
        if os.path.isfile(self._Aee__swt_jbt_traces_path):
            swtJbtTraces = SwtJbtTraces(self._Aee__swt_jbt_traces_path)
            try:
                anr_detail_list = swtJbtTraces.get_anr_detail(self._Aee__pid)
                if anr_detail_list:
                    return (True, "\n".join(anr_detail_list))
                TEST_LOGGER.debug("在 SWT_JBT_TRACES 文件中获取的 anr detail 为空", tag=(self._Aee__aee_dir_name))
                return (False, 'can not find detail in SWT_JBT_TRACES')
            except:
                TEST_LOGGER.debug(("读取 SWT_JBT_TRACES 文件时发生异常：\n{}".format(traceback.format_exc())), tag=(self._Aee__aee_dir_name))
                return (False, 'exception when read SWT_JBT_TRACES')
        else:
            TEST_LOGGER.debug("SWT_JBT_TRACES 文件不存在", tag=(self._Aee__aee_dir_name))
            return (False, 'SWT_JBT_TRACES not found')

    def __swt_optimize(self):
        TEST_LOGGER.debug("开始获取 SWT 类型问题的 detail 信息", tag=(self._Aee__aee_dir_name))
        try:
            tne01 = Tne01((self._Aee__aee_dir), is_aee=True)
            tne01.analyse()
            self._Aee__detail = tne01.get_tne_attrs()[8]
        except:
            TEST_LOGGER.error(("获取swt detail信息时，发生异常：\n{}".format(traceback.format_exc())), tag=(self._Aee__aee_dir_name))

# okay decompiling extracted_pyz_modules\modules\analyse\aee\AnalyseAee.pyc
