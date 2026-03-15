#!/usr/bin/env python3
"""检查解决问题转换的验证器要求"""
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

# 使用处理中状态的问题
issue_key = 'VCAME-276'

print(f"问题: {issue_key}")
print("=" * 60)

# 获取问题当前状态
issue = client.get_issue(issue_key)
fields = issue.get('fields', {})
print(f"当前状态: {fields.get('status', {}).get('name')}")
print(f"已记录工时: {fields.get('timespent', 0)} 秒")
print()

# 获取转换详情
result = client._make_request('GET', f'/rest/api/2/issue/{issue_key}/transitions?expand=transitions.fields')

for t in result.get('transitions', []):
    if t['name'] == '解决问题':
        print(f"转换: {t['name']} (id={t['id']})")
        print(f"目标状态: {t['to']['name']}")
        print()
        print("字段要求:")
        for fname, finfo in t.get('fields', {}).items():
            required = "必填" if finfo.get('required') else "可选"
            print(f"  {fname}: {finfo.get('name')} [{required}]")
            
            # 显示 allowedValues
            allowed = finfo.get('allowedValues', [])
            if allowed and len(allowed) <= 5:
                print(f"    可选值: {[v.get('name') or v.get('value') for v in allowed]}")
        
        print()
        print("注意: API 显示的 required 字段可能不完整")
        print("工作流可能有额外的后置验证器要求")

# 尝试不同的 payload 组合
print()
print("=" * 60)
print("测试不同的 payload 组合")
print("=" * 60)

payloads = [
    {
        "name": "仅 resolution",
        "payload": {
            "transition": {"id": "5"},
            "fields": {
                "resolution": {"id": "10000"}
            }
        }
    },
    {
        "name": "resolution + fixVersions",
        "payload": {
            "transition": {"id": "5"},
            "fields": {
                "resolution": {"id": "10000"},
                "fixVersions": [{"name": "P1"}]
            }
        }
    },
    {
        "name": "resolution + fixVersions + 根本原因 + 现象确认",
        "payload": {
            "transition": {"id": "5"},
            "fields": {
                "resolution": {"id": "10000"},
                "fixVersions": [{"name": "P1"}],
                "customfield_10144": "根本原因测试",
                "customfield_10701": "现象确认测试"
            }
        }
    },
    {
        "name": "全部字段",
        "payload": {
            "transition": {"id": "5"},
            "fields": {
                "resolution": {"id": "10000"},
                "fixVersions": [{"name": "P1"}],
                "customfield_10144": "根本原因测试",
                "customfield_10701": "现象确认测试",
                "customfield_10702": "临时措施测试",
                "customfield_10145": "长期措施测试"
            }
        }
    }
]

for test in payloads:
    print(f"\n测试: {test['name']}")
    try:
        client._make_request("POST", f"/rest/api/2/issue/{issue_key}/transitions", json=test['payload'])
        print("  结果: 成功!")
        break
    except Exception as e:
        error_msg = str(e)
        # 提取错误信息
        if "body=" in error_msg:
            body = error_msg.split("body=")[1]
            try:
                err = json.loads(body)
                msgs = err.get('errorMessages', [])
                errs = err.get('errors', {})
                print(f"  结果: 失败")
                if msgs:
                    print(f"  错误消息: {msgs}")
                if errs:
                    print(f"  字段错误: {errs}")
            except:
                print(f"  结果: 失败 - {error_msg[:100]}")
        else:
            print(f"  结果: 失败 - {error_msg[:100]}")

client.close()
