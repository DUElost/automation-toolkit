#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
针对http://jira-ex.transsion.com:6001，JIRA批量问题创建脚本
读取Excel文件并批量创建JIRA问题
使用方法: python excel_to_jira_batch_create.py <excel文件路径>
"""

import sys 
import os
import pandas as pd
from datetime import datetime
from jira import JIRA, JIRAError
import argparse

# 添加项目根目录到Python路径
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

# JIRA服务器配置
JIRA_SERVER = 'http://jira-ex.transsion.com:6001'
JIRA_USER = 'dailv.tinno'
JIRA_PASSWORD = '2j4-Gx6-beJ-x36'

# 列映射，兼容 test_excel_to_jira_upload_list.py 生成的规范化字段
NORMALIZED_FIELD_CANDIDATES = {
    'project': ['Project', 'project'],
    'issue_type': ['Issue Type', 'issue_type', 'issuetype'],
    'summary': ['Summary', 'summary'],
    'assignee': ['Assignee', 'assignee'],
    'module': ['Module', 'module', 'components'],
    'priority': ['Priority', 'priority'],
    'description': ['Description', 'description'],
    'key_information': ['key_information', 'Key Information', 'customfield_12805'],
    'environment': ['Environment', 'environment'],
    'ps': ['PS', '备注'],
    'bug_severity': ['Bug Severity', 'bug_severity'],
    'version': ['Version', 'version', 'Versions', 'versions'],
}


def _clean_cell_value(value):
    if isinstance(value, str):
        cleaned = value.strip()
        return cleaned if cleaned and cleaned.lower() != 'nan' else None
    if isinstance(value, (int, float)) and pd.notna(value):
        return value
    if pd.notna(value):
        return value
    return None


def _get_field_value(row, field_name, default=None):
    for column in NORMALIZED_FIELD_CANDIDATES.get(field_name, []):
        if column in row.index:
            value = _clean_cell_value(row[column])
            if value is not None:
                return value
    return default


def _find_column(columns, field_name):
    for column in NORMALIZED_FIELD_CANDIDATES.get(field_name, []):
        if column in columns:
            return column
    return None

def connect_to_jira(server, username, password):
    """连接到JIRA服务器"""
    print(f"正在连接到 JIRA 服务器: {server}")
    print(f"用户名: {username}")
    
    try:
        jira = JIRA(server=server, basic_auth=(username, password))
        print("[成功] JIRA 连接成功!")
        print(f"当前登录用户: {jira.current_user()}")
        return jira
    except JIRAError as e:
        print(f"[失败] JIRA 连接失败: {e.text} (状态码: {e.status_code})")
        return None
    except Exception as e:
        print(f"[失败] 连接异常: {str(e)}")
        return None

def read_excel_file(file_path):
    """读取Excel文件"""
    try:
        print(f"正在读取Excel文件: {file_path}")
        df = pd.read_excel(file_path, engine='openpyxl')
        print(f"成功读取 {len(df)} 行数据")
        print(f"表头: {list(df.columns)}")
        return df
    except Exception as e:
        print(f"读取Excel文件失败: {str(e)}")
        return None

def map_priority_to_id(priority_name):
    """将优先级名称映射为ID"""
    priority_mapping = {
        '紧急': '1',
        '严重': '2', 
        '重要': '3',
        '次要': '4',
        '微小': '5',
        'highest': '1',
        'high': '2',
        'medium': '3',
        'low': '4',
        'lowest': '5'
    }
    if priority_name is None:
        return '3'
    priority_key = str(priority_name).strip().lower()
    return priority_mapping.get(priority_key, '3')  # 默认为重要

def create_issue_from_row(jira_client, row, row_index):
    """根据Excel行数据创建JIRA问题"""
    try:
        print(f"\n--- 创建第 {row_index + 1} 个问题 ---")
        
        project_key = _get_field_value(row, 'project', 'ALLYL')
        issue_type = _get_field_value(row, 'issue_type', '故障')
        summary = _get_field_value(row, 'summary', '未指定概要')
        priority_name = _get_field_value(row, 'priority', 'Medium')
        description = _get_field_value(row, 'description', '通过Excel批量导入创建')
        environment = _get_field_value(row, 'environment')
        module_value = _get_field_value(row, 'module')
        assignee_value = _get_field_value(row, 'assignee')
        key_information = _get_field_value(row, 'key_information', 'MonkeyAEE')
        remark_text = _get_field_value(row, 'ps')
        bug_severity = _get_field_value(row, 'bug_severity')

        # 构建问题数据
        issue_dict = {
            'project': {'key': str(project_key)},
            'issuetype': {'name': str(issue_type)},
            'summary': str(summary),
            'priority': {'id': map_priority_to_id(priority_name)},
            'description': str(description) if description else '通过Excel批量导入创建',
        }
        
        # 添加可选字段
        if environment:
            issue_dict['environment'] = str(environment)
            
        if module_value:
            components = [comp.strip() for comp in str(module_value).replace(';', ',').split(',') if comp.strip()]
            if components:
                issue_dict['components'] = [{'name': comp} for comp in components]
            
        # 影响版本是必需的，使用项目的第一个可用版本
        version_value = _get_field_value(row, 'version')
        try:
            if version_value:
                issue_dict['versions'] = [{'name': str(version_value)}]
            else:
                project_versions = jira_client.project_versions(issue_dict['project']['key'])
                if project_versions:
                    issue_dict['versions'] = [{'name': project_versions[0].name}]
                else:
                    issue_dict['versions'] = [{'name': 'V1.0'}]
        except Exception:
            issue_dict['versions'] = [{'name': 'V1.0'}]
            
        # 经办人处理
        assignee_name = assignee_value if assignee_value else JIRA_USER
        issue_dict['assignee'] = {'name': assignee_name}
            
        # 添加自定义字段
        custom_fields = {
            'customfield_10201': {'value': 'must'},  # Risk
            'customfield_10401': {'value': 'Auto Test'},  # Issue Source
            'customfield_10203': {'value': 'Stability'},  # Issue Category
            'customfield_10202': {'value': 'New issues'},  # Issue Nature
            'customfield_12500': 'MonkeyTest',  # 用例编号 (字符串类型)
            'customfield_12804': str(bug_severity) if bug_severity else 'MonkeyAEE',  # ExpClass
            'customfield_12805': str(key_information) if key_information else 'System',  # CausedBy
            'customfield_12900': {'value': 'CL7-V-P765A'},  # Affect Project (选择类型)
        }
        
        # 从Excel中读取自定义字段值（如果存在）
        for field_id, default_value in custom_fields.items():
            if field_id in row and pd.notna(row[field_id]):
                if field_id in ['customfield_10201', 'customfield_10401', 'customfield_10203', 'customfield_10202']:
                    issue_dict[field_id] = {'value': str(row[field_id])}
                else:
                    issue_dict[field_id] = str(row[field_id])
            else:
                if field_id in ['customfield_10201', 'customfield_10401', 'customfield_10203', 'customfield_10202']:
                    issue_dict[field_id] = {'value': default_value}
                else:
                    issue_dict[field_id] = default_value
        
        print(f"概要: {issue_dict['summary']}")
        print(f"项目: {issue_dict['project']['key']}")
        print(f"问题类型: {issue_dict['issuetype']['name']}")
        print(f"优先级ID: {issue_dict['priority']['id']}")
        
        # 创建问题
        new_issue = jira_client.create_issue(fields=issue_dict)
        
        print(f"[成功] 问题创建成功!")
        print(f"问题Key: {new_issue.key}")
        print(f"问题链接: {JIRA_SERVER}/browse/{new_issue.key}")
        
        # 添加备注（如果存在）
        comment_text = remark_text
        if comment_text and str(comment_text).strip() and str(comment_text).strip() != 'nan':
            try:
                jira_client.add_comment(new_issue, str(comment_text))
                print(f"[成功] 备注已添加到问题 {new_issue.key}")
            except Exception as comment_error:
                print(f"[警告] 添加备注失败: {comment_error}")
        
        return {
            'success': True,
            'issue_key': new_issue.key,
            'issue_url': f"{JIRA_SERVER}/browse/{new_issue.key}",
            'summary': issue_dict['summary'],
            'comment_added': bool(comment_text and str(comment_text).strip() and str(comment_text).strip() != 'nan')
        }
        
    except JIRAError as e:
        error_msg = f"JIRA错误: {e.text} (状态码: {e.status_code})"
        print(f"[失败] {error_msg}")
        
        # 解析详细错误信息
        if hasattr(e, 'response') and e.response:
            try:
                error_data = e.response.json()
                if 'errors' in error_data:
                    print("详细错误信息:")
                    for field, error_msg_detail in error_data['errors'].items():
                        print(f"  {field}: {error_msg_detail}")
                if 'errorMessages' in error_data:
                    print("错误消息:")
                    for msg in error_data['errorMessages']:
                        print(f"  - {msg}")
            except:
                pass
        
        return {
            'success': False,
            'error': error_msg,
            'summary': issue_dict['summary']
        }
        
    except Exception as e:
        error_msg = f"创建问题时发生异常: {str(e)}"
        print(f"[失败] {error_msg}")
        return {
            'success': False,
            'error': error_msg,
            'summary': str(_get_field_value(row, 'summary', '未知问题'))
        }

def batch_create_issues(jira_client, df):
    """批量创建JIRA问题"""
    print(f"\n开始批量创建 {len(df)} 个JIRA问题...")
    
    success_count = 0
    failed_count = 0
    results = []
    
    for index, row in df.iterrows():
        summary_preview = _get_field_value(row, 'summary', '未指定概要')
        print(f"正在处理第 {index + 1} 行: {str(summary_preview)[:50]}...")
        result = create_issue_from_row(jira_client, row, index)
        
        if result['success']:
            success_count += 1
            comment_status = " (含备注)" if result.get('comment_added', False) else ""
            results.append({
                'row': index + 1,
                'status': '成功',
                'issue_key': result['issue_key'],
                'summary': result['summary'],
                'error': None,
                'comment_added': result.get('comment_added', False)
            })
        else:
            failed_count += 1
            results.append({
                'row': index + 1,
                'status': '失败',
                'issue_key': None,
                'summary': result['summary'],
                'error': result['error'],
                'comment_added': False
            })
    
    # 打印统计信息
    print(f"\n=== 批量创建完成 ===")
    print(f"总计: {len(df)} 个问题")
    print(f"成功: {success_count} 个")
    print(f"失败: {failed_count} 个")
    print(f"成功率: {success_count/len(df)*100:.1f}%")
    
    # 打印详细结果
    print(f"\n=== 详细结果 ===")
    for result in results:
        if result['status'] == '成功':
            comment_status = " (含备注)" if result.get('comment_added', False) else ""
            print(f"第{result['row']}行: ✅ {result['issue_key']}{comment_status} - {result['summary'][:50]}...")
        else:
            print(f"第{result['row']}行: ❌ {result['summary'][:50]}... - {result['error']}")
    
    return results

def validate_excel_format(df):
    """验证Excel文件格式并返回概要列名"""
    summary_column = _find_column(df.columns, 'summary')
    if not summary_column:
        print("错误: Excel文件缺少必需的 Summary 列（需包含 'Summary' 或 'summary'）")
        print(f"当前列: {list(df.columns)}")
        return None
    
    empty_summary_rows = df[df[summary_column].isna() | (df[summary_column].astype(str).str.strip() == '')]
    if len(empty_summary_rows) > 0:
        print(f"警告: 发现 {len(empty_summary_rows)} 行概要为空，这些行将被跳过")
        
    return summary_column

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='JIRA批量问题创建工具')
    parser.add_argument('excel_file', help='Excel文件路径')
    parser.add_argument('--dry-run', action='store_true', help='仅验证数据，不实际创建问题')
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("JIRA 批量问题创建工具")
    print("=" * 60)
    
    # 检查文件是否存在
    if not os.path.exists(args.excel_file):
        print(f"错误: 文件不存在: {args.excel_file}")
        return 1
    
    # 读取Excel文件
    df = read_excel_file(args.excel_file)
    if df is None:
        return 1
    
    # 验证Excel格式
    summary_column = validate_excel_format(df)
    if not summary_column:
        return 1
    
    # 过滤掉概要为空的行
    df = df[df[summary_column].notna() & (df[summary_column].astype(str).str.strip() != '')]
    
    if len(df) == 0:
        print("错误: 没有有效的数据行")
        return 1
    
    print(f"有效数据行数: {len(df)}")
    
    if args.dry_run:
        print("\n=== 干运行模式 - 仅验证数据 ===")
        for index, row in df.iterrows():
            summary_preview = _get_field_value(row, 'summary', '未指定概要')
            print(f"第{index+1}行: {str(summary_preview)[:50]}...")
        print("验证完成，未实际创建问题")
        return 0
    
    # 连接到JIRA
    jira = connect_to_jira(JIRA_SERVER, JIRA_USER, JIRA_PASSWORD)
    if not jira:
        print("无法连接到JIRA服务器")
        return 1
    
    # 批量创建问题
    results = batch_create_issues(jira, df)
    
    # 保存结果到文件
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    result_file = f"jira_batch_create_result_{timestamp}.txt"
    
    with open(result_file, 'w', encoding='utf-8') as f:
        f.write(f"JIRA批量创建结果 - {datetime.now()}\n")
        f.write(f"Excel文件: {args.excel_file}\n")
        f.write(f"总计: {len(results)} 个问题\n")
        f.write(f"成功: {sum(1 for r in results if r['status'] == '成功')} 个\n")
        f.write(f"失败: {sum(1 for r in results if r['status'] == '失败')} 个\n\n")
        
        for result in results:
            comment_status = " (含备注)" if result.get('comment_added', False) else ""
            f.write(f"第{result['row']}行: {result['status']}{comment_status} - {result['summary']}\n")
            if result['issue_key']:
                f.write(f"  问题Key: {result['issue_key']}\n")
                f.write(f"  链接: {JIRA_SERVER}/browse/{result['issue_key']}\n")
                if result.get('comment_added', False):
                    f.write(f"  备注: 已添加\n")
            if result['error']:
                f.write(f"  错误: {result['error']}\n")
            f.write("\n")
    
    print(f"\n结果已保存到: {result_file}")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
