#!/usr/bin/env python3
import sys
sys.path.insert(0, 'src')
from modules.config_loader import ConfigLoader
from modules.jira_synchronizer import JIRASynchronizer

config_loader = ConfigLoader('.env')
jira_config = config_loader.get_jira_config()
jira_sync = JIRASynchronizer(jira_config)

result = jira_sync.search_issues('project = VCAME AND key = VCAME-264', max_results=1)
issue = result.get('issues', [{}])[0]
fields = issue.get('fields', {})
status = fields.get('status', {}).get('name')
resolution = fields.get('resolution')
resolution_name = resolution.get('name') if resolution else None

print(f'VCAME-264 状态: {status}')
print(f'Resolution: {resolution_name}')
summary = fields.get('summary', '')
print(f'Summary: {summary[:80]}')

jira_sync.close()
