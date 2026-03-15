#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""创建已解决/问题不修改状态的测试问题"""

import os
import sys
from pathlib import Path
from datetime import datetime, timedelta

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_p12_client import JiraP12Client

def main():
    client = JiraP12Client(
        jira_url=os.getenv('JIRA_URL'),
        p12_file_path=os.getenv('JIRA_P12_PATH'),
        p12_password=os.getenv('JIRA_P12_PASSWORD'),
        jira_username=os.getenv('JIRA_USERNAME'),
        jira_password=os.getenv('JIRA_PASSWORD')
    )
    
    try:
        # 创建问题
        fields = {
            "project": {"key": "VCAME"},
            "issuetype": {"name": "Bug"},
            "summary": "[ScenarioTest][WontFix] com.android.dialer java.lang.IllegalArgumentException",
            "description": "决策场景测试: COMMENT (Won't Fix)\n包名: com.android.dialer\n异常: java.lang.IllegalArgumentException\n\n当匹配到此问题时，应添加备注而非重新打开",
            "labels": ["MonkeyAEE", "ScenarioTest"],
            "components": [{"name": "AUTOTEST"}],
            "customfield_10120": {"value": "B"},
            "assignee": {"name": "dai.lv"},
        }
        
        result = client.create_issue(fields)
        key = result.get("key")
        print(f"创建成功: {key}")
        
        # 转换到处理中
        today = datetime.now()
        payload = {
            "transition": {"id": "4"},
            "fields": {
                "timetracking": {"originalEstimate": "1h"},
                "customfield_10109": today.strftime("%Y-%m-%d"),
                "customfield_10110": (today + timedelta(days=7)).strftime("%Y-%m-%d"),
            }
        }
        client._make_request("POST", f"/rest/api/2/issue/{key}/transitions", json=payload)
        print("转换到处理中成功")
        
        # 记录工时
        client._make_request("POST", f"/rest/api/2/issue/{key}/worklog", json={"timeSpent": "1h", "comment": "问题处理完成"})
        print("记录工时成功")
        
        # 转换到已解决 (问题不修改)
        payload = {
            "transition": {"id": "5"},
            "fields": {
                "resolution": {"id": "10102"},  # 问题不修改
                "fixVersions": [{"name": "P1"}],
                "customfield_10144": "根本原因: 非问题，无需修复",
                "customfield_10701": "现象确认: 已确认为预期行为",
                "customfield_10145": "长期措施: 无",
                "customfield_10146": "可能风险: 无",
                "customfield_10147": "对应代码: N/A",
            }
        }
        client._make_request("POST", f"/rest/api/2/issue/{key}/transitions", json=payload)
        print("转换到已解决(问题不修改)成功")
        
        # 获取最终状态
        issue = client.get_issue(key)
        status = issue.get("fields", {}).get("status", {}).get("name")
        resolution = issue.get("fields", {}).get("resolution", {}).get("name")
        print(f"最终状态: {key} - {status} / {resolution}")
        print(f"URL: https://jira.tinno.com/browse/{key}")
        
    finally:
        client.close()


if __name__ == "__main__":
    main()
