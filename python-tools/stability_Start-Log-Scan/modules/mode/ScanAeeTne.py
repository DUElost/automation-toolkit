# -*- coding: utf-8 -*-
"""
ScanAeeTne - AEE/TNE 日志扫描模块
基于 BaseScan 实现的完整扫描功能
"""
import datetime
import json
import os
import re
import time
import traceback
from modules.common.Logger import TEST_LOGGER
from modules.common.GlobalAttrs import *
from modules.common.Utils import get_str_similar
from modules.mode.BaseScan import ScanBase
from modules.analyse.tne.types.tne_base import TneBase


class ScanAeeTne(ScanBase):
    """AEE/TNE 日志扫描类"""

    # 扫盘时跳过的重日志/无关目录（不包含 __exp_main / .dbg）
    _WALK_SKIP_DIR_NAMES = frozenset({
        "mobilelog", "debuglogger", "ap_log", "netlog", "gpslog", "btlog",
        "mblog", "net_log", "gps_log", "btm_log", "wifi_log", "audio_log",
        "__pycache__", ".git", ".svn", "node_modules",
    })
    _SCAN_PROGRESS_DIR_INTERVAL = 500
    _SCAN_PROGRESS_TIME_INTERVAL_SEC = 60
    _TNE_DIR_RE = re.compile(r"^0x[a-fA-F0-9]{8}_(?:\d{4}(?:_\d{1,2}){5,6}|\d{16})$")
    _TNE_VERSION_DATE_RE = re.compile(r"-(\d{6})V")
    _TNE_NO_FORMAT_EXP_TYPES = ("0xffffff0d_hwt", "0xffffff0c_hang_detect")
    _TNE_ABSOLUTE_EQUAL_EXP_TYPES = (
        "0x007a0044", "0xffffff2c", "0xffffff3c", "0xffffff32", "0x007a0050")

    def __init__(self, scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir,
                 skip_extract, skip_unzip, nas_address=None, task_tag=None,
                 special_build_prefix=None, delete_logs=False, limit_dbg_count=0):
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
        TEST_LOGGER.info("limit_dbg_count：{}".format(limit_dbg_count))
        super(ScanAeeTne, self).__init__(scan_mode, scan_place, days_before,
                                          scan_root_dir, cur_tool_dir, skip_extract,
                                          skip_unzip, task_tag, delete_logs,
                                          limit_dbg_count=limit_dbg_count)
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
        if self._scan_mode == SCAN_MODE_TNE:
            self._scan_tne_summary()
            return
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
                    use_bi_hash = self._scan_mode == SCAN_MODE_TRANSSION
                    aee_result_list = self._analyse_aee(
                        exp_main_file_list, self._to_recognize_except, self._extra_jira_tag, use_bi_hash=use_bi_hash)
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

    @classmethod
    def _prune_walk_dirs(cls, dirs, skip_dec_dirs=False):
        """就地剪枝 os.walk 的 dirs，跳过重日志目录；可选跳过 *.DEC。"""
        kept = []
        for name in dirs:
            lower = name.lower()
            if lower in cls._WALK_SKIP_DIR_NAMES or name.startswith("."):
                continue
            if skip_dec_dirs and name.upper().endswith(".DEC"):
                continue
            kept.append(name)
        dirs[:] = kept

    def __get_physical_dbg_file_list(self):
        physical_dbg_file_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            # dbg 本体不在 .DEC 内；直接不进入 .DEC / 重日志目录
            self._prune_walk_dirs(dirs, skip_dec_dirs=True)
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

    def __maybe_append_exp_main(self, file_path, exp_main_file_list):
        """按既有过滤规则决定是否纳入 __exp_main.txt。"""
        if not file_path or not os.path.isfile(file_path):
            return
        if self._scan_date_formatted_aee and self._scan_date_formatted_aee not in file_path:
            return
        dbg_file_path = self._get_dbg_file_from_dec_related_path(file_path)
        if dbg_file_path and dbg_file_path in self._zero_size_dbg_set:
            TEST_LOGGER.warn(f"__exp_main.txt 对应的 dbg 文件大小为 0，跳过正常解析且不写入报告：{file_path}")
            return
        if dbg_file_path and dbg_file_path in self._extract_failed_dbg_set:
            missing = self._get_dbg_dec_missing_critical_files(dbg_file_path)
            if missing:
                TEST_LOGGER.warn(
                    f"__exp_main.txt 所在 .DEC 目录仍缺少关键文件 {missing}，跳过正常解析并转入失败兜底链：{file_path}")
                return
        exp_main_file_list.append(file_path)
        TEST_LOGGER.debug(f"获取 __exp_main.txt 文件：{file_path}")

    def __scan_exp_main_list(self):
        """扫描目录下所有的 __exp_main.txt 文件（方案B：剪枝 + DEC 短路 + 进度日志）"""
        TEST_LOGGER.info("******************** 开始扫描__exp_main.txt文件 ********************")
        exp_main_file_list = []
        dir_count = 0
        last_progress_t = time.time()

        for root, dirs, files in os.walk(self._scan_root_dir):
            dir_count += 1
            now = time.time()
            if (dir_count % self._SCAN_PROGRESS_DIR_INTERVAL == 0
                    or now - last_progress_t >= self._SCAN_PROGRESS_TIME_INTERVAL_SEC):
                TEST_LOGGER.info(
                    f"扫描进度：已遍历 {dir_count} 个目录，已找到 {len(exp_main_file_list)} 个 __exp_main.txt")
                last_progress_t = now

            self._prune_walk_dirs(dirs, skip_dec_dirs=False)

            # .dbg.DEC / *.DEC：关键文件在目录根，直接取 __exp_main.txt 后不再下钻
            if os.path.basename(root).upper().endswith(".DEC"):
                self.__maybe_append_exp_main(
                    os.path.join(root, "__exp_main.txt"), exp_main_file_list)
                dirs.clear()
                continue

            # 兼容偶发不在 .DEC 下的 __exp_main.txt
            if "__exp_main.txt" in files:
                self.__maybe_append_exp_main(
                    os.path.join(root, "__exp_main.txt"), exp_main_file_list)

        TEST_LOGGER.info(f"获取需要分析的 __exp_main.txt 文件共：{len(exp_main_file_list)} 个")
        return exp_main_file_list

    def _scan_tne_summary(self):
        """-m tne：扫描/解析 TNE，按官方规则汇总去重并出 org/final 表。"""
        TEST_LOGGER.resetTag(__name__)
        TEST_LOGGER.info("开始执行 TNE 汇总去重扫描")
        TEST_LOGGER.info("扫描目录: {}".format(self._scan_root_dir))
        TEST_LOGGER.info("相似度系数: {}".format(self._ratio_std_tne))
        TEST_LOGGER.info("扫描日期: {}".format(self._scan_date_formatted_tne if self._scan_date_formatted_tne else "所有日期"))

        if not self._scan_root_dir or not os.path.isdir(self._scan_root_dir):
            TEST_LOGGER.error(f"扫描目录不存在: {self._scan_root_dir}")
            return

        try:
            tne_file_list, tne_dir_list = self._collect_tne_files_and_dirs()
            TEST_LOGGER.info("扫描获取tne文件共：{}个".format(len(tne_file_list)))
            TEST_LOGGER.info("扫描获取tne目录共：{}个".format(len(tne_dir_list)))
            if not self._skip_extract:
                self._decompress_tne(tne_file_list)
                _, tne_dir_list = self._collect_tne_files_and_dirs()
                TEST_LOGGER.info("解压后tne目录共：{}个".format(len(tne_dir_list)))
            else:
                TEST_LOGGER.info("skip_extract: True，跳过 tne 解压，仅扫描已解压目录")

            tne_result_list = []
            if tne_dir_list:
                tne_result_list = self._analyse_tne(tne_dir_list, extra_jira_tag=self._extra_jira_tag)
            tne_rlt_list_org, tne_rlt_list_final = self._tne_to_org_final(tne_result_list, replace_path=True)
            TEST_LOGGER.info("tne 合并后原始 {} 条，最终 {} 条".format(
                len(tne_rlt_list_org), len(tne_rlt_list_final)))
            summary_data = self.__build_tne_scan_summary(
                tne_file_list, tne_dir_list, tne_result_list, tne_rlt_list_org, tne_rlt_list_final)
            self.__generate_tne_result(tne_rlt_list_org, tne_rlt_list_final, summary_data)
            TEST_LOGGER.info("TNE 汇总去重扫描完成")
        except Exception:
            TEST_LOGGER.error(f"TNE 扫描过程发生异常: {traceback.format_exc()}")

    def _tne_file_matches_scan_date(self, name):
        scan_date = self._scan_date_formatted_tne
        if not scan_date:
            return True
        if scan_date in name:
            return True
        if len(scan_date) == 8:
            dashed = "{}_{}_{}".format(scan_date[:4], scan_date[4:6], scan_date[6:8])
            return dashed in name
        return False

    def _collect_tne_files_and_dirs(self):
        """收集 .tne 文件与已解压的 0x* 目录。"""
        TEST_LOGGER.info("******************** 开始扫描tne文件与目录 ********************")
        tne_file_list = []
        tne_dir_list = []
        for root, dirs, files in os.walk(self._scan_root_dir):
            self._prune_walk_dirs(dirs, skip_dec_dirs=True)
            for dir_name in list(dirs):
                if not self._TNE_DIR_RE.fullmatch(dir_name):
                    continue
                if not self._tne_file_matches_scan_date(dir_name):
                    TEST_LOGGER.info("跳过tne目录（日期不符）：{}".format(os.path.join(root, dir_name)))
                    continue
                tne_dir_list.append(os.path.join(root, dir_name))
                TEST_LOGGER.info("发现tne目录：{}".format(os.path.join(root, dir_name)))
            for file_name in files:
                if not file_name.lower().endswith(".tne"):
                    continue
                if not self._tne_file_matches_scan_date(file_name):
                    TEST_LOGGER.info("跳过tne文件（日期不符）：{}".format(os.path.join(root, file_name)))
                    continue
                file_path = os.path.join(root, file_name)
                tne_file_list.append(file_path)
                TEST_LOGGER.info("发现tne文件：{}".format(file_path))
        TEST_LOGGER.info("******************** 扫描tne文件与目录已完成 ********************")
        return tne_file_list, tne_dir_list

    def _tne_dedup_similarity_params(self, exp_type_org, caused_by_org):
        format_str = True
        absolute_equal = False
        if exp_type_org in self._TNE_NO_FORMAT_EXP_TYPES:
            format_str = False
        freeze_list = getattr(self, "_freeze_tne_type_list", None) or []
        subsystem_list = getattr(self, "_subsystem_crash_tne_type_list", None) or []
        if exp_type_org in freeze_list or exp_type_org in subsystem_list:
            absolute_equal = True
        if exp_type_org in self._TNE_ABSOLUTE_EQUAL_EXP_TYPES:
            absolute_equal = "***FoundStackInfo***" not in str(caused_by_org or "")
        return format_str, absolute_equal

    @staticmethod
    def _as_count(value, default=1):
        try:
            return int(value)
        except (TypeError, ValueError):
            return default

    def _combine_tne_duplicate_row(self, exist, incoming):
        """命中后次数相加，重复路径和设备号合并；较新版本覆盖 Version。"""
        count = self._as_count(exist[11]) + self._as_count(incoming[11])
        path_exist = str(exist[0] or "")
        path_incoming = str(incoming[0] or "")
        if path_incoming and path_incoming not in path_exist.split(" | "):
            merged_path = path_exist + " | " + path_incoming if path_exist else path_incoming
            if len(merged_path) > 10000:
                merged_path = merged_path[:10000]
            exist[0] = merged_path
        device_exist = str(exist[10] or "").strip()
        device_incoming = str(incoming[10] or "").strip()
        if device_incoming and device_incoming not in ("undefined", "None"):
            exist_ids = []
            if device_exist and device_exist not in ("undefined", "None"):
                exist_ids = [item.strip() for item in device_exist.split(",") if item.strip()]
            if device_incoming not in exist_ids:
                exist[10] = ",".join(exist_ids + [device_incoming]) if exist_ids else device_incoming
        try:
            version_incoming = re.search(self._TNE_VERSION_DATE_RE, str(incoming[1])).group(1)
            version_exist = re.search(self._TNE_VERSION_DATE_RE, str(exist[1])).group(1)
            if version_incoming > version_exist:
                exist[1] = incoming[1]
                exist[2] = incoming[2]
        except Exception:
            pass
        exist[11] = count
        return exist

    def _merge_tne_final_rows(self, base_list, incoming_list):
        """分片最终行再去重。命中后次数相加，重复路径和设备次数合并。"""
        for row in incoming_list:
            exp_type = row[4]
            caused_by = row[8]
            if "TNE_ERROR_file_missing" in str(exp_type) and str(caused_by) == "undefined":
                continue
            if caused_by is None:
                continue
            format_str, absolute_equal = self._tne_dedup_similarity_params(exp_type, caused_by)
            matched = False
            for exist in base_list:
                if exist[4] != exp_type or exist[6] != row[6]:
                    continue
                try:
                    exist_caused_by = str(exist[8])
                    incoming_caused_by = str(caused_by)
                    ratio = get_str_similar(
                        exist_caused_by, incoming_caused_by,
                        format_str=format_str, absolute_equal=absolute_equal)
                    if (ratio < self._ratio_std_tne and not absolute_equal
                            and TneBase.transucc_stacks_equivalent(exist_caused_by, incoming_caused_by)):
                        ratio = 100
                except Exception:
                    TEST_LOGGER.warn("TNE 去重相似度计算异常：\n{}".format(traceback.format_exc()))
                    continue
                if ratio >= self._ratio_std_tne:
                    self._combine_tne_duplicate_row(exist, row)
                    matched = True
                    break
            if not matched:
                base_list.append(list(row))
        return base_list

    def _tne_to_org_final(self, tne_result_list, replace_path=False):
        """将 TNE 解析结果转为原始表与去重后最终表。"""
        tne_rlt_list_org = []
        tne_rlt_list_final = []
        if not tne_result_list:
            return tne_rlt_list_org, tne_rlt_list_final
        for tne_result in tne_result_list:
            tne_result_attrs = list(tne_result.get_tne_attrs())
            if replace_path:
                tne_result_attrs[0] = self._convert_path_to_win(tne_result_attrs[0])
            tne_result_attrs[8] = str(tne_result_attrs[8])
            org_row = list(tne_result_attrs)
            tne_rlt_list_org.append(org_row)
            exp_type_org = tne_result_attrs[4]
            caused_by_org = tne_result_attrs[8]
            if "TNE_ERROR_file_missing" in str(exp_type_org) and caused_by_org == "undefined":
                continue
            if caused_by_org is None:
                continue
            self._merge_tne_final_rows(tne_rlt_list_final, [tne_result_attrs])
        return tne_rlt_list_org, tne_rlt_list_final

    def __generate_tne_result(self, tne_rlt_list_org, tne_rlt_list_final, summary_data=None):
        TEST_LOGGER.info("******************** 开始生成TNE扫描结果 ********************")
        try:
            from modules.common.Excel import Excel
            build_version = self._build_version
            if tne_rlt_list_org:
                for tne_rlt in tne_rlt_list_org:
                    if len(tne_rlt) > 1 and tne_rlt[1] and tne_rlt[1] not in ("undefined",):
                        build_version = tne_rlt[1]
                        break
            jira_repo = self._jira_repo if self._jira_repo else "None"
            reporter = self._reporter if self._reporter else "None"
            result_dir = self._scan_root_dir
            timestamp = time.strftime("%H%M%S")
            date_time_str = f"{self._report_date_formatted}_{timestamp}"
            generated_files = {}
            if not tne_rlt_list_org and not tne_rlt_list_final:
                TEST_LOGGER.info("TNE org结果为空，跳过生成结果表")

            if tne_rlt_list_org:
                org_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyTNE_{self._scan_place}_{date_time_str}_org.xls"
                org_excel_path = os.path.join(result_dir, org_excel_name)
                excel_org = Excel(org_excel_path)
                excel_org.insertResultTne(tne_rlt_list_org)
                TEST_LOGGER.info(f"TNE 原始结果Excel已生成：{org_excel_path}")
                generated_files["org_excel"] = org_excel_path

            if tne_rlt_list_final:
                final_excel_name = f"Result_{jira_repo}_{reporter}_MonkeyTNE_{self._scan_place}_{date_time_str}.xls"
                final_excel_path = os.path.join(result_dir, final_excel_name)
                excel_final = Excel(final_excel_path)
                excel_final.insertResultTne(tne_rlt_list_final)
                TEST_LOGGER.info(f"TNE 去重后结果Excel已生成：{final_excel_path}")
                generated_files["final_excel"] = final_excel_path

            if summary_data is not None:
                summary_json_name = f"Result_{jira_repo}_{reporter}_MonkeyTNE_{self._scan_place}_{date_time_str}_summary.json"
                summary_json_path = os.path.join(result_dir, summary_json_name)
                summary_data["generated_files"] = generated_files
                summary_data["generated_files"]["summary_json"] = summary_json_path
                summary_data["build_version"] = build_version if build_version else "VersionNone"
                with open(summary_json_path, "w", encoding="utf-8") as f:
                    json.dump(summary_data, f, ensure_ascii=False, indent=2)
                TEST_LOGGER.info(f"TNE 扫描摘要 JSON 已生成：{summary_json_path}")
        except Exception:
            TEST_LOGGER.error(f"生成TNE结果时发生异常：{traceback.format_exc()}")
        TEST_LOGGER.info("******************** TNE扫描结果生成完成 ********************")

    def __build_tne_scan_summary(self, tne_file_list, tne_dir_list, tne_result_list,
                                 tne_rlt_list_org, tne_rlt_list_final):
        return {
            "tool": "stability_Start-Log-Scan",
            "scan_mode": self._scan_mode,
            "scan_mode_name": SCAN_MODE_DICT.get(self._scan_mode, "未知"),
            "scan_place": self._scan_place,
            "scan_root_dir": self._scan_root_dir,
            "scan_date": self._scan_date_formatted_tne if self._scan_date_formatted_tne else "ALL",
            "report_date": self._report_date_formatted,
            "generated_at": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "skip_extract": self._skip_extract,
            "counts": {
                "tne_file_count": len(tne_file_list),
                "tne_dir_count": len(tne_dir_list),
                "tne_result_count": len(tne_result_list),
                "tne_result_org_count": len(tne_rlt_list_org),
                "tne_result_final_count": len(tne_rlt_list_final)
            }
        }

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
