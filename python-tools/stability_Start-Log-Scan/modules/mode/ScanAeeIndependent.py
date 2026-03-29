# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\mode\ScanAeeIndependent.py
import os, re, shutil, traceback
import modules.common.Excel as Excel
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import send_jira_request, delete_mtklog_dir
from modules.mode.BaseScan import ScanBase

class ScanAeeIndependent(ScanBase):

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, nas_address=None, task_tag=None, delete_logs=False):
        TEST_LOGGER.info("初始化 ScanAeeIndependent，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(scan_place))
        TEST_LOGGER.info("days_before：{}".format(days_before))
        TEST_LOGGER.info("scan_root_dir：{}".format(scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(cur_tool_dir))
        TEST_LOGGER.info("skip_extract：{}".format(skip_extract))
        TEST_LOGGER.info("skip_unzip：{}".format(skip_unzip))
        TEST_LOGGER.info("task_tag：{}".format(task_tag))
        TEST_LOGGER.info("delete_logs：{}".format(delete_logs))
        super(ScanAeeIndependent, self).__init__(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag, delete_logs)
        TEST_LOGGER.info("nas_address：{}".format(nas_address))

    def _get_scan_dir_failed(self, error_msg):
        return

    def _init_scan_attrs(self):
        return

    def _scan(self):
        """
        扫描开始
        :return:
        """
        TEST_LOGGER.resetTag(__name__)
        pattern_jira = ".*osptlog[/|\\\\](.*?)[/|\\\\].*"
        self._jira_repo = re.match(pattern_jira, self._scan_root_dir).group(1)
        TEST_LOGGER.info("jira_repo: {}".format(self._jira_repo))
        if not self._skip_extract:
            if not self._skip_unzip:
                self._unzip_aee_exceptions()
            else:
                TEST_LOGGER.warn("skip_unzip:{}，跳过解压zip文件步骤".format(self._skip_unzip))
            dbg_file_list = self._ScanAeeIndependent__get_dbg_list()
            self._extract_dbg(dbg_file_list)
        else:
            TEST_LOGGER.warn("skip_extract:{}，跳过解压步骤".format(self._skip_extract))
        exp_main_file_list = self._ScanAeeIndependent__getAnalyseList()
        replace_path = False
        if self._archive_address:
            if self._replace_index:
                replace_path = True
        aee_result_list = self._analyse_aee(exp_main_file_list, self._to_recognize_except, self._extra_jira_tag)
        aee_rlt_list_org, aee_rlt_list_final, to_be_deleted_file_list = self._aee_to_data_list(aee_result_list, replace_path=replace_path,
          special_build_prefix=(self._special_build_prefix))
        if to_be_deleted_file_list:
            if self._delete_logs:
                for to_be_deleted_file in to_be_deleted_file_list:
                    if delete_mtklog_dir(to_be_deleted_file):
                        TEST_LOGGER.info("文件：{} 所在目录已被删除！".format(to_be_deleted_file))
                    else:
                        TEST_LOGGER.warn("删除文件：{} 所在目录返回失败！".format(to_be_deleted_file))

        self._ScanAeeIndependent__generate_result_aee(aee_rlt_list_org, aee_rlt_list_final)

    def __generate_result_aee(self, aee_rlt_list_org, aee_rlt_list_final):
        """
        根据aee解析结果生成对应excel文件
        :param aee_rlt_list_org:
        :param aee_rlt_list_final:
        :return:
        """
        TEST_LOGGER.info("******************** 开始生成aee结果文件 ********************")
        project, build_version = (None, None)
        org_excel_name = "Result_{}_{}_IndependentAEE_{}_{}_org.xls"
        final_excel_name = "Result_{}_{}_IndependentAEE_{}_{}.xls"
        org_excel_path, final_excel_path = (None, None)
        if aee_rlt_list_org:
            aee_rlt_list_org_length = len(aee_rlt_list_org)
            aee_rlt_index = 0
            while not aee_rlt_index < aee_rlt_list_org_length or build_version is None or build_version == "":
                build_version = aee_rlt_list_org[aee_rlt_index][1]
                aee_rlt_index += 1

            TEST_LOGGER.info("扫描结果记录中测试版本为：{}".format(build_version))
            project = build_version.split("-")[0] if build_version else None
            org_excel_name = org_excel_name.format(self._jira_repo, self._reporter, self._scan_place, self._report_date_formatted)
            org_excel_path = self._scan_root_dir + os.sep + org_excel_name
            TEST_LOGGER.info("去重前excel文件：{}".format(org_excel_path))
            excel = Excel(org_excel_path)
            try:
                excel.insertResultAee(aee_rlt_list_org)
            except:
                TEST_LOGGER.warn(traceback.format_exc())

        else:
            TEST_LOGGER.warn("去重前aee数据为0")
        if aee_rlt_list_final:
            statistics_list = [
             project, build_version] + self.get_statistics(aee_rlt_list_final)
            final_excel_name = final_excel_name.format(self._jira_repo, self._reporter, self._scan_place, self._report_date_formatted)
            final_excel_path = self._scan_root_dir + os.sep + final_excel_name
            TEST_LOGGER.info("去重后Excel文件：{}".format(final_excel_path))
            excel = Excel(final_excel_path)
            try:
                excel.insertResultAee(aee_rlt_list_final, deduplicated=True)
            except:
                TEST_LOGGER.warn(traceback.format_exc())

            if self._submit_jira:
                TEST_LOGGER.info("submit_jira：True，执行Jira提交，提交Url：{}".format(self._submit_jira_url))
                if self._task_tag == "3rd_app":
                    ignore_components = ""
                else:
                    ignore_components = None
                send_jira_request((self._submit_jira_url), final_excel_path, ignore_components=ignore_components, jira_project_name=(self._jira_repo))
            else:
                TEST_LOGGER.info("submit_jira：False，不执行Jira提交")
        else:
            TEST_LOGGER.warn("去重后aee数据为0")
            statistics_list = [project, build_version, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 
             0, 0, 0, 0, 0, 0, '']
        statistics_file_path = self._scan_root_dir + os.sep + "statistics.txt"
        with open(statistics_file_path, "w", encoding="utf-8") as f:
            f.write(str(statistics_list))
        if self._result_dir:
            result_dir_by_date = self._result_dir + os.sep + self._report_date_formatted
            if not os.path.isdir(result_dir_by_date):
                try:
                    os.makedirs(result_dir_by_date)
                except:
                    TEST_LOGGER.warn(traceback.format_exc())

            TEST_LOGGER.info(os.path.abspath(result_dir_by_date))
            if result_dir_by_date and os.path.isdir(result_dir_by_date):
                if org_excel_path:
                    if os.path.isfile(org_excel_path):
                        try:
                            shutil.move(org_excel_path, result_dir_by_date)
                            TEST_LOGGER.info("文件：{} 已移动至：{}".format(org_excel_path, result_dir_by_date))
                        except shutil.Error:
                            excel_basename = os.path.basename(org_excel_path)
                            target_path = os.path.join(result_dir_by_date, excel_basename)
                            os.remove(target_path)
                            try:
                                shutil.move(org_excel_path, result_dir_by_date)
                                TEST_LOGGER.info("文件：{} 已移动至：{}".format(org_excel_path, result_dir_by_date))
                            except:
                                TEST_LOGGER.error("Move org exception again: {}".format(traceback.format_exc()))

                        except:
                            TEST_LOGGER.error("Move org exception: {}".format(traceback.format_exc()))

                if final_excel_path and os.path.isfile(final_excel_path):
                    try:
                        shutil.move(final_excel_path, result_dir_by_date)
                        TEST_LOGGER.info("文件：{} 已移动至：{}".format(final_excel_path, result_dir_by_date))
                    except shutil.Error:
                        excel_basename = os.path.basename(final_excel_path)
                        target_path = os.path.join(result_dir_by_date, excel_basename)
                        os.remove(target_path)
                        try:
                            shutil.move(final_excel_path, result_dir_by_date)
                            TEST_LOGGER.info("文件：{} 已移动至：{}".format(final_excel_path, result_dir_by_date))
                        except:
                            TEST_LOGGER.error("Move org exception again: {}".format(traceback.format_exc()))

                    except:
                        TEST_LOGGER.error("Move final exception: {}".format(traceback.format_exc()))

        TEST_LOGGER.info("******************** 生成aee结果文件完成 ********************\n")

    def __get_dbg_list(self):
        """
        扫描目录下符合条件的aee和tne文件列表
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描dbg与tne文件 ********************")
        mtklog_tag = self._scan_date_formatted_aee
        dbg_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                file_lower = file.lower()
                file_path = os.path.join(root, file)
                if file_lower.endswith(".dbg") and mtklog_tag in file_path:
                    TEST_LOGGER.info("发现dbg文件：{}".format(file_path))
                    dbg_file_list.append(file_path)

        TEST_LOGGER.info("******************** 扫描dbg与tne文件已完成 ********************\n")
        return dbg_file_list

    def __getAnalyseList(self):
        """
        获取 __exp_main.txt 文件列表
        :return:
        """
        TEST_LOGGER.info("******************** 开始扫描__exp_main.txt文件与tne目录 ********************")
        exp_main_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                db_file_path = os.path.join(root, file)
                if file == "__exp_main.txt" and self._scan_date_formatted_aee in db_file_path:
                    exp_main_file_list.append(db_file_path)
                    TEST_LOGGER.info("获取 __exp_main.txt 文件：{}".format(db_file_path))

        if exp_main_file_list:
            TEST_LOGGER.info("获取需要分析的__exp_main.txt文件列表：")
            [TEST_LOGGER.info("__exp_main.txt 文件：{}".format(exp_main_file)) for exp_main_file in exp_main_file_list]
        else:
            TEST_LOGGER.warn("__exp_main.txt 列表为空")
        TEST_LOGGER.info("******************** 扫描__exp_main.txt文件与tne目录已完成 ********************\n")
        return exp_main_file_list

# okay decompiling extracted_pyz_modules/modules/mode\ScanAeeIndependent.pyc
