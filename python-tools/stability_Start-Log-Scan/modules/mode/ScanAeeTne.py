# -*- coding: utf-8 -*-
"""
ScanAeeTne - AEE/TNE 日志扫描模块
基于 BaseScan 实现的完整扫描功能
"""
import datetime
import json
import os
import time
import traceback
from modules.common.Logger import TEST_LOGGER
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
        self._extract_failed_dbg_set = set()
        self._zero_size_dbg_set = set()

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
            extract_failed_dbg_list = []
            db_file_map_exception_zip_count = 0
            db_file_map_discard_count = 0
            dbg_count = 0
            dbg_to_extract_count = 0
            pre_analysed_dbg_count = 0
            preanalyse_discard_count = 0
            exp_main_file_count = 0
            fallback_aee_result_count = 0
            aee_result_count_before_filter = 0
            self._extract_failed_dbg_set = set()
            self._zero_size_dbg_set = set()
            self._reset_extract_failed_dbg_tracking()
            physical_dbg_file_list = self.__get_physical_dbg_file_list()
            dbg_count = len(physical_dbg_file_list)
            self._zero_size_dbg_set = self.__get_zero_size_dbg_set(physical_dbg_file_list)

            # 解压和预处理
            if not self._skip_extract:
                if not self._skip_unzip:
                    # 分析 DBFileMap
                    stop_scan, exception_zip_list, discard_dbg_info_list = self._analyse_db_file_map()
                    db_file_map_exception_zip_count = len(exception_zip_list) if exception_zip_list else 0
                    db_file_map_discard_count = len(discard_dbg_info_list) if discard_dbg_info_list else 0
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
                    dbg_file_list = self.__get_dbg_list(physical_dbg_file_list)
                    dbg_to_extract_count = len(dbg_file_list) if dbg_file_list else 0
                    if dbg_file_list:
                        # 预分析 dbg 文件
                        stop_scan, zz_list_to_be_analysed, discard_dbg_info_list = self._pre_analyse_dbg(dbg_file_list)
                        pre_analysed_dbg_count = len(zz_list_to_be_analysed) if zz_list_to_be_analysed else 0
                        preanalyse_discard_count = len(discard_dbg_info_list) if discard_dbg_info_list else 0
                        if stop_scan:
                            TEST_LOGGER.warn("预过滤后，dbg文件过多，停止后续步骤")
                            unexpected_dbg_count = True
                        else:
                            dbg_file_list = [zz.dbg_path for zz in zz_list_to_be_analysed]
                            if dbg_file_list:
                                extract_failed_dbg_list = self._extract_dbg(dbg_file_list)
                                self._extract_failed_dbg_set = set(extract_failed_dbg_list)
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
                exp_main_file_count = len(exp_main_file_list) if exp_main_file_list else 0
                if exp_main_file_list:
                    TEST_LOGGER.info(f"找到 {len(exp_main_file_list)} 个 exp_main 文件")
                    aee_result_list = self._analyse_aee(exp_main_file_list, self._to_recognize_except, self._extra_jira_tag)
                else:
                    TEST_LOGGER.info("未找到 exp_main 文件")
                    aee_result_list = []
                fallback_aee_result_list = self._build_extract_failed_aee_result_list(extract_failed_dbg_list)
                fallback_aee_result_count = len(fallback_aee_result_list)
                if fallback_aee_result_list:
                    TEST_LOGGER.warn(f"解压失败的严重问题回填结果数：{len(fallback_aee_result_list)}")
                    aee_result_list.extend(fallback_aee_result_list)
                aee_result_count_before_filter = len(aee_result_list)

            # 处理结果
            aee_rlt_list_org, aee_rlt_list_final, to_be_deleted = self._aee_to_data_list(
                aee_result_list, True, self._special_build_prefix)

            if discard_dbg_info_list:
                aee_rlt_list_org = self._save_discard_to_org(aee_rlt_list_org, discard_dbg_info_list)

            # 生成结果
            scan_summary = self.__build_scan_summary(
                unexpected_dbg_count, db_file_map_exception_zip_count, db_file_map_discard_count,
                dbg_count, dbg_to_extract_count, pre_analysed_dbg_count, preanalyse_discard_count,
                exp_main_file_count, extract_failed_dbg_list, fallback_aee_result_count,
                aee_result_count_before_filter, aee_rlt_list_org, aee_rlt_list_final)
            self.__generate_result(aee_rlt_list_org, aee_rlt_list_final, scan_summary)

            TEST_LOGGER.info("AEE/TNE 扫描完成")
            TEST_LOGGER.info(f"原始结果数: {len(aee_rlt_list_org)}")
            TEST_LOGGER.info(f"去重后结果数: {len(aee_rlt_list_final)}")

        except Exception as e:
            TEST_LOGGER.error(f"扫描过程发生异常: {traceback.format_exc()}")

    @staticmethod
    def __is_dbg_file(file_name):
        return file_name.endswith(".dbg") or (file_name.startswith("db.") and "_analyze_report" not in file_name and not file_name.endswith(".txt"))

    def __get_physical_dbg_file_list(self):
        physical_dbg_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            if ".DEC" in root:
                continue
            for file in files:
                if self.__is_dbg_file(file):
                    file_path = os.path.join(root, file)
                    if not self._scan_date_formatted_aee or self._scan_date_formatted_aee in file_path:
                        physical_dbg_file_list.append(file_path)
        return physical_dbg_file_list

    @staticmethod
    def __is_zero_size_dbg_file(file_path):
        if not os.path.isfile(file_path):
            return False
        try:
            return os.path.getsize(file_path) == 0
        except OSError:
            return False

    def __get_zero_size_dbg_set(self, physical_dbg_file_list):
        zero_size_dbg_set = set()
        for file_path in physical_dbg_file_list:
            if self.__is_zero_size_dbg_file(file_path):
                zero_size_dbg_set.add(file_path)
        if zero_size_dbg_set:
            TEST_LOGGER.warn(f"扫描阶段识别到 0 字节 dbg 文件共：{len(zero_size_dbg_set)} 个，这些文件不会进入 Excel 报告")
            for file_path in sorted(zero_size_dbg_set):
                TEST_LOGGER.warn(f"dbg 文件大小为 0，判定为无效源日志，不进入报告：{file_path}")
        return zero_size_dbg_set

    def __get_dbg_list(self, physical_dbg_file_list=None):
        """获取需要重新解析的 dbg 文件列表"""
        TEST_LOGGER.info("******************** 开始扫描dbg文件 ********************")
        dbg_file_list = []
        if physical_dbg_file_list is None:
            physical_dbg_file_list = self.__get_physical_dbg_file_list()
        TEST_LOGGER.info(f"目录中物理存在的 dbg 文件共：{len(physical_dbg_file_list)} 个")

        for file_path in physical_dbg_file_list:
            if file_path in self._zero_size_dbg_set:
                TEST_LOGGER.debug(f"跳过 0 字节 dbg 文件：{file_path}")
                continue
            # 检查对应的 .DEC 目录是否存在且完整
            dec_dir = file_path + ".DEC"
            if os.path.isdir(dec_dir):
                missing = self._get_dbg_dec_missing_critical_files(file_path)
                if not missing:
                    TEST_LOGGER.debug(f"dbg 文件已解析且完整，跳过：{file_path}")
                    continue
                else:
                    TEST_LOGGER.info(f"dbg 文件的 .DEC 目录缺少关键文件 {missing}，需要重新解析：{file_path}")

            dbg_file_list.append(file_path)
            TEST_LOGGER.debug(f"获取 dbg 文件：{file_path}")

        TEST_LOGGER.info(f"获取需要重新解析的 dbg 文件共：{len(dbg_file_list)} 个")
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
                        dbg_file_path = self._get_dbg_file_from_dec_related_path(file_path)
                        if dbg_file_path and dbg_file_path in self._zero_size_dbg_set:
                            TEST_LOGGER.warn(f"__exp_main.txt 对应的 dbg 文件大小为 0，跳过正常解析且不写入报告：{file_path}")
                            continue
                        if dbg_file_path and dbg_file_path in self._extract_failed_dbg_set:
                            missing = self._get_dbg_dec_missing_critical_files(dbg_file_path)
                            if missing:
                                TEST_LOGGER.warn(f"__exp_main.txt 所在 .DEC 目录仍缺少关键文件 {missing}，跳过正常解析并转入失败兜底链：{file_path}")
                                continue
                        exp_main_file_list.append(file_path)
                        TEST_LOGGER.debug(f"获取 __exp_main.txt 文件：{file_path}")

        TEST_LOGGER.info(f"获取需要分析的 __exp_main.txt 文件共：{len(exp_main_file_list)} 个")
        return exp_main_file_list

    def __generate_result(self, aee_rlt_list_org, aee_rlt_list_final, summary_data=None):
        """生成扫描结果"""
        TEST_LOGGER.info("******************** 开始生成扫描结果 ********************")

        try:
            from modules.common.Excel import Excel
            # 从结果中获取版本信息
            build_version = self._build_version
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
            generated_files = {}
            if not aee_rlt_list_org and not aee_rlt_list_final:
                TEST_LOGGER.info("扫描结果为空，不生成Excel文件，仅生成扫描摘要")
            
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
                generated_files["org_excel"] = org_excel_path

            # 生成去重后结果 Excel
            if aee_rlt_list_final:
                final_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}.xls"
                final_excel_path = os.path.join(result_dir, final_excel_name)
                try:
                    excel_final = Excel(final_excel_path)
                    excel_final.insertResultAee(aee_rlt_list_final, deduplicated=True)
                    TEST_LOGGER.info(f"去重后结果Excel已生成：{final_excel_path}")
                except PermissionError:
                    # 如果文件被锁定，添加额外的时间戳
                    extra_timestamp = time.strftime("%H%M%S")
                    final_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}_{extra_timestamp}.xls"
                    final_excel_path = os.path.join(result_dir, final_excel_name)
                    excel_final = Excel(final_excel_path)
                    excel_final.insertResultAee(aee_rlt_list_final, deduplicated=True)
                    TEST_LOGGER.info(f"去重后结果Excel已生成（使用额外时间戳）：{final_excel_path}")
                generated_files["final_excel"] = final_excel_path

            if summary_data is not None:
                summary_json_name = f"Result_{jira_repo}_{reporter}_MonkeyAEE_{self._scan_place}_{date_time_str}_summary.json"
                summary_json_path = os.path.join(result_dir, summary_json_name)
                legacy_summary_json_path = os.path.join(result_dir, "summary.json")
                summary_data["generated_files"] = generated_files
                summary_data["generated_files"]["summary_json"] = summary_json_path
                summary_data["build_version"] = build_version if build_version else "VersionNone"
                with open(summary_json_path, "w", encoding="utf-8") as f:
                    json.dump(summary_data, f, ensure_ascii=False, indent=2)
                if os.path.isfile(legacy_summary_json_path):
                    try:
                        os.remove(legacy_summary_json_path)
                        TEST_LOGGER.info(f"已删除旧版固定文件名扫描摘要：{legacy_summary_json_path}")
                    except Exception:
                        TEST_LOGGER.warn(f"删除旧版固定文件名扫描摘要失败：{legacy_summary_json_path}")
                TEST_LOGGER.info(f"扫描摘要 JSON 已生成：{summary_json_path}")

        except Exception as e:
            TEST_LOGGER.error(f"生成结果时发生异常：{traceback.format_exc()}")

        TEST_LOGGER.info("******************** 扫描结果生成完成 ********************")

    def __get_extract_failed_dbg_reason_count_dict(self):
        reason_count_dict = {}
        for reason_info_list in self._extract_failed_dbg_reason_map.values():
            reason_code_set = set()
            for reason_info in reason_info_list:
                reason_code = reason_info.get("code")
                if reason_code:
                    reason_code_set.add(reason_code)
            for reason_code in reason_code_set:
                reason_count_dict[reason_code] = reason_count_dict.get(reason_code, 0) + 1
        return dict(sorted(reason_count_dict.items(), key=lambda item: item[0]))

    def __build_extract_failed_dbg_summary_list(self, aee_rlt_list_org, aee_rlt_list_final):
        org_path_set = {str(aee_rlt[0]) for aee_rlt in aee_rlt_list_org}
        final_path_set = {str(aee_rlt[0]) for aee_rlt in aee_rlt_list_final}
        dbg_file_set = set(self._extract_failed_dbg_reason_map.keys()) | set(self._extract_failed_dbg_report_status_map.keys())
        summary_list = []
        for dbg_file in sorted(dbg_file_set):
            reason_info_list = self._get_extract_failed_dbg_reason_info_list(dbg_file)
            reason_code_list = [reason_info.get("code") for reason_info in reason_info_list if reason_info.get("code")]
            report_status = dict(self._extract_failed_dbg_report_status_map.get(dbg_file, {}))
            converted_dbg_file = self._convert_path_to_win(dbg_file)
            summary_entry = {
                "dbg_file": dbg_file,
                "dbg_file_win": converted_dbg_file,
                "reason_codes": reason_code_list,
                "reason_details": reason_info_list,
                "current_missing_critical_files": self._get_dbg_dec_missing_critical_files(dbg_file),
                "written_to_report": bool(report_status.get("written_to_report", False)),
                "skip_reason": report_status.get("skip_reason"),
                "extra_tag": report_status.get("extra_tag", self._build_extract_failed_dbg_extra_tag(dbg_file)),
                "org_reported": converted_dbg_file in org_path_set,
                "final_reported": converted_dbg_file in final_path_set
            }
            summary_list.append(summary_entry)
        return summary_list

    @staticmethod
    def __build_scan_summary_field_comments():
        return {
            "_comment": "JSON 不支持原生注释，这里通过 field_comments 字段提供各参数说明",
            "tool": "工具名称",
            "scan_mode": "扫描模式原始值",
            "scan_mode_name": "扫描模式名称，便于直接阅读",
            "scan_place": "扫描地点/站点标识",
            "scan_root_dir": "本次扫描的根目录",
            "scan_date": "实际筛选日志使用的日期；ALL 代表不按日期过滤",
            "report_date": "报告日期，格式为 YYYYMMDD",
            "generated_at": "summary 生成时间，格式为 YYYY-MM-DD HH:MM:SS",
            "skip_extract": "是否跳过 dbg 解压阶段",
            "skip_unzip": "是否跳过 zip 解压阶段",
            "unexpected_dbg_count": "是否因问题数量过多而触发提前停止",
            "build_version": "本次报告识别到的版本号；若无法识别则为 VersionNone",
            "generated_files": {
                "org_excel": "原始结果 Excel 路径",
                "final_excel": "去重后结果 Excel 路径",
                "summary_json": "本次扫描生成的摘要 JSON 路径"
            },
            "counts": {
                "db_file_map_exception_zip_count": "DBFileMap 阶段识别出的异常 zip 数量",
                "db_file_map_discard_count": "DBFileMap 阶段按规则丢弃的问题数量",
                "dbg_count": "扫描目录中物理存在的 dbg 文件总数",
                "zero_size_dbg_count": "扫描阶段识别出的 0 字节 dbg 文件数量；这些文件不会进入 Excel 报告",
                "dbg_to_extract_count": "本次需要重新解析/解压的 dbg 文件数",
                "pre_analysed_dbg_count": "dbg 预分析后保留下来的待解析数量",
                "preanalyse_discard_count": "dbg 预分析阶段被丢弃的问题数量",
                "exp_main_file_count": "最终参与正常 AEE 解析的 __exp_main.txt 文件数量",
                "extract_failed_dbg_count": "进入失败跟踪链路的 dbg 文件去重后数量",
                "fallback_aee_result_count": "因解析失败而使用兜底逻辑写入报告的结果数量",
                "aee_result_count_before_filter": "进入最终过滤前的 AEE 结果总数，含正常解析和兜底结果",
                "aee_result_org_count": "原始报告中的结果数量",
                "aee_result_final_count": "去重后最终报告中的结果数量"
            },
            "failure_reason_counts": "按失败原因码聚合的 dbg 数量统计；同一个 dbg 命中多个原因码时会分别计数",
            "invalid_dbg": {
                "zero_size_dbg_files": "扫描阶段识别出的 0 字节 dbg 文件路径列表；这些文件只记录在摘要中，不进入 Excel 报告"
            },
            "extract_failed_dbg": {
                "_item_comment": "列表中每一项代表一个进入失败跟踪链路的 dbg 文件",
                "dbg_file": "原始 dbg 文件路径，保持扫描环境中的原路径格式",
                "dbg_file_win": "转换为 Windows 形式后的 dbg 文件路径，便于本机定位",
                "reason_codes": "该 dbg 命中的失败原因码列表",
                "reason_details": "失败原因详情列表，每项包含 code 和 detail",
                "current_missing_critical_files": "当前 .DEC 目录仍缺失的关键文件列表",
                "written_to_report": "该 dbg 是否已经通过兜底逻辑写入报告",
                "skip_reason": "未写入报告时的跳过原因；写入时通常为 null",
                "extra_tag": "写入 Excel 时附带的额外标记，包含 failure_reason 信息",
                "org_reported": "是否出现在原始报告中",
                "final_reported": "是否出现在去重后的最终报告中"
            }
        }

    def __build_scan_summary(self, unexpected_dbg_count, db_file_map_exception_zip_count, db_file_map_discard_count,
                             dbg_count, dbg_to_extract_count, pre_analysed_dbg_count, preanalyse_discard_count,
                             exp_main_file_count, extract_failed_dbg_list, fallback_aee_result_count,
                             aee_result_count_before_filter, aee_rlt_list_org, aee_rlt_list_final):
        extract_failed_dbg_summary_list = self.__build_extract_failed_dbg_summary_list(aee_rlt_list_org, aee_rlt_list_final)
        return {
            "field_comments": self.__build_scan_summary_field_comments(),
            "tool": "stability_Start-Log-Scan",
            "scan_mode": self._scan_mode,
            "scan_mode_name": SCAN_MODE_DICT.get(self._scan_mode, "未知"),
            "scan_place": self._scan_place,
            "scan_root_dir": self._scan_root_dir,
            "scan_date": self._scan_date_formatted_aee if self._scan_date_formatted_aee else "ALL",
            "report_date": self._report_date_formatted,
            "generated_at": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "skip_extract": self._skip_extract,
            "skip_unzip": self._skip_unzip,
            "unexpected_dbg_count": unexpected_dbg_count,
            "counts": {
                "db_file_map_exception_zip_count": db_file_map_exception_zip_count,
                "db_file_map_discard_count": db_file_map_discard_count,
                "dbg_count": dbg_count,
                "zero_size_dbg_count": len(self._zero_size_dbg_set),
                "dbg_to_extract_count": dbg_to_extract_count,
                "pre_analysed_dbg_count": pre_analysed_dbg_count,
                "preanalyse_discard_count": preanalyse_discard_count,
                "exp_main_file_count": exp_main_file_count,
                "extract_failed_dbg_count": len(set(extract_failed_dbg_list)),
                "fallback_aee_result_count": fallback_aee_result_count,
                "aee_result_count_before_filter": aee_result_count_before_filter,
                "aee_result_org_count": len(aee_rlt_list_org),
                "aee_result_final_count": len(aee_rlt_list_final)
            },
            "invalid_dbg": {
                "zero_size_dbg_files": sorted(self._zero_size_dbg_set)
            },
            "failure_reason_counts": self.__get_extract_failed_dbg_reason_count_dict(),
            "extract_failed_dbg": extract_failed_dbg_summary_list
        }
