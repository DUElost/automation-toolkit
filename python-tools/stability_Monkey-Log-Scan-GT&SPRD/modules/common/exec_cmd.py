# -*- coding: utf-8 -*-
# @Time     : 2020/10/14 10:48
# @Author   : yunqing.gui
# @Email    : yunqing.gui@transsion.com
# @File     : exec_cmd.py

import tempfile
import subprocess
from modules.common.logger import TEST_LOGGER


def exec_cmd(cmdline, timeout=60):
    out_temp = tempfile.SpooledTemporaryFile(10 * 1000)
    fileno = out_temp.fileno()
    try:
        process = subprocess.Popen(cmdline, stdout=fileno, stderr=fileno, shell=False)
        process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        TEST_LOGGER.warn("执行命令：" + str(cmdline) + " 超时！！", tag="exec_cmd")
    finally:
        try:
            process.kill()
        except:
            pass
    out_temp.seek(0)
    rlt = out_temp.readlines()
    out_temp.close()
    return rlt


def execute_cmd_infinite(cmdline, timeout=15, maxTry=10, curTry=1):
    out_temp = tempfile.SpooledTemporaryFile(10 * 1000)
    fileno = out_temp.fileno()
    try:
        process = subprocess.Popen(cmdline, stdout=fileno, stderr=fileno, shell=False)
        process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        TEST_LOGGER.warn("执行命令：" + str(cmdline) + " 超时！！ 已执行[{}]次".format(curTry), tag="exec_cmd")
        out_temp.close()
        try:
            process.kill()
        except:
            pass
        if curTry < maxTry:
            curTry = curTry + 1
            TEST_LOGGER.warn("执行命令：" + str(cmdline) + " 未达最大值，尝试再次执行第[{}]次！".format(curTry), tag="exec_cmd")
            return execute_cmd_infinite(cmdline, timeout=timeout, maxTry=maxTry, curTry=curTry)
        else:
            TEST_LOGGER.error("执行命令：" + str(cmdline) + " 已打最大失败次数:[{}]，退出执行！".format(maxTry), tag="exec_cmd")
            return False, None
    out_temp.seek(0)
    rlt = out_temp.readlines()
    out_temp.close()
    try:
        process.kill()
    except:
        pass
    return True, rlt


def execute_cmd_kill(cmdline, force_stop_cmdline):
    out_temp = tempfile.SpooledTemporaryFile(100 * 1000)
    fileno = out_temp.fileno()
    try:
        process = subprocess.Popen(cmdline, stdout=fileno, stderr=fileno, shell=False)
        process.communicate(timeout=30)
    except subprocess.TimeoutExpired:
        TEST_LOGGER.warn("执行命令：" + str(cmdline) + " 超时！！", tag="exec_cmd")
        try:
            process.kill()
        finally:
            exec_cmd(force_stop_cmdline)
    out_temp.seek(0)
    rlt = out_temp.readlines()
    out_temp.close()
    return rlt


def cmd_exec_and_save(cmdline, result_file, timeout=30):
    o_file = open(result_file, "w")
    process = subprocess.Popen(cmdline, stdout=o_file, stderr=o_file, shell=False)
    if timeout is None:
        process.communicate()
        try:
            process.kill()
        except:
            pass
    else:
        try:
            process.communicate(timeout=timeout)
        except subprocess.TimeoutExpired:
            TEST_LOGGER.warn("执行命令：" + str(cmdline) + " 超时！！", tag="exec_cmd")
            return False, "TimeoutExpired"
        finally:
            try:
                process.kill()
            except:
                pass
    o_file.close()
    return True, None
