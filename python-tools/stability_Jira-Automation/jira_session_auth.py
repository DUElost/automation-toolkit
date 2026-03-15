#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRA会话认证工具 - 手动登录后使用会话状态
"""

import requests
import json
import urllib3
import pandas as pd
from datetime import datetime
import argparse
import time
import re

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class JIRASessionAuth:
    """使用会话认证的JIRA客户端"""
    
    def __init__(self, server_url):
        self.server_url = server_url.rstrip('/')
        self.session = requests.Session()
        self.session.verify = False
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
            'Accept-Encoding': 'gzip, deflate, br',
            'Connection': 'keep-alive',
            'Upgrade-Insecure-Requests': '1'
        })
        self.is_authenticated = False
        
    def manual_login(self, username, password):
        """手动登录到JIRA"""
        try:
            print(f"正在访问JIRA登录页面: {self.server_url}")
            
            # 1. 获取登录页面
            login_page_response = self.session.get(f"{self.server_url}/login.jsp")
            print(f"登录页面状态码: {login_page_response.status_code}")
            
            # 2. 查找登录表单中的token
            login_html = login_page_response.text
            
            # 查找atl_token或其他隐藏字段
            token_match = re.search(r'name="atl_token" value="([^"]*)"', login_html)
            atl_token = token_match.group(1) if token_match else None
            
            print(f"找到atl_token: {atl_token is not None}")
            
            # 3. 提交登录表单
            login_data = {
                'os_username': username,
                'os_password': password,
                'os_destination': '',
                'user_role': '',
                'atl_token': atl_token,
                'login': 'Log+In'
            }
            
            print("正在提交登录表单...")
            login_response = self.session.post(
                f"{self.server_url}/login.jsp",
                data=login_data,
                allow_redirects=True
            )
            
            print(f"登录响应状态码: {login_response.status_code}")
            
            # 4. 验证登录是否成功
            if login_response.status_code == 200 and "login" not in login_response.url.lower():
                print("[成功] 登录成功!")
                self.is_authenticated = True
                return True
            else:
                print("[失败] 登录失败!")
                print(f"当前URL: {login_response.url}")
                print(f"响应内容预览: {login_response.text[:200]}")
                return False
                
        except Exception as e:
            print(f"[异常] 登录过程中发生错误: {e}")
            return False
    
    def test_api_access(self):
        """测试API访问"""
        if not self.is_authenticated:
            print("[错误] 未认证，无法访问API")
            return False
            
        try:
            # 测试用户信息API
            print("测试用户信息API...")
            api_url = f"{self.server_url}/rest/api/2/myself"
            response = self.session.get(api_url)
            
            print(f"API响应状态码: {response.status_code}")
            print(f"响应类型: {response.headers.get('Content-Type', 'Unknown')}")
            
            if response.status_code == 200:
                user_data = response.json()
                print(f"[成功] 当前用户: {user_data.get('name', 'Unknown')}")
                print(f"显示名: {user_data.get('displayName', 'Unknown')}")
                return True
            else:
                print(f"[失败] API访问失败: {response.text[:200]}")
                return False
                
        except Exception as e:
            print(f"[异常] API测试失败: {e}")
            return False
    
    def create_issue(self, issue_data):
        """创建JIRA问题"""
        if not self.is_authenticated:
            return {'success': False, 'error': '未认证'}
            
        try:
            api_url = f"{self.server_url}/rest/api/2/issue"
            response = self.session.post(
                api_url,
                json={'fields': issue_data},
                headers={'Content-Type': 'application/json'}
            )
            
            if response.status_code == 201:
                issue_info = response.json()
                return {
                    'success': True,
                    'key': issue_info.get('key'),
                    'id': issue_info.get('id'),
                    'self': issue_info.get('self')
                }
            else:
                return {
                    'success': False,
                    'error': f"HTTP {response.status_code}: {response.text}"
                }
                
        except Exception as e:
            return {'success': False, 'error': str(e)}
    
    def add_comment(self, issue_key, comment):
        """添加评论"""
        if not self.is_authenticated:
            return {'success': False, 'error': '未认证'}
            
        try:
            api_url = f"{self.server_url}/rest/api/2/issue/{issue_key}/comment"
            response = self.session.post(
                api_url,
                json={'body': comment},
                headers={'Content-Type': 'application/json'}
            )
            
            return response.status_code == 201
            
        except Exception as e:
            print(f"添加评论失败: {e}")
            return False

def test_manual_login():
    """测试手动登录"""
    jira_auth = JIRASessionAuth('https://jira.tinno.com')
    
    # 手动输入凭据
    print("请输入JIRA登录凭据:")
    username = input("用户名: ").strip()
    password = input("密码: ").strip()
    
    # 尝试登录
    if jira_auth.manual_login(username, password):
        print("登录成功，正在测试API访问...")
        
        if jira_auth.test_api_access():
            print("API访问测试成功!")
            return jira_auth
        else:
            print("API访问测试失败!")
            return None
    else:
        print("登录失败!")
        return None

if __name__ == "__main__":
    test_manual_login()