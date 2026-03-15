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

result = client._make_request('GET', '/rest/api/2/resolution')
print("可用解决方案:")
for r in result:
    print(f"  {r['id']}: {r['name']}")
client.close()
