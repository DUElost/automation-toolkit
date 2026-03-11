# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\binder_state.py
import re, traceback
from modules.common.Logger import TEST_LOGGER

class BinderState(object):

    def __init__(self, file_path):
        super(BinderState, self).__init__()
        self._BinderState__file_path = file_path

    def get_outgoing_id(self, pid, sys_tid):
        regex_key = re.compile("outgoing transaction .* from {}:{}".format(pid, sys_tid) + " to (\\d+):(\\d+)")
        to_pid = None
        to_tid = None
        with open((self._BinderState__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                regex_rlt = re.search(regex_key, line)
                if regex_rlt:
                    to_pid = regex_rlt.group(1)
                    to_tid = regex_rlt.group(2)

        return (
         to_pid, to_tid)

    def get_0x31_pid_value(self, code_key, code_value):
        pid_value, code_line = (None, None)
        try:
            code_value_0x = str(hex(int(code_value)))
        except:
            TEST_LOGGER.error(f"转换 code_value: {code_value} 时发生异常：\n{traceback.format_exc()}")
            code_value_0x = code_value

        if code_value_0x.startswith("0x"):
            code_value_0x = code_value_0x[2:]
        code_value_tag = f"code {code_value}"
        code_value_tag_0x = f"code {code_value_0x}"
        regex_pid = re.compile("to\\s+(\\d+):(.*?)\\s+code")
        with open((self._BinderState__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if not code_key in line or code_value_tag in line or code_value_tag_0x in line:
                    regex_rlt = re.search(regex_pid, line)
                    if regex_rlt:
                        pid_value = str(regex_rlt.group(2))
                        code_line = line

        return (
         pid_value, code_line)

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\binder_state.pyc
