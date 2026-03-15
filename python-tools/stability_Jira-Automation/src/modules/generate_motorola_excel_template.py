#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
基于Motorola edart JIRA项目元数据生成Excel模板

根据获取的EKLAMUC项目信息生成创建问题所需的Excel模板
包含所有必填字段和常用自定义字段
"""

import pandas as pd
import json
from datetime import datetime

def load_metadata():
    """加载JIRA元数据"""
    try:
        with open('motorola_project_info.json', 'r', encoding='utf-8') as f:
            project_info = json.load(f)

        with open('motorola_createmeta.json', 'r', encoding='utf-8') as f:
            createmeta = json.load(f)

        return project_info, createmeta
    except Exception as e:
        print(f"加载元数据失败: {e}")
        return None, None

def extract_bug_fields(createmeta):
    """提取Bug类型的字段信息"""
    if not createmeta or 'projects' not in createmeta:
        return []

    project = createmeta['projects'][0]
    issue_types = project.get('issuetypes', [])

    # 查找故障类型
    bug_type = None
    for issue_type in issue_types:
        if issue_type.get('name') == '故障':
            bug_type = issue_type
            break

    if not bug_type:
        print("未找到故障类型")
        return []

    fields = bug_type.get('fields', {})
    field_list = []

    for field_key, field_info in fields.items():
        field_data = {
            'key': field_key,
            'name': field_info.get('name', ''),
            'required': field_info.get('required', False),
            'type': field_info.get('schema', {}).get('type', ''),
            'description': field_info.get('description', ''),
            'allowed_values': []
        }

        # 处理允许值
        if 'allowedValues' in field_info and field_info['allowedValues']:
            field_data['allowed_values'] = [
                value.get('name', value.get('value', str(value)))
                for value in field_info['allowedValues']
            ]

        field_list.append(field_data)

    return field_list

def create_excel_template(project_info, bug_fields):
    """创建Excel模板"""

    # 基础列定义
    template_columns = [
        {
            'column_name': 'Project',
            'display_name': '项目',
            'field_key': 'project',
            'required': True,
            'type': 'project',
            'description': '项目Key，固定为EKLAMUC',
            'default_value': 'EKLAMUC',
            'allowed_values': ['EKLAMUC']
        },
        {
            'column_name': 'Issue Type',
            'display_name': '问题类型',
            'field_key': 'issuetype',
            'required': True,
            'type': 'issuetype',
            'description': '问题类型，通常选择故障',
            'default_value': '故障',
            'allowed_values': ['故障']
        },
        {
            'column_name': 'Summary',
            'display_name': '概要',
            'field_key': 'summary',
            'required': True,
            'type': 'string',
            'description': '问题的简短描述，必填',
            'default_value': '',
            'allowed_values': []
        },
        {
            'column_name': 'Description',
            'display_name': '描述',
            'field_key': 'description',
            'required': False,
            'type': 'string',
            'description': '问题的详细描述',
            'default_value': '',
            'allowed_values': []
        },
        {
            'column_name': 'Priority',
            'display_name': '优先级',
            'field_key': 'priority',
            'required': False,
            'type': 'priority',
            'description': '问题优先级',
            'default_value': '重要',
            'allowed_values': ['1', '2', '3', '4', '5', '紧急', '高', '重要', '低', '微小']
        },
        {
            'column_name': 'Assignee',
            'display_name': '经办人',
            'field_key': 'assignee',
            'required': False,
            'type': 'user',
            'description': '分配给的用户名或邮箱',
            'default_value': '',
            'allowed_values': []
        },
        {
            'column_name': 'Components',
            'display_name': '组件',
            'field_key': 'components',
            'required': False,
            'type': 'array',
            'description': '影响的组件，多个组件用逗号分隔',
            'default_value': '',
            'allowed_values': [comp['name'] for comp in project_info.get('components', [])]
        },
        {
            'column_name': 'Versions',
            'display_name': '影响版本',
            'field_key': 'versions',
            'required': True,
            'type': 'array',
            'description': '影响的版本，必填，多个版本用逗号分隔',
            'default_value': 'n/a',
            'allowed_values': [version['name'] for version in project_info.get('versions', [])]
        }
    ]

    # 添加自定义字段
    custom_fields_mapping = {
        'customfield_10017': 'Severity',
        'customfield_10198': 'Team Found',
        'customfield_11016': 'Product Affected'
    }

    for field in bug_fields:
        field_key = field['key']
        field_name = field['name']

        # 跳过已经在基础字段中的字段
        basic_keys = ['summary', 'description', 'priority', 'assignee', 'project', 'issuetype', 'versions', 'components']
        if any(basic_key in field_key.lower() for basic_key in basic_keys):
            continue

        # 添加自定义字段
        if field_key in custom_fields_mapping:
            template_columns.append({
                'column_name': custom_fields_mapping[field_key],
                'display_name': field_name,
                'field_key': field_key,
                'required': field['required'],
                'type': field['type'],
                'description': field['description'],
                'default_value': '',
                'allowed_values': field['allowed_values']
            })

    # 创建DataFrame
    columns = [col['column_name'] for col in template_columns]
    df = pd.DataFrame(columns=columns)

    # 添加示例数据行
    sample_row = {}
    for col in template_columns:
        column_name = col['column_name']
        if column_name == 'Project':
            sample_row[column_name] = col['default_value']
        elif column_name == 'Issue Type':
            sample_row[column_name] = col['default_value']
        elif column_name == 'Summary':
            sample_row[column_name] = '示例：应用在打开时发生崩溃'
        elif column_name == 'Description':
            sample_row[column_name] = '详细描述问题发生的步骤：\n1. 打开应用\n2. 执行某个操作\n3. 应用崩溃'
        elif column_name == 'Priority':
            sample_row[column_name] = col['default_value']
        elif column_name == 'Versions':
            sample_row[column_name] = col['default_value']
        elif col['allowed_values'] and column_name not in ['Project', 'Issue Type']:
            sample_row[column_name] = col['allowed_values'][0]
        elif col['required']:
            sample_row[column_name] = f'请填写{col["display_name"]}'
        else:
            sample_row[column_name] = ''

    df = pd.concat([df, pd.DataFrame([sample_row])], ignore_index=True)

    return df, template_columns

def generate_field_descriptions(template_columns):
    """生成字段说明表"""
    field_data = []
    for col in template_columns:
        field_data.append({
            '列名': col['column_name'],
            '显示名称': col['display_name'],
            '字段Key': col['field_key'],
            '必填': '是' if col['required'] else '否',
            '类型': col['type'],
            '描述': col['description'],
            '默认值': col.get('default_value', ''),
            '允许值': ', '.join(col['allowed_values']) if col['allowed_values'] else ''
        })

    return pd.DataFrame(field_data)

def generate_components_list(project_info):
    """生成组件列表"""
    components = project_info.get('components', [])
    component_data = []
    for comp in components:
        component_data.append({
            '组件名称': comp['name'],
            '描述': comp.get('description', ''),
            'ID': comp['id']
        })

    return pd.DataFrame(component_data)

def generate_versions_list(project_info):
    """生成版本列表"""
    versions = project_info.get('versions', [])
    version_data = []
    for version in versions:
        version_data.append({
            '版本名称': version['name'],
            'ID': version['id'],
            '已发布': '是' if version.get('released', False) else '否',
            '已归档': '是' if version.get('archived', False) else '否',
            '发布日期': version.get('releaseDate', ''),
            '开始日期': version.get('startDate', '')
        })

    return pd.DataFrame(version_data)

def main():
    """主函数"""
    print("=" * 60)
    print("Motorola edart JIRA Excel模板生成器")
    print("=" * 60)

    # 加载元数据
    project_info, createmeta = load_metadata()
    if not project_info or not createmeta:
        print("❌ 无法加载元数据，请先运行 test_jira_motorola_simple.py")
        return 1

    print(f"项目: {project_info['name']} ({project_info['key']})")

    # 提取Bug字段
    bug_fields = extract_bug_fields(createmeta)
    print(f"找到 {len(bug_fields)} 个Bug相关字段")

    # 创建Excel模板
    df_template, template_columns = create_excel_template(project_info, bug_fields)

    # 生成其他工作表
    df_field_descriptions = generate_field_descriptions(template_columns)
    df_components = generate_components_list(project_info)
    df_versions = generate_versions_list(project_info)

    # 保存Excel文件
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    excel_filename = f"jira_motorola_edart_template_{timestamp}.xlsx"

    with pd.ExcelWriter(excel_filename, engine='openpyxl') as writer:
        # 问题模板
        df_template.to_excel(writer, sheet_name='Issue Template', index=False)

        # 字段说明
        df_field_descriptions.to_excel(writer, sheet_name='Field Descriptions', index=False)

        # 组件列表
        df_components.to_excel(writer, sheet_name='Components', index=False)

        # 版本列表
        df_versions.to_excel(writer, sheet_name='Versions', index=False)

    print(f"✅ Excel模板已生成: {excel_filename}")
    print(f"\n模板包含 {len(template_columns)} 个字段:")
    print(f"  必填字段: {len([c for c in template_columns if c['required']])} 个")
    print(f"  可选字段: {len([c for c in template_columns if not c['required']])} 个")
    print(f"  组件数量: {len(project_info.get('components', []))} 个")
    print(f"  版本数量: {len(project_info.get('versions', []))} 个")

    print(f"\n工作表:")
    print(f"  - Issue Template: 问题创建模板")
    print(f"  - Field Descriptions: 字段说明")
    print(f"  - Components: 可用组件列表")
    print(f"  - Versions: 可用版本列表")

    return 0

if __name__ == "__main__":
    exit(main())