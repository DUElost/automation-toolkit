#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
直接登录JIRA的解决方案
"""

import requests
import urllib3
import re
import time

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

def direct_login_to_jira():
    """直接登录JIRA并获取有效的会话"""
    
    server_url = 'https://jira.tinno.com'
    username = 'dai.lv'
    password = 'l.74926520'
    
    print("=== 尝试直接登录JIRA ===")
    
    # 创建会话
    session = requests.Session()
    session.verify = False
    session.headers.update({
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
        'Accept-Language': 'zh-CN,zh;q=0.9,en;q=0.8',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive',
        'Upgrade-Insecure-Requests': '1'
    })
    
    try:
        # 1. 获取登录页面
        print("1. 获取登录页面...")
        login_page_response = session.get(f"{server_url}/login.jsp")
        print(f"   登录页面状态码: {login_page_response.status_code}")
        
        # 2. 查找登录表单中的字段
        login_html = login_page_response.text
        
        # 查找atl_token
        token_match = re.search(r'name="atl_token" value="([^"]*)"', login_html)
        atl_token = token_match.group(1) if token_match else None
        
        # 查找其他可能的字段
        hidden_fields = {}
        field_matches = re.findall(r'<input[^>]*type="hidden"[^>]*name="([^"]*)"[^>]*value="([^"]*)"[^>]*>', login_html)
        for name, value in field_matches:
            hidden_fields[name] = value
        
        print(f"   找到隐藏字段: {list(hidden_fields.keys())}")
        
        # 3. 构建登录数据
        login_data = {
            'os_username': username,
            'os_password': password,
            'os_destination': '',
            'user_role': '',
            'login': 'Log+In'
        }
        
        # 添加隐藏字段
        if atl_token:
            login_data['atl_token'] = atl_token
        
        for key, value in hidden_fields.items():
            if key not in login_data:
                login_data[key] = value
        
        print(f"   登录数据字段: {list(login_data.keys())}")
        
        # 4. 提交登录
        print("2. 提交登录表单...")
        login_response = session.post(
            f"{server_url}/login.jsp",
            data=login_data,
            allow_redirects=True
        )
        
        print(f"   登录响应状态码: {login_response.status_code}")
        print(f"   登录后URL: {login_response.url}")
        
        # 5. 检查是否登录成功
        if 'login' not in login_response.url.lower() and login_response.status_code == 200:
            print("3. [成功] 登录成功!")
            
            # 显示当前cookies
            print("4. 当前Cookies:")
            for cookie in session.cookies:
                print(f"   {cookie.name}: {cookie.value}")
            
            # 6. 测试API访问
            print("5. 测试API访问...")
            
            # 更新会话头部用于API请求
            api_session = requests.Session()
            api_session.verify = False
            api_session.headers.update({
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                'Accept': 'application/json',
                'Content-Type': 'application/json'
            })
            
            # 复制cookies到API会话
            for cookie in session.cookies:
                api_session.cookies.set(cookie.name, cookie.value, domain='jira.tinno.com')
            
            # 测试用户信息
            api_url = f"{server_url}/rest/api/2/myself"
            response = api_session.get(api_url)
            
            print(f"   API状态码: {response.status_code}")
            print(f"   Content-Type: {response.headers.get('Content-Type', 'Unknown')}")
            
            if response.status_code == 200:
                try:
                    import json
                    user_data = response.json()
                    print(f"   [成功] 当前用户: {user_data.get('name', 'Unknown')}")
                    
                    # 返回cookies字符串供后续使用
                    cookies_str = '; '.join([f"{cookie.name}={cookie.value}" for cookie in session.cookies])
                    print(f"\n6. [成功] Cookies字符串:")
                    print(f"   {cookies_str}")
                    
                    return cookies_str
                    
                except json.JSONDecodeError:
                    print(f"   [失败] 响应不是有效的JSON: {response.text[:200]}")
            else:
                print(f"   [失败] API访问失败: {response.text[:200]}")
        else:
            print("3. [失败] 登录失败!")
            print(f"   当前URL: {login_response.url}")
            
            # 检查是否有错误信息
            if 'error' in login_response.text.lower():
                error_match = re.search(r'<div[^>]*class="[^"]*error[^"]*"[^>]*>([^<]*)</div>', login_response.text, re.IGNORECASE)
                if error_match:
                    print(f"   错误信息: {error_match.group(1)}")
            
    except Exception as e:
        print(f"[异常] 登录过程中发生错误: {e}")
    
    return None

if __name__ == "__main__":
    cookies_str = direct_login_to_jira()
    
    if cookies_str:
        print("\n=== 登录成功! ===")
        print("可以使用以下cookies字符串:")
        print(cookies_str)
        
        print("\n现在可以运行批量创建脚本:")
        print(f"python jira_batch_create_session.py JIRA_Upload_List_20250911_225735.xlsx --cookies \"{cookies_str}\"")
    else:
        print("\n=== 登录失败 ===")
        print("可能需要:")
        print("1. 检查用户名和密码")
        print("2. 确认JIRA服务器状态")
        print("3. 检查是否需要验证码或其他认证")
        print("4. 联系系统管理员")