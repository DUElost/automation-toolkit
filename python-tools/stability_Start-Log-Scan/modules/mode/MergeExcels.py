# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\mode\MergeExcels.py
import re, os, datetime, traceback
from modules.common.GlobalAttrs import *
from modules.common.Excel import read_aee_rlt_excel, Excel
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.mode.BaseScan import ScanBase

class MergeExcels(ScanBase):

    def __init__(self, merge_excel_dir_list, merge_side, merge_key, scan_mode, merge_factory=False, priority=False):
        super(MergeExcels, self).__init__(scan_mode, merge_side, -1, None, None, False, False)
        self._MergeExcels__merge_excel_dir_list = merge_excel_dir_list
        self._MergeExcels__merge_side = merge_side
        self._MergeExcels__merge_key = merge_key
        self._MergeExcels__target_build = None
        self._MergeExcels__merge_factory = merge_factory
        self._MergeExcels__priority = priority

    def _get_scan_dir_failed(self, error_msg):
        return

    def _init_scan_attrs(self):
        return

    def _scan(self):
        return

    def start_merge(self):
        if self._MergeExcels__merge_factory:
            merge_factory = self._MergeExcels__merge_excel_dir_list[0]
            merge_excel_dir_list = []
            regex_merge_factory = re.compile("(\\d{3})-(\\d{3})-(\\d{8})-(\\d{8})")
            regex_rlt = re.match(regex_merge_factory, merge_factory)
            if regex_rlt:
                date_list = []
                try:
                    scan_date_start = datetime.datetime.strptime(regex_rlt.group(3), "%Y%m%d")
                    scan_date_end = datetime.datetime.strptime(regex_rlt.group(4), "%Y%m%d")
                    while scan_date_start <= scan_date_end:
                        date_str = scan_date_start.strftime("%Y%m%d")
                        date_list.append(date_str)
                        scan_date_start += datetime.timedelta(days=1)

                except:
                    TEST_LOGGER.error("merge_factory，解析传入日期参数：{} 时发生异常：\n{}".format(merge_factory, traceback.format_exc()))
                    return
                else:
                    if not date_list:
                        TEST_LOGGER.error("merge_factory，传入参数解析的日期列表为空，请检查传入参数：{}".format(merge_factory))
                        return
                    server_index_start = int(regex_rlt.group(1))
                    server_index_end = int(regex_rlt.group(2))
                    for server_index in range(server_index_start, server_index_end + 1):
                        if 1 <= server_index <= 15:
                            nas_address = "10.243.155.11"
                        else:
                            if 16 <= server_index <= 30:
                                nas_address = "10.243.155.12"
                            else:
                                if 31 <= server_index <= 45:
                                    nas_address = "10.243.155.10"
                                else:
                                    TEST_LOGGER.info("传入的Nas服务器序列号：{} 超出范围！")
                                    continue
                        server_index_str = str(server_index).zfill(3)
                        for scan_date_str in date_list:
                            merge_excel_dir = "\\\\{}\\nas\\Result\\{}\\autotest-{}".format(nas_address, scan_date_str, server_index_str)
                            merge_excel_dir_list.append(merge_excel_dir)

            else:
                TEST_LOGGER.info("merge_factory，传入参数格式异常：{}，请检查后重试".format(self._MergeExcels__merge_excel_dir_list))
                return
            self._MergeExcels__merge_excel_dir_list = merge_excel_dir_list
        if not self._MergeExcels__merge_key:
            self._MergeExcels__merge_key = ""
        total_aee_rlt_list = []
        aee_path_list = []
        for merge_excel_dir in self._MergeExcels__merge_excel_dir_list:
            if os.path.isdir(merge_excel_dir):
                TEST_LOGGER.info("开始合并目录：{}中的excel文件".format(merge_excel_dir))
            else:
                TEST_LOGGER.warn("合并目录：{}不存在，继续下个目录".format(merge_excel_dir))
                continue
            for root, dirs, files in os.walk(merge_excel_dir):
                for file in files:
                    file_lower = file.lower()
                    if file_lower.endswith(".xls"):
                        if "org" in file_lower or "endall" in file_lower:
                            pass
                        if self._MergeExcels__merge_key in file:
                            xls_file_path = os.path.join(root, file)
                            aee_rlt_list = read_aee_rlt_excel(xls_file_path)
                            TEST_LOGGER.info("文件：{} 中读取记录：{}条".format(xls_file_path, len(aee_rlt_list)))
                            for aee_rlt in aee_rlt_list:
                                aee_path = aee_rlt.get_aee_attrs()[0]
                                if aee_path in aee_path_list:
                                    continue
                                else:
                                    total_aee_rlt_list.append(aee_rlt)
                                    aee_path_list.append(aee_path)

        TEST_LOGGER.info("累计读取原始记录共：{}条".format(len(total_aee_rlt_list)))
        if self._MergeExcels__merge_side == "shanghai":
            self._pkglist_file = "pkglist.txt"
            self._scan_type = "shanghai"
        else:
            if self._MergeExcels__merge_side == "factory":
                self._pkglist_file = "pkglist_factory.txt"
                self._scan_type = "factory"
            else:
                pkglist_file_path = PathManager.config_folder + os.sep + self._pkglist_file
                self._pkglist = self._get_pkglist(self._scan_type, pkglist_file_path)
                total_aee_rlt_list_org, total_aee_rlt_list_final, to_be_deleted_file_list = self._aee_to_data_list(total_aee_rlt_list)
                if not self._MergeExcels__target_build:
                    if total_aee_rlt_list_org:
                        build_version = total_aee_rlt_list_org[0][1]
                        TEST_LOGGER.info("扫描结果记录中测试版本为：{}".format(build_version))
                        self._MergeExcels__target_build = build_version
                statistics_project_name = self._MergeExcels__target_build.split("-")[0] if self._MergeExcels__target_build else None
                org_excel_name = "Result_MonkeyAEE_Merge_org.xls"
                final_excel_name = "Result_MonkeyAEE_Merge.xls"
                merge_result_dir = PathManager.merge_rlt_folder + os.sep + datetime.datetime.now().strftime("%Y_%m_%d_%H_%M_%S")
                if not os.path.isdir(merge_result_dir):
                    try:
                        os.makedirs(merge_result_dir)
                    except:
                        pass

                if total_aee_rlt_list_org:
                    org_excel_path = merge_result_dir + os.sep + org_excel_name
                    TEST_LOGGER.info("累计去重前excel文件：{}".format(org_excel_path))
                    excel = Excel(org_excel_path)
                    try:
                        excel.insertResultAee(total_aee_rlt_list_org)
                    except:
                        TEST_LOGGER.warn(traceback.format_exc())

                    if total_aee_rlt_list_final:
                        statistics_list = [
                         statistics_project_name, self._MergeExcels__target_build] + self.get_statistics(total_aee_rlt_list_final)
                        final_excel_path = merge_result_dir + os.sep + final_excel_name
                        TEST_LOGGER.info("累计去重后Excel文件：{}".format(final_excel_path))
                        excel = Excel(final_excel_path)
                        try:
                            excel.insertResultAee(total_aee_rlt_list_final, priority=(self._MergeExcels__priority), deduplicated=True)
                        except:
                            TEST_LOGGER.warn(traceback.format_exc())

                else:
                    statistics_list = [
                     statistics_project_name, self._MergeExcels__target_build] + [0] * 17 + [""]
                    TEST_LOGGER.warn("去重后数据为0")
            statistics_file_path = merge_result_dir + os.sep + "statistics.txt"
            with open(statistics_file_path, "w", encoding="utf-8") as f:
                f.write(str(statistics_list))
            TEST_LOGGER.info("******************** 生成累计结果完成 ********************\n")

# okay decompiling extracted_pyz_modules/modules/mode\MergeExcels.pyc
