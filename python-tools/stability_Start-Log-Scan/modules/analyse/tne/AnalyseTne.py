# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\AnalyseTne.py
import datetime, os, re, traceback
import modules.analyse.tne.types.TneDaemonCrash as TneDaemonCrash
import modules.analyse.tne.types.TneFreeze as TneFreeze
import modules.analyse.tne.types.TneSubsystemCrash as TneSubsystemCrash
from modules.analyse.tne.types.tne12 import Tne12
from modules.analyse.tne.types.tne13 import Tne13
from modules.analyse.tne.types.tne14 import Tne14
from modules.analyse.tne.types.tne_stucklogo_expdb import TneStuckLogoExpdb
from modules.common.Logger import TEST_LOGGER
from modules.analyse.tne.types.tne00 import Tne00
from modules.analyse.tne.types.tne01 import Tne01
from modules.analyse.tne.types.tne02 import Tne02
from modules.analyse.tne.types.tne03 import Tne03
from modules.analyse.tne.types.tne04 import Tne04
from modules.analyse.tne.types.tne06 import Tne06
from modules.analyse.tne.types.tne07 import Tne07
from modules.analyse.tne.types.tne08 import Tne08
from modules.analyse.tne.types.tne09 import Tne09
from modules.analyse.tne.types.tne0a import Tne0a
from modules.analyse.tne.types.tne0c import Tne0c
from modules.analyse.tne.types.tne0d import Tne0d
from modules.analyse.tne.types.tne0f import Tne0f
from modules.analyse.tne.types.tne00160002 import Tne00160002
from modules.analyse.tne.types.TneBacklightSensorDetect import TneBacklightSensorDetect
from modules.analyse.tne.types.TneCloneStability import TneCloneStability
regex_0xffffff31 = re.compile("0xffffff31_(\\d{4}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d+)")
regex_0xffffff32 = re.compile("0xffffff32_(\\d{4}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d+)")
regex_0x007a0049 = re.compile("0x007a0049_(\\d{4}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d+)")
regex_0x007a0050 = re.compile("0x007a0050_(\\d{4}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d{2}_\\d+)")
_PLANNED_REBOOT_TAGS = ("adb_reboot_reset", "factory_reset")


def _compact_ts_to_datetime(ts):
    """将紧凑时间串前 14 位转为 datetime，失败返回 None。"""
    if not ts or len(ts) < 14:
        return None
    try:
        return datetime.datetime(
            int(ts[0:4]), int(ts[4:6]), int(ts[6:8]),
            int(ts[8:10]), int(ts[10:12]), int(ts[12:14]))
    except ValueError:
        return None


def parse_tne_dir_timestamp(time_tag_str):
    """
    解析 TNE 目录/文件名中的时间戳，支持：
      - 旧格式: 2026_08_13_10_08_36_74
      - 新格式单时间戳: 2026081310083674
      - 新格式双时间戳(+hash): 2026072802283273_2026072802282526[_hash...]
        第一段=tne生成时间，第二段=问题发生时间 → 统一取第二段
    解析失败返回 None。
    """
    if not time_tag_str:
        return None
    time_tag_str = str(time_tag_str).strip()
    if time_tag_str.lower().endswith(".tne"):
        time_tag_str = time_tag_str[:-4]
    dual = re.match(r"^(\d{14,20})_(\d{14,20})(?:_[a-fA-F0-9]+)?$", time_tag_str)
    if dual:
        return _compact_ts_to_datetime(dual.group(2))
    single = re.match(r"^(\d{14,20})$", time_tag_str)
    if single:
        return _compact_ts_to_datetime(single.group(1))
    legacy = re.match(r"^(\d{4}_\d{2}_\d{2}_\d{2}_\d{2}_\d{2}(?:_\d+)?)", time_tag_str)
    if not legacy:
        return None
    tag = legacy.group(1)
    try:
        return datetime.datetime.strptime(tag, "%Y_%m_%d_%H_%M_%S_%f")
    except ValueError:
        try:
            return datetime.datetime.strptime("_".join(tag.split("_")[:6]), "%Y_%m_%d_%H_%M_%S")
        except ValueError:
            return None


def _is_backlight_sensor_detect(tne_type):
    return str(tne_type or "").strip().lower() == "0xffffff73"


def _finish_tne_analyse(tne, tne_dir_path, extra_jira_tag=None):
    tne_dir_name = os.path.basename(tne_dir_path)
    try:
        tne.analyse()
        if extra_jira_tag:
            tne.set_extra_jira_tag(extra_jira_tag)
    except Exception:
        TEST_LOGGER.error("分析TNE时发生异常：\n{}".format(traceback.format_exc()))
        return (False, tne_dir_path, None, "Exception", traceback.format_exc())
    extra_tag = getattr(tne, "_extra_tag", "") or ""
    if extra_tag in _PLANNED_REBOOT_TAGS:
        TEST_LOGGER.info("计划内重启，不作为死机挂死上报：{}".format(extra_tag), tag=tne_dir_name)
        return (False, tne_dir_path, tne, extra_tag, extra_tag)
    TEST_LOGGER.debug(("TNE目录：{} 解析已完成".format(tne_dir_path)), tag=tne_dir_name)
    return (True, tne_dir_path, tne, None, None)


def analyse_tne(tne_dir_path, tne_type=None, freeze_tne_type_list=None, subsystem_crash_tne_type_list=None, daemon_crash_tne_type_list=None, build_version=None, extra_jira_tag=None):
    tne_dir_name = os.path.basename(tne_dir_path)
    TEST_LOGGER.debug(("开始解析TNE目录：{}".format(tne_dir_path)), tag=tne_dir_name)
    if not tne_type:
        tne_type = tne_dir_name.split("_")[0]
    if tne_type in ("0x0016000a", "0x0016000b"):
        tne = TneCloneStability(tne_dir_path, tne_type)
        return _finish_tne_analyse(tne, tne_dir_path, extra_jira_tag)
    if tne_type == "0xffffff73" or _is_backlight_sensor_detect(tne_type):
        tne = TneBacklightSensorDetect(tne_dir_path, tne_type, build_version)
        return _finish_tne_analyse(tne, tne_dir_path, extra_jira_tag)
    if tne_type == "0xffffff00":
        tne = Tne00(tne_dir_path)
    else:
        if tne_type == "0xffffff01":
            tne = Tne01(tne_dir_path)
        else:
            if tne_type == "0xffffff02":
                tne = Tne02(tne_dir_path)
            else:
                if tne_type == "0xffffff03":
                    tne = Tne03(tne_dir_path)
                else:
                    if tne_type == "0xffffff04":
                        tne = Tne04(tne_dir_path)
                    else:
                        if tne_type == "0xffffff05":
                            TEST_LOGGER.warn("TNE类型0xffffff05不再解析", tag=tne_dir_name)
                            return (False, tne_dir_path, None, "UnsupportTneType", tne_type)
                        if tne_type == "0xffffff06":
                            tne = Tne06(tne_dir_path)
                        else:
                            if tne_type == "0xffffff07":
                                tne = Tne07(tne_dir_path)
                            else:
                                if tne_type == "0xffffff08":
                                    tne = Tne08(tne_dir_path)
                                else:
                                    if tne_type == "0xffffff09":
                                        tne = Tne09(tne_dir_path)
                                    else:
                                        if tne_type == "0xffffff0a":
                                            tne = Tne0a(tne_dir_path)
                                        else:
                                            if tne_type == "0xffffff0c":
                                                tne = Tne0c(tne_dir_path)
                                            else:
                                                if tne_type == "0xffffff0d":
                                                    tne = Tne0d(tne_dir_path)
                                                else:
                                                    if tne_type == "0xffffff0f":
                                                        tne = Tne0f(tne_dir_path)
                                                    else:
                                                        if tne_type == "0xffffff12":
                                                            tne = Tne12(tne_dir_path)
                                                        else:
                                                            if tne_type == "0xffffff13":
                                                                tne = Tne13(tne_dir_path)
                                                            else:
                                                                if tne_type == "0xffffff14":
                                                                    tne = Tne14(tne_dir_path)
                                                                else:
                                                                    if tne_type == "0x00160002":
                                                                        tne = Tne00160002(tne_dir_path)
                                                                    else:
                                                                        if tne_type == "expdb_stucklogo":
                                                                            tne = TneStuckLogoExpdb(tne_dir_path)
                                                                        else:
                                                                            if freeze_tne_type_list and tne_type in freeze_tne_type_list:
                                                                                paired_tne_path = None
                                                                                paired_tne_dir_name = None
                                                                                min_time_diff = 100
                                                                                if tne_type == "0xffffff31":
                                                                                    time_tag_31_str = tne_dir_name.split("0xffffff31_")[-1]
                                                                                    time_tag_31 = datetime.datetime.strptime(time_tag_31_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                    parent_dir_path = os.path.dirname(tne_dir_path)
                                                                                    for dir_name in os.listdir(parent_dir_path):
                                                                                        regex_rlt = re.match(regex_0xffffff32, dir_name)
                                                                                        if regex_rlt:
                                                                                            time_tag_32_str = regex_rlt.group(1)
                                                                                            time_tag_32 = datetime.datetime.strptime(time_tag_32_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                            time_diff_abs = abs((time_tag_32 - time_tag_31).total_seconds())
                                                                                            if time_diff_abs <= 60 and time_diff_abs < min_time_diff:
                                                                                                min_time_diff = time_diff_abs
                                                                                                paired_tne_dir_name = dir_name
                                                                                                paired_tne_path = os.path.join(parent_dir_path, paired_tne_dir_name)

                                                                                    if paired_tne_path:
                                                                                        TEST_LOGGER.info(f"获取 {tne_dir_name} 配对的0xffffff32类型TNE成功: {paired_tne_dir_name}")
                                                                                elif tne_type == "0xffffff32":
                                                                                    time_tag_32_str = tne_dir_name.split("0xffffff32_")[-1]
                                                                                    time_tag_32 = datetime.datetime.strptime(time_tag_32_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                    parent_dir_path = os.path.dirname(tne_dir_path)
                                                                                    for dir_name in os.listdir(parent_dir_path):
                                                                                        regex_rlt = re.match(regex_0xffffff31, dir_name)
                                                                                        if regex_rlt:
                                                                                            time_tag_31_str = regex_rlt.group(1)
                                                                                            time_tag_31 = datetime.datetime.strptime(time_tag_31_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                            time_diff_abs = abs((time_tag_32 - time_tag_31).total_seconds())
                                                                                            if time_diff_abs <= 60 and time_diff_abs < min_time_diff:
                                                                                                min_time_diff = time_diff_abs
                                                                                                paired_tne_dir_name = dir_name
                                                                                                paired_tne_path = os.path.join(parent_dir_path, paired_tne_dir_name)

                                                                                    if paired_tne_path:
                                                                                        TEST_LOGGER.info(f"获取 {tne_dir_name} 配对的0xffffff31类型TNE成功: {paired_tne_dir_name}, 不再解析")
                                                                                        return (False, tne_dir_path, None, "paired_0xffffff31", tne_type)
                                                                                elif tne_type == "0x007a0049":
                                                                                    time_tag_49_str = tne_dir_name.split("0x007a0049_")[-1]
                                                                                    time_tag_49 = datetime.datetime.strptime(time_tag_49_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                    parent_dir_path = os.path.dirname(tne_dir_path)
                                                                                    for dir_name in os.listdir(parent_dir_path):
                                                                                        regex_rlt = re.match(regex_0x007a0050, dir_name)
                                                                                        if regex_rlt:
                                                                                            time_tag_50_str = regex_rlt.group(1)
                                                                                            time_tag_50 = datetime.datetime.strptime(time_tag_50_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                            time_diff_abs = abs((time_tag_50 - time_tag_49).total_seconds())
                                                                                            if time_diff_abs <= 60 and time_diff_abs < min_time_diff:
                                                                                                min_time_diff = time_diff_abs
                                                                                                paired_tne_dir_name = dir_name
                                                                                                paired_tne_path = os.path.join(parent_dir_path, paired_tne_dir_name)

                                                                                    if paired_tne_path:
                                                                                        TEST_LOGGER.info(f"获取 {tne_dir_name} 配对的0x007a0050类型TNE成功: {paired_tne_dir_name}")
                                                                                elif tne_type == "0x007a0050":
                                                                                    time_tag_50_str = tne_dir_name.split("0x007a0050_")[-1]
                                                                                    time_tag_50 = datetime.datetime.strptime(time_tag_50_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                    parent_dir_path = os.path.dirname(tne_dir_path)
                                                                                    for dir_name in os.listdir(parent_dir_path):
                                                                                        regex_rlt = re.match(regex_0x007a0049, dir_name)
                                                                                        if regex_rlt:
                                                                                            time_tag_49_str = regex_rlt.group(1)
                                                                                            time_tag_49 = datetime.datetime.strptime(time_tag_49_str, "%Y_%m_%d_%H_%M_%S_%f")
                                                                                            time_diff_abs = abs((time_tag_50 - time_tag_49).total_seconds())
                                                                                            if time_diff_abs <= 60 and time_diff_abs < min_time_diff:
                                                                                                min_time_diff = time_diff_abs
                                                                                                paired_tne_dir_name = dir_name
                                                                                                paired_tne_path = os.path.join(parent_dir_path, paired_tne_dir_name)

                                                                                    if paired_tne_path:
                                                                                        TEST_LOGGER.info(f"获取 {tne_dir_name} 配对的0x007a0049类型TNE成功: {paired_tne_dir_name}, 不再解析")
                                                                                        return (False, tne_dir_path, None, "paired_0x007a0049", tne_type)
                                                                                tne = TneFreeze(tne_dir_path, tne_type, build_version, paired_tne_path)
                                                                            else:
                                                                                if subsystem_crash_tne_type_list and tne_type in subsystem_crash_tne_type_list:
                                                                                    tne = TneSubsystemCrash(tne_dir_path, tne_type, build_version)
                                                                                else:
                                                                                    if daemon_crash_tne_type_list:
                                                                                        if tne_type in daemon_crash_tne_type_list:
                                                                                            tne = TneDaemonCrash(tne_dir_path, tne_type, build_version)
                                                                                        else:
                                                                                            TEST_LOGGER.error(("未知的TNE类型：{}，目录：{}".format(tne_type, tne_dir_path)), tag=tne_dir_name)
                                                                                            return (False, tne_dir_path, None, "unknownTneType", tne_type)
                                                                                    else:
                                                                                        try:
                                                                                            tne.analyse()
                                                                                            if extra_jira_tag:
                                                                                                if extra_jira_tag != "":
                                                                                                    tne.set_extra_jira_tag(extra_jira_tag)
                                                                                        except:
                                                                                            TEST_LOGGER.error("分析TNE时发生异常：\n{}".format(traceback.format_exc()))
                                                                                            return (False, tne_dir_path, None, "Exception", traceback.format_exc())

                                                                                    TEST_LOGGER.debug(("TNE目录：{} 解析已完成".format(tne_dir_path)), tag=tne_dir_name)
                                                                                    return (True, tne_dir_path, tne, None, None)
    return _finish_tne_analyse(tne, tne_dir_path, extra_jira_tag)


def specific_tne_to_jira(tne_type_list, tne_dir_path, tne_type=None):
    """
    将指定的TNE（黑屏定屏TNE）转换为jira提单数据
    """
    tne_dir_name = os.path.basename(tne_dir_path)
    TEST_LOGGER.debug(("开始解析TNE目录：{}".format(tne_dir_path)), tag=tne_dir_name)
    if not tne_type:
        tne_type = tne_dir_name.split("_")[0]
    if tne_type in tne_type_list:
        pass
    return

# okay decompiling extracted_pyz_modules/modules/analyse/tne\AnalyseTne.pyc
