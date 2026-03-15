#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""获取项目的有效版本列表"""

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

# 获取项目版本
project_key = "VCAME"
result = client._make_request("GET", f"/rest/api/2/project/{project_key}/versions")

print(f"项目 {project_key} 的版本列表:")
for v in result[:20]:  # 只显示前20个
    print(f"  {v.get('name')} - released: {v.get('released')}")

jira_sync.close()
