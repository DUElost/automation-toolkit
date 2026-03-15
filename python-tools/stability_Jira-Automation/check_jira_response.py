#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
检查JIRA服务器响应内容
"""

import requests
from requests.auth import HTTPBasicAuth
import urllib3

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def check_jira_response():
    """检查JIRA服务器响应内容"""
    jira_url = "https://jira.tinno.com"
    username = "dai.lv"
    password = "l.74926520"
    
    # 测试JIRA REST API
    print("检查JIRA REST API响应内容...")
    try:
        api_url = f"{jira_url}/rest/api/2/myself"
        response = requests.get(api_url, auth=HTTPBasicAuth(username, password), verify=False, timeout=10)
        print(f"状态码: {response.status_code}")
        print(f"Content-Type: {response.headers.get('Content-Type', 'Unknown')}")
        
        # 尝试解析前100个字符
        content = response.text[:200]
        print(f"响应内容前200字符: {content}")
        
        # 检查是否是HTML
        if '<html' in content.lower() or '<!doctype' in content.lower():
            print("响应是HTML页面，可能需要登录或重定向")
            
    except Exception as e:
        print(f"检查失败: {e}")

if __name__ == "__main__":
    check_jira_response()