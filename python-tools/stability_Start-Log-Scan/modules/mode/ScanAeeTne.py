# -*- coding: utf-8 -*-
"""
ScanAeeTne - AEE/TNE 日志扫描模块
基于 BaseScan 实现的完整扫描功能
"""
import os
import traceback
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.common.GlobalAttrs import *
from modules.mode.BaseScan import ScanBase


class ScanAeeTne(ScanBase):
    """AEE/TNE 日志扫描类"""

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir,
                 skip_extract, skip_unzip, nas_address=None, task_tag=None,
                 special_build_prefix=None, delete_logs=False):
        TEST_LOGGER.info("初始化 ScanAeeTne，传入的参数列表：")
        TEST_LOGGER.info("scan_mode：{}".format(scan_mode))
        TEST_LOGGER.info("scan_place：{}".format(scan_place))
        TEST_LOGGER.info("days_before：{}".format(days_before))
        TEST_LOGGER.info("scan_root_dir：{}".format(scan_root_dir))
        TEST_LOGGER.info("cur_tool_dir：{}".format(cur_tool_dir))
        TEST_LOGGER.info("skip_extract：{}".format(skip_extract))
        TEST_LOGGER.info("skip_unzip：{}".format(skip_unzip))
        TEST_LOGGER.info("nas_address：{}".format(nas_address))
        TEST_LOGGER.info("task_tag：{}".format(task_tag))
        TEST_LOGGER.info("special_build_prefix：{}".format(special_build_prefix))
        TEST_LOGGER.info("delete_logs：{}".format(delete_logs))
        super(ScanAeeTne, self).__init__(scan_mode, scan_place, days_before,
                                          scan_root_dir, cur_tool_dir, skip_extract,
                                          skip_unzip, task_tag, delete_logs)
        self._nas_address = nas_address
        self._special_build_prefix = special_build_prefix

    def _get_scan_dir_failed(self, error_msg):
        """扫描目录获取失败处理"""
        TEST_LOGGER.error(f"扫描目录获取失败: {error_msg}")

    def _init_scan_attrs(self):
        """初始化扫描属性"""
        TEST_LOGGER.info("初始化 ScanAeeTne 扫描属性")
        TEST_LOGGER.info("扫描模式：{}".format(SCAN_MODE_DICT.get(self._scan_mode, "未知")))

    def _scan(self):
        """执行扫描"""
        TEST_LOGGER.resetTag(__name__)
        TEST_LOGGER.info("开始执行 AEE/TNE 扫描")
        TEST_LOGGER.info("扫描目录: {}".format(self._scan_root_dir))
        TEST_LOGGER.info("相似度系数: {}".format(self._ratio_std_aee))
        TEST_LOGGER.info("扫描日期: {}".format(self._scan_date_formatted_aee if self._scan_date_formatted_aee else "所有日期"))

        if not self._scan_root_dir or not os.path.isdir(self._scan_root_dir):
            TEST_LOGGER.error(f"扫描目录不存在: {self._scan_root_dir}")
            return

        try:
            unexpected_dbg_count = False
            discard_dbg_info_list = None

            # 解压和预处理
            if not self._skip_extract:
                if not self._skip_unzip:
                    # 分析 DBFileMap
                    stop_scan, exception_zip_list, discard_dbg_info_list = self._analyse_db_file_map()
                    if stop_scan:
                        TEST_LOGGER.warn("DBFileMap 解析结果，问题数超过最大数，不再执行后续扫描")
                        unexpected_dbg_count = True
                    elif exception_zip_list:
                        self._unzip_aee_exceptions(exception_zip_list)
                    else:
                        self._unzip_aee_exceptions()
                else:
                    TEST_LOGGER.info("skip_unzip: True，跳过解压zip文件步骤")

                if not unexpected_dbg_count:
                    # 获取 dbg 文件列表
                    dbg_file_list = self.__get_dbg_list()
                    if dbg_file_list:
                        # 预分析 dbg 文件
                        stop_scan, zz_list_to_be_analysed, discard_dbg_info_list = self._pre_analyse_dbg(dbg_file_list)
                        if stop_scan:
                            TEST_LOGGER.warn("预过滤后，dbg文件过多，停止后续步骤")
                            unexpected_dbg_count = True
                        else:
                            dbg_file_list = [zz.dbg_path for zz in zz_list_to_be_analysed]
                            if dbg_file_list:
                                self._extract_dbg(dbg_file_list)
                            else:
                                TEST_LOGGER.info("预过滤后，dbg文件列表为空")
            else:
                TEST_LOGGER.info("skip_extract: True，跳过所有解压步骤")

            # 扫描 exp_main 文件
            if unexpected_dbg_count:
                TEST_LOGGER.warn("unexpected_dbg_count: True，直接设置 aee_result_list 为空")
                aee_result_list = []
            else:
                exp_main_file_list = self.__scan_exp_main_list()
                if exp_main_file_list:
                    TEST_LOGGER.info(f"找到 {len(exp_main_file_list)} 个 exp_main 文件")
                    aee_result_list = self._analyse_aee(exp_main_file_list, self._to_recognize_except, self._extra_jira_tag)
                else:
                    TEST_LOGGER.info("未找到 exp_main 文件")
                    aee_result_list = []

            # 处理结果
            aee_rlt_list_org, aee_rlt_list_final, to_be_deleted = self._aee_to_data_list(
                aee_result_list, True, self._special_build_prefix)

            # 注意：不添加 discard_dbg_info_list 到结果中，与原始 exe 行为一致
            # if discard_dbg_info_list:
            #     aee_rlt_list_org = self._save_discard_to_org(aee_rlt_list_org, discard_dbg_info_list)

            # 生成结果
            self.__generate_result(aee_rlt_list_org, aee_rlt_list_final)

            TEST_LOGGER.info("AEE/TNE 扫描完成")
            TEST_LOGGER.info(f"原始结果数: {len(aee_rlt_list_org)}")
            TEST_LOGGER.info(f"去重后结果数: {len(aee_rlt_list_final)}")

        except Exception as e:
            TEST_LOGGER.error(f"扫描过程发生异常: {traceback.format_exc()}")

    def __get_dbg_list(self):
        """获取 dbg 文件列表"""
        TEST_LOGGER.info("******************** 开始扫描dbg文件 ********************")
        dbg_file_list = []

        for root, dirs, files in os.walk(self._scan_root_dir):
            # 跳过 .DEC 目录中的文件，避免把解压后的文件当作 dbg 文件
            if ".DEC" in root:
                continue
            for file in files:
                # 只匹配真正的 dbg 文件：以 .dbg 结尾，或以 db. 开头且不包含 _analyze_report
                if file.endswith(".dbg") or (file.startswith("db.") and "_analyze_report" not in file and not file.endswith(".txt")):
                    file_path = os.path.join(root, file)
                    if not self._scan_date_formatted_aee or self._scan_date_formatted_aee in file_path:
                        # 检查对应的 .DEC 目录是否存在且完整
                        dec_dir = file_path + ".DEC"
                        if os.path.isdir(dec_dir):
                            # 三个关键文件必须全部存在才算完整
                            has_exp_main = os.path.isfile(os.path.join(dec_dir, "__exp_main.txt"))
                            has_zz_internal = os.path.isfile(os.path.join(dec_dir, "ZZ_INTERNAL"))
                            has_sys_properties = os.path.isfile(os.path.join(dec_dir, "SYS_PROPERTIES"))
                            
                            if has_exp_main and has_zz_internal and has_sys_properties:
                                TEST_LOGGER.debug(f"dbg 文件已解析且完整，跳过：{file_path}")
                                continue
                            else:
                                missing = []
                                if not has_exp_main:
                                    missing.append("__exp_main.txt")
                                if not has_zz_internal:
                                    missing.append("ZZ_INTERNAL")
                                if not has_sys_properties:
                                    missing.append("SYS_PROPERTIES")
                                TEST_LOGGER.info(f"dbg 文件的 .DEC 目录缺少关键文件 {missing}，需要重新解析：{file_path}")
                        
                        dbg_file_list.append(file_path)
                        TEST_LOGGER.debug(f"获取 dbg 文件：{file_path}")

        TEST_LOGGER.info(f"获取 dbg 文件共：{len(dbg_file_list)} 个")
        return dbg_file_list

    def __scan_exp_main_list(self):
        """扫描目录下所有的 __exp_main.txt 文件"""
        TEST_LOGGER.info("******************** 开始扫描__exp_main.txt文件 ********************")
        exp_main_file_list = []

        for root, dirs, files in os.walk(self._scan_root_dir):
            for file in files:
                file_path = os.path.join(root, file)
                if file == "__exp_main.txt":
                    if not self._scan_date_formatted_aee or self._scan_date_formatted_aee in file_path:
                        exp_main_file_list.append(file_path)
                        TEST_LOGGER.debug(f"获取 __exp_main.txt 文件：{file_path}")

        TEST_LOGGER.info(f"获取需要分析的 __exp_main.txt 文件共：{len(exp_main_file_list)} 个")
        return exp_main_file_list

    def __generate_result(self, aee_rlt_list_org, aee_rlt_list_final):
        """生成扫描结果"""
        TEST_LOGGER.info("******************** 开始生成扫描结果 ********************")

        if not aee_rlt_list_org and not aee_rlt_list_final:
            TEST_LOGGER.info("扫描结果为空，无需生成Excel文件")
            return

        try:
            from modules.common.Excel import Excel
            import time

            # 从结果中获取版本信息
            build_version = None
            if aee_rlt_list_org:
                for aee_rlt in aee_rlt_list_org:
                    if len(aee_rlt) > 1 and aee_rlt[1] and aee_rlt[1] not in ("discard_dbg_version", "discard_ota_ke_dbg_version", "discard_db_file_map_exception"):
                        build_version = aee_rlt[1]
                        break
            
            # 生成文件名，格式: Result_{jira_repo}_{reporter}_MonkeyAEE_{scan_place}_{date}_{time}.xls
            jira_repo = self._jira_repo if self._jira_repo else "None"
            reporter = self._reporter if self._reporter else "None"
            
            # 报告输出到 -d 参数指定的目录（即 _scan_root_dir）
            result_dir = self._scan_root_dir
            
            # 生成带时分秒的时间戳，避免覆盖之前的报告
            timestamp = time.strftime("%H%M%S")
            date_time_str = f"{self._report_date_formatted}_{timestamp}"
            
            # 生成原始结果 Excel
            if aee_rlt_list_org:
                org_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}_org.xls"
                org_excel_path = os.path.join(result_dir, org_excel_name)
                try:
                    excel_org = Excel(org_excel_path)
                    excel_org.insertResultAee(aee_rlt_list_org)
                    TEST_LOGGER.info(f"原始结果Excel已生成：{org_excel_path}")
                except PermissionError:
                    # 如果文件被锁定，添加额外的时间戳
                    extra_timestamp = time.strftime("%H%M%S")
                    org_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}_{extra_timestamp}_org.xls"
                    org_excel_path = os.path.join(result_dir, org_excel_name)
                    excel_org = Excel(org_excel_path)
                    excel_org.insertResultAee(aee_rlt_list_org)
                    TEST_LOGGER.info(f"原始结果Excel已生成（使用额外时间戳）：{org_excel_path}")

            # 生成去重后结果 Excel
            if aee_rlt_list_final:
                final_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}.xls"
                final_excel_path = os.path.join(result_dir, final_excel_name)
                try:
                    excel_final = Excel(final_excel_path)
                    excel_final.insertResultAee(aee_rlt_list_final)
                    TEST_LOGGER.info(f"去重后结果Excel已生成：{final_excel_path}")
                except PermissionError:
                    # 如果文件被锁定，添加额外的时间戳
                    extra_timestamp = time.strftime("%H%M%S")
                    final_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}_{extra_timestamp}.xls"
                    final_excel_path = os.path.join(result_dir, final_excel_name)
                    excel_final = Excel(final_excel_path)
                    excel_final.insertResultAee(aee_rlt_list_final)
                    TEST_LOGGER.info(f"去重后结果Excel已生成（使用额外时间戳）：{final_excel_path}")

        except Exception as e:
            TEST_LOGGER.error(f"生成结果时发生异常：{traceback.format_exc()}")

        TEST_LOGGER.info("******************** 扫描结果生成完成 ********************")
