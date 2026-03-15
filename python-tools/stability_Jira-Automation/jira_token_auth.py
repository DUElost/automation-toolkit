#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
使用JIRA Personal Access Token (PAT) 认证的批量创建工具
"""

import sys
import os
import pandas as pd
from datetime import datetime
import requests
import json
import urllib3
import argparse
import base64

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class JIRATokenAuth:
    """使用JIRA Personal Access Token认证的客户端"""
    
    def __init__(self, server_url, username, token):
        self.server_url = server_url.rstrip('/')
        self.username = username
        self.token = token
        self.session = requests.Session()
        self.session.verify = False
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': f'Basic {self._get_auth_string()}'
        })
        self.is_authenticated = False
        
    def _get_auth_string(self):
        """获取Basic Auth字符串"""
        auth_string = f"{self.username}:{self.token}"
        auth_bytes = auth_string.encode('utf-8')
        return base64.b64encode(auth_bytes).decode('utf-8')
    
    def test_connection(self):
        """测试连接"""
        try:
            api_url = f"{self.server_url}/rest/api/2/myself"
            response = self.session.get(api_url)
            
            if response.status_code == 200:
                try:
                    user_data = response.json()
                    print(f"[成功] 连接成功，用户: {user_data.get('displayName', 'Unknown')}")
                    self.is_authenticated = True
                    return True
                except json.JSONDecodeError:
                    print(f"[失败] 响应不是有效的JSON")
                    print(f"响应内容: {response.text[:300]}")
                    return False
            else:
                print(f"[失败] 连接失败，状态码: {response.status_code}")
                print(f"响应内容: {response.text[:300]}")
                return False
                
        except Exception as e:
            print(f"[异常] 连接测试失败: {e}")
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
            return False
            
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

def get_jira_token_guide():
    """获取JIRA Token的指导"""
    print("""
=== JIRA Personal Access Token (PAT) 获取指南 ===

JIRA Personal Access Token 是一种安全的认证方式，比密码更安全。

获取步骤:

1. **登录JIRA**
   - 在浏览器中访问: https://jira.tinno.com
   - 使用您的账户登录

2. **访问账户设置**
   - 点击右上角的用户头像
   - 选择 "Profile" 或 "账户设置"

3. **管理API Token**
   - 在账户设置中查找 "Security" 或 "安全" 选项
   - 找到 "API Token" 或 "Personal Access Token" 选项
   - 点击 "Create Token" 或 "生成Token"

4. **生成Token**
   - 输入Token描述 (例如: "JIRA批量创建工具")
   - 设置Token过期时间 (可选)
   - 点击生成或创建

5. **复制Token**
   - 生成后立即复制Token (只显示一次!)
   - Token通常以类似 "ATATT3xFfGF0..." 的格式开头

6. **使用Token**
   - Token将替代密码用于API认证
   - 格式: username:token

注意:
- Token只显示一次，生成后请立即保存
- 可以随时撤销不需要的Token
- Token比密码更安全，可以单独撤销

常见问题:
- 如果找不到Token选项，可能需要管理员权限
- 某些JIRA版本可能使用不同的术语 (如 "REST API Token")
- 如果没有PAT功能，可以使用OAuth或其他认证方式
""")

def test_token_authentication(server_url, username, token):
    """测试Token认证"""
    print("=== 测试JIRA Token认证 ===")
    print(f"服务器: {server_url}")
    print(f"用户名: {username}")
    print(f"Token: {'*' * (len(token) - 4)}{token[-4:] if len(token) > 4 else token}")
    
    jira_client = JIRATokenAuth(server_url, username, token)
    
    if jira_client.test_connection():
        print("[成功] Token认证成功!")
        return jira_client
    else:
        print("[失败] Token认证失败!")
        return None

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
    parser = argparse.ArgumentParser(description='使用JIRA Token认证的批量创建工具')
    parser.add_argument('excel_file', help='Excel文件路径')
    parser.add_argument('--server', default='https://jira.tinno.com', help='JIRA服务器地址')
    parser.add_argument('--username', default='dai.lv', help='JIRA用户名')
    parser.add_argument('--token', help='JIRA Personal Access Token')
    parser.add_argument('--guide', action='store_true', help='显示Token获取指南')
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("JIRA 批量问题创建工具 - Token认证版本")
    print("=" * 60)
    
    # 显示Token获取指南
    if args.guide:
        get_jira_token_guide()
        return 0
    
    # 获取Token
    token = args.token
    if not token:
        print("请提供JIRA Personal Access Token:")
        print("方式1: 使用 --token 参数")
        print("方式2: 运行 python jira_token_auth.py --guide 查看获取指南")
        return 1
    
    # 测试Token认证
    jira_client = test_token_authentication(args.server, args.username, token)
    if not jira_client:
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
        f.write(f"用户名: {args.username}\n")
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