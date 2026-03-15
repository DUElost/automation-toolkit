#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
调试JIRA连接问题的脚本
"""

import requests
import json
from requests.auth import HTTPBasicAuth
import urllib3

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def debug_jira_connection():
    """调试JIRA连接"""
    jira_url = "https://jira.tinno.com"
    username = "dai.lv"
    password = "l.74926520"
    
    # 测试基本连接
    print("1. 测试基本HTTP连接...")
    try:
        response = requests.get(jira_url, verify=False, timeout=10)
        print(f"   状态码: {response.status_code}")
        print(f"   响应头: {dict(response.headers)}")
        if response.status_code != 200:
            print(f"   响应内容: {response.text[:500]}")
    except Exception as e:
        print(f"   连接失败: {e}")
        return
    
    # 测试JIRA REST API
    print("\n2. 测试JIRA REST API连接...")
    try:
        api_url = f"{jira_url}/rest/api/2/myself"
        response = requests.get(api_url, auth=HTTPBasicAuth(username, password), verify=False, timeout=10)
        print(f"   状态码: {response.status_code}")
        print(f"   响应头: {dict(response.headers)}")
        
        if response.status_code == 200:
            user_data = response.json()
            print(f"   当前用户: {user_data.get('name', 'Unknown')}")
            print(f"   邮箱: {user_data.get('emailAddress', 'Unknown')}")
        else:
            print(f"   响应内容: {response.text[:500]}")
            
    except Exception as e:
        print(f"   API连接失败: {e}")
    
    # 测试JIRA服务器信息
    print("\n3. 测试JIRA服务器信息...")
    try:
        server_info_url = f"{jira_url}/rest/api/2/serverInfo"
        response = requests.get(server_info_url, verify=False, timeout=10)
        print(f"   状态码: {response.status_code}")
        
        if response.status_code == 200:
            server_info = response.json()
            print(f"   JIRA版本: {server_info.get('version', 'Unknown')}")
            print(f"   部署类型: {server_info.get('deploymentType', 'Unknown')}")
        else:
            print(f"   响应内容: {response.text[:500]}")
            
    except Exception as e:
        print(f"   服务器信息获取失败: {e}")

if __name__ == "__main__":
    debug_jira_connection()