#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
详细的JIRA错误调试工具
获取400错误的具体原因
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

def debug_excel_issue_creation():
    """调试Excel问题创建的详细错误"""
    print("调试Excel问题创建 - 详细错误分析")
    print("=" * 60)

    excel_file = "jira_motorola_edart_template_20251013_001616.xlsx"

    try:
        df = pd.read_excel(excel_file, engine='openpyxl')
        print(f"成功读取Excel文件，共 {len(df)} 行")

        if len(df) == 0:
            print("Excel文件中没有数据")
            return False

        row = df.iloc[0]

        print("\n=== Excel数据详情 ===")
        for col in df.columns:
            value = row[col]
            if pd.notna(value):
                print(f"{col}: {value}")
            else:
                print(f"{col}: [空]")

        # 构建完整的JIRA问题数据
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

        # 添加标签
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

        print(f"\n=== 构建的JIRA数据 ===")
        print(json.dumps(issue_data, ensure_ascii=False, indent=2))

        # 发送请求并获取详细错误
        return create_issue_with_detailed_error(issue_data)

    except Exception as e:
        print(f"处理Excel数据时发生错误: {e}")
        return False

def create_issue_with_detailed_error(issue_data):
    """创建JIRA问题并获取详细错误信息"""
    try:
        url = f"{JIRA_SERVER}/rest/api/2/issue"
        headers = {
            "Authorization": f"Bearer {JIRA_TOKEN}",
            "Accept": "application/json",
            "Content-Type": "application/json"
        }

        print(f"\n=== 发送请求 ===")
        print(f"URL: {url}")
        print(f"Method: POST")

        response = requests.post(url, headers=headers, json=issue_data, timeout=30, verify=False)

        print(f"\n=== 响应信息 ===")
        print(f"状态码: {response.status_code}")
        print(f"响应头: {dict(response.headers)}")

        if response.status_code == 201:
            result = response.json()
            print(f"✅ 成功创建问题: {result['key']}")
            print(f"问题链接: {JIRA_SERVER}/browse/{result['key']}")
            return True
        else:
            print(f"❌ 创建失败")
            print(f"响应状态码: {response.status_code}")
            print(f"响应内容:")

            try:
                error_data = response.json()
                print(json.dumps(error_data, ensure_ascii=False, indent=2))

                # 分析具体错误
                if 'errors' in error_data:
                    print(f"\n=== 错误分析 ===")
                    for field, error_msg in error_data['errors'].items():
                        print(f"字段 '{field}' 错误: {error_msg}")

                if 'errorMessages' in error_data:
                    print(f"\n=== 系统错误消息 ===")
                    for msg in error_data['errorMessages']:
                        print(f"- {msg}")

            except json.JSONDecodeError:
                print("响应内容不是有效的JSON格式:")
                print(response.text)

            return False

    except Exception as e:
        print(f"请求时发生异常: {e}")
        return False

def test_individual_fields():
    """测试各个字段的有效性"""
    print(f"\n=== 字段有效性测试 ===")

    excel_file = "jira_motorola_edart_template_20251013_001616.xlsx"
    df = pd.read_excel(excel_file, engine='openpyxl')
    row = df.iloc[0]

    # 测试组件
    if pd.notna(row.get('Components')):
        component_name = str(row.get('Components')).strip()
        print(f"\n测试组件: {component_name}")
        test_component_validity(component_name)

    # 测试版本
    if pd.notna(row.get('Versions')):
        version_name = str(row.get('Versions')).strip()
        print(f"\n测试版本: {version_name}")
        test_version_validity(version_name)

    # 测试标签
    if pd.notna(row.get('Label')):
        label_str = str(row.get('Label')).strip()
        print(f"\n测试标签: {label_str}")
        # 标签不需要验证，可以直接使用

    # 测试自定义字段
    custom_fields = {
        'Severity': 'customfield_10017',
        'Team Found': 'customfield_10198',
        'Product Affected': 'customfield_11016'
    }

    for display_name, field_key in custom_fields.items():
        if pd.notna(row.get(display_name)):
            value = str(row.get(display_name)).strip()
            print(f"\n测试自定义字段 {display_name} ({field_key}): {value}")

def test_component_validity(component_name):
    """测试组件是否有效"""
    try:
        url = f"{JIRA_SERVER}/rest/api/2/component"
        headers = {
            "Authorization": f"Bearer {JIRA_TOKEN}",
            "Accept": "application/json"
        }

        params = {"project": "EKLAMUC"}
        response = requests.get(url, headers=headers, params=params, timeout=30, verify=False)

        if response.status_code == 200:
            components = response.json()
            component_names = [comp['name'] for comp in components]
            if component_name in component_names:
                print(f"  ✅ 组件 '{component_name}' 有效")
            else:
                print(f"  ❌ 组件 '{component_name}' 无效")
                print(f"  可用组件: {component_names[:10]}...")  # 显示前10个
        else:
            print(f"  ❌ 无法验证组件有效性: {response.status_code}")

    except Exception as e:
        print(f"  ❌ 验证组件时发生错误: {e}")

def test_version_validity(version_name):
    """测试版本是否有效"""
    try:
        url = f"{JIRA_SERVER}/rest/api/2/project/EKLAMUC/versions"
        headers = {
            "Authorization": f"Bearer {JIRA_TOKEN}",
            "Accept": "application/json"
        }

        response = requests.get(url, headers=headers, timeout=30, verify=False)

        if response.status_code == 200:
            versions = response.json()
            version_names = [ver['name'] for ver in versions]
            if version_name in version_names:
                print(f"  ✅ 版本 '{version_name}' 有效")
            else:
                print(f"  ❌ 版本 '{version_name}' 无效")
                print(f"  可用版本: {version_names}")
        else:
            print(f"  ❌ 无法验证版本有效性: {response.status_code}")

    except Exception as e:
        print(f"  ❌ 验证版本时发生错误: {e}")

def main():
    """主函数"""
    print("JIRA详细错误调试工具")
    print("=" * 60)

    # 调试Excel问题创建
    success = debug_excel_issue_creation()

    if not success:
        # 测试各个字段的有效性
        test_individual_fields()

    print(f"\n=== 总结 ===")
    if success:
        print("✅ 测试成功")
    else:
        print("❌ 测试失败，请查看上述错误信息")

    return 0 if success else 1

if __name__ == "__main__":
    exit(main())