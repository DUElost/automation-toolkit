# -*- coding: utf-8 -*-
"""
recognize_except 模块的替代实现
原模块是内部库，此处提供基于日志文件解析的实现
"""
import os
import re


class recognizeexception:
    """异常识别类"""
    
    @staticmethod
    def recognize(exp_type, caused_by, detail, process_name=None, **kwargs):
        """
        识别异常类型
        :return: (None, None, None) 表示无法识别
        """
        return (None, None, None)
    
    @staticmethod
    def recognizeExcept(aee_dir):
        """
        解析 AEE 目录获取异常信息
        :param aee_dir: AEE 解压目录
        :return: 包含异常信息的字典
        """
        result = {
            "Build Info": None,
            "Package": None,
            "Current Executing Process": None,
            "pid": None,
            "CPU info": None,
            "Subject": None,
            "Blocked Threads": None,
            "Backtrace": None,
            "Backtrace_Log": None,  # SYS_ANDROID_LOG 中的日志行
            "IOW_Warning": None,
            "Thread_Dump": None,
            "Thread_Dump_Error": None,  # 当找不到 main 线程 dump 时的错误消息
            "Exception_Class": None  # 异常类型：ANR, NE, JE
        }
        
        if not os.path.isdir(aee_dir):
            return result
        
        # 解析 __exp_main.txt（主要数据来源）
        exp_main_path = os.path.join(aee_dir, "__exp_main.txt")
        if os.path.isfile(exp_main_path):
            result = recognizeexception._parse_exp_main(exp_main_path, result)
        
        # 解析 SYS_PROPERTIES（获取详细版本信息）
        sys_properties_path = os.path.join(aee_dir, "SYS_PROPERTIES")
        if os.path.isfile(sys_properties_path):
            result = recognizeexception._parse_sys_properties(sys_properties_path, result)
        
        # 解析 SYS_ANDROID_LOG（获取 Timeout 日志）
        sys_android_log_path = os.path.join(aee_dir, "SYS_ANDROID_LOG")
        if os.path.isfile(sys_android_log_path) and result.get("pid"):
            result = recognizeexception._parse_sys_android_log(sys_android_log_path, result)
        
        # 解析 SWT_JBT_TRACES（获取线程 dump）
        swt_jbt_traces_path = os.path.join(aee_dir, "SWT_JBT_TRACES")
        if os.path.isfile(swt_jbt_traces_path) and result.get("pid"):
            result = recognizeexception._parse_swt_jbt_traces(swt_jbt_traces_path, result)
        
        return result
    
    @staticmethod
    def _parse_exp_main(file_path, result):
        """解析 __exp_main.txt 文件"""
        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                content = f.read()
                lines = content.split("\n")
            
            # 检测异常类型
            exception_class = None
            defect_class = None
            
            for line in lines:
                # 检测 Exception Class
                if "Exception Class:" in line:
                    if "Native (NE)" in line:
                        exception_class = "NE"
                    elif "Java (JE)" in line:
                        exception_class = "JE"
                    elif "ANR" in line:
                        exception_class = "ANR"
                    elif "External (EE)" in line:
                        exception_class = "EE"
                    elif "Kernel (KE)" in line:
                        exception_class = "KE"
                    elif "SWT" in line:
                        exception_class = "SWT"
                    elif "HANG_DETECT" in line:
                        exception_class = "HANG"
                    elif "OCP reboot" in line:
                        exception_class = "OCP"
                    elif "Hardware Reboot" in line:
                        exception_class = "HW_Reboot"
                    elif "HWT" in line:
                        exception_class = "HWT"
                    break
                # 检测 Defect Class（KernelAPI, SystemAPI 等）
                if "Defect Class:" in line:
                    if "Kernel API" in line:
                        defect_class = "KernelAPI"
                    elif "System API" in line:
                        defect_class = "SystemAPI"
                    break
            
            # 根据异常类型选择解析方法
            if defect_class == "KernelAPI":
                result["Exception_Class"] = "KernelAPI"
                return recognizeexception._parse_kernel_api_exp_main(lines, result)
            elif defect_class == "SystemAPI":
                result["Exception_Class"] = "SystemAPI"
                return recognizeexception._parse_system_api_exp_main(lines, result)
            elif exception_class == "NE":
                result["Exception_Class"] = "NE"
                return recognizeexception._parse_ne_exp_main(lines, result)
            elif exception_class == "JE":
                result["Exception_Class"] = "JE"
                return recognizeexception._parse_je_exp_main(lines, result)
            elif exception_class == "EE":
                result["Exception_Class"] = "EE"
                return recognizeexception._parse_ee_exp_main(lines, result)
            elif exception_class == "KE":
                result["Exception_Class"] = "KE"
                return recognizeexception._parse_ke_exp_main(lines, result)
            elif exception_class == "SWT":
                result["Exception_Class"] = "SWT"
                return recognizeexception._parse_swt_exp_main(lines, result)
            elif exception_class == "HANG":
                result["Exception_Class"] = "HANG"
                return recognizeexception._parse_hang_exp_main(lines, result)
            elif exception_class == "OCP":
                result["Exception_Class"] = "OCP"
                return recognizeexception._parse_ocp_exp_main(lines, result)
            elif exception_class == "HW_Reboot":
                result["Exception_Class"] = "HW_Reboot"
                return recognizeexception._parse_hw_reboot_exp_main(lines, result)
            elif exception_class == "HWT":
                result["Exception_Class"] = "HWT"
                return recognizeexception._parse_hwt_exp_main(lines, result)
            else:
                result["Exception_Class"] = "ANR"
                return recognizeexception._parse_anr_exp_main(lines, result)
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_ne_exp_main(lines, result):
        """解析 NE (Native Exception) 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            pid_value = None
            backtrace_lines = []
            in_backtrace = False
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info（NE 格式）- 暂时保存，后面可能被 SYS_PROPERTIES 覆盖
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 pid 和 tid（NE 格式: pid: 23394, tid: 23402）
                if "pid:" in line_stripped and "tid:" in line_stripped:
                    match = re.search(r'pid:\s*(\d+)', line_stripped)
                    if match:
                        pid_value = match.group(1)
                        result["pid"] = [f" {pid_value}"]
                
                # 解析 Current Executing Process（NE 格式）
                if line_stripped.startswith("/system/") or line_stripped.startswith("/vendor/") or line_stripped.startswith("/apex/"):
                    if not result.get("Current Executing Process"):
                        result["Current Executing Process"] = [line_stripped]
                
                # 解析 Backtrace（NE 格式: #00 pc ...）
                if line_stripped.startswith("Backtrace:"):
                    in_backtrace = True
                    continue
                
                if in_backtrace:
                    if line_stripped.startswith("#"):
                        # 格式化堆栈行，去掉前导空格
                        backtrace_lines.append(line_stripped)
                    elif line_stripped.startswith("$**") or line_stripped == "":
                        in_backtrace = False
            
            # 设置 Build Info（暂时使用从 __exp_main.txt 解析的）
            if build_info:
                result["Build Info"] = [build_info]
            
            # 设置 Backtrace
            if backtrace_lines:
                # 将所有堆栈行合并为一个字符串，用换行符分隔
                result["Backtrace"] = "\n".join(backtrace_lines)
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_je_exp_main(lines, result):
        """解析 JE (Java Exception) 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            pid_value = None
            package_info = None
            process_name = None
            backtrace_lines = []
            in_backtrace = False
            crash_handler = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info（JE 格式）
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 Current Executing Process（JE 格式：进程名在单独一行）
                if line_stripped.startswith("Current Executing Process:"):
                    # 下一行是进程名
                    if i + 1 < len(lines):
                        next_line = lines[i + 1].strip()
                        if next_line and not next_line.startswith("$**"):
                            process_name = next_line
                            result["Current Executing Process"] = [process_name]
                
                # 解析 Package（JE 格式：在 Backtrace 段落内的 Package: xxx）
                # 注意：JE 格式中 Package 在 Backtrace 段落内
                if line_stripped.startswith("Package:") and not package_info:
                    package = line_stripped.split("Package:")[1].strip()
                    if package:
                        package_info = package
                        result["Package"] = [package]
                
                # 解析 PID（JE 格式：PID: xxx 或 Trigger time:[...] pid:xxx）
                if line_stripped.startswith("PID:") and not pid_value:
                    pid = line_stripped.split("PID:")[1].strip()
                    if pid and pid != "0":
                        pid_value = pid
                        result["pid"] = [pid]
                elif "pid:" in line_stripped and not pid_value:
                    match = re.search(r'pid:(\d+)', line_stripped)
                    if match:
                        pid_value = match.group(1)
                        result["pid"] = [pid_value]
                
                # 解析 Backtrace 部分（JE 格式）
                if line_stripped.startswith("Backtrace:"):
                    in_backtrace = True
                    continue
                
                if in_backtrace:
                    # 检测结束标记
                    if line_stripped.startswith("$**"):
                        in_backtrace = False
                        continue
                    
                    # 解析 Crash-Handler（在 Backtrace 段落内）
                    if line_stripped.startswith("Crash-Handler:"):
                        crash_handler = line_stripped
                        continue
                    
                    # 解析异常信息（以异常类名开头，如 android.view.InflateException:）
                    # 或者 Caused by: 开头
                    if (re.match(r'^[a-zA-Z][\w.]+Exception:', line_stripped) or 
                        re.match(r'^[a-zA-Z][\w.]+Error:', line_stripped) or
                        line_stripped.startswith("Caused by:")):
                        backtrace_lines.append(line_stripped)
                        continue
                    
                    # 解析堆栈行（以 at 开头，原始文件中可能是 \tat）
                    if line_stripped.startswith("at "):
                        backtrace_lines.append(line_stripped)
                        continue
            
            # 设置 Build Info
            if build_info:
                result["Build Info"] = [build_info]
            
            # 设置 Blocked Threads（JE 类型默认为 main）
            if pid_value:
                result["Blocked Threads"] = [["main"]]
            
            # 设置 Backtrace（JE 格式：Crash-Handler + 异常信息）
            if crash_handler or backtrace_lines:
                je_backtrace = []
                if crash_handler:
                    je_backtrace.append(crash_handler)
                je_backtrace.extend(backtrace_lines)
                result["Backtrace"] = "\n".join(je_backtrace)
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_anr_exp_main(lines, result):
        """解析 ANR 类型的 __exp_main.txt 文件"""
        try:
            cpu_info_lines = []
            subject_lines = []
            blocked_threads = []
            pid_value = None
            build_info = None
            exp_time = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build（从 Build: 行提取）
                if line_stripped.startswith("Build:"):
                    build_str = line_stripped.split("Build:")[1].strip()
                    # 转换格式
                    if "/" in build_str:
                        parts = build_str.split("/")
                        if len(parts) >= 3:
                            device = parts[1] if len(parts) > 1 else ""
                            rest = "/".join(parts[2:])
                            match = re.match(r'[^:]+:(\d+)/([^/]+)/([^:]+):(\w+)/(.+)', rest)
                            if match:
                                android_ver = match.group(1)
                                version = match.group(2)
                                build_id = match.group(3)
                                build_type = match.group(4)
                                keys = match.group(5)
                                build_info = f"{device}-{build_type} {android_ver} {version} {build_id} {keys}"
                    if not build_info:
                        build_info = build_str
                
                # 解析 Package（包含版本信息）
                if line_stripped.startswith("Package:"):
                    package = line_stripped.split("Package:")[1].strip()
                    if package:
                        result["Package"] = [package]
                
                # 解析 Process
                if line_stripped.startswith("Process:"):
                    process = line_stripped.split("Process:")[1].strip()
                    if process:
                        result["Current Executing Process"] = [process.split()[0].split(":")[0]]
                
                # 解析 PID
                if line_stripped.startswith("PID:"):
                    pid = line_stripped.split("PID:")[1].strip()
                    if pid and pid != "0":
                        pid_value = pid
                        result["pid"] = [pid]
                
                # 解析 Trigger time（获取时间戳）
                if line_stripped.startswith("Trigger time:"):
                    match = re.search(r'\[(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})', line_stripped)
                    if match:
                        exp_time = match.group(1)
                        result["exp_time"] = exp_time
                
                # 解析 Subject
                if line_stripped.startswith("Subject:"):
                    subject = line_stripped.split("Subject:")[1].strip()
                    if subject:
                        subject_lines.append(" " + subject + "\n")
                
                # 解析 CPU info（从 TOTAL: 行提取）
                if "TOTAL:" in line_stripped and "%" in line_stripped:
                    cpu_info_lines.append(line_stripped)
            
            # 设置 Build Info
            if build_info:
                result["Build Info"] = [build_info]
            
            # 设置 Subject
            if subject_lines:
                result["Subject"] = subject_lines
            
            # 设置 CPU info
            if cpu_info_lines:
                result["CPU info"] = cpu_info_lines[:2]
            
            # 设置 Blocked Threads（默认为 main）
            if pid_value:
                result["Blocked Threads"] = [["main"]]
            
            # 设置 Backtrace（使用 CPU info 列表）
            if cpu_info_lines:
                result["Backtrace"] = [cpu_info_lines[:2]]
            
            # 检查 IOW 是否过高
            for cpu_line in cpu_info_lines[:2]:
                match = re.search(r'(\d+)%\s*iowait', cpu_line)
                if match:
                    iowait = int(match.group(1))
                    if iowait > 40:
                        result["IOW_Warning"] = "IOW too high, please analyze the SYS_BLOCKIO with PerLyzer tool, maybe performance issue!!!"
                        break
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_sys_properties(file_path, result):
        """解析 SYS_PROPERTIES 文件，获取详细版本信息"""
        try:
            with open(file_path, "r", encoding="utf-8", errors="ignore") as f:
                for line in f:
                    line = line.strip()
                    # 查找 ro.build.display.id 属性
                    if "[ro.build.display.id]:" in line:
                        match = re.search(r'\[ro\.build\.display\.id\]:\s*\[([^\]]+)\]', line)
                        if match:
                            build_display_id = match.group(1)
                            # 使用这个更详细的版本信息覆盖之前的
                            result["Build Info"] = [build_display_id]
                            break
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_sys_android_log(file_path, result):
        """解析 SYS_ANDROID_LOG 文件，获取 Timeout 日志"""
        try:
            pid = result.get("pid", [None])[0]
            exp_time = result.get("exp_time", "")
            
            if not pid:
                return result
            
            # 提取时间的小时:分钟部分用于匹配
            time_prefix = ""
            if exp_time:
                match = re.search(r'(\d{2}:\d{2}):\d{2}', exp_time)
                if match:
                    time_prefix = match.group(1)
            
            timeout_logs = []
            with open(file_path, "rb") as f:
                for line in f:
                    line = line.decode(encoding="utf-8", errors="ignore").strip()
                    # 查找 Timeout executing service 日志
                    if "Timeout executing service" in line or "Timeout of" in line:
                        # 如果有时间前缀，检查是否匹配
                        if time_prefix and time_prefix in line:
                            timeout_logs.append(line)
                        elif not time_prefix:
                            timeout_logs.append(line)
            
            if timeout_logs:
                # 取最后一条匹配的日志
                result["Backtrace_Log"] = timeout_logs[-1]
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_swt_jbt_traces(file_path, result):
        """解析 SWT_JBT_TRACES 文件，获取线程 dump"""
        try:
            pid = result.get("pid", [None])[0]
            exp_time = result.get("exp_time", "")
            
            if not pid:
                return result
            
            # 提取日期时间用于匹配
            date_str = ""
            time_str = ""
            if exp_time:
                match = re.search(r'(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2})', exp_time)
                if match:
                    date_str = match.group(1)
                    time_str = match.group(2)
            
            pid_line_pattern = f"pid {pid} at"
            found_pid_section = False
            found_main_thread = False
            pid_header_line = None
            main_thread_lines = []
            
            with open(file_path, "rb") as f:
                lines = f.readlines()
            
            i = 0
            while i < len(lines):
                line = lines[i].decode(encoding="utf-8", errors="ignore")
                line_stripped = line.strip()
                
                # 查找 ----- pid xxx at xxx ----- 行
                if pid_line_pattern in line_stripped and line_stripped.startswith("-----"):
                    found_pid_section = True
                    pid_header_line = line_stripped
                    i += 1
                    continue
                
                # 在 pid 段落中查找 main 线程
                if found_pid_section:
                    if line_stripped.startswith('"main"') and "prio=" in line_stripped:
                        found_main_thread = True
                        main_thread_lines.append(line.rstrip())
                        i += 1
                        # 收集 main 线程的所有行
                        while i < len(lines):
                            next_line = lines[i].decode(encoding="utf-8", errors="ignore")
                            next_stripped = next_line.strip()
                            main_thread_lines.append(next_line.rstrip())
                            # 检测线程结束
                            if next_stripped.startswith("DumpLatencyMs:"):
                                break
                            # 检测下一个线程开始
                            if next_stripped.startswith('"') and "prio=" in next_stripped:
                                main_thread_lines.pop()  # 移除下一个线程的行
                                break
                            i += 1
                        break
                    # 检测 pid 段落结束
                    if line_stripped.startswith("----- end") or (line_stripped.startswith("-----") and "pid" in line_stripped and pid_line_pattern not in line_stripped):
                        break
                
                i += 1
            
            # 设置结果 - 简化 pid 行格式以匹配原始 exe
            if pid_header_line:
                # 原始格式可能是: "----- Waiting Channels: pid 22514 at 2025-10-21 10:52:32.968134002+0800 -----"
                # 需要简化为: "----- pid 22514 at 2025-10-21 10:52:32 -----"
                simplified_header = pid_header_line
                # 移除 "Waiting Channels: " 前缀
                simplified_header = re.sub(r'-----\s*Waiting Channels:\s*', '----- ', simplified_header)
                # 简化时间戳（移除毫秒和时区）
                simplified_header = re.sub(r'(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})\.\d+[+-]\d+', r'\1', simplified_header)
                simplified_header = re.sub(r'(\d{4}-\d{2}-\d{2}\s+\d{2}:\d{2}:\d{2})\.\d+', r'\1', simplified_header)
                result["Thread_Dump_Header"] = simplified_header
            
            if found_main_thread and main_thread_lines:
                result["Thread_Dump"] = main_thread_lines
            else:
                # 没有找到 main 线程的完整 dump
                result["Thread_Dump_Error"] = "2No matched time trace print in SWT_JBT_TRACES!!!"
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def get_version():
        """获取版本号"""
        return "1.0.8"
    
    @staticmethod
    def _parse_ee_exp_main(lines, result):
        """解析 EE (External Exception) 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            backtrace_lines = []
            exp_type = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 Exception Type
                if line_stripped.startswith("Exception Type:"):
                    exp_type = line_stripped.split(":")[-1].strip()
                
                # 解析 md1 信息（modem 类型）
                if line_stripped.startswith("md1:"):
                    backtrace_lines.append(line_stripped)
                
                # 解析 [Others] 行（modem 类型）
                if line_stripped.startswith("[Others]"):
                    backtrace_lines.append(line_stripped)
                
                # 解析 MD: 和 AP: 行（modem 类型）
                if line_stripped.startswith("MD:") or line_stripped.startswith("AP:"):
                    backtrace_lines.append(line_stripped)
                
                # 解析 combo 类型的 ASSERT 信息
                if line_stripped.startswith(";") and "ASSERT" in line_stripped:
                    backtrace_lines.append(line_stripped)
                
                # 解析 combo 类型的其他信息
                if line_stripped.startswith(";") and ("exp_main:" in line_stripped or "sp=" in line_stripped):
                    backtrace_lines.append(line_stripped)
            
            if build_info:
                result["Build Info"] = [build_info]
            
            if backtrace_lines:
                result["Backtrace"] = "\n".join(backtrace_lines)
            elif exp_type:
                # 如果没有找到堆栈信息，使用 exp_type 作为 Backtrace
                result["Backtrace"] = exp_type
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_kernel_api_exp_main(lines, result):
        """解析 KernelAPI 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            backtrace_lines = []
            in_backtrace = False
            detail_info = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 Detail Info
                if line_stripped.startswith("Detail Info:"):
                    # 下一行是详细信息
                    if i + 1 < len(lines):
                        detail_info = lines[i + 1].strip()
                
                # 解析 Backtrace
                if line_stripped.startswith("Backtrace:"):
                    in_backtrace = True
                    continue
                
                if in_backtrace:
                    if line_stripped.startswith("$**") or line_stripped.startswith("Suspect:"):
                        in_backtrace = False
                        continue
                    if line_stripped.startswith("[<"):
                        backtrace_lines.append(line_stripped)
            
            if build_info:
                result["Build Info"] = [build_info]
            
            bt_content = []
            if detail_info:
                bt_content.append(detail_info)
            if backtrace_lines:
                bt_content.extend(backtrace_lines)
            
            if bt_content:
                result["Backtrace"] = "\n".join(bt_content)
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_system_api_exp_main(lines, result):
        """解析 SystemAPI 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            backtrace_lines = []
            in_backtrace = False
            process_info = None
            crdispatch_key = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 Process
                if line_stripped.startswith("Process:"):
                    process_info = line_stripped.split("Process:")[1].strip()
                
                # 解析 CRDISPATCH_KEY
                if line_stripped.startswith("CRDISPATCH_KEY:"):
                    crdispatch_key = line_stripped
                
                # 解析 Backtrace
                if line_stripped.startswith("Backtrace:"):
                    in_backtrace = True
                    continue
                
                if in_backtrace:
                    if line_stripped.startswith("$**"):
                        in_backtrace = False
                        continue
                    if line_stripped.startswith("#") or line_stripped.startswith("pid("):
                        backtrace_lines.append(line_stripped)
            
            if build_info:
                result["Build Info"] = [build_info]
            
            bt_content = []
            if process_info:
                bt_content.append(f"Process: {process_info}")
            if crdispatch_key:
                bt_content.append(crdispatch_key)
            if backtrace_lines:
                bt_content.extend(backtrace_lines)
            
            if bt_content:
                result["Backtrace"] = "\n".join(bt_content)
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_ke_exp_main(lines, result):
        """解析 KE (Kernel Exception) 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            backtrace_lines = []
            in_backtrace = False
            pc_info = None
            lr_info = None
            process_info = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 PC is at
                if line_stripped.startswith("PC is at"):
                    pc_info = line_stripped
                
                # 解析 LR is at
                if line_stripped.startswith("LR is at"):
                    lr_info = line_stripped
                
                # 解析 Current Executing Process
                if line_stripped.startswith("Current Executing Process:"):
                    # 下一行是进程信息
                    if i + 1 < len(lines):
                        next_line = lines[i + 1].strip()
                        if next_line.startswith("cpu:"):
                            process_info = next_line
                            if i + 2 < len(lines):
                                process_info += "\n" + lines[i + 2].strip()
                
                # 解析 Backtrace
                if line_stripped.startswith("Backtrace:"):
                    in_backtrace = True
                    continue
                
                if in_backtrace:
                    if line_stripped.startswith("$**") or line_stripped == "":
                        if backtrace_lines:
                            in_backtrace = False
                        continue
                    if line_stripped.startswith("[<"):
                        backtrace_lines.append(line_stripped)
            
            if build_info:
                result["Build Info"] = [build_info]
            
            bt_content = []
            if pc_info:
                bt_content.append(pc_info)
            if lr_info:
                bt_content.append(lr_info)
            if process_info:
                bt_content.append(process_info)
            if backtrace_lines:
                bt_content.extend(backtrace_lines)
            
            if bt_content:
                result["Backtrace"] = "\n".join(bt_content)
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_swt_exp_main(lines, result):
        """解析 SWT (System Watchdog Timeout) 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            pid_value = None
            process_name = None
            subject = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 Current Executing Process
                if line_stripped.startswith("Current Executing Process:"):
                    if i + 1 < len(lines):
                        next_line = lines[i + 1].strip()
                        if next_line and not next_line.startswith("$**"):
                            process_name = next_line
                            result["Current Executing Process"] = [process_name]
                
                # 解析 pid
                if "pid:" in line_stripped:
                    match = re.search(r'pid:(\d+)', line_stripped)
                    if match:
                        pid_value = match.group(1)
                        result["pid"] = [pid_value]
                
                # 解析 Subject
                if line_stripped.startswith("Subject:"):
                    subject = line_stripped.split("Subject:")[1].strip()
            
            if build_info:
                result["Build Info"] = [build_info]
            
            if subject:
                result["Backtrace"] = f"Subject: {subject}"
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_hang_exp_main(lines, result):
        """解析 HANG_DETECT 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
            
            if build_info:
                result["Build Info"] = [build_info]
            
            result["Backtrace"] = "HANG_DETECT"
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_ocp_exp_main(lines, result):
        """解析 OCP reboot 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            crdispatch_key = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 CRDISPATCH_KEY
                if line_stripped.startswith("CRDISPATCH_KEY:"):
                    crdispatch_key = line_stripped
            
            if build_info:
                result["Build Info"] = [build_info]
            
            if crdispatch_key:
                result["Backtrace"] = crdispatch_key
            else:
                result["Backtrace"] = "OCP reboot"
                
        except Exception:
            pass
        
        return result
    
    @staticmethod
    def _parse_hw_reboot_exp_main(lines, result):
        """解析 Hardware Reboot 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            wdt_info = []
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
                
                # 解析 WDT status
                if line_stripped.startswith("WDT status:"):
                    wdt_info.append(line_stripped)
                
                # 解析 kick 信息
                if line_stripped.startswith("kick="):
                    wdt_info.append(line_stripped)
            
            if build_info:
                result["Build Info"] = [build_info]
            
            if wdt_info:
                result["Backtrace"] = "\n".join(wdt_info)
            else:
                result["Backtrace"] = "Hardware Reboot"
                
        except Exception:
            pass
        
        return result

    @staticmethod
    def _parse_hwt_exp_main(lines, result):
        """解析 HWT (Hardware Watchdog Timeout) 类型的 __exp_main.txt 文件"""
        try:
            build_info = None
            
            for i, line in enumerate(lines):
                line_stripped = line.strip()
                
                # 解析 Build Info
                if line_stripped.startswith("Build Info:"):
                    build_str = line_stripped.split("Build Info:")[1].strip().strip("'")
                    build_info = build_str
            
            if build_info:
                result["Build Info"] = [build_info]
            
            # HWT 类型通常没有详细的堆栈信息
            result["Backtrace"] = "HWT"
                
        except Exception:
            pass
        
        return result
