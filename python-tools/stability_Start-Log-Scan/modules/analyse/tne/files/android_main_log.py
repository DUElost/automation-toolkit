# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\android_main_log.py
import datetime
import os
import re
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import ignore_num_hex_string

class AndroidMainLog(object):
    REGEX_TIME = re.compile("\\d\\d-\\d\\d\\s+\\d\\d:\\d\\d:\\d\\d.\\d\\d\\d")
    REGEX_PKG = re.compile("Pkg=\\'([^\\']*)\\'")
    REGEX_TABE_IDENTITY = re.compile("\\d+\\s+\\d+\\s+I\\s+TABE.CrashHandler:")
    REGEX_SYSTEM_BIHASH = re.compile("(\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}).*?Start TNE for.*?:(.*?), BIHash=(.*)")
    REGEX_APK_BIHASH = re.compile("(\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}\\.\\d{3}).*?BIHash = (.*?),")
    REGEX_PROC_NAME = re.compile("procName = (.*?),")
    REGEX_PKG_NAME = re.compile("pkgName = (.*?),")
    REGEX_TIME_ONLY = re.compile("(\\d{1,2}:\\d{1,2}:\\d{1,2}(?:\\.\\d+)?)")
    REGEX_DATE_TIME = re.compile("(\\d{1,2}-\\d{1,2}\\s+\\d{1,2}:\\d{1,2}:\\d{1,2}(?:\\.\\d+)?)")

    def __init__(self, file_path):
        super(AndroidMainLog, self).__init__()
        self._AndroidMainLog__file_path = file_path
        self._AndroidMainLog__tne_dir_name = None

    def _common_analyse(self):
        self._AndroidMainLog__tne_dir_name = os.path.basename(os.path.dirname(self._AndroidMainLog__file_path))
        TEST_LOGGER.debug(("开始解析android_main_log文件：{}".format(self._AndroidMainLog__file_path)), tag=(self._AndroidMainLog__tne_dir_name))

    def get_hash_value(self, target_hash_type, target_hash_time, target_hash_package):
        """
        从 SYS_ANDROID_LOG / main_log 中提取与异常最接近的 BIHash。
        :return: closest BIHash or None
        """
        hash_info_list = []
        closest_hash = None
        tne_dir_name = os.path.basename(os.path.dirname(self._AndroidMainLog__file_path))
        self._AndroidMainLog__tne_dir_name = tne_dir_name
        TEST_LOGGER.debug("开始获取[{}] 类型：{}，包名：{}，时间：{} 的hash信息".format(
            tne_dir_name, target_hash_type, target_hash_package, target_hash_time))
        if target_hash_package == "android_framework":
            target_hash_package = "android"
        # 逐行扫描，避免 readlines() 整文件进内存
        with open(self._AndroidMainLog__file_path, errors="ignore", encoding="utf-8") as f:
            for line in f:
                if "BIHash" not in line:
                    continue
                if "TranSuccCrashMgr:" in line:
                    matches = re.search(AndroidMainLog.REGEX_SYSTEM_BIHASH, line)
                    if matches:
                        package_name = matches.group(2)
                        hash_info_list.append(
                            [matches.group(1), "system", package_name, package_name, matches.group(3)])
                    continue
                if "TranSucc.CrashlyticsWork" not in line:
                    continue
                matches = re.search(AndroidMainLog.REGEX_APK_BIHASH, line)
                if not matches:
                    continue
                timestamp = matches.group(1)
                hash_value = matches.group(2)
                proc_match = re.search(AndroidMainLog.REGEX_PROC_NAME, line)
                proc_name = proc_match.group(1) if proc_match else "unknown"
                pkg_match = re.search(AndroidMainLog.REGEX_PKG_NAME, line)
                package_name = pkg_match.group(1) if pkg_match else "unknown"
                if package_name == "android_framework":
                    package_name = "android"
                hash_info_list.append([timestamp, "apk", package_name, proc_name, hash_value])

        TEST_LOGGER.debug("[{}] 的Hash信息列表：{}".format(tne_dir_name, hash_info_list))
        if not hash_info_list:
            TEST_LOGGER.debug("未发现{} 的Hash信息".format(self._AndroidMainLog__tne_dir_name))
            return closest_hash

        # 先按类型/包名过滤，再一次性取时间最近（结果与循环内反复就近计算等价）
        hash_info_tmp_list = []
        for hash_info in hash_info_list:
            hash_type_tmp = hash_info[1]
            hash_package_tmp = hash_info[2]
            hash_proc_tmp = hash_info[3]
            if ":" in hash_package_tmp:
                hash_package_tmp = hash_package_tmp.split(":")[0]
            if ":" in hash_proc_tmp:
                hash_proc_tmp = hash_proc_tmp.split(":")[0]
            if hash_type_tmp != target_hash_type:
                continue
            package_matched = (
                hash_package_tmp == target_hash_package
                or (target_hash_package and target_hash_package in hash_package_tmp)
                or (hash_package_tmp and hash_package_tmp in target_hash_package)
            )
            proc_matched = (
                hash_proc_tmp == target_hash_package
                or (target_hash_package and target_hash_package in hash_proc_tmp)
                or (hash_proc_tmp and hash_proc_tmp in target_hash_package)
            )
            if package_matched or proc_matched:
                hash_info_tmp_list.append(hash_info)

        if not hash_info_tmp_list:
            TEST_LOGGER.debug("[{}] 没有和 类型：{}，包名：{} 匹配的Hah值".format(
                tne_dir_name, target_hash_type, target_hash_package))
            return None

        closest_hash = hash_info_tmp_list[-1][4]
        if (len(hash_info_tmp_list) > 1
                and target_hash_time
                and str(target_hash_time).lower() not in ("undefined", "none", "")):
            closest_hash = self._pick_closest_hash(
                hash_info_tmp_list, target_hash_time, closest_hash, tne_dir_name)
        TEST_LOGGER.info("[{}] 获取最接近的Hash值：{}".format(tne_dir_name, closest_hash))
        return closest_hash

    def _pick_closest_hash(self, hash_info_tmp_list, target_hash_time, closest_hash, tne_dir_name):
        min_diff = datetime.timedelta(days=1)
        target_str = None
        time_with_date = False
        match = re.search(AndroidMainLog.REGEX_DATE_TIME, str(target_hash_time))
        if match:
            target_str = "2000-" + match.group(1)
            time_with_date = True
        else:
            match = re.search(AndroidMainLog.REGEX_TIME_ONLY, str(target_hash_time))
            if match:
                target_str = "2000-01-01 " + match.group(1)
        if not target_str:
            return closest_hash
        if "." not in target_str:
            target_str += ".000"
        TEST_LOGGER.debug("目标时间:{} 格式化后，为：{}".format(target_hash_time, target_str))
        target_dt = datetime.datetime.strptime(target_str, "%Y-%m-%d %H:%M:%S.%f")
        for hash_info_tmp in hash_info_tmp_list:
            hash_time_tmp_org = hash_info_tmp[0]
            hash_time_tmp = hash_info_tmp[0]
            hash_value_tmp = hash_info_tmp[4]
            if time_with_date:
                hash_time_tmp = "2000-" + hash_time_tmp
            else:
                hash_time_tmp = "2000-01-01 " + hash_time_tmp.split(" ")[1]
            TEST_LOGGER.debug("{} 格式化后，为：{}".format(hash_time_tmp_org, hash_time_tmp))
            hash_time_dt = datetime.datetime.strptime(hash_time_tmp, "%Y-%m-%d %H:%M:%S.%f")
            diff = abs(hash_time_dt - target_dt)
            if diff > datetime.timedelta(hours=12):
                diff = datetime.timedelta(days=1) - diff
            if diff < min_diff:
                min_diff = diff
                closest_hash = hash_value_tmp
        return closest_hash

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
