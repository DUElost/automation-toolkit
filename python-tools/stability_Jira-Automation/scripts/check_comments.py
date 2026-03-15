#!/usr/bin/env python3
import os
import sys
from pathlib import Path

PROJECT_ROOT = Path(__file__).parent.parent
sys.path.insert(0, str(PROJECT_ROOT))
sys.path.insert(0, str(PROJECT_ROOT / "src"))

from dotenv import load_dotenv
load_dotenv(PROJECT_ROOT / ".env")

from src.modules.jira_p12_client import JiraP12Client

client = JiraP12Client(
    jira_url=os.getenv("JIRA_URL"),
    p12_file_path=os.getenv("JIRA_P12_PATH"),
    p12_password=os.getenv("JIRA_P12_PASSWORD"),
    jira_username=os.getenv("JIRA_USERNAME"),
    jira_password=os.getenv("JIRA_PASSWORD")
)

issue_key = sys.argv[1] if len(sys.argv) > 1 else "VCAME-284"
comments = client._make_request("GET", f"/rest/api/2/issue/{issue_key}/comment")
print(f"{issue_key} 评论:")
for c in comments.get("comments", []):
    body = c.get("body", "")[:100]
    print(f"  - {body}")
client.close()
