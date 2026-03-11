# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\common\Decorators.py
import time
from functools import wraps
from modules.common.Logger import TEST_LOGGER

def func_timer(func):

    @wraps(func)
    def execute_timer(*args, **kwargs):
        start_time = time.time()
        res = func(*args, **kwargs)
        end_time = time.time()
        delta_time = end_time - start_time
        TEST_LOGGER.debug(("Function：{} 执行时间：{}".format(func.__name__, delta_time)), tag=(func.__name__))
        return res

    return execute_timer

# okay decompiling extracted_pyz_modules\modules\common\Decorators.pyc
