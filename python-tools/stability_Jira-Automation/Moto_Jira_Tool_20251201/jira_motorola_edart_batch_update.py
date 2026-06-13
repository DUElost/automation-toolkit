#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Motorola edart JIRA 问题更新工具
基于Excel文件更新指定的JIRA问题信息

功能：
1. 读取Excel文件中的更新数据
2. 根据问题单号更新对应的JIRA问题
3. 支持多种字段更新（摘要、描述、优先级等）
4. 支持自定义字段更新
5. 生成详细的更新结果报告
6. 使用Personal Access Token认证

使用方法: python jira_motorola_edart_batch_update.py <excel文件路径> --issues "EKLAMUC-2028,EKLAMUC-2029"
python jira_motorola_edart_batch_update.py JIRA_Upload_List_Moto_20251014_093941.xlsx --issues "EKLAMUC-2021,EKLAMUC-2022" --add-comments

作者：AI Assistant
创建时间：2025-01-13
"""

import sys
import os
import pandas as pd
import requests
import json
import time
from datetime import datetime
from jira import JIRA, JIRAError
import argparse
import urllib3

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# JIRA服务器配置
JIRA_SERVER = 'https://edart.motorola.com'
JIRA_TOKEN = os.getenv('JIRA_TOKEN', '')
PROJECT_KEY = 'EKLAMUC'

def connect_to_jira(server, token):
    """连接到JIRA服务器"""
    try:
        print(f"正在连接到 JIRA 服务器: {server}")
        print("使用Personal Access Token认证")

        jira_client = JIRA(
            server=server,
            token_auth=token,
            options={'verify': False, 'proxies': None}
        )

        # 验证连接
        current_user = jira_client.current_user()
        print(f"[成功] JIRA 连接成功!")
        print(f"当前登录用户: {current_user}")
        return jira_client

    except JIRAError as e:
        print(f"[失败] JIRA 连接失败: {e.text} (状态码: {e.status_code})")
        if e.status_code == 401:
            print("  Token认证失败，请检查Token是否正确")
        elif e.status_code == 403:
            print("  权限不足，请检查Token权限")
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
        df = pd.read_excel(file_path, engine='openpyxl')
        print(f"成功读取 {len(df)} 行数据")

        # 显示表头信息
        print(f"表头: {list(df.columns)}")

        # 过滤掉空行
        if 'Issue Key' in df.columns:
            df = df.dropna(subset=['Issue Key'])
        elif 'issue_key' in df.columns:
            df = df.dropna(subset=['issue_key'])
        elif 'Summary' in df.columns:
            df = df.dropna(subset=['Summary'])

        print(f"有效数据行数: {len(df)}")

        return df

    except Exception as e:
        print(f"[失败] 读取Excel文件失败: {e}")
        return None

def map_priority_to_name(priority_str):
    """将优先级字符串映射到JIRA优先级名称"""
    priority_map = {
        '1': '1',
        '2': '2',
        '3': '3',
        '4': '4',
        '5': '5',
        '紧急': '1',
        '高': '2',
        '重要': '3',
        '低': '4',
        '微小': '5',
        'Highest': '1',
        'High': '2',
        'Medium': '3',
        'Low': '4',
        'Lowest': '5'
    }
    return priority_map.get(str(priority_str).strip(), '3')

def get_component_id(jira_client, component_name):
    """获取组件ID"""
    try:
        components = jira_client.project_components(PROJECT_KEY)
        for comp in components:
            if comp.name.lower() == component_name.lower():
                return comp.id
        return None
    except:
        return None

def get_version_id(jira_client, version_name):
    """获取版本ID"""
    try:
        versions = jira_client.project_versions(PROJECT_KEY)
        for version in versions:
            if version.name.lower() == version_name.lower():
                return version.id
        return None
    except:
        return None

def add_comment_to_issue(jira_client, issue_key, comment_body):
    """向JIRA问题添加评论"""
    try:
        print(f"\n--- 添加评论到问题 {issue_key} ---")

        if not comment_body or str(comment_body).strip() == 'nan':
            print("评论内容为空，跳过添加评论")
            return True, None

        # 格式化评论内容
        formatted_comment = f"""{comment_body}

---
*评论由自动化工具添加于 {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}*
"""

        print(f"评论内容预览:")
        print(formatted_comment[:200] + "..." if len(formatted_comment) > 200 else formatted_comment)
        print("------------------------")

        # 添加评论
        jira_client.add_comment(issue_key, formatted_comment)
        print(f"[成功] 评论已添加到问题 {issue_key}")

        # 服务器端要求：评论操作完成后等待5秒
        print("等待5秒以满足服务器端要求...")
        time.sleep(5)
        print("等待完成，继续下一步操作")

        return True, None

    except JIRAError as e:
        error_msg = f"添加评论失败: {e.text} (状态码: {e.status_code})"
        print(f"[失败] {error_msg}")

        # 打印详细的错误信息
        if hasattr(e, 'response') and e.response:
            response_text = e.response.text
            print("--- JIRA返回的响应内容 ---")
            print(response_text)
            print("---------------------------------")

        return False, error_msg

    except Exception as e:
        error_msg = f"添加评论时发生异常: {str(e)}"
        print(f"[失败] {error_msg}")
        return False, error_msg

def update_issue_from_row(jira_client, row, row_index, target_issue_key=None):
    """根据Excel行数据更新JIRA问题"""
    issue_key = target_issue_key or row.get('Issue Key') or row.get('issue_key')

    if not issue_key:
        return {
            'success': False,
            'issue_key': None,
            'error': '未找到问题Key'
        }

    try:
        print(f"\n--- 更新问题 {issue_key} (第 {row_index + 1} 行) ---")

        # 检查问题是否存在
        try:
            issue = jira_client.issue(issue_key)
            print(f"找到问题: {issue.fields.summary}")
        except JIRAError as e:
            if e.status_code == 404:
                return {
                    'success': False,
                    'issue_key': issue_key,
                    'error': f'问题 {issue_key} 不存在'
                }
            else:
                raise

        # 构建更新数据
        update_dict = {}

        # 更新摘要
        if 'Summary' in row and pd.notna(row['Summary']):
            new_summary = str(row['Summary']).strip()
            if new_summary and new_summary != issue.fields.summary:
                update_dict['summary'] = new_summary
                print(f"更新摘要: {new_summary}")

        # 更新描述
        if 'Description' in row and pd.notna(row['Description']):
            new_description = str(row['Description']).strip()
            if new_description and new_description != (issue.fields.description or ''):
                update_dict['description'] = new_description
                print(f"更新描述: {new_description[:100]}...")

        # 更新优先级
        if 'Priority' in row and pd.notna(row['Priority']):
            new_priority = map_priority_to_name(row['Priority'])
            if new_priority and new_priority != issue.fields.priority.name:
                update_dict['priority'] = {'name': new_priority}
                print(f"更新优先级: {new_priority}")

        # 更新经办人
        if 'Assignee' in row and pd.notna(row['Assignee']):
            assignee = str(row['Assignee']).strip()
            if assignee and assignee != 'nan':
                update_dict['assignee'] = {'name': assignee}
                print(f"更新经办人: {assignee}")

        # 更新组件
        if 'Components' in row and pd.notna(row['Components']):
            components_str = str(row['Components']).strip()
            if components_str and components_str != 'nan':
                component_names = [comp.strip() for comp in components_str.split(',')]
                components = [{'name': name} for name in component_names]
                update_dict['components'] = components
                print(f"更新组件: {', '.join(component_names)}")

        # 更新影响版本
        if 'Versions' in row and pd.notna(row['Versions']):
            versions_str = str(row['Versions']).strip()
            if versions_str and versions_str != 'nan':
                version_names = [ver.strip() for ver in versions_str.split(',')]
                versions = [{'name': name} for name in version_names]
                update_dict['versions'] = versions
                print(f"更新影响版本: {', '.join(version_names)}")

        # 更新标签 (支持Label和Labels两种列名)
        label_column = None
        if 'Label' in row:
            label_column = 'Label'
        elif 'Labels' in row:
            label_column = 'Labels'

        if label_column and pd.notna(row[label_column]):
            label_str = str(row[label_column]).strip()
            if label_str and label_str != 'nan':
                import re
                labels = re.split(r'[,;，；\s]+', label_str)
                labels = [label.strip() for label in labels if label.strip()]
                update_dict['labels'] = labels
                print(f"更新标签: {', '.join(labels)}")
        else:
            print("未找到Label或Labels列，或列数据为空")

        # 更新自定义字段
        custom_fields_mapping = {
            'Severity': 'customfield_10017',
            'Team Found': 'customfield_10198',
            'Product Affected': 'customfield_11016'
        }

        for display_name, field_key in custom_fields_mapping.items():
            if display_name in row and pd.notna(row[display_name]):
                value = str(row[display_name]).strip()
                if value and value != 'nan':
                    update_dict[field_key] = {'value': value}
                    print(f"更新{display_name}: {value}")

        # 如果没有需要更新的字段
        if not update_dict:
            print("没有需要更新的字段")
            return {
                'success': True,
                'issue_key': issue_key,
                'updated_fields': [],
                'error': None
            }

        # 打印更新信息
        print("--- 更新数据 ---")
        print(json.dumps(update_dict, indent=2, ensure_ascii=False))
        print("----------------")

        # 执行更新前，先尝试获取问题字段信息
        print("--- 问题当前信息 ---")
        try:
            print(f"当前摘要: {issue.fields.summary}")
            print(f"当前优先级: {issue.fields.priority.name if issue.fields.priority else 'None'}")
            print(f"当前经办人: {issue.fields.assignee.displayName if issue.fields.assignee else 'None'}")
        except Exception as field_error:
            print(f"获取问题信息失败: {field_error}")
        print("--------------------")

        # 执行更新
        print("正在执行JIRA更新...")
        issue.update(fields=update_dict)

        print(f"[成功] 问题 {issue_key} 更新成功!")

        # 服务器端要求：更新操作完成后等待5秒
        print("等待5秒以满足服务器端要求...")
        time.sleep(5)
        print("等待完成，继续下一步操作")

        return {
            'success': True,
            'issue_key': issue_key,
            'updated_fields': list(update_dict.keys()),
            'error': None
        }

    except JIRAError as e:
        error_msg = f"JIRA错误: {e.text} (状态码: {e.status_code})"
        print(f"[失败] {error_msg}")

        # 增强的错误日志
        try:
            if hasattr(e, 'response') and e.response:
                response_text = e.response.text
                print("--- JIRA返回的响应内容 ---")
                print(response_text)
                print("---------------------------------")

                # 尝试解析JSON
                try:
                    error_data = e.response.json()
                    if 'errors' in error_data:
                        errors = error_data['errors']
                        for field, field_error in errors.items():
                            error_msg += f" | 字段'{field}': {field_error}"
                    if 'errorMessages' in error_data:
                        for msg in error_data['errorMessages']:
                            error_msg += f" | {msg}"
                except json.JSONDecodeError:
                    error_msg += f" | 响应内容: {response_text}"

        except Exception as parse_error:
            error_msg += f" | 解析错误信息失败: {parse_error}"

        # 尝试逐个字段更新以定位问题
        print("\n--- 尝试逐个字段更新以定位问题 ---")
        try:
            # 重试更新摘要
            if 'summary' in update_dict:
                print(f"尝试更新摘要: {update_dict['summary']}")
                issue.update(fields={'summary': update_dict['summary']})
                print("摘要更新成功")

            # 重试更新经办人
            if 'assignee' in update_dict:
                print(f"尝试更新经办人: {update_dict['assignee']}")
                issue.update(fields={'assignee': update_dict['assignee']})
                print("经办人更新成功")

        except Exception as single_error:
            print(f"逐个字段更新也失败: {single_error}")
        print("-------------------------------------")

        return {
            'success': False,
            'issue_key': issue_key,
            'updated_fields': [],
            'error': error_msg
        }

    except Exception as e:
        error_msg = f"更新问题时发生异常: {str(e)}"
        print(f"[失败] {error_msg}")
        return {
            'success': False,
            'issue_key': issue_key,
            'updated_fields': [],
            'error': error_msg
        }

def batch_update_issues(jira_client, df, target_issues, add_comments=False):
    """批量更新JIRA问题"""
    print(f"\n开始批量更新 {len(target_issues)} 个JIRA问题...")
    if add_comments:
        print("模式: 更新字段 + 添加评论")
    else:
        print("模式: 仅更新字段")

    results = []
    update_success_count = 0
    update_failed_count = 0
    comment_success_count = 0
    comment_failed_count = 0

    for i, issue_key in enumerate(target_issues):
        print(f"\n{'='*60}")
        print(f"处理第 {i+1} 个问题: {issue_key}")
        print(f"{'='*60}")

        # 查找对应的Excel行数据
        # 优先通过Issue Key匹配，如果没有则按行号顺序
        matching_row = None
        row_index = 0

        for index, row in df.iterrows():
            if 'Issue Key' in row and pd.notna(row['Issue Key']):
                if str(row['Issue Key']).strip() == issue_key:
                    matching_row = row
                    row_index = index
                    break
        else:
            # 如果没有找到匹配的Issue Key，使用第一行数据
            if len(df) > i:
                matching_row = df.iloc[i]
                row_index = i
            elif len(df) > 0:
                matching_row = df.iloc[0]
                row_index = 0

        # 步骤1: 更新问题字段
        if matching_row is not None:
            update_result = update_issue_from_row(jira_client, matching_row, row_index, issue_key)
        else:
            update_result = {
                'success': False,
                'issue_key': issue_key,
                'error': '未找到对应的Excel数据行'
            }

        if update_result['success']:
            update_success_count += 1
        else:
            update_failed_count += 1
            print(f"字段更新失败，跳过添加评论")
            results.append(update_result)
            continue

        # 步骤2: 添加评论（如果启用）
        comment_result = {'success': True, 'error': None}
        if add_comments and matching_row is not None:
            ps_content = matching_row.get('PS') if pd.notna(matching_row.get('PS')) else None
            comment_success, comment_error = add_comment_to_issue(jira_client, issue_key, ps_content)

            if comment_success:
                comment_success_count += 1
                comment_result = {'success': True, 'error': None}
            else:
                comment_failed_count += 1
                comment_result = {'success': False, 'error': comment_error}
        elif add_comments:
            print("跳过添加评论（未找到PS内容）")
        else:
            print("跳过添加评论（未启用--add-comments选项）")

        # 合并结果
        combined_result = {
            'success': update_result['success'] and (not add_comments or comment_result['success']),
            'issue_key': issue_key,
            'updated_fields': update_result.get('updated_fields', []),
            'comment_added': add_comments and comment_result['success'],
            'error': update_result.get('error') or comment_result.get('error')
        }
        results.append(combined_result)

        # 处理完一个问题后等待5秒再处理下一个（服务器端要求）
        if i < len(target_issues) - 1:  # 不是最后一个问题
            print(f"\n问题 {issue_key} 处理完成，等待5秒后处理下一个问题...")
            time.sleep(5)
            print("等待完成，继续处理下一个问题")

    # 打印统计信息
    print(f"\n{'='*60}")
    print("批量更新完成统计")
    print(f"{'='*60}")
    print(f"总计处理: {len(results)} 个问题")
    print(f"字段更新成功: {update_success_count} 个")
    print(f"字段更新失败: {update_failed_count} 个")

    if add_comments:
        print(f"评论添加成功: {comment_success_count} 个")
        print(f"评论添加失败: {comment_failed_count} 个")

    # 打印详细结果
    print(f"\n=== 详细结果 ===")
    for i, result in enumerate(results):
        if result['success']:
            field_info = f"更新字段: {', '.join(result.get('updated_fields', []))}"
            comment_info = " + 添加评论" if result.get('comment_added') else ""
            print(f"第{i+1}个: [成功] {result['issue_key']} - {field_info}{comment_info}")
        else:
            print(f"第{i+1}个: [失败] {result.get('issue_key', 'Unknown')} - 错误: {result['error']}")

    return results

def validate_excel_format(df):
    """验证Excel文件格式"""
    print(f"[成功] Excel文件格式验证通过")
    return True

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='Motorola edart JIRA 问题更新工具')
    parser.add_argument('excel_file', help='Excel文件路径')
    parser.add_argument('--issues', required=True, help='要更新的问题单号，用逗号分隔 (例如: EKLAMUC-2028,EKLAMUC-2029)')
    parser.add_argument('--dry-run', action='store_true', help='仅验证数据，不实际更新问题')
    parser.add_argument('--debug', action='store_true', help='显示详细的调试信息')
    parser.add_argument('--add-comments', action='store_true', help='更新完成后添加PS列内容作为评论')

    args = parser.parse_args()

    print("=" * 80)
    print("Motorola edart JIRA 问题更新工具")
    if args.add_comments:
        print("模式: 更新字段 + 添加评论")
    else:
        print("模式: 仅更新字段")
    print("=" * 80)

    # 解析问题列表
    target_issues = [issue.strip() for issue in args.issues.split(',') if issue.strip()]
    if not target_issues:
        print("错误: 未指定要更新的问题单号")
        return 1

    print(f"要更新的问题: {', '.join(target_issues)}")

    # 连接到JIRA
    jira = connect_to_jira(JIRA_SERVER, JIRA_TOKEN)
    if not jira:
        print("无法连接到JIRA服务器")
        return 1

    # 检查文件是否存在
    if not os.path.exists(args.excel_file):
        print(f"错误: 文件不存在: {args.excel_file}")
        return 1

    # 读取Excel文件
    df = read_excel_file(args.excel_file)
    if df is None:
        return 1

    # 验证Excel格式
    if not validate_excel_format(df):
        return 1

    if len(df) == 0:
        print("错误: 没有有效的数据行")
        return 1

    print(f"有效数据行数: {len(df)}")

    if args.dry_run:
        print("\n=== 干运行模式 - 仅验证数据 ===")
        for index, row in df.iterrows():
            summary = row.get('Summary') or '未指定概要'
            print(f"第{index+1}行: {summary[:50]}...")
            if args.add_comments:
                ps_content = row.get('PS') or '无PS内容'
                print(f"  PS内容: {ps_content[:100]}...")
        print("\n要更新的问题:")
        for issue in target_issues:
            print(f"  - {issue}")
        print("验证完成，未实际更新问题")
        return 0

    # 批量更新问题
    results = batch_update_issues(jira, df, target_issues, args.add_comments)

    # 保存结果到文件
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    result_file = f"jira_motorola_edart_batch_update_result_{timestamp}.txt"

    with open(result_file, 'w', encoding='utf-8') as f:
        f.write(f"Motorola edart JIRA 批量更新结果 - {datetime.now()}\n")
        f.write(f"Excel文件: {args.excel_file}\n")
        f.write(f"JIRA服务器: {JIRA_SERVER}\n")
        f.write(f"项目: {PROJECT_KEY}\n")
        f.write(f"目标问题: {', '.join(target_issues)}\n")
        f.write(f"总计: {len(results)} 个问题\n")
        f.write(f"成功: {sum(1 for r in results if r['success'])} 个\n")
        f.write(f"失败: {sum(1 for r in results if not r['success'])} 个\n\n")

        for i, result in enumerate(results):
            if result['success']:
                f.write(f"第{i+1}个: 成功 - {result['issue_key']}\n")
                if result.get('updated_fields'):
                    f.write(f"  更新字段: {', '.join(result['updated_fields'])}\n")
                f.write(f"\n")
            else:
                f.write(f"第{i+1}个: 失败 - {result.get('issue_key', 'Unknown')}\n")
                f.write(f"  错误: {result['error']}\n\n")

    print(f"\n结果已保存到: {result_file}")

    return 0

if __name__ == "__main__":
    sys.exit(main())