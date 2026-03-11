# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\mode\ScanAeeDaily.py
import os, re, traceback
from concurrent.futures import ThreadPoolExecutor
import modules.common.Excel as Excel
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.common.Utils import unzip, sendMail, send_jira_request
from modules.mode.BaseScan import ScanBase, PATTERN_MAIL

class ScanAeeDaily(ScanBase):

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag):
        TEST_LOGGER.info("初始化 ScanAeeDaily，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(scan_place))
        TEST_LOGGER.info("days_before：{}".format(days_before))
        TEST_LOGGER.info("scan_root_dir：{}".format(scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(cur_tool_dir))
        TEST_LOGGER.info("skip_extract：{}".format(skip_extract))
        TEST_LOGGER.info("skip_unzip：{}".format(skip_unzip))
        TEST_LOGGER.info("task_tag：{}".format(task_tag))
        super(ScanAeeDaily, self).__init__(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag)

    def _get_scan_dir_failed(self, error_msg):
        self._ScanAeeDaily__send_failure_mail(error_msg)

    def _init_scan_attrs(self):
        """
        初始化各个扫描模式的扫描参数
        :return:
        """
        return

    def _scan(self):
        TEST_LOGGER.resetTag(__name__)
        if self._scan_place == "SZ":
            TEST_LOGGER.info("测试归属地：{}，根据主机名：{} 确定扫描目录和归档nas ip地址".format(self._scan_place, self._hostname))
            self._scan_root_dir = "/mnt/nas/{}/LoNg_v2.1710.5/MTBF-log".format(self._hostname)
            TEST_LOGGER.info("主机：{} 确定扫描目录：{}".format(self._hostname, self._scan_root_dir))
            try:
                host_number = int(re.search("(\\d+)", self._hostname).group(1))
                if 1 <= host_number <= 15:
                    self._archive_address = "\\\\10.243.155.11\\"
                else:
                    if 16 <= host_number <= 30:
                        self._archive_address = "\\\\10.243.155.12\\"
                    else:
                        if 31 <= host_number <= 45:
                            self._archive_address = "\\\\10.243.155.10\\"
                TEST_LOGGER.info("主机：{} 确定的归档NAS ip：{}".format(self._hostname, self._archive_address))
            except:
                TEST_LOGGER.warn("主机：{} 确定归档NAS ip地址时发生异常：\n{}".format(self._hostname, traceback.format_exc()))
                subject = "日志每日扫描归档地址替换异常【{}】【{}】".format(self._hostname, self._scan_date_formatted_fans_usic)
                content = "扫描主机：{}，解析文件暂不提交Jira，请检查后手动提交。\n归档异常内容：\n{}".format(self._hostname, traceback.format_exc())
                self._archive_address = "\\\\unknownAddress\\"
                if self._scan_system_mail_list:
                    sendMail(subject, content, self._scan_system_mail_list)

        if not os.path.isdir(self._scan_root_dir):
            TEST_LOGGER.error(f"配置的扫描根目录:{self._scan_root_dir} 不存在，请检查配置文件：{self._config_file}")
            self._ScanAeeDaily__send_failure_mail(f"扫描服务器：{self._hostname}，配置的扫描根目录:{self._scan_root_dir} 不存在，请检查传入参数")
            return
        TEST_LOGGER.info("开始获取根目录:{} 下最新的目录".format(self._scan_root_dir))
        loNg_dir_list = os.listdir(self._scan_root_dir)
        loNg_dir_list.sort(reverse=True)
        TEST_LOGGER.info(loNg_dir_list)
        for loNg_dir in loNg_dir_list:
            loNg_dir_path = os.path.join(self._scan_root_dir, loNg_dir)
            if os.path.isdir(loNg_dir_path):
                self._scan_root_dir = loNg_dir_path
                break

        TEST_LOGGER.info("获取最新的目录：{}".format(self._scan_root_dir))
        TEST_LOGGER.info("初始化扫描参数完成\n")
        TEST_LOGGER.info("开始执行扫描：")
        TEST_LOGGER.info("扫描LoNg路径为：{}".format(self._scan_root_dir))
        TEST_LOGGER.info("相似度系数定值为：{}".format(self._ratio_std_aee))
        TEST_LOGGER.info("扫描日志日期为：{}\n".format(self._scan_date_formatted_aee))
        unexpected_dbg_count = False
        discard_dbg_info_list = None
        if not self._skip_extract:
            if not self._skip_unzip:
                skip_analyse_dbg = False
                stop_scan, exception_zip_list, discard_dbg_info_list = self._analyse_db_file_map()
                if stop_scan:
                    TEST_LOGGER.warn("DBFileMap 解析结果，问题数超过最大数，不再执行后续扫描")
                else:
                    if exception_zip_list:
                        self._unzip_aee_exceptions(exception_zip_list)
                        skip_analyse_dbg = True
                    else:
                        self._unzip_aee_exceptions()
            else:
                TEST_LOGGER.warn("skip_unzip:{}，跳过解压zip文件步骤".format(self._skip_unzip))
            if stop_scan:
                unexpected_dbg_count = True
            else:
                dbg_file_list = self._ScanAeeDaily__get_dbg_list()
                if skip_analyse_dbg:
                    TEST_LOGGER.info("已分析过DBFileMap文件，不再分析ZZ_INTERNAL文件")
                else:
                    stop_scan, zz_list_to_be_analysed, discard_dbg_info_list = self._pre_analyse_dbg(dbg_file_list)
                    if stop_scan:
                        TEST_LOGGER.warn("预过滤后，dbg文件过多，停止后续步骤，设置 unexpected_dbg_count = True")
                        unexpected_dbg_count = True
                    else:
                        dbg_file_list = []
                        for zz_internal in zz_list_to_be_analysed:
                            dbg_file_list.append(zz_internal.dbg_path)

                        if len(dbg_file_list) == 0:
                            TEST_LOGGER.warn("预过滤后，dbg文件列表为空，设置 unexpected_dbg_count = True")
                            unexpected_dbg_count = True
                        if unexpected_dbg_count:
                            TEST_LOGGER.warn("unexpected_dbg_count: True，不执行解压操作")
                        else:
                            self._extract_dbg(dbg_file_list)
        else:
            TEST_LOGGER.warn("skip_extract:{}，跳过解压步骤".format(self._skip_extract))
        if unexpected_dbg_count:
            TEST_LOGGER.warn("unexpected_dbg_count: True，直接设置 aee_result_list 为空")
            aee_result_list = []
        else:
            exp_main_file_list = self._ScanAeeDaily__scan_exp_main_list()
            aee_result_list = self._analyse_aee(exp_main_file_list, self._to_recognize_except, self._extra_jira_tag)
        aee_rlt_list_org, aee_rlt_list_final, to_be_deleted_file_list = self._aee_to_data_list(aee_result_list, True, self._special_build_prefix)
        if discard_dbg_info_list:
            aee_rlt_list_org = self._save_discard_to_org(aee_rlt_list_org, discard_dbg_info_list)
        self._ScanAeeDaily__generate_result(aee_rlt_list_org, aee_rlt_list_final)
        TEST_LOGGER.info("{} 的扫描任务已完成".format(self._scan_date_formatted_aee))

    def __scan_exp_main_list(self):
        """
        扫描目录下所有的 __exp_main.txt 文件
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描__exp_main.txt文件 ********************")
        exp_main_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                db_file_path = os.path.join(root, file)
                if file == "__exp_main.txt" and self._scan_date_formatted_aee in db_file_path:
                    exp_main_file_list.append(db_file_path)
                    TEST_LOGGER.info("获取 __exp_main.txt 文件：{}".format(db_file_path))

        if exp_main_file_list:
            TEST_LOGGER.info("获取需要分析的__exp_main.txt文件共：{}个".format(len(exp_main_file_list)))
        else:
            TEST_LOGGER.warn("__exp_main.txt 列表为空")
        TEST_LOGGER.info("******************** 扫描__exp_main.txt文件已完成 ********************\n")
        return exp_main_file_list

    def __unzip_exceptions(self):
        """
        解压mtklog zip文件
        :return:
        """
        mtklog_tag = "mtklog_" + self._scan_date_formatted_aee
        unzip_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                portion = os.path.splitext(file)
                file_name = portion[0].lower()
                file_postfix = portion[1].lower()
                if file_postfix == ".zip" and "exception" in file_name and mtklog_tag in file_name:
                    unzip_file_list.append(os.path.join(root, file))

        if unzip_file_list:
            TEST_LOGGER.info("******************** 开始解压zip文件 ********************")
            with ThreadPoolExecutor(max_workers=5, thread_name_prefix="unzip_mtklog_thread") as executor:
                [executor.submit(unzip, self._unzip, unzip_file) for unzip_file in unzip_file_list]
            TEST_LOGGER.info("******************** zip文件解压完成 ********************\n")

    def __get_dbg_list(self):
        """
        扫描目录下符合条件的dbg文件列表
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描dbg文件 ********************")
        mtklog_tag = "mtklog_" + self._scan_date_formatted_aee
        TEST_LOGGER.info("扫描目录：{}，mtklog_tag：{}".format(self._scan_root_dir, mtklog_tag))
        dbg_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                file_path = os.path.join(root, file)
                file_path_lower = file.lower()
                if file_path_lower.endswith(".dbg") and mtklog_tag in file_path:
                    dbg_file_list.append(file_path)
                    TEST_LOGGER.info("发现dbg文件：{}".format(file_path))

        TEST_LOGGER.info("扫描获取dbg文件共：{}个".format(len(dbg_file_list)))
        TEST_LOGGER.info("******************** 扫描dbg文件已完成 ********************\n")
        return dbg_file_list

    def __generate_result(self, aee_rlt_list_org, aee_rlt_list_final):
        """
        根据解析结果生成结果文件，并提交jira
        :param aee_rlt_list_org:
        :param aee_rlt_list_final:
        :return:
        """
        TEST_LOGGER.info("******************** 开始生成结果文件与提交Jira ********************")
        result_date_formatted = self._scan_date_formatted_aee if self._scan_date_formatted_aee != "" else self._report_date_formatted
        final_rlt_dir_path = self._result_dir + os.sep + self._hostname + os.sep + result_date_formatted
        if not os.path.isdir(final_rlt_dir_path):
            try:
                os.makedirs(final_rlt_dir_path)
            except:
                pass

        org_excel_name = "Result_{}-AeeExpAuto_{}_MonkeyAEE_{}_{}_org.xls"
        final_excel_name = "Result_{}-AeeExpAuto_{}_MonkeyAEE_{}_{}.xls"
        ready_to_submit_jira = False
        statistics_project_name = "UnknownProject"
        target_build = "UnknownBuild"
        org_excel_path, final_excel_path = (None, None)
        if aee_rlt_list_org:
            build_version = None
            aee_rlt_list_org_length = len(aee_rlt_list_org)
            aee_rlt_index = 0
            while not aee_rlt_index < aee_rlt_list_org_length or build_version is None or build_version == "":
                build_version = aee_rlt_list_org[aee_rlt_index][1]
                aee_rlt_index += 1

            TEST_LOGGER.info("扫描结果记录中测试版本为：{}".format(build_version))
            project_tag = build_version.rsplit("-", 1)[0] if build_version else None
            TEST_LOGGER.info("去除日期后版本标志为：{}".format(project_tag))
            statistics_project_name = build_version.split("-")[0] if build_version else None
            target_build = build_version
            if aee_rlt_list_final:
                if self._jira_repo:
                    TEST_LOGGER.info("已指定Jira提交库名，不设置 MP_Block")
                    self._is_mp_block = False
                else:
                    jira_project_file_path = PathManager.config_folder + os.sep + self._jira_project_file
                    mp_block_file_path = PathManager.config_folder + os.sep + self._mp_block_file
                    self._jira_repo, self._is_mp_block, mail_list = self._get_jira_project(project_tag, jira_project_file_path, mp_block_file_path)
                    if self._send_notify_mail_to_project:
                        if mail_list:
                            self._notify_mail_list.extend(re.findall(PATTERN_MAIL, mail_list))
                    if self._jira_repo:
                        TEST_LOGGER.info("Jira提交库名：{}".format(self._jira_repo))
                        ready_to_submit_jira = True
                    else:
                        TEST_LOGGER.error("Jira项目映射文件中未找到对应项目，不自动提单！")
                        ready_to_submit_jira = False
                if self._is_mp_block:
                    TEST_LOGGER.info("is_mp_block：True，项目：{}，标注MP Block，设置place为MP".format(project_tag))
                    self._scan_place = "MP"
        else:
            TEST_LOGGER.info("is_mp_block：False，项目：{}，不标注MP Block".format(project_tag))
        org_excel_name = org_excel_name.format(self._jira_repo, self._reporter, self._scan_place, result_date_formatted)
        org_excel_path = final_rlt_dir_path + os.sep + org_excel_name
        TEST_LOGGER.info("去重前excel文件：{}".format(org_excel_path))
        excel = Excel(org_excel_path)
        try:
            excel.insertResultAee(aee_rlt_list_org)
        except:
            TEST_LOGGER.warn(traceback.format_exc())

        if aee_rlt_list_final:
            statistics_list = [
             statistics_project_name, target_build] + self.get_statistics(aee_rlt_list_final)
            final_excel_name = final_excel_name.format(self._jira_repo, self._reporter, self._scan_place, result_date_formatted)
            final_excel_path = final_rlt_dir_path + os.sep + final_excel_name
            TEST_LOGGER.info("去重后Excel文件：{}".format(final_excel_path))
            excel = Excel(final_excel_path)
            try:
                excel.insertResultAee(aee_rlt_list_final)
            except:
                TEST_LOGGER.warn(traceback.format_exc())

            if self._submit_jira:
                TEST_LOGGER.info("submit_jira：True，执行Jira提交，提交Url：{}".format(self._submit_jira_url))
                if ready_to_submit_jira:
                    if "unknownAddress" not in self._archive_address:
                        send_jira_request(self._submit_jira_url, final_excel_path)
                    else:
                        TEST_LOGGER.info("ready_to_submit_jira：{}，archive_address：{}，jira提交数据异常，不执行Jira提交".format(ready_to_submit_jira, self._archive_address))
                else:
                    TEST_LOGGER.info("submit_jira：False，不执行Jira提交")
            else:
                statistics_list = [
                 statistics_project_name, target_build] + [0] * 17
                TEST_LOGGER.warn("去重后数据为0")
                pass_file_path = final_rlt_dir_path + os.sep + "pass.txt"
                with open(pass_file_path, "w", encoding="utf-8") as f:
                    f.write("Congratulation! Scan Result: Available data is Null!")
        else:
            TEST_LOGGER.warn("去重前数据为0")
            pass_file_path = final_rlt_dir_path + os.sep + "pass.txt"
            with open(pass_file_path, "w", encoding="utf-8") as f:
                f.write("Congratulation! Scan Result: Org data is Null!")
            statistics_list = [
             statistics_project_name, target_build] + [0] * 17 + [""]
        self._send_result_mail(statistics_list, org_excel_path, final_excel_path)
        statistics_file_path = final_rlt_dir_path + os.sep + "statistics.txt"
        with open(statistics_file_path, "w", encoding="utf-8") as f:
            f.write(str(statistics_list))
        TEST_LOGGER.info("******************** aee解析完成 ********************\n")

    def __send_failure_mail(self, error_msg):
        if self._scan_system_mail_list:
            subject = f"【日志扫描异常】【ScanAeeDaily】【{self._scan_site}】【{self._hostname}】【{self._scan_date_formatted_aee}】"
            content = f"ScanAeeDaily 每日日志扫描异常\n扫描服务器：[{self._hostname}]\n扫描目录：[{self._scan_root_dir}]\n"
            content = content + "\n失败信息：\n"
            content = content + error_msg
            if self._scan_system_mail_list:
                sendMail(subject, content, self._scan_system_mail_list)

# okay decompiling extracted_pyz_modules/modules/mode\ScanAeeDaily.pyc
