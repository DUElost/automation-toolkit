# -*- coding: utf-8 -*-
# 反编译后清理的文件

import datetime, os, re
from modules.analyse.tne.files.android_events_log import AndroidEventsLog
from modules.analyse.tne.files.android_system_log import AndroidSystemLog
from modules.analyse.tne.files.anr import Anr
from modules.analyse.tne.files.binder_state import BinderState
from modules.analyse.tne.types.tne_base import TneBase
from modules.common.Logger import TEST_LOGGER


class Tne01(TneBase):

    def __init__(self, path, is_aee=False):
        super(Tne01, self).__init__(path, is_aee)
        self._exp_class = "0xffffff01_watchdogTimeout"
        self._exp_type = "0xffffff01_watchdogTimeout"
        self._cur_process = "system_server"
        self._package = "system_server"

    def _report_info_handle(self, exp_type_set=None, watchdog_stack_info_list=None, waited_half_stack_info_list=None):
        if watchdog_stack_info_list and waited_half_stack_info_list and str(watchdog_stack_info_list) == str(waited_half_stack_info_list):
            TEST_LOGGER.debug(("watchdog 与 WAITED_HALF 堆栈内容完全一样: {}".format(watchdog_stack_info_list)), tag=(self.tne_dir_name))
            self._detail = "same stack detail:" if self._detail == "undefined" else self._detail
            self._detail = self._detail + "\n\n" + "\n".join(watchdog_stack_info_list)
        else:
            if watchdog_stack_info_list or waited_half_stack_info_list:
                TEST_LOGGER.debug("watchdog 与 WAITED_HALF 堆栈内容不一致", tag=(self.tne_dir_name))
                if not exp_type_set:
                    exp_type_set = set("different_watchdog_WAITED_HALF")
                else:
                    exp_type_set.add("different_watchdog_WAITED_HALF")
                if watchdog_stack_info_list:
                    self._detail = "watchdog stack detail:" if self._detail == "undefined" else self._detail
                    self._detail = self._detail + "\n\n" + "\n".join(watchdog_stack_info_list)
                if waited_half_stack_info_list:
                    self._detail = "waited half stack detail:" if self._detail == "undefined" else self._detail
                    self._detail = self._detail + "\n\n\n" + "waited half stack detail:" + "\n\n" + "\n".join(waited_half_stack_info_list)
        if exp_type_set:
            self._exp_type = self._exp_type + "\n" + "\n".join(exp_type_set)
        self._detail_to_random()

    def analyse(self):
        """分析方法 - 简化实现"""
        return True

    def __get_closest_anr_file(self, pid, event_time):
        """
        获取指定pid和event_time 最接近的anr文件
        """
        time_file_dict = {}
        regex_key_pid_at = re.compile("----- pid {}".format(pid) + " at \\d{4}-(\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2})")
        for file in os.listdir(self._path):
            if file.startswith("anr"):
                anr_file_path = os.path.join(self._path, file)
                with open(anr_file_path, "r", encoding="utf-8", errors="ignore") as f:
                    for line in f.readlines():
                        regex_exec_rlt = re.search(regex_key_pid_at, line)
                        if regex_exec_rlt:
                            pid_timestamp = regex_exec_rlt.group(1)
                            try:
                                pid_time = datetime.datetime.strptime(pid_timestamp, "%m-%d %H:%M:%S")
                            except:
                                pid_time = datetime.datetime.strptime(str(datetime.datetime.now().year) + "-" + pid_timestamp, "%Y-%m-%d %H:%M:%S")
                            time_file_dict[pid_time] = anr_file_path

        if not time_file_dict:
            return None
        pid_time_list = list(time_file_dict.keys())
        pid_time_list.sort()
        target_anr_file = None
        min_delta_time_before_event = None
        for pid_time in pid_time_list:
            if pid_time == event_time:
                target_anr_file = time_file_dict[pid_time]
                return target_anr_file
            if pid_time < event_time:
                min_delta_time_before_event = (event_time - pid_time).seconds
                target_anr_file = time_file_dict[pid_time]
            else:
                delta_time = (pid_time - event_time).seconds
                if not min_delta_time_before_event or delta_time < min_delta_time_before_event:
                    target_anr_file = time_file_dict[pid_time]
                    return target_anr_file
        return target_anr_file

    def __get_closest_anr_file_list(self, block_time):
        """
        根据 watchdog 发生的时间，获取对应的anr文件
        """
        closest_anr_file_list = []
        regex_key_anr_file = re.compile("anr_\\d{4}-(\\d{2}-\\d{2}-\\d{2}-\\d{2}-\\d{2})")
        closest_file = None
        for file in os.listdir(self._path):
            regex_rlt = re.match(regex_key_anr_file, file)
            if regex_rlt:
                anr_file_timestamp_str = regex_rlt.group(1)
                try:
                    anr_file_timestamp = datetime.datetime.strptime(anr_file_timestamp_str, "%m-%d-%H-%M-%S")
                except:
                    anr_file_timestamp = datetime.datetime.strptime(str(datetime.datetime.now().year) + "-" + anr_file_timestamp_str, "%Y-%m-%d-%H-%M-%S")

                if anr_file_timestamp == block_time:
                    closest_anr_file_list.append(os.path.join(self._path, file))
                elif anr_file_timestamp < block_time:
                    closest_file = file
                elif closest_file:
                    closest_anr_file_list.append(os.path.join(self._path, closest_file))
                    closest_anr_file_list.append(os.path.join(self._path, file))
                    break
        return closest_anr_file_list
