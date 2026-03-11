# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\common\Excel.py
import os
from copy import deepcopy
import xlwt, xlrd, traceback
from modules.analyse.aee.AnalyseAee import Aee
from modules.common.Logger import TEST_LOGGER
from modules.common.Utils import send_msg_by_feishu_robot

class Excel(object):

    def __init__(self, excel_path):
        self.excel_path = excel_path

    def insertResultAee(self, aee_result_list, more_info=False, pipeline_id=None, utp_tcid=None, utp_taskid=None, priority=False):
        insert_exception = False
        style0 = xlwt.easyxf("font: height 200  ,name Times New Roman, color-index blue, bold on")
        style1 = xlwt.easyxf("font: name calibri")
        wb = xlwt.Workbook(encoding="utf-8")
        work_sheet = wb.add_sheet("aeeexp", cell_overwrite_ok=True)
        column_index = 0
        work_sheet.write(0, column_index, "Id", style0)
        work_sheet.col(column_index).width = 1000
        column_index += 1
        work_sheet.write(0, column_index, "Path", style0)
        work_sheet.col(column_index).width = 10000
        column_index += 1
        work_sheet.write(0, column_index, "Version", style0)
        work_sheet.col(column_index).width = 6000
        column_index += 1
        work_sheet.write(0, column_index, "ExpTime", style0)
        work_sheet.col(column_index).width = 7000
        column_index += 1
        work_sheet.write(0, column_index, "ExpClass", style0)
        work_sheet.col(column_index).width = 2000
        column_index += 1
        work_sheet.write(0, column_index, "ExpType ", style0)
        work_sheet.col(column_index).width = 4000
        column_index += 1
        work_sheet.write(0, column_index, "CurProcess", style0)
        work_sheet.col(column_index).width = 7000
        column_index += 1
        work_sheet.write(0, column_index, "Package", style0)
        work_sheet.col(column_index).width = 7000
        column_index += 1
        work_sheet.write(0, column_index, "Detail", style0)
        work_sheet.col(column_index).width = 30000
        column_index += 1
        work_sheet.write(0, column_index, "CausedBy", style0)
        work_sheet.col(column_index).width = 30000
        column_index += 1
        work_sheet.write(0, column_index, "extraTag", style0)
        work_sheet.col(column_index).width = 7000
        column_index += 1
        work_sheet.write(0, column_index, "Count", style0)
        work_sheet.col(column_index).width = 5000
        column_index += 1
        work_sheet.write(0, column_index, "Activity", style0)
        work_sheet.col(column_index).width = 7000
        column_index += 1
        if pipeline_id:
            work_sheet.write(0, column_index, "pipelineID", style0)
            work_sheet.col(column_index).width = 10000
            pipeline_id_index = column_index
            column_index += 1
        if utp_tcid:
            work_sheet.write(0, column_index, "utpTcId", style0)
            work_sheet.col(column_index).width = 10000
            utp_tcid_index = column_index
            column_index += 1
        if utp_taskid:
            work_sheet.write(0, column_index, "utpTaskId", style0)
            work_sheet.col(column_index).width = 10000
            utp_taskid_index = column_index
            column_index += 1
        if more_info:
            work_sheet.write(0, column_index, "Device", style0)
            work_sheet.col(column_index).width = 8000
            column_index += 1
            work_sheet.write(0, column_index, "DataPercent", style0)
            work_sheet.col(column_index).width = 5000
            column_index += 1
        work_sheet.write(0, column_index, "DeviceId", style0)
        work_sheet.col(column_index).width = 10000
        column_index += 1
        if priority:
            work_sheet.write(0, column_index, "Priority", style0)
            work_sheet.col(column_index).width = 10000
            column_index += 1
        row_index = 0
        for aee_result in aee_result_list:
            aee_result = [
             row_index] + aee_result
            if priority:
                aee_priority = self.judge_priority(aee_result)
                aee_result.append(aee_priority)
            for col_index in range(column_index):
                if pipeline_id and pipeline_id_index == col_index:
                    content = pipeline_id
                else:
                    if utp_tcid and utp_tcid_index == col_index:
                        content = utp_tcid
                    else:
                        if utp_taskid and utp_taskid_index == col_index:
                            content = utp_taskid
                        else:
                            try:
                                content = aee_result[col_index] if (col_index == 0 or col_index == 11) else (str(aee_result[col_index]))
                            except:
                                TEST_LOGGER.error(f"Exception, col_index:{col_index}, aee_result:{aee_result}")
                                content = "None"
                                insert_exception = True

                            if type(content) == str:
                                if len(content) > 10000:
                                    TEST_LOGGER.warn("col_index:{}, too long: {}".format(col_index, content))
                                    content = content[:10000]
                            work_sheet.write(row_index + 1, col_index, content, style1)

            row_index = row_index + 1

        wb.save(self.excel_path)
        if insert_exception:
            send_msg_by_feishu_robot("生成结果Excel文件发生异常", f"Excel文件：{self.excel_path}", "Excel生成异常")
        TEST_LOGGER.info("已生成文件：{}".format(self.excel_path))

    def insertResultTne(self, tne_result_list):
        style0 = xlwt.easyxf("font: height 200  ,name Times New Roman, color-index blue, bold on")
        style1 = xlwt.easyxf("font: name calibri")
        wb = xlwt.Workbook(encoding="utf-8")
        work_sheet = wb.add_sheet("aeeexp", cell_overwrite_ok=True)
        work_sheet.write(0, 0, "Id", style0)
        work_sheet.write(0, 1, "Path", style0)
        work_sheet.write(0, 2, "Version", style0)
        work_sheet.write(0, 3, "ExpTime", style0)
        work_sheet.write(0, 4, "ExpClass", style0)
        work_sheet.write(0, 5, "ExpType ", style0)
        work_sheet.write(0, 6, "CurProcess", style0)
        work_sheet.write(0, 7, "Package", style0)
        work_sheet.write(0, 8, "Detail", style0)
        work_sheet.write(0, 9, "CausedBy", style0)
        work_sheet.write(0, 10, "extraTag", style0)
        work_sheet.write(0, 11, "DeviceId", style0)
        work_sheet.write(0, 12, "Count", style0)
        work_sheet.col(0).width = 1000
        work_sheet.col(1).width = 10000
        work_sheet.col(2).width = 6000
        work_sheet.col(3).width = 7000
        work_sheet.col(4).width = 2000
        work_sheet.col(5).width = 4000
        work_sheet.col(6).width = 7000
        work_sheet.col(7).width = 7000
        work_sheet.col(8).width = 30000
        work_sheet.col(9).width = 30000
        work_sheet.col(10).width = 7000
        work_sheet.col(11).width = 5000
        work_sheet.col(12).width = 5000
        col_count = 13
        row_index = 0
        for tne_result in tne_result_list:
            tne_result = [
             row_index] + tne_result
            for col_index in range(col_count):
                content = tne_result[col_index] if (col_index == 0 or col_index == 12) else (str(tne_result[col_index]))
                if type(content) == str:
                    if len(content) > 10000:
                        TEST_LOGGER.warn("col_index:{}, too long: {}".format(col_index, content))
                        content = content[:10000]
                work_sheet.write(row_index + 1, col_index, content, style1)

            row_index = row_index + 1

        wb.save(self.excel_path)
        TEST_LOGGER.info("已生成文件：{}".format(self.excel_path))

    def insertResultTneUsicAbandon(self, tne_result_list):
        style0 = xlwt.easyxf("font: height 200  ,name Times New Roman, color-index blue, bold on")
        style1 = xlwt.easyxf("font: name calibri")
        wb = xlwt.Workbook(encoding="utf-8")
        work_sheet = wb.add_sheet("aeeexp", cell_overwrite_ok=True)
        work_sheet.write(0, 0, "Id", style0)
        work_sheet.write(0, 1, "Path", style0)
        work_sheet.write(0, 2, "Version", style0)
        work_sheet.write(0, 3, "ExpTime", style0)
        work_sheet.write(0, 4, "ExpClass", style0)
        work_sheet.write(0, 5, "ExpType ", style0)
        work_sheet.write(0, 6, "CurProcess", style0)
        work_sheet.write(0, 7, "Package", style0)
        work_sheet.write(0, 8, "Detail", style0)
        work_sheet.write(0, 9, "CausedBy", style0)
        work_sheet.write(0, 10, "extraTag", style0)
        work_sheet.write(0, 11, "DeviceID", style0)
        work_sheet.write(0, 12, "Count", style0)
        work_sheet.write(0, 13, "AbandonReason", style0)
        work_sheet.col(0).width = 1000
        work_sheet.col(1).width = 10000
        work_sheet.col(2).width = 6000
        work_sheet.col(3).width = 7000
        work_sheet.col(4).width = 2000
        work_sheet.col(5).width = 4000
        work_sheet.col(6).width = 7000
        work_sheet.col(7).width = 7000
        work_sheet.col(8).width = 30000
        work_sheet.col(9).width = 30000
        work_sheet.col(10).width = 7000
        work_sheet.col(11).width = 5000
        work_sheet.col(12).width = 5000
        work_sheet.col(13).width = 10000
        col_count = 14
        row_index = 0
        for tne_result in tne_result_list:
            tne_result = [
             row_index] + tne_result
            for col_index in range(col_count):
                content = tne_result[col_index] if (col_index == 0 or col_index == 12) else (str(tne_result[col_index]))
                if type(content) == str:
                    if len(content) > 10000:
                        TEST_LOGGER.warn("col_index:{}, too long: {}".format(col_index, content))
                        content = content[:10000]
                work_sheet.write(row_index + 1, col_index, content, style1)

            row_index = row_index + 1

        wb.save(self.excel_path)
        TEST_LOGGER.info("已生成文件：{}".format(self.excel_path))

    def insertResultTneUsicOrg(self, tne_result_list):
        style0 = xlwt.easyxf("font: height 200  ,name Times New Roman, color-index blue, bold on")
        style1 = xlwt.easyxf("font: name calibri")
        wb = xlwt.Workbook(encoding="utf-8")
        work_sheet = wb.add_sheet("aeeexp", cell_overwrite_ok=True)
        work_sheet.write(0, 0, "Id", style0)
        work_sheet.write(0, 1, "Path", style0)
        work_sheet.write(0, 2, "Version", style0)
        work_sheet.write(0, 3, "ExpTime", style0)
        work_sheet.write(0, 4, "ExpClass", style0)
        work_sheet.write(0, 5, "ExpType ", style0)
        work_sheet.write(0, 6, "CurProcess", style0)
        work_sheet.write(0, 7, "Package", style0)
        work_sheet.write(0, 8, "Detail", style0)
        work_sheet.write(0, 9, "CausedBy", style0)
        work_sheet.write(0, 10, "extraTag", style0)
        work_sheet.write(0, 11, "DeviceID", style0)
        work_sheet.write(0, 12, "Count", style0)
        work_sheet.col(0).width = 1000
        work_sheet.col(1).width = 10000
        work_sheet.col(2).width = 6000
        work_sheet.col(3).width = 7000
        work_sheet.col(4).width = 2000
        work_sheet.col(5).width = 4000
        work_sheet.col(6).width = 7000
        work_sheet.col(7).width = 7000
        work_sheet.col(8).width = 30000
        work_sheet.col(9).width = 30000
        work_sheet.col(10).width = 7000
        work_sheet.col(11).width = 5000
        work_sheet.col(12).width = 5000
        col_count = 13
        row_index = 0
        for tne_result in tne_result_list:
            tne_result = [
             row_index] + tne_result
            for col_index in range(col_count):
                content = tne_result[col_index] if (col_index == 0 or col_index == 12) else (str(tne_result[col_index]))
                if type(content) == str:
                    if len(content) > 10000:
                        TEST_LOGGER.warn("col_index:{}, too long: {}".format(col_index, content))
                        content = content[:10000]
                work_sheet.write(row_index + 1, col_index, content, style1)

            row_index = row_index + 1

        wb.save(self.excel_path)
        TEST_LOGGER.info("已生成文件：{}".format(self.excel_path))

    def insertResultTneUsicFinal(self, tne_result_list, prj_result_dir_win):
        style0 = xlwt.easyxf("font: height 200  ,name Times New Roman, color-index blue, bold on")
        style1 = xlwt.easyxf("font: name calibri")
        wb = xlwt.Workbook(encoding="utf-8")
        work_sheet = wb.add_sheet("aeeexp", cell_overwrite_ok=True)
        work_sheet.write(0, 0, "Id", style0)
        work_sheet.write(0, 1, "Path", style0)
        work_sheet.write(0, 2, "Version", style0)
        work_sheet.write(0, 3, "ExpTime", style0)
        work_sheet.write(0, 4, "ExpClass", style0)
        work_sheet.write(0, 5, "ExpType ", style0)
        work_sheet.write(0, 6, "CurProcess", style0)
        work_sheet.write(0, 7, "Package", style0)
        work_sheet.write(0, 8, "Detail", style0)
        work_sheet.write(0, 9, "CausedBy", style0)
        work_sheet.write(0, 10, "extraTag", style0)
        work_sheet.write(0, 11, "DeviceCount", style0)
        work_sheet.write(0, 12, "DeviceDetail", style0)
        work_sheet.write(0, 13, "Count", style0)
        work_sheet.write(0, 14, "DuplicatedPath", style0)
        work_sheet.col(0).width = 1000
        work_sheet.col(1).width = 10000
        work_sheet.col(2).width = 6000
        work_sheet.col(3).width = 7000
        work_sheet.col(4).width = 2000
        work_sheet.col(5).width = 4000
        work_sheet.col(6).width = 7000
        work_sheet.col(7).width = 7000
        work_sheet.col(8).width = 30000
        work_sheet.col(9).width = 30000
        work_sheet.col(10).width = 7000
        work_sheet.col(11).width = 5000
        work_sheet.col(12).width = 5000
        work_sheet.col(13).width = 5000
        work_sheet.col(14).width = 10000
        col_count = 15
        row_index = 0
        for tne_result in tne_result_list:
            tne_result = deepcopy(tne_result)
            duplicated_path = tne_result[12]
            split_duplicated_path = duplicated_path.split("\n")[:10]
            duplicated_path_top5 = "\n".join(split_duplicated_path)
            duplicated_id = tne_result[13]
            tne_result[7] = "{}\nExcel Path:{}\nDuplicated ID(重复问题ID --- 对应org原始表格中的行数):{}\n重复问题地址：\n{}".format(tne_result[7], prj_result_dir_win, duplicated_id, duplicated_path_top5)
            device_dict = tne_result[10]
            device_count = len(device_dict)
            device_count_list = sorted((device_dict.items()), key=(lambda x: x[1]), reverse=True)
            tne_result[10] = device_count_list[:3] if len(device_count_list) > 3 else device_count_list
            tne_result.insert(10, device_count)
            tne_result = [row_index] + tne_result
            for col_index in range(col_count):
                content = tne_result[col_index] if col_index in (0, 11, 13) else str(tne_result[col_index])
                if type(content) == str:
                    if len(content) > 10000:
                        TEST_LOGGER.warn("col_index:{}, too long: {}".format(col_index, content))
                        content = content[:10000]
                work_sheet.write(row_index + 1, col_index, content, style1)

            row_index = row_index + 1
            TEST_LOGGER.info(tne_result)

        wb.save(self.excel_path)
        TEST_LOGGER.info("已生成文件：{}".format(self.excel_path))

    @staticmethod
    def judge_priority(aee_result):
        aee_priority = "C"
        attrs_path = str(aee_result[1]).lower()
        attrs_exp_class = str(aee_result[4]).lower()
        attrs_exp_type = str(aee_result[5]).lower()
        attrs_count = aee_result[11]
        if attrs_exp_class in ('swt', 'hwt', 'kernel (ke)', 'hang_detect', 'hardware reboot',
                               'ocp reboot'):
            return "A"
        if attrs_exp_class == "native (ne)":
            if "fatal" in attrs_path:
                return "A"
            if attrs_count >= 2:
                return "B"
            return "C"
        if attrs_exp_class == "java (je)":
            if "fatal" in attrs_path:
                return "A"
            if attrs_count >= 3:
                return "B"
            return "C"
        if attrs_exp_class == "external (ee)":
            if attrs_exp_type == "combo":
                if attrs_count >= 50:
                    return "B"
                return "C"
            if attrs_exp_type == "modem":
                if attrs_count >= 3:
                    return "A"
                return "B"
        if attrs_exp_class == "system api dump":
            return "B"
        if attrs_exp_class == "anr":
            if attrs_count >= 10:
                return "B"
            return "C"
        return aee_priority


class ExcelTne04(object):

    def __init__(self, excel_path):
        self.excel_path = excel_path

    def insertResult(self, tne04_detail_list):
        style0 = xlwt.easyxf("font: height 200  ,name Times New Roman, color-index blue, bold on")
        style1 = xlwt.easyxf("font: name calibri")
        wb = xlwt.Workbook(encoding="utf-8")
        work_sheet = wb.add_sheet("aeeexp", cell_overwrite_ok=True)
        work_sheet.write(0, 0, "Log路径", style0)
        work_sheet.write(0, 1, "项目名", style0)
        work_sheet.write(0, 2, "SN号", style0)
        work_sheet.write(0, 3, "故障原因", style0)
        work_sheet.write(0, 4, "Modem起始温度", style0)
        work_sheet.write(0, 5, "Modem结束温度", style0)
        work_sheet.write(0, 6, "Modem最高温度", style0)
        work_sheet.write(0, 7, "AP起始温度", style0)
        work_sheet.write(0, 8, "AP结束温度", style0)
        work_sheet.write(0, 9, "AP最高温度", style0)
        work_sheet.write(0, 10, "电池起始温度", style0)
        work_sheet.write(0, 11, "电池结束温度", style0)
        work_sheet.write(0, 12, "电池温度差", style0)
        work_sheet.write(0, 13, "最低电压", style0)
        work_sheet.write(0, 14, "平均电流", style0)
        work_sheet.write(0, 15, "开始时间", style0)
        work_sheet.write(0, 16, "结束时间", style0)
        work_sheet.write(0, 17, "多久产生的故障", style0)
        work_sheet.write(0, 18, "故障时间点", style0)
        work_sheet.col(0).width = 10000
        work_sheet.col(1).width = 2000
        work_sheet.col(2).width = 5000
        work_sheet.col(3).width = 2000
        work_sheet.col(4).width = 2000
        work_sheet.col(5).width = 2000
        work_sheet.col(6).width = 2000
        work_sheet.col(7).width = 2000
        work_sheet.col(8).width = 2000
        work_sheet.col(9).width = 2000
        work_sheet.col(10).width = 2000
        work_sheet.col(11).width = 2000
        work_sheet.col(12).width = 2000
        work_sheet.col(13).width = 2000
        work_sheet.col(14).width = 2000
        work_sheet.col(15).width = 5000
        work_sheet.col(16).width = 5000
        work_sheet.col(17).width = 2000
        work_sheet.col(18).width = 5000
        col_count = 19
        row_index = 0
        for tne_result in tne04_detail_list:
            for col_index in range(col_count):
                content = tne_result[col_index]
                if type(content) == str:
                    if len(content) > 10000:
                        TEST_LOGGER.warn("col_index:{}, too long: {}".format(col_index, content))
                        content = content[:10000]
                work_sheet.write(row_index + 1, col_index, content, style1)

            row_index = row_index + 1

        wb.save(self.excel_path)
        TEST_LOGGER.info("已生成文件：{}".format(self.excel_path))


def exportExcelTneUsic(tne_rlt_list_abandon, tne_rlt_list_org, tne_rlt_list_final, excel_path_abandon, excel_path_org, excel_path_final, prj_result_dir_win):
    """
    生成 Tne Usic 结果Excel
    :param tne_rlt_list_abandon: 丢弃的数据
    :param tne_rlt_list_org: 扫描原始数据
    :param tne_rlt_list_final: 扫描去重后数据
    :param excel_path_abandon：丢弃数据Excel存放路径
    :param excel_path_org: 原始数据Excel存放路径
    :param excel_path_final: 去重数据Excel存放路径
    :param prj_result_dir_win: Excel 存放路径
    :return:
    """
    if os.path.isfile(excel_path_abandon):
        os.remove(excel_path_abandon)
    if os.path.isfile(excel_path_org):
        os.remove(excel_path_org)
    if os.path.isfile(excel_path_final):
        os.remove(excel_path_final)
    if tne_rlt_list_abandon:
        excel = Excel(excel_path_abandon)
        excel.insertResultTneUsicAbandon(tne_rlt_list_abandon)
    if tne_rlt_list_org:
        excel = Excel(excel_path_org)
        excel.insertResultTneUsicOrg(tne_rlt_list_org)
    if tne_rlt_list_final:
        excel = Excel(excel_path_final)
        excel.insertResultTneUsicFinal(tne_rlt_list_final, prj_result_dir_win)


def read_aee_rlt_excel(excel_path):
    aee_rlt_list = []
    work_book = xlrd.open_workbook(excel_path)
    work_sheet_0 = work_book.sheet_by_index(0)
    row_count = work_sheet_0.nrows
    if row_count > 1:
        for row_index in range(1, work_sheet_0.nrows):
            row_values = work_sheet_0.row_values(row_index)
            exp_main_path = row_values[1]
            version = row_values[2]
            exp_time = row_values[3]
            exp_class = row_values[4]
            exp_type = row_values[5]
            cur_process = row_values[6]
            package = row_values[7]
            detail = row_values[8]
            caused_by = row_values[9]
            extra_tag = row_values[10]
            if len(row_values) > 12:
                count = row_values[11]
                activity = row_values[12]
            else:
                activity = None
            aee_data = AeeExcelData(exp_main_path, version, exp_time, exp_class, exp_type, cur_process, package, detail, caused_by, extra_tag, activity)
            aee_rlt_list.append(aee_data)

    return aee_rlt_list


class AeeExcelData(object):

    def __init__(self, exp_main_path, version, exp_time, exp_class, exp_type, cur_process, package, detail, caused_by, extra_tag, activity):
        self._AeeExcelData__exp_main_path = exp_main_path
        self._AeeExcelData__version = version
        self._AeeExcelData__exp_time = exp_time
        self._AeeExcelData__exp_class = exp_class
        self._AeeExcelData__exp_type = exp_type
        self._AeeExcelData__cur_process = cur_process
        self._AeeExcelData__package = package
        self._AeeExcelData__detail = detail
        self._AeeExcelData__caused_by = caused_by
        self._AeeExcelData__extra_tag = extra_tag
        self._AeeExcelData__count = 1
        self._AeeExcelData__activity = activity
        self._AeeExcelData__device_id = None
        self._AeeExcelData__recognize_exception_rlt = True
        self._AeeExcelData__handle_recognize_rlt = True
        self._AeeExcelData__ignore_ke_ne_hwasan = False
        self._AeeExcelData__ne_system_issue = True

    def get_aee_attrs(self):
        return [
         self._AeeExcelData__exp_main_path, self._AeeExcelData__version, self._AeeExcelData__exp_time, self._AeeExcelData__exp_class, self._AeeExcelData__exp_type,
         self._AeeExcelData__cur_process, self._AeeExcelData__package, self._AeeExcelData__detail, self._AeeExcelData__caused_by, self._AeeExcelData__extra_tag, self._AeeExcelData__count, self._AeeExcelData__activity, self._AeeExcelData__device_id]

    @property
    def recognize_exception_rlt(self):
        return self._AeeExcelData__recognize_exception_rlt

    @property
    def handle_recognize_rlt(self):
        return self._AeeExcelData__handle_recognize_rlt

    def is_ignore_ke_ne_hwasan(self):
        return self._AeeExcelData__ignore_ke_ne_hwasan

    def is_ne_system_issue(self):
        return self._AeeExcelData__ne_system_issue


if __name__ == "__main__":
    read_aee_rlt_excel("D:\\Ongoing\\Result_AC8_scm_FANSAEE_SH_20210510_Fans_org.xls")

# okay decompiling extracted_pyz_modules\modules\common\Excel.pyc
