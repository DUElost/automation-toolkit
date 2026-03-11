# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\types\TneFreeze.py
import os.path, re
from modules.analyse.tne.files.binder_state import BinderState
from modules.analyse.tne.files.java_stack import JavaStack
from modules.analyse.tne.files.native_stack import NativeStack
from modules.analyse.tne.files.sys_kernel_log import SysKernelLog
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER

class TneFreeze(TneBase):

    def __init__(self, path, tne_type, build_version, paired_tne=None):
        super(TneFreeze, self).__init__(path)
        self._exp_class = tne_type
        self._exp_type = tne_type
        self._cur_process = tne_type
        self._package = tne_type
        if build_version:
            if self._version == "undefined" or self._version is None:
                self._version = build_version
        self._paired_tne = paired_tne

    def analyse(self):
        self._detail = f"BuildVersion: {self._version}\nExpClass: {self._exp_class}"
        if self._exp_class in ('0x00450005', '0xffffff21'):
            self._extra_tag = "screen_on_off_timeout_check"
            self._caused_by = "埋点名称：screen_on_off_timeout_check\n埋点描述：监控亮/灭屏发起到亮度写值流程，超时触发TNE"
        else:
            if self._exp_class in ('0x00450006', '0xffffff22'):
                self._extra_tag = "panic_key_check"
                self._caused_by = "埋点名称：panic_key_check\n埋点描述：触发用户恐慌按键行为"
            else:
                if self._exp_class in ('0x00450007', '0xffffff23'):
                    self._extra_tag = "inputreader_thread_check"
                    self._caused_by = "埋点名称：inputreader_thread_check\n埋点描述：InputReader线程异常"
                else:
                    if self._exp_class in ('0x00450008', '0xffffff24'):
                        self._extra_tag = "inputDispatcher_thread_check"
                        self._caused_by = "埋点名称：inputDispatcher_thread_check\n埋点描述：InputDispatcher线程异常"
                    else:
                        if self._exp_class in ('0x00450009', '0xffffff25'):
                            self._extra_tag = "1_pixel_and_transparent_window_check"
                            self._caused_by = "埋点名称：1_pixel_and_transparent_window_check\n埋点描述：1像素/透明window检测"
                        else:
                            if self._exp_class in ('0x00070001', '0xffffff26'):
                                self._extra_tag = "cpu_state"
                                self._caused_by = "埋点名称：cpu_state\n埋点描述：收集CPU重负载的时候产生的系统信息"
                            else:
                                if self._exp_class in ('0x000c0005', '0xffffff27'):
                                    self._extra_tag = "io_handling_high"
                                    self._caused_by = "埋点名称：io_handling_high\n埋点描述：收集io handling higi的异常"
                                else:
                                    if self._exp_class in ('0x000c0006', '0xffffff28'):
                                        self._extra_tag = "ufs_driver_exception"
                                        self._caused_by = "埋点名称：ufs_driver_exception\n埋点描述：收集UFS驱动的异常"
                                    else:
                                        if self._exp_class in ('0x007a0041', '0xffffff29'):
                                            self._extra_tag = "maybe_java_leak"
                                            self._caused_by = "埋点名称：maybe_java_leak\n埋点描述：Maybe Java leak"
                                        else:
                                            if self._exp_class in ('0x007a0042', '0xffffff2a'):
                                                self._extra_tag = "tranWatchdog_block"
                                                self._caused_by = "埋点名称：tranWatchdog_block\n埋点描述：TranWatchdog block"
                                            else:
                                                if self._exp_class in ('0x007a0043',
                                                                       '0xffffff2b'):
                                                    self._extra_tag = "presentFence_block"
                                                    self._caused_by = "埋点名称：presentFence_block\n埋点描述：PresentFence block"
                                                else:
                                                    if self._exp_class in ('0x007a0044',
                                                                           '0xffffff2c'):
                                                        self._extra_tag = "app_thread_block"
                                                        self._caused_by = "埋点名称：app_thread_block\n埋点描述：App thread block"
                                                    else:
                                                        if self._exp_class in ('0x007a0045',
                                                                               '0xffffff2d'):
                                                            self._extra_tag = "black_screen_check"
                                                            self._caused_by = "埋点名称：black_screen_check\n埋点描述：Black screen check"
                                                        else:
                                                            if self._exp_class in ('0x007a0046',
                                                                                   '0xffffff2e'):
                                                                self._extra_tag = "ion_memory_check"
                                                                self._caused_by = "埋点名称：ion_memory_check\n埋点描述：Ion memory check"
                                                            else:
                                                                if self._exp_class in ('0x007a0047',
                                                                                       '0xffffff2f'):
                                                                    self._extra_tag = "connectionRecord_leak"
                                                                    self._caused_by = "埋点名称：connectionRecord_leak\n埋点描述：ConnectionRecord leak"
                                                                else:
                                                                    if self._exp_class in ('0x007a0048',
                                                                                           '0xffffff30'):
                                                                        self._extra_tag = "futex_hung_dectect"
                                                                        self._caused_by = "埋点名称：futex_hung_dectect\n埋点描述：futex hung dectect"
                                                                    else:
                                                                        if self._exp_class in ('0x007a0049',
                                                                                               '0xffffff31'):
                                                                            self._extra_tag = "binder_transaction_hung_client"
                                                                            self._caused_by = "埋点名称：binder_transaction_hung_client\n埋点描述：binder transaction hung client"
                                                                            if self._paired_tne:
                                                                                stack_info_list, analyse_step_info_list = self._analyse_tne_31_32()
                                                                                if stack_info_list:
                                                                                    self._detail = self._detail + "\n***FoundStackInfo***\n" + "\n".join(stack_info_list)
                                                                                    self._extra_tag = "binder_transaction_hung_target"
                                                                                    self._caused_by = "埋点名称：binder_transaction_hung_target\n埋点描述：binder transaction hung target"
                                                                                    if self._exp_class == "0x007a0049":
                                                                                        self._exp_class = "0x007a0050"
                                                                                        self._exp_type = "0x007a0050"
                                                                                        self._cur_process = "0x007a0050"
                                                                                        self._package = "0x007a0050"
                                                                                    else:
                                                                                        if self._exp_class == "0xffffff31":
                                                                                            self._exp_class = "0xffffff32"
                                                                                            self._exp_type = "0xffffff32"
                                                                                            self._cur_process = "0xffffff32"
                                                                                            self._package = "0xffffff32"
                                                                                self._caused_by = self._caused_by + f"\n对应0xffffff32: {self._paired_tne}"
                                                                                self._caused_by = self._caused_by + "\n解析步骤：\n" + "\n".join(analyse_step_info_list)
                                                                        elif self._exp_class in ('0x007a0050',
                                                                                                 '0xffffff32'):
                                                                            self._extra_tag = "binder_transaction_hung_target"
                                                                            self._caused_by = "埋点名称：binder_transaction_hung_target\n埋点描述：binder transaction hung target"
                                                                        else:
                                                                            if self._exp_class in ('0x007a0051',
                                                                                                   '0xffffff33'):
                                                                                self._extra_tag = "cup_hung"
                                                                                self._caused_by = "埋点名称：cup_hung\n埋点描述：cup hung"
                                                                            else:
                                                                                if self._exp_class in ('0x007a0052',
                                                                                                       '0xffffff34'):
                                                                                    self._extra_tag = "hung_iowait_task"
                                                                                    self._caused_by = "埋点名称：hung_iowait_task\n埋点描述：收集hung iowait task异常log"
                                                                                else:
                                                                                    if self._exp_class in ('0x007a0053',
                                                                                                           '0xffffff35'):
                                                                                        self._extra_tag = "hung_non_iowait_task"
                                                                                        self._caused_by = "埋点名称：hung_non_iowait_task\n埋点描述：收集hung non-iowait task异常log"
                                                                                    else:
                                                                                        if self._exp_class in ('0x00080001',
                                                                                                               '0xffffff36'):
                                                                                            self._extra_tag = "lcm_driver"
                                                                                            self._caused_by = "埋点名称：lcm_driver\n埋点描述：收集LCM driver问题埋点"
                                                                                        else:
                                                                                            if self._exp_class in ('0x00500003',
                                                                                                                   '0xffffff37'):
                                                                                                self._extra_tag = "lmkd_exception"
                                                                                                self._caused_by = "埋点名称：lmkd_exception\n埋点描述：检测到系统存在内存占用回收异常时回传现场信息供分析"
                                                                                            else:
                                                                                                if self._exp_class in ('0x007a002a',
                                                                                                                       '0xffffff38'):
                                                                                                    self._extra_tag = "event_longpress"
                                                                                                    self._caused_by = "埋点名称：event_longpress\n埋点描述：长按Power键事件监测"
                                                                                                else:
                                                                                                    self._extra_tag = "freeze"
                                                                                                    self._caused_by = "未知的Freeze埋点类型"

    def _analyse_tne_31_32(self):
        analyse_step_info_list = []
        if not (os.path.isfile(self._sys_kernel_log_path) and os.path.getsize(self._sys_kernel_log_path) > 0):
            TEST_LOGGER.warn(f"{self._sys_kernel_log_path} 不存在或者为空")
            analyse_step_info_list.append(f"{self._sys_kernel_log_path} 不存在或者为空")
            return (None, analyse_step_info_list)
        if not os.path.isfile(self._binder_state_path):
            if os.path.getsize(self._binder_state_path) > 0:
                TEST_LOGGER.warn(f"{self._binder_state_path} 不存在或者为空")
                analyse_step_info_list.append(f"{self._binder_state_path} 不存在或者为空")
                return (None, analyse_step_info_list)
        native_stack, java_stack = (None, None)
        paired_32_native_stack_path = os.path.join(self._paired_tne, "native_stack")
        if os.path.isfile(paired_32_native_stack_path) and os.path.getsize(paired_32_native_stack_path) > 0:
            native_stack = NativeStack(paired_32_native_stack_path)
            TEST_LOGGER.info(f"找到配对的32目录中的native_stack文件：{paired_32_native_stack_path}")
        else:
            paired_32_native_stack_path = None
        paired_32_java_stack_path = os.path.join(self._paired_tne, "java_stack")
        if os.path.isfile(paired_32_java_stack_path) and os.path.getsize(paired_32_java_stack_path) > 0:
            java_stack = JavaStack(paired_32_java_stack_path)
            TEST_LOGGER.info(f"找到配对的32目录中的java_stack文件：{paired_32_java_stack_path}")
        else:
            paired_32_java_stack_path = None
        if native_stack is None:
            if java_stack is None:
                TEST_LOGGER.warn(f"配对的32目录中: {self._paired_tne}，既没有native_stack文件，也没有java_stack文件")
                analyse_step_info_list.append(f"配对的32目录中: {self._paired_tne}，既没有native_stack文件，也没有java_stack文件")
                return (None, analyse_step_info_list)
        sys_kernel_log = SysKernelLog(self._sys_kernel_log_path)
        bind_hung_30_list = sys_kernel_log.get_bind_hung_30_list()
        if len(bind_hung_30_list) == 0:
            TEST_LOGGER.warn(f"{self._sys_kernel_log_path} 中没有找到 binder hung 30 的信息")
            analyse_step_info_list.append(f"{self._sys_kernel_log_path} 中没有找到 binder hung 30 的信息")
            return (None, analyse_step_info_list)
        if len(bind_hung_30_list) > 1:
            pid_list = None
            if paired_32_native_stack_path:
                pid_list = native_stack.get_pid()
            else:
                if paired_32_java_stack_path:
                    pid_list = java_stack.get_pid()
                elif not pid_list:
                    TEST_LOGGER.warn("无法从 native_stack 或 java_stack 中找到 pid")
                    analyse_step_info_list.append("无法从 native_stack 或 java_stack 中找到 pid")
                    return (None, analyse_step_info_list)
                if len(pid_list) > 1:
                    TEST_LOGGER.warn(f"native_stack 或 java_stack 中找到多个 pid: {pid_list}")
                pid = pid_list[0]
                bind_hung_30_with_pid_list = []
                for line in bind_hung_30_list:
                    if pid in line:
                        bind_hung_30_with_pid_list.append(line)

                bind_hung_30_with_pid_list or TEST_LOGGER.warn(f"在 {self._sys_kernel_log_path} 中找不到 含有 pid: {pid} 的 binder hung 30 信息")
                analyse_step_info_list.append(f"在 {self._sys_kernel_log_path} 中找不到 含有 pid: {pid} 的 binder hung 30 信息")
                return (None, analyse_step_info_list)
            bind_hung_30_list = bind_hung_30_with_pid_list
        TEST_LOGGER.info(f"获取到的 binder hung 30 信息: {bind_hung_30_list}")
        for line in bind_hung_30_list:
            analyse_step_info_list.append(line)

        code_dict = {}
        regex_key = re.compile("from\\s+(.*?)\\s+code.*?:(.*?)\\s+to")
        for line_with_pid in bind_hung_30_list:
            regex_rlt = re.search(regex_key, line_with_pid)
            if regex_rlt:
                code_key = regex_rlt.group(1)
                code_value = regex_rlt.group(2)
                code_dict[code_key] = code_value

        if not code_dict:
            TEST_LOGGER.warn("在 bind_hung_30_list 解析code_key 和 code_value 失败")
            analyse_step_info_list.append("在 bind_hung_30_list 解析code_key 和 code_value 失败")
            return (None, analyse_step_info_list)
        binder_state = BinderState(self._binder_state_path)
        pid_value_set = set()
        for code_key, code_value in code_dict.items():
            pid_value, code_line = binder_state.get_0x31_pid_value(code_key, code_value)
            analyse_step_info_list.append(f"{code_key} --- {code_value} --- {pid_value} --- {code_line}")
            if not pid_value is None:
                if pid_value == "0":
                    TEST_LOGGER.warn(f"在 {self._binder_state_path} 中根据code_key:{code_key} 获取pid_value异常：{pid_value}")
                    continue
                TEST_LOGGER.warn(f"在 {self._binder_state_path} 中根据code_key:{code_key} 获取pid_value成功：{pid_value}")
                pid_value_set.add(pid_value)

        if not pid_value_set:
            TEST_LOGGER.warn(f"在 {self._binder_state_path} 中找不到任何 pid_value")
            analyse_step_info_list.append(f"在 {self._binder_state_path} 中找不到任何 pid_value")
            return (None, analyse_step_info_list)
        TEST_LOGGER.info(f"在 {self._binder_state_path} 中找到的 pid_value: {pid_value_set}")
        for pid_value in pid_value_set:
            if native_stack:
                stack_info_list = native_stack.get_stack_info(pid_value)
            else:
                if java_stack:
                    stack_info_list = java_stack.get_stack_info(pid_value)
            if stack_info_list:
                TEST_LOGGER.info(f"在 {self._binder_state_path} 中找到的 pid_value: {pid_value} 对应的 stack_info_list")
                analyse_step_info_list.append(f"pid_value: {pid_value}")
                return (stack_info_list, analyse_step_info_list)

        TEST_LOGGER.warn(f"在 java_stack 与 native_stack 中找不到 pid_value_set:{pid_value_set} 对应的堆栈信息")
        analyse_step_info_list.append(f"在 java_stack 与 native_stack 中找不到 pid_value_set:{pid_value_set} 对应的堆栈信息")
        return (None, analyse_step_info_list)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\types\TneFreeze.pyc
