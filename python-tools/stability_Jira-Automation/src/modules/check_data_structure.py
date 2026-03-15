#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
检查数据结构问题
"""

import os
import pandas as pd
import json

def check_data_structure():
    """检查数据结构"""
    print("检查数据结构问题")
    print("=" * 40)

    # 读取Excel
    excel_file = "jira_motorola_edart_template_20251013_001616.xlsx"
    df = pd.read_excel(excel_file, engine='openpyxl')
    row = df.iloc[0]

    print("原始Excel数据:")
    for col in df.columns:
        value = row[col]
        print(f"  {col}: {value} (类型: {type(value)})")

    # 手动构建正确格式的数据
    correct_issue_dict = {
        'fields': {
            'project': {'key': 'EKLAMUC'},
            'issuetype': {'name': '故障'},
            'summary': '[测试] ANR: com.android.settings (1 Times)',
            'description': '测试描述',
            'priority': {'name': '3'},
            'assignee': {'name': 'tin_dai.lv_tmp@extlenovo.com'},
            'components': [{'name': 'SW_APP_Settings'}],
            'versions': [{'name': 'VVTB35.12'}],
            'labels': ['lamuc_monkey'],
            'customfield_10017': {'value': 'Major'},
            'customfield_10198': {'value': 'ODM'},
            'customfield_11016': {'value': 'Lamu26 (lamuc)'}
        }
    }

    print(f"\n正确的数据结构:")
    print(json.dumps(correct_issue_dict, ensure_ascii=False, indent=2))

    print(f"\n数据结构验证:")
    print(f"  包含 'project' 字段: {'project' in correct_issue_dict}")
    print(f"  包含 'fields' 字段: {'fields' in correct_issue_dict}")
    print(f"  'project' 在 'fields' 中: {'project' in correct_issue_dict['fields']}")

    # 尝试使用requests直接创建问题
    import requests
    import urllib3
    urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

    try:
        url = f"https://edart.motorola.com/rest/api/2/issue"
        headers = {
            "Authorization": f"Bearer {os.getenv('JIRA_TOKEN', '')}",
            "Accept": "application/json",
            "Content-Type": "application/json"
        }

        response = requests.post(url, headers=headers, json=correct_issue_dict, timeout=30, verify=False)

        print(f"\n直接API测试:")
        print(f"响应状态码: {response.status_code}")

        if response.status_code == 201:
            result = response.json()
            print(f"✅ 直接API创建成功: {result['key']}")
            return True
        else:
            print(f"❌ 直接API创建失败")
            try:
                error_data = response.json()
                print(json.dumps(error_data, ensure_ascii=False, indent=2))
            except:
                print(response.text)
            return False

    except Exception as e:
        print(f"❌ 直接API请求失败: {e}")
        return False

if __name__ == "__main__":
    check_data_structure()