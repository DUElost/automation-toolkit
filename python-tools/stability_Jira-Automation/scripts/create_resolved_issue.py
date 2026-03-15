#!/usr/bin/env python3
"""
创建一个"已解决"状态的问题用于 REOPEN 场景测试

由于 VCAME 项目的"解决问题"转换有工作流验证器限制，
我们使用以下方法模拟：
1. 创建问题 (开放)
2. 开始进行 (处理中)
3. 关闭问题 (已关闭) - 使用 resolution=完成
4. 重新打开 (重新打开)
5. 再次关闭 (已关闭) - 使用 resolution=完成，fix_version=P1

这样可以得到一个 resolution=完成 的已关闭问题，
决策引擎会根据版本比较决定是 REOPEN 还是 IGNORE
"""
import os, sys
sys.path.insert(0, 'src')
from dotenv import load_dotenv
load_dotenv('.env')
from modules.jira_p12_client import JiraP12Client
from datetime import datetime, timedelta

client = JiraP12Client(
    jira_url=os.getenv('JIRA_URL'),
    p12_file_path=os.getenv('JIRA_P12_PATH'),
    p12_password=os.getenv('JIRA_P12_PASSWORD'),
    jira_username=os.getenv('JIRA_USERNAME'),
    jira_password=os.getenv('JIRA_PASSWORD')
)

print("=" * 60)
print("创建 REOPEN 场景测试问题")
print("=" * 60)

# 1. 创建问题
print("\n[1/4] 创建问题...")
fields = {
    "project": {"key": "VCAME"},
    "issuetype": {"name": "Bug"},
    "summary": "[WorkflowTest][ForReopen] com.android.gallery3d 测试问题",
    "description": "此问题用于测试 REOPEN 决策场景\n包名: com.android.gallery3d\n异常: java.lang.OutOfMemoryError\n\n当新版本出现相同问题时，应重新打开此问题",
    "labels": ["MonkeyAEE", "WorkflowTest", "ReopenScenario"],
    "components": [{"name": "AUTOTEST"}],
    "customfield_10120": {"value": "B"},
    "assignee": {"name": "dai.lv"},
}
result = client.create_issue(fields)
issue_key = result.get('key')
print(f"  创建成功: {issue_key}")

# 2. 转换到处理中
print("\n[2/4] 转换到处理中...")
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
print("  成功")

# 3. 记录工时
print("\n[3/4] 记录工时...")
client._make_request(
    "POST",
    f"/rest/api/2/issue/{issue_key}/worklog",
    json={"timeSpent": "1h", "comment": "问题处理完成"}
)
print("  成功")

# 4. 关闭问题 (使用 resolution=完成)
print("\n[4/4] 关闭问题 (resolution=完成, fixVersion=P1)...")
payload = {
    "transition": {"id": "2"},  # 关闭问题
    "fields": {
        "resolution": {"id": "10000"},  # 完成
        "fixVersions": [{"name": "P1"}],
        "customfield_10144": "问题已修复",
        "customfield_10701": "现象已确认"
    }
}
client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=payload)
print("  成功")

# 验证最终状态
issue = client.get_issue(issue_key)
fields = issue.get('fields', {})
status = fields.get('status', {}).get('name')
resolution = fields.get('resolution', {}).get('name') if fields.get('resolution') else None
fix_versions = [v.get('name') for v in fields.get('fixVersions', [])]

print()
print("=" * 60)
print("问题创建完成")
print("=" * 60)
print(f"Key: {issue_key}")
print(f"状态: {status}")
print(f"解决方案: {resolution}")
print(f"修复版本: {fix_versions}")
print(f"URL: https://jira.tinno.com/browse/{issue_key}")
print()
print("说明:")
print("  此问题状态为'已关闭'，解决方案为'完成'，修复版本为'P1'")
print("  当新版本(晚于P1)出现相同问题时，决策引擎应判定为 REOPEN")
print("  当旧版本(早于P1)出现相同问题时，决策引擎应判定为 IGNORE")

client.close()
