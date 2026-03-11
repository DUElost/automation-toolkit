# -*- coding: utf-8 -*-
"""
工具信息收集模块 - 已禁用网络功能
"""
from modules.common.Logger import TEST_LOGGER
from modules.common.Version import VERSION, TOOL_NAME


def query_tool_info(tool_name):
    """查询工具版本信息 - 已禁用"""
    return (None, None, None)


def post_usage_record(tool_name, start_time=None, input_user_name=None, input_user_code=None):
    """上报工具使用记录 - 已禁用"""
    pass


def is_network_connected():
    """检查网络连接 - 已禁用，始终返回False"""
    return False


def check_tool_version():
    """检查工具版本 - 已禁用网络检查"""
    TEST_LOGGER.info("工具：{} --- 当前版本：{}".format(TOOL_NAME, VERSION))
    return True
