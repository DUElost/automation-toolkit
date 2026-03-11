# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\common\Path.py
import os, sys

class PATH:

    @property
    def project_folder(self):
        if sys.argv[0].endswith(".py") or sys.argv[0].endswith(".pyc"):
            modules_folder = os.path.dirname(os.path.abspath(__file__))
            modules_folder = os.path.dirname(modules_folder)
            return os.path.dirname(modules_folder)
        return os.path.dirname(os.path.abspath(sys.argv[0]))

    @property
    def log_folder(self):
        return os.path.join(self.project_folder, "logs")

    @property
    def result_folder(self):
        return os.path.join(self.project_folder, "result")

    @property
    def merge_rlt_folder(self):
        return os.path.join(self.project_folder, "merge_result")

    @property
    def tools_folder(self):
        return os.path.join(self.project_folder, "tools")

    @property
    def config_folder(self):
        return os.path.join(self.project_folder, "config")

    @property
    def tmp_folder(self):
        return os.path.join(self.project_folder, "tmp")


PathManager = PATH()

# okay decompiling extracted_pyz_modules\modules\common\Path.pyc
