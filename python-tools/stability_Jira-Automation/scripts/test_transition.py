#!/usr/bin/env python3
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

issue_key = 'VCAME-270'

# 先查看可用转换
transitions = client.get_transitions(issue_key)
print(f"问题 {issue_key} 可用转换:")
for t in transitions.get('transitions', []):
    print(f"  [{t['id']}] {t['name']} -> {t['to']['name']}")

# 构建 payload - 关闭问题
payload = {
    "transition": {"id": "2"},  # 关闭问题
    "fields": {
        "resolution": {"id": "10000"},  # 完成
        "fixVersions": [{"name": "P1"}],
        "customfield_10144": "测试用途",
        "customfield_10701": "测试用途"
    }
}

print("\n发送 payload:")
print(json.dumps(payload, indent=2, ensure_ascii=False))

try:
    result = client._make_request(
        "POST",
        f"/rest/api/2/issue/{issue_key}/transitions",
        json=payload
    )
    print("成功!")
except Exception as e:
    print(f"失败: {e}")

client.close()
