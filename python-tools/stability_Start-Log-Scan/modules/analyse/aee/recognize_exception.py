# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\recognize_exception.py
import traceback
from recognize_except import recognizeexception
from modules.common.GlobalAttrs import RECOGNIZE_LIB_VERSION
from modules.common.Logger import TEST_LOGGER

def recognize_except(aee_dir, aee_dir_name=None):
    """
    调用 recognizeexception 库方法，解析detail信息
    :param aee_dir:
    :param aee_dir_name:
    :return:
    """
    recognize_except_list = [
     (f"{RECOGNIZE_LIB_VERSION}")]
    TEST_LOGGER.info(f"开始调用 recognizeexception 库方法，解析detail信息，解析目录：{aee_dir}", tag=aee_dir_name)
    try:
        exception_report = recognizeexception.recognizeExcept(aee_dir)
    except:
        TEST_LOGGER.error(f"调用 recognizeexception 库方法，解析detail信息失败，解析目录：\n{aee_dir}，\n异常信息：\n{traceback.format_exc()}", tag=aee_dir_name)
        raise Exception("RecognizeException")

    # 获取异常类型
    exception_class = exception_report.get("Exception_Class", "ANR")
    
    build_info = exception_report.get("Build Info")
    if build_info:
        recognize_except_list.append(f"手机版本：{build_info}")
    
    package = exception_report.get("Package")
    if package:
        recognize_except_list.append(f"异常包名：{package}")
    
    # ANR/JE/SWT 类型输出异常进程，NE/EE/KE 等类型不输出
    current_executing_process = exception_report.get("Current Executing Process")
    blocked_threads = exception_report.get("Blocked Threads")
    if current_executing_process and blocked_threads:
        recognize_except_list.append(f"异常进程：{current_executing_process}")
    
    pid = exception_report.get("pid")
    if pid:
        recognize_except_list.append(f"pid：{pid}")
    
    # ANR 类型特有的输出
    if exception_class == "ANR":
        cpu_info = exception_report.get("CPU info")
        if cpu_info:
            recognize_except_list.append(f"CPU info：{cpu_info}")
        
        subject = exception_report.get("Subject")
        if subject:
            recognize_except_list.append(f"Subject：{subject}")
        
        blocked_threads = exception_report.get("Blocked Threads")
        if blocked_threads:
            recognize_except_list.append(f"Blocked Threads：{blocked_threads}")
    
    # Backtrace 部分
    backtrace = exception_report.get("Backtrace")
    backtrace_log = exception_report.get("Backtrace_Log")
    
    # JE/NE/EE/KE/SWT/KernelAPI/SystemAPI/HANG/OCP/HW_Reboot/HWT 类型直接输出 Backtrace
    if exception_class in ("JE", "NE", "EE", "KE", "SWT", "KernelAPI", "SystemAPI", "HANG", "OCP", "HW_Reboot", "HWT"):
        if backtrace:
            recognize_except_list.append("Backtrace：")
            recognize_except_list.append(backtrace)
    else:
        # ANR 类型
        if backtrace or backtrace_log:
            recognize_except_list.append("Backtrace：")
            if backtrace_log:
                recognize_except_list.append(backtrace_log)
            if backtrace:
                if type(backtrace) == str:
                    recognize_except_list.append(backtrace)
                elif type(backtrace) == list:
                    backtrace = backtrace[0]
                    recognize_except_list.append(f"{backtrace}")
        
        # ANR 类型特有：IOW 警告
        iow_warning = exception_report.get("IOW_Warning")
        if iow_warning:
            recognize_except_list.append(iow_warning)
        
        # ANR 类型特有：线程 dump 头部
        thread_dump_header = exception_report.get("Thread_Dump_Header")
        if thread_dump_header:
            recognize_except_list.append(thread_dump_header)
            recognize_except_list.append("The blocked thread:main")
            recognize_except_list.append("")
        
        # ANR 类型特有：线程 dump 内容
        thread_dump = exception_report.get("Thread_Dump")
        if thread_dump:
            for line in thread_dump:
                recognize_except_list.append(line)
        
        # ANR 类型特有：线程 dump 错误消息
        thread_dump_error = exception_report.get("Thread_Dump_Error")
        if thread_dump_error:
            recognize_except_list.append(thread_dump_error)
    
    return recognize_except_list


if __name__ == "__main__":
    try:
        recognize_except_list = recognize_except("\\\\10.150.152.36\\fans_log\\fans\\X6526\\2024-01-10\\azure\\X6526-V658ADEFGHIJ-TGo-OP-231227V1486Fans\\109834038S000027\\db.59.ANR.WedJan10023005WAT2024.dbg.DEC")
        print("\n".join(recognize_except_list))
    except Exception as e:
        try:
            if str(e) == "RecognizeException":
                print("xxxxxxxxxxxx")
        finally:
            e = None
            del e

# okay decompiling extracted_pyz_modules\modules\analyse\aee\recognize_exception.pyc
