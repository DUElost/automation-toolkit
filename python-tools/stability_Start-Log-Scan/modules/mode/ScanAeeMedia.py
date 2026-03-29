# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\mode\ScanAeeMedia.py
import os, json, datetime, re, traceback
from modules.common.Db import query_max_round, insert_monkey_detail, insert_monkey_summary
from modules.common.Excel import Excel, read_aee_rlt_excel
from modules.common.ExecCmd import exec_cmd
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.common.Utils import send_jira_request, sendMail, insert_monkey_data, insert_monkey_data_org
from modules.mode.BaseScan import ScanBase, PATTERN_MAIL

class ScanAeePlatformMedia(ScanBase):

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, nas_address, task_tag, pipeline_id, uuid, end_of_scan, start_time, device_count, target_project, target_build, android, device_list, reporter, utp_tcid, utp_taskid):
        TEST_LOGGER.info("初始化 ScanAeePlatformMedia，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(scan_place))
        TEST_LOGGER.info("days_before：{}".format(days_before))
        TEST_LOGGER.info("scan_root_dir：{}".format(scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(cur_tool_dir))
        TEST_LOGGER.info("skip_extract：{}".format(skip_extract))
        TEST_LOGGER.info("skip_unzip：{}".format(skip_unzip))
        TEST_LOGGER.info("nas_address：{}".format(nas_address))
        TEST_LOGGER.info("task_tag：{}".format(task_tag))
        TEST_LOGGER.info("pipeline_id：{}".format(pipeline_id))
        TEST_LOGGER.info("uuid：{}".format(uuid))
        TEST_LOGGER.info("end_of_scan：{}".format(end_of_scan))
        TEST_LOGGER.info("start_time：{}".format(start_time))
        TEST_LOGGER.info("device_count：{}".format(device_count))
        TEST_LOGGER.info("target_project：{}".format(target_project))
        TEST_LOGGER.info("target_build：{}".format(target_build))
        TEST_LOGGER.info("android：{}".format(android))
        TEST_LOGGER.info(f"device_list:{device_list}")
        TEST_LOGGER.info(f"reporter:{reporter}")
        TEST_LOGGER.info("utp_tcid：{}".format(utp_tcid))
        TEST_LOGGER.info("utp_taskid：{}".format(utp_taskid))
        super(ScanAeePlatformMedia, self).__init__(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag)
        self._nas_address = nas_address
        self._pipeline_id = pipeline_id
        self._uuid = uuid
        self._end_of_scan = end_of_scan
        self._start_time_str = start_time
        self._end_time_str = None
        self._start_time = None
        self._end_time = None
        self._device_count = device_count
        self._android = android
        self._target_project = target_project
        self._target_build = target_build
        if ";" in device_list:
            self._device_list = device_list.split(";")
        else:
            if "," in device_list:
                self._device_list = device_list.split(",")
            else:
                if ":" in device_list:
                    self._device_list = device_list.split(":")
                self._scan_dir_by_sn_list = []
                self._jira_repo = None
                self._reporter = reporter
                self._utp_tcid = utp_tcid
                self._utp_taskid = utp_taskid

    def _get_scan_dir_failed(self, error_msg):
        self._ScanAeePlatformMedia__send_failure_mail(error_msg)

    def _init_scan_attrs(self):
        """
        初始化各个扫描模式的扫描参数
        :return:
        """
        if self._nas_address:
            self._archive_address = "\\\\{}\\".format(self._nas_address)
        else:
            self._archive_address = self._default_config["archive_address"]
        TEST_LOGGER.info("日志归档存放NAS:{}".format(self._archive_address))
        self._LoNg_mtbf_dir = self._scan_root_dir + os.sep + "LoNg_{}".format(self._android.upper()) + os.sep + "MTBF-log"
        self._result_dir = os.path.dirname(self._scan_root_dir) + os.sep + "PlatformResult"
        self._result_dir_pipeline = self._result_dir + os.sep + "{}".format(self._pipeline_id)
        TEST_LOGGER.info("结果存放根目录:{}".format(self._result_dir_pipeline))
        self._result_dir_daily = self._result_dir_pipeline + os.sep + "daily"
        self._result_dir_summary = self._result_dir_pipeline + os.sep + "summary"
        self._result_dir_daily_uuid = self._result_dir_daily + os.sep + self._uuid
        self._result_dir_summary_uuid = self._result_dir_summary + os.sep + self._uuid
        self._jira_repo = self._default_config.get("jira_repo")

    def _scan(self):
        """
        扫描开始
        :return:
        """
        TEST_LOGGER.resetTag(__name__)
        if self._end_of_scan:
            TEST_LOGGER.info("end_of_scan is True，扫描当天日志")
            self._scan_date_formatted_aee = datetime.datetime.now().strftime("%Y%m%d")
        TEST_LOGGER.info("扫描日志日期为：{}\n".format(self._scan_date_formatted_aee))
        TEST_LOGGER.info("传入的Monkey开始时间为：{}".format(self._start_time_str))
        if self._start_time_str:
            try:
                self._start_time = datetime.datetime.strptime(self._start_time_str, "%Y-%m-%d %H:%M:%S")
            except:
                TEST_LOGGER.warn("传入的Monkey开始时间格式异常，期望的格式：%Y-%m-%d %H:%M:%S，传入时间：{}".format(self._start_time_str))
                self._ScanAeePlatformMedia__send_failure_mail("传入的Monkey开始时间格式异常，期望的格式：%Y-%m-%d %H:%M:%S，传入时间：{}".format(self._start_time_str))
                return

        self._end_time = datetime.datetime.now()
        self._end_time_str = self._end_time.strftime("%Y-%m-%d %H:%M:%S")
        TEST_LOGGER.info("设置当前时间为结束时间：{}".format(self._end_time_str))
        if not os.path.isdir(self._LoNg_mtbf_dir):
            TEST_LOGGER.error("配置的扫描根目录:{} 不存在，请检查传入参数".format(self._LoNg_mtbf_dir))
            self._ScanAeePlatformMedia__send_failure_mail("配置的扫描根目录:{} 不存在，请检查传入参数".format(self._LoNg_mtbf_dir))
            return
        TEST_LOGGER.info("开始获取根目录:{} 下最新的目录".format(self._LoNg_mtbf_dir))
        loNg_dir_list = os.listdir(self._LoNg_mtbf_dir)
        loNg_dir_list.sort(reverse=True)
        for loNg_dir in loNg_dir_list:
            loNg_dir_path = os.path.join(self._LoNg_mtbf_dir, loNg_dir)
            if os.path.isdir(loNg_dir_path):
                self._scan_root_dir = loNg_dir_path
                break

        TEST_LOGGER.info("更新后扫描LoNg路径为：{}".format(self._scan_root_dir))
        TEST_LOGGER.info("传入的设备列表为：{}".format(self._device_list))
        for device_sn in self._device_list:
            TEST_LOGGER.info(f"开始确定设备：{device_sn}的扫描目录")
            if device_sn and device_sn != "":
                scan_dir_by_sn = self._scan_root_dir + os.sep + device_sn
                if os.path.isdir(scan_dir_by_sn):
                    TEST_LOGGER.info(f"设备：{device_sn} 的扫描目录为：{scan_dir_by_sn}")
                    self._scan_dir_by_sn_list.append(scan_dir_by_sn)

        TEST_LOGGER.info("根据设备列表，确定的扫描目录列表为：{}".format(self._scan_dir_by_sn_list))
        if not self._scan_dir_by_sn_list:
            TEST_LOGGER.error(f"在目录：{self._scan_root_dir} 下，未找到设备：{self._device_list} 的日志目录")
            return
        TEST_LOGGER.info("初始化扫描参数完成\n")
        TEST_LOGGER.info("开始执行扫描：")
        stop_scan = False
        unexpected_dbg_count = False
        discard_dbg_info_list = None
        if not self._skip_extract:
            skip_analyse_dbg = False
            if not self._skip_unzip:
                stop_scan, exception_zip_list, discard_dbg_info_list = self._analyse_db_file_map(self._device_list)
                if stop_scan:
                    TEST_LOGGER.warn("DBFileMap 解析结果，问题数超过最大数，不再执行后续扫描")
                else:
                    if exception_zip_list:
                        self._unzip_aee_exceptions(exception_zip_list)
                        skip_analyse_dbg = True
                    else:
                        TEST_LOGGER.warn("DBFileMap 分析结果不包含zip文件，扫描并解压所有的zip文件")
                        self._unzip_aee_all_camera_exceptions(self._scan_dir_by_sn_list)
            else:
                TEST_LOGGER.warn("skip_unzip:{}，跳过解压zip文件步骤".format(self._skip_unzip))
            if stop_scan:
                unexpected_dbg_count = True
            else:
                dbg_file_list = self._ScanAeePlatformMedia__get_dbg_list()
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
            exp_main_file_list = self._ScanAeePlatformMedia__scan_exp_main_list()
            aee_result_list = self._analyse_aee(exp_main_file_list, self._to_recognize_except, self._extra_jira_tag)
        aee_rlt_list_org, aee_rlt_list_final, to_be_deleted_file_list = self._aee_to_data_list(aee_result_list, True, self._special_build_prefix)
        if discard_dbg_info_list:
            aee_rlt_list_org = self._save_discard_to_org(aee_rlt_list_org, discard_dbg_info_list)
        self._ScanAeePlatformMedia__generate_result(aee_rlt_list_org, aee_rlt_list_final)
        total_aee_rlt_list_org, total_aee_rlt_list_final = self._ScanAeePlatformMedia__handle_history_data()
        TEST_LOGGER.info("{} 的扫描任务已完成".format(self._scan_date_formatted_aee))

    def __get_dbg_list(self):
        """
        扫描目录下符合条件的dbg文件列表
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描dbg文件 ********************")
        mtklog_tag = "mtklog_" + self._scan_date_formatted_aee
        dbg_file_list = []
        for scan_dir_by_sn in self._scan_dir_by_sn_list:
            TEST_LOGGER.info("扫描目录：{}，mtklog_tag：{}".format(scan_dir_by_sn, mtklog_tag))
            for root, dirs, files in os.walk(scan_dir_by_sn):
                for file in files:
                    file_path = os.path.join(root, file)
                    file_path_lower = file.lower()
                    if file_path_lower.endswith(".dbg") and mtklog_tag in file_path:
                        dbg_file_list.append(file_path)

        TEST_LOGGER.info("扫描获取dbg文件共：{}个".format(len(dbg_file_list)))
        TEST_LOGGER.info("******************** 扫描dbg文件已完成 ********************\n")
        return dbg_file_list

    def __scan_exp_main_list(self):
        """
        扫描目录下所有的 __exp_main.txt 文件
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描__exp_main.txt文件 ********************")
        exp_main_file_list = []
        for scan_dir_by_sn in self._scan_dir_by_sn_list:
            TEST_LOGGER.info("扫描目录：{}".format(scan_dir_by_sn))
            for root, dirs, files in os.walk(scan_dir_by_sn):
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

    def __generate_result(self, aee_rlt_list_org, aee_rlt_list_final):
        """
        根据解析结果生成结果文件，并提交jira
        :param aee_rlt_list_org:
        :param aee_rlt_list_final:
        :return:
        """
        TEST_LOGGER.info("******************** 开始生成结果文件与提交Jira ********************")
        TEST_LOGGER.info("检查并生成结果存放目录：{}".format(self._result_dir_daily_uuid))
        if not os.path.isdir(self._result_dir_daily_uuid):
            try:
                os.makedirs(self._result_dir_daily_uuid)
            except:
                TEST_LOGGER.error(traceback.format_exc())
                if self._platform_system != "windows":
                    TEST_LOGGER.info("尝试获取 mount -l 信息")
                    cmdline = ["mount", "-l"]
                    rlt, timeout_expired = exec_cmd(cmdline)
                    for line in rlt:
                        line = line.decode().strip()
                        TEST_LOGGER.info(line)

        if not self._target_build:
            if aee_rlt_list_org:
                build_version = None
                aee_rlt_list_org_length = len(aee_rlt_list_org)
                aee_rlt_index = 0
                while not aee_rlt_index < aee_rlt_list_org_length or build_version is None or build_version == "":
                    build_version = aee_rlt_list_org[aee_rlt_index][1]
                    aee_rlt_index += 1

                TEST_LOGGER.info("扫描结果记录中测试版本为：{}".format(build_version))
                self._target_build = build_version
        if not self._target_project:
            self._target_project = self._target_build.split("-")[0] if self._target_build else None
        statistics_project_name = self._target_project
        ready_to_submit_jira = False
        TEST_LOGGER.info("非基线测试项，获取提交参数")
        org_excel_name = "Result_{}_{}_MonkeyAEE_{}_{}_org.xls"
        final_excel_name = "Result_{}_{}_MonkeyAEE_{}_{}.xls"
        if aee_rlt_list_final:
            project_tag = self._target_build.rsplit("-", 1)[0] if self._target_build else None
            TEST_LOGGER.info("去除日期后版本标志为：{}".format(project_tag))
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
                else:
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
        org_excel_path, final_excel_path = (None, None)
        if aee_rlt_list_org:
            TEST_LOGGER.info(f"去重前数据：{len(aee_rlt_list_org)}")
            org_excel_name = org_excel_name.format(self._jira_repo, self._reporter, self._scan_place, self._scan_date_formatted_aee)
            org_excel_path = self._result_dir_daily_uuid + os.sep + org_excel_name
            TEST_LOGGER.info("去重前excel文件：{}".format(org_excel_path))
            excel = Excel(org_excel_path)
            try:
                excel.insertResultAee(aee_rlt_list_org, pipeline_id=(self._pipeline_id), utp_tcid=(self._utp_tcid), utp_taskid=(self._utp_taskid))
            except:
                TEST_LOGGER.warn(traceback.format_exc())

        else:
            TEST_LOGGER.warn("去重前数据为0")
            pass_file_path = self._result_dir_daily_uuid + os.sep + "pass.txt"
            with open(pass_file_path, "w", encoding="utf-8") as f:
                f.write("Congratulation! Scan Result: Org data is Null!")
        if aee_rlt_list_final:
            TEST_LOGGER.info(f"去重后数据：{len(aee_rlt_list_final)}")
            statistics_list = [
             statistics_project_name, self._target_build] + self.get_statistics(aee_rlt_list_final)
            final_excel_name = final_excel_name.format(self._jira_repo, self._reporter, self._scan_place, self._scan_date_formatted_aee)
            final_excel_path = self._result_dir_daily_uuid + os.sep + final_excel_name
            TEST_LOGGER.info("去重后Excel文件：{}".format(final_excel_path))
            excel = Excel(final_excel_path)
            try:
                excel.insertResultAee(aee_rlt_list_final, pipeline_id=(self._pipeline_id), utp_tcid=(self._utp_tcid), utp_taskid=(self._utp_taskid), deduplicated=True)
            except:
                TEST_LOGGER.warn(traceback.format_exc())

            if self._submit_jira:
                TEST_LOGGER.info("submit_jira：True，执行Jira提交，提交Url：{}".format(self._submit_jira_url))
                if ready_to_submit_jira:
                    send_jira_request((self._submit_jira_url), final_excel_path, jira_project_name=(self._jira_repo), monkey_type="camera")
                else:
                    TEST_LOGGER.info("ready_to_submit_jira False，jira提交数据异常，不执行Jira提交")
            else:
                TEST_LOGGER.info("submit_jira：False，不执行Jira提交")
        else:
            statistics_list = [
             statistics_project_name, self._target_build] + [0] * 17 + [""]
            TEST_LOGGER.warn("去重后数据：0")
            pass_file_path = self._result_dir_daily_uuid + os.sep + "pass.txt"
            with open(pass_file_path, "w", encoding="utf-8") as f:
                f.write("Congratulation! Scan Result: Available data is Null!")
        statistics_file_path = self._result_dir_daily_uuid + os.sep + "statistics.txt"
        with open(statistics_file_path, "w", encoding="utf-8") as f:
            f.write(str(statistics_list))
        self._send_result_feishu(statistics_list, aee_rlt_list_org, aee_rlt_list_final, self._result_dir_daily_uuid, self._pipeline_id, self._uuid, "平台多媒体日志扫描结果")
        self._send_result_mail(statistics_list, org_excel_path, final_excel_path, self._pipeline_id, self._uuid)
        TEST_LOGGER.info("******************** 生成结果文件与提交Jira ********************\n")

    def __handle_history_data(self):
        """
        处理历史数据
        :return:
        """
        TEST_LOGGER.info("******************** 生成累计结果 ********************")
        if not os.path.isdir(self._result_dir_summary_uuid):
            try:
                os.makedirs(self._result_dir_summary_uuid)
            except:
                pass

        total_aee_rlt_list = []
        for root, dirs, files in os.walk(self._result_dir_daily):
            for file in files:
                if file.endswith(".xls") and "org" in file:
                    xls_file_path = os.path.join(root, file)
                    aee_rlt_list = read_aee_rlt_excel(xls_file_path)
                    TEST_LOGGER.info("文件：{} 中读取记录：{}条".format(xls_file_path, len(aee_rlt_list)))
                    total_aee_rlt_list = total_aee_rlt_list + aee_rlt_list

        TEST_LOGGER.info("累计读取原始记录共：{}条".format(len(total_aee_rlt_list)))
        total_aee_rlt_list_org, total_aee_rlt_list_final, to_be_deleted_file_list = self._aee_to_data_list(total_aee_rlt_list)
        if not self._target_build:
            if total_aee_rlt_list_org:
                build_version = None
                aee_rlt_list_org_length = len(total_aee_rlt_list_org)
                aee_rlt_index = 0
                while not aee_rlt_index < aee_rlt_list_org_length or build_version is None or build_version == "":
                    build_version = total_aee_rlt_list_org[aee_rlt_index][1]
                    aee_rlt_index += 1

                TEST_LOGGER.info("扫描结果记录中测试版本为：{}".format(build_version))
                self._target_build = build_version
        if not self._target_project:
            self._target_project = self._target_build.split("-")[0] if self._target_build else None
        statistics_project_name = self._target_project
        org_excel_name = "Result_MonkeyAEE_Summary_{}_org.xls"
        final_excel_name = "Result_MonkeyAEE_Summary_{}.xls"
        if total_aee_rlt_list_org:
            org_excel_name = org_excel_name.format(self._scan_date_formatted_aee)
            org_excel_path = self._result_dir_summary_uuid + os.sep + org_excel_name
            TEST_LOGGER.info("累计去重前excel文件：{}".format(org_excel_path))
            excel = Excel(org_excel_path)
            try:
                excel.insertResultAee(total_aee_rlt_list_org, pipeline_id=(self._pipeline_id), utp_tcid=(self._utp_tcid), utp_taskid=(self._utp_taskid))
            except:
                TEST_LOGGER.warn(traceback.format_exc())

        if total_aee_rlt_list_final:
            statistics_list = [
             statistics_project_name, self._target_build] + self.get_statistics(total_aee_rlt_list_final)
            final_excel_name = final_excel_name.format(self._scan_date_formatted_aee)
            final_excel_path = self._result_dir_summary_uuid + os.sep + final_excel_name
            TEST_LOGGER.info("累计去重后Excel文件：{}".format(final_excel_path))
            excel = Excel(final_excel_path)
            try:
                excel.insertResultAee(total_aee_rlt_list_final, pipeline_id=(self._pipeline_id), utp_tcid=(self._utp_tcid), utp_taskid=(self._utp_taskid), deduplicated=True)
            except:
                TEST_LOGGER.warn(traceback.format_exc())

        else:
            statistics_list = [
             statistics_project_name, self._target_build] + [0] * 17 + [""]
            TEST_LOGGER.warn("去重后数据为0")
        statistics_file_path = self._result_dir_summary_uuid + os.sep + "statistics.txt"
        with open(statistics_file_path, "w", encoding="utf-8") as f:
            f.write(str(statistics_list))
        TEST_LOGGER.info("******************** 生成累计结果完成 ********************\n")
        return (total_aee_rlt_list_org, total_aee_rlt_list_final)

    def __send_failure_mail(self, error_msg):
        if self._scan_system_mail_list:
            subject = f"【日志扫描异常】【ScanAeePlatform】【{self._scan_site}】【{self._pipeline_id}】【{self._uuid}】【{self._scan_date_formatted_aee}】"
            content = f"ScanAeePlatform 平台日志扫描任务：\nPipeline：[{self._pipeline_id}]\nuuid：[{self._uuid}]\n扫描目录：[{self._scan_root_dir}]\n"
            content = content + "\n失败信息：\n"
            content = content + error_msg
            if self._scan_system_mail_list:
                sendMail(subject, content, self._scan_system_mail_list)

# okay decompiling extracted_pyz_modules/modules/mode\ScanAeeMedia.pyc
