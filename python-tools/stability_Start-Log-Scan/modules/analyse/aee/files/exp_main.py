# -*- coding: utf-8 -*-
# 反编译后清理的文件

import os, re
from modules.analyse.aee.files.exp_detail import ExpDetail
from modules.analyse.aee.files.sys_android_log import SysAndroidLog
from modules.analyse.aee.files.sys_processes_and_threads import SysProcessesAndThreads
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import ignore_num_hex_string, random_str
NOT_SYS_NE_SO_PATH = [
 '/data/', 
 '/data/app/', 
 '/data/app-lib/', 
 '/product/app/Chrome', 
 '/product/app/TrichromeLibrary', 
 '/product/app/GoogleTTS', 
 '/product/app/Maps', 
 '/product/app/WebViewGoogle', 
 '/product/app/YouTube', 
 '/product/priv-app/GmsCore', 
 '/data/preload-app-lib', 
 '/product/operator', 
 '/memfd:', 
 '<anonymous:', 
 '<unknown', 
 '[anon']

class ExpMain(object):

    def __init__(self, file_path, exp_detail_path):
        super(ExpMain, self).__init__()
        self._ExpMain__file_path = file_path
        self._ExpMain__exp_detail_path = exp_detail_path
        self._ExpMain__aee_dir = os.path.dirname(file_path)
        self._ExpMain__aee_dir_name = os.path.basename(self._ExpMain__aee_dir)
        self._ExpMain__exp_main_build_version = None
        self._ExpMain__exp_time = None
        self._ExpMain__exp_class = None
        self._ExpMain__exp_type = None
        self._ExpMain__cur_process = None
        self._ExpMain__package = None
        self._ExpMain__activity = None
        self._ExpMain__subject = None
        self._ExpMain__detail = None
        self._ExpMain__pid = None
        self._ExpMain__tid = None
        self._ExpMain__ne_system_issue = False
        self._ExpMain__ignore_ne_hwasan = False
        self._ExpMain__ignore_ke_hwasan = False
        self._ExpMain__line_count = 0
        self._ExpMain__is_defect_class = False
        self._ExpMain__foreground_no = False
        self._ExpMain__line_index_build_info = None
        self._ExpMain__line_index_exp_time = None
        self._ExpMain__line_index_exp_class = None
        self._ExpMain__line_index_exp_type = None
        self._ExpMain__line_index_current_executing_process = None
        self._ExpMain__line_index_backtrace = None
        self._ExpMain__line_index_process = None
        self._ExpMain__line_index_pid = None
        self._ExpMain__line_index_package = None
        self._ExpMain__line_index_activity = None
        self._ExpMain__line_index_subject = None
        self._ExpMain__line_index_build = None
        self._ExpMain__line_index_loading = None
        self._ExpMain__line_index_dropped = None
        self._ExpMain__line_index_assert = None
        self._ExpMain__line_index_detail_info = None

    def analyse(self):
        TEST_LOGGER.debug(("开始解析 __exp_main.txt 文件：{}".format(self._ExpMain__file_path)), tag=(self._ExpMain__aee_dir_name))
        regex_exception_build_version = re.compile("/(\\d{6}V\\d+[a-zA-Z]*):")
        regex_exception_log_time = re.compile("Exception Log Time:\\[([^\\[]*)\\]")
        with open((self._ExpMain__file_path), "r", encoding="utf-8", errors="ignore") as f:
            lines_in_exp_main = f.readlines()
        self._ExpMain__line_count = len(lines_in_exp_main)
        if self._ExpMain__line_count > 0:
            for line_index in range(self._ExpMain__line_count):
                line = lines_in_exp_main[line_index].strip()
                if "__kasan_report" in line:
                    self._ExpMain__ignore_ke_hwasan = True
                elif not self._ExpMain__line_index_build_info:
                    if line.startswith("Build Info:"):
                        self._ExpMain__line_index_build_info = line_index
                        regex_rlt = re.search(regex_exception_build_version, line)
                        if regex_rlt:
                            self._ExpMain__exp_main_build_version = regex_rlt.group(1)
                            TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Build Version: {}".format(line_index, self._ExpMain__exp_main_build_version)), tag=(self._ExpMain__aee_dir_name))
                            continue
                elif self._ExpMain__line_index_exp_time is None and line.startswith("Exception Log Time:"):
                    self._ExpMain__line_index_exp_time = line_index
                    regex_rlt = re.match(regex_exception_log_time, line)
                    if regex_rlt:
                        self._ExpMain__exp_time = regex_rlt.group(1)
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Exception Log Time: {}".format(line_index, self._ExpMain__exp_time)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_exp_class:
                    if line.startswith("Exception Class:") or line.startswith("Defect Class:"):
                        self._ExpMain__exp_class = line.split(":")[-1].strip()
                        self._ExpMain__line_index_exp_class = line_index
                        if line.startswith("Defect Class:"):
                            self._ExpMain__is_defect_class = True
                            TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Defect Class: {}".format(line_index, self._ExpMain__exp_class)), tag=(self._ExpMain__aee_dir_name))
                        else:
                            TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Exception Class: {}".format(line_index, self._ExpMain__exp_class)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_exp_type:
                    if line.startswith("Exception Type:"):
                        self._ExpMain__exp_type = line.split(":")[-1].strip()
                        self._ExpMain__line_index_exp_type = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Exception Type: {}".format(line_index, self._ExpMain__exp_type)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_current_executing_process:
                    if line == "Current Executing Process:":
                        self._ExpMain__line_index_current_executing_process = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Current Executing Process:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_backtrace:
                    if line == "Backtrace:":
                        self._ExpMain__line_index_backtrace = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Backtrace:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_process:
                    if line.startswith("Process:"):
                        process = line.split("Process:")[1].strip()
                        self._ExpMain__cur_process = process.split()[0].split(":")[0].strip()
                        self._ExpMain__line_index_process = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Process: {}".format(line_index, self._ExpMain__cur_process)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_pid:
                    if line.startswith("PID:"):
                        self._ExpMain__line_index_pid = line_index
                        self._ExpMain__pid = line.split(":")[-1].strip()
                        if self._ExpMain__pid == "0":
                            TEST_LOGGER.debug("获取的PID值为0，设置为未获取", tag=(self._ExpMain__aee_dir_name))
                            self._ExpMain__pid = None
                            continue
                if not self._ExpMain__line_index_package:
                    if line.startswith("Package:"):
                        package = line.split("Package:")[1].strip()
                        self._ExpMain__package = package.split()[0].split(":")[0].strip()
                        self._ExpMain__line_index_package = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Package: {}".format(line_index, self._ExpMain__package)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if "Foreground: No" in line:
                    self._ExpMain__foreground_no = True
                    TEST_LOGGER.debug(("line:{}, Foreground: No, Path:{}".format(line, self._ExpMain__file_path)), tag=(self._ExpMain__aee_dir_name))
                    continue
                if not self._ExpMain__line_index_activity:
                    if line.startswith("Activity:"):
                        self._ExpMain__activity = line.split("Activity:")[1].strip()
                        self._ExpMain__line_index_activity = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Activity: {}".format(line_index, self._ExpMain__activity)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_subject:
                    if line.startswith("Subject:"):
                        self._ExpMain__subject = line.split("Subject:")[1].strip()
                        self._ExpMain__line_index_subject = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Subject: {}".format(line_index, self._ExpMain__subject)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_build:
                    if line.startswith("Build:"):
                        self._ExpMain__line_index_build = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Build:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_loading:
                    if line.startswith("Loading-Progress:"):
                        self._ExpMain__line_index_loading = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Loading-Progress:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_dropped:
                    if line.startswith("Dropped-Count:"):
                        self._ExpMain__line_index_dropped = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Dropped-Count:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if not self._ExpMain__line_index_assert:
                    if "ASSERT" in line:
                        self._ExpMain__line_index_assert = line_index
                        TEST_LOGGER.debug(("__exp_main.txt [Index: {}] ASSERT:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                        continue
                if self._ExpMain__line_index_detail_info is None and "Detail Info" in line:
                    self._ExpMain__line_index_detail_info = line_index
                    TEST_LOGGER.debug(("__exp_main.txt [Index: {}] Detail Info:".format(line_index)), tag=(self._ExpMain__aee_dir_name))
                    continue

            if not self._ExpMain__exp_type:
                self._ExpMain__exp_type = self._ExpMain__exp_class
            if not self._ExpMain__pid:
                if self._ExpMain__line_index_current_executing_process:
                    regex_pid = "pid:(\\d+)"
                    for line in lines_in_exp_main[self._ExpMain__line_index_current_executing_process:]:
                        line = line.strip()
                        regex_rlt = re.search(regex_pid, line)
                        if regex_rlt:
                            self._ExpMain__pid = regex_rlt.group(1)
                            break

            if not self._ExpMain__cur_process or self._ExpMain__exp_type == "system_server_crash":
                self._ExpMain__get_current_process(lines_in_exp_main)
            if self._ExpMain__cur_process:
                if ":" in self._ExpMain__cur_process:
                    self._ExpMain__cur_process = self._ExpMain__cur_process.split(":")[0].strip()
            if not self._ExpMain__package:
                if self._ExpMain__exp_class == "External (EE)" or self._ExpMain__exp_type == "system_server_crash":
                    self._ExpMain__package = self._ExpMain__exp_type
                else:
                    if self._ExpMain__exp_class == "Kernel (KE)":
                        self._ExpMain__package = self._ExpMain__exp_class
                    else:
                        if self._ExpMain__is_defect_class and self._ExpMain__exp_class != "Kernel API Dump":
                            self._ExpMain__package = self._ExpMain__exp_class
                        else:
                            self._ExpMain__package = self._ExpMain__cur_process
            self._ExpMain__get_detail(lines_in_exp_main)
            if self._ExpMain__exp_class == "Native (NE)":
                if self._ExpMain__line_index_backtrace:
                    self._ExpMain__ne_system_issue = self._ExpMain__is_ne_system_issue(lines_in_exp_main)
            return True
        TEST_LOGGER.error(("__exp_main.txt 文件：{} 为空".format(self._ExpMain__file_path)), tag=(self._ExpMain__aee_dir_name))
        return False

    def get_analyse_rlt(self):
        return (
         self._ExpMain__exp_time, self._ExpMain__exp_class, self._ExpMain__exp_type, self._ExpMain__cur_process, self._ExpMain__package, self._ExpMain__activity, self._ExpMain__subject, self._ExpMain__detail, self._ExpMain__pid, self._ExpMain__tid, self._ExpMain__foreground_no, self._ExpMain__exp_main_build_version, self._ExpMain__ne_system_issue, self._ExpMain__ignore_ne_hwasan or self._ExpMain__ignore_ke_hwasan)

    def __get_current_process(self, lines_in_exp_main):
        """
        根据 exp_class 类型 与 Current Executing Process 所在行数，获取 current process 值
        :param lines_in_exp_main:
        :return:
        """
        # 处理特殊的 exp_class 类型
        if self._ExpMain__exp_class in ('Kernel (KE)', 'HWT', 'HANG_DETECT', 'Kernel API Dump', 'Hardware Reboot'):
            self._ExpMain__cur_process = self._ExpMain__exp_class
            return
        
        if self._ExpMain__exp_class == "External (EE)":
            self._ExpMain__cur_process = self._ExpMain__exp_type
            return
        
        # 获取 Current Executing Process 后面的两行
        next_line_1, next_line_2 = '', ''
        if self._ExpMain__line_index_current_executing_process:
            try:
                next_line_1 = lines_in_exp_main[self._ExpMain__line_index_current_executing_process + 1].strip()
                next_line_2 = lines_in_exp_main[self._ExpMain__line_index_current_executing_process + 2].strip()
            except IndexError:
                pass
        
        # 处理 system_server_crash
        if self._ExpMain__exp_type == "system_server_crash":
            self._ExpMain__cur_process = next_line_1
            return
        
        # 处理 Native (NE)
        if self._ExpMain__exp_class == "Native (NE)":
            if os.path.isfile(self._ExpMain__exp_detail_path):
                TEST_LOGGER.debug("Native (NE), 尝试解析 _exp_detail.txt", tag=(self._ExpMain__aee_dir_name))
                exp_detail = ExpDetail(self._ExpMain__exp_detail_path)
                self._ExpMain__cur_process, self._ExpMain__ignore_ne_hwasan = exp_detail.get_cur_process()
                if self._ExpMain__cur_process:
                    return
            if next_line_2 and next_line_2 != "":
                self._ExpMain__cur_process = next_line_2
                return
            regex_pid_tid = re.compile("pid:\\s+(\\d+), tid:\\s+(\\d+)")
            regex_rlt = re.search(regex_pid_tid, next_line_1)
            if regex_rlt:
                self._ExpMain__pid = regex_rlt.group(1)
                self._ExpMain__tid = regex_rlt.group(2)
                sys_android_log_path = self._ExpMain__aee_dir + os.sep + "SYS_ANDROID_LOG"
                if os.path.isfile(sys_android_log_path):
                    sys_android_log = SysAndroidLog(sys_android_log_path)
                    self._ExpMain__cur_process = sys_android_log.get_cur_process(self._ExpMain__pid, self._ExpMain__tid)
                    return
            return
        
        # 处理 SWT
        if self._ExpMain__exp_class == "SWT":
            self._ExpMain__cur_process = next_line_1
            return
        
        # 处理 System API Dump
        if self._ExpMain__exp_class == "System API Dump":
            if next_line_2 and next_line_2 != "":
                self._ExpMain__cur_process = next_line_2.split()[0].split(":")[0].strip()
            return
        
        # 其他情况
        if self._ExpMain__line_index_process:
            self._ExpMain__cur_process = lines_in_exp_main[self._ExpMain__line_index_process].split(":")[1].strip()
        elif next_line_2 and next_line_2 != "":
            self._ExpMain__cur_process = next_line_2.split()[0].split(":")[0].strip()
        
        if not self._ExpMain__cur_process or self._ExpMain__cur_process == "":
            self._ExpMain__cur_process = self._ExpMain__exp_class

    def __get_detail(self, lines_in_exp_main):
        """
        从 __exp_main.txt 文件中提取详细信息
        构建格式: Activity: xxx\nSubject: xxx\n堆栈信息
        :param lines_in_exp_main: 文件内容行列表
        :return:
        """
        # combo 类型的 External (EE) 需要提取 ASSERT 信息（只取第一行）
        if self._ExpMain__exp_class == "External (EE)" and self._ExpMain__exp_type == "combo":
            for line in lines_in_exp_main:
                line_stripped = line.strip()
                # 提取以 ; 开头且包含 ASSERT 的行
                if line_stripped.startswith(";") and "ASSERT" in line_stripped:
                    self._ExpMain__detail = line_stripped
                    return
        
        # Kernel API Dump 类型需要提取 Detail Info 信息
        if self._ExpMain__exp_class == "Kernel API Dump":
            detail_info = None
            in_detail_info = False
            for line in lines_in_exp_main:
                line_stripped = line.strip()
                if line_stripped.startswith("Detail Info:"):
                    in_detail_info = True
                    continue
                if in_detail_info and line_stripped:
                    # 获取 Detail Info 后的第一行非空内容
                    detail_info = line_stripped
                    break
            if detail_info:
                self._ExpMain__detail = f"class:[{self._ExpMain__exp_class}] process:[{self._ExpMain__cur_process}] detail info:[{detail_info}]"
                return
        
        # JE 类型需要提取 Java 异常信息
        if self._ExpMain__exp_class == "Java (JE)":
            for line in lines_in_exp_main:
                line_stripped = line.strip()
                # 查找 Java 异常行（如 java.lang.OutOfMemoryError: ...）
                if line_stripped.startswith("java.") or line_stripped.startswith("android."):
                    if "Exception" in line_stripped or "Error" in line_stripped:
                        self._ExpMain__detail = line_stripped
                        return
                # 查找 Caused by 行
                if line_stripped.startswith("Caused by:"):
                    self._ExpMain__detail = line_stripped
                    return
        
        detail_parts = []
        
        # 添加 Activity 信息
        activity_str = self._ExpMain__activity if self._ExpMain__activity else "None"
        detail_parts.append(f"Activity: {activity_str}")
        
        # 添加 Subject 信息
        if self._ExpMain__subject:
            detail_parts.append(f"Subject: {self._ExpMain__subject}")
        
        # 提取堆栈信息
        backtrace_lines = []
        
        # 从文件中查找堆栈信息（native 堆栈或 Java 堆栈）
        in_backtrace = False
        for i, line in enumerate(lines_in_exp_main):
            line_stripped = line.strip()
            
            # 查找 native 堆栈（以 #00 pc 开头）
            if line_stripped.startswith("#") and " pc " in line_stripped:
                backtrace_lines.append(f"native: {line_stripped}")
                in_backtrace = True
                continue
            
            # 查找 Java 堆栈（以 "at " 开头）
            if line_stripped.startswith("at ") and "(" in line_stripped:
                backtrace_lines.append(line_stripped)
                in_backtrace = True
                continue
            
            # 如果已经在堆栈中，遇到空行或特殊标记则停止
            if in_backtrace:
                if line_stripped == "" or line_stripped.startswith("$**") or line_stripped.startswith("---"):
                    if len(backtrace_lines) > 5:  # 至少收集5行堆栈
                        break
        
        # 添加堆栈信息（最多20行）
        if backtrace_lines:
            detail_parts.extend(backtrace_lines[:20])
        
        # 组合所有部分
        if detail_parts:
            self._ExpMain__detail = "\n".join(detail_parts)
        else:
            self._ExpMain__detail = self._ExpMain__subject or self._ExpMain__exp_type or ""

    def __is_ne_system_issue(self, lines_in_exp_main):
        is_sys = False
        for line in lines_in_exp_main[self._ExpMain__line_index_backtrace:]:
            line = line.strip()
            if line.startswith("#"):
                if re.match("#00 pc(.*?)__epoll_pwait(.*?)", line):
                    return False
                s_line_file = re.sub("[(](.*?)[)]", "", line)
                asl_info = s_line_file.split(" ")
                if len(asl_info) <= 4:
                    continue
                s_line_so = asl_info[4]
                if s_line_so == "":
                    TEST_LOGGER.debug("解析的ne文件so路径为空", tag=(self._ExpMain__aee_dir_name))
                else:
                    for nsp in NOT_SYS_NE_SO_PATH:
                        if s_line_so.startswith(nsp):
                            TEST_LOGGER.debug(("解析的ne文件so路径为：{} 以：{} 开头，判定为非系统问题".format(s_line_so, nsp)), tag=(self._ExpMain__aee_dir_name))
                            return False

                    if s_line_so.startswith("/"):
                        is_sys = True
            if line.startswith("$**"):
                break

        return is_sys
