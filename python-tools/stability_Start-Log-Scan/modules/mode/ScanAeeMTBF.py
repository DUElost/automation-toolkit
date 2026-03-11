# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\mode\ScanAeeMTBF.py
import os, re, traceback
from modules.common.Excel import Excel, read_aee_rlt_excel
from modules.common.ExecCmd import exec_cmd
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.common.Utils import sendMail
from modules.mode.BaseScan import ScanBase, PATTERN_MAIL

class ScanAeeMTBF(ScanBase):

    def __init__(self, scan_mode, scan_place, scan_root_dir, cur_tool_dir, nas_address, pipeline_id, uuid, end_of_scan, target_project, target_build, utp_tcid, utp_taskid):
        TEST_LOGGER.info("初始化 ScanAeeMTBF，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(scan_place))
        TEST_LOGGER.info("scan_root_dir：{}".format(scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(cur_tool_dir))
        TEST_LOGGER.info("nas_address：{}".format(nas_address))
        TEST_LOGGER.info("pipeline_id：{}".format(pipeline_id))
        TEST_LOGGER.info("uuid：{}".format(uuid))
        TEST_LOGGER.info("end_of_scan：{}".format(end_of_scan))
        TEST_LOGGER.info("target_project：{}".format(target_project))
        TEST_LOGGER.info("target_build：{}".format(target_build))
        TEST_LOGGER.info("utp_tcid：{}".format(utp_tcid))
        TEST_LOGGER.info("utp_taskid：{}".format(utp_taskid))
        days_before = 0
        skip_extract = False
        skip_unzip = False
        task_tag = None
        super(ScanAeeMTBF, self).__init__(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag)
        self._nas_address = nas_address
        self._pipeline_id = pipeline_id
        self._uuid = uuid
        self._end_of_scan = end_of_scan
        self._utp_tcid = utp_tcid
        self._utp_taskid = utp_taskid
        self._target_project = target_project
        self._target_build = target_build

    def _get_scan_dir_failed(self, error_msg):
        return

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
        if self._result_dir and os.path.isdir(self._result_dir):
            TEST_LOGGER.info(f"使用配置的扫描结果存放目录：{self._result_dir}")
        else:
            mtbf_result_dir = str(self._scan_root_dir).split("bifrost")[0]
            self._result_dir = mtbf_result_dir + os.sep + "PlatformResult" + os.sep + "MTBF"
            TEST_LOGGER.info(f"解析传入的日志路径，合成扫描结果存放根目录：{self._result_dir}")
        self._result_dir_pipeline = self._result_dir + os.sep + str(self._pipeline_id)
        self._result_dir_uuid = self._result_dir_pipeline + os.sep + self._uuid
        TEST_LOGGER.info("本轮扫描结果存放目录:{}".format(self._result_dir_uuid))

    def _scan(self):
        """
        扫描开始
        :return:
        """
        TEST_LOGGER.resetTag(__name__)
        dbg_file_list = self._ScanAeeMTBF__get_dbg_list()
        self._extract_dbg(dbg_file_list)
        exp_main_file_list = self._ScanAeeMTBF__scan_exp_main_list()
        aee_result_list = self._analyse_aee(exp_main_file_list, self._to_recognize_except, self._extra_jira_tag)
        aee_rlt_list_org, aee_rlt_list_final, to_be_deleted_file_list = self._aee_to_data_list(aee_result_list, True, self._special_build_prefix)
        self._ScanAeeMTBF__generate_result(aee_rlt_list_org, aee_rlt_list_final)
        if self._end_of_scan:
            TEST_LOGGER.info("end_of_scan is True，整合本轮扫描结果")
            aee_rlt_list_org, aee_rlt_list_final, to_be_deleted_file_list = self._ScanAeeMTBF__handle_history_data()
            self._ScanAeeMTBF__generate_result(aee_rlt_list_org, aee_rlt_list_final, True)
        TEST_LOGGER.info("扫描任务已完成")

    def __get_dbg_list(self):
        """
        扫描目录下符合条件的dbg文件列表
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描dbg文件 ********************")
        TEST_LOGGER.info(f"扫描目录：{self._scan_root_dir}")
        dbg_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                file_path = os.path.join(root, file)
                file_path_lower = file.lower()
                if file_path_lower.endswith(".dbg"):
                    dbg_file_list.append(file_path)

        if dbg_file_list:
            TEST_LOGGER.info("扫描获取dbg文件共：{}个".format(len(dbg_file_list)))
        else:
            TEST_LOGGER.warn("扫描获取dbg文件为空")
        TEST_LOGGER.info("******************** 扫描dbg文件已完成 ********************\n")
        return dbg_file_list

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
                if file == "__exp_main.txt":
                    exp_main_file_list.append(db_file_path)
                    TEST_LOGGER.info("获取 __exp_main.txt 文件：{}".format(db_file_path))

        if exp_main_file_list:
            TEST_LOGGER.info("获取需要分析的__exp_main.txt文件共：{}个".format(len(exp_main_file_list)))
        else:
            TEST_LOGGER.warn("__exp_main.txt 列表为空")
        TEST_LOGGER.info("******************** 扫描__exp_main.txt文件已完成 ********************\n")
        return exp_main_file_list

    def __generate_result(self, aee_rlt_list_org, aee_rlt_list_final, is_summary=False):
        """
        根据解析结果生成结果文件，并提交jira
        :param aee_rlt_list_org:
        :param aee_rlt_list_final:
        :return:
        """
        TEST_LOGGER.info("******************** 开始生成结果文件与提交Jira ********************")
        if is_summary:
            self._result_dir_uuid = self._result_dir_pipeline + os.sep + "summary"
            TEST_LOGGER.info(f"生成汇总数据，设置汇总存放目录 self._result_dir_uuid：{self._result_dir_uuid}")
        else:
            TEST_LOGGER.info(f"检查并生成结果存放目录 self._result_dir_uuid：{self._result_dir_uuid}")
        if not os.path.isdir(self._result_dir_uuid):
            try:
                os.makedirs((self._result_dir_uuid), exist_ok=True)
            except:
                TEST_LOGGER.error(traceback.format_exc())
                if self._platform_system != "windows":
                    TEST_LOGGER.info("尝试获取 mount -l 信息：\n")
                    cmdline = ["mount", "-l"]
                    rlt, timeout_expired = exec_cmd(cmdline)
                    for line in rlt:
                        line = line.decode().strip()
                        TEST_LOGGER.info(line)

        if not os.path.isdir(self._result_dir_uuid):
            TEST_LOGGER.warn(f"结果存放目录：{self._result_dir_uuid}不存在，存放路径设置为：{PathManager.result_folder}")
            self._result_dir_uuid = PathManager.result_folder
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
        else:
            statistics_project_name = self._target_project
            if aee_rlt_list_final:
                project_tag = self._target_build.rsplit("-", 1)[0] if self._target_build else None
                TEST_LOGGER.info("去除日期后版本标志为：{}".format(project_tag))
                jira_project_file_path = PathManager.config_folder + os.sep + self._jira_project_file
                mp_block_file_path = PathManager.config_folder + os.sep + self._mp_block_file
                self._jira_repo, self._is_mp_block, mail_list = self._get_jira_project(project_tag, jira_project_file_path, mp_block_file_path)
                if self._send_notify_mail_to_project:
                    if mail_list:
                        self._notify_mail_list.extend(re.findall(PATTERN_MAIL, mail_list))
                org_excel_name = f"Result_MTBF_{self._target_project}_{self._reporter}_{self._scan_place}_{self._scan_date_formatted_aee}_org.xls"
                final_excel_name = f"Result_MTBF_{self._target_project}_{self._reporter}_{self._scan_place}_{self._scan_date_formatted_aee}.xls"
                org_excel_path, final_excel_path = (None, None)
                if aee_rlt_list_org:
                    org_excel_path = self._result_dir_uuid + os.sep + org_excel_name
                    TEST_LOGGER.info("去重前excel文件：{}".format(org_excel_path))
                    excel = Excel(org_excel_path)
                    try:
                        excel.insertResultAee(aee_rlt_list_org, pipeline_id=(self._pipeline_id), utp_tcid=(self._utp_tcid), utp_taskid=(self._utp_taskid))
                    except:
                        TEST_LOGGER.warn(traceback.format_exc())

            else:
                TEST_LOGGER.warn("去重前数据为0")
        if aee_rlt_list_final:
            statistics_list = [
             statistics_project_name, self._target_build] + self.get_statistics(aee_rlt_list_final)
            final_excel_name = final_excel_name.format(self._jira_repo, self._reporter, self._scan_place, self._scan_date_formatted_aee)
            final_excel_path = self._result_dir_uuid + os.sep + final_excel_name
            TEST_LOGGER.info("去重后Excel文件：{}".format(final_excel_path))
            excel = Excel(final_excel_path)
            try:
                excel.insertResultAee(aee_rlt_list_final, pipeline_id=(self._pipeline_id), utp_tcid=(self._utp_tcid), utp_taskid=(self._utp_taskid))
            except:
                TEST_LOGGER.warn(traceback.format_exc())

        else:
            statistics_list = [
             statistics_project_name, self._target_build] + [0] * 17 + [""]
            TEST_LOGGER.warn("去重后数据为0")
        statistics_file_path = self._result_dir_uuid + os.sep + "statistics.txt"
        with open(statistics_file_path, "w", encoding="utf-8") as f:
            f.write(str(statistics_list))
        self._send_result_mail(statistics_list, org_excel_path, final_excel_path, self._pipeline_id, self._uuid)
        TEST_LOGGER.info("******************** 生成结果文件与提交Jira ********************\n")

    def __handle_history_data(self):
        """
        处理历史数据
        :return:
        """
        TEST_LOGGER.info("******************** 生成累计结果 ********************")
        total_aee_rlt_list = []
        for root, dirs, files in os.walk(self._result_dir_pipeline):
            for file in files:
                file_lower = file.lower()
                if file.endswith(".xls") and "org" in file_lower:
                    xls_file_path = os.path.join(root, file)
                    aee_rlt_list = read_aee_rlt_excel(xls_file_path)
                    TEST_LOGGER.info("文件：{} 中读取记录：{}条".format(xls_file_path, len(aee_rlt_list)))
                    total_aee_rlt_list = total_aee_rlt_list + aee_rlt_list

        TEST_LOGGER.info("累计读取原始记录共：{}条".format(len(total_aee_rlt_list)))
        return self._aee_to_data_list(total_aee_rlt_list)

# okay decompiling extracted_pyz_modules/modules/mode\ScanAeeMTBF.pyc
