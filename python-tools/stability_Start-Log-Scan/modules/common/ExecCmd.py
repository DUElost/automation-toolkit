# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\common\ExecCmd.py
import tempfile, subprocess, traceback
from modules.common.Logger import TEST_LOGGER

def exec_cmd(cmdline, timeout=60, cwd=None):
    timeout_expired = False
    out_temp = tempfile.SpooledTemporaryFile(10000)
    fileno = out_temp.fileno()
    try:
        try:
            process = subprocess.Popen(cmdline, stdout=fileno, stderr=fileno, shell=False, cwd=cwd)
            process.communicate(timeout=timeout)
        except subprocess.TimeoutExpired:
            timeout_expired = True
            TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 超时！！"), tag="exec_cmd")
        except:
            TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 出现异常：\n{}".format(traceback.format_exc())), tag="exec_cmd")

    finally:
        try:
            process.kill()
        except:
            pass

    out_temp.seek(0)
    rlt = out_temp.readlines()
    out_temp.close()
    return (rlt, timeout_expired)


def execute_cmd_infinite(cmdline, timeout=15, maxTry=10, curTry=1):
    out_temp = tempfile.SpooledTemporaryFile(10000)
    fileno = out_temp.fileno()
    try:
        process = subprocess.Popen(cmdline, stdout=fileno, stderr=fileno, shell=False)
        process.communicate(timeout=timeout)
    except subprocess.TimeoutExpired:
        TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 超时！！ 已执行[{}]次".format(curTry)), tag="execute_cmd_infinite")
        out_temp.close()
        try:
            process.kill()
        except:
            pass

        if curTry < maxTry:
            curTry = curTry + 1
            TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 未达最大值，尝试再次执行第[{}]次！".format(curTry)), tag="execute_cmd_infinite")
            return execute_cmd_infinite(cmdline, timeout=timeout, maxTry=maxTry, curTry=curTry)
        TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 已打最大失败次数:[{}]，退出执行！".format(maxTry)), tag="execute_cmd_infinite")
        return (False, None)

    out_temp.seek(0)
    rlt = out_temp.readlines()
    out_temp.close()
    try:
        process.kill()
    except:
        pass

    return (
     True, rlt)


def execute_cmd_kill(cmdline, force_stop_cmdline):
    out_temp = tempfile.SpooledTemporaryFile(100000)
    fileno = out_temp.fileno()
    try:
        process = subprocess.Popen(cmdline, stdout=fileno, stderr=fileno, shell=False)
        process.communicate(timeout=30)
    except subprocess.TimeoutExpired:
        TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 超时！！"), tag="execute_cmd_kill")
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
            try:
                process.communicate(timeout=timeout)
            except subprocess.TimeoutExpired:
                TEST_LOGGER.error(("执行命令：" + str(cmdline) + " 超时！！"), tag="cmd_exec_and_save")
                return (False, 'TimeoutExpired')

        finally:
            try:
                process.kill()
            except:
                pass

    o_file.close()
    return (True, None)

# okay decompiling extracted_pyz_modules\modules\common\ExecCmd.pyc
