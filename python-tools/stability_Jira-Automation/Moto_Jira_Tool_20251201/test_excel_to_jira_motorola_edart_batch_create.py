#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Motorola edart JIRA 批量问题创建工具
基于Excel文件批量创建JIRA问题，支持EKLAMUC项目

功能：
1. 读取Excel文件中的问题数据
2. 批量在Motorola edart JIRA中创建问题
3. 支持自定义字段和组件
4. 可选择添加PS列内容作为评论
5. 每次操作完成后自动等待5秒（服务器端要求）
6. 生成详细的创建结果报告
7. 使用Personal Access Token认证

使用方法（必须通过命令行参数传入Excel和JIRA Token）:
- 创建问题: python test_excel_to_jira_motorola_edart_batch_create.py --add-excel-file <excel文件路径> --set-jira-token <JIRA_TOKEN>
- 创建问题并添加评论: 在上面命令后追加 --add-comments
- 干运行模式: 在上面命令后追加 --dry-run（仅验证数据，不创建）
- 验证元数据: python test_excel_to_jira_motorola_edart_batch_create.py --validate-metadata
示例: python test_excel_to_jira_motorola_edart_batch_create.py --add-excel-file JIRA_Upload_List_Moto_20251121_162215.xlsx --set-jira-token <JIRA_TOKEN> --add-comments
作者：AI Assistant
创建时间：2025-01-13
更新时间：2025-01-13 (添加评论功能和等待时间)
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

script_dir = os.path.dirname(os.path.abspath(__file__))
log_dir = os.path.join(script_dir, "log")
os.makedirs(log_dir, exist_ok=True)

# JIRA服务器配置
JIRA_SERVER = 'https://edart.motorola.com'
# JIRA_TOKEN 通过命令行参数 --set-jira-token 传入
JIRA_TOKEN = ''
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

def validate_project_metadata(jira_client, project_key):
    """验证项目元数据，包括可用的组件和版本"""
    try:
        print(f"\n=== 验证项目 {project_key} 的元数据 ===")

        # 获取项目信息
        project = jira_client.project(project_key)
        print(f"项目名称: {project.name}")
        print(f"项目Key: {project.key}")

        # 获取可用的问题类型
        print(f"\n可用的问题类型:")
        issue_types = jira_client.issue_types()
        for it in issue_types:
            print(f"  - {it.name} (ID: {it.id})")

        # 获取可用的优先级
        print(f"\n可用的优先级:")
        priorities = jira_client.priorities()
        for p in priorities:
            print(f"  - {p.name} (ID: {p.id})")

        # 获取项目组件
        print(f"\n项目组件:")
        components = jira_client.project_components(project_key)
        for comp in components:
            print(f"  - {comp.name} (ID: {comp.id})")

        # 获取项目版本
        print(f"\n项目版本:")
        versions = jira_client.project_versions(project_key)
        for ver in versions:
            print(f"  - {ver.name} (ID: {ver.id}, 状态: {ver.released})")

        return True

    except Exception as e:
        print(f"验证项目元数据失败: {e}")
        return False

def read_excel_file(file_path):
    """读取Excel文件"""
    try:
        print(f"正在读取Excel文件: {file_path}")
        df = pd.read_excel(file_path, engine='openpyxl')
        print(f"成功读取 {len(df)} 行数据")

        # 显示表头信息
        print(f"表头: {list(df.columns)}")

        # 过滤掉空行
        if 'Summary' in df.columns:
            df = df.dropna(subset=['Summary'])
        elif 'summary' in df.columns:
            df = df.dropna(subset=['summary'])

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

def map_issue_type_to_name(issue_type_str):
    """将问题类型字符串映射到JIRA问题类型名称"""
    issue_type_map = {
        '故障': 'Bug',
        'Bug': 'Bug',
        'bug': 'Bug',
        '任务': 'Task',
        'Task': 'Task',
        'task': 'Task',
        '改进': 'Improvement',
        'Improvement': 'Improvement',
        '新功能': 'New Feature',
        'New Feature': 'New Feature',
        'Epic': 'Epic',
        'Story': 'Story'
    }
    return issue_type_map.get(str(issue_type_str).strip(), 'Bug')

def normalize_severity_value(severity_str):
    """将Severity值映射到JIRA允许的选项"""
    allowed_values = {'blocker', 'critical', 'major', 'minor', 'trivial'}
    severity_map = {
        '1': 'Blocker',
        'block': 'Blocker',
        'blocker': 'Blocker',
        '2': 'Critical',
        'critical': 'Critical',
        '3': 'Major',
        'major': 'Major',
        '4': 'Minor',
        'minor': 'Minor',
        '5': 'Trivial',
        'trivial': 'Trivial'
    }

    if severity_str is None or str(severity_str).strip().lower() == 'nan':
        return 'Major'

    cleaned = str(severity_str).strip()
    mapped = severity_map.get(cleaned.lower(), cleaned)

    if mapped.lower() not in allowed_values:
        print(f"[警告] Severity值 '{cleaned}' 不在允许列表 {sorted(allowed_values)}, 使用默认值 'Major'")
        return 'Major'

    if mapped != cleaned:
        print(f"[提示] 将Severity '{cleaned}' 映射为 '{mapped}'")

    return mapped

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

def build_version_lookup(jira_client):
    """获取项目版本映射，便于校验Excel中的版本值"""
    try:
        versions = jira_client.project_versions(PROJECT_KEY)
        lookup = {str(ver.name).lower(): ver.name for ver in versions}
        print(f"已加载 {len(lookup)} 个项目版本用于校验")
        return lookup
    except Exception as exc:
        print(f"[警告] 获取项目版本列表失败，将直接使用Excel中的版本值: {exc}")
        return {}

def normalize_versions(versions_col, version_lookup):
    """校验并规范版本字段，未知版本回退为 n/a 以避免400错误"""
    if not versions_col or str(versions_col).strip() in ('', 'nan'):
        fallback = version_lookup.get('n/a', 'n/a') if version_lookup else 'n/a'
        return [{'name': fallback}], []

    version_names = [ver.strip() for ver in str(versions_col).split(',') if ver.strip()]
    if not version_lookup:
        return [{'name': name} for name in version_names], []

    normalized_versions = []
    invalid_versions = []
    for name in version_names:
        matched = version_lookup.get(name.lower())
        if matched:
            normalized_versions.append({'name': matched})
        else:
            invalid_versions.append(name)

    if invalid_versions:
        print(f"[警告] 版本 {', '.join(invalid_versions)} 不在项目版本列表中，使用 'n/a' 替代")

    if not normalized_versions:
        fallback = version_lookup.get('n/a', 'n/a')
        normalized_versions = [{'name': fallback}]

    return normalized_versions, invalid_versions

def add_comment_to_issue(jira_client, issue_key, comment_body, current_user=None):
    """向JIRA问题添加评论"""
    try:
        print(f"\n--- 添加评论到问题 {issue_key} ---")

        if not comment_body or str(comment_body).strip() == 'nan':
            print("评论内容为空，跳过添加评论")
            return True, None

        reporter = f"\n*Reporter :* {str(current_user).strip().lower()}"

        extra_note = ""
        if current_user and str(current_user).strip().lower() == "tin_xiuzhe.zhang_tmp@extlenovo.com":
            extra_note = "\n*对此单存在疑问，需要咨询测试时，请联系：王启明（qiming.wang1@tinno.com）*\n"

        # 格式化评论内容
        formatted_comment = f"""{comment_body}{reporter}{extra_note}

---
*//172.21.15.4 天珑 Log 服务器路径如下：*
内网FTP访问：
文件管理器中输入ftp://172.21.15.4 账号:jxtinno 密码：tinno@2025
公网访问：
使用filezilla工具连接 地址：220.175.120.251 账号：jxtinno 密码：tinno@2025  端口不用设置  
连接成功后即可访问
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

def create_issue_from_row(jira_client, row, row_index, version_lookup=None):
    """根据Excel行数据创建JIRA问题"""
    summary = '未指定概要' # 在try块外初始化，以备后续错误处理使用
    try:
        print(f"\n--- 创建第 {row_index + 1} 个问题 ---")

        # 获取基本字段（支持大小写不敏感的列名）
        summary = row.get('Summary') or row.get('summary') or '未指定概要'
        issue_type_raw = row.get('Issue Type') or row.get('issuetype') or '故障'
        description = row.get('Description') or row.get('description') or '通过Excel批量导入创建'
        priority_raw = row.get('Priority') or row.get('priority') or '重要'
        assignee = row.get('Assignee') or row.get('assignee') or ''

        # 映射字段值
        issue_type = map_issue_type_to_name(issue_type_raw)
        priority = map_priority_to_name(priority_raw)

        # 构建问题数据
        issue_dict = {
            'project': {'key': str(row.get('Project') or row.get('project') or PROJECT_KEY)},
            'issuetype': {'name': str(issue_type)},
            'summary': str(summary),
            'description': str(description),
            'priority': {'name': str(priority)}
        }

        # 添加经办人（如果提供） - 暂时注释掉以测试是否是assignee导致的问题
        # if assignee and str(assignee).strip() and str(assignee).strip() != 'nan':
        #     issue_dict['assignee'] = {'name': str(assignee)}

        # 添加组件（必填字段）
        components_col = row.get('Components') or row.get('components')
        if components_col and str(components_col).strip() and str(components_col).strip() != 'nan':
            component_names = [comp.strip() for comp in str(components_col).split(',')]
            components = [{'name': name} for name in component_names]
            if components:
                issue_dict['components'] = components
        else:
            # 如果没有指定组件，使用默认组件
            issue_dict['components'] = [{'name': 'n/a'}]

        # 添加影响版本（必填字段）
        versions_col = row.get('Versions') or row.get('versions')
        normalized_versions, invalid_versions = normalize_versions(versions_col, version_lookup)
        issue_dict['versions'] = normalized_versions

        # 添加标签字段
        label_col = row.get('Label') or row.get('label') or row.get('Labels') or row.get('labels')
        if label_col and str(label_col).strip() and str(label_col).strip() != 'nan':
            import re
            label_str = str(label_col).strip()
            labels = re.split(r'[,;，；\s]+', label_str)
            labels = [label.strip() for label in labels if label.strip()]
            if labels:
                issue_dict['labels'] = labels

        # 添加自定义字段（必填字段）
        custom_fields_mapping = {
            'Severity': 'customfield_10017',
            'Team Found': 'customfield_10198',
            'Product Affected': 'customfield_11016'
        }

        # 设置默认值
        custom_field_defaults = {
            'customfield_10017': 'Major',  # Severity默认值
            'customfield_10198': 'ODM',    # Team Found默认值
            'customfield_11016': 'Lamu26 (lamuc)'  # Product Affected默认值
        }

        # 首先设置默认值
        for field_key, default_value in custom_field_defaults.items():
            issue_dict[field_key] = {'value': default_value}

        # 然后用Excel中的值覆盖
        for display_name, field_key in custom_fields_mapping.items():
            if display_name in row and pd.notna(row[display_name]):
                value = str(row[display_name]).strip()
                if value:
                    if field_key == 'customfield_10017':
                        value = normalize_severity_value(value)
                    issue_dict[field_key] = {'value': value}

        # 打印创建信息
        print(f"概要: {summary[:80]}..." if len(summary) > 80 else f"概要: {summary}")
        print(f"项目: {issue_dict['project']['key']}")
        print(f"问题类型: {issue_dict['issuetype']['name']}")
        print(f"优先级: {issue_dict['priority']['name']}")
        if 'labels' in issue_dict:
            print(f"标签: {', '.join(issue_dict['labels'])}")
        if 'components' in issue_dict:
            component_names = [comp['name'] for comp in issue_dict['components']]
            print(f"组件: {', '.join(component_names)}")
        if 'versions' in issue_dict:
            version_names = [ver['name'] for ver in issue_dict['versions']]
            print(f"影响版本: {', '.join(version_names)}")

        # 打印完整的请求数据（调试用）
        print("--- 发送给JIRA的数据 ---")
        print(json.dumps(issue_dict, indent=2, ensure_ascii=False))
        print("------------------------")

        # 创建问题
        new_issue = jira_client.create_issue(fields=issue_dict)

        print(f"[成功] 问题创建成功!")
        print(f"问题Key: {new_issue.key}")
        print(f"问题链接: {JIRA_SERVER}/browse/{new_issue.key}")

        # 服务器端要求：创建操作完成后等待5秒
        print("等待5秒以满足服务器端要求...")
        time.sleep(5)
        print("等待完成，继续下一步操作")

        return {
            'success': True,
            'issue_key': new_issue.key,
            'issue_url': f"{JIRA_SERVER}/browse/{new_issue.key}",
            'summary': summary,
            'error': None
        }

    except JIRAError as e:
        error_msg = f"JIRA错误: {e.text} (状态码: {e.status_code})"
        print(f"[失败] {error_msg}")

        # --- 增强的错误日志 ---
        try:
            response_text = getattr(getattr(e, 'response', None), 'text', '')
            if response_text:
                print("--- JIRA返回的响应内容 ---")
                print(response_text)
                print("---------------------------------")

                # 尝试解析JSON
                try:
                    error_data = json.loads(response_text)
                    if 'errors' in error_data:
                        errors = error_data['errors']
                        for field, field_error in errors.items():
                            error_msg += f" | 字段'{field}': {field_error}"
                    if 'errorMessages' in error_data:
                        for msg in error_data['errorMessages']:
                            error_msg += f" | {msg}"
                except json.JSONDecodeError:
                    error_msg += f" | 响应内容: {response_text}"
            else:
                error_msg += f" | 原始异常: {e}"

            # 附加其他错误信息
            if hasattr(e, 'text') and e.text:
                error_msg += f" | 错误文本: {e.text}"
            if hasattr(e, 'status_code') and e.status_code:
                error_msg += f" | 状态码: {e.status_code}"
            if hasattr(e, 'url') and e.url:
                error_msg += f" | URL: {e.url}"

        except Exception as parse_error:
            error_msg += f" | 解析错误信息失败: {parse_error}"

        return {
            'success': False,
            'issue_key': None,
            'issue_url': None,
            'summary': str(summary),
            'error': error_msg
        }

    except Exception as e:
        error_msg = f"创建问题时发生异常: {str(e)}"
        print(f"[失败] {error_msg}")
        return {
            'success': False,
            'issue_key': None,
            'issue_url': None,
            'summary': str(summary),
            'error': error_msg
        }

def batch_create_issues_direct_api(jira_client, df, add_comments=False, current_user=None):
    """使用直接API批量创建JIRA问题"""
    print(f"\n开始批量创建 {len(df)} 个JIRA问题（使用直接API）...")
    if add_comments:
        print("模式: 创建问题 + 添加评论")
    else:
        print("模式: 仅创建问题")

    results = []
    create_success_count = 0
    create_failed_count = 0
    comment_success_count = 0
    comment_failed_count = 0
    version_lookup = build_version_lookup(jira_client)

    for index, row in df.iterrows():
        print(f"\n{'='*60}")
        print(f"处理第 {index + 1} 行数据")
        print(f"{'='*60}")

        # 步骤1: 创建问题
        create_result = create_issue_from_row(jira_client, row, index, version_lookup)

        if create_result['success']:
            create_success_count += 1

            # 步骤2: 添加评论（如果启用且创建成功）
            comment_result = {'success': True, 'error': None}
            if add_comments and create_result['issue_key']:
                ps_content = row.get('PS') if pd.notna(row.get('PS')) else None
                comment_success, comment_error = add_comment_to_issue(
                    jira_client,
                    create_result['issue_key'],
                    ps_content,
                    current_user=current_user,
                )

                if comment_success:
                    comment_success_count += 1
                    comment_result = {'success': True, 'error': None}
                else:
                    comment_failed_count += 1
                    comment_result = {'success': False, 'error': comment_error}
            elif add_comments:
                print("跳过添加评论（问题创建失败或未找到PS内容）")
            else:
                print("跳过添加评论（未启用--add-comments选项）")

            # 合并结果
            combined_result = {
                'success': create_result['success'] and (not add_comments or comment_result['success']),
                'issue_key': create_result['issue_key'],
                'issue_url': create_result['issue_url'],
                'summary': create_result['summary'],
                'comment_added': add_comments and comment_result['success'],
                'error': create_result.get('error') or comment_result.get('error')
            }
            results.append(combined_result)

        else:
            create_failed_count += 1
            results.append(create_result)

        # 处理完一个问题后等待5秒再处理下一个（服务器端要求）
        if index < len(df) - 1:  # 不是最后一个问题
            print(f"\n第 {index + 1} 行处理完成，等待5秒后处理下一行...")
            time.sleep(5)
            print("等待完成，继续处理下一行")

    # 打印统计信息
    print(f"\n{'='*60}")
    print("批量创建完成统计")
    print(f"{'='*60}")
    print(f"总计处理: {len(results)} 个问题")
    print(f"问题创建成功: {create_success_count} 个")
    print(f"问题创建失败: {create_failed_count} 个")

    if add_comments:
        print(f"评论添加成功: {comment_success_count} 个")
        print(f"评论添加失败: {comment_failed_count} 个")

    # 打印详细结果
    print(f"\n=== 详细结果 ===")
    for i, result in enumerate(results):
        if result['success']:
            summary_short = result['summary'][:50] + "..." if len(result['summary']) > 50 else result['summary']
            comment_info = " + 添加评论" if result.get('comment_added') else ""
            print(f"第{i+1}行: [成功] {result.get('issue_key', 'Unknown')} - {summary_short}{comment_info}")
        else:
            summary_short = result['summary'][:50] + "..." if len(result['summary']) > 50 else result['summary']
            print(f"第{i+1}行: [失败] - {summary_short}")
            print(f"      错误: {result['error']}")

    return results

def validate_excel_format(df):
    """验证Excel文件格式"""
    # 检查必需的列（支持大小写不敏感）
    required_columns_lower = ['summary']
    df_columns_lower = [col.lower() for col in df.columns]

    missing_columns = []
    for req_col in required_columns_lower:
        if req_col not in df_columns_lower:
            missing_columns.append(req_col)

    if missing_columns:
        print(f"[错误] Excel文件缺少必需的列: {missing_columns}")
        print(f"当前列: {list(df.columns)}")
        return False

    print(f"[成功] Excel文件格式验证通过")
    return True

def test_simple_issue(jira_client):
    """测试创建一个简单的JIRA问题"""
    try:
        print(f"\n=== 测试创建简单JIRA问题 ===")

        simple_issue = {
            'project': {'key': PROJECT_KEY},
            'issuetype': {'name': 'Bug'},
            'summary': 'Test Issue - Simple Bug Report',
            'description': 'This is a test issue created via API to verify basic functionality.',
            'priority': {'name': '3'},
            'components': [{'name': 'SW_APP_Settings'}],  # 必填字段
            'versions': [{'name': 'VVTB35.12'}],  # 必填字段
            'customfield_10017': {'value': 'Major'},  # Severity - 必填字段
            'customfield_10198': {'value': 'ODM'},  # Team Found - 必填字段
            'customfield_11016': {'value': 'Lamu26 (lamuc)'}  # Product Affected - 必填字段
        }

        print("创建的简单问题数据:")
        print(json.dumps(simple_issue, indent=2, ensure_ascii=False))

        new_issue = jira_client.create_issue(fields=simple_issue)

        print(f"[成功] 简单问题创建成功!")
        print(f"问题Key: {new_issue.key}")
        print(f"问题链接: {JIRA_SERVER}/browse/{new_issue.key}")

        return new_issue.key

    except Exception as e:
        print(f"[失败] 创建简单问题失败: {e}")
        return None

def get_custom_field_options(jira_client, field_key):
    """获取自定义字段的选项"""
    try:
        print(f"\n获取自定义字段 {field_key} 的选项:")

        # 尝试获取字段选项
        field = jira_client.field(field_key)
        print(f"字段名称: {field.name}")
        print(f"字段ID: {field.id}")
        print(f"字段类型: {getattr(field, 'schema', {}).get('type', 'Unknown')}")

        # 获取允许的值
        if hasattr(field, 'allowedValues'):
            print("允许的值:")
            for value in field.allowedValues:
                print(f"  - {value}")

        return True

    except Exception as e:
        print(f"获取字段选项失败: {e}")
        return False

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='Motorola edart JIRA 批量问题创建工具')
    parser.add_argument('--add-excel-file', dest='excel_file', help='Excel文件路径（必填，执行创建时需要）')
    parser.add_argument('--set-jira-token', dest='jira_token', required=True, help='JIRA Personal Access Token（必填）')
    parser.add_argument('--dry-run', action='store_true', help='仅验证数据，不实际创建问题')
    parser.add_argument('--validate-metadata', action='store_true', help='验证项目元数据（组件、版本等）')
    parser.add_argument('--test-simple', action='store_true', help='测试创建简单的JIRA问题')
    parser.add_argument('--add-comments', action='store_true', help='创建完成后添加PS列内容作为评论')

    # 无参数时打印帮助并退出
    if len(sys.argv) == 1:
        parser.print_help()
        return 0

    args = parser.parse_args()
    excel_path = args.excel_file
    jira_token = args.jira_token
    if not jira_token or not str(jira_token).strip():
        print("错误: 需要提供有效的JIRA Token（--set-jira-token）")
        return 1

    print("=" * 80)
    print("Motorola edart JIRA 批量问题创建工具")
    if args.add_comments:
        print("模式: 创建问题 + 添加评论")
    else:
        print("模式: 仅创建问题")
    print("=" * 80)

    # 连接到JIRA
    jira = connect_to_jira(JIRA_SERVER, jira_token)
    if not jira:
        print("无法连接到JIRA服务器")
        return 1
    current_user = None
    try:
        current_user = jira.current_user()
    except Exception:
        pass

    # 如果请求验证元数据
    if args.validate_metadata:
        validate_project_metadata(jira, PROJECT_KEY)
        return 0

    # 如果请求测试简单问题
    if args.test_simple:
        test_simple_issue(jira)
        return 0

    # 如果不是验证元数据/测试，则需要Excel文件
    if not excel_path and not args.validate_metadata and not args.test_simple:
        print("错误: 需要提供Excel文件路径")
        parser.print_help()
        return 1

    # 检查文件是否存在
    if excel_path and not os.path.exists(excel_path):
        print(f"错误: 文件不存在: {excel_path}")
        return 1

    # 读取Excel文件
    df = read_excel_file(excel_path)
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
            summary = row.get('Summary') or row.get('summary') or '未指定概要'
            print(f"第{index+1}行: {summary[:50]}...")
            if args.add_comments:
                ps_content = row.get('PS') or '无PS内容'
                print(f"  PS内容: {ps_content[:100]}...")
        print("验证完成，未实际创建问题")
        return 0

    # 创建前确认
    confirm = input("\n确认要在JIRA上创建这些问题吗？(y/n): ").strip().lower()
    if confirm not in ('y', 'yes'):
        print("已取消创建操作")
        return 0

    # 使用直接API批量创建问题
    results = batch_create_issues_direct_api(jira, df, args.add_comments, current_user=current_user)

    # 保存结果到文件
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    result_file = f"jira_motorola_edart_batch_create_result_{timestamp}.txt"
    result_path = os.path.join(log_dir, result_file)

    with open(result_path, 'w', encoding='utf-8') as f:
        f.write(f"Motorola edart JIRA 批量创建结果 - {datetime.now()}\n")
        f.write(f"Excel文件: {excel_path}\n")
        f.write(f"JIRA服务器: {JIRA_SERVER}\n")
        f.write(f"项目: {PROJECT_KEY}\n")
        f.write(f"模式: {'创建问题+添加评论' if args.add_comments else '仅创建问题'}\n")
        f.write(f"总计: {len(results)} 个问题\n")
        f.write(f"成功: {sum(1 for r in results if r['success'])} 个\n")
        f.write(f"失败: {sum(1 for r in results if not r['success'])} 个\n\n")

        for i, result in enumerate(results):
            if result['success']:
                f.write(f"第{i+1}行: 成功 - {result['summary']}\n")
                f.write(f"  问题Key: {result['issue_key']}\n")
                f.write(f"  链接: {result['issue_url']}\n")
                if result.get('comment_added'):
                    f.write(f"  已添加评论\n")
                f.write(f"\n")
            else:
                f.write(f"第{i+1}行: 失败 - {result['summary']}\n")
                f.write(f"  错误: {result['error']}\n\n")

    print(f"\n结果已保存到: {result_path}")

    return 0

if __name__ == "__main__":
    sys.exit(main())
