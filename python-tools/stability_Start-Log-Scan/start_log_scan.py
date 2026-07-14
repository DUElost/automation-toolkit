# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: start_log_scan.py
import argparse, datetime, os, sys, traceback
from modules.common.GlobalAttrs import *
from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager
from modules.common.Version import VERSION, TOOL_NAME
from modules.mode.DedupOrgExcel import DedupOrgExcel
from modules.mode.MergeExcels import MergeExcels
from modules.mode.ScanAeeIndependent import ScanAeeIndependent
from modules.mode.ScanAeeMedia import ScanAeePlatformMedia
from modules.mode.ScanAeeDaily import ScanAeeDaily
from modules.mode.ScanAeeFans import ScanAeeFans
from modules.mode.ScanAeeMTBF import ScanAeeMTBF
from modules.mode.ScanAeeOTADaily import ScanAeeOTADaily
from modules.mode.ScanAeePlatform import ScanAeePlatform
from modules.mode.ScanAeeTne import ScanAeeTne
from modules.mode.ScanStuckLogo import ScanStuckLogo
from modules.mode.ScanTneUpload import ScanTneUpload
from modules.mode.ScanTneUsic import ScanTneUsic
if __name__ == "__main__":
    dedup_requested = "-dedup_org" in sys.argv
    cur_datetime = datetime.datetime.now()
    cur_datetime_formatted = cur_datetime.strftime("%Y-%m-%d %H:%M:%S")
    TEST_LOGGER.info("**************************************************")
    TEST_LOGGER.info("启动日志扫描工具 {}".format(cur_datetime_formatted))
    TEST_LOGGER.info("**************************************************\n")
    cmd_line = " ".join(sys.argv)
    TEST_LOGGER.info(f"日志扫描工具启动命令：{cmd_line}\n")
    TEST_LOGGER.info("工具：{} --- 当前版本：{}".format(TOOL_NAME, VERSION))
    parser = argparse.ArgumentParser(description="日志扫描输入参数")
    parser.add_argument("-v", "--version", dest="show_version", action="store_const", const=True, default=False, metavar="显示版本",
      help="显示工具版本")
    parser.add_argument("-debug", "--debug", dest="debug_mode", action="store_const", const=True, default=False, metavar="工具日志Debug模式", help="工具日志Debug模式")
    parser.add_argument("-del", "--delete", dest="delete_logs", action="store_const", const=True, default=False, metavar="删除不提交的log目录", help="删除不提交的log目录")
    parser.add_argument("-s", "--skip", dest="skip_extract", action="store_const", const=True, default=False, metavar="跳过解压", help="跳过所有解压步骤")
    parser.add_argument("-sz", "--skip_unzip", dest="skip_unzip", action="store_const", const=True, default=False, metavar="跳过解压", help="跳过解压zip文件")
    choices_list = [
     SCAN_MODE_AEE_TNE, SCAN_MODE_AEE, SCAN_MODE_TNE, SCAN_MODE_FANS, 
     SCAN_MODE_USIC, SCAN_MODE_PLATFORM, 
     SCAN_MODE_DAILY, SCAN_MODE_JENKINS, 
     SCAN_MODE_HWASAN, SCAN_MODE_MTBF_PLATFORM, SCAN_MODE_STUCK_LOGO, 
     SCAN_MODE_CAMERA_PLATFORM, 
     SCAN_MODE_VIDEO_PLATFORM, SCAN_MODE_SUNMAO_PLATFORM, SCAN_MODE_FREEZE, 
     SCAN_MODE_HWASAN_PLATFORM, 
     SCAN_MODE_FUZZ, SCAN_MODE_FUZZ_PLATFORM, SCAN_MODE_OTA_DAILY, SCAN_MODE_INDEPENDENT, 
     SCAN_MODE_DAEMON_CRASH, SCAN_MODE_SUBSYSTEM_CRASH, SCAN_MODE_UPLOAD_TNE]
    parser.add_argument("-m", "--mode", dest="scan_mode", metavar="扫描模式", type=int, choices=choices_list, default=0,
      nargs="?",
      help="0：Aee & Tne | 1：Aee | 2：Tne | 3：Fans | 4：Usic | 5：Platform Monkey | 6：Daily | 7：Jenkins | 8：HWAsan | 9：Platform MTBF | 10：StuckLogo | 11：Platform Camera | 12：Platform Video | 13：Platform Sunmao | 14：Freeze | 15：Platform HWASan | 16：Fuzz | 17：Platform Fuzz | 18：OTA Daily | 19：INDEPENDENT | 20：DAEMON CRASH | 21：SUBSYSTEM CRASH | 22：UPLOAD TNE")
    parser.add_argument("-b", "--before", dest="days_before", metavar="指定扫描往前第?天的日志", type=int, default=(-1), nargs="?",
      help="扫描现在开始往前第几天的日志，默认-1：扫描所有的日志")
    parser.add_argument("-d", "--dir", dest="scan_root_dir", metavar="待扫描日志根目录", type=str, default=None, help="待扫描日志根目录")
    parser.add_argument("-d_abs", "--dir_abs", dest="scan_root_dir_abs", metavar="待扫描日志根目录(绝对路径)", type=str, default=None, help="待扫描日志根目录(绝对路径)")
    parser.add_argument("-p", "--place", dest="place", metavar="扫描日志归属地", type=str, default="SH", help="扫描日志归属地")
    parser.add_argument("-nas", dest="nas_address", metavar="日志存放NAS的IP地址", type=str, default=None, nargs="?", help="日志存放NAS的IP地址")
    parser.add_argument("-tag", dest="task_tag", metavar="任务的Tag", type=str, default=None, nargs="?", help="任务的Tag，用于标识读取本地配置选项")
    parser.add_argument("-sbp", dest="special_build_prefix", metavar="Excel中版本需要添加的前缀", type=str, default=None, nargs="?", help="Excel中版本需要添加的前缀")
    parser.add_argument("-pipeline", dest="pipeline_id", metavar="平台任务的pipeline id", type=str, default=None, nargs="?", help="平台执行任务的pipeline id")
    parser.add_argument("-uuid", dest="uuid", metavar="平台任务的uuid", type=str, default=None, nargs="?", help="平台任务的uuid")
    parser.add_argument("-end", dest="end_of_scan", action="store_const", const=True, default=False, metavar="是否是最后一次扫描",
      help="是否是最后一次扫描")
    parser.add_argument("-start_time", dest="start_time", metavar="Monkey 测试开始时间", type=str, default=None, nargs="?", help="Monkey测试的开始时间")
    parser.add_argument("-device_count", dest="device_count", metavar="Monkey 测试设备数", type=int, default=0, nargs="?", help="Monkey 测试设备数")
    parser.add_argument("-android", dest="android", metavar="目标安卓版本：P，Q，R，S...", type=str, default=None, nargs="?", help="目标安卓版本：P，Q，R，S...")
    parser.add_argument("-project", dest="project", metavar="基线Monkey，触发的测试项目", type=str, default=None, nargs="?", help="基线Monkey，触发的测试项目")
    parser.add_argument("-build", dest="build", metavar="基线Monkey，触发的测试版本", type=str, default=None, nargs="?", help="基线Monkey，触发的测试版本")
    parser.add_argument("-device_list", dest="device_list", metavar="多媒体Monkey测试，扫描手机SN列表", type=str, default=None, nargs="?", help="多媒体Monkey测试，扫描手机SN列表")
    parser.add_argument("-reporter", dest="reporter", metavar="指定问题提交人员", type=str, default=None, nargs="?", help="指定问题提交人员")
    parser.add_argument("-tcid", dest="utp_tcid", metavar="UTP平台tcid", type=str, default=None, nargs="?", help="UTP平台tcid")
    parser.add_argument("-taskid", dest="utp_taskid", metavar="UTP平台taskId", type=str, default=None, nargs="?", help="UTP平台taskId")
    parser.add_argument("-trunk_branch", dest="trunk_branch", metavar="基线Monkey，触发测试的基线分支名", type=str, default=None, nargs="?", help="基线Monkey，触发测试的基线分支名")
    parser.add_argument("-merge_factory", dest="merge_factory", metavar="合并Excel文件存放目录，工厂专用", type=str, default=None, nargs="+", help="合并Excel文件，待合并文件夹目录，工厂专用")
    parser.add_argument("-merge", dest="merge_excel_dir", metavar="合并Excel文件存放目录", type=str, default=None, nargs="+", help="合并Excel文件，待合并文件夹目录")
    parser.add_argument("-merge_key", dest="merge_key", metavar="过滤待合并文件名关键字", type=str, default=None, nargs="?", help="过滤待合并文件名关键字")
    parser.add_argument("-side", dest="merge_side", metavar="合并Excel文件归属地", type=str, default="shanghai", nargs="?", help="合并Excel文件归属地：shanghai / factory")
    parser.add_argument("-limit", dest="limit_dbg_count", metavar="最大解析dbg数", type=int, default=0, nargs="?", help="最大解析dbg文件数，0为不限制")
    parser.add_argument("-dedup_org", dest="dedup_org", metavar="离线去重_org.xls路径", type=str, default=None, nargs="?", const="", help="离线去重指定的_org.xls文件")
    parser.add_argument("-merge_priority", "--merge_priority", dest="merge_priority", action="store_const", const=True, default=False, metavar="是否判断优先级",
      help="是否判断优先级")
    parser.add_argument("-merge_files", dest="merge_files", metavar="合并多个已生成的xls文件", type=str, default=None, nargs="+", help="合并多个已生成的xls结果文件（_org.xls或final.xls），去重汇总输出")
    parser.add_argument("-merge_files_list", dest="merge_files_list", metavar="文件列表路径（一行一个xls）", type=str, default=None, nargs="?", help="从文件读取待合并的xls路径列表（一行一个），适用于大量文件命令行超长场景")
    try:
        args = parser.parse_args()
        show_version = args.show_version
        if show_version:
            sys.exit(0)
        if args.debug_mode:
            TEST_LOGGER.setDebugMode()
        if args.dedup_org is not None:
            if not args.dedup_org:
                TEST_LOGGER.error("-dedup_org 缺少_org.xls文件路径，退出离线去重")
                sys.exit(1)
            try:
                output_path = DedupOrgExcel(args.dedup_org, args.merge_side).run()
            except SystemExit:
                raise
            except:
                TEST_LOGGER.error("离线 org 去重执行失败：\n{}".format(traceback.format_exc()))
                sys.exit(1)

            print(output_path)
            sys.exit(0)
        scan_mode = args.scan_mode
        if not os.path.isdir(PathManager.tmp_folder):
            try:
                os.makedirs(PathManager.tmp_folder)
            except:
                pass

        merge_files = args.merge_files
        if args.merge_files_list:
            with open(args.merge_files_list, encoding="utf-8") as _f:
                _list_entries = [line.strip() for line in _f if line.strip()]
            merge_files = (merge_files or []) + _list_entries
        merge_factory = args.merge_factory
        merge_excel_dir_list = args.merge_excel_dir
        merge_side = args.merge_side
        merge_key = args.merge_key
        merge_priority = args.merge_priority
        merge_excels = None
        if merge_files:
            TEST_LOGGER.info("合并多个已生成的Excel文件，文件列表：{}，归属地：{}".format(merge_files, merge_side))
            merge_excels = MergeExcels(merge_files, merge_side, "", SCAN_MODE_AEE, priority=merge_priority)
            try:
                merge_excels.start_merge_files(merge_files)
            except:
                exception_file = PathManager.log_folder + os.sep + datetime.datetime.now().strftime("merge_exception_%Y_%m_%d_%H_%M_%S.txt")
                with open(exception_file, "w", encoding="utf-8", errors="ignore") as f:
                    f.write("Version:{}\n\n".format(VERSION))
                    f.write(traceback.format_exc())
                traceback.print_exc()
            sys.exit()
        if merge_factory:
            TEST_LOGGER.info("合并扫描结果Excel文件，merge_factory模式：{}，合并关键字：{}".format(merge_factory, merge_key))
            merge_excels = MergeExcels(merge_factory, "factory", merge_key, scan_mode, True, priority=merge_priority)
        else:
            if merge_excel_dir_list:
                TEST_LOGGER.info("合并扫描结果Excel文件，文件存放目录：{}，文件归属地：{}, 合并关键字：{}".format(merge_excel_dir_list, merge_side, merge_key))
                merge_excels = MergeExcels(merge_excel_dir_list, merge_side, merge_key, scan_mode, priority=merge_priority)
            if merge_excels:
                try:
                    merge_excels.start_merge()
                except:
                    exception_file = PathManager.log_folder + os.sep + datetime.datetime.now().strftime("merge_exception_%Y_%m_%d_%H_%M_%S.txt")
                    with open(exception_file, "w", encoding="utf-8", errors="ignore") as f:
                        f.write("Version:{}\n\n".format(VERSION))
                        f.write(traceback.format_exc())
                    traceback.print_exc()

                sys.exit()
            skip_extract = args.skip_extract
            skip_unzip = args.skip_unzip
            delete_logs = args.delete_logs
            days_before = args.days_before
            scan_root_dir = args.scan_root_dir
            scan_root_dir_abs = args.scan_root_dir_abs
            scan_place = args.place.upper()
            special_build_prefix = args.special_build_prefix
            nas_address = args.nas_address
            pipeline_id = args.pipeline_id
            uuid = args.uuid
            task_tag = args.task_tag
            end_of_scan = args.end_of_scan
            start_time = args.start_time
            if start_time:
                start_time = start_time.strip('"')
            device_count = args.device_count
            android = args.android
            trunk_branch = args.trunk_branch
            project = args.project
            build = args.build
            device_list = args.device_list
            reporter = args.reporter
            utp_tcid = args.utp_tcid
            utp_taskid = args.utp_taskid
            limit_dbg_count = args.limit_dbg_count
            TEST_LOGGER.info("获取输入参数：")
            TEST_LOGGER.info("-del [删除不提交日志目录]：{}".format(delete_logs))
            TEST_LOGGER.info("-s [跳过所有解压步骤]：{}".format(skip_extract))
            TEST_LOGGER.info("-sz [跳过解压zip文件]：{}".format(skip_unzip))
            TEST_LOGGER.info("-m [扫描模式]：{}".format(scan_mode))
            TEST_LOGGER.info("-b [指定日期]：{}".format(days_before))
            TEST_LOGGER.info("-d [扫描目录]：{}".format(scan_root_dir))
            TEST_LOGGER.info("-p [扫描地点]：{}".format(scan_place))
            TEST_LOGGER.info("-sbp [特殊版本前缀]：{}".format(special_build_prefix))
            TEST_LOGGER.info("-nas [NAS的IP地址]：{}".format(nas_address))
            TEST_LOGGER.info("-pipeline [平台任务 pipeline id]：{}".format(pipeline_id))
            TEST_LOGGER.info("-uuid [平台任务 uuid]：{}".format(uuid))
            TEST_LOGGER.info("-tag [任务标签]：{}".format(task_tag))
            TEST_LOGGER.info("-end [是否最后一次每日扫描]：{}".format(end_of_scan))
            TEST_LOGGER.info("-start_time [monkey测试开始时间]：{}".format(start_time))
            TEST_LOGGER.info("-device_count [测试设备数]：{}".format(device_count))
            TEST_LOGGER.info("-android [安卓版本]：{}".format(android))
            TEST_LOGGER.info("-trunk_branch [基线分支 trunk_branch]：{}".format(trunk_branch))
            TEST_LOGGER.info("-project [项目 project]：{}".format(project))
            TEST_LOGGER.info("-build [版本 build]：{}".format(build))
            TEST_LOGGER.info(f"-device_list [测试手机列表 device_list]：{device_list}")
            TEST_LOGGER.info(f"-reporter [问题提交人员 reporter]：{reporter}")
            TEST_LOGGER.info(f"-tcid [UTP平台测试例ID tcid]：{utp_tcid}")
            TEST_LOGGER.info(f"-taskid [UTP平台任务ID taskid]：{utp_taskid}")
            TEST_LOGGER.info("-limit [最大解析dbg数]：{}".format(limit_dbg_count))
    except SystemExit as e:
        if dedup_requested:
            raise
        sys.exit(0)
    except:
        TEST_LOGGER.warn(f"参数解析异常：\n{traceback.format_exc()}")
        if dedup_requested:
            sys.exit(1)
        if len(sys.argv) == 2 and sys.argv[1] != "-v":
            scan_root_dir = sys.argv[1]
            if not os.path.isdir(scan_root_dir):
                TEST_LOGGER.error("扫描目录：{} 不存在，退出扫描！".format(scan_root_dir))
                sys.exit(0)
            scan_mode = SCAN_MODE_AEE
            scan_place = "SH"
            days_before = -1
            skip_extract = False
            skip_unzip = False
            nas_address = None
            task_tag = None
            special_build_prefix = False
            delete_logs = False
            TEST_LOGGER.info("默认扫描模式：0，扫描路径：{}".format(scan_root_dir))
        else:
            sys.exit(0)

    if scan_mode in [SCAN_MODE_DAILY, SCAN_MODE_FANS, SCAN_MODE_USIC, SCAN_MODE_STUCK_LOGO, SCAN_MODE_PLATFORM, 
     SCAN_MODE_MTBF_PLATFORM, SCAN_MODE_CAMERA_PLATFORM, SCAN_MODE_VIDEO_PLATFORM, 
     SCAN_MODE_SUNMAO_PLATFORM, SCAN_MODE_FREEZE, SCAN_MODE_HWASAN_PLATFORM, 
     SCAN_MODE_OTA_DAILY, SCAN_MODE_DAEMON_CRASH, SCAN_MODE_SUBSYSTEM_CRASH, 
     SCAN_MODE_UPLOAD_TNE]:
        if days_before < 0:
            TEST_LOGGER.info("粉丝模式，Tne Usic，Freeze，aee平台每日扫描和OTA扫描，不支持扫描所有日志，默认扫描日期设置为前一天，days_before 设置为：1")
            days_before = 1 if days_before < 0 else days_before
    cur_tool_dir = os.path.abspath(os.path.curdir)
    TEST_LOGGER.info("工具当前目录：{}\n".format(cur_tool_dir))
    if scan_mode in [SCAN_MODE_AEE_TNE, SCAN_MODE_AEE, SCAN_MODE_TNE, SCAN_MODE_JENKINS, SCAN_MODE_HWASAN, 
     SCAN_MODE_FUZZ]:
        scanner = ScanAeeTne(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, nas_address, task_tag, special_build_prefix, delete_logs, limit_dbg_count=limit_dbg_count)
        loggerName = datetime.datetime.now().strftime("LogScanAeeTne_%Y_%m_%d_%H_%M_%S.log")
        loggerPath = os.path.join(PathManager.log_folder, loggerName)
        TEST_LOGGER.resetLogFile(loggerPath)
        TEST_LOGGER.info("**************************************************")
        TEST_LOGGER.info("开始日志扫描 ScanAeeTne {}".format(cur_datetime_formatted))
        TEST_LOGGER.info("**************************************************\n")
    else:
        if scan_mode == SCAN_MODE_FANS:
            scanner = ScanAeeFans(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
            loggerName = datetime.datetime.now().strftime("LogScanFans_%Y_%m_%d.log")
            loggerPath = os.path.join(PathManager.log_folder, loggerName)
            TEST_LOGGER.resetLogFile(loggerPath)
            TEST_LOGGER.info("**************************************************")
            TEST_LOGGER.info("开始日志扫描 ScanAeeFans {}".format(cur_datetime_formatted))
            TEST_LOGGER.info("**************************************************\n")
        else:
            if scan_mode == SCAN_MODE_USIC:
                scanner = ScanTneUsic(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                loggerName = datetime.datetime.now().strftime("LogScanUsic_%Y_%m_%d.log")
                loggerPath = os.path.join(PathManager.log_folder, loggerName)
                TEST_LOGGER.resetLogFile(loggerPath)
                TEST_LOGGER.info("**************************************************")
                TEST_LOGGER.info("开始日志扫描 ScanTneUsic {}".format(cur_datetime_formatted))
                TEST_LOGGER.info("**************************************************\n")
            else:
                if scan_mode == SCAN_MODE_FREEZE:
                    scanner = ScanTneUsic(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                    loggerName = datetime.datetime.now().strftime("LogScanFreeze_%Y_%m_%d.log")
                    loggerPath = os.path.join(PathManager.log_folder, loggerName)
                    TEST_LOGGER.resetLogFile(loggerPath)
                    TEST_LOGGER.info("**************************************************")
                    TEST_LOGGER.info("开始日志扫描 ScanTneFreeze {}".format(cur_datetime_formatted))
                    TEST_LOGGER.info("**************************************************\n")
                else:
                    if scan_mode == SCAN_MODE_DAEMON_CRASH:
                        scanner = ScanTneUsic(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                        loggerName = datetime.datetime.now().strftime("LogScanDaemonCrash_%Y_%m_%d.log")
                        loggerPath = os.path.join(PathManager.log_folder, loggerName)
                        TEST_LOGGER.resetLogFile(loggerPath)
                        TEST_LOGGER.info("**************************************************")
                        TEST_LOGGER.info("开始日志扫描 ScanTneDaemonCrash {}".format(cur_datetime_formatted))
                        TEST_LOGGER.info("**************************************************\n")
                    else:
                        if scan_mode == SCAN_MODE_SUBSYSTEM_CRASH:
                            scanner = ScanTneUsic(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                            loggerName = datetime.datetime.now().strftime("LogScanSubsystemCrash_%Y_%m_%d.log")
                            loggerPath = os.path.join(PathManager.log_folder, loggerName)
                            TEST_LOGGER.resetLogFile(loggerPath)
                            TEST_LOGGER.info("**************************************************")
                            TEST_LOGGER.info("开始日志扫描 ScanTneSubsystemCrash {}".format(cur_datetime_formatted))
                            TEST_LOGGER.info("**************************************************\n")
                        else:
                            if scan_mode == SCAN_MODE_STUCK_LOGO:
                                scanner = ScanStuckLogo(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                                loggerName = datetime.datetime.now().strftime("LogScanStuckLogo_%Y_%m_%d.log")
                                loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                TEST_LOGGER.resetLogFile(loggerPath)
                                TEST_LOGGER.info("**************************************************")
                                TEST_LOGGER.info("开始日志扫描 ScanStuckLogo {}".format(cur_datetime_formatted))
                                TEST_LOGGER.info("**************************************************\n")
                            else:
                                if scan_mode in [SCAN_MODE_PLATFORM, SCAN_MODE_SUNMAO_PLATFORM, SCAN_MODE_HWASAN_PLATFORM, SCAN_MODE_FUZZ_PLATFORM]:
                                    scanner = ScanAeePlatform(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, nas_address, task_tag, pipeline_id, uuid, end_of_scan, start_time, device_count, trunk_branch, project, build, android, utp_tcid, utp_taskid, scan_root_dir_abs)
                                    if scan_mode == SCAN_MODE_SUNMAO_PLATFORM:
                                        loggerName = datetime.datetime.now().strftime(f"LogScanPlatformSunmao_{pipeline_id}_%Y%m%d_%H%M%S_%f.log")
                                    else:
                                        if scan_mode == SCAN_MODE_HWASAN_PLATFORM:
                                            loggerName = datetime.datetime.now().strftime(f"LogScanPlatformHwasan_{pipeline_id}_%Y%m%d_%H%M%S_%f.log")
                                        else:
                                            if scan_mode == SCAN_MODE_FUZZ_PLATFORM:
                                                loggerName = datetime.datetime.now().strftime(f"LogScanPlatformFuzz_{pipeline_id}_%Y%m%d_%H%M%S_%f.log")
                                            else:
                                                loggerName = datetime.datetime.now().strftime(f"LogScanPlatformAee_{pipeline_id}_%Y%m%d_%H%M%S_%f.log")
                                    loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                    TEST_LOGGER.resetLogFile(loggerPath)
                                    TEST_LOGGER.info("**************************************************")
                                    TEST_LOGGER.info("开始日志扫描 ScanAeePlatform {}".format(cur_datetime_formatted))
                                    TEST_LOGGER.info("**************************************************\n")
                                else:
                                    if scan_mode in [SCAN_MODE_CAMERA_PLATFORM, SCAN_MODE_VIDEO_PLATFORM]:
                                        scanner = ScanAeePlatformMedia(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, nas_address, task_tag, pipeline_id, uuid, end_of_scan, start_time, device_count, project, build, android, device_list, reporter, utp_tcid, utp_taskid)
                                        loggerName = datetime.datetime.now().strftime(f"LogScanPlatformMedia_{pipeline_id}_%Y%m%d_%H%M%S_%f.log")
                                        loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                        TEST_LOGGER.resetLogFile(loggerPath)
                                        TEST_LOGGER.info("**************************************************")
                                        TEST_LOGGER.info("开始日志扫描 ScanAeePlatformCamera {}".format(cur_datetime_formatted))
                                        TEST_LOGGER.info("**************************************************\n")
                                    else:
                                        if scan_mode == SCAN_MODE_DAILY:
                                            scanner = ScanAeeDaily(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, task_tag)
                                            loggerName = datetime.datetime.now().strftime("LogScanDaily_%Y_%m_%d.log")
                                            loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                            TEST_LOGGER.resetLogFile(loggerPath)
                                            TEST_LOGGER.info("**************************************************")
                                            TEST_LOGGER.info("开始日志扫描 ScanAeeDaily {}".format(cur_datetime_formatted))
                                            TEST_LOGGER.info("**************************************************\n")
                                        else:
                                            if scan_mode == SCAN_MODE_MTBF_PLATFORM:
                                                scanner = ScanAeeMTBF(scan_mode, scan_place, scan_root_dir, cur_tool_dir, nas_address, pipeline_id, uuid, end_of_scan, project, build, utp_tcid, utp_taskid)
                                                loggerName = datetime.datetime.now().strftime(f"LogScanMTBF_{pipeline_id}_%Y%m%d_%H%M%S_%f.log")
                                                loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                                TEST_LOGGER.resetLogFile(loggerPath)
                                                TEST_LOGGER.info("**************************************************")
                                                TEST_LOGGER.info("开始日志扫描 ScanAeeMTBF {}".format(cur_datetime_formatted))
                                                TEST_LOGGER.info("**************************************************\n")
                                            else:
                                                if scan_mode == SCAN_MODE_OTA_DAILY:
                                                    scanner = ScanAeeOTADaily(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                                                    loggerName = datetime.datetime.now().strftime("LogScanOtaDaily_%Y_%m_%d.log")
                                                    loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                                    TEST_LOGGER.resetLogFile(loggerPath)
                                                    TEST_LOGGER.info("**************************************************")
                                                    TEST_LOGGER.info("开始日志扫描 ScanAeeOtaDaily {}".format(cur_datetime_formatted))
                                                    TEST_LOGGER.info("**************************************************\n")
                                                else:
                                                    if scan_mode == SCAN_MODE_INDEPENDENT:
                                                        scanner = ScanAeeIndependent(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip, nas_address, task_tag, delete_logs)
                                                        loggerName = datetime.datetime.now().strftime("LogScanIndependent_%Y%m%d_%H%M%S_%f.log")
                                                        loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                                        TEST_LOGGER.resetLogFile(loggerPath)
                                                        TEST_LOGGER.info("**************************************************")
                                                        TEST_LOGGER.info("开始日志扫描 ScanAeeIndependent {}".format(cur_datetime_formatted))
                                                        TEST_LOGGER.info("**************************************************\n")
                                                    else:
                                                        if scan_mode == SCAN_MODE_UPLOAD_TNE:
                                                            scanner = ScanTneUpload(scan_mode, scan_place, days_before, scan_root_dir, cur_tool_dir, skip_extract, skip_unzip)
                                                            loggerName = datetime.datetime.now().strftime("LogScanUploadTne_%Y_%m_%d.log")
                                                            loggerPath = os.path.join(PathManager.log_folder, loggerName)
                                                            TEST_LOGGER.resetLogFile(loggerPath)
                                                            TEST_LOGGER.info("**************************************************")
                                                            TEST_LOGGER.info("开始日志扫描 ScanTneUpload {}".format(cur_datetime_formatted))
                                                            TEST_LOGGER.info("**************************************************\n")
    
    # 执行扫描
    # 执行扫描
    start_time = datetime.datetime.now()
    try:
        scanner.start_scan()
    except:
        crash_msg = traceback.format_exc()
        TEST_LOGGER.critical("解析过程发生异常崩溃：\n{}".format(crash_msg))
        exception_file = PathManager.log_folder + os.sep + datetime.datetime.now().strftime("exception_%Y_%m_%d_%H_%M_%S.txt")
        with open(exception_file, "w", encoding="utf-8", errors="ignore") as f:
            f.write("Version:{}\n\n".format(VERSION))
            f.write(crash_msg)
    
    TEST_LOGGER.info("扫描完成")
