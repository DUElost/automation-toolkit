# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\aee\files\dumpsys_display.py
import os

class DumpsysDisplay(object):

    def __init__(self, file_path):
        super(DumpsysDisplay, self).__init__()
        self._DumpsysDisplay__file_path = file_path
        self._DumpsysDisplay__aee_dir = os.path.dirname(file_path)
        self._DumpsysDisplay__aee_dir_name = os.path.basename(self._DumpsysDisplay__aee_dir)

    def is_screen_on(self):
        is_screen_on = True
        with open((self._DumpsysDisplay__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "mScreenState=" in line:
                    screen_state_str = line.split("=")[1]
                    if screen_state_str.lower() == "on":
                        is_screen_on = True
                    else:
                        is_screen_on = False
                    break

        return is_screen_on

# okay decompiling extracted_pyz_modules\modules\analyse\aee\files\dumpsys_display.pyc
