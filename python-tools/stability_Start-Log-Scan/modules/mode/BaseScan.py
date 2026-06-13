# -*- coding: utf-8 -*-
# 反编译后清理的文件

import os, re, shutil, sys, json, datetime, platform, socket, traceback
from abc import ABC, abstractmethod
from concurrent.futures import ThreadPoolExecutor, as_completed
from modules.analyse.aee.AnalyseAee import analyse_aee
from modules.analyse.aee.files.db_file_map import DbFileMap
from modules.analyse.aee.files.exp_main import ExpMain
from modules.analyse.aee.files.rom_ram import parse_rom_ram_from_dec_dir
from modules.analyse.aee.files.sys_properties import SysProperties
from modules.analyse.aee.files.zz_internal import ZZ_internal
from modules.analyse.tne.AnalyseTne import analyse_tne
from modules.common.ExecCmd import exec_cmd
from modules.common.Path import PathManager
from modules.common.Logger import TEST_LOGGER
from modules.common.GlobalAttrs import *
from modules.common.Utils import unzip, aee_extract, decompress_tne, get_report_history_online, get_package_white_list_online, get_monkey_blacklist_online, get_jira_project_online, post_report_history, sendMail, is_network_connected, extract_expdb, send_msg_by_feishu_robot, get_mixed_md5, walk_with_max_depth, get_str_similar, send_monkey_rlt_by_feishu_robot, get_freeze_version_from_feishu, get_top_app_list_from_feishu, get_tne_tag_info_from_feishu, random_str
from modules.common.Version import VERSION
PATTERN_MAIL = re.compile("[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{2,4}")
PATTERN_ANDROID_VERION = re.compile("-([L|M|N|O|P|Q|R|S|T|U|V])-")

class FallbackAeeResult(object):

    def __init__(self, path, version, exp_time, exp_class, exp_type, cur_process, package, detail_col_text, caused_by_col_text, extra_tag="", activity="None", device_id=None, fans_version=False, rom_ram=""):
        super(FallbackAeeResult, self).__init__()
        self._attrs = [
         path, version, exp_time, exp_class, exp_type, cur_process, package, detail_col_text,
         caused_by_col_text, extra_tag, 1, activity, device_id, fans_version, rom_ram]

    def get_aee_attrs(self):
        return list(self._attrs)

    @property
    def recognize_exception_rlt(self):
        return True

    @property
    def handle_recognize_rlt(self):
        return True

    def is_ignore_ke_ne_hwasan(self):
        return False

    def is_ne_system_issue(self):
        return False


class ScanBase(ABC):
    __doc__ = "\n    配置文件读取优先级： 平台传入tag值 value > hostname对应 value > default value\n    扫描目录优先级：传入扫描目录参数 > 配置参数配置 > 扫描工具本地目录\n    "

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag=None, delete_logs=False, limit_dbg_count=0):
        super(ScanBase, self).__init__()
        self._scan_mode = scan_mode
        self._scan_place = scan_place
        self._days_before = days_before
        self._scan_root_dir = scan_root_dir
        self._cur_tool_dir = cur_tool_dir
        self._skip_extract = skip_extract
        self._skip_unzip = skip_unzip
        self._task_tag = task_tag
        self._delete_logs = delete_logs
        self._limit_dbg_count = limit_dbg_count
        self._build_version = None
        self._scan_site = "UnknownSite"
        TEST_LOGGER.info("初始化 ScanBase，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(self._scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(self._scan_place))
        TEST_LOGGER.info("days_before：{}".format(self._days_before))
        TEST_LOGGER.info("scan_root_dir：{}".format(self._scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(self._cur_tool_dir))
        TEST_LOGGER.info("skip_extract：{}".format(self._skip_extract))
        TEST_LOGGER.info("skip_unzip：{}".format(self._skip_unzip))
        TEST_LOGGER.info("task_tag：{}".format(self._task_tag))
        TEST_LOGGER.info("delete_logs：{}".format(self._delete_logs))
        TEST_LOGGER.info("limit_dbg_count：{}".format(self._limit_dbg_count))
        self._android = None
        self._hostname = None
        self._platform_system = None
        self._unzip, self._aee_extract, self._tne_decompress = (None, None, None)
        self._p_new_db = None
        self._scan_date_formatted_aee = ""
        self._scan_date_formatted_tne = ""
        self._scan_date_formatted_fans_usic = ""
        self._scan_date_formatted_stuck_logo = ""
        self._report_date_formatted = ""
        self._stop_if_too_many = True
        self._skip_if_too_many = True
        self._max_single_dbg_number = 100
        self._max_single_handle_dbg_number = 10
        self._max_dbg_number = 500
        self._ratio_std_aee = 90
        self._ratio_std_tne = 90
        self._is_mp_block = False
        self._is_trunk = False
        self._trunk_jira_repo = None
        self._trunk_build_prefix = None
        self._log_smb_username = None
        self._log_smb_password = None
        self._extra_jira_tag = None
        self._special_build_prefix = None
        self._is_network_connected = True
        self._to_recognize_except = True
        self._delete_log_when_no_exception = False
        self._send_notify_mail_to_tester = True
        self._send_notify_mail_to_default = False
        self._send_notify_mail_to_project = False
        self._send_warning_mail = True
        self._mail_receivers_to_project = None
        self._mail_receivers_to_tester = None
        self._mail_receivers_to_default = None
        self._mail_receivers_to_new_app = None
        self._mail_receivers_to_scan_system = None
        self._notify_mail_list = []
        self._warning_mail_list = []
        self._new_app_mail_list = []
        self._new_app_noticed = False
        self._scan_system_mail_list = []
        self._extract_dbg_time_out = 3600
        self._pkglist_file = "pkglist.txt"
        self._mp_block_file = "mp_block.txt"
        self._jira_project_file = "jira_project.txt"
        self._blacklist_file = "blacklist.txt"
        self._report_history_file = "report_history.txt"
        self._top_apk_file = "top_apk.txt"
        self._freeze_tne_type_file = "freeze_tne_type.json"
        self._scan_type = "shanghai"
        self._pkglist = []
        self._blacklist = []
        self._report_history_list = []
        self._new_app_info_list = []
        self._failed_dbg_info_cache = {}
        self._extract_failed_dbg_reason_map = {}
        self._extract_failed_dbg_report_status_map = {}
        self._win_to_mnt_dict = {}
        self._ignore_pkglist = False
        self._reporter = None
        self._get_tne_type_list = False
        self._tne_tag_dict = {}
        self._freeze_tne_type_list = []
        self._daemon_crash_tne_type_list = []
        self._subsystem_crash_tne_type_list = []
        self._app_crash_anr_tne_type_list = []
        self._default_config = {'scan_root_dir':None, 
         'stop_if_too_many':True, 
         'skip_if_too_many':True, 
         'max_single_dbg_number':100, 
         'max_single_handle_dbg_number':10, 
         'max_dbg_number':500, 
         'ratio_std_aee':90, 
         'ratio_std_tne':90, 
         'scan_type':"shanghai", 
         'scan_site':"UnknownSite", 
         'is_trunk':False, 
         'pkglist_file':"pkglist.txt", 
         'mp_block_file':"mp_block.txt", 
         'jira_project_file':"jira_project.txt", 
         'submit_jira':False, 
         'submit_jira_url':None, 
         'reporter':None, 
         'jira_repo':None, 
         'archive_address':None, 
         'replace_index':2, 
         'result_dir':None, 
         'mail_receivers_to_tester':None, 
         'mail_receivers_to_default':None, 
         'mail_receivers_to_new_app':None, 
         'mail_receivers_to_scan_system':None, 
         'send_notify_mail_to_tester':True, 
         'send_notify_mail_to_default':False, 
         'send_notify_mail_to_project':False, 
         'send_warning_mail':True, 
         'submit_monkey_db':False, 
         'top_apk_file':"top_apk.txt", 
         'limited_prj_build':{},  'limited_max_days':0, 
         'limited_prj_date':{},  'win_to_mnt':None, 
         'ignore_pkglist':False, 
         'extract_dbg_time_out':3600}
        self._config_file = None

    def start_scan(self):
        """
        执行扫描开始
        :return:
        """
        self._init_env()
        self._load_configs()
        self._get_mail_receivers()
        rlt, error_msg = self._get_scan_dir()
        if not rlt:
            self._get_scan_dir_failed(error_msg)
            return
        self._init_scan_attrs()
        self._get_standard_info()
        self._scan()

    def _normalize_aee_device_id(self, device_id):
        if device_id is None:
            return None
        device_id = str(device_id).strip()
        if not device_id:
            return None
        if device_id.lower() in ("none", "undefined", "unknown_device_id", "discard_device_id"):
            return None
        return device_id

    def _build_aee_final_attrs(self, aee_result_attrs):
        final_attrs = list(aee_result_attrs)
        device_id_set = set()
        rom_ram_set = set()
        device_id = self._normalize_aee_device_id(final_attrs[12] if len(final_attrs) > 12 else None)
        rom_ram = str(final_attrs[14] if len(final_attrs) > 14 else "").strip()
        if device_id:
            device_id_set.add(device_id)
        if rom_ram:
            rom_ram_set.add(rom_ram)
        final_attrs.append(device_id_set)
        final_attrs.append(rom_ram_set)
        return final_attrs

    def _merge_aee_final_device_id(self, final_attrs, device_id):
        device_id_set = self._get_aee_final_device_id_set(final_attrs)
        normalized_device_id = self._normalize_aee_device_id(device_id)
        if normalized_device_id:
            device_id_set.add(normalized_device_id)

    def _merge_aee_final_rom_ram(self, final_attrs, rom_ram):
        rom_ram_set = self._get_aee_final_rom_ram_set(final_attrs)
        rom_ram = str(rom_ram or "").strip()
        if rom_ram:
            rom_ram_set.add(rom_ram)

    @staticmethod
    def _get_aee_final_device_id_set(final_attrs):
        if final_attrs and len(final_attrs) >= 2 and isinstance(final_attrs[-2], set):
            return final_attrs[-2]
        device_id_set = set()
        final_attrs.append(device_id_set)
        if not isinstance(final_attrs[-1], set):
            final_attrs.append(set())
        return device_id_set

    @staticmethod
    def _get_aee_final_rom_ram_set(final_attrs):
        if final_attrs and isinstance(final_attrs[-1], set):
            return final_attrs[-1]
        rom_ram_set = set()
        final_attrs.append(rom_ram_set)
        return rom_ram_set

    @abstractmethod
    def _get_scan_dir_failed(self, error_msg):
        """
        获取
        :param error_msg:
        :return:
        """
        return

    @abstractmethod
    def _init_scan_attrs(self):
        """
        初始化各个扫描模式的扫描参数
        :return:
        """
        return

    @abstractmethod
    def _scan(self):
        return

    def _init_env(self):
        """
        检查测试环境及需要的工具是否存在，确定扫描时间信息，确定读取的配置文件
        :return:
        """
        self._hostname = socket.gethostname()
        self._platform_system = platform.system().lower()
        self._is_network_connected = is_network_connected()
        TEST_LOGGER.info("当前服务器系统：{}".format(self._platform_system))
        if self._platform_system == "linux":
            self._aee_extract = PathManager.tools_folder + os.sep + "aee_extract" + os.sep + "aee_extract"
            self._tne_decompress = PathManager.tools_folder + os.sep + "decompress" + os.sep + "linux" + os.sep + "tne_decompress"
            self._unzip = "unzip"
            TEST_LOGGER.info("Linux 系统，使用系统自带unzip")
            self._p_new_db = PathManager.tools_folder + os.sep + "expdb" + os.sep + "p-new-db"
            if not os.path.isfile(self._p_new_db):
                TEST_LOGGER.critical("p-new-db 文件不存在：{}".format(self._p_new_db))
                sys.exit(EXIT_CODE_INVALID_ENV)
            TEST_LOGGER.info("p-new-db 路径：{}".format(self._p_new_db))
        else:
            if self._platform_system == "windows":
                self._aee_extract = PathManager.tools_folder + os.sep + "aee_extract" + os.sep + "aee_extract.exe"
                self._tne_decompress = PathManager.tools_folder + os.sep + "decompress" + os.sep + "windows" + os.sep + "TneDecompress.exe"
                self._unzip = PathManager.tools_folder + os.sep + "unzip" + os.sep + "unzip.exe"
                if not os.path.isfile(self._unzip):
                    TEST_LOGGER.critical("unzip 文件不存在：{}".format(self._aee_extract))
                    sys.exit(EXIT_CODE_INVALID_ENV)
                TEST_LOGGER.info("unzip 路径：{}".format(self._unzip))
                TEST_LOGGER.info("Windows 下不存在 p-new-db 文件")
            else:
                TEST_LOGGER.critical("未知的服务器系统：{}".format(self._platform_system))
                sys.exit(EXIT_CODE_INVALID_ENV)
        if not os.path.isfile(self._aee_extract):
            TEST_LOGGER.critical("aee_extract 文件不存在：{}".format(self._aee_extract))
            sys.exit(EXIT_CODE_INVALID_ENV)
        else:
            TEST_LOGGER.info("aee_extract 路径：{}".format(self._aee_extract))
            if not os.path.isfile(self._tne_decompress):
                TEST_LOGGER.critical("tne_decompress 文件不存在：{}".format(self._tne_decompress))
                sys.exit(EXIT_CODE_INVALID_ENV)
            TEST_LOGGER.info("tne_decompress 路径：{}".format(self._tne_decompress))
            today = datetime.datetime.now()
            if self._days_before >= 0:
                TEST_LOGGER.info("days_before：{}，指定扫描{}天前的日志".format(self._days_before, self._days_before))
                days_before = -self._days_before
                scan_date = today + datetime.timedelta(days=days_before)
                self._report_date_formatted = scan_date.strftime("%Y%m%d")
                self._scan_date_formatted_aee = scan_date.strftime("%Y%m%d")
                self._scan_date_formatted_tne = scan_date.strftime("%Y%m%d")
                self._scan_date_formatted_fans_usic = scan_date.strftime("%Y-%m-%d")
                self._scan_date_formatted_stuck_logo = scan_date.strftime("%Y-%m-%d")
                self._scan_date_formatted_ota_daily = scan_date.strftime("%Y_%m_%d")
            else:
                TEST_LOGGER.info("days_before：{}，扫描当前目录所有日期的日志".format(self._days_before))
            self._report_date_formatted = today.strftime("%Y%m%d")
            self._scan_date_formatted_aee = ""
            self._scan_date_formatted_tne = ""
            self._scan_date_formatted_ota_daily = ""
        if self._task_tag in ('ad10_sh', 'ad10_cq'):
            regex_rlt = re.search("\\d{4}-\\d{2}-\\d{2}", self._scan_root_dir)
            if regex_rlt:
                scan_date = regex_rlt.group(0)
                self._report_date_formatted = "".join(scan_date.split("-"))
        TEST_LOGGER.info("report_date_formatted：{}".format(self._report_date_formatted))
        TEST_LOGGER.info("scan_date_formatted_aee：{}".format(self._scan_date_formatted_aee))
        TEST_LOGGER.info("scan_date_formatted_tne：{}".format(self._scan_date_formatted_tne))
        TEST_LOGGER.info("scan_date_formatted_fans_usic：{}".format(self._scan_date_formatted_fans_usic))
        TEST_LOGGER.info(f"scan_date_formatted_stuck_logo: {self._scan_date_formatted_stuck_logo}")
        TEST_LOGGER.info("scan_date_formatted_ota_daily：{}".format(self._scan_date_formatted_ota_daily))
        TEST_LOGGER.info("扫描初始化完成\n")

    def _load_configs(self):
        """
        导入配置文件并初始化扫描参数
        :return:
        """
        if self._scan_mode == SCAN_MODE_FANS:
            self._config_file = PathManager.config_folder + os.sep + "config_aee_fans.json"
        else:
            if self._scan_mode == SCAN_MODE_USIC:
                self._config_file = PathManager.config_folder + os.sep + "config_tne_usic.json"
            else:
                if self._scan_mode == SCAN_MODE_FREEZE:
                    self._config_file = PathManager.config_folder + os.sep + "config_tne_freeze.json"
                else:
                    if self._scan_mode == SCAN_MODE_DAEMON_CRASH:
                        self._config_file = PathManager.config_folder + os.sep + "config_tne_daemon_crash.json"
                    else:
                        if self._scan_mode == SCAN_MODE_SUBSYSTEM_CRASH:
                            self._config_file = PathManager.config_folder + os.sep + "config_tne_subsystem_crash.json"
                        else:
                            if self._scan_mode == SCAN_MODE_STUCK_LOGO:
                                self._config_file = PathManager.config_folder + os.sep + "config_stuck_logo.json"
                            else:
                                if self._scan_mode == SCAN_MODE_MTBF_PLATFORM:
                                    self._config_file = PathManager.config_folder + os.sep + "config_aee_mtbf_platform_{}.json".format(self._scan_place.lower())
                                else:
                                    if self._scan_mode == SCAN_MODE_PLATFORM:
                                        self._config_file = PathManager.config_folder + os.sep + "config_aee_platform_{}.json".format(self._scan_place.lower())
                                    else:
                                        if self._scan_mode == SCAN_MODE_DAILY:
                                            self._config_file = PathManager.config_folder + os.sep + "config_aee_daily_{}.json".format(self._scan_place.lower())
                                        else:
                                            if self._scan_mode in [SCAN_MODE_CAMERA_PLATFORM, SCAN_MODE_VIDEO_PLATFORM]:
                                                self._config_file = PathManager.config_folder + os.sep + "config_aee_media_platform_{}.json".format(self._scan_place.lower())
                                            else:
                                                if self._scan_mode == SCAN_MODE_OTA_DAILY:
                                                    self._config_file = PathManager.config_folder + os.sep + "config_aee_ota_daily.json"
                                                else:
                                                    if self._scan_mode == SCAN_MODE_INDEPENDENT:
                                                        self._config_file = PathManager.config_folder + os.sep + "config_aee_independent.json"
                                                    else:
                                                        if self._scan_mode == SCAN_MODE_UPLOAD_TNE:
                                                            self._config_file = PathManager.config_folder + os.sep + f"config_upload_tne_{self._scan_place.lower()}.json"
                                                        else:
                                                            self._config_file = PathManager.config_folder + os.sep + "config_aee_tne.json"
        TEST_LOGGER.info("测试模式：{} 对应配置文件：{}".format(SCAN_MODE_DICT[self._scan_mode], self._config_file))
        if os.path.isfile(self._config_file):
            TEST_LOGGER.info("开始读取配置文件：{}".format(self._config_file))
            with open((self._config_file), "r", encoding="utf-8", errors="ignore") as f:
                config_dict = json.load(f)
                if "default" in config_dict:
                    config_default = config_dict["default"]
                    self._default_config.update(config_default)
                else:
                    TEST_LOGGER.info("{} 中未获取到 default 配置信息".format(self._config_file))
                if self._scan_mode == SCAN_MODE_PLATFORM:
                    TEST_LOGGER.info("平台扫描模式，项目：{}，开始检查是否存在对应配置项".format(self._target_project))
                    dict_key = self._prj_key_in_config_dict(config_dict)
                    if dict_key:
                        TEST_LOGGER.info("存在配置项：{}，开始读取对应配置".format(dict_key))
                        config_prj = config_dict[dict_key]
                        self._default_config.update(config_prj)
                    else:
                        TEST_LOGGER.info("不存在项目：{}的配置项".format(self._target_project))
                if self._scan_mode in [SCAN_MODE_CAMERA_PLATFORM, SCAN_MODE_VIDEO_PLATFORM]:
                    TEST_LOGGER.info(f"多媒体平台扫描模式，项目：{self._target_project}，开始检查是否存在对应配置项")
                    dict_key = self._prj_key_in_config_dict(config_dict)
                    if dict_key:
                        TEST_LOGGER.info("存在配置项：{}，开始读取对应配置".format(dict_key))
                        config_prj = config_dict[dict_key]
                        self._default_config.update(config_prj)
                    else:
                        TEST_LOGGER.error("多媒体平台扫描模式，不存在项目：{}的配置项".format(self._target_project))
                        raise Exception("多媒体平台扫描模式，不存在项目：{}的配置项".format(self._target_project))
                if self._scan_mode == SCAN_MODE_SUNMAO_PLATFORM:
                    TEST_LOGGER.info("榫卯平台扫描模式，开始检查是否存在对应配置项")
                    config_sunmao = config_dict.get("sunmao")
                    if config_sunmao:
                        self._default_config.update(config_sunmao)
                    else:
                        TEST_LOGGER.info("不存在榫卯平台配置项")
                        raise Exception("不存在榫卯平台配置项")
                if self._scan_mode in [SCAN_MODE_AEE_TNE, SCAN_MODE_AEE, SCAN_MODE_DAILY]:
                    if self._hostname and self._hostname in config_dict:
                        TEST_LOGGER.info("发现主机名配置项：{}，开始读取对应配置项".format(self._hostname))
                        config_host = config_dict[self._hostname]
                        self._default_config.update(config_host)
                    else:
                        TEST_LOGGER.info("{} 中未获取到主机名 {} 配置信息".format(self._config_file, self._hostname))
                if self._task_tag:
                    TEST_LOGGER.info("传入参数中存在tag标签：{}".format(self._task_tag))
                    if self._task_tag in config_dict:
                        TEST_LOGGER.info("发现TAG配置项：{}，开始读取对应配置项".format(self._task_tag))
                        config_task_tag = config_dict[self._task_tag]
                        self._default_config.update(config_task_tag)
                    else:
                        TEST_LOGGER.error("未发现指定的TAG配置项：{}，请检查配置文件：{}".format(self._task_tag, self._config_file))
        else:
            TEST_LOGGER.error("不存在配置文件：{}".format(self._config_file))
            raise Exception("不存在配置文件：{}".format(self._config_file))
        TEST_LOGGER.info("扫描服务器名：{}".format(self._hostname))
        TEST_LOGGER.info("扫描目录：{}".format(self._scan_root_dir))
        self._stop_if_too_many = self._default_config["stop_if_too_many"]
        self._skip_if_too_many = self._default_config["skip_if_too_many"]
        self._max_single_dbg_number = self._default_config["max_single_dbg_number"]
        self._max_single_handle_dbg_number = self._default_config["max_single_handle_dbg_number"]
        self._max_dbg_number = self._default_config["max_dbg_number"]
        self._ratio_std_aee = self._default_config["ratio_std_aee"]
        TEST_LOGGER.info("aee去重标准:{}%".format(self._ratio_std_aee))
        self._ratio_std_tne = self._default_config["ratio_std_tne"]
        TEST_LOGGER.info("tne去重标准:{}%".format(self._ratio_std_tne))
        self._scan_type = self._default_config["scan_type"]
        TEST_LOGGER.info("扫描去重类型:{}".format(self._scan_type))
        self._scan_site = self._default_config["scan_site"]
        TEST_LOGGER.info(f"扫描地点：{self._scan_site}")
        self._pkglist_file = self._default_config["pkglist_file"]
        TEST_LOGGER.info("pkglist文件：{}".format(self._pkglist_file))
        self._mp_block_file = self._default_config["mp_block_file"]
        TEST_LOGGER.info("MP_Block映射文件：{}".format(self._mp_block_file))
        self._jira_project_file = self._default_config["jira_project_file"]
        TEST_LOGGER.info("JiraProject文件：{}".format(self._jira_project_file))
        self._ignore_pkglist = self._default_config["ignore_pkglist"]
        TEST_LOGGER.info("去重时忽略白名单文件标志ignore_pkglist：{}".format(self._ignore_pkglist))
        self._submit_jira = self._default_config["submit_jira"]
        TEST_LOGGER.info("是否提交Jira：{}".format(self._submit_jira))
        self._submit_jira_url = self._default_config["submit_jira_url"]
        TEST_LOGGER.info("提交Jira Url：{}".format(self._submit_jira_url))
        self._jira_server = self._default_config.get("jira_server")
        TEST_LOGGER.info("提交Jira server：{}".format(self._jira_server))
        self._log_smb_username = self._default_config.get("log_smb_username")
        self._log_smb_password = self._default_config.get("log_smb_password")
        if not self._reporter:
            self._reporter = self._default_config["reporter"]
            TEST_LOGGER.info("问题提交人:{}".format(self._reporter))
        if self._scan_mode == SCAN_MODE_VIDEO_PLATFORM:
            self._media_submit_exp_class_list = self._default_config.get("media_submit_exp_class_list")
            TEST_LOGGER.info("多媒体提交问题的异常类型列表:{}".format(self._media_submit_exp_class_list))
            self._media_submit_key_list = self._default_config.get("media_submit_key_list")
            TEST_LOGGER.info("多媒体提交问题关键字列表:{}".format(self._media_submit_key_list))
        self._jira_repo = self._default_config["jira_repo"]
        TEST_LOGGER.info("配置的Jira提交库:{}".format(self._jira_repo))
        self._extra_jira_tag = self._default_config.get("extra_jira_tag")
        TEST_LOGGER.info("Jira提交额外标签:{}".format(self._extra_jira_tag))
        self._archive_address = self._default_config["archive_address"]
        TEST_LOGGER.info("日志存放NAS:{}".format(self._archive_address))
        self._replace_index = self._default_config["replace_index"]
        TEST_LOGGER.info("日志路径替换位置:{}".format(self._replace_index))
        self._result_dir = self._default_config["result_dir"]
        TEST_LOGGER.info("结果存放根目录:{}".format(self._result_dir))
        to_recognize_except = self._default_config.get("recognize_except")
        if to_recognize_except is not None:
            if to_recognize_except is False:
                self._to_recognize_except = False
        TEST_LOGGER.info("是否调用detail识别库:{}".format(self._to_recognize_except))
        self._delete_log_when_no_exception = self._default_config.get("delete_log_when_no_exception")
        TEST_LOGGER.info("无异常时是否删除log:{}".format(self._delete_log_when_no_exception))
        self._mail_receivers_to_tester = self._default_config.get("mail_receivers_to_tester")
        self._mail_receivers_to_default = self._default_config.get("mail_receivers_to_default")
        self._mail_receivers_to_new_app = self._default_config.get("mail_receivers_to_new_app")
        self._mail_receivers_to_scan_system = self._default_config.get("mail_receivers_to_scan_system")
        self._send_notify_mail_to_tester = self._default_config.get("send_notify_mail_to_tester")
        self._send_notify_mail_to_default = self._default_config.get("send_notify_mail_to_default")
        self._send_notify_mail_to_project = self._default_config.get("send_notify_mail_to_project")
        self._send_warning_mail = self._default_config.get("send_warning_mail")
        extract_dbg_time_out = self._default_config.get("extract_dbg_time_out")
        if extract_dbg_time_out:
            if type(extract_dbg_time_out) == int:
                self._extract_dbg_time_out = extract_dbg_time_out
        TEST_LOGGER.info(f"extract_dbg_time_out: {self._extract_dbg_time_out}")
        if not self._special_build_prefix:
            if "special_build_prefix" in self._default_config:
                self._special_build_prefix = self._default_config["special_build_prefix"]
                TEST_LOGGER.info("存在提交问题特殊版本前缀：{}".format(self._special_build_prefix))
        if self._scan_mode in [SCAN_MODE_AEE_TNE, SCAN_MODE_TNE, SCAN_MODE_FREEZE, SCAN_MODE_DAEMON_CRASH, 
         SCAN_MODE_SUBSYSTEM_CRASH, SCAN_MODE_UPLOAD_TNE]:
            TEST_LOGGER.info(f"当前扫描模式为{self._scan_mode}，需要获取TNE类型列表")
            self._get_tne_type_list = True
        else:
            submit_freeze_tne_in_monkey = self._default_config.get("submit_freeze_tne_in_monkey")
            TEST_LOGGER.info("提交黑屏定屏tne问题：{}".format(submit_freeze_tne_in_monkey))
            if submit_freeze_tne_in_monkey:
                TEST_LOGGER.info("submit_freeze_tne_in_monkey: True, 需要获取TNE类型列表")
                self._get_tne_type_list = True
            if self._get_tne_type_list:
                self._tne_tag_dict, self._freeze_tne_type_list, self._daemon_crash_tne_type_list, self._subsystem_crash_tne_type_list, self._app_crash_anr_tne_type_list = get_tne_tag_info_from_feishu()
                TEST_LOGGER.info(f"在线获取tne类型字典：{self._tne_tag_dict}")
                TEST_LOGGER.info(f"在线获取黑屏定屏tne类型列表：{self._freeze_tne_type_list}")
                TEST_LOGGER.info(f"在线获取daemon crash tne类型列表：{self._daemon_crash_tne_type_list}")
                TEST_LOGGER.info(f"在线获取子系统crash tne类型列表：{self._subsystem_crash_tne_type_list}")
                TEST_LOGGER.info(f"在线获取AppCrashANR tne类型列表：{self._app_crash_anr_tne_type_list}")
                if not self._freeze_tne_type_list:
                    TEST_LOGGER.info("在线获取黑屏定屏tne类型列表为空，尝试读取本地配置文件")
                    freeze_tne_type_file_path = PathManager.config_folder + os.sep + self._freeze_tne_type_file
                    if os.path.isfile(freeze_tne_type_file_path):
                        with open(freeze_tne_type_file_path, "r") as f:
                            tne_type_to_jira = json.load(f)
                            for value_list in tne_type_to_jira.values():
                                self._freeze_tne_type_list.extend(value_list)

                    else:
                        TEST_LOGGER.warn(f"黑屏定屏TNE提交开启，提交TNE类型文件不存在：{freeze_tne_type_file_path}")
                    TEST_LOGGER.info(f"此次扫描将扫描TNE文件：freeze_tne_type_list = {self._freeze_tne_type_list}")

    def _prj_key_in_config_dict(self, config_dict: dict) -> str:
        key_prj_android = self._target_project.lower() + "-" + str(self._android).lower()
        key_prj = self._target_project.lower()
        for key in config_dict.keys():
            if key_prj_android == key.lower():
                return key
                if key_prj == key.lower():
                    return key

        return

    def _get_scan_dir(self):
        """获取扫描目录"""
        error_msg = None
        
        if self._scan_root_dir:
            TEST_LOGGER.info("传入参数 scan_root_dir：{}，设为本次扫描目录".format(self._scan_root_dir))
        else:
            TEST_LOGGER.info("传入参数 scan_root_dir 为空，检查是否存在配置的扫描路径")
            if "scan_root_dir" in self._default_config and self._default_config["scan_root_dir"]:
                self._scan_root_dir = self._default_config["scan_root_dir"]
                TEST_LOGGER.info("获取配置文件中的扫描路径：{}，设为本次扫描目录".format(self._scan_root_dir))
            else:
                TEST_LOGGER.warn("配置文件中不存在 scan_root_dir，设置扫描目录为当前工具目录")
                self._scan_root_dir = self._cur_tool_dir
        
        # Jenkins 模式路径转换
        if self._scan_mode in [SCAN_MODE_JENKINS]:
            self._win_to_mnt_dict = self._default_config.get("win_to_mnt")
            if self._win_to_mnt_dict:
                is_convert_path = False
                for win_path, mnt_path in self._win_to_mnt_dict.items():
                    if win_path in self._scan_root_dir:
                        self._scan_root_dir = self._scan_root_dir.replace(win_path, mnt_path)
                        is_convert_path = True
                        break
                if is_convert_path:
                    TEST_LOGGER.info("替换后的扫描路径：{}".format(self._scan_root_dir))
        
        TEST_LOGGER.info("扫描路径：{}".format(self._scan_root_dir))
        self._scan_root_dir = self._scan_root_dir.strip().rstrip("\r\n")
        TEST_LOGGER.info("扫描路径，去除CR、LF、空格：{}".format(self._scan_root_dir))
        
        # 检查目录是否存在
        if not os.path.isdir(self._scan_root_dir):
            error_msg = f"扫描路径：{self._scan_root_dir} 不存在，请检查对应路径后，再次触发扫描或者手动扫描。"
            TEST_LOGGER.critical(error_msg)
            return (False, error_msg)
        
        self._scan_root_dir = os.path.abspath(self._scan_root_dir)
        return (True, None)

    @staticmethod
    def _scan_tne_dir_list(prj, prj_scan_path, scan_data):
        """
        扫描目录下的所有TNE解压目录
        :param prj:
        :param prj_scan_path:
        :param scan_data:
        :return:
        """
        TEST_LOGGER.info("********************" + f" 开始扫描项目{prj} 的tne目录 " + "********************")
        tne_dir_list, zs_dir_list = [], []
        expdb_dir_list = []
        tne_dir_regex = re.compile("0x[a|b|c|d|e|f|\\d]{8}_\\d{4}(_\\d{1,2}){5,6}$")
        for root, dirs, files in os.walk(prj_scan_path):
            for d in dirs:
                dir_path = os.path.join(root, d)
                if "0xffffff05" in dir_path:
                    TEST_LOGGER.warn(f"{dir_path} - 0xffffff05 问题不再解析，跳过")
                    continue
                if scan_data in dir_path:
                    if re.search(tne_dir_regex, dir_path):
                        is_zs_exist = False
                        for decompress_tne_file in os.listdir(dir_path):
                            if decompress_tne_file.endswith("zs"):
                                TEST_LOGGER.info("发现zs文件：{}".format(decompress_tne_file))
                                is_zs_exist = True
                                break

                        if is_zs_exist:
                            zs_dir_list.append(dir_path)
                        else:
                            tne_dir_list.append(dir_path)
                        cmdline = ["chmod", "777", dir_path]
                        exec_cmd(cmdline)
                    elif dir_path.endswith("files"):
                        expdb_dir_list.append(dir_path)

        TEST_LOGGER.info("********************" + f" 扫描项目{prj} 的tne目录已完成 " + "********************" + "\n")
        return (prj, tne_dir_list, zs_dir_list, expdb_dir_list)

    def _aee_to_data_list(self, aee_result_list, replace_path=False, special_build_prefix=None):
        """
        将aee解析结果转换成原始数据和去重后数据
        : param aee_result_list         需要去转换的aee类列表
        : param replace_path            是否替换path路径
        : param special_build_prefix    解析出的版本号前需要添加的前缀，用于提交jira非本项目库，防呆机制
        :return:
        """
        aee_rlt_list_org = []
        aee_rlt_list_final = []
        to_be_deleted_file_list = []
        nfc_too_close_file_list = []
        recognize_exception_list = []
        handle_recognize_failed_list = []
        top_apk_list = []
        if aee_result_list:
            if self._scan_mode in [SCAN_MODE_HWASAN, SCAN_MODE_HWASAN_PLATFORM]:
                top_apk_list = self._get_top_apk_list()
            for i in range(len(aee_result_list)):
                aee_result = aee_result_list[i]
                aee_result_attrs = aee_result.get_aee_attrs()
                attrs_path = aee_result_attrs[0]
                attrs_version = aee_result_attrs[1]
                attrs_exp_class = aee_result_attrs[3]
                attrs_exp_type = aee_result_attrs[4]
                attrs_cur_process = aee_result_attrs[5]
                attrs_package = aee_result_attrs[6]
                attrs_caused_by = str(aee_result_attrs[8])
                extra_tag = aee_result_attrs[9]
                attrs_activity = aee_result_attrs[11]
                attrs_device_id = aee_result_attrs[12] if len(aee_result_attrs) > 12 else None
                to_be_deleted_file_path = aee_result_attrs[0]
                if replace_path:
                    aee_result_attrs[0] = self._convert_path_to_win(attrs_path)
                # 处理版本号
                if attrs_version:
                    if special_build_prefix:
                        if not attrs_version.startswith(special_build_prefix):
                            aee_result_attrs[1] = f"{special_build_prefix}-{aee_result_attrs[1]}"
                            attrs_version = aee_result_attrs[1]
                else:
                    TEST_LOGGER.warn(f"日志解析版本为空，Path: {attrs_path}")
                    attrs_version = "VersionNone"
                    aee_result_attrs[1] = "VersionNone"
                if attrs_exp_class is None:
                    TEST_LOGGER.warn("日志解析exp_class为None，Path: {}".format(attrs_path))
                    attrs_exp_class = "ExpClassNone"
                    aee_result_attrs[3] = "ExpClassNone"
                if attrs_exp_type is None:
                    TEST_LOGGER.warn("日志解析exp_type为None，Path: {}".format(attrs_path))
                    attrs_exp_type = "ExpTypeNone"
                    aee_result_attrs[4] = "ExpTypeNone"
                if attrs_cur_process is None:
                    TEST_LOGGER.warn("日志解析cur_process为None，Path: {}".format(attrs_path))
                    attrs_cur_process = "CurProcessNone"
                    aee_result_attrs[5] = "CurProcessNone"
                if attrs_package is None:
                    TEST_LOGGER.warn("日志解析package为None，Path: {}".format(attrs_path))
                    attrs_package = "PackageNone"
                    aee_result_attrs[6] = "PackageNone"
                aee_result_attrs[8] = attrs_caused_by[:10000]
                attrs_caused_by = aee_result_attrs[8]
                if not aee_result.recognize_exception_rlt:
                    recognize_exception_list.append(attrs_path)
                if not aee_result.handle_recognize_rlt:
                    handle_recognize_failed_list.append(attrs_path)
                aee_rlt_list_org.append(list(aee_result_attrs))
                if self._scan_mode in [SCAN_MODE_HWASAN, SCAN_MODE_HWASAN_PLATFORM]:
                    if attrs_exp_class not in ('Native (NE)', 'Kernel (KE)'):
                        TEST_LOGGER.info(f"天网版本，AEE日志类型不符合要求，exp_class:{attrs_exp_class} Path: {attrs_path}")
                        to_be_deleted_file_list.append(to_be_deleted_file_path)
                        continue
                    if aee_result.is_ignore_ke_ne_hwasan():
                        TEST_LOGGER.info(f"天网版本，需要过滤的KE与NE，exp_class:{attrs_exp_class} Path: {attrs_path}")
                        to_be_deleted_file_list.append(to_be_deleted_file_path)
                        aee_result_attrs[3] = f"Ignored_hwasan_{attrs_exp_class}"
                        continue
                    if attrs_cur_process not in self._pkglist:
                        if attrs_cur_process in top_apk_list:
                            if not aee_result.is_ne_system_issue():
                                if "system_app" in attrs_exp_type or "product_app" in attrs_exp_type:
                                    TEST_LOGGER.debug("Package：[{}] Path：[{}] 判定为3RD APK系统问题，计入提单".format(attrs_package, attrs_path))
                            else:
                                to_be_deleted_file_list.append(to_be_deleted_file_path)
                                continue
                        else:
                            to_be_deleted_file_list.append(to_be_deleted_file_path)
                            continue
                elif self._scan_mode == SCAN_MODE_VIDEO_PLATFORM:
                    if any((substring in attrs_cur_process.lower() for substring in self._media_submit_key_list)):
                        pass  # 继续处理
                    elif any((exp_class_type in attrs_exp_class.lower() for exp_class_type in self._media_submit_exp_class_list)):
                        pass  # 继续处理
                    else:
                        continue  # 跳过不符合条件的
                # 检查白名单
                if not self._ignore_pkglist and attrs_cur_process not in self._pkglist:
                    # 不在白名单中，检查是否需要特殊处理
                    if self._scan_mode in [SCAN_MODE_PLATFORM, SCAN_MODE_DAILY]:
                        if "SIGSEGV" in attrs_exp_type:
                            to_be_deleted_file_list.append(to_be_deleted_file_path)
                            continue
                        if "data_app" in attrs_exp_type:
                            # data_app 类型，检查是否是 transsion 应用
                            if attrs_cur_process and "transsion" in attrs_cur_process.lower():
                                if attrs_cur_process not in self._report_history_list:
                                    if attrs_cur_process not in self._blacklist:
                                        self._new_app_info_list.append([attrs_cur_process, attrs_exp_type, attrs_path])
                                        post_report_history(attrs_cur_process)
                                        self._report_history_list.append(attrs_cur_process)
                                    else:
                                        to_be_deleted_file_list.append(to_be_deleted_file_path)
                                        continue
                                else:
                                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                                    continue
                            else:
                                to_be_deleted_file_list.append(to_be_deleted_file_path)
                                continue
                    else:
                        # 其他模式下，不在白名单中的直接跳过
                        to_be_deleted_file_list.append(to_be_deleted_file_path)
                        continue
                # 检查 com.android.emergency
                if attrs_package == "com.android.emergency":
                    if self._android is None:
                        if attrs_version:
                            regex_rlt = re.search(PATTERN_ANDROID_VERION, attrs_version)
                            if regex_rlt:
                                self._android = regex_rlt.group(1)
                                TEST_LOGGER.info(f"从版本：{attrs_version} 中解析出安卓版本：{self._android}")
                    if self._android:
                        if self._android.upper() > "S":
                            TEST_LOGGER.info(f"当前版本：{self._android}，T版本后，com.android.emergency 不计入提单问题")
                            continue
                # AD10 PR0 camera 问题过滤
                if "AD10" in attrs_path and "PR0" in attrs_path and "camera" in attrs_package:
                    TEST_LOGGER.debug("AD10, PR0 机器，camera 问题不计入提单问题")
                    continue
                # 预分析丢弃问题过滤
                if "discard_dbg" in attrs_package or "discard_db_file_map" in attrs_package:
                    TEST_LOGGER.debug(f"预分析丢弃问题，不计入去重后问题。Path:{attrs_path}")
                    continue
                # 无效问题过滤
                if "invalid_combo_wifi" in attrs_caused_by:
                    TEST_LOGGER.warn("combo_wifi 无效问题，不计入去重后问题。Path:{}".format(attrs_path))
                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                    continue
                if "unknown_app_crash" in attrs_caused_by:
                    TEST_LOGGER.warn("unknown_app_crash 问题，不计入去重后问题。Path:{}".format(attrs_path))
                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                    continue
                if "nfc_too_close" in attrs_caused_by:
                    TEST_LOGGER.warn("nfc_too_close 问题，不计入去重后问题。Path:{}".format(attrs_path))
                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                    nfc_too_close_file_list.append(attrs_path)
                    continue
                if "anr when screen off" in attrs_caused_by:
                    TEST_LOGGER.warn("anr 灭屏问题，不计入去重后问题。Path:{}".format(attrs_path))
                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                    continue
                if "can not find pid" in attrs_caused_by:
                    TEST_LOGGER.warn("pid=0 问题，不计入去重后问题。Path:{}".format(attrs_path))
                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                    continue
                # API 工厂模式过滤
                if "API" in attrs_path and self._scan_type == "factory":
                    to_be_deleted_file_list.append(to_be_deleted_file_path)
                    continue
                # fatal 问题特殊处理
                if "fatal" in attrs_path and "detailToBeDone" in attrs_caused_by:
                    aee_rlt_list_final.append(self._build_aee_final_attrs(aee_result_attrs))
                    continue
                # FUZZ 模式过滤
                if self._scan_mode in [SCAN_MODE_FUZZ, SCAN_MODE_FUZZ_PLATFORM]:
                    fuzz_error_flag = True
                    if attrs_exp_class == "Native (NE)" and "liblspatch.so" in aee_result_attrs[7]:
                        fuzz_error_flag = False
                    if attrs_exp_class == "Java (JE)":
                        if "Caused by: java.lang.UnsatisfiedLinkError:*already opened by ClassLoader" in aee_result_attrs[7]:
                            fuzz_error_flag = False
                        if "Caused by: java.lang.ClassNotFoundException:" in aee_result_attrs[7]:
                            fuzz_error_flag = False
                        if "com.fuzz.test.*" in aee_result_attrs[7]:
                            fuzz_error_flag = False
                    if fuzz_error_flag is False:
                        to_be_deleted_file_list.append(to_be_deleted_file_path)
                        continue
                # 去重逻辑
                # 注意：原始代码使用 pass 而不是 continue，意味着即使条件不满足也会继续执行相似度计算
                # 这里保持与原始 exe 一致的行为
                if len(aee_rlt_list_final) == 0:
                    aee_rlt_list_final.append(self._build_aee_final_attrs(aee_result_attrs))
                    continue
                current_aee_final_length = len(aee_rlt_list_final)
                is_duplicate = False
                for j in range(current_aee_final_length):
                    final_attrs = aee_rlt_list_final[j]
                    final_exp_class = final_attrs[3]
                    final_cur_process = final_attrs[5]
                    final_package = final_attrs[6]

                    if final_exp_class != attrs_exp_class:
                        continue

                    # 所有 AEE 类型去重前都必须同包名，避免跨应用误聚合。
                    if final_package != attrs_package:
                        continue

                    # 版本不同则跳过（但原始代码用 pass，所以这里也不跳过）
                    # 原始代码逻辑：if not attrs_version == "VersionNone": if attrs_version != ...: pass
                    # 这意味着只有当 attrs_version == "VersionNone" 时才跳过版本检查
                    # 否则如果版本不同，用 pass 继续执行
                    
                    # ANR 类型检查 activity（原始代码也用 pass）
                    # 这里简化为：直接计算相似度，不做前置检查
                    
                    # 计算相似度
                    try:
                        str_1 = final_attrs[8]
                        ratio = get_str_similar(str_1, attrs_caused_by)
                        if ratio >= self._ratio_std_aee:
                            aee_rlt_list_final[j][10] = aee_rlt_list_final[j][10] + 1
                            self._merge_aee_final_device_id(aee_rlt_list_final[j], attrs_device_id)
                            attrs_rom_ram = aee_result_attrs[14] if len(aee_result_attrs) > 14 else ""
                            self._merge_aee_final_rom_ram(aee_rlt_list_final[j], attrs_rom_ram)
                            is_duplicate = True
                            break
                    except:
                        pass
                # 如果不是重复，添加到最终列表
                if not is_duplicate:
                    aee_rlt_list_final.append(self._build_aee_final_attrs(aee_result_attrs))

            if len(self._new_app_info_list) > 0:
                try:
                    report_history_file_path = PathManager.config_folder + os.sep + self._report_history_file
                    with open(report_history_file_path, "a", errors="ignore") as f:
                        for new_app_info in self._new_app_info_list:
                            f.write(new_app_info[0] + "\n")

                except:
                    pass

                if self._new_app_mail_list:
                    if not self._new_app_noticed:
                        self._send_new_app_mail()
                        self._new_app_noticed = True
            if nfc_too_close_file_list:
                send_msg_by_feishu_robot("已过滤疑似NFC过近导致问题：\n", "\\" + "\n\\".join(nfc_too_close_file_list), "NFC 过近问题过滤提醒")
            if recognize_exception_list:
                send_msg_by_feishu_robot("解析库解析异常日志路径：\n", "\\" + "\n\\".join(recognize_exception_list), f"日志解析库解析异常提醒 {RECOGNIZE_LIB_VERSION}")
            if handle_recognize_failed_list:
                send_msg_by_feishu_robot("解析库返回内容处理异常日志路径：\n", "\\" + "\n\\".join(handle_recognize_failed_list), f"解析库返回内容处理异常提醒 {RECOGNIZE_LIB_VERSION}")
            if aee_rlt_list_final:
                for aee_rlt in aee_rlt_list_final:
                    aee_rlt[6] = "3RD Application " + aee_rlt[6] if (aee_rlt[6] in top_apk_list and aee_rlt[6] not in self._pkglist) else (aee_rlt[6])

        return (
         aee_rlt_list_org, aee_rlt_list_final, to_be_deleted_file_list)

    def _tne_to_data_list(self, tne_result_list, replace_path=False):
        """
        将tne解析结果转化成原始数据和去重后数据
        :param tne_result_list:
        :return:
        """
        tne_rlt_list_org = []
        tne_rlt_list_final = []
        regex_version_date = re.compile("-(\\d{6})V")
        if tne_result_list:
            for i in range(len(tne_result_list)):
                tne_result = tne_result_list[i]
                tne_result_attrs = tne_result.get_tne_attrs()
                attrs_path = tne_result_attrs[0]
                version_org = tne_result_attrs[1]
                exp_type_org = tne_result_attrs[4]
                package_org = tne_result_attrs[6]
                attrs_caused_by_org = tne_result_attrs[8]
                if replace_path:
                    tne_result_attrs[0] = self._convert_path_to_win(attrs_path)
                attrs_caused_by = str(tne_result_attrs[8])
                tne_result_attrs[8] = attrs_caused_by
                tne_rlt_list_org.append(tne_result_attrs)
                current_tne_final_length = len(tne_rlt_list_final)
                if current_tne_final_length == 0:
                    tne_rlt_list_final.append(tne_result_attrs)
                    continue
                if not ("TNE_ERROR_file_missing" in exp_type_org and attrs_caused_by_org == "undefined"):
                    if attrs_caused_by_org is None:
                        tne_rlt_list_final.append(tne_result_attrs)
                        continue
                    for j in range(current_tne_final_length):
                        if tne_rlt_list_final[j][4] == exp_type_org and tne_rlt_list_final[j][6] == package_org:
                            str_1 = str(tne_rlt_list_final[j][8])
                            format_str = True
                            if exp_type_org in ('0xffffff0d_hwt', '0xffffff0c_hang_detect'):
                                format_str = False
                            absolute_equal = False
                            if exp_type_org in self._freeze_tne_type_list or exp_type_org in self._subsystem_crash_tne_type_list:
                                absolute_equal = True
                            if exp_type_org in ('0xffffff32', '0x007a0050'):
                                if "***FoundStackInfo***" in attrs_caused_by_org:
                                    absolute_equal = False
                            ratio = get_str_similar(str_1, attrs_caused_by_org, format_str=format_str, absolute_equal=absolute_equal)
                            if ratio >= self._ratio_std_tne:
                                count = tne_rlt_list_final[j][11] + 1
                                version_final = tne_rlt_list_final[j][2]
                                try:
                                    version_date_org = re.search(regex_version_date, version_org).group(1)
                                    version_date_final = re.search(regex_version_date, version_final).group(1)
                                    if version_date_org > version_date_final:
                                        tne_rlt_list_final[j] = tne_rlt_list_org[i]
                                except:
                                    pass

                                tne_rlt_list_final[j][11] = count
                                break
                            if j == current_tne_final_length - 1:
                                tne_rlt_list_final.append(tne_rlt_list_org[i])

        return (
         tne_rlt_list_org, tne_rlt_list_final)

    @staticmethod
    def get_statistics(aee_rlt_list):
        total_count = 0
        hwt_count = 0
        swt_count = 0
        ke_count = 0
        ne_count = 0
        je_count = 0
        anr_count = 0
        hang_count = 0
        fatal_ne = 0
        fatal_je = 0
        ee_combo_count = 0
        ee_modem_count = 0
        other_count = 0
        if aee_rlt_list:
            total_count = len(aee_rlt_list)
            for aee_rlt in aee_rlt_list:
                exp_path = aee_rlt[0]
                exp_class = aee_rlt[3].strip()
                exp_type = aee_rlt[4].strip()
                if "HANG" in exp_class:
                    hang_count += 1
                    continue
                if not exp_class == "HWT":
                    if exp_class == "Hardware Reboot":
                        hwt_count += 1
                        continue
                    if exp_class == "SWT":
                        swt_count += 1
                        continue
                    if exp_class == "Kernel (KE)":
                        ke_count += 1
                        continue
                    if exp_class == "Native (NE)":
                        if "fatal" in exp_path:
                            fatal_ne += 1
                            continue
                        else:
                            ne_count += 1
                            continue
                    if exp_class == "Java (JE)":
                        if "fatal" in exp_path:
                            fatal_je += 1
                            continue
                        else:
                            je_count += 1
                            continue
                    if exp_class == "ANR":
                        anr_count += 1
                        continue
                    if exp_class == "External (EE)":
                        if exp_type == "combo":
                            ee_combo_count += 1
                            continue
                        if exp_type == "modem":
                            ee_modem_count += 1
                            continue
                    other_count += 1

        a_total = hwt_count + swt_count + ke_count + hang_count + fatal_ne + fatal_je + ee_modem_count
        b_total = je_count + ne_count
        c_total = anr_count + ee_combo_count
        a_b_c_sum = a_total + b_total + c_total
        statistics_msg = f"total_count：{total_count}"
        statistics_msg += f"\na_total：{a_total}"
        statistics_msg += f"\nb_total：{b_total}"
        statistics_msg += f"\nc_total：{c_total}"
        statistics_msg += f"\na_b_c_sum：{a_b_c_sum}"
        statistics_msg += f"\nother_count：{other_count}"
        statistics_msg += f"\nswt_count：{swt_count}"
        statistics_msg += f"\nhwt_count：{hwt_count}"
        statistics_msg += f"\nke_count：{ke_count}"
        statistics_msg += f"\nhang_count：{hang_count}"
        statistics_msg += f"\nfatal_ne：{fatal_ne}"
        statistics_msg += f"\nfatal_je：{fatal_je}"
        statistics_msg += f"\nee_modem_count：{ee_modem_count}"
        statistics_msg += f"\nje_count：{je_count}"
        statistics_msg += f"\nne_count：{ne_count}"
        statistics_msg += f"\nanr_count：{anr_count}"
        statistics_msg += f"\nee_combo_count：{ee_combo_count}"
        return [
         total_count, a_total, b_total, c_total, a_b_c_sum, 
         other_count, swt_count, hwt_count, ke_count, hang_count, 
         fatal_ne, fatal_je, ee_modem_count, je_count, ne_count, anr_count, 
         ee_combo_count, statistics_msg]

    @staticmethod
    def is_reboot_issue(exp_class, exp_path):
        if exp_class:
            if "HANG" in exp_class:
                return True
                if exp_class in ('SWT', 'HWT', 'Hardware Reboot', 'Kernel (KE)'):
                    return True
            elif exp_class == "Native (NE)":
                if "fatal" in exp_path:
                    return True
            if exp_class == "Java (JE)" and "fatal" in exp_path:
                return True
        return False

    def _analyse_db_file_map(self, device_list=None):
        """
        检查DBFileMap文件，预分析中间记录的问题
        :param device_list: 设备列表，如果传入，则只分析列表中设备的问题
        :return:
        stop_scan: 是否因为问题数过多而需要停止扫描
        exception_zip_list: 经过解析，需要解压分析的zip文件列表
        discard_dbg_info_list: 经过分析，丢弃的问题信息列表
        """
        TEST_LOGGER.info("******************** 开始预分析DBFileMap文件 ********************")
        stop_scan = False
        exception_zip_list = []
        discard_dbg_info_list = []
        db_file_map_path = None
        pattern_mtbf = re.compile("(.*MTBF-log)[\\\\|/](\\d+_\\d+)")
        regex_rlt = re.match(pattern_mtbf, self._scan_root_dir)
        if regex_rlt:
            mtbf_dir_path = regex_rlt.group(1)
            mtbf_dir_timestamp = regex_rlt.group(2)
            TEST_LOGGER.info(f"截取MTBF目录路径：{mtbf_dir_path}, 目录时间戳：{mtbf_dir_timestamp}")
            db_file_map_path = os.path.dirname(mtbf_dir_path) + os.sep + "KT-log" + os.sep + "DBFileMap"
        elif db_file_map_path and os.path.isfile(db_file_map_path):
            TEST_LOGGER.info(f"发现 DBFileMap 文件：{db_file_map_path}")
            total_exception_count = 0
            unknown_process_dict = {}
            whitelist_dict = {}
            discard_dict = {}
            TEST_LOGGER.info(f"开始分析DBFileMap文件中，{self._scan_date_formatted_aee} 产生的问题")
            with open(db_file_map_path, "r", encoding="utf-8", errors="ignore") as db_file_map:
                for line in db_file_map.readlines():
                    line = line.strip()
                    if mtbf_dir_timestamp in line:
                        if self._scan_date_formatted_aee in line:
                            split_line = line.split("ZZ_INTERNAL")
                            if len(split_line) < 2:
                                continue
                    if device_list:
                        if not any((device in line for device in device_list)):
                            continue
                        exception_zip_path = re.sub("[\\\\|/]data[\\\\|/].*", "_exception.zip", split_line[0])
                        converted_exception_zip_path = self._convert_path_to_win(exception_zip_path)
                        exception_dir_path = re.sub("[\\\\|/]data[\\\\|/].*", "_exception", split_line[0])
                        converted_exception_dir_path = self._convert_path_to_win(exception_dir_path)
                        if os.path.isfile(exception_zip_path):
                            file_path = exception_zip_path
                            win_path = converted_exception_zip_path
                            total_exception_count += 1
                        else:
                            if os.path.isfile(converted_exception_zip_path):
                                file_path = converted_exception_zip_path
                                win_path = converted_exception_zip_path
                                total_exception_count += 1
                            else:
                                if os.path.isdir(exception_dir_path):
                                    file_path = exception_dir_path
                                    win_path = converted_exception_dir_path
                                    total_exception_count += 1
                                else:
                                    if os.path.isdir(converted_exception_dir_path):
                                        file_path = converted_exception_dir_path
                                        win_path = converted_exception_dir_path
                                        total_exception_count += 1
                                    else:
                                        continue
                                    exception_info_str = split_line[-1].strip()
                                    try:
                                        db_file_map = DbFileMap(exception_info_str, file_path, win_path)
                                    except:
                                        TEST_LOGGER.error(f"解析DBFileMap文件:{file_path} 时发生异常，异常行：{line}")
                                        continue

                                    cur_process = db_file_map.cur_process
                                    exp_time = db_file_map.exp_time
                                    exp_type = db_file_map.exp_type
                                    exp_class = db_file_map.exp_class
                                    if exp_class in ('Kernel API Dump', ):
                                        whitelist_dict.setdefault(f"{exp_class}: {exp_class}", []).append(db_file_map)
                                        continue
                                    if cur_process in ('PROCESS_UNKNOWN', 'PROCESS_KE',
                                                       'SYSTEM_API_DUMP'):
                                        unknown_process_dict.setdefault(f"{cur_process}: {exp_class}", []).append(db_file_map)
                                        continue
                                    if self._ignore_pkglist or cur_process in self._pkglist or "fatal" in exception_zip_path:
                                        whitelist_dict.setdefault(f"{cur_process}: {exp_class}", []).append(db_file_map)
                                        continue
                                    discard_dict.setdefault(cur_process, []).append(db_file_map)
                                    discard_dbg_info_list.append([file_path, 'discard_db_file_map_exception', 
                                     exp_time, 
                                     exp_class, 
                                     exp_type, 
                                     cur_process, 
                                     'discard_db_file_map_package', 
                                     'discard_db_file_map_detail', 
                                     'discard_db_file_map_caused_by', 
                                     'discard_db_file_map_extra_tag', 
                                     1, 'discard_db_file_map_activity', 'discard_device_id'])

            if unknown_process_dict or whitelist_dict:
                process_count_dict = {}
                db_file_map_to_be_analysed = []
                unhandled_db_file_map = []
                TEST_LOGGER.info(f"经过解析，DBFileMap 中需要分析的问题个数：{total_exception_count}")
                one_db_file_map = None
                if self._scan_mode not in [SCAN_MODE_CAMERA_PLATFORM, SCAN_MODE_VIDEO_PLATFORM]:
                    for process_name, db_file_map_list in unknown_process_dict.items():
                        db_file_map_count = len(db_file_map_list)
                        one_db_file_map = db_file_map_list[0]
                        TEST_LOGGER.info(f"未知进程：{process_name} 的DBFileMap记录个数：{db_file_map_count}")
                        win_path = one_db_file_map.win_path
                        process_count_dict[process_name] = [db_file_map_count, win_path]
                        if db_file_map_count > self._max_single_dbg_number:
                            if process_name == "PROCESS_KE":
                                TEST_LOGGER.info(f"进程：{process_name} 的个数：{db_file_map_count}，大于单进程最大个数：{self._max_single_dbg_number}，当前保留真实数据，不再截断")
                                db_file_map_to_be_analysed.extend(db_file_map_list)
                            else:
                                db_file_map_to_be_analysed.extend(db_file_map_list)
                        else:
                            db_file_map_to_be_analysed.extend(db_file_map_list)

                for process_name, db_file_map_list in whitelist_dict.items():
                    db_file_map_count = len(db_file_map_list)
                    one_db_file_map = db_file_map_list[0]
                    TEST_LOGGER.info("白名单进程：{} 的DBFileMap记录个数：{}".format(process_name, db_file_map_count))
                    win_path = one_db_file_map.win_path
                    process_count_dict[process_name] = [db_file_map_count, win_path]
                    if db_file_map_count > self._max_single_dbg_number:
                        TEST_LOGGER.info(f"进程：{process_name} 的个数：{db_file_map_count}，大于单进程最大个数：{self._max_single_dbg_number}，当前保留真实数据，不再截断")
                        db_file_map_to_be_analysed.extend(db_file_map_list)
                    else:
                        db_file_map_to_be_analysed.extend(db_file_map_list)

                send_mail = False
                to_be_analysed_number = len(db_file_map_to_be_analysed)
                if False and to_be_analysed_number > self._max_dbg_number and self._stop_if_too_many:
                    TEST_LOGGER.warn(f"经过解析，需要处理的问题总数：{to_be_analysed_number} 大于最大处理问题数：{self._max_dbg_number}")
                    stop_scan = False
                    scan_status_str = "日志扫描终止"
                    send_mail = False
                else:
                    TEST_LOGGER.info("本次预计处理问题共：{}个".format(to_be_analysed_number))
                    unhandled_number = len(unhandled_db_file_map)
                    if unhandled_number > 0:
                        TEST_LOGGER.info("因单个进程问题过多，不做处理问题共：{}个".format(unhandled_number))
                    else:
                        TEST_LOGGER.info("当前保留全部真实数据，未因单进程阈值丢弃问题")
                    if unhandled_number > 0:
                        send_mail = True
                        scan_status_str = "日志扫描告警"
                    if send_mail:
                        if self._send_warning_mail:
                            if self._build_version:
                                build_version = self._build_version
                            else:
                                build_version = "UnknownBuild"
                                try:
                                    if one_db_file_map:
                                        file_path = one_db_file_map.file_path
                                        if file_path.endswith(".zip"):
                                            TEST_LOGGER.info(f"对文件：{file_path}进行解压")
                                            unzip_dir_path = unzip(self._unzip, file_path, False)
                                            TEST_LOGGER.info(f"解压后，文件路径为：{unzip_dir_path}")
                                        else:
                                            unzip_dir_path = file_path
                                        if unzip_dir_path:
                                            if os.path.isdir(unzip_dir_path):
                                                TEST_LOGGER.info(f"在目录：{unzip_dir_path}中查找dbg文件")
                                                dbg_file_path = None
                                                for root, dirs, files in os.walk(unzip_dir_path):
                                                    for file in files:
                                                        if file.lower().endswith(".dbg"):
                                                            dbg_file_path = os.path.join(root, file)
                                                            TEST_LOGGER.info(f"发现dbg文件：{dbg_file_path}")
                                                            break

                                                if dbg_file_path:
                                                    TEST_LOGGER.info("解压dbg文件，并获取版本信息")
                                                    aee_extract(self._aee_extract, dbg_file_path, timeout=self._extract_dbg_time_out)
                                                    sys_properties_file_path = None
                                                    for root, dirs, files in os.walk(os.path.dirname(dbg_file_path)):
                                                        for file in files:
                                                            if file == "SYS_PROPERTIES":
                                                                sys_properties_file_path = os.path.join(root, file)
                                                                break

                                                    if sys_properties_file_path:
                                                        sys_properties = SysProperties(sys_properties_file_path)
                                                        build_version = sys_properties.build_version
                                            else:
                                                TEST_LOGGER.warn(f"dbg解压目录：{unzip_dir_path} 中未发现dbg文件，无法获取版本信息")
                                        else:
                                            TEST_LOGGER.warn(f"dbg解压目录不存在：{unzip_dir_path}，无法获取版本信息")
                                    else:
                                        TEST_LOGGER.warn("未发现有效的DBFileMap记录，无法获取版本信息")
                                except:
                                    TEST_LOGGER.warn(f"获取版本信息时发生异常：\n{traceback.format_exc()}")

                                subject = f"【{scan_status_str}】【{self._scan_site}】【{build_version}】【DBFileMap异常信息数： {to_be_analysed_number}】【{self._hostname}】【{self._report_date_formatted}】"
                                converted_path = self._convert_path_to_win(self._scan_root_dir)
                                content_desc = f"扫描工具版本：{VERSION}\n\n"
                                content_desc = content_desc + f"扫描路径：{converted_path}\n\n"
                                content_desc = content_desc + f"测试版本：{build_version}\n"
                                content_desc = content_desc + f"DBFileMap文件记录问题总数：{total_exception_count}\n"
                                content_desc = content_desc + f"需要处理的问题数：{to_be_analysed_number}\n"
                                content_desc = content_desc + f"最大限定dbg问题阈值：{self._max_dbg_number}，单进程最大限定dbg问题阈值：{self._max_single_dbg_number}\n"
                                sorted_process_count_list = sorted((process_count_dict.items()), key=(lambda x: x[1][0]), reverse=True)
                                content = content_desc + "\n\n" + "********************" + "\n" + "DBFileMap 进程信息" + "\n" + "********************"
                                for process_name, (db_file_map_count, win_path) in sorted_process_count_list[:20]:
                                    content = content + f"\n进程：{process_name}\n问题个数：{db_file_map_count}\n文件：{win_path}\n"

                                if build_version and "-" in build_version:
                                    project_tag = build_version.rsplit("-", 1)[0]
                                    _, _, mail_list = self._get_jira_project(project_tag)
                                    if mail_list:
                                        self._warning_mail_list.extend(re.findall(PATTERN_MAIL, mail_list))
                                elif self._warning_mail_list:
                                    sendMail(subject, content, self._warning_mail_list)
                                else:
                                    TEST_LOGGER.warn("异常告警邮件通知人列表为空，不发送通知邮件")
                    TEST_LOGGER.info("解析获取需要解压的zip文件列表")
                    for db_file_map in db_file_map_to_be_analysed:
                        file_path = db_file_map.file_path
                        if str(file_path).lower().endswith(".zip"):
                            exception_zip_list.append(file_path)

            else:
                TEST_LOGGER.warn(f"DBFileMap 文件：{db_file_map_path} 未发现白名单或者未知进程的异常信息")
        else:
            TEST_LOGGER.warn(f"未发现 DBFileMap 文件：{db_file_map_path}")
        TEST_LOGGER.info("******************** 预分析DBFileMap文件 已完成 ********************\n")
        return (stop_scan, exception_zip_list, discard_dbg_info_list)

    def _pre_analyse_dbg(self, org_dbg_file_list):
        """
        在解压dbg文件前，预先读取dbg文件所在目录的ZZ_INTERNAL 文件，检查发生问题的cur_process 是否在白名单中
        如果不在，则将该dbg文件移除解压列表
        :return:
        stop_scan: 是否因为问题数过多而需要停止扫描
        zz_list_to_be_analysed: 本次解析需要解压的ZZ_INTERNAL list
        discard_dbg_info_list: 非白名单丢弃日志的详细信息
        """
        TEST_LOGGER.info("******************** 开始预分析dbg列表的ZZ_INTERNAL ********************")
        stop_scan = False
        zz_list_to_be_analysed = []
        discard_dbg_info_list = []
        unknown_process_zz_dict = {}
        whitelist_zz_dict = {}
        discard_zz_dict = {}
        zz_list_file = datetime.datetime.now().strftime("ZZ_INTERNAL_file_list_%Y_%m_%d_%H_%M_%S.txt")
        zz_list_file_path = PathManager.tmp_folder + os.sep + zz_list_file
        with open(zz_list_file_path, "a") as f:
            for dbg_file in org_dbg_file_list:
                TEST_LOGGER.debug("尝试解析：{} 的ZZ_INTERNAL文件".format(dbg_file))
                converted_dbg_file = self._convert_path_to_win(dbg_file)
                zz_internal_file_path = os.path.join(os.path.dirname(dbg_file), "ZZ_INTERNAL")
                zz_internal = ZZ_internal(zz_internal_file_path, dbg_file, converted_dbg_file)
                if os.path.isfile(zz_internal_file_path):
                    cur_process = zz_internal.cur_process
                    exp_type = zz_internal.exp_type
                    exp_time = zz_internal.exp_time
                    exp_class = zz_internal.exp_class
                    ota_ke = zz_internal.ota_ke
                    f.write("{}：{}\n".format(cur_process, converted_dbg_file))
                    if self._scan_mode == SCAN_MODE_OTA_DAILY or self._task_tag == "otalab":
                        if "KE" in os.path.basename(dbg_file):
                            TEST_LOGGER.info(f"ota_ke: {ota_ke}")
                            if ota_ke:
                                TEST_LOGGER.info(f"OTA扫描，KE文件需要被过滤：{dbg_file}")
                                discard_zz_dict.setdefault(cur_process, []).append(zz_internal)
                                discard_dbg_info_list.append([
                                 dbg_file, "discard_ota_ke_dbg_version", exp_time, exp_class, exp_type, cur_process,
                                 "discard_ota_ke_dbg_package", "discard_ota_ke_dbg_detail", "discard_ota_ke_dbg_caused_by",
                                 "discard_ota_ke_dbg_extra_tag", 1, "discard_ota_ke_dbg_activity", "discard_device_id"])
                                continue
                    if exp_class in ('Kernel API Dump',):
                        unknown_process_zz_dict.setdefault(f"{exp_class}: {exp_class}", []).append(zz_internal)
                        continue
                    if cur_process in ('PROCESS_UNKNOWN', 'PROCESS_KE', 'SYSTEM_API_DUMP'):
                        unknown_process_zz_dict.setdefault(f"{cur_process}: {exp_class}", []).append(zz_internal)
                        continue
                    elif self._scan_mode == SCAN_MODE_CAMERA_PLATFORM:
                        if cur_process in self._pkglist:
                            whitelist_zz_dict.setdefault(f"{cur_process}: {exp_class}", []).append(zz_internal)
                            continue
                    elif self._scan_mode == SCAN_MODE_VIDEO_PLATFORM:
                        if any((substring in cur_process.lower() for substring in self._media_submit_key_list)):
                            whitelist_zz_dict.setdefault(f"{cur_process}: {exp_class}", []).append(zz_internal)
                            continue
                        if any((exp_class_type in exp_class.lower() for exp_class_type in self._media_submit_exp_class_list)):
                            whitelist_zz_dict.setdefault(f"{cur_process}: {exp_class}", []).append(zz_internal)
                            continue
                    elif self._ignore_pkglist or cur_process in self._pkglist or "fatal" in dbg_file:
                        whitelist_zz_dict.setdefault(f"{cur_process}: {exp_class}", []).append(zz_internal)
                        continue
                    discard_zz_dict.setdefault(cur_process, []).append(zz_internal)
                    discard_dbg_info_list.append([
                     dbg_file, "discard_dbg_version", exp_time, exp_class, exp_type, cur_process,
                     "discard_dbg_package", "discard_dbg_detail", "discard_dbg_caused_by", "discard_dbg_extra_tag", 1, "discard_dbg_activity", "discard_device_id"])
                else:
                    TEST_LOGGER.debug("ZZ_INTERNAL 文件不存在，dbg需解压")
                    unknown_process_zz_dict.setdefault("ZZ_INTERNAL_MISSING", []).append(zz_internal)
                    f.write(f"ZZ_INTERNAL_MISSING：{converted_dbg_file}\n")

        if unknown_process_zz_dict or whitelist_zz_dict:
            org_dbg_file_number = len(org_dbg_file_list)
            unhandled_zz_list = []
            process_count_dict = {}
            if self._scan_mode not in [SCAN_MODE_CAMERA_PLATFORM, SCAN_MODE_VIDEO_PLATFORM]:
                for process_name, zz_internal_list in unknown_process_zz_dict.items():
                    zz_internal_count = len(zz_internal_list)
                    TEST_LOGGER.info("未知进程：{} 的dbg文件个数：{}".format(process_name, zz_internal_count))
                    dbg_file_path_win = zz_internal_list[0].win_path
                    process_count_dict[process_name] = [zz_internal_count, dbg_file_path_win]
                    if zz_internal_count > self._max_single_dbg_number:
                        if process_name == "PROCESS_KE":
                            TEST_LOGGER.info("进程：{} 的个数：{}，大于单进程最大个数：{}，当前保留真实数据，不再截断".format(process_name, zz_internal_count, self._max_single_dbg_number))
                            zz_list_to_be_analysed.extend(zz_internal_list)
                        else:
                            zz_list_to_be_analysed.extend(zz_internal_list)
                    else:
                        zz_list_to_be_analysed.extend(zz_internal_list)

            for process_name, zz_internal_list in whitelist_zz_dict.items():
                zz_internal_count = len(zz_internal_list)
                TEST_LOGGER.info("白名单进程：{} 的dbg文件个数：{}".format(process_name, zz_internal_count))
                for zz_internal in zz_internal_list:
                    TEST_LOGGER.info(f"{zz_internal.dbg_path}")

                dbg_file_path_win = zz_internal_list[0].win_path
                process_count_dict[process_name] = [zz_internal_count, dbg_file_path_win]
                if zz_internal_count > self._max_single_dbg_number:
                    TEST_LOGGER.info("进程：{} 的个数：{}，大于单进程最大个数：{}，当前保留真实数据，不再截断".format(process_name, zz_internal_count, self._max_single_dbg_number))
                    zz_list_to_be_analysed.extend(zz_internal_list)
                else:
                    zz_list_to_be_analysed.extend(zz_internal_list)

            send_mail = False
            to_be_analysed_number = len(zz_list_to_be_analysed)
            if False and to_be_analysed_number > self._max_dbg_number and self._stop_if_too_many:
                TEST_LOGGER.warn("经处理后，本次处理问题个数：{} 大于最大个数：{}，退出解析".format(to_be_analysed_number, self._max_dbg_number))
                stop_scan = False
                scan_status_str = "日志扫描终止"
                send_mail = False
            else:
                if self._limit_dbg_count > 0 and to_be_analysed_number > self._limit_dbg_count:
                    TEST_LOGGER.info("预分析后待处理问题共 {} 个，超过限制 {} 个，截断至 {}".format(to_be_analysed_number, self._limit_dbg_count, self._limit_dbg_count))
                    zz_list_to_be_analysed = zz_list_to_be_analysed[:self._limit_dbg_count]
                    to_be_analysed_number = self._limit_dbg_count
                TEST_LOGGER.info("本次预计处理问题共：{}个".format(to_be_analysed_number))
                unhandled_number = len(unhandled_zz_list)
                if unhandled_number > 0:
                    TEST_LOGGER.info("因单个进程问题过多，不做处理问题共：{}个".format(unhandled_number))
                else:
                    TEST_LOGGER.info("当前保留全部真实数据，未因单进程阈值丢弃问题")
                if unhandled_number > 0:
                    scan_status_str = "日志扫描告警"
                    send_mail = True
                if send_mail and self._send_warning_mail:
                    if self._build_version:
                        build_version = self._build_version
                    else:
                        build_version = "UnknownBuild"
                        try:
                            zz_internal = zz_list_to_be_analysed[0]
                            aee_extract(self._aee_extract, zz_internal.dbg_path, timeout=self._extract_dbg_time_out)
                            sys_properties_file_path = None
                            for root, dirs, files in os.walk(os.path.dirname(zz_internal.dbg_path)):
                                for file in files:
                                    if file == "SYS_PROPERTIES":
                                        sys_properties_file_path = os.path.join(root, file)
                                        break

                            if sys_properties_file_path:
                                sys_properties = SysProperties(sys_properties_file_path)
                                build_version = sys_properties.build_version
                        except:
                            TEST_LOGGER.info(traceback.format_exc())

                        subject = f"【{self._scan_site}】【{scan_status_str}】【{build_version}】【dbg文件 {to_be_analysed_number}】【{self._hostname}】【{self._report_date_formatted}】"
                        converted_path = self._convert_path_to_win(self._scan_root_dir)
                        content_desc = "扫描工具版本：{}\n\n".format(VERSION)
                        content_desc = content_desc + "扫描路径：{}\n\n".format(converted_path)
                        content_desc = content_desc + "测试版本：{}\n".format(build_version)
                        content_desc = content_desc + "原始dbg文件总数：{}\n".format(org_dbg_file_number)
                        content_desc = content_desc + "需处理dbg文件数：{}\n".format(to_be_analysed_number)
                        content_desc = content_desc + "最大限定dbg问题阈值：{}，单进程最大限定dbg问题阈值：{}\n".format(self._max_dbg_number, self._max_single_dbg_number)
                        sorted_process_count_list = sorted((process_count_dict.items()), key=(lambda x: x[1][0]), reverse=True)
                        content = content_desc + "\n\n" + "********************" + "\n" + "dbg 进程信息" + "\n" + "********************"
                        for process_name, (zz_internal_count, dbg_file_path_win) in sorted_process_count_list[:20]:
                            content = content + "\n进程：{}\n问题个数：{}\ndbg文件：{}\n".format(process_name, zz_internal_count, dbg_file_path_win)

                        if build_version and "-" in build_version:
                            project_tag = build_version.rsplit("-", 1)[0]
                            _, _, mail_list = self._get_jira_project(project_tag)
                            if mail_list:
                                self._warning_mail_list.extend(re.findall(PATTERN_MAIL, mail_list))
                            if self._warning_mail_list:
                                sendMail(subject, content, self._warning_mail_list)
                        else:
                            TEST_LOGGER.warn("异常告警邮件通知人列表为空，不发送通知邮件")
        else:
            TEST_LOGGER.warn("经过预分析dbg的ZZ_INTERNAL文件，未发现白名单或者未知进程的异常信息")
        TEST_LOGGER.info("******************** 预分析dbg列表的ZZ_INTERNAL 已完成 ********************\n")
        return (stop_scan, zz_list_to_be_analysed, discard_dbg_info_list)

    def _convert_path_to_win(self, log_path):
        """
        将传入的日志路径转换为windows可访问路径
        :param log_path:
        :return:
        """
        if log_path.startswith("/") and self._archive_address and self._replace_index:
            attrs_path_split = log_path.split("/")
            converted_log_path = self._archive_address + "\\".join(attrs_path_split[self._replace_index:])
        else:
            converted_log_path = log_path
        return converted_log_path

    @staticmethod
    def _save_discard_to_org(aee_rlt_list_org, discard_dbg_info_list):
        for discard_dbg_info in discard_dbg_info_list:
            aee_rlt_list_org.append(discard_dbg_info)

        return aee_rlt_list_org

    def _unzip_aee_exceptions(self, unzip_file_list=None):
        """
        解压mtklog zip文件
        :return:
        """
        if unzip_file_list is None:
            mtklog_tag = "mtklog_" + self._scan_date_formatted_aee
            TEST_LOGGER.info("开始扫描zip文件，扫描限定字符：{}".format(mtklog_tag))
            unzip_file_list = []
            for root, dirs, files in os.walk(self._scan_root_dir):
                for file in files:
                    file_lower = file.lower()
                    if not file_lower == "mtk.zip":
                        if mtklog_tag in file_lower:
                            if not "exception" in file_lower or file_lower.endswith(".zip"):
                                zip_file_path = os.path.join(root, file)
                                TEST_LOGGER.info("获取待解压zip文件：{}".format(zip_file_path))
                                unzip_file_list.append(zip_file_path)

            TEST_LOGGER.info(f"扫描发现符合条件的zip文件共：{len(unzip_file_list)}个")
        elif unzip_file_list:
            TEST_LOGGER.info("******************** 开始解压zip文件 ********************")
            TEST_LOGGER.info("等待解压文件个数：{}".format(len(unzip_file_list)))
            with ThreadPoolExecutor(max_workers=5, thread_name_prefix="unzip_mtklog_thread") as executor:
                [executor.submit(unzip, self._unzip, unzip_file, True) for unzip_file in unzip_file_list]
            TEST_LOGGER.info("******************** zip文件解压完成 ********************\n")
        else:
            TEST_LOGGER.warn("unzip_file_list 为空，未发现符合的zip文件")
        return True

    def _unzip_aee_all_camera_exceptions(self, scan_dir_by_sn_list):
        """
        解压mtklog zip文件
        :return:
        """
        mtklog_tag = "mtklog_" + self._scan_date_formatted_aee
        TEST_LOGGER.info("开始扫描zip文件，扫描限定字符：{}".format(mtklog_tag))
        unzip_file_list = []
        for scan_dir_by_sn in scan_dir_by_sn_list:
            for root, dirs, files in os.walk(scan_dir_by_sn):
                for file in files:
                    file_lower = file.lower()
                    if not file_lower == "mtk.zip":
                        if mtklog_tag in file_lower:
                            if not "exception" in file_lower or file_lower.endswith(".zip"):
                                zip_file_path = os.path.join(root, file)
                                TEST_LOGGER.info("获取待解压zip文件：{}".format(zip_file_path))
                                unzip_file_list.append(zip_file_path)

        TEST_LOGGER.info(f"扫描发现符合条件的zip文件共：{len(unzip_file_list)}个")
        if unzip_file_list:
            TEST_LOGGER.info("******************** 开始解压zip文件 ********************")
            TEST_LOGGER.info("等待解压文件个数：{}".format(len(unzip_file_list)))
            with ThreadPoolExecutor(max_workers=5, thread_name_prefix="unzip_mtklog_thread") as executor:
                [executor.submit(unzip, self._unzip, unzip_file, True) for unzip_file in unzip_file_list]
            TEST_LOGGER.info("******************** zip文件解压完成 ********************\n")
        else:
            TEST_LOGGER.warn("unzip_file_list 为空，未发现符合的zip文件")
        return True

    @staticmethod
    def _get_dbg_dec_dir(dbg_file):
        return dbg_file + ".DEC"

    @staticmethod
    def _get_dbg_file_from_dec_related_path(file_path):
        regex_rlt = re.search("\\.DEC(?:(?:\\\\|/).*)?$", file_path, re.IGNORECASE)
        if regex_rlt:
            return file_path[:regex_rlt.start()]
        return None

    def _get_dbg_dec_missing_critical_files(self, dbg_file):
        dec_dir = self._get_dbg_dec_dir(dbg_file)
        critical_file_list = ["__exp_main.txt", "ZZ_INTERNAL", "SYS_PROPERTIES"]
        if not os.path.isdir(dec_dir):
            return list(critical_file_list)
        missing_file_list = []
        for critical_file in critical_file_list:
            if not os.path.isfile(os.path.join(dec_dir, critical_file)):
                missing_file_list.append(critical_file)
        return missing_file_list

    def _reset_extract_failed_dbg_tracking(self):
        self._extract_failed_dbg_reason_map = {}
        self._extract_failed_dbg_report_status_map = {}

    def _add_extract_failed_dbg_reason(self, dbg_file, reason_code, detail=None):
        if not dbg_file or not reason_code:
            return
        reason_info_list = self._extract_failed_dbg_reason_map.setdefault(dbg_file, [])
        for reason_info in reason_info_list:
            if reason_info.get("code") == reason_code and reason_info.get("detail") == detail:
                return
        reason_info = {"code": reason_code}
        if detail:
            reason_info["detail"] = detail
        reason_info_list.append(reason_info)

    def _get_extract_failed_dbg_reason_info_list(self, dbg_file):
        return [dict(reason_info) for reason_info in self._extract_failed_dbg_reason_map.get(dbg_file, [])]

    def _get_extract_failed_dbg_reason_codes(self, dbg_file):
        return [reason_info.get("code") for reason_info in self._extract_failed_dbg_reason_map.get(dbg_file, []) if reason_info.get("code")]

    def _set_extract_failed_dbg_report_status(self, dbg_file, written_to_report, skip_reason=None, extra_tag=None):
        report_status = {"written_to_report": written_to_report}
        if skip_reason:
            report_status["skip_reason"] = skip_reason
        if extra_tag is not None:
            report_status["extra_tag"] = extra_tag
        self._extract_failed_dbg_report_status_map[dbg_file] = report_status

    def _record_extract_failed_dbg_dec_reasons(self, dbg_file, missing_file_list):
        dec_dir = self._get_dbg_dec_dir(dbg_file)
        if not os.path.isdir(dec_dir):
            self._add_extract_failed_dbg_reason(dbg_file, "dec_dir_missing")
        reason_code_dict = {"__exp_main.txt": "dec_missing_exp_main", "ZZ_INTERNAL": "dec_missing_zz_internal", "SYS_PROPERTIES": "dec_missing_sys_properties"}
        for missing_file in missing_file_list:
            reason_code = reason_code_dict.get(missing_file)
            if reason_code:
                self._add_extract_failed_dbg_reason(dbg_file, reason_code)

    def _build_extract_failed_dbg_extra_tag(self, dbg_file):
        extra_tag_list = []
        if self._extra_jira_tag:
            extra_tag_list.append(self._extra_jira_tag)
        reason_code_list = self._get_extract_failed_dbg_reason_codes(dbg_file)
        if not reason_code_list:
            reason_code_list = ["extract_failed_unknown"]
        extra_tag_list.extend([f"failure_reason:{reason_code}" for reason_code in reason_code_list])
        return "|".join(dict.fromkeys(extra_tag_list))

    def _get_extract_failed_dbg_metadata(self, dbg_file):
        dec_dir = self._get_dbg_dec_dir(dbg_file)
        exp_main_file_path = os.path.join(dec_dir, "__exp_main.txt")
        exp_detail_path = os.path.join(dec_dir, "_exp_detail.txt")
        if not os.path.isfile(exp_detail_path) and os.path.basename(dec_dir).startswith("CURRENT."):
            exp_detail_path = os.path.join(os.path.dirname(dec_dir), "_exp_detail.txt")
        if os.path.isfile(exp_main_file_path):
            try:
                exp_main = ExpMain(exp_main_file_path, exp_detail_path)
                if exp_main.analyse():
                    exp_time, exp_class, exp_type, cur_process, package, activity, subject, detail, pid, tid, foreground_no, exp_main_build_version, ne_system_issue, ignore_ke_ne_hwasan = exp_main.get_analyse_rlt()
                    return {"source": "EXP_MAIN", "exp_time": exp_time, "exp_class": exp_class, "exp_type": exp_type, "cur_process": cur_process, "package": package}
            except:
                TEST_LOGGER.warn("读取解压失败 dbg 的 __exp_main.txt 元数据异常：{}\n{}".format(exp_main_file_path, traceback.format_exc()))
        zz_internal_file_path = os.path.join(os.path.dirname(dbg_file), "ZZ_INTERNAL")
        zz_internal = ZZ_internal(zz_internal_file_path, dbg_file, self._convert_path_to_win(dbg_file))
        return {"source": "ZZ_INTERNAL", "exp_time": zz_internal.exp_time, "exp_class": zz_internal.exp_class, "exp_type": zz_internal.exp_type, "cur_process": zz_internal.cur_process, "package": zz_internal.cur_process}

    def _extract_dbg(self, dbg_file_list):
        """
        解压dbg文件
        :param dbg_file_list:
        :return:
        """
        TEST_LOGGER.info("******************** 开始解压dbg文件 ********************")
        extract_failed_dbg_list = []
        if dbg_file_list:
            done_count = 1
            all_count = len(dbg_file_list)
            with ThreadPoolExecutor(max_workers=5, thread_name_prefix="aee_extract_thread") as executor:
                extract_dbg_thread = [executor.submit(aee_extract, self._aee_extract, aee_file_path, self._extract_dbg_time_out) for aee_file_path in dbg_file_list]
                for future in as_completed(extract_dbg_thread):
                    TEST_LOGGER.info(f"已完成解压dbg文件个数：{done_count}/{all_count} 占比：{done_count * 100 / all_count:.2f}")
                    done_count += 1
                    failed_dbg_result = future.result()
                    if failed_dbg_result:
                        if isinstance(failed_dbg_result, dict):
                            failed_dbg_file_path = failed_dbg_result.get("dbg_file")
                            reason_code = failed_dbg_result.get("reason_code")
                            detail = failed_dbg_result.get("detail")
                        else:
                            failed_dbg_file_path = failed_dbg_result
                            reason_code = "extract_failed_unknown"
                            detail = None
                        if failed_dbg_file_path:
                            extract_failed_dbg_list.append(failed_dbg_file_path)
                            self._add_extract_failed_dbg_reason(failed_dbg_file_path, reason_code, detail)

            for dbg_file in dbg_file_list:
                missing_file_list = self._get_dbg_dec_missing_critical_files(dbg_file)
                if missing_file_list:
                    self._record_extract_failed_dbg_dec_reasons(dbg_file, missing_file_list)
                    TEST_LOGGER.warn("dbg 文件解压后 .DEC 目录仍缺少关键文件 {}，转入失败兜底链：{}".format(missing_file_list, dbg_file))
                    extract_failed_dbg_list.append(dbg_file)

            extract_failed_dbg_list = list(dict.fromkeys(extract_failed_dbg_list))
            if extract_failed_dbg_list:
                TEST_LOGGER.warn("dbg 文件解压后进入失败兜底链的文件共：{} 个".format(len(extract_failed_dbg_list)))

        else:
            TEST_LOGGER.warn("未发现dbg文件，不执行dbg解压")
        TEST_LOGGER.info("******************** 解压dbg文件已完成 ********************\n")
        return extract_failed_dbg_list

    def _get_extract_failed_dbg_pkglist_candidates(self, exp_class, cur_process):
        candidate_list = []
        if exp_class:
            candidate_list.append(exp_class)
        if cur_process:
            candidate_list.append(cur_process)
            if ":" in cur_process:
                candidate_list.append(cur_process.split(":", 1)[0])
        if exp_class == "Kernel (KE)" or cur_process == "PROCESS_KE":
            candidate_list.extend(["Kernel (KE)", "Kernel KE"])
        return [candidate for candidate in candidate_list if candidate]

    def _should_keep_extract_failed_dbg(self, exp_class, cur_process):
        if self._ignore_pkglist:
            return True
        candidate_list = self._get_extract_failed_dbg_pkglist_candidates(exp_class, cur_process)
        for candidate in candidate_list:
            if candidate in self._pkglist:
                return True
        return False

    def _get_failed_dbg_device_root_and_id(self, dbg_file):
        normalized_scan_root = self._scan_root_dir.replace("\\", "/").rstrip("/")
        normalized_dbg_file = dbg_file.replace("\\", "/")
        if normalized_scan_root and normalized_dbg_file.startswith(normalized_scan_root + "/"):
            relative_path = normalized_dbg_file[len(normalized_scan_root) + 1:]
            path_parts = relative_path.split("/", 1)
            if path_parts and path_parts[0]:
                device_id = path_parts[0]
                return (os.path.join(self._scan_root_dir, device_id), device_id)
        regex_rlt = re.search("/([A-Za-z0-9]{10,})/", normalized_dbg_file)
        if regex_rlt:
            device_id = regex_rlt.group(1)
            return (os.path.join(self._scan_root_dir, device_id), device_id)
        return (None, None)

    def _get_failed_dbg_build_version_and_device_id(self, dbg_file):
        device_root, device_id = self._get_failed_dbg_device_root_and_id(dbg_file)
        cache_key = device_root if device_root else dbg_file
        cache_rlt = self._failed_dbg_info_cache.get(cache_key)
        if cache_rlt:
            return cache_rlt
        build_version = self._build_version if self._build_version else "VersionNone"
        fallback_device_id = device_id if device_id else "unknown_device_id"
        if device_root and os.path.isdir(device_root):
            for root, dirs, files in os.walk(device_root):
                if "SYS_PROPERTIES" in files:
                    sys_properties_path = os.path.join(root, "SYS_PROPERTIES")
                    try:
                        sys_properties = SysProperties(sys_properties_path)
                        if sys_properties.build_version:
                            build_version = sys_properties.build_version
                        if sys_properties.device_id:
                            fallback_device_id = sys_properties.device_id
                        break
                    except:
                        TEST_LOGGER.warn("读取 SYS_PROPERTIES 文件失败：{}\n{}".format(sys_properties_path, traceback.format_exc()))
        self._failed_dbg_info_cache[cache_key] = (build_version, fallback_device_id)
        return self._failed_dbg_info_cache[cache_key]

    def _build_extract_failed_aee_result(self, dbg_file):
        metadata = self._get_extract_failed_dbg_metadata(dbg_file)
        exp_class = metadata.get("exp_class")
        exp_type = metadata.get("exp_type")
        exp_time = metadata.get("exp_time")
        cur_process = metadata.get("cur_process")
        package = metadata.get("package") if metadata.get("package") else cur_process
        extra_tag = self._build_extract_failed_dbg_extra_tag(dbg_file)
        if not self._should_keep_extract_failed_dbg(exp_class, cur_process):
            self._set_extract_failed_dbg_report_status(dbg_file, False, skip_reason="pkglist_filtered", extra_tag=extra_tag)
            return None
        build_version, device_id = self._get_failed_dbg_build_version_and_device_id(dbg_file)
        if exp_class == "CLASS_UNKNOWN" and ".ke" in dbg_file.lower():
            exp_class = "Kernel (KE)"
        if exp_class in ('Kernel (KE)', 'HWT', 'HANG_DETECT', 'Kernel API Dump', 'Hardware Reboot'):
            cur_process = exp_class
            package = exp_class
        elif cur_process == "PROCESS_KE":
            exp_class = "Kernel (KE)"
            cur_process = "Kernel (KE)"
            package = "Kernel (KE)"
        if exp_time == "TIME_UNKNOWN":
            exp_time = "TIME_UNKNOWN"
        detail_col_text = "Device_id: {}\n{}\n手机版本：['{}']".format(device_id, RECOGNIZE_LIB_VERSION, build_version)
        caused_by_col_text = "当前类型没有获取详细信息方式，请自己查看日志文件，本内容只为了Jira不能去重：\n{}".format(random_str(slen=200))
        rom_ram = parse_rom_ram_from_dec_dir(self._get_dbg_dec_dir(dbg_file))
        TEST_LOGGER.warn("dbg 文件解压失败，已生成兜底结果写入报告：{}".format(dbg_file))
        self._set_extract_failed_dbg_report_status(dbg_file, True, extra_tag=extra_tag)
        return FallbackAeeResult(dbg_file, build_version, exp_time, exp_class, exp_type, cur_process, package, detail_col_text, caused_by_col_text, extra_tag=extra_tag, device_id=device_id, rom_ram=rom_ram)

    def _build_extract_failed_aee_result_list(self, extract_failed_dbg_list):
        fallback_aee_result_list = []
        if not extract_failed_dbg_list:
            return fallback_aee_result_list
        for dbg_file in sorted(set(extract_failed_dbg_list)):
            missing_file_list = self._get_dbg_dec_missing_critical_files(dbg_file)
            if not missing_file_list:
                TEST_LOGGER.info("dbg 文件虽然解压异常，但 .DEC 关键文件完整，跳过兜底结果：{}".format(dbg_file))
                self._set_extract_failed_dbg_report_status(dbg_file, False, skip_reason="dec_complete_after_retry", extra_tag=self._build_extract_failed_dbg_extra_tag(dbg_file))
                continue
            TEST_LOGGER.warn("dbg 文件的 .DEC 目录仍缺少关键文件 {}，按失败兜底写入报告：{}".format(missing_file_list, dbg_file))
            fallback_aee_result = self._build_extract_failed_aee_result(dbg_file)
            if fallback_aee_result:
                fallback_aee_result_list.append(fallback_aee_result)
            elif dbg_file not in self._extract_failed_dbg_report_status_map:
                self._set_extract_failed_dbg_report_status(dbg_file, False, skip_reason="fallback_build_failed", extra_tag=self._build_extract_failed_dbg_extra_tag(dbg_file))
        if fallback_aee_result_list:
            TEST_LOGGER.warn("解压失败后写入报告的兜底 AEE 结果共：{} 个".format(len(fallback_aee_result_list)))
        return fallback_aee_result_list

    def _decompress_tne(self, tne_file_list):
        """
        解压 tne 文件
        :param tne_file_list:
        :return:
        """
        TEST_LOGGER.info("******************** 开始解压tne文件 ********************")
        decompressed_tne_dir_list = []
        if tne_file_list:
            done_count = 1
            all_count = len(tne_file_list)
            with ThreadPoolExecutor(max_workers=5, thread_name_prefix="tne_decompress_thread") as executor:
                decompress_tne_thread = [executor.submit(decompress_tne, self._tne_decompress, tne_file_path) for tne_file_path in tne_file_list]
                for future in as_completed(decompress_tne_thread):
                    TEST_LOGGER.info(f"已完成解压tne文件个数：{done_count}/{all_count} 占比：{done_count * 100 / all_count}")
                    decompressed_tne_dir = future.result()
                    decompressed_tne_dir_list.append(decompressed_tne_dir)
                    done_count += 1

        else:
            TEST_LOGGER.warn("未发现tne文件，不执行tne解压")
        TEST_LOGGER.info("******************** 解压tne文件已完成 ********************\n")
        return decompressed_tne_dir_list

    def _extract_expdb(self, expdb_file_list):
        """
        解压 expdb 文件
        :param expdb_file_list:
        :return:
        """
        TEST_LOGGER.info("******************** 开始解压expdb文件 ********************")
        if expdb_file_list:
            with ThreadPoolExecutor(max_workers=5, thread_name_prefix="expdb_extract_thread") as executor:
                [executor.submit(extract_expdb, self._p_new_db, expdb_file_path) for expdb_file_path in expdb_file_list]
        else:
            TEST_LOGGER.warn("未发现tne文件，不执行tne解压")
        TEST_LOGGER.info("******************** 解压tne文件已完成 ********************\n")

    @staticmethod
    def _analyse_aee(exp_main_file_list, to_recognize_except=True, extra_jira_tag=None):
        TEST_LOGGER.info("******************** 开始进行aee解析 ********************")
        aee_result_list = []
        with ThreadPoolExecutor(max_workers=5) as executor:
            aee_analyse_thread = [executor.submit(analyse_aee, exp_main_file, to_recognize_except, extra_jira_tag) for exp_main_file in exp_main_file_list]
            for future in as_completed(aee_analyse_thread):
                rlt, exp_main_file, aee, error_type, error_detail = future.result()
                if aee:
                    aee_result_list.append(aee)

        if aee_result_list:
            TEST_LOGGER.info("解析获取aee问题结果共：{}个".format(len(aee_result_list)))
        else:
            TEST_LOGGER.warn("aee解析结果列表为空")
        TEST_LOGGER.info("******************** aee解析完成 ********************\n")
        return aee_result_list

    def _analyse_tne(self, tne_dir_list, build_version=None, extra_jira_tag=None):
        TEST_LOGGER.info("******************** 开始进行tne解析 ********************")
        tne_result_list = []
        with ThreadPoolExecutor(max_workers=5) as executor:
            tne_analyse_thread = [executor.submit(analyse_tne, tne_dir, None, self._freeze_tne_type_list, self._subsystem_crash_tne_type_list, self._daemon_crash_tne_type_list, build_version, extra_jira_tag) for tne_dir in tne_dir_list]
            for future in as_completed(tne_analyse_thread):
                rlt, tne_dir_path, tne, error_type, error_detail = future.result()
                if rlt and tne:
                    tne_result_list.append(tne)

        if tne_result_list:
            TEST_LOGGER.info("解析获取tne问题结果共：{}个".format(len(tne_result_list)))
        else:
            TEST_LOGGER.warn("tne解析结果列表为空")
        TEST_LOGGER.info("******************** tne解析完成 ********************\n")
        return tne_result_list

    def _get_pkglist(self, scan_type, pkglist_file_path):
        TEST_LOGGER.info("开始获取pkglist")
        rlt, pkglist = False, []
        if self._is_network_connected:
            rlt, pkglist = get_package_white_list_online(scan_type)
        if rlt and pkglist:
            # 在线获取成功，更新本地文件
            TEST_LOGGER.info("已在线获取最新的pkglist，开始更新本地文件：{}".format(pkglist_file_path))
            try:
                with open(pkglist_file_path, "w", encoding="utf-8", errors="ignore") as f:
                    for pkg in pkglist:
                        f.write(pkg + "\n")
            except:
                TEST_LOGGER.warn("更新本地pkglist文件：{} 时，发生异常：\n{}".format(pkglist_file_path, traceback.format_exc()))
        else:
            # 在线获取失败或返回空，读取本地文件
            TEST_LOGGER.info("在线获取pkglist返回异常，尝试读取本地文件：{}".format(pkglist_file_path))
            if os.path.isfile(pkglist_file_path):
                with open(pkglist_file_path, "r", encoding="utf-8", errors="ignore") as f:
                    for line in f.readlines():
                        line = line.strip()
                        if line != "":
                            pkglist.append(line.strip())
            else:
                TEST_LOGGER.warn("本地pkglist文件：{} 不存在！".format(pkglist_file_path))

        if self._scan_mode == SCAN_MODE_CAMERA_PLATFORM:
            TEST_LOGGER.info("多媒体扫描模式，只保留含有camera的包名")
            camera_pkglist = []
            for pkg in pkglist:
                if "camera" in pkg.lower():
                    camera_pkglist.append(pkg)
            pkglist = camera_pkglist
            TEST_LOGGER.info(f"多媒体扫描模式，保留的包名列表：{pkglist}")
        TEST_LOGGER.info("pkglist 内容：{}".format(pkglist))
        return pkglist

    def _get_top_apk_list(self):
        TEST_LOGGER.info("开始从飞书文档获取预装和三方apk列表")
        top_apk_file_path = PathManager.config_folder + os.sep + self._top_apk_file
        top_apk_list = get_top_app_list_from_feishu()
        if not top_apk_list:
            TEST_LOGGER.warn("从飞书文档获取预装和三方apk列表失败，开始从本地文件获取")
            if os.path.isfile(top_apk_file_path):
                TEST_LOGGER.info("开始读取top_apk文件：{}".format(top_apk_file_path))
                with open(top_apk_file_path, "r", encoding="utf-8", errors="ignore") as f:
                    for line in f.readlines():
                        top_apk_list.append(line.strip())

            else:
                TEST_LOGGER.warn("top_apk文件：{} 不存在！".format(top_apk_file_path))
        else:
            TEST_LOGGER.info(f"从飞书文档获取预装和三方apk列表成功，开始更新本地文件:{top_apk_list}")
            try:
                with open(top_apk_file_path, "w", encoding="utf-8", errors="ignore") as f:
                    for top_apk in top_apk_list:
                        f.write(top_apk + "\n")

            except:
                TEST_LOGGER.warn(f"更新本地预装和三方apk列表文件：{top_apk_file_path} 时，发生异常：\n{traceback.format_exc()}")

            return top_apk_list

    def _get_blacklist(self, blacklist_file_path):
        TEST_LOGGER.info("开始获取黑名单文件列表")
        rlt, blacklist = False, []
        if self._is_network_connected:
            rlt, blacklist = get_monkey_blacklist_online()
        if rlt:
            blacklist or TEST_LOGGER.warn("在线获取黑名单列表返回异常，尝试读取本地文件：{}".format(blacklist_file_path))
            if os.path.isfile(blacklist_file_path):
                with open(blacklist_file_path, "r", encoding="utf-8", errors="ignore") as f:
                    for line in f.readlines():
                        line = line.strip()
                        if line != "":
                            blacklist.append(line.strip())

            else:
                TEST_LOGGER.warn("本地黑名单文件：{} 不存在！".format(blacklist_file_path))
        else:
            TEST_LOGGER.info("已在线获取最新的黑名单列表，开始更新本地文件：{}".format(blacklist_file_path))
            try:
                with open(blacklist_file_path, "w", encoding="utf-8", errors="ignore") as f:
                    for black_app in blacklist:
                        f.write(black_app + "\n")

            except:
                TEST_LOGGER.warn("更新本地黑名单文件：{} 时，发生异常：\n{}".format(blacklist_file_path, traceback.format_exc()))

            return blacklist

    def _get_jira_project(self, project_name, jira_project_file_path=None, mp_block_file_path=None):
        TEST_LOGGER.info("开始获取项目：{} 的Jira映射数据".format(project_name))
        rlt, jira_repo, is_mp_block, mail_list = (False, None, False, None)
        if self._is_network_connected:
            rlt, jira_repo, is_mp_block, mail_list = get_jira_project_online(project_name)
        if not rlt:
            TEST_LOGGER.info("在线获取项目：{} 的Jira映射数据返回异常，尝试读取本地文件".format(project_name))
            if jira_project_file_path and os.path.isfile(jira_project_file_path):
                with open(jira_project_file_path, "r", encoding="utf-8", errors="ignore") as fi:
                    for line in fi.readlines():
                        if project_name in line:
                            try:
                                jira_repo = line.split(":")[1].strip()
                                break
                            except:
                                pass

            else:
                TEST_LOGGER.error("未找到jira项目映射文件：{}！".format(jira_project_file_path))
            if mp_block_file_path and os.path.isfile(mp_block_file_path):
                with open(mp_block_file_path, "r", encoding="utf-8", errors="ignore") as fi:
                    for line in fi.readlines():
                        if project_name in line:
                            TEST_LOGGER.info("mp_block.txt 中存在：{}，标注MP Block".format(project_name))
                            is_mp_block = True
                            break

        else:
            TEST_LOGGER.info("未找到 MP_Block 映射文件，不标注MP Block！")
        return (
         jira_repo, is_mp_block, mail_list)

    def _get_report_history(self, report_history_file_path):
        TEST_LOGGER.info("开始获取新增APK提醒历史记录")
        report_history_list = []
        if self._is_network_connected:
            report_history_list = get_report_history_online()
        if not report_history_list:
            TEST_LOGGER.info("在线获取新增APK提醒历史记录为空，尝试读取本地文件：{}".format(report_history_file_path))
            if os.path.isfile(report_history_file_path):
                with open(report_history_file_path, "r", encoding="utf-8", errors="ignore") as f:
                    for line in f.readlines():
                        line = line.strip()
                        if line != "":
                            report_history_list.append(line.strip())

            else:
                TEST_LOGGER.warn("本地APK提醒历史记录文件：{} 不存在！".format(report_history_file_path))
        else:
            TEST_LOGGER.info("已在线获取最新的新增APK提醒历史记录，开始更新本地文件：{}".format(report_history_file_path))
            try:
                with open(report_history_file_path, "w", encoding="utf-8", errors="ignore") as f:
                    for report_history in report_history_list:
                        f.write(report_history + "\n")

            except:
                TEST_LOGGER.warn("更新本地新增APK提醒历史记录文件：{} 时，发生异常：\n{}".format(report_history_file_path, traceback.format_exc()))

            return report_history_list

    def _get_standard_info(self):
        """
        获取白名单、黑名单、apk提醒历史列表
        :return: 
        """
        pkglist_file_path = PathManager.config_folder + os.sep + self._pkglist_file
        self._pkglist = self._get_pkglist(self._scan_type, pkglist_file_path)
        blacklist_file_path = PathManager.config_folder + os.sep + self._blacklist_file
        self._blacklist = self._get_blacklist(blacklist_file_path)
        report_history_file_path = PathManager.config_folder + os.sep + self._report_history_file
        self._report_history_list = self._get_report_history(report_history_file_path)
        TEST_LOGGER.info(f"self._report_history_list:{self._report_history_list}")

    def _send_new_app_mail(self):
        subject = f"LogScan 新增System APP提醒 【{self._scan_site}】【{self._hostname}】【{self._report_date_formatted}】"
        content = ""
        for new_app_info in self._new_app_info_list:
            converted_path = self._convert_path_to_win(new_app_info[2])
            content = content + "ProcessName：【{}】    Type：【{}】\nPath：{}\n\n".format(new_app_info[0], new_app_info[1], converted_path)

        sendMail(subject, content, self._new_app_mail_list)
        TEST_LOGGER.info("新增system app邮件已发送")

    def _send_result_mail(self, statistics_list, org_excel_path, final_excel_path, pipeline_id=None, uuid=None):
        """
        发送扫描结果邮件
        :param statistics_list:
        :param attach_file_list:
        :return:
        """
        if self._notify_mail_list:
            target_project = "None"
            converted_path = self._convert_path_to_win(self._scan_root_dir)
            content = "日志扫描完成，扫描路径：\n{}\n".format(converted_path)
            if pipeline_id:
                content = content + f"pipelineId：{pipeline_id}\n"
            if uuid:
                content = content + f"uuid：{uuid}\n"
            if statistics_list:
                target_project = statistics_list[0]
                content = content + "扫描简要信息：\nProject：{}\n".format(statistics_list[0])
                content = content + "Build：{}\n".format(statistics_list[1])
                content = content + f"{statistics_list[-1]}\n"
            subject = f"【日志扫描结果】【{self._scan_site}】【{target_project}】【{self._hostname}】【{self._report_date_formatted}】【问题总数-{statistics_list[2]}】"
            sendMail(subject, content, self._notify_mail_list, org_excel_path, final_excel_path)
        else:
            TEST_LOGGER.info("扫描正常通知人邮件列表为空，不发送结果通知邮件")

    def _send_result_feishu(self, statistics_list, aee_rlt_list_org, aee_rlt_list_final, result_dir, pipeline_id=None, uuid=None, msg_header=None):
        TEST_LOGGER.info("发送飞书通知本次扫描结果")
        target_project = "None"
        aee_count_org, aee_count_final = (0, 0)
        if aee_rlt_list_org:
            aee_count_org = len(aee_rlt_list_org)
        if aee_rlt_list_final:
            aee_count_final = len(aee_rlt_list_final)
        fei_msg = f"【去重前AEE数：{aee_count_org}】【去重后AEE数：{aee_count_final}】"
        fei_msg += f"\n【测试版本】 {self._target_build}"
        fei_msg += f"\n【主机名】 {self._hostname}"
        fei_msg += f"\n【UUID】 {uuid}"
        converted_path = self._convert_path_to_win(self._scan_root_dir)
        fei_msg += f"\n【扫描路径】 \\{converted_path}"
        converted_path = self._convert_path_to_win(result_dir)
        fei_msg += f"\n【结果路径】 \\{converted_path}"
        total_count = 0
        if statistics_list:
            target_project = statistics_list[0]
            total_count = statistics_list[2]
        fei_title = f"【{target_project}】【{self._scan_site}】【{pipeline_id}】【{self._report_date_formatted}】【问题总数：{total_count}】"
        send_monkey_rlt_by_feishu_robot(fei_title, fei_msg, msg_header)

    def _get_mail_receivers(self):
        """
        根据配置项，获取邮件人通知列表
        :return:
        """
        TEST_LOGGER.info("开始获取邮件通知人列表")
        if self._send_notify_mail_to_tester:
            if self._mail_receivers_to_tester:
                self._notify_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_tester))
        if self._send_notify_mail_to_default:
            if self._mail_receivers_to_default:
                self._notify_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_default))
        if self._mail_receivers_to_new_app:
            self._new_app_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_new_app))
        if self._send_warning_mail:
            if self._mail_receivers_to_tester:
                self._warning_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_tester))
            if self._mail_receivers_to_default:
                self._warning_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_default))
        if self._mail_receivers_to_tester:
            self._scan_system_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_tester))
        if self._mail_receivers_to_scan_system:
            self._scan_system_mail_list.extend(re.findall(PATTERN_MAIL, self._mail_receivers_to_scan_system))
        TEST_LOGGER.info(f"获取扫描正常通知人邮件列表：{self._notify_mail_list}")
        TEST_LOGGER.info(f"获取异常告警通知人邮件列表：{self._warning_mail_list}")
        TEST_LOGGER.info(f"获取平台异常通知人邮件列表：{self._scan_system_mail_list}")

    def get_log_url(self, log_path):
        """
        获取日志的URL链接 - 反编译失败，使用空实现
        :param log_path: 日志路径
        :return: URL链接或None
        """
        return None

    def _no_exception_delete_logs(self):
        TEST_LOGGER.info("delete_log: true, 执行删除Log, 扫描所有当前日期的zip文件和目录，并执行删除")
        mtklog_tag = "mtklog_" + self._scan_date_formatted_aee
        TEST_LOGGER.info("扫描目录：{}，mtklog_tag：{}".format(self._scan_root_dir, mtklog_tag))
        for root, dirs, files in walk_with_max_depth(self._scan_root_dir, 2):
            for name in files:
                if mtklog_tag in name:
                    TEST_LOGGER.info("删除文件：{}".format(os.path.join(root, name)))
                    try:
                        os.remove(os.path.join(root, name))
                    except:
                        TEST_LOGGER.error(f"删除文件：{os.path.join(root, name)}，发生异常：{traceback.format_exc()}")

            for name in dirs:
                if mtklog_tag in name:
                    TEST_LOGGER.info("删除目录：{}".format(os.path.join(root, name)))
                    try:
                        shutil.rmtree(os.path.join(root, name))
                    except Exception as e:
                        try:
                            TEST_LOGGER.error("删除目录：{}，发生异常：{}".format(os.path.join(root, name), e))
                        finally:
                            e = None
                            del e
