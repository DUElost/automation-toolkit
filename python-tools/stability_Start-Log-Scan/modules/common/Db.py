# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: modules\common\Db.py
import pymysql, traceback
from functools import wraps
from modules.common.Logger import TEST_LOGGER

def singleton(cls):
    instances = {}

    @wraps(cls)
    def get_instance(*args, **kw):
        if cls not in instances:
            instances[cls] = cls(*args, **kw)
        return instances[cls]

    return get_instance


@singleton
class MySqlSingle(object):

    def __init__(self, host, db, user, password, port=3306):
        self.host = host
        self.user = user
        self.password = password
        self.db = db
        self.port = port
        self.conn = None

    def get_conn(self):
        if self.conn is None:
            self.conn = pymysql.connect(host=(self.host), user=(self.user), password=(self.password), database=(self.db), port=(self.port))
        self.conn.connect()
        return self.conn


mySqlSingle = MySqlSingle("10.150.154.190", "monkeydb", "monkey", "mysqlasd,./123")

def query_max_round(table_name):
    max_round = None
    TEST_LOGGER.debug("开始获取 Table:{} 中的最大Times".format(table_name))
    sql_max_round = "select max(Times) from {}".format(table_name)
    conn = mySqlSingle.get_conn()
    cur = conn.cursor()
    try:
        try:
            cur.execute(sql_max_round)
            rlt = cur.fetchone()
            TEST_LOGGER.debug("Query 执行结果: {}".format(rlt))
            if rlt[0]:
                max_round = rlt[0]
        except:
            TEST_LOGGER.error("Error: unable to fecth data:\n{}".format(traceback.format_exc()))

    finally:
        cur.close()
        conn.close()

    TEST_LOGGER.debug("获取的Max Times: {}".format(max_round))
    return max_round


def create_monkey_table(table_name):
    """
    查询项目Monkey表单是否存在,不存在则创建
    :param table_name:
    :return:
    """
    TEST_LOGGER.debug("开始为项目:{} 创建Table".format(table_name))
    cmdline_sql = "CREATE TABLE IF NOT EXISTS `{}`(`id` int(0) NOT NULL AUTO_INCREMENT,`Times` tinyint unsigned NOT NULL,`Path` varchar(2000)  DEFAULT NULL,`Version` char(100)  DEFAULT NULL,`ExpTime` varchar(80)  DEFAULT NULL,`ExpClass` char(100) DEFAULT NULL,`ExpType` char(100) DEFAULT NULL,`CurProcess` varchar(200)  DEFAULT NULL,`Package` varchar(200) DEFAULT NULL,`Detail` varchar(2000) DEFAULT NULL,`Count` int(0) DEFAULT NULL,`IOwait` char(20) DEFAULT NULL,`swap` char(20) DEFAULT NULL,`DeviceID` char(50) DEFAULT NULL,`Sample` int(0) DEFAULT NULL,`Test_times` int(0) DEFAULT NULL,PRIMARY KEY (`id`) USING BTREE)".format(table_name)
    conn = mySqlSingle.get_conn()
    cur = conn.cursor()
    try:
        try:
            cur.execute(cmdline_sql)
        except:
            TEST_LOGGER.error("创建数据库表：{}发生异常:\n{}".format(table_name, traceback.format_exc()))

    finally:
        cur.close()
        conn.close()


def insert_monkey_detail(table_name, table_keys, result_list):
    create_monkey_table(table_name)
    conn = mySqlSingle.get_conn()
    cur = conn.cursor()
    cmdline_sql = "lock tables {} write".format(table_name)
    cur.execute(cmdline_sql)
    keys = ", ".join(table_keys)
    result_values = ", ".join(["%s"] * len(table_keys))
    cmdline_sql = "insert into {table} ({keys}) values ({result_values})".format(table=table_name, keys=keys, result_values=result_values)
    TEST_LOGGER.debug("开始执行sql语句：{}".format(cmdline_sql))
    try:
        cur.executemany(cmdline_sql, result_list)
        conn.commit()
    except:
        TEST_LOGGER.error("插入测试结果详细数据时发生异常，执行回滚！异常信息：\n{}".format(traceback.format_exc()))
        conn.rollback()

    cmdline_sql = "unlock tables"
    cur.execute(cmdline_sql)
    cur.close()
    conn.close()


def insert_monkey_summary(summary_list):
    table_name = "summary_monkey"
    table_keys = ['projectName', 'times', 'pre_DPPM', 'post_DPPM', 'pre_A', 'pre_B', 'pre_C', 
     'post_A', 'post_B', 
     'post_C', 'sample', 'test_times', 
     'place', 'startTime', 'endTime', 'version']
    conn = mySqlSingle.get_conn()
    cur = conn.cursor()
    cmdline_sql = "lock tables {} write".format(table_name)
    cur.execute(cmdline_sql)
    keys = ", ".join(table_keys)
    result_values = ", ".join(["%s"] * len(table_keys))
    cmdline_sql = "insert into {table} ({keys}) values ({result_values})".format(table=table_name, keys=keys, result_values=result_values)
    TEST_LOGGER.debug("开始执行sql语句：{}".format(cmdline_sql))
    try:
        cur.execute(cmdline_sql, summary_list)
        conn.commit()
    except:
        TEST_LOGGER.error("插入测试结果统计数据时发生异常，执行回滚！异常信息：\n{}".format(traceback.format_exc()))
        conn.rollback()

    cmdline_sql = "unlock tables"
    cur.execute(cmdline_sql)
    cur.close()
    conn.close()

# okay decompiling extracted_pyz_modules\modules\common\Db.pyc
