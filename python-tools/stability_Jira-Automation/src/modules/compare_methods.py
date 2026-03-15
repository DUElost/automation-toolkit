#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
比较直接创建和批量创建的方法差异
"""

import os
import pandas as pd
import requests
import json
import urllib3

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# JIRA服务器配置
JIRA_SERVER = 'https://edart.motorola.com'
JIRA_TOKEN = os.getenv('JIRA_TOKEN', '')

def build_issue_data_batch_method():
    """使用批量创建方法构建数据"""
    print("=== 批量创建方法 ===")

    excel_file = "jira_motorola_edart_template_20251013_001616.xlsx"
    df = pd.read_excel(excel_file, engine='openpyxl')
    row = df.iloc[0]

    print("原始Excel数据:")
    for col in df.columns:
        value = row[col]
        if pd.notna(value):
            print(f"  {col}: {value}")

    # 构建问题数据（模拟批量创建脚本的方法）
    issue_dict = {
        'fields': {
            'project': {'key': str(row.get('Project', 'EKLAMUC')).strip()},
            'issuetype': {'name': str(row.get('Issue Type', '故障')).strip()},
            'summary': str(row.get('Summary', '')).strip(),
            'description': str(row.get('Description', '')).strip(),
            'priority': {'name': str(int(row.get('Priority', 3)))},
            'versions': [{'name': str(row.get('Versions', 'n/a')).strip()}]
        }
    }

    # 添加组件
    if pd.notna(row.get('Components')) and str(row.get('Components')).strip():
        components = [{"name": str(row.get('Components')).strip()}]
        issue_dict['fields']['components'] = components

    # 添加标签字段
    label_col = row.get('Label') or row.get('label') or row.get('Labels') or row.get('labels')
    print(f"\n标签处理:")
    print(f"  原始值: {label_col}")
    print(f"  类型: {type(label_col)}")
    print(f"  pd.notna: {pd.notna(label_col)}")
    print(f"  str().strip(): '{str(label_col).strip()}'")
    print(f"  str().strip() != 'nan': {str(label_col).strip() != 'nan'}")

    if label_col and str(label_col).strip() and str(label_col).strip() != 'nan':
        label_str = str(label_col).strip()
        print(f"  处理后字符串: '{label_str}'")

        import re
        labels = re.split(r'[,;，；\s]+', label_str)
        labels = [label.strip() for label in labels if label.strip()]
        print(f"  分割后标签: {labels}")

        if labels:
            issue_dict['fields']['labels'] = labels
            print(f"  添加到issue_dict: {labels}")

    # 添加自定义字段
    custom_fields_mapping = {
        'Severity': 'customfield_10017',
        'Team Found': 'customfield_10198',
        'Product Affected': 'customfield_11016'
    }

    for display_name, field_key in custom_fields_mapping.items():
        if display_name in row and pd.notna(row[display_name]):
            value = str(row[display_name]).strip()
            if value:  # 只有当值不为空时才添加
                # 所有这些自定义字段都需要使用 {'value': 'value'} 格式
                issue_dict['fields'][field_key] = {'value': value}
                print(f"  添加自定义字段 {field_key}: {value}")

    print(f"\n批量方法构建的JIRA数据:")
    print(json.dumps(issue_dict, ensure_ascii=False, indent=2))

    return issue_dict

def build_issue_data_direct_method():
    """使用直接方法构建数据"""
    print("\n=== 直接创建方法 ===")

    excel_file = "jira_motorola_edart_template_20251013_001616.xlsx"
    df = pd.read_excel(excel_file, engine='openpyxl')
    row = df.iloc[0]

    # 构建问题数据（直接方法）
    issue_data = {
        "fields": {
            "project": {"key": str(row.get('Project', 'EKLAMUC')).strip()},
            "issuetype": {"name": str(row.get('Issue Type', '故障')).strip()},
            "summary": str(row.get('Summary', '')).strip(),
            "description": str(row.get('Description', '')).strip(),
            "priority": {"name": str(int(row.get('Priority', 3)))},
            "versions": [{"name": str(row.get('Versions', 'n/a')).strip()}]
        }
    }

    # 添加组件
    if pd.notna(row.get('Components')) and str(row.get('Components')).strip():
        components = [{"name": str(row.get('Components')).strip()}]
        issue_data["fields"]["components"] = components

    # 添加标签字段
    label_col = row.get('Label')
    if pd.notna(label_col) and str(label_col).strip():
        import re
        label_str = str(label_col).strip()
        labels = re.split(r'[,;，；\s]+', label_str)
        labels = [label.strip() for label in labels if label.strip()]
        if labels:
            issue_data["fields"]["labels"] = labels

    # 添加自定义字段
    custom_fields = {
        'Severity': 'customfield_10017',
        'Team Found': 'customfield_10198',
        'Product Affected': 'customfield_11016'
    }

    for display_name, field_key in custom_fields.items():
        if pd.notna(row.get(display_name)):
            value = str(row.get(display_name)).strip()
            if value:
                issue_data["fields"][field_key] = {"value": value}

    print(f"直接方法构建的JIRA数据:")
    print(json.dumps(issue_data, ensure_ascii=False, indent=2))

    return issue_data

def compare_data(data1, data2):
    """比较两个数据结构"""
    print(f"\n=== 数据比较 ===")

    # 转换为JSON字符串进行比较
    json1 = json.dumps(data1, ensure_ascii=False, sort_keys=True, indent=2)
    json2 = json.dumps(data2, ensure_ascii=False, sort_keys=True, indent=2)

    if json1 == json2:
        print("✅ 两种方法构建的数据完全相同")
        return True
    else:
        print("❌ 两种方法构建的数据有差异")
        print("\n批量方法数据:")
        print(json1)
        print("\n直接方法数据:")
        print(json2)
        return False

def main():
    """主函数"""
    print("JIRA创建方法比较工具")
    print("=" * 60)

    # 构建两种方法的数据
    data1 = build_issue_data_batch_method()
    data2 = build_issue_data_direct_method()

    # 比较数据
    is_same = compare_data(data1, data2)

    if is_same:
        print(f"\n结论: 两种方法构建的数据相同，问题可能在别处")
    else:
        print(f"\n结论: 两种方法构建的数据不同，需要修复批量创建脚本")

    return 0 if is_same else 1

if __name__ == "__main__":
    exit(main())