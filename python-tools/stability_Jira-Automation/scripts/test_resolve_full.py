#!/usr/bin/env python3
"""测试完整的解决问题转换"""
import os, sys
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

issue_key = 'VCAME-276'

print(f"尝试解决问题 {issue_key}")
print("=" * 60)

# 完整的 payload
payload = {
    "transition": {"id": "5"},
    "fields": {
        "resolution": {"id": "10000"},  # 完成
        "fixVersions": [{"name": "P1"}],
        "customfield_10144": "根本原因: 测试用途",  # 根本原因
        "customfield_10701": "现象确认: 测试用途",  # 现象确认
        "customfield_10145": "长期措施: 测试用途",  # 长期措施
        "customfield_10146": "可能风险: 无",  # RiskProbability
        "customfield_10147": "对应代码: N/A",  # Corresponding code
    }
}

print("Payload:")
import json
print(json.dumps(payload, indent=2, ensure_ascii=False))
print()

try:
    client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
    print("成功!")
    
    # 验证状态
    issue = client.get_issue(issue_key)
    fields = issue.get('fields', {})
    print(f"\n最终状态: {fields.get('status', {}).get('name')}")
    print(f"解决方案: {fields.get('resolution', {}).get('name') if fields.get('resolution') else None}")
    
except Exception as e:
    print(f"失败: {e}")

client.close()
