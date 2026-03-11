# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\analyse\tne\files\pstore.py
import datetime, os, re
from statistics import mean
from modules.common.Logger import TEST_LOGGER

class Pstore(object):

    def __init__(self, file_path):
        super(Pstore, self).__init__()
        self._Pstore__file_path = file_path

    def analyse_tne04(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Pstore__file_path))
        TEST_LOGGER.debug(("开始解析pstore文件：{}".format(self._Pstore__file_path)), tag=tne_dir_name)
        regex_utc_time = re.compile("(\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}).* UTC")
        regex_detail_pc_is_at = re.compile("PC is at (\\[[a-zA-Z0-9_]+\\]\\s+)?([a-zA-Z0-9_]+)\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+")
        regex_detail_pc = re.compile("pc : (\\[[a-zA-Z0-9_]+\\]\\s+)?([a-zA-Z0-9_]+)\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+")
        regex_kernel_panic = re.compile("Kernel panic - not syncing:.*")
        regex_violation_start = re.compile("\\[DEVAPC\\]:\\s+(.*Violation$)")
        regex_devapc = re.compile(".*DEVAPC\\]:\\s+")
        package, detail, utc_time, last_utc_time = (None, None, None, None)
        detail_list = []
        find_first_violation = False
        violation_line_count = 0
        unable_to_handle_kernel_paging_request_line = None
        el1_list = []
        start_record_el1 = False
        el1_done = False
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "Unable to handle kernel paging request" in line:
                    unable_to_handle_kernel_paging_request_line = line
                    continue
                if start_record_el1:
                    el1_done or el1_list.append(line)
                    if len(el1_list) == 6:
                        el1_done = True
                        continue
                if "el1_" in line:
                    if not start_record_el1:
                        el1_list.append(line)
                        start_record_el1 = True
                        continue
                regex_utc_time_rlt = re.search(regex_utc_time, line)
                if regex_utc_time_rlt:
                    utc_time = regex_utc_time_rlt.group(1)
                    continue
                regex_rlt = re.search(regex_detail_pc_is_at, line)
                if regex_rlt:
                    detail_list.append(regex_rlt.group())
                    package = regex_rlt.group(2) if not package else package + "\n" + regex_rlt.group(2)
                    if utc_time:
                        last_utc_time = last_utc_time or utc_time
                        continue
                regex_rlt = re.search(regex_detail_pc, line)
                if regex_rlt:
                    detail_list.append(regex_rlt.group())
                    package = regex_rlt.group(2) if not package else package + "\n" + regex_rlt.group(2)
                    if utc_time:
                        last_utc_time = last_utc_time or utc_time
                        continue
                    regex_rlt = re.search(regex_kernel_panic, line)
                    if regex_rlt:
                        detail_list.append(regex_rlt.group())
                        continue
                    else:
                        if not find_first_violation:
                            regex_rlt = re.search(regex_violation_start, line)
                            if regex_rlt:
                                find_first_violation = True
                                violation_line_count = 1
                                detail_list.append(regex_rlt.group(1))
                                continue
                            else:
                                if "Permission setting" in line:
                                    find_first_violation = False
                                    detail_list.append(re.sub(regex_devapc, "", line))
                                    continue
                        else:
                            if violation_line_count < 10:
                                detail_list.append(re.sub(regex_devapc, "", line))
                                violation_line_count = violation_line_count + 1
                                continue
                        find_first_violation = False

        if unable_to_handle_kernel_paging_request_line:
            el1_list = [
             unable_to_handle_kernel_paging_request_line, ""] + el1_list
        if el1_list:
            if detail_list:
                el1_list.append("")
                el1_list.extend(detail_list)
            detail_list = el1_list
        if detail_list:
            detail = "\n".join(detail_list)
        if detail:
            if "tsbat_sysrst_set_cur_state" in detail:
                detail = "tsbat_sysrst_set_cur_state"
        return (
         last_utc_time, package, detail)

    def get_last_utc_time(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Pstore__file_path))
        TEST_LOGGER.debug(("开始解析pstore文件：{}".format(self._Pstore__file_path)), tag=tne_dir_name)
        regex_utc_time = re.compile("(\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}).* UTC")
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines()[:]:
                regex_utc_time_rlt = re.search(regex_utc_time, line)
                if regex_utc_time_rlt:
                    return regex_utc_time_rlt.group(1)

        return

    def get_battery_temperature_detail(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Pstore__file_path))
        TEST_LOGGER.debug(("开始解析pstore文件：{}".format(self._Pstore__file_path)), tag=tne_dir_name)
        regex_modem_temperature = re.compile("TZ/BTSMDPA]T_btsmdpa=(\\d+)")
        regex_ap_temperature = re.compile("Thermal/TZ/BTS]T_AP=(\\d+)")
        regex_battery_temperature_mode_1 = re.compile("bat_temp=(\\d+)")
        regex_battery_temperature_mode_2 = re.compile("healthd: battery.*\\s+t=(\\d+(\\.\\d+)?).*\\s+c=(-?\\d+)")
        regex_start_time = re.compile("suspend entry\\s+(\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2})")
        regex_end_time = re.compile("suspend exit\\s+(\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2})")
        regex_adc_result = re.compile("BAT_TEMP.*adc_result=(\\d+)")
        is_temperature_problem = False
        modem_temperature_list = []
        ap_temperature_list = []
        battery_temperature_list = []
        battery_adc_list = []
        battery_ac_list = []
        suspend_entry_time = None
        suspend_exit_time = None
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "mtk_cooling_wrapper_set_cur_state" in line:
                    is_temperature_problem = True
                    continue
                regex_rlt = re.search(regex_modem_temperature, line)
                if regex_rlt:
                    modem_temperature_list.append(int(regex_rlt.group(1)) / 1000)
                    continue
                regex_rlt = re.search(regex_ap_temperature, line)
                if regex_rlt:
                    ap_temperature_list.append(int(regex_rlt.group(1)) / 1000)
                    continue
                regex_rlt = re.search(regex_adc_result, line)
                if regex_rlt:
                    battery_adc_list.append(int(regex_rlt.group(1)))
                    continue
                regex_rlt = re.search(regex_battery_temperature_mode_1, line)
                if regex_rlt:
                    battery_temperature_list.append(float(regex_rlt.group(1)))
                    continue
                regex_rlt = re.search(regex_battery_temperature_mode_2, line)
                if regex_rlt:
                    battery_temperature_list.append(float(regex_rlt.group(1)))
                    battery_ac_list.append(int(regex_rlt.group(3)))
                    continue
                if not suspend_entry_time:
                    regex_rlt = re.search(regex_start_time, line)
                    if regex_rlt:
                        suspend_entry_time = regex_rlt.group(1)
                        continue
                regex_rlt = re.search(regex_end_time, line)
                if regex_rlt:
                    suspend_exit_time = regex_rlt.group(1)
                    continue

        max_modem_temperature = -1
        modem_temperature_start = -1
        modem_temperature_end = -1
        if modem_temperature_list:
            max_modem_temperature = max(modem_temperature_list)
            modem_temperature_start = modem_temperature_list[0]
            modem_temperature_end = modem_temperature_list[-1]
        max_ap_temperature = -1
        ap_temperature_start = -1
        ap_temperature_end = -1
        if ap_temperature_list:
            max_ap_temperature = max(ap_temperature_list)
            ap_temperature_start = ap_temperature_list[0]
            ap_temperature_end = ap_temperature_list[-1]
        battery_temperature_start = -1
        battery_temperature_end = -1
        if battery_temperature_list:
            battery_temperature_start = battery_temperature_list[0]
            battery_temperature_end = battery_temperature_list[-1]
        battery_temperature_delta = battery_temperature_end - battery_temperature_start
        delta_seconds = -1
        if suspend_entry_time:
            if suspend_exit_time:
                d1 = datetime.datetime.strptime(suspend_exit_time, "%Y-%m-%d %H:%M:%S")
                d2 = datetime.datetime.strptime(suspend_entry_time, "%Y-%m-%d %H:%M:%S")
                delta = d1 - d2
                delta_seconds = delta.seconds
        min_battery_adc = -1
        if battery_adc_list:
            min_battery_adc = min(battery_adc_list)
        avg_battery_ac = -1
        if battery_ac_list:
            avg_battery_ac = mean(battery_ac_list) / 1000
        return (is_temperature_problem,
         [modem_temperature_start, modem_temperature_end, max_modem_temperature, 
          ap_temperature_start, 
          ap_temperature_end, max_ap_temperature, 
          battery_temperature_start, 
          battery_temperature_end, battery_temperature_delta, min_battery_adc, 
          avg_battery_ac, 
          suspend_entry_time, suspend_exit_time, 
          delta_seconds, suspend_exit_time])

    def get_counts_for_tne0c(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Pstore__file_path))
        TEST_LOGGER.debug(("开始解析pstore文件：{}".format(self._Pstore__file_path)), tag=tne_dir_name)
        detail_list = []
        zygote_running_list = []
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "Hang_Detect manual triger hang by developer" in line:
                    detail_list.append(line)
                if "hang_detect: zygote running" in line:
                    zygote_running_list.append(line)

        if len(zygote_running_list) > 2:
            if detail_list:
                detail_list.append("")
            detail_list.extend(zygote_running_list)
        counts_line = None
        counts_value = None
        regex_counts = re.compile("counts down (-?\\d+):(\\d+)")
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines()[:]:
                line = line.strip()
                regex_rlt = re.search(regex_counts, line)
                if regex_rlt:
                    counts_line = line
                    counts_value = int(regex_rlt.group(2))
                    break

        if counts_line:
            if detail_list:
                detail_list.append("")
            detail_list.append(counts_line)
        if counts_value:
            if counts_value == 11:
                io_wait_list = []
                with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
                    for line in f.readlines():
                        line = line.strip()
                        if not "Cpus Usage" in line:
                            if "iowait" in line:
                                pass
                            io_wait_list.append(line)

                if io_wait_list:
                    if detail_list:
                        detail_list.append("")
                    detail_list.extend(io_wait_list[-6:])
        return (
         detail_list, counts_value)

    def is_reboot(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Pstore__file_path))
        TEST_LOGGER.debug(("开始解析pstore文件：{}".format(self._Pstore__file_path)), tag=tne_dir_name)
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "Kernel_init_done" in line:
                    return True

        return False

    def check_more_than_30(self):
        tne_dir_name = os.path.basename(os.path.dirname(self._Pstore__file_path))
        TEST_LOGGER.debug(("开始解析pstore文件：{}".format(self._Pstore__file_path)), tag=tne_dir_name)
        tcpc_tcpc_list = []
        tcpc_typec_list = []
        msdc_command_resp_polling_list = []
        ff_work_handler_list = []
        more_than_30_list = []
        with open((self._Pstore__file_path), "r", encoding="utf-8", errors="ignore") as f:
            for line in f.readlines():
                line = line.strip()
                if "TCPC-TCPC" in line:
                    tcpc_tcpc_list.append(line)
                    continue
                if "TCPC-TYPEC" in line:
                    tcpc_typec_list.append(line)
                    continue
                if "msdc_command_resp_polling" in line:
                    msdc_command_resp_polling_list.append(line)
                    continue
                if "ff_work_handler" in line:
                    ff_work_handler_list.append(line)

        if len(tcpc_tcpc_list) >= 20:
            more_than_30_list.append("TCPC-TCPC more than 20")
            more_than_30_list += tcpc_tcpc_list[-3:]
        if len(tcpc_typec_list) >= 20:
            more_than_30_list.append("TCPC-TYPEC more than 20")
            more_than_30_list += tcpc_typec_list[-3:]
        if len(msdc_command_resp_polling_list) >= 20:
            more_than_30_list.append("msdc_command_resp_polling more than 20")
            more_than_30_list += more_than_30_list[-3:]
        if len(ff_work_handler_list) >= 20:
            more_than_30_list.append("ff_work_handler more than 20")
            more_than_30_list += ff_work_handler_list[-3:]
        return more_than_30_list


if __name__ == "__main__":
    ps = Pstore("D:\\log\\tne\\data\\TNE\\0xffffff0c_2023_07_14_00_17_02\\pstore0")
    ps = Pstore("D:\\log\\tne\\data\\TNE\\0xffffff0c_2023_06_17_20_30_13\\pstore0")
    line, count_number = ps.get_counts_for_tne0c()

# okay decompiling extracted_pyz_modules\modules\analyse\tne\files\pstore.pyc
