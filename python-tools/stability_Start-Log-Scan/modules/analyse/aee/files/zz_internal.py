# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\zz_internal.py
import os.path, re

class ZZ_internal(object):

    def __init__(self, file_path, dbg_file, converted_dbg_file):
        super(ZZ_internal, self).__init__()
        self._ZZ_internal__file_path = file_path
        self._ZZ_internal__dbg_path = dbg_file
        self._ZZ_internal__win_path = converted_dbg_file
        self._ZZ_internal__exp_class = None
        self._ZZ_internal__exp_type = None
        self._ZZ_internal__cur_process = None
        self._ZZ_internal__exp_time = None
        self._ZZ_internal__ota_ke = False
        self._ZZ_internal__analyse()

    def __analyse(self):
        regex_time = re.compile("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")
        if os.path.isfile(self._ZZ_internal__file_path):
            with open((self._ZZ_internal__file_path), "r", encoding="utf-8", errors="ignore") as f:
                try:
                    zz_internal = f.read().strip()
                    zz_internal_split_list = zz_internal.split(",")
                    self._ZZ_internal__exp_class = zz_internal_split_list[0]
                    self._ZZ_internal__exp_type = zz_internal_split_list[6]
                    if self._ZZ_internal__exp_class == "Externel (EE)":
                        if "scp" in zz_internal.lower():
                            self._ZZ_internal__cur_process = "scp"
                        else:
                            if "comb" in zz_internal.lower():
                                self._ZZ_internal__cur_process = "combo"
                            else:
                                self._ZZ_internal__cur_process = "modem"
                    else:
                        if self._ZZ_internal__exp_class == "System API Dump":
                            self._ZZ_internal__exp_type = "system_api_dump"
                            self._ZZ_internal__cur_process = "SYSTEM_API_DUMP"
                        else:
                            self._ZZ_internal__cur_process = zz_internal_split_list[7]
                            if self._ZZ_internal__cur_process.startswith("KE at"):
                                self._ZZ_internal__cur_process = "PROCESS_KE"
                            if ":" in self._ZZ_internal__cur_process:
                                self._ZZ_internal__cur_process = self._ZZ_internal__cur_process.split(":")[0]
                            elif self._ZZ_internal__exp_class == "Kernel (KE)" and "ipanic+0x7c/0xa4" in zz_internal:
                                self._ZZ_internal__ota_ke = True
                            regex_rlt = re.search(regex_time, zz_internal)
                            if regex_rlt:
                                self._ZZ_internal__exp_time = regex_rlt.group(0)
                except:
                    pass

        if not self._ZZ_internal__exp_class or self._ZZ_internal__exp_class == "":
            self._ZZ_internal__exp_class = "CLASS_UNKNOWN"
        if not self._ZZ_internal__exp_type or self._ZZ_internal__exp_type == "":
            self._ZZ_internal__exp_type = "TYPE_UNKNOWN"
        if not self._ZZ_internal__cur_process or self._ZZ_internal__cur_process == "":
            self._ZZ_internal__cur_process = "PROCESS_UNKNOWN"
        if not self._ZZ_internal__exp_time or self._ZZ_internal__exp_time == "":
            self._ZZ_internal__exp_time = "TIME_UNKNOWN"

    @property
    def file_path(self):
        return self._ZZ_internal__file_path

    @property
    def dbg_path(self):
        return self._ZZ_internal__dbg_path

    @property
    def win_path(self):
        return self._ZZ_internal__win_path

    @property
    def exp_class(self):
        return self._ZZ_internal__exp_class

    @property
    def exp_type(self):
        return self._ZZ_internal__exp_type

    @property
    def cur_process(self):
        return self._ZZ_internal__cur_process

    @property
    def exp_time(self):
        return self._ZZ_internal__exp_time

    @property
    def ota_ke(self):
        return self._ZZ_internal__ota_ke

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\zz_internal.pyc
