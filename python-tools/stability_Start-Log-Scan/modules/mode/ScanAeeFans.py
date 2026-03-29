# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\mode\ScanAeeFans.py
import datetime, difflib, os, re, shutil, traceback
from concurrent.futures import ThreadPoolExecutor, as_completed
from modules.analyse.aee.AnalyseAee import analyse_aee
import modules.common.Excel as Excel
from modules.common.GlobalAttrs import RECOGNIZE_LIB_VERSION
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.common.Utils import sendMail, send_jira_request, get_mixed_md5, send_msg_by_feishu_robot, get_str_similar
from modules.mode.BaseScan import ScanBase

class ScanAeeFans(ScanBase):
    __doc__ = "\n    粉丝日志每日扫描脚本\n    "

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip):
        TEST_LOGGER.info("初始化 ScanAeeFans，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(scan_place))
        TEST_LOGGER.info("days_before：{}".format(days_before))
        TEST_LOGGER.info("scan_root_dir：{}".format(scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(cur_tool_dir))
        TEST_LOGGER.info("skip_extract：{}".format(skip_extract))
        TEST_LOGGER.info("skip_unzip：{}".format(skip_unzip))
        super(ScanAeeFans, self).__init__(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)

    def _get_scan_dir_failed(self, error_msg):
        return

    def _init_scan_attrs(self):
        """
        初始化各个扫描模式的扫描参数
        :return:
        """
        self._limited_max_days = self._default_config["limited_max_days"]
        TEST_LOGGER.info("提交问题最长有效天数：{}".format(self._limited_max_days))
        self._limited_pri_date = self._default_config["limited_prj_date"]
        TEST_LOGGER.info("提交限定项目版本日期：{}".format(self._limited_pri_date))
        self._top_apk_file = self._default_config["top_apk_file"]
        TEST_LOGGER.info("TopApk文件名：{}".format(self._top_apk_file))
        self._core_app_reporter = self._default_config.get("core_app_reporter")
        if self._core_app_reporter is None or self._core_app_reporter == "":
            self._core_app_reporter = self._reporter
        TEST_LOGGER.info(f"核心应用问题，项目提交人：{self._core_app_reporter}")
        self._core_app_repo_dict = self._default_config["core_app_repo"]
        TEST_LOGGER.info(f"核心应用问题，项目提交库列表：{self._core_app_repo_dict}")
        self._core_app_reporter_out = self._default_config.get("core_app_reporter_out")
        if self._core_app_reporter_out is None or self._core_app_reporter_out == "":
            self._core_app_reporter_out = self._reporter
        TEST_LOGGER.info(f"核心应用问题，外研项目提交人：{self._core_app_reporter_out}")
        self._core_app_repo_out_dict = self._default_config["core_app_repo_out"]
        TEST_LOGGER.info(f"核心应用问题，外研项目提交库列表：{self._core_app_repo_out_dict}")
        self._stop_prj_list = self._default_config.get("stop_prj_list")
        TEST_LOGGER.info(f"停止运营项目列表：{self._stop_prj_list}")
        self._specified_prj_list = self._default_config.get("specified_prj_list")
        TEST_LOGGER.info(f"指定项目列表：{self._specified_prj_list}")

    def _scan(self):
        """
        扫描 粉丝日志
        :return:
        """
        TEST_LOGGER.resetTag(__name__)
        scan_task_dict = {}
        TEST_LOGGER.info("开始扫描日志目录:{}".format(self._scan_root_dir))
        for prj in os.listdir(self._scan_root_dir):
            if self._specified_prj_list:
                if prj not in self._specified_prj_list:
                    TEST_LOGGER.info(f"项目: {prj} 不在指定项目列表内，不进行扫描", tag=__name__)
                    continue
                elif self._stop_prj_list and prj in self._stop_prj_list:
                    TEST_LOGGER.info(f"项目: {prj}已停止运营，不进行扫描", tag=__name__)
                    continue
                prj_path = os.path.join(self._scan_root_dir, prj)
                if prj != "Result" and os.path.isdir(prj_path):
                    prj_scan_path = os.path.join(prj_path, self._scan_date_formatted_fans_usic)
                    if os.path.isdir(prj_scan_path):
                        TEST_LOGGER.info("项目: {} 存在 {} 的日志, 准备执行扫描".format(prj, self._scan_date_formatted_fans_usic))
                        scan_task_dict[prj] = prj_scan_path
                else:
                    TEST_LOGGER.info("项目: {} 不存在 {} 的日志, 本次不执行扫描".format(prj, self._scan_date_formatted_fans_usic))

        TEST_LOGGER.info("目录扫描完成\n")
        if not scan_task_dict:
            subject = "粉丝日常扫描失败 - {}".format(self._scan_date_formatted_fans_usic)
            converted_path = self._convert_path_to_win(self._scan_root_dir)
            content = "粉丝日志目录：{}，日期：[{}] 的日志不存在，不进行扫描!".format(converted_path, self._scan_date_formatted_fans_usic)
            sendMail(subject, content, self._warning_mail_list)
            send_msg_by_feishu_robot("粉丝日常扫描未执行", content)
            return
        elif not self._skip_extract:
            TEST_LOGGER.info("******************** 开始获取dbg文件列表 ********************")
            dbg_file_list = []
            for prj, prj_scan_path in scan_task_dict.items():
                prj_dbg_count = 0
                for root, dirs, files in os.walk(prj_scan_path):
                    for file in files:
                        file_lower = file.lower()
                        file_path = os.path.join(root, file)
                        if file_lower.endswith(".dbg"):
                            dbg_file_list.append(file_path)
                            prj_dbg_count += 1

                TEST_LOGGER.info(f"项目{prj}的dbg文件数量：{prj_dbg_count}")

            [TEST_LOGGER.info("dbg file: {}".format(dbg_file)) for dbg_file in dbg_file_list]
            TEST_LOGGER.info("********************" + f" 获取dbg文件列表已完成，总计{len(dbg_file_list)}个dbg文件 " + "********************" + "\n")
            self._extract_dbg(dbg_file_list)
        else:
            TEST_LOGGER.warn("skip_extract:{}，跳过解压步骤".format(self._skip_extract))
        exp_main_prj_dict = {}
        with ThreadPoolExecutor(max_workers=5, thread_name_prefix="scan_exp_main_list") as executor:
            scan_thread_list = [executor.submit(self._ScanAeeFans__scan_exp_main_list, prj, prj_scan_path) for prj, prj_scan_path in scan_task_dict.items()]
            for future in as_completed(scan_thread_list):
                prj, exp_main_list = future.result()
                exp_main_prj_dict[prj] = exp_main_list

        for prj, exp_main_list in exp_main_prj_dict.items():
            TEST_LOGGER.info("项目：{} 需要解析的__exp_main.txt：".format(prj))
            [TEST_LOGGER.info(exp_main_file) for exp_main_file in exp_main_list]

        aee_rlt_dict = {}
        analyse_exception_list = []
        for prj, exp_main_list in exp_main_prj_dict.items():
            TEST_LOGGER.info("********************" + " 开始解析项目：{}的aee ".format(prj) + "********************")
            with ThreadPoolExecutor(max_workers=5) as executor:
                aee_analyse_thread = [executor.submit(analyse_aee, exp_main_file, self._to_recognize_except, self._extra_jira_tag) for exp_main_file in exp_main_list]
                for future in as_completed(aee_analyse_thread):
                    rlt, exp_main_file, aee, error_type, error_detail = future.result()
                    if rlt:
                        if aee:
                            aee_rlt_dict.setdefault(prj, []).append(aee)
                        if error_type:
                            analyse_exception_list.append([exp_main_file, error_type, error_detail])

            if prj in aee_rlt_dict:
                TEST_LOGGER.info("项目：{}共解析出aee问题：{}个".format(prj, len(aee_rlt_dict[prj])))
            else:
                TEST_LOGGER.error("项目：{}未产生aee结果，请检查".format(prj))
            TEST_LOGGER.info("********************" + " 项目：{}的aee 解析完成 ".format(prj) + "********************" + "\n")

        if analyse_exception_list:
            subject = "粉丝日常扫描存在异常 - {}".format(self._scan_date_formatted_fans_usic)
            content = ""
            for analyse_exception in analyse_exception_list:
                content = content + "异常类型：{}\nAEE路径：{}\n详细信息：{}\n\n\n".format(analyse_exception[1], analyse_exception[0], analyse_exception[2])

            sendMail(subject, content, self._warning_mail_list)
            send_msg_by_feishu_robot("粉丝日常扫描存在异常", content)
        for prj, aee_result_list in aee_rlt_dict.items():
            TEST_LOGGER.info("********************" + " 开始对项目：{}的扫描结果进行去重 ".format(prj) + "********************")
            try:
                aee_rlt_list_org, aee_rlt_list_final, aee_rlt_list_core_and_reboot, core_app_repo, is_out_prj = self._ScanAeeFans__aee_to_data_list_fans(prj, aee_result_list)
            except Exception as e:
                try:
                    TEST_LOGGER.error(traceback.format_exc())
                    send_msg_by_feishu_robot("扫描中断！结果未提交！", traceback.format_exc())
                    raise e
                finally:
                    e = None
                    del e

            if aee_rlt_list_org:
                TEST_LOGGER.info(("项目：{}的原始数据个数：{}".format(prj, len(aee_rlt_list_org))), tag=__name__)
            else:
                TEST_LOGGER.info(("项目：{}的原始数据为空".format(prj)), tag=__name__)
            if aee_rlt_list_final:
                TEST_LOGGER.info(("项目：{}的去重后非核心应用数据个数：{}".format(prj, len(aee_rlt_list_final))), tag=__name__)
            else:
                TEST_LOGGER.info(("项目：{}的去重后数据为空".format(prj)), tag=__name__)
            if aee_rlt_list_core_and_reboot:
                TEST_LOGGER.info(("项目：{}的去重后核心应用数据个数：{}".format(prj, len(aee_rlt_list_final))), tag=__name__)
            else:
                TEST_LOGGER.info(("项目：{}的去重后核心应用数据为空".format(prj)), tag=__name__)
            TEST_LOGGER.info("********************" + " 项目：{}扫描结果去重完成 ".format(prj) + "********************" + "\n")
            prj_dir_path = scan_task_dict[prj]
            if is_out_prj:
                jira_server = self._jira_server
                core_app_reporter = self._core_app_reporter_out
                TEST_LOGGER.info(f"外研项目，jira_server: {jira_server}, core_app_reporter: {core_app_reporter}")
            else:
                jira_server = None
                core_app_reporter = self._core_app_reporter
                TEST_LOGGER.info(f"内研项目，jira_server: {jira_server}, core_app_reporter: {core_app_reporter}")
            org_excel_name = f"Result_{prj}_{self._reporter}_FANSAEE_SH_{self._report_date_formatted}_Fans_org.xls"
            final_excel_name = f"Result_{prj}_{self._reporter}_FANSAEE_SH_{self._report_date_formatted}_Fans.xls"
            core_and_reboot_excel_name = f"Result_{core_app_repo}_{core_app_reporter}_FANSAEE_SH_{self._report_date_formatted}_Fans.xls"
            org_excel_path = prj_dir_path + os.sep + org_excel_name
            final_excel_path = prj_dir_path + os.sep + final_excel_name
            reboot_excel_path = prj_dir_path + os.sep + core_and_reboot_excel_name
            try:
                if aee_rlt_list_org:
                    TEST_LOGGER.info("项目：{} 未去重文件：{}".format(prj, org_excel_path))
                    excel = Excel(org_excel_path)
                    excel.insertResultAee(aee_rlt_list_org)
                else:
                    TEST_LOGGER.info(("项目：{}的原始数据为空，不生成Excel文件".format(prj)), tag=__name__)
            except:
                TEST_LOGGER.error(traceback.format_exc())

            try:
                if aee_rlt_list_final:
                    TEST_LOGGER.info("项目：{} 去重后文件：{}".format(prj, final_excel_path))
                    excel = Excel(final_excel_path)
                    excel.insertResultAee(aee_rlt_list_final, deduplicated=True)
                else:
                    TEST_LOGGER.info(("项目：{}的去重后数据为空，不生成Excel文件".format(prj)), tag=__name__)
            except:
                TEST_LOGGER.error(traceback.format_exc())
                send_msg_by_feishu_robot(f"【Fans每日扫描提交异常】\n项目：{prj} 生成结果文件异常，结果未提交！", (f"{traceback.format_exc()}"))

            try:
                if aee_rlt_list_core_and_reboot:
                    TEST_LOGGER.info(f"项目：{prj} 核心应用问题去重后文件：{reboot_excel_path}")
                    excel = Excel(reboot_excel_path)
                    excel.insertResultAee(aee_rlt_list_core_and_reboot, deduplicated=True)
                else:
                    TEST_LOGGER.info(("项目：{}的核心应用问题去重后数据为空，不生成Excel文件".format(prj)), tag=__name__)
            except:
                TEST_LOGGER.error(traceback.format_exc())
                send_msg_by_feishu_robot(f"【Fans每日扫描提交异常】\n项目：{prj} 核心应用问题生成结果文件异常，结果未提交！", (f"{traceback.format_exc()}"))

            if self._submit_jira:
                TEST_LOGGER.info(f"submit_jira：True，执行Jira提交，提交Url：{self._submit_jira_url}")
                if aee_rlt_list_final:
                    if os.path.isfile(final_excel_path):
                        TEST_LOGGER.info("提交至粉丝库，不再区分内外研，jira_project_name：FANS-PROJECT")
                        send_jira_request((self._submit_jira_url), final_excel_path, jira_project_name="FANS-PROJECT", log_smb_username=(self._log_smb_username), log_smb_password=(self._log_smb_password))
                    else:
                        TEST_LOGGER.info(f"项目：{prj}的去重后数据为空，不执行Jira提交")
                    if aee_rlt_list_core_and_reboot and os.path.isfile(reboot_excel_path):
                        if core_app_repo and core_app_repo != "":
                            TEST_LOGGER.info(f"提交至项目库，jira_server:{jira_server}")
                            send_jira_request((self._submit_jira_url), reboot_excel_path, log_smb_username=(self._log_smb_username), log_smb_password=(self._log_smb_password), jira_server=jira_server)
                else:
                    TEST_LOGGER.info(f"项目：{prj}的核心应用问题，去重后数据为空，不执行Jira提交")
            else:
                TEST_LOGGER.info("submit_jira：False，不执行Jira提交")
            prj_result_dir = self._result_dir + os.sep + self._scan_date_formatted_fans_usic + os.sep + prj
            os.makedirs(prj_result_dir, exist_ok=True)
            if prj_result_dir and os.path.isdir(prj_result_dir):
                if os.path.isfile(org_excel_path):
                    try:
                        shutil.move(org_excel_path, prj_result_dir)
                        TEST_LOGGER.info("文件：{} 已移动至：{}".format(org_excel_path, prj_result_dir))
                    except shutil.Error:
                        excel_basename = os.path.basename(org_excel_path)
                        target_path = os.path.join(prj_result_dir, excel_basename)
                        os.remove(target_path)
                        try:
                            shutil.move(org_excel_path, prj_result_dir)
                            TEST_LOGGER.info("文件：{} 已移动至：{}".format(org_excel_path, prj_result_dir))
                        except:
                            TEST_LOGGER.error("Move org exception again: {}".format(traceback.format_exc()))

                    except:
                        TEST_LOGGER.error("Move org exception: {}".format(traceback.format_exc()))

            if os.path.isfile(final_excel_path):
                try:
                    shutil.move(final_excel_path, prj_result_dir)
                    TEST_LOGGER.info("文件：{} 已移动至：{}".format(final_excel_path, prj_result_dir))
                except shutil.Error:
                    excel_basename = os.path.basename(final_excel_path)
                    target_path = os.path.join(prj_result_dir, excel_basename)
                    os.remove(target_path)
                    try:
                        shutil.move(final_excel_path, prj_result_dir)
                        TEST_LOGGER.info("文件：{} 已移动至：{}".format(final_excel_path, prj_result_dir))
                    except:
                        TEST_LOGGER.error("Move org exception again: {}".format(traceback.format_exc()))

                except:
                    TEST_LOGGER.error("Move final exception: {}".format(traceback.format_exc()))

                if os.path.isfile(reboot_excel_path):
                    try:
                        shutil.move(reboot_excel_path, prj_result_dir)
                        TEST_LOGGER.info("文件：{} 已移动至：{}".format(reboot_excel_path, prj_result_dir))
                    except shutil.Error:
                        excel_basename = os.path.basename(reboot_excel_path)
                        target_path = os.path.join(prj_result_dir, excel_basename)
                        os.remove(target_path)
                        try:
                            shutil.move(reboot_excel_path, prj_result_dir)
                            TEST_LOGGER.info("文件：{} 已移动至：{}".format(reboot_excel_path, prj_result_dir))
                        except:
                            TEST_LOGGER.error("Move org exception again: {}".format(traceback.format_exc()))

                    except:
                        TEST_LOGGER.error("Move final exception: {}".format(traceback.format_exc()))

        if not self._submit_jira:
            send_msg_by_feishu_robot("日志未提交Jira", f"粉丝日志：{self._scan_date_formatted_fans_usic} 扫描，submit_jira False，请检查确认")
        TEST_LOGGER.info("已完成扫描日志目录:{}".format(self._scan_root_dir))

    def __scan_exp_main_list(self, prj, prj_scan_path):
        """
        扫描指定项目目录下所有的 __exp_main.txt 文件
        :param prj:
        :param prj_scan_path:
        :return:
        """
        TEST_LOGGER.info("********************" + " 开始扫描项目：{} 的 __exp_main.txt文件 ".format(prj) + "********************")
        exp_main_file_list = []
        for root, dirs, files in os.walk(prj_scan_path):
            for file in files:
                db_file_path = os.path.join(root, file)
                if file == "__exp_main.txt" and self._scan_date_formatted_fans_usic in db_file_path:
                    exp_main_file_list.append(db_file_path)
                    TEST_LOGGER.info("获取 __exp_main.txt 文件：{}".format(db_file_path))

        if exp_main_file_list:
            TEST_LOGGER.info("获取需要分析的__exp_main.txt文件共：{}个".format(len(exp_main_file_list)))
        else:
            TEST_LOGGER.warn("__exp_main.txt 列表为空")
        TEST_LOGGER.info("********************" + " 扫描项目：{} 的 __exp_main.txt文件已完成 ".format(prj) + "********************" + "\n")
        return (prj, exp_main_file_list)

    def __aee_to_data_list_fans(self, prj, aee_result_list):
        """
        将aee解析结果转换成原始数据和去重后数据
        : param prj 当前指定项目
        : param aee_result_list 需要去转换的aee类列表
        :return:
        """
        aee_rlt_list_org = []
        aee_rlt_list_final = []
        aee_rlt_list_core_and_reboot = []
        is_out_prj = False
        core_app_repo = None
        recognize_exception_list = []
        handle_recognize_failed_list = []
        if aee_result_list:
            top_apk_list = self._get_top_apk_list()
            limited_pri_date = None
            if self._limited_max_days > 0:
                limited_pri_date = datetime.datetime.now() - datetime.timedelta(days=(self._limited_max_days))
                limited_pri_date = limited_pri_date.strftime("%Y%m%d")
                TEST_LOGGER.info("存在最久限定日期：{}，计算版本限定日期为：{}".format(self._limited_max_days, limited_pri_date))
            if prj in self._limited_pri_date:
                limited_pri_date_prj = self._limited_pri_date[prj]
                if len(limited_pri_date_prj) == 6:
                    limited_pri_date_prj = "20" + limited_pri_date_prj
                TEST_LOGGER.info("项目：{} 存在限定版本日期：{}".format(prj, limited_pri_date_prj))
                if limited_pri_date:
                    limited_pri_date = limited_pri_date if limited_pri_date > limited_pri_date_prj else limited_pri_date_prj
                    TEST_LOGGER.info("项目：{} 获取最接近限定版本日期：{}".format(prj, limited_pri_date))
        else:
            limited_pri_date = limited_pri_date_prj
        regex_date = re.compile("(\\d{6})V\\d+")
        core_app_repo = self._core_app_repo_dict.get(prj)
        if core_app_repo is None or core_app_repo == "":
            core_app_repo = self._core_app_repo_out_dict.get(prj)
            if core_app_repo:
                if core_app_repo != "":
                    is_out_prj = True
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
            attrs_fans_version = aee_result_attrs[13]
            aee_result_attrs[0] = self._convert_path_to_win(attrs_path)
            path_org = aee_result_attrs[0]
            http_link = self.get_log_url(attrs_path)
            if http_link:
                aee_result_attrs[0] = aee_result_attrs[0] + "\n" + http_link
            aee_result_attrs[8] = attrs_caused_by[:10000]
            attrs_caused_by = aee_result_attrs[8]
            if attrs_version is None:
                TEST_LOGGER.warn(f"日志解析版本为空，Path: {attrs_path}")
                attrs_version = "VersionNone"
                aee_result_attrs[1] = "VersionNone"
            if attrs_package is None:
                TEST_LOGGER.warn("日志解析package为None，Path: {}".format(attrs_path))
                attrs_package = "PackageNone"
                aee_result_attrs[6] = "PackageNone"
            if not aee_result.recognize_exception_rlt:
                recognize_exception_list.append(path_org)
            elif not aee_result.handle_recognize_rlt:
                handle_recognize_failed_list.append(path_org)
            elif attrs_cur_process in ('com.transsion.tranfansfeedback', ):
                is_submit_to_prj_repo = False
            else:
                if attrs_fans_version:
                    if attrs_version.lower().endswith("fans"):
                        if attrs_cur_process in self._pkglist:
                            is_submit_to_prj_repo = True
                    else:
                        is_submit_to_prj_repo = self.is_reboot_issue(attrs_exp_class, attrs_path)
                else:
                    is_submit_to_prj_repo = False
            aee_rlt_list_org.append(list(aee_result_attrs))
            if attrs_exp_class is None or attrs_exp_type is None or attrs_cur_process is None:
                TEST_LOGGER.info(f"解释数据异常：attrs_exp_class: {attrs_exp_class}, attrs_exp_type: {attrs_exp_type}, attrs_cur_process:{attrs_cur_process}, 不计入去重后问题，Path: {attrs_path}")
                continue
            if "invalid_combo_wifi" in attrs_caused_by:
                TEST_LOGGER.info("combo_wifi 无效问题，不计入去重后问题。Path:{}".format(attrs_path))
                continue
            if "anr when screen off" in attrs_caused_by:
                TEST_LOGGER.info("anr 灭屏问题，不计入去重后问题。Path:{}".format(attrs_path))
                continue
            if "can not find pid" in attrs_caused_by:
                TEST_LOGGER.info("pid=0 问题，不计入去重后问题。Path:{}".format(attrs_path))
                continue
            if "fmstestsn20202021" in attrs_path or "1b373a4efc8c98ace07a4c502fd450f7" in attrs_path or "39dc3400de81d8ca05b2a9d735e67471dbb4ccc633a05071f727e1dac597ca02" in attrs_path:
                TEST_LOGGER.info(f"SN: fmstestsn20202021 问题，不计入去重后问题。Path:{attrs_path}")
                continue
            if limited_pri_date and attrs_version:
                regex_rlt = re.search(regex_date, attrs_version)
                if regex_rlt:
                    attrs_version_data = "20" + regex_rlt.group(1)
                    TEST_LOGGER.info("获取版本日期：{}，版本限定日期：{}".format(attrs_version_data, limited_pri_date))
                    if attrs_version_data < limited_pri_date:
                        TEST_LOGGER.warn("版本日期：[{}] 在 日期：[{}]之前，不计入去重后问题。Path:{}".format(attrs_version_data, limited_pri_date, path_org))
                        continue
                    else:
                        TEST_LOGGER.warn("获取版本日期失败，不再判断日志期限")
                elif not "system_app" in attrs_exp_type:
                    if "product_app" in attrs_exp_type or attrs_cur_process in self._pkglist:
                        skip_process = False
                elif attrs_package in top_apk_list:
                    skip_process = aee_result.is_foreground_no()
                    if skip_process:
                        TEST_LOGGER.warn("TOP三方app，is_foreground_no，不计入去重后问题。Path:{}".format(path_org))
                else:
                    TEST_LOGGER.warn("非系统或TOP三方app，不计入去重后问题。Path:{}".format(path_org))
                    skip_process = True
                if skip_process or is_submit_to_prj_repo:
                    target_aee_rlt_list = aee_rlt_list_core_and_reboot
                else:
                    target_aee_rlt_list = aee_rlt_list_final
                if len(target_aee_rlt_list) == 0:
                    target_aee_rlt_list.append(self._build_aee_final_attrs(aee_result_attrs))
                    continue
                current_target_aee_rlt_list_length = len(target_aee_rlt_list)
                for j in range(current_target_aee_rlt_list_length):
                    if not attrs_version == "VersionNone":
                        if attrs_version != target_aee_rlt_list[j][1]:
                            pass
                        elif (attrs_package == "PackageNone" or attrs_package) != target_aee_rlt_list[j][6]:
                            pass
                        elif attrs_exp_class == "ANR" and not attrs_activity:
                            if target_aee_rlt_list[j][11]:
                                if attrs_activity != target_aee_rlt_list[j][12]:
                                    pass
                        try:
                            str_1 = target_aee_rlt_list[j][8]
                            ratio = get_str_similar(str_1, attrs_caused_by)
                            if ratio >= self._ratio_std_aee:
                                target_aee_rlt_list[j][10] = target_aee_rlt_list[j][10] + 1
                                self._merge_aee_final_device_id(target_aee_rlt_list[j], attrs_device_id)
                                break
                        except:
                            pass

                        if j == current_target_aee_rlt_list_length - 1:
                            target_aee_rlt_list.append(self._build_aee_final_attrs(aee_result_attrs))

        if aee_rlt_list_final:
            for aee_rlt in aee_rlt_list_final:
                aee_rlt[6] = "3RD Application " + aee_rlt[6] if (aee_rlt[6] in top_apk_list and aee_rlt[6] not in self._pkglist) else (aee_rlt[6])

        if aee_rlt_list_core_and_reboot:
            for aee_rlt in aee_rlt_list_core_and_reboot:
                aee_rlt[6] = "3RD Application " + aee_rlt[6] if (aee_rlt[6] in top_apk_list and aee_rlt[6] not in self._pkglist) else (aee_rlt[6])

            if core_app_repo and core_app_repo != "":
                if str(core_app_repo).lower() == "false":
                    TEST_LOGGER.info(f"项目：{prj} 配置是否提交项目库为False，该项目重启问题不再提交项目库")
            else:
                TEST_LOGGER.warn(f"项目：{prj} 未找到项目库配置项，请检查，当前问题不再提交项目库")
                send_msg_by_feishu_robot("粉丝日志扫描告警", f"项目：{prj} 未找到项目库配置项，请检查")
        if recognize_exception_list:
            send_msg_by_feishu_robot("解析库解析异常日志路径：\n", "\\" + "\n\\".join(recognize_exception_list), f"日志解析库解析异常提醒 {RECOGNIZE_LIB_VERSION}")
        if handle_recognize_failed_list:
            send_msg_by_feishu_robot("解析库返回内容处理异常日志路径：\n", "\\" + "\n\\".join(handle_recognize_failed_list), f"解析库返回内容处理异常提醒 {RECOGNIZE_LIB_VERSION}")
        return (aee_rlt_list_org, aee_rlt_list_final, aee_rlt_list_core_and_reboot, core_app_repo, is_out_prj)

# okay decompiling extracted_pyz_modules/modules/mode\ScanAeeFans.pyc
