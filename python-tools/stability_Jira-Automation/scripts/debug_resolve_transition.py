#!/usr/bin/env python3
"""调试解决问题转换"""
import os, sys, json
sys.path.insert(0, 'src')
from dotenv import load_dotenv
load_dotenv('.env')
from modules.jira_p12_client import JiraP12Client

client = JiraP12Client(
    jira_url=os.getenv('JIRA_URL'),
    p12_file_path=os.getenv('JIRA_P12_PATH'),
    p12_password=os.getenv('JIRA_P12_PASSWORD'),
    jira_username=os.getenv('JIRA_USERNAME'),
    jira_password=os.getenv('JIRA_PASSWORD')
)

# 先创建一个新问题用于测试
print("创建测试问题...")
fields = {
    "project": {"key": "VCAME"},
    "issuetype": {"name": "Bug"},
    "summary": "[ResolveTest] 测试解决问题转换",
    "description": "用于测试解决问题转换的问题",
    "labels": ["MonkeyAEE", "ResolveTest"],
    "components": [{"name": "AUTOTEST"}],
    "customfield_10120": {"value": "B"},
    "assignee": {"name": "dai.lv"},
}
result = client.create_issue(fields)
issue_key = result.get('key')
print(f"创建成功: {issue_key}")

# 转换到处理中
print("\n转换到处理中...")
from datetime import datetime, timedelta
today = datetime.now()
payload = {
    "transition": {"id": "4"},
    "fields": {
        "timetracking": {"originalEstimate": "1h"},
        "customfield_10109": today.strftime("%Y-%m-%d"),
        "customfield_10110": (today + timedelta(days=7)).strftime("%Y-%m-%d"),
    }
}
client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
print("成功")

# 查看解决问题转换的详细字段
print("\n获取解决问题转换的详细字段...")
result = client._make_request('GET', f'/rest/api/2/issue/{issue_key}/transitions?expand=transitions.fields')
for t in result.get('transitions', []):
    if t['id'] == '5':  # 解决问题
        print(f"\n转换: {t['name']} -> {t['to']['name']}")
        print("字段详情:")
        for fname, finfo in t.get('fields', {}).items():
            allowed = finfo.get('allowedValues', [])
            print(f"  {fname}: {finfo.get('name')}")
            print(f"    required: {finfo.get('required')}")
            print(f"    schema: {finfo.get('schema', {}).get('type')}")
            allowed = finfo.get('allowedValues', [])
            if allowed:
                print(f"    allowedValues ({len(allowed)}):")
                for v in allowed[:15]:
                    print(f"      - id={v.get('id')}, name={v.get('name')}, value={v.get('value')}")

# 尝试解决问题 - 使用不同的 resolution 格式
print("\n\n尝试解决问题...")

# 先记录工时
print("先记录工时...")
try:
    client._make_request(
        "POST",
        f"/rest/api/2/issue/{issue_key}/worklog",
        json={"timeSpent": "1h", "comment": "测试工时"}
    )
    print("工时记录成功")
except Exception as e:
    print(f"工时记录失败: {e}")

# 方法1: 使用 name
print("\n方法1: resolution={name: '完成'}")
payload1 = {
    "transition": {"id": "5"},
    "fields": {
        "resolution": {"name": "完成"},
        "fixVersions": [{"name": "P1"}],
        "customfield_10144": "根本原因",
        "customfield_10701": "现象确认"
    }
}
try:
    client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload1)
    print("成功!")
except Exception as e:
    print(f"失败: {e}")

# 检查当前状态
issue = client.get_issue(issue_key)
current_status = issue.get('fields', {}).get('status', {}).get('name')
print(f"\n当前状态: {current_status}")

if current_status == '处理中':
    # 方法2: 使用 id
    print("\n方法2: resolution={id: '10000'}")
    payload2 = {
        "transition": {"id": "5"},
        "fields": {
            "resolution": {"id": "10000"},
            "fixVersions": [{"name": "P1"}],
            "customfield_10144": "根本原因",
            "customfield_10701": "现象确认"
        }
    }
    try:
        client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload2)
        print("成功!")
    except Exception as e:
        print(f"失败: {e}")

# 再次检查状态
issue = client.get_issue(issue_key)
current_status = issue.get('fields', {}).get('status', {}).get('name')
resolution = issue.get('fields', {}).get('resolution', {})
print(f"\n最终状态: {current_status}")
print(f"解决方案: {resolution.get('name') if resolution else None}")

print(f"\nURL: https://jira.tinno.com/browse/{issue_key}")

client.close()
