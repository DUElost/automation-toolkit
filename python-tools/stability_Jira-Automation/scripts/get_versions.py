#!/usr/bin/env python3
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

project_key = os.getenv('JIRA_PROJECT_KEY', 'VCAME')
result = client._make_request('GET', f'/rest/api/2/project/{project_key}/versions')
print(f"项目 {project_key} 可用版本 (最近10个):")
for v in result[-10:]:
    print(f"  {v['id']}: {v['name']} (released={v.get('released', False)})")
client.close()
