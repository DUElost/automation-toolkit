# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\native_stack.py
import re

class NativeStack(object):

    def __init__(self, file_path):
        super(NativeStack, self).__init__()
        self._NativeStack__file_path = file_path

    def get_pid(self):
        pid_list = []
        regex_pid = re.compile("- pid (\\d+) at")
        with open((self._NativeStack__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                regex_rlt = re.search(regex_pid, line)
                if regex_rlt:
                    pid_list.append(regex_rlt.group(1))

        return pid_list

    def get_stack_info(self, pid):
        cmdline_value = None
        stack_info_list = []
        stack_start_tag = f"sysTid={pid}"
        find_target_systid = False
        with open((self._NativeStack__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "Cmd line:" in line:
                    cmdline_value = line
                if line.startswith('"'):
                    stack_info_list.clear()
                if stack_start_tag in line:
                    find_target_systid = True
                if line == "":
                    if find_target_systid:
                        break
                stack_info_list.append(line)

        stack_info_list.insert(0, cmdline_value)
        if not find_target_systid:
            stack_info_list.clear()
        return stack_info_list

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\native_stack.pyc
