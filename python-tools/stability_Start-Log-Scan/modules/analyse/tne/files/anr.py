# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\anr.py
import os, re, datetime
from modules.common.Logger import TEST_LOGGER

class StackObj(object):
    __doc__ = "\n    anr 文件中，每个线程堆栈块对象\n    "

    def __init__(self, thread_tid):
        super(StackObj, self).__init__()
        self.thread_tid = thread_tid
        self.thread_name = None
        self.wait_for_response = False
        self.sys_tid = None
        self.held_by_thread = None
        self.thread_status = False
        self.block_detail = []


class BlockThread(object):
    __doc__ = "\n    watchdog行中 Blocked in handler 的线程\n    "

    def __init__(self, thread_name):
        super(BlockThread, self).__init__()
        self.thread_name = thread_name
        self.thread_tid = None
        self.is_cycled = False
        self.traced_tid_list = []
        self.cycled_stack_list = []


class Anr(object):

    def __init__(self, file_path):
        super(Anr, self).__init__()
        self._Anr__file_path = file_path
        self._Anr__tne_dir_name = os.path.basename(os.path.dirname(file_path))
        self._Anr__start_line = None
        self._Anr__tid_stackObj_dict = {}
        self._Anr__block_thread_dict = {}

    def analyse_blocked_thread(self, pid, event_time, block_thread_list):
        """
        解析 watchdog 或者 WAITED_HALF 对应 block_pid 和 发生时间 对应的anr信息
        :param pid:
        :param event_time:
        :param block_thread_list:
        :return:
        """
        self._Anr__get_analyse_start_line(pid, event_time)
        self._Anr__get_all_stack_obj(pid, block_thread_list)
        for block_thread in self._Anr__block_thread_dict.values():
            stackObj = self._Anr__tid_stackObj_dict[block_thread.thread_tid]
            traced_tid_list = [stackObj.thread_tid]
            if stackObj.held_by_thread:
                traced_tid_list.append(stackObj.held_by_thread)
                trace_rlt, is_cycled, cycled_tid_list = self._Anr__traceStackObj(stackObj.held_by_thread, traced_tid_list)
                if is_cycled:
                    block_thread.is_cycled = True
                    block_thread.cycled_stack_list = []
                    for tid in cycled_tid_list:
                        block_thread.cycled_stack_list.append(self._Anr__tid_stackObj_dict[tid])

            block_thread.traced_tid_list = traced_tid_list

        final_stack_list = []
        for thread_name, block_thread in self._Anr__block_thread_dict.items():
            if block_thread.is_cycled:
                return (True, block_thread.cycled_stack_list)
                last_tid = block_thread.traced_tid_list[-1]
                stackObj = self._Anr__tid_stackObj_dict[last_tid]
                if stackObj not in final_stack_list:
                    final_stack_list.append(stackObj)

        return (
         False, final_stack_list)

    def find_binder_stack_info(self, pid, sys_tid, event_time):
        binder_stack_list = []
        if self._Anr__get_analyse_start_line(pid, event_time):
            analyse_start = False
            binder_start = False
            regex_key_binder = re.compile('"Binder:{}'.format(pid) + '.*\\"\\s+' + "sysTid={}".format(sys_tid))
            analyse_end_line = "----- end {} -----".format(pid)
            with open((self._Anr__file_path), "r", encoding="utf-8", errors="ignore") as f:
                for line in f.readlines():
                    line = line.strip()
                    if analyse_start:
                        if analyse_end_line == line:
                            break
                        if binder_start:
                            binder_stack_list.append(line)
                            if line == "":
                                break
                        else:
                            regex_exec_rlt = re.match(regex_key_binder, line)
                        if regex_exec_rlt:
                            binder_start = True
                        elif self._Anr__start_line == line:
                            analyse_start = True

        return binder_stack_list

    def __get_analyse_start_line(self, pid, event_time):
        """
        获取和 event_time 最接近的 ----- pid xxxx at ----- 行
        :param pid:
        :param event_time:
        :return:
        """
        self._Anr__start_line = None
        regex_key_pid_at = re.compile("----- pid {}".format(pid) + " at \\d{4}-(\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2})")
        TEST_LOGGER.debug(("获取ANR文件中，pid：{} 最接近时间点：{} 的开始行".format(pid, event_time)), tag=(self._Anr__tne_dir_name))
        with open((self._Anr__file_path), "r", encoding="utf-8", errors="ignore") as f:
            min_delta_time_before_event = None
            for line in f.readlines():
                regex_exec_rlt = re.search(regex_key_pid_at, line)
                if regex_exec_rlt:
                    line = line.strip()
                    pid_timestamp = regex_exec_rlt.group(1)
                    try:
                        pid_time = datetime.datetime.strptime(pid_timestamp, "%m-%d %H:%M:%S")
                    except:
                        pid_time = datetime.datetime.strptime(str(datetime.datetime.now().year) + "-" + pid_timestamp, "%Y-%m-%d %H:%M:%S")

                    if pid_time == event_time:
                        self._Anr__start_line = line
                        break
                    elif pid_time < event_time:
                        min_delta_time_before_event = (pid_time - event_time).seconds
                        self._Anr__start_line = line
                    else:
                        delta_time = (event_time - pid_time).seconds
                        if not min_delta_time_before_event or delta_time < min_delta_time_before_event:
                            self._Anr__start_line = line
                        break

        if self._Anr__start_line:
            TEST_LOGGER.debug(("pid:{}, event_time:{} 对应开始行为：{}".format(pid, event_time, self._Anr__start_line)), tag=(self._Anr__tne_dir_name))
            return True
        TEST_LOGGER.debug(("pid:{}, event_time:{} 没有找到对应开始行".format(pid, event_time)), tag=(self._Anr__tne_dir_name))
        return False

    def __get_all_stack_obj(self, pid, block_thread_list):
        analyse_start = False
        block_start = False
        analyse_end_line = "----- end {} -----".format(pid)
        regex_key_block_start = re.compile('\\"(.+)\\" prio=\\d+ tid=(\\d+) (.+)')
        regex_key_held_by_thread = re.compile("held by thread (\\d+)")
        regex_key_sys_pid = re.compile("sysTid=(\\d+)")
        with open((self._Anr__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if analyse_start:
                    if analyse_end_line == line:
                        break
                    if block_start and not line.startswith("at"):
                        if line.startswith("-"):
                            stackObj.block_detail.append(line)
                        regex_exec_rlt = re.search(regex_key_held_by_thread, line)
                        if regex_exec_rlt:
                            stackObj.held_by_thread = regex_exec_rlt.group(1)
                        regex_exec_rlt = re.search(regex_key_sys_pid, line)
                        if regex_exec_rlt:
                            stackObj.sys_tid = regex_exec_rlt.group(1)
                        if "waitForResponse" in line:
                            stackObj.wait_for_response = True
                        if line == "":
                            block_start = False
                            if stackObj.thread_name in block_thread_list and not thread_name not in self._Anr__block_thread_dict:
                                if not stackObj.thread_status != "Native" or "android.os.MessageQueue.nativePollOnce" not in str(stackObj.block_detail):
                                    block_thread = BlockThread(thread_name)
                                    block_thread.thread_tid = thread_tid
                                    self._Anr__block_thread_dict[thread_name] = block_thread
                    else:
                        regex_exec_rlt = re.match(regex_key_block_start, line)
                    if regex_exec_rlt:
                        block_start = True
                        thread_name = regex_exec_rlt.group(1)
                        thread_tid = regex_exec_rlt.group(2)
                        thread_status = regex_exec_rlt.group(3)
                        stackObj = StackObj(thread_tid)
                        stackObj.thread_name = thread_name
                        stackObj.thread_status = thread_status
                        stackObj.block_detail = []
                        self._Anr__tid_stackObj_dict[thread_tid] = stackObj
                    elif self._Anr__start_line == line:
                        analyse_start = True

    def __traceStackObj(self, next_tid, traced_tid_list):
        """
        获取阻塞线程指向的下一个线程，并检查是否为环
        :param next_tid:
        :param traced_tid_list:
        :return:  [是否正常] [是否成环] [环链表]
        """
        if next_tid in self._Anr__tid_stackObj_dict:
            stackObj = self._Anr__tid_stackObj_dict[next_tid]
            if stackObj.held_by_thread:
                if stackObj.held_by_thread in traced_tid_list:
                    traced_tid_list.append(stackObj.held_by_thread)
                    cycle_start_index = traced_tid_list.index(stackObj.held_by_thread)
                    cycled_tid_list = traced_tid_list[cycle_start_index[:-1]]
                    return (True, True, cycled_tid_list)
                traced_tid_list.append(stackObj.held_by_thread)
                return self._Anr__traceStackObj(stackObj.held_by_thread, traced_tid_list)
            else:
                return (True, False, None)
        else:
            return (False, False, None)

    def get_all_binder_waiting_stack(self):
        stack_info_list = []
        for stackObj in self._Anr__tid_stackObj_dict.values():
            if stackObj.thread_name.startswith("Binder:") and stackObj.thread_status == "Waiting":
                stack_info_list = stack_info_list + stackObj.block_detail
                stack_info_list.append("\n\n")

        return stack_info_list

    def analyse_tne13(self):
        """
        modified 20230619_1712，分析tne13的anr文件
        :return:
        """
        detail_msg = None
        with open((self._Anr__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if line.startswith("Subject:"):
                    detail_msg = line
                    break

        return detail_msg

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\anr.pyc
