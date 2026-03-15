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

issue_key = sys.argv[1] if len(sys.argv) > 1 else 'VCAME-268'
result = client._make_request('GET', f'/rest/api/2/issue/{issue_key}/transitions?expand=transitions.fields')

print(f"问题 {issue_key} 可用转换及字段:")
for t in result.get('transitions', []):
    print(f"\n[{t['id']}] {t['name']} -> {t['to']['name']}")
    fields = t.get('fields', {})
    if fields:
        print("  必填字段:")
        for fname, finfo in fields.items():
            required = finfo.get('required', False)
            name = finfo.get('name', fname)
            schema = finfo.get('schema', {})
            print(f"    - {fname}: {name} (required={required}, type={schema.get('type')})")

client.close()
