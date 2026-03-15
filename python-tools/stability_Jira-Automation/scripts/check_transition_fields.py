#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""检查转换需要的字段"""

import os
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_synchronizer import JIRASynchronizer

jira_config = {
    "url": os.getenv("JIRA_URL"),
    "username": os.getenv("JIRA_USERNAME"),
    "password": os.getenv("JIRA_PASSWORD"),
    "p12_path": os.getenv("JIRA_P12_PATH"),
    "p12_password": os.getenv("JIRA_P12_PASSWORD"),
    "project_key": os.getenv("JIRA_PROJECT_KEY", "VCAME"),
    "mode": "rest",
}

jira_sync = JIRASynchronizer(jira_config)
client = jira_sync._backend.client

# 获取转换详情（包含字段）
issue_key = "VCAME-307"
url = f"/rest/api/2/issue/{issue_key}/transitions?expand=transitions.fields"
result = client._make_request("GET", url)

import json
print(json.dumps(result, indent=2, ensure_ascii=False))

jira_sync.close()
