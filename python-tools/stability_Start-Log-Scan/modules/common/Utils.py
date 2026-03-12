# -*- coding: utf-8 -*-
"""
工具函数模块 - 已禁用网络上报功能
"""
import difflib
import hashlib
import os
import platform
import random
import re
import shutil
import smtplib
import string
import subprocess
import time
import traceback
import zipfile
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from modules.common.Logger import TEST_LOGGER
from modules.common.Path import PathManager

# 邮件配置
MAIL_SMTP_SERVER = "smtp.transsion.com"
MAIL_SMTP_PORT = 587
MAIL_SENDER = "log_scan@transsion.com"
MAIL_PASSWD = "LogScan@2021"

# 微服务地址（已禁用）
MICROSERVICE_SERVER = "10.204.124.213"


def random_str(digits=True, lowercase=True, uppercase=True, symbol=True, slen=10):
    """生成随机字符串"""
    seed = ""
    seed = seed + "1234567890" if digits else seed + ""
    seed = seed + "abcdefghijklmnopqrstuvwxyz" if lowercase else seed + ""
    seed = seed + "ABCDEFGHIJKLMNOPQRSTUVWXYZ" if uppercase else seed + ""
    seed = seed + "!@#$%^&*()_+-=[]{}|;':\",./<>?" if symbol else seed + ""
    if not seed:
        seed = "abcdefghijklmnopqrstuvwxyz"
    return ''.join(random.choices(seed, k=slen))


def unzip(zip_file, extract_dir):
    """解压zip文件"""
    try:
        with zipfile.ZipFile(zip_file, 'r') as zf:
            zf.extractall(extract_dir)
        return True
    except Exception as e:
        TEST_LOGGER.error(f"解压文件失败: {zip_file}, 错误: {e}")
        return False


def aee_extract(aee_extract_tool, dbg_file, timeout=300):
    """使用 aee_extract 工具解压 dbg 文件"""
    try:
        extract_dir = os.path.dirname(dbg_file)
        cmd = [aee_extract_tool, dbg_file]
        result = subprocess.run(cmd, cwd=extract_dir, capture_output=True, timeout=timeout)
        if result.returncode == 0:
            return None
        else:
            TEST_LOGGER.error(f"aee_extract 解压: {dbg_file}, returncode: {result.returncode}")
            return {"dbg_file": dbg_file, "reason_code": "extract_returncode_nonzero", "detail": f"returncode={result.returncode}"}
    except subprocess.TimeoutExpired:
        TEST_LOGGER.error(f"aee_extract 解压超时: {dbg_file}")
        return {"dbg_file": dbg_file, "reason_code": "extract_timeout"}
    except Exception as e:
        TEST_LOGGER.error(f"aee_extract 解压异常: {dbg_file}, 错误: {e}")
        return {"dbg_file": dbg_file, "reason_code": "extract_exception", "detail": str(e)}


def decompress_tne(tne_decompress_tool, tne_file):
    """使用 tne_decompress 工具解压 tne 文件"""
    try:
        extract_dir = os.path.dirname(tne_file)
        cmd = [tne_decompress_tool, tne_file]
        result = subprocess.run(cmd, cwd=extract_dir, capture_output=True, timeout=300)
        if result.returncode == 0:
            return None
        else:
            TEST_LOGGER.error(f"decompress_tne 解压失败: {tne_file}, returncode: {result.returncode}")
            return tne_file
    except subprocess.TimeoutExpired:
        TEST_LOGGER.error(f"decompress_tne 解压超时: {tne_file}")
        return tne_file
    except Exception as e:
        TEST_LOGGER.error(f"decompress_tne 解压异常: {tne_file}, 错误: {e}")
        return tne_file


def extract_expdb(expdb_file, extract_dir):
    """解压expdb文件"""
    return unzip(expdb_file, extract_dir)


def ignore_num_hex_string(input_str):
    """忽略字符串中的数字和十六进制"""
    if not input_str:
        return ""
    result = re.sub(r'0x[a-fA-F0-9]+', '', input_str)
    result = re.sub(r'\d+', '', result)
    return result


def get_mixed_md5(serial_num):
    """生成混合MD5"""
    mixed_str = serial_num + "df71a11f-3c54-46a9-8302-7e5c055be238"
    encrypted_str = hashlib.md5(mixed_str.encode("utf-8")).hexdigest()
    return encrypted_str


def delete_mtklog_dir(exp_main_path):
    """删除mtklog目录"""
    regex_mtklog_dir = re.compile(r".*mtklog.*exception")
    regex_rlt = re.match(regex_mtklog_dir, exp_main_path)
    if regex_rlt:
        mktlog_dir_path = regex_rlt.group()
        if os.path.isdir(mktlog_dir_path):
            try:
                shutil.rmtree(mktlog_dir_path)
                return True
            except:
                return False
    return False


def walk_with_max_depth(topdir, max_depth):
    """带最大深度的目录遍历"""
    for root, dirs, files in os.walk(topdir):
        depth = root[len(topdir) + len(os.path.sep):].count(os.path.sep)
        if depth < max_depth:
            yield root, dirs, files
        else:
            del dirs[:]


def get_str_similar(str_1, str_2, format_str=True, absolute_equal=False):
    """计算两个字符串的相似度"""
    if absolute_equal:
        return 100 if str_1 == str_2 else 0
    
    if "*** sprd minidump ke ***" in str_1 and "*** sprd minidump ke ***" in str_2:
        if "exception_reboot_reason: kernel_crash" in str_1 and "exception_reboot_reason: kernel_crash" in str_2:
            return 100 if str_1 == str_2 else 0
        return 0
    
    if "*** sprd minidump ke ***" in str_1 or "*** sprd minidump ke ***" in str_2:
        return 0
    
    if format_str:
        str_1 = re.sub(r'0x[a-zA-Z0-9]+', '', str_1)
        str_2 = re.sub(r'0x[a-zA-Z0-9]+', '', str_2)
        str_1 = re.sub(r'@[a-zA-Z0-9]+', '', str_1)
        str_2 = re.sub(r'@[a-zA-Z0-9]+', '', str_2)
        str_1 = re.sub(r'\d', '', str_1)
        str_2 = re.sub(r'\d', '', str_2)
    
    ratio = difflib.SequenceMatcher(None, str_1, str_2).quick_ratio() * 100
    return ratio


def is_network_connected():
    """检查网络连接 - 已禁用，始终返回False"""
    TEST_LOGGER.info("网络功能已禁用")
    return False


def sendMail(subject, content, mail_receivers):
    """发送邮件 - 已禁用"""
    TEST_LOGGER.info(f"邮件发送功能已禁用，主题: {subject}")
    pass


def send_msg_by_feishu_robot(msg_title, msg_content, msg_header=None):
    """发送飞书机器人消息 - 已禁用"""
    TEST_LOGGER.info(f"飞书通知功能已禁用，标题: {msg_title}")
    pass


def send_monkey_rlt_by_feishu_robot(msg_title, msg_content, msg_header=None):
    """发送Monkey结果到飞书 - 已禁用"""
    TEST_LOGGER.info(f"飞书通知功能已禁用，标题: {msg_title}")
    pass


def send_jira_request(submit_url, submit_excel, ignore_components=None, jira_project_name=None, 
                      monkey_type=None, log_smb_username=None, log_smb_password=None, jira_server=None):
    """发送Jira提交请求 - 已禁用"""
    TEST_LOGGER.info(f"Jira提交功能已禁用，文件: {submit_excel}")
    pass


def insert_monkey_data(aee_rlt_list_final, table_name):
    """插入Monkey数据 - 已禁用"""
    TEST_LOGGER.info(f"数据上报功能已禁用，表名: {table_name}")
    pass


def insert_monkey_data_org(aee_rlt_list_org, table_name):
    """插入原始Monkey数据 - 已禁用"""
    TEST_LOGGER.info(f"数据上报功能已禁用，表名: {table_name}")
    pass


def post_hardware_marked(hardware_marked_dict=None):
    """上报硬件标记 - 已禁用"""
    TEST_LOGGER.info("硬件标记上报功能已禁用")
    pass


def get_report_history_online():
    """获取在线历史记录 - 已禁用，返回空列表"""
    TEST_LOGGER.info("在线历史记录获取功能已禁用")
    return []


def post_report_history(package_name):
    """保存历史记录 - 已禁用"""
    TEST_LOGGER.info(f"历史记录保存功能已禁用，包名: {package_name}")
    pass


def get_jira_project_online(project_name):
    """获取Jira项目信息 - 已禁用"""
    TEST_LOGGER.info(f"Jira项目查询功能已禁用，项目: {project_name}")
    return False, None


def get_package_white_list_online(get_url=None):
    """获取包白名单 - 已禁用，返回空列表"""
    TEST_LOGGER.info("包白名单获取功能已禁用")
    return False, []


def get_monkey_blacklist_online(get_url=None):
    """获取Monkey黑名单 - 已禁用，返回空列表"""
    TEST_LOGGER.info("Monkey黑名单获取功能已禁用")
    return False, []


def get_freeze_version_from_feishu():
    """从飞书获取Freeze版本 - 已禁用，返回空字典"""
    TEST_LOGGER.info("飞书文档读取功能已禁用")
    return {}


def get_top_app_list_from_feishu():
    """从飞书获取Top App列表 - 已禁用，返回空列表"""
    TEST_LOGGER.info("飞书文档读取功能已禁用")
    return []


def get_tne_tag_info_from_feishu():
    """从飞书获取TNE标签信息 - 已禁用，返回默认值"""
    TEST_LOGGER.info("飞书文档读取功能已禁用")
    return {}, [], [], [], []


def check_dns():
    """检查DNS - 已禁用"""
    return False
