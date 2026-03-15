#!/usr/bin/env python3
"""验证 JIRA 问题"""
import sys
import os
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

issue = client.get_issue('VCAME-268')
fields = issue.get('fields', {})

print("=" * 60)
print("真实 JIRA 问题验证")
print("=" * 60)
print("Key: VCAME-268")
print("Summary:", fields.get('summary', 'N/A'))
print("Status:", fields.get('status', {}).get('name', 'N/A'))
print("Reporter:", fields.get('reporter', {}).get('name', 'N/A'))
print("Created:", fields.get('created', 'N/A'))
print()
print("问题已成功创建在 JIRA 中!")
print("URL: https://jira.tinno.com/browse/VCAME-268")

client.close()
