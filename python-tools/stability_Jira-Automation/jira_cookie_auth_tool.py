#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
使用浏览器Cookie进行JIRA认证的工具
"""

import requests
import json
import urllib3
import pandas as pd
from datetime import datetime
import argparse

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class JIRACookieAuth:
    """使用浏览器Cookie进行JIRA认证"""
    
    def __init__(self, server_url):
        self.server_url = server_url.rstrip('/')
        self.session = requests.Session()
        self.session.verify = False
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        })
        self.is_authenticated = False
        
    def load_cookies_from_string(self, cookies_string):
        """从字符串加载cookies"""
        try:
            # 解析cookies字符串
            cookies = {}
            for cookie in cookies_string.split(';'):
                if '=' in cookie:
                    key, value = cookie.strip().split('=', 1)
                    cookies[key] = value
            
            # 设置cookies到会话
            for key, value in cookies.items():
                self.session.cookies.set(key, value, domain='jira.tinno.com')
            
            print(f"加载了 {len(cookies)} 个cookies")
            return True
            
        except Exception as e:
            print(f"加载cookies失败: {e}")
            return False
    
    def test_api_access(self):
        """测试API访问"""
        try:
            print("测试用户信息API...")
            api_url = f"{self.server_url}/rest/api/2/myself"
            response = self.session.get(api_url)
            
            print(f"API响应状态码: {response.status_code}")
            print(f"响应类型: {response.headers.get('Content-Type', 'Unknown')}")
            
            if response.status_code == 200:
                try:
                    user_data = response.json()
                    print(f"[成功] 当前用户: {user_data.get('name', 'Unknown')}")
                    print(f"显示名: {user_data.get('displayName', 'Unknown')}")
                    self.is_authenticated = True
                    return True
                except json.JSONDecodeError:
                    print(f"[失败] 响应不是有效的JSON: {response.text[:200]}")
                    return False
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

def test_with_manual_cookies():
    """测试手动输入cookies"""
    print("=== JIRA Cookie认证测试 ===")
    print("请在浏览器中登录 https://jira.tinno.com")
    print("然后打开开发者工具(F12)，在Application/Storage标签页中复制cookies")
    print("特别是 'JSESSIONID' 和其他认证相关的cookies")
    print()
    
    jira_auth = JIRACookieAuth('https://jira.tinno.com')
    
    # 示例cookie格式
    example_cookies = "JSESSIONID=ABC123XYZ; atlassian.xsrf.token=ABC-XYZ; other=value"
    
    print(f"示例cookie格式: {example_cookies}")
    print("请粘贴完整的cookies字符串:")
    
    try:
        cookies_input = input().strip()
        
        if jira_auth.load_cookies_from_string(cookies_input):
            print("Cookies加载成功，正在测试API访问...")
            
            if jira_auth.test_api_access():
                print("[成功] API访问测试成功!")
                return jira_auth
            else:
                print("[失败] API访问测试失败!")
                return None
        else:
            print("[失败] Cookies加载失败!")
            return None
            
    except KeyboardInterrupt:
        print("\n操作已取消")
        return None

def create_batch_create_script():
    """创建使用cookie认证的批量创建脚本"""
    script_content = '''#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
使用Cookie认证的JIRA批量创建脚本
"""

import sys
import os
import pandas as pd
from datetime import datetime
from jira_cookie_auth import JIRACookieAuth
import argparse

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='使用Cookie认证的JIRA批量创建工具')
    parser.add_argument('excel_file', help='Excel文件路径')
    parser.add_argument('--cookies', help='浏览器cookies字符串')
    parser.add_argument('--server', default='https://jira.tinno.com', help='JIRA服务器地址')
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("JIRA 批量问题创建工具 - Cookie认证版本")
    print("=" * 60)
    
    # 初始化JIRA客户端
    jira_auth = JIRACookieAuth(args.server)
    
    # 加载cookies
    if args.cookies:
        if jira_auth.load_cookies_from_string(args.cookies):
            print("[成功] Cookies加载成功")
        else:
            print("[失败] Cookies加载失败")
            return 1
    else:
        print("请提供cookies字符串 (使用--cookies参数)")
        return 1
    
    # 测试API访问
    if not jira_auth.test_api_access():
        print("[失败] API访问测试失败")
        return 1
    
    # 读取Excel文件
    try:
        df = pd.read_excel(args.excel_file)
        print(f"成功读取 {len(df)} 行数据")
    except Exception as e:
        print(f"读取Excel文件失败: {e}")
        return 1
    
    # 批量创建问题
    success_count = 0
    failed_count = 0
    
    for index, row in df.iterrows():
        try:
            print(f"\\n创建第 {index + 1} 个问题...")
            
            # 构建问题数据
            issue_data = {
                'project': {'key': str(row.get('Project', 'VCAME'))},
                'issuetype': {'name': str(row.get('Issue Type', '故障'))},
                'summary': str(row.get('Summary', '未指定概要')),
                'assignee': {'name': str(row.get('Assignee', 'dai.lv'))},
                'description': str(row.get('Description', '通过Excel批量导入创建')),
            }
            
            # 添加优先级
            if pd.notna(row.get('Priority')):
                issue_data['priority'] = {'name': str(row['Priority'])}
            
            # 创建问题
            result = jira_auth.create_issue(issue_data)
            
            if result['success']:
                print(f"[成功] 问题创建成功: {result['key']}")
                success_count += 1
                
                # 添加评论
                if pd.notna(row.get('PS')):
                    jira_auth.add_comment(result['key'], str(row['PS']))
                    print("[成功] 评论已添加")
                    
            else:
                print(f"[失败] 创建失败: {result['error']}")
                failed_count += 1
                
        except Exception as e:
            print(f"[异常] 处理第 {index + 1} 行时发生错误: {e}")
            failed_count += 1
    
    # 输出统计信息
    print(f"\\n=== 批量创建完成 ===")
    print(f"总计: {len(df)} 个问题")
    print(f"成功: {success_count} 个")
    print(f"失败: {failed_count} 个")
    
    return 0

if __name__ == "__main__":
    sys.exit(main())
'''
    
    with open('jira_batch_create_cookie.py', 'w', encoding='utf-8') as f:
        f.write(script_content)
    
    print("已创建批量创建脚本: jira_batch_create_cookie.py")

if __name__ == "__main__":
    # 测试cookie认证
    jira_auth = test_with_manual_cookies()
    
    if jira_auth:
        # 创建批量创建脚本
        create_batch_create_script()
        
        # 测试创建问题
        print("\\n=== 测试创建问题 ===")
        test_issue_data = {
            'project': {'key': 'VCAME'},
            'issuetype': {'name': '故障'},
            'summary': '[测试] Cookie认证测试问题',
            'description': '这是一个使用Cookie认证创建的测试问题',
            'assignee': {'name': 'dai.lv'}
        }
        
        result = jira_auth.create_issue(test_issue_data)
        if result['success']:
            print(f"[成功] 测试问题创建成功: {result['key']}")
        else:
            print(f"[失败] 测试问题创建失败: {result['error']}")
    else:
        print("认证失败，无法创建问题")