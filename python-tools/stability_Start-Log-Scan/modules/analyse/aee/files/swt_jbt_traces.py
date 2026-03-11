# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\swt_jbt_traces.py
import os, re
from modules.common.Logger import TEST_LOGGER

class SwtJbtTraces(object):

    def __init__(self, file_path):
        super(SwtJbtTraces, self).__init__()
        self._SwtJbtTraces__file_path = file_path
        self._SwtJbtTraces__aee_dir = os.path.dirname(file_path)
        self._SwtJbtTraces__aee_dir_name = os.path.basename(self._SwtJbtTraces__aee_dir)

    def get_anr_detail(self, pid):
        tmp_sign = 0
        anr_detail_list = []
        anr_start_line = "pid {} at".format(pid)
        TEST_LOGGER.debug(("开始在 SWT_JBT_TRACES 中获取pid：{} 对应的anr详细信息".format(pid)), tag=(self._SwtJbtTraces__aee_dir_name))
        anr_native_count_native = 0
        anr_native_count_at = 0
        with open(self._SwtJbtTraces__file_path, "rb") as f:
            for line in f:
                line = line.decode(encoding="utf-8", errors="ignore").strip()
                if anr_start_line in line:
                    tmp_sign = 1
                if '"main"' in line:
                    if tmp_sign == 1:
                        tmp_sign = 2
                    elif "native" in line:
                        if tmp_sign == 2 and anr_native_count_native < 3:
                            anr_detail_list.append(line)
                            anr_native_count_native = anr_native_count_native + 1
                    if "at " in line and tmp_sign == 2 and anr_native_count_at < 3:
                        anr_detail_list.append(line)
                        anr_native_count_at = anr_native_count_at + 1

        return anr_detail_list

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\swt_jbt_traces.pyc
