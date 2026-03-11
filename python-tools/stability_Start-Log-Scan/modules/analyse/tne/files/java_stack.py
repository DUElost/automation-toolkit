# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\java_stack.py
import re

class JavaStack(object):

    def __init__(self, file_path):
        super(JavaStack, self).__init__()
        self._JavaStack__file_path = file_path

    def get_pid(self):
        pid_list = []
        regex_pid = re.compile("- pid (\\d+) at")
        with open((self._JavaStack__file_path), "r", encoding="utf-8", errors="ignore") as f:
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
        with open((self._JavaStack__file_path), "r", encoding="utf-8", errors="ignore") as f:
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


if __name__ == "__main__":
    java_stack = JavaStack("\\\\10.150.152.36\\fans_log\\StabilityFreeze\\AE10\\2024-05-05\\aliyun\\AE10-H833A-U-OP-240417V2166Fans\\7b96f6973755ac78ea597d6f45636b6c778f53194888690058d65d9352c3fcc9\\data\\TNE\\0xffffff32_2024_05_01_23_55_08_58\\java_stack")
    stack_info_list = java_stack.get_stack_info("2303")
    for stack_info in stack_info_list:
        print(stack_info)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\java_stack.pyc
