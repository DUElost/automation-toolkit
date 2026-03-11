# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\android_main_log.py
import os, re
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import ignore_num_hex_string

class AndroidMainLog(object):
    REGEX_TIME = re.compile("\\d\\d-\\d\\d\\s+\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d")
    REGEX_PKG = re.compile("Pkg=\\'([^\\']*)\\'")
    REGEX_TABE_IDENTITY = re.compile("\\d+\\s+\\d+\\s+I\\s+TABE.CrashHandler:")

    def __init__(self, file_path):
        super(AndroidMainLog, self).__init__()
        self._AndroidMainLog__file_path = file_path
        self._AndroidMainLog__tne_dir_name = None

    def _common_analyse(self):
        self._AndroidMainLog__tne_dir_name = os.path.basename(os.path.dirname(self._AndroidMainLog__file_path))
        TEST_LOGGER.debug(("开始解析android_main_log文件：{}".format(self._AndroidMainLog__file_path)), tag=(self._AndroidMainLog__tne_dir_name))

    def analyse_tne07(self):
        self._common_analyse()
        last_crash_time, last_crash_detail, pkg = (None, None, None)
        crash_identity, pkg = (None, None)
        tabe_start = False
        with open((self._AndroidMainLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if tabe_start:
                    if crash_identity:
                        if crash_identity in line:
                            if not pkg:
                                regex_pkg_rlt = re.search(AndroidMainLog.REGEX_PKG, line)
                                if regex_pkg_rlt:
                                    pkg = regex_pkg_rlt.group(1)
                            last_crash_detail = last_crash_detail + "\n" + ignore_num_hex_string(line.split(crash_identity)[1].strip())
                        else:
                            tabe_start = False
                            crash_identity = None
                    elif "TABE.CrashHandler" in line:
                        re_rlt_time = re.match(AndroidMainLog.REGEX_TIME, line)
                        re_rlt_identity = re.search(AndroidMainLog.REGEX_TABE_IDENTITY, line)
                        if re_rlt_time:
                            if re_rlt_identity:
                                last_crash_time = re_rlt_time.group()
                                crash_identity = re_rlt_identity.group()
                                last_crash_detail = ignore_num_hex_string(line.split(crash_identity)[1].strip())
                                regex_pkg_rlt = re.search(AndroidMainLog.REGEX_PKG, line)
                                if regex_pkg_rlt:
                                    pkg = regex_pkg_rlt.group(1)
                            tabe_start = True

        return (
         last_crash_time, last_crash_detail, pkg)

    def analyse_anr(self):
        """
        modified 20230619_1712, 解析tne13 anr问题
        :return:
        """
        self._common_analyse()
        last_crash_time, pkg = (None, None)
        crash_identity, pkg = (None, None)
        tabe_start = False
        with open((self._AndroidMainLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if tabe_start:
                    if crash_identity and crash_identity in line:
                        if not pkg:
                            regex_pkg_rlt = re.search(AndroidMainLog.REGEX_PKG, line)
                            if regex_pkg_rlt:
                                pkg = regex_pkg_rlt.group(1)
                        else:
                            tabe_start = False
                            crash_identity = None
                    elif "TABE.CrashHandler" in line and "EType='anr'" in line:
                        re_rlt_time = re.match(AndroidMainLog.REGEX_TIME, line)
                        re_rlt_identity = re.search(AndroidMainLog.REGEX_TABE_IDENTITY, line)
                        if re_rlt_time:
                            if re_rlt_identity:
                                last_crash_time = re_rlt_time.group()
                                crash_identity = re_rlt_identity.group()
                                regex_pkg_rlt = re.search(AndroidMainLog.REGEX_PKG, line)
                                if regex_pkg_rlt:
                                    pkg = regex_pkg_rlt.group(1)
                            tabe_start = True

        return (
         last_crash_time, pkg)

    def analyse_daemon_crash(self):
        self._common_analyse()
        last_app_entity_line = None
        with open((self._AndroidMainLog__file_path), errors="ignore", encoding="utf-8") as f:
            for line in f.readlines():
                if "TABE.AppAprController: AppAprEntity" in line and "mIsNativeProcess='true'" in line:
                    last_app_entity_line = line.strip()

        last_crash_time, last_crash_detail, pkg, build_version = (None, None, None,
                                                                  None)
        if last_app_entity_line:
            last_app_entity_line = last_app_entity_line[(last_app_entity_line.index("AppAprEntity{") + len("AppAprEntity{"))[:None]]
            last_app_entity_line = last_app_entity_line[:last_app_entity_line.index("}")]
            regex_package = re.compile("mPkgName='(.*?)'")
            pkg = re.search(regex_package, last_app_entity_line).group(1)
            regex_build_version = re.compile("mDeviceRom='(.*?)'")
            build_version = re.search(regex_build_version, last_app_entity_line).group(1)
            regex_crash_time = re.compile("mExpTime='(.*?)'")
            last_crash_time = re.search(regex_crash_time, last_app_entity_line).group(1)
            regex_crash_detail = re.compile("mExpSummary='(.*?)'")
            last_crash_detail = re.search(regex_crash_detail, last_app_entity_line).group(1)
        TEST_LOGGER.info(f"获取到的最后一次崩溃信息: {last_crash_time}, {last_crash_detail}, {pkg}, {build_version}")
        return (last_crash_time, last_crash_detail, pkg, build_version)


if __name__ == "__main__":
    android_main_log = AndroidMainLog("D:\\Logs\\daemonCrash\\data\\TNE\\0x007a0054_2024_03_26_13_56_16_9\\android_main_log")
    android_main_log.analyse_daemon_crash()

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\android_main_log.pyc
