#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
使用会话认证的JIRA批量创建脚本 - 修改版
"""

import sys
import os
import pandas as pd
from datetime import datetime
import requests
import json
import urllib3
import argparse

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class JIRASessionClient:
    """使用会话认证的JIRA客户端"""
    
    def __init__(self, server_url):
        self.server_url = server_url.rstrip('/')
        self.session = requests.Session()
        self.session.verify = False
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Accept': 'application/json',
            'Content-Type': 'application/json'
        })
        self.is_authenticated = False
        
    def set_cookies(self, cookies_dict):
        """设置cookies"""
        try:
            for key, value in cookies_dict.items():
                self.session.cookies.set(key, value, domain='jira.tinno.com')
            print(f"已设置 {len(cookies_dict)} 个cookies")
            return True
        except Exception as e:
            print(f"设置cookies失败: {e}")
            return False
    
    def test_connection(self):
        """测试连接"""
        try:
            api_url = f"{self.server_url}/rest/api/2/myself"
            response = self.session.get(api_url)
            
            if response.status_code == 200:
                try:
                    user_data = response.json()
                    print(f"[成功] 连接成功，用户: {user_data.get('name', 'Unknown')}")
                    self.is_authenticated = True
                    return True
                except json.JSONDecodeError:
                    print(f"[失败] 响应不是有效的JSON")
                    print(f"响应内容: {response.text[:200]}")
                    return False
            else:
                print(f"[失败] 连接失败，状态码: {response.status_code}")
                print(f"响应内容: {response.text[:200]}")
                return False
                
        except Exception as e:
            print(f"[异常] 连接测试失败: {e}")
            return False
    
    def create_issue(self, issue_data):
        """创建JIRA问题"""
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
                error_text = response.text
                if response.headers.get('Content-Type', '').startswith('text/html'):
                    error_text = "服务器返回HTML错误页面"
                return {
                    'success': False,
                    'error': f"HTTP {response.status_code}: {error_text}"
                }
                
        except Exception as e:
            return {'success': False, 'error': str(e)}
    
    def add_comment(self, issue_key, comment):
        """添加评论"""
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

def get_cookies_from_browser():
    """从浏览器获取cookies的指导"""
    print("""
=== 如何获取JIRA登录Cookies ===

1. 在浏览器中访问 https://jira.tinno.com
2. 登录您的JIRA账户
3. 打开开发者工具 (F12)
4. 切换到 "Application" 或 "Storage" 标签页
5. 在左侧菜单中找到 "Cookies" -> "https://jira.tinno.com"
6. 复制以下重要的cookies值:
   - JSESSIONID
   - atlassian.xsrf.token
   - seraph.rememberme.cookie
   - 其他认证相关的cookies

7. 将cookies以以下格式提供:
   JSESSIONID=ABC123XYZ; atlassian.xsrf.token=ABC-XYZ; seraph.rememberme.cookie=VALUE

或者您也可以手动逐个输入cookies名称和值。
""")

def parse_cookies_string(cookies_string):
    """解析cookies字符串"""
    cookies = {}
    for cookie in cookies_string.split(';'):
        if '=' in cookie:
            key, value = cookie.strip().split('=', 1)
            cookies[key.strip()] = value.strip()
    return cookies

def get_cookies_interactive():
    """交互式获取cookies"""
    print("请选择获取cookies的方式:")
    print("1. 粘贴完整的cookies字符串")
    print("2. 逐个输入cookies")
    
    choice = input("请选择 (1/2): ").strip()
    
    cookies = {}
    
    if choice == '1':
        cookies_string = input("请粘贴完整的cookies字符串: ").strip()
        cookies = parse_cookies_string(cookies_string)
    else:
        while True:
            key = input("输入cookie名称 (或直接回车结束): ").strip()
            if not key:
                break
            value = input(f"输入cookie值 ({key}): ").strip()
            if value:
                cookies[key] = value
    
    return cookies

def read_excel_file(file_path):
    """读取Excel文件"""
    try:
        print(f"正在读取Excel文件: {file_path}")
        df = pd.read_excel(file_path)
        print(f"成功读取 {len(df)} 行数据")
        print(f"表头: {list(df.columns)}")
        
        # 过滤掉空行
        df = df.dropna(subset=['Summary'])
        print(f"有效数据行数: {len(df)}")
        
        return df
        
    except Exception as e:
        print(f"[失败] 读取Excel文件失败: {e}")
        return None

def batch_create_issues(jira_client, df):
    """批量创建JIRA问题"""
    print(f"\n开始批量创建 {len(df)} 个JIRA问题...")
    
    results = []
    success_count = 0
    failed_count = 0
    
    for index, row in df.iterrows():
        print(f"\n--- 创建第 {index + 1} 个问题 ---")
        
        try:
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
            
            # 添加组件
            if pd.notna(row.get('Module')):
                issue_data['components'] = [{'name': str(row['Module'])}]
            
            # 添加环境信息
            if pd.notna(row.get('Environment')):
                issue_data['environment'] = str(row['Environment'])
            
            # 打印创建信息
            print(f"概要: {issue_data['summary'][:80]}..." if len(issue_data['summary']) > 80 else f"概要: {issue_data['summary']}")
            print(f"项目: {issue_data['project']['key']}")
            print(f"问题类型: {issue_data['issuetype']['name']}")
            
            # 创建问题
            result = jira_client.create_issue(issue_data)
            
            if result['success']:
                print(f"[成功] 问题创建成功!")
                print(f"问题Key: {result['key']}")
                success_count += 1
                
                # 添加评论
                comment_text = row.get('PS', '')
                if comment_text and str(comment_text).strip() and str(comment_text).strip() != 'nan':
                    if jira_client.add_comment(result['key'], str(comment_text)):
                        print(f"[成功] 备注已添加到问题 {result['key']}")
                    
                results.append({
                    'success': True,
                    'issue_key': result['key'],
                    'issue_url': f"{jira_client.server_url}/browse/{result['key']}",
                    'summary': issue_data['summary'],
                    'comment_added': bool(comment_text and str(comment_text).strip() and str(comment_text).strip() != 'nan')
                })
            else:
                print(f"[失败] 创建失败: {result['error']}")
                failed_count += 1
                
                results.append({
                    'success': False,
                    'error': result['error'],
                    'summary': issue_data['summary']
                })
                
        except Exception as e:
            error_msg = f"创建问题时发生异常: {e}"
            print(f"[失败] {error_msg}")
            failed_count += 1
            
            results.append({
                'success': False,
                'error': error_msg,
                'summary': str(row.get('Summary', '未知问题'))
            })
    
    # 打印统计信息
    print(f"\n=== 批量创建完成 ===")
    print(f"总计: {len(results)} 个问题")
    print(f"成功: {success_count} 个")
    print(f"失败: {failed_count} 个")
    print(f"成功率: {(success_count/len(results)*100):.1f}%")
    
    return results

def main():
    """主函数"""
    parser = argparse.ArgumentParser(description='使用会话认证的JIRA批量创建工具')
    parser.add_argument('excel_file', help='Excel文件路径')
    parser.add_argument('--server', default='https://jira.tinno.com', help='JIRA服务器地址')
    parser.add_argument('--cookies', help='cookies字符串')
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("JIRA 批量问题创建工具 - 会话认证版本")
    print("=" * 60)
    
    # 显示获取cookies的指导
    get_cookies_from_browser()
    
    # 获取cookies
    cookies = {}
    if args.cookies:
        cookies = parse_cookies_string(args.cookies)
    else:
        cookies = get_cookies_interactive()
    
    if not cookies:
        print("[错误] 没有提供cookies")
        return 1
    
    # 初始化JIRA客户端
    jira_client = JIRASessionClient(args.server)
    
    # 设置cookies
    if not jira_client.set_cookies(cookies):
        print("[失败] 设置cookies失败")
        return 1
    
    # 测试连接
    if not jira_client.test_connection():
        print("[失败] 连接测试失败")
        print("请检查:")
        print("1. cookies是否正确")
        print("2. cookies是否已过期")
        print("3. 网络连接是否正常")
        return 1
    
    # 读取Excel文件
    df = read_excel_file(args.excel_file)
    if df is None:
        return 1
    
    # 批量创建问题
    results = batch_create_issues(jira_client, df)
    
    # 保存结果到文件
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    result_file = f"jira_batch_create_result_{timestamp}.txt"
    
    with open(result_file, 'w', encoding='utf-8') as f:
        f.write(f"JIRA批量创建结果 - {datetime.now()}\n")
        f.write(f"Excel文件: {args.excel_file}\n")
        f.write(f"JIRA服务器: {args.server}\n")
        f.write(f"总计: {len(results)} 个问题\n")
        f.write(f"成功: {sum(1 for r in results if r['success'])} 个\n")
        f.write(f"失败: {sum(1 for r in results if not r['success'])} 个\n")
        f.write("\n")
        
        for i, result in enumerate(results):
            if result['success']:
                comment_status = " (含备注)" if result['comment_added'] else ""
                f.write(f"第{i+1}行: 成功{comment_status} - {result['summary']}\n")
                f.write(f"  问题Key: {result['issue_key']}\n")
                f.write(f"  链接: {result['issue_url']}\n")
                if result['comment_added']:
                    f.write(f"  备注: 已添加\n")
                f.write("\n")
            else:
                f.write(f"第{i+1}行: 失败 - {result['summary']}\n")
                f.write(f"  错误: {result['error']}\n")
                f.write("\n")
    
    print(f"\n结果已保存到: {result_file}")
    return 0

if __name__ == "__main__":
    sys.exit(main())