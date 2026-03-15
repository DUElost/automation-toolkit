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
result = client._make_request('GET', f'/rest/api/2/project/{project_key}/components')
print(f"项目 {project_key} 可用组件 (前20个):")
for c in result[:20]:
    print(f"  {c['name']}")
print(f"\n共 {len(result)} 个组件")
client.close()
