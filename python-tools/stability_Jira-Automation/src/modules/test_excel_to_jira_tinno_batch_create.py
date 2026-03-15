#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Excel文件批量创建JIRA问题工具 - Tinno JIRA版本

功能：
1. 读取Excel文件中的问题数据
2. 批量在Tinno JIRA (https://jira.tinno.com) 中创建问题
3. 为每个问题添加备注（PS列内容）
4. 生成详细的创建结果报告
5. 使用方法: python excel_to_jira_tinno_batch_create.py <excel文件路径>

作者：AI Assistant
创建时间：2025-01-10
"""

import sys
import os
import pandas as pd
from datetime import datetime
from jira import JIRA, JIRAError
import argparse
import urllib3

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# JIRA服务器配置
JIRA_SERVER = 'https://jira.tinno.com'
JIRA_USER = 'dai.lv'
JIRA_PASSWORD = 'l.74926520'
project_key = 'VCAME'

def connect_to_jira(server, username, password):
    """连接到JIRA服务器"""
    try:
        print(f"正在连接到 JIRA 服务器: {server}")
        print(f"用户名: {username}")
        
        jira_client = JIRA(server, basic_auth=(username, password))
        
        # 验证连接
        current_user = jira_client.current_user()
        print(f"[成功] JIRA 连接成功!")
        print(f"当前登录用户: {current_user}")
        return jira_client
        
    except JIRAError as e:
        print(f"[失败] JIRA 连接失败 (JIRA错误): {e.text} (状态码: {e.status_code})")
        if e.status_code == 401:
            print("  认证失败，请检查用户名和密码是否正确")
        elif e.status_code == 403:
            print("  权限不足，请检查账户权限")
        elif e.status_code == 404:
            print("  服务器地址不正确或服务不可用")
        else:
            print("  请检查网络连接和服务器状态")
        return None
        
    except Exception as e:
        print(f"[失败] JIRA 连接失败: {e}")
        return None

def read_excel_file(file_path):
    """读取Excel文件"""
    try:
        print(f"正在读取Excel文件: {file_path}")
        df = pd.read_excel(file_path)
        print(f"成功读取 {len(df)} 行数据")
        
        # 显示表头信息
        print(f"表头: {list(df.columns)}")
        
        # 过滤掉空行
        df = df.dropna(subset=['Summary'])  # 以Summary列为准过滤空行
        print(f"有效数据行数: {len(df)}")
        
        return df
        
    except Exception as e:
        print(f"[失败] 读取Excel文件失败: {e}")
        return None

def map_priority_to_name(priority_str):
    """将优先级字符串映射到JIRA优先级名称"""
    priority_map = {
        'Highest': 'Highest',
        'High': 'High', 
        'Medium': 'Medium',
        'Low': 'Low',
        'Lowest': 'Lowest',
        '最高': 'Highest',
        '高': 'High',
        '中等': 'Medium',
        '低': 'Low',
        '最低': 'Lowest'
    }
    return priority_map.get(str(priority_str).strip(), 'Medium')

def create_issue_from_row(jira_client, row, row_index):
    """根据Excel行数据创建JIRA问题"""
    try:
        print(f"\n--- 创建第 {row_index + 1} 个问题 ---")

        # 构建问题数据
        issue_dict = {
            'project': {'key': str(row.get('Project', project_key))},
            'issuetype': {'name': str(row.get('Issue Type', '故障'))},
            'summary': str(row.get('Summary', '未指定概要')),
            'assignee': {'name': str(row.get('Assignee', 'dai.lv'))},
            'priority': {'name': map_priority_to_name(str(row.get('Priority', 'Medium')))},
            'description': str(row.get('Description', '通过Excel批量导入创建')),
        }
        
        # 添加组件（模块）
        if pd.notna(row.get('Module')):
            issue_dict['components'] = [{'name': str(row['Module'])}]
        
        # 添加环境信息
        if pd.notna(row.get('Environment')):
            issue_dict['environment'] = str(row['Environment'])
        
        # 添加自定义字段（基于jira_test_TN.py的配置）
        custom_fields = {}
        
        # Bug Severity字段
        if pd.notna(row.get('Bug Severity')):
            custom_fields['customfield_10120'] = {'value': str(row['Bug Severity'])}
        
        # Previous Version Status字段
        if pd.notna(row.get('Previous Version Status')):
            custom_fields['customfield_10123'] = {'value': 'Previous version exists'}
            custom_fields['customfield_10124'] = {'value': str(row['Previous Version Status'])}
        
        # key_information字段
        if pd.notna(row.get('key_information')):
            custom_fields['customfield_10500'] = str(row['key_information'])

        # 合并自定义字段
        issue_dict.update(custom_fields)
        
        # 打印创建信息
        print(f"概要: {issue_dict['summary'][:80]}..." if len(issue_dict['summary']) > 80 else f"概要: {issue_dict['summary']}")
        print(f"项目: {issue_dict['project']['key']}")
        print(f"问题类型: {issue_dict['issuetype']['name']}")
        print(f"经办人: {issue_dict['assignee']['name']}")
        print(f"优先级: {issue_dict['priority']['name']}")
        
        # 创建问题
        new_issue = jira_client.create_issue(fields=issue_dict)
        
        print(f"[成功] 问题创建成功!")
        print(f"问题Key: {new_issue.key}")
        print(f"问题链接: {JIRA_SERVER}/browse/{new_issue.key}")
        
        # 添加备注（如果存在PS列）
        comment_text = row.get('PS', '')
        comment_added = False
        if comment_text and str(comment_text).strip() and str(comment_text).strip() != 'nan':
            try:
                jira_client.add_comment(new_issue, str(comment_text))
                print(f"[成功] 备注已添加到问题 {new_issue.key}")
                comment_added = True
            except Exception as comment_error:
                print(f"[警告] 添加备注失败: {comment_error}")
        
        return {
            'success': True,
            'issue_key': new_issue.key,
            'issue_url': f"{JIRA_SERVER}/browse/{new_issue.key}",
            'summary': issue_dict['summary'],
            'comment_added': comment_added
        }
        
    except JIRAError as e:
        error_msg = f"JIRA错误: {e.text} (状态码: {e.status_code})"
        print(f"[失败] 创建问题时发生JIRA错误: {error_msg}")
        return {
            'success': False,
            'error': error_msg,
            'summary': str(row.get('Summary', '未知问题'))
        }
        
    except Exception as e:
        error_msg = f"创建问题时发生异常: {e}"
        print(f"[失败] {error_msg}")
        return {
            'success': False,
            'error': error_msg,
            'summary': str(row.get('Summary', '未知问题'))
        }

def batch_create_issues(jira_client, df):
    """批量创建JIRA问题"""
    print(f"\n开始批量创建 {len(df)} 个JIRA问题...")
    
    results = []
    success_count = 0
    failed_count = 0
    
    for index, row in df.iterrows():
        result = create_issue_from_row(jira_client, row, index)
        results.append(result)
        
        if result['success']:
            success_count += 1
        else:
            failed_count += 1
    
    # 打印统计信息
    print(f"\n=== 批量创建完成 ===")
    print(f"总计: {len(results)} 个问题")
    print(f"成功: {success_count} 个")
    print(f"失败: {failed_count} 个")
    print(f"成功率: {(success_count/len(results)*100):.1f}%")
    
    # 打印详细结果
    print(f"\n=== 详细结果 ===")
    for i, result in enumerate(results):
        if result['success']:
            comment_status = " (含备注)" if result['comment_added'] else ""
            summary_short = result['summary'][:50] + "..." if len(result['summary']) > 50 else result['summary']
            print(f"第{i+1}行: ✅ {result['issue_key']}{comment_status} - {summary_short}")
        else:
            summary_short = result['summary'][:50] + "..." if len(result['summary']) > 50 else result['summary']
            print(f"第{i+1}行: ❌ 失败 - {summary_short}")
            print(f"       错误: {result['error']}")
    
    return results

def validate_excel_format(df):
    """验证Excel文件格式"""
    required_columns = ['Project', 'Issue Type', 'Summary', 'Assignee']
    missing_columns = [col for col in required_columns if col not in df.columns]
    
    if missing_columns:
        print(f"[错误] Excel文件缺少必需的列: {missing_columns}")
        print(f"当前列: {list(df.columns)}")
        return False
    
    print(f"[成功] Excel文件格式验证通过")
    return True

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='Excel文件批量创建JIRA问题工具 - Tinno JIRA版本')
    parser.add_argument('excel_file', help='Excel文件路径')
    parser.add_argument('--server', default=JIRA_SERVER, help='JIRA服务器地址')
    parser.add_argument('--user', default=JIRA_USER, help='JIRA用户名')
    parser.add_argument('--password', default=JIRA_PASSWORD, help='JIRA密码')
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("JIRA 批量问题创建工具 - Tinno JIRA版本")
    print("=" * 60)
    
    # 读取Excel文件
    df = read_excel_file(args.excel_file)
    if df is None:
        return 1
    
    # 验证Excel格式
    if not validate_excel_format(df):
        return 1
    
    # 连接到JIRA
    jira = connect_to_jira(args.server, args.user, args.password)
    if jira is None:
        return 1
    
    # 批量创建问题
    results = batch_create_issues(jira, df)
    
    # 保存结果到文件
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    result_file = f"jira_tinno_batch_create_result_{timestamp}.txt"
    
    with open(result_file, 'w', encoding='utf-8') as f:
        f.write(f"JIRA批量创建结果 - {datetime.now()}\n")
        f.write(f"Excel文件: {args.excel_file}\n")
        f.write(f"JIRA服务器: {args.server}\n")
        f.write(f"总计: {len(results)} 个问题\n")
        f.write(f"成功: {sum(1 for r in results if r['success'])} 个\n")
        f.write(f"失败: {sum(1 for r in results if not r['success'])} 个\n")
        f.write("\n")
        
        for i, result in enumerate(results):
            if result['success']:
                comment_status = " (含备注)" if result['comment_added'] else ""
                f.write(f"第{i+1}行: 成功{comment_status} - {result['summary']}\n")
                f.write(f"  问题Key: {result['issue_key']}\n")
                f.write(f"  链接: {result['issue_url']}\n")
                if result['comment_added']:
                    f.write(f"  备注: 已添加\n")
                f.write("\n")
            else:
                f.write(f"第{i+1}行: 失败 - {result['summary']}\n")
                f.write(f"  错误: {result['error']}\n")
                f.write("\n")
    
    print(f"\n结果已保存到: {result_file}")
    return 0

if __name__ == "__main__":
    sys.exit(main())