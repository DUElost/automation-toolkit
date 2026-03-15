#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Transsion项目用户问题同步脚本

基于test_sync_vffba_user_issues.py的配置，拉取Transsion JIRA项目中当前用户提交的所有问题到主表
针对 http://jira-ex.transsion.com:6001 的JIRA库
"""

import sys
import os
import sqlite3
import logging
from pathlib import Path
from typing import Dict, List, Any, Optional
from datetime import datetime
from jira import JIRA
from jira.exceptions import JIRAError
import urllib3
import re

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# 配置日志
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class TranssionUserIssueSync:
    """Transsion项目用户问题同步器"""
    
    def __init__(self):
        """初始化同步器"""
        # JIRA配置（针对Transsion外网JIRA）
        self.jira_server = 'http://jira-ex.transsion.com:6001'
        self.jira_user = 'dailv.tinno'
        self.jira_password = '2j4-Gx6-beJ-x36'
        self.project_key = 'X6851VP865'  # 默认项目，可根据实际情况调整
        
        # 数据库配置
        self.db_path = Path(__file__).parent.parent / 'jira_automation_transsion.db'
        
        # JIRA客户端
        self.jira_client = None
        
        logger.info("Transsion用户问题同步器初始化完成")
    
    def connect_to_jira(self) -> bool:
        """连接到JIRA"""
        try:
            logger.info(f"正在连接到JIRA服务器: {self.jira_server}")
            logger.info(f"用户名: {self.jira_user}")
            
            self.jira_client = JIRA(
                self.jira_server, 
                basic_auth=(self.jira_user, self.jira_password)
            )
            
            # 验证连接
            current_user = self.jira_client.current_user()
            logger.info(f"JIRA连接成功！当前登录用户: {current_user}")
            return True
            
        except JIRAError as e:
            logger.error(f"JIRA连接失败: {e.text} (状态码: {e.status_code})")
            return False
        except Exception as e:
            logger.error(f"JIRA连接失败: {e}")
            return False
    
    def init_database(self):
        """初始化数据库表结构"""
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                # 创建主表 - 基于Transsion_out.xlsx表头结构
                cursor.execute("""
                    CREATE TABLE IF NOT EXISTS jira_issues_main (
                        id INTEGER PRIMARY KEY AUTOINCREMENT,
                        jira_key VARCHAR(255) UNIQUE NOT NULL,
                        project VARCHAR(100) NOT NULL,
                        issuetype VARCHAR(100) NOT NULL,
                        summary TEXT NOT NULL,
                        assignee VARCHAR(255),
                        components VARCHAR(255),
                        versions VARCHAR(255),
                        priority VARCHAR(50) NOT NULL DEFAULT 'Medium',
                        description TEXT,
                        customfield_12805 TEXT,
                        environment TEXT,
                        customfield_10201 TEXT,
                        customfield_10203 TEXT,
                        customfield_10401 TEXT,
                        customfield_10202 TEXT,
                        customfield_12500 TEXT,
                        customfield_12804 TEXT,
                        notes TEXT,
                        status VARCHAR(100) NOT NULL DEFAULT 'Open',
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        resolved_at TIMESTAMP,
                        raw_data TEXT
                    )
                """)
                
                conn.commit()
                logger.info("数据库表结构初始化完成")
                
        except Exception as e:
            logger.error(f"数据库初始化失败: {e}")
            raise
    
    def get_user_issues(self) -> List[Dict[str, Any]]:
        """获取当前用户在项目下提交的所有问题"""
        if not self.jira_client:
            logger.error("JIRA客户端未连接")
            return []
        
        try:
            # 构建JQL查询语句：查找当前用户报告的所有问题
            jql_query = f"reporter = currentUser() ORDER BY created DESC"
            logger.info(f"JQL查询语句: {jql_query}")
            
            # 分页查询获取所有问题
            all_issues = []
            start_at = 0
            max_per_page = 100
            
            while True:
                issues_batch = self.jira_client.search_issues(
                    jql_query, 
                    startAt=start_at, 
                    maxResults=max_per_page,
                    expand='changelog'
                )
                
                if not issues_batch:
                    break
                
                all_issues.extend(issues_batch)
                logger.info(f"已获取 {len(all_issues)} 个问题...")
                
                if len(issues_batch) < max_per_page:
                    break
                
                start_at += max_per_page
            
            logger.info(f"总共找到 {len(all_issues)} 个问题")
            return all_issues
            
        except JIRAError as e:
            logger.error(f"获取问题列表失败: {e.text} (状态码: {e.status_code})")
            return []
        except Exception as e:
            logger.error(f"获取问题列表失败: {e}")
            return []
    
    def get_first_comment(self, issue) -> str:
        """获取问题的第一个备注内容"""
        try:
            comments = self.jira_client.comments(issue)
            if comments:
                return comments[0].body
            return ''
        except Exception as e:
            logger.warning(f"获取问题 {issue.key} 的备注失败: {e}")
            return ''
    
    def get_custom_field_value(self, issue, field_name: str) -> str:
        """获取自定义字段值"""
        try:
            field_value = getattr(issue.fields, field_name, None)
            if field_value:
                if isinstance(field_value, dict) and 'value' in field_value:
                    return field_value['value']
                elif isinstance(field_value, list) and len(field_value) > 0:
                    if isinstance(field_value[0], dict) and 'value' in field_value[0]:
                        return field_value[0]['value']
                    return str(field_value[0])
                return str(field_value)
            return ''
        except Exception as e:
            logger.warning(f"获取自定义字段 {field_name} 失败: {e}")
            return ''
    
    def sync_issue_to_main_table(self, issue) -> bool:
        """将JIRA问题同步到主表"""
        try:
            # 获取第一个备注内容（对应备注列）
            notes_content = self.get_first_comment(issue)
            
            # 获取自定义字段值
            customfield_12805 = self.get_custom_field_value(issue, 'customfield_12805')
            customfield_10201 = self.get_custom_field_value(issue, 'customfield_10201')
            customfield_10203 = self.get_custom_field_value(issue, 'customfield_10203')
            customfield_10401 = self.get_custom_field_value(issue, 'customfield_10401')
            customfield_10202 = self.get_custom_field_value(issue, 'customfield_10202')
            customfield_12500 = self.get_custom_field_value(issue, 'customfield_12500')
            customfield_12804 = self.get_custom_field_value(issue, 'customfield_12804')
            
            # 构建主表记录 - 基于Transsion_out.xlsx表头结构
            record = {
                'jira_key': issue.key,
                'project': issue.fields.project.key if issue.fields.project else '',
                'issuetype': issue.fields.issuetype.name if issue.fields.issuetype else '',
                'summary': issue.fields.summary,
                'assignee': issue.fields.assignee.displayName if issue.fields.assignee else '',
                'components': '',  # 从组件中获取
                'versions': '',   # 从版本中获取
                'priority': issue.fields.priority.name if issue.fields.priority else 'Medium',
                'description': issue.fields.description or '',
                'customfield_12805': customfield_12805,
                'environment': issue.fields.environment or '',
                'customfield_10201': customfield_10201,
                'customfield_10203': customfield_10203,
                'customfield_10401': customfield_10401,
                'customfield_10202': customfield_10202,
                'customfield_12500': customfield_12500,
                'customfield_12804': customfield_12804,
                'notes': notes_content,
                'status': issue.fields.status.name,
                'raw_data': str({
                    'created': str(issue.fields.created),
                    'updated': str(issue.fields.updated),
                    'reporter': issue.fields.reporter.displayName if issue.fields.reporter else None,
                    'components': [comp.name for comp in issue.fields.components] if issue.fields.components else [],
                    'versions': [ver.name for ver in issue.fields.versions] if issue.fields.versions else []
                })
            }
            
            # 获取组件信息（多个组件用逗号分隔）
            if issue.fields.components:
                record['components'] = ', '.join([comp.name for comp in issue.fields.components])
            
            # 获取版本信息（多个版本用逗号分隔）
            if issue.fields.versions:
                record['versions'] = ', '.join([ver.name for ver in issue.fields.versions])
            
            # 插入或更新数据库
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                # 检查是否已存在
                cursor.execute("SELECT id FROM jira_issues_main WHERE jira_key = ?", (issue.key,))
                existing = cursor.fetchone()
                
                if existing:
                    # 更新现有记录
                    update_sql = """
                        UPDATE jira_issues_main SET
                            project = ?, issuetype = ?, summary = ?, assignee = ?,
                            components = ?, versions = ?, priority = ?, description = ?,
                            customfield_12805 = ?, environment = ?, customfield_10201 = ?,
                            customfield_10203 = ?, customfield_10401 = ?, customfield_10202 = ?,
                            customfield_12500 = ?, customfield_12804 = ?, notes = ?,
                            status = ?, raw_data = ?, updated_at = CURRENT_TIMESTAMP
                        WHERE jira_key = ?
                    """
                    cursor.execute(update_sql, (
                        record['project'], record['issuetype'], record['summary'], record['assignee'],
                        record['components'], record['versions'], record['priority'], record['description'],
                        record['customfield_12805'], record['environment'], record['customfield_10201'],
                        record['customfield_10203'], record['customfield_10401'], record['customfield_10202'],
                        record['customfield_12500'], record['customfield_12804'], record['notes'],
                        record['status'], record['raw_data'], record['jira_key']
                    ))
                    logger.debug(f"更新问题 {issue.key}")
                else:
                    # 插入新记录
                    insert_sql = """
                        INSERT INTO jira_issues_main (
                            jira_key, project, issuetype, summary, assignee,
                            components, versions, priority, description,
                            customfield_12805, environment, customfield_10201,
                            customfield_10203, customfield_10401, customfield_10202,
                            customfield_12500, customfield_12804, notes, status, raw_data
                        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                    """
                    cursor.execute(insert_sql, (
                        record['jira_key'], record['project'], record['issuetype'], record['summary'], record['assignee'],
                        record['components'], record['versions'], record['priority'], record['description'],
                        record['customfield_12805'], record['environment'], record['customfield_10201'],
                        record['customfield_10203'], record['customfield_10401'], record['customfield_10202'],
                        record['customfield_12500'], record['customfield_12804'], record['notes'],
                        record['status'], record['raw_data']
                    ))
                    logger.debug(f"插入问题 {issue.key}")
                
                conn.commit()
            
            return True
            
        except Exception as e:
            logger.error(f"同步问题 {issue.key} 失败: {e}")
            return False
    
    def sync_all_user_issues(self) -> bool:
        """同步所有用户问题到主表"""
        try:
            # 连接JIRA
            if not self.connect_to_jira():
                return False
            
            # 初始化数据库
            self.init_database()
            
            # 获取用户问题
            issues = self.get_user_issues()
            if not issues:
                logger.info("没有找到任何问题")
                return True
            
            # 同步到主表
            success_count = 0
            for issue in issues:
                if self.sync_issue_to_main_table(issue):
                    success_count += 1
            
            logger.info(f"同步完成: {success_count}/{len(issues)} 个问题成功同步到主表")
            
            # 显示统计信息
            self.show_sync_statistics()
            
            return True
            
        except Exception as e:
            logger.error(f"同步过程失败: {e}")
            return False
    
    def show_sync_statistics(self):
        """显示同步统计信息"""
        try:
            with sqlite3.connect(self.db_path) as conn:
                cursor = conn.cursor()
                
                # 总问题数
                cursor.execute("SELECT COUNT(*) FROM jira_issues_main")
                total_count = cursor.fetchone()[0]
                
                # 按状态统计
                cursor.execute("""
                    SELECT status, COUNT(*) 
                    FROM jira_issues_main 
                    GROUP BY status
                """)
                status_stats = cursor.fetchall()
                
                # 按项目统计
                cursor.execute("""
                    SELECT project, COUNT(*) 
                    FROM jira_issues_main 
                    GROUP BY project
                """)
                project_stats = cursor.fetchall()
                
                # 按问题类型统计
                cursor.execute("""
                    SELECT issuetype, COUNT(*) 
                    FROM jira_issues_main 
                    GROUP BY issuetype
                """)
                issue_type_stats = cursor.fetchall()
                
                # 按优先级统计
                cursor.execute("""
                    SELECT priority, COUNT(*) 
                    FROM jira_issues_main 
                    GROUP BY priority
                """)
                priority_stats = cursor.fetchall()
                
                logger.info("=" * 60)
                logger.info("Transsion JIRA问题同步统计信息")
                logger.info("=" * 60)
                logger.info(f"总问题数: {total_count}")
                
                logger.info("\n按状态分布:")
                for status, count in status_stats:
                    logger.info(f"  - {status}: {count} 个")
                
                logger.info("\n按项目分布:")
                for project, count in project_stats:
                    logger.info(f"  - {project}: {count} 个")
                
                logger.info("\n按问题类型分布:")
                for issue_type, count in issue_type_stats:
                    logger.info(f"  - {issue_type}: {count} 个")
                
                logger.info("\n按优先级分布:")
                for priority, count in priority_stats:
                    logger.info(f"  - {priority}: {count} 个")
                
        except Exception as e:
            logger.error(f"显示统计信息失败: {e}")

def main():
    """主函数"""
    print("=" * 60)
    print("Transsion项目用户问题同步工具")
    print("=" * 60)
    
    sync_tool = TranssionUserIssueSync()
    
    if sync_tool.sync_all_user_issues():
        print("\n✅ 同步完成！")
    else:
        print("\n❌ 同步失败！")
        sys.exit(1)

if __name__ == "__main__":
    main()