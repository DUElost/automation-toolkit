# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\db_file_map.py
import os.path, re

class DbFileMap(object):

    def __init__(self, exception_info_str, file_path, win_path):
        super(DbFileMap, self).__init__()
        self._DbFileMap__exception_info_str = exception_info_str
        self._DbFileMap__file_path = file_path
        self._DbFileMap__win_path = win_path
        self._DbFileMap__exp_class = None
        self._DbFileMap__exp_type = None
        self._DbFileMap__cur_process = None
        self._DbFileMap__exp_time = None
        self._DbFileMap__analyse()

    def __analyse(self):
        regex_time = re.compile("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}")
        exception_info_list = self._DbFileMap__exception_info_str.split(",")
        self._DbFileMap__exp_class = exception_info_list[0]
        self._DbFileMap__exp_type = exception_info_list[6]
        if self._DbFileMap__exp_class == "Externel (EE)":
            if "scp" in self._DbFileMap__exception_info_str.lower():
                self._DbFileMap__cur_process = "scp"
            else:
                if "comb" in self._DbFileMap__exception_info_str.lower():
                    self._DbFileMap__cur_process = "combo"
                else:
                    self._DbFileMap__cur_process = "modem"
        else:
            if self._DbFileMap__exp_class == "System API Dump":
                self._DbFileMap__exp_type = "system_api_dump"
                self._DbFileMap__cur_process = "SYSTEM_API_DUMP"
            else:
                self._DbFileMap__cur_process = exception_info_list[7]
                if self._DbFileMap__cur_process.startswith("KE at"):
                    self._DbFileMap__cur_process = "PROCESS_KE"
                if ":" in self._DbFileMap__cur_process:
                    self._DbFileMap__cur_process = self._DbFileMap__cur_process.split(":")[0]
        regex_rlt = re.search(regex_time, self._DbFileMap__exception_info_str)
        if regex_rlt:
            self._DbFileMap__exp_time = regex_rlt.group(0)
        if not self._DbFileMap__exp_class or self._DbFileMap__exp_class == "":
            self._DbFileMap__exp_class = "CLASS_UNKNOWN"
        if not self._DbFileMap__exp_type or self._DbFileMap__exp_type == "":
            self._DbFileMap__exp_type = "TYPE_UNKNOWN"
        if not self._DbFileMap__cur_process or self._DbFileMap__cur_process == "":
            self._DbFileMap__cur_process = "PROCESS_UNKNOWN"
        if not self._DbFileMap__exp_time or self._DbFileMap__exp_time == "":
            self._DbFileMap__exp_time = "TIME_UNKNOWN"

    @property
    def file_path(self):
        return self._DbFileMap__file_path

    @property
    def win_path(self):
        return self._DbFileMap__win_path

    @property
    def exp_class(self):
        return self._DbFileMap__exp_class

    @property
    def exp_type(self):
        return self._DbFileMap__exp_type

    @property
    def cur_process(self):
        return self._DbFileMap__cur_process

    @property
    def exp_time(self):
        return self._DbFileMap__exp_time


if __name__ == "__main__":
    with open("E:\\yunqing.gui\\Desktop\\DBFileMap.txt", "r", encoding="utf-8", errors="ignore") as db_file_map:
        for line in db_file_map.readlines():
            split_line = line.split("ZZ_INTERNAL")
            if len(split_line) < 2:
                continue
            exception_info_str = split_line[-1].strip()
            print(exception_info_str)
            db_file_map = DbFileMap(exception_info_str, "xxx", "dddd")

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\db_file_map.pyc
