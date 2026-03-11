# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\tfa_debug_buf.py
import os
from modules.common.Logger import TEST_LOGGER

class TfaDebugBuf(object):

    def __init__(self, file_path):
        super(TfaDebugBuf, self).__init__()
        self._TfaDebugBuf__file_path = file_path

    def analyse_tne0d(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._TfaDebugBuf__file_path))
        TEST_LOGGER.debug(f"开始解析TFA_DEBUG_BUF文件：{self._TfaDebugBuf__file_path}", tag=tne_dir_name)
        vlpcfg_disble_info_list = []
        with open((self._TfaDebugBuf__file_path), errors="ignore", encoding="utf-8") as f:
            last_vlpcfg_line_index = -1
            line_index = 0
            for line in f.readlines():
                line = line.strip()
                if "VLPCFG Disble" in line:
                    last_vlpcfg_line_index = line_index
                line_index += 1

            if last_vlpcfg_line_index >= 0:
                f.seek(0)
                for line in f.readlines()[last_vlpcfg_line_index[:last_vlpcfg_line_index + 4]]:
                    line = line.strip()
                    vlpcfg_disble_info_list.append(line)

        return vlpcfg_disble_info_list

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\tfa_debug_buf.pyc
