# -*- coding: utf-8 -*-
# @Time     : 2020/10/14 15:28
# @Author   : yunqing.gui
# @Email    : yunqing.gui@transsion.com
# @File     : path.py

import os
import sys


class Path(object):

    def __init__(self):
        super(Path, self).__init__()

    @property
    def project_folder(self):
        if sys.argv[0].endswith(".py") or sys.argv[0].endswith(".pyc"):
            # 如果执行的是 py或 pyc文件, 表示执行对象未打包
            common_folder = os.path.dirname(os.path.abspath(__file__))
            modules_folder = os.path.dirname(common_folder)
            return os.path.dirname(modules_folder)
        else:
            # 如果执行的是非py文件, 表示执行对象已打包, 则返回打包文件目录的绝对路径
            return os.path.dirname(os.path.abspath(sys.argv[0]))

    @property
    def configs_folder(self):
        configs_folder = self.project_folder + os.sep + "configs"
        if not os.path.isdir(configs_folder):
            raise Exception("folder:{} is not exist!".format(configs_folder))
        return os.path.abspath(configs_folder)

    @property
    def tools_folder(self):
        tools_folder = self.project_folder + os.sep + "tools"
        if not os.path.isdir(tools_folder):
            raise Exception("folder:{} is not exist!".format(tools_folder))
        return os.path.abspath(tools_folder)

    @property
    def log_folder(self):
        log_folder = self.project_folder + os.sep + "log"
        if not os.path.isdir(log_folder):
            try:
                os.makedirs(log_folder)
            except:
                pass
        return os.path.abspath(log_folder)

    @property
    def tmp_folder(self):
        tmp_folder = self.project_folder + os.sep + "tmp"
        if not os.path.isdir(tmp_folder):
            try:
                os.makedirs(tmp_folder)
            except:
                pass
        return os.path.abspath(tmp_folder)

    @property
    def result_folder(self):
        result_folder = self.project_folder + os.sep + "result"
        if not os.path.isdir(result_folder):
            try:
                os.makedirs(result_folder)
            except:
                pass
        return os.path.abspath(result_folder)

    @property
    def version_folder(self):
        version_folder = self.project_folder + os.sep + "version"
        if not os.path.isdir(version_folder):
            try:
                os.makedirs(version_folder)
            except:
                pass
        return os.path.abspath(version_folder)


PathManager = Path()


if __name__ == '__main__':
    print(PathManager.project_folder)
    print(PathManager.configs_folder)
    print(PathManager.tools_folder)
    print(PathManager.log_folder)
    print(PathManager.tmp_folder)
    print(PathManager.result_folder)
