#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Excel文件批量创建JIRA问题工具 - Tinno P12证书优化版

功能：
1. 使用P12证书进行SSL认证，并使用用户名/密码登录。
2. 读取Excel文件中的问题数据。
3. 批量在Tinno JIRA (https://jira.tinno.com) 中创建问题。
4. 为每个问题添加备注（PS列内容）。
5. 生成详细的创建结果报告。
6. 使用方法: python jira_batch_tool.py <excel文件路径> --p12file <p12文件路径> --p12password <p12密码> --user <jira用户名> --password <jira密码>

python F:\Jira_test_0813_rin\src\modules\test_excel_to_jira_tinno_batch_create_0913.py
  "F:\Jira_test_0813_rin\src\modules\JIRA_Upload_List_20250913_2234523.xlsx"
    --p12file "F:\Jira_test_0813_rin\src\modules\890177.p12"
      --p12password "2j062EX92T" 
      --user "dai.lv" --password "l,74926520"

Honor

python F:\Jira_test_0813_rin\src\modules\test_excel_to_jira_tinno_batch_create_SSL_final.py "F:\Jira_test_1105_rin\JIRA_Upload_List_20251114_182556.xlsx" --p12file "F:\Jira_test_0813_rin\src\modules\890177.p12" --p12password "2j062EX92T" --user "dai.lv" --password "l,74926520" 
    JIRA_Upload_List_20251114_182556.xlsx
    JIRA_Upload_List_20251113_222654.xlsx
    JIRA_Upload_List_20250913_2234523.xlsx
    JIRA_Upload_List_Moto_20251031_174834.xlsx
      JIRA_Upload_List_20251028_142034.xlsx
      JIRA_Upload_List_20251028_153423.xlsx
作者：AI Assistant
更新时间：2025-01-11
"""

import sys
import os
import pandas as pd
from datetime import datetime
import argparse
import json
import requests
import tempfile
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.primitives.serialization import pkcs12
from urllib.parse import urljoin
from bs4 import BeautifulSoup
import re
import urllib3
import time
from typing import Dict, List, Optional, Any

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# --- JIRA服务器和默认配置 ---
JIRA_SERVER = 'https://jira.tinno.com'
# 请通过命令行参数提供以下值，或设置环境变量
P12_FILE_PATH = os.getenv("JIRA_P12_PATH")
P12_PASSWORD = os.getenv("JIRA_P12_PASSWORD")
JIRA_USER = os.getenv("JIRA_USERNAME", "dai.lv")
JIRA_PASSWORD = os.getenv("JIRA_PASSWORD")
# PROJECT_KEY = 'WERSXYSUOEDBGBG' # 默认项目 Key
PROJECT_KEY = 'VCAME' # 默认项目 Key
# PROJECT_KEY = 'VFFBA' # 默认项目 Key

# ==============================================================================
# 整合后的 JiraP12Client 类
# (基于您验证成功的 jira_client.py)
# ==============================================================================
class JiraP12Client:
    def __init__(self, jira_url, p12_file_path, p12_password, jira_username, jira_password):
        self.jira_url = jira_url.rstrip('/')
        self.p12_file_path = p12_file_path
        self.p12_password = p12_password
        self.jira_username = jira_username
        self.jira_password = jira_password
        self.session = None
        self.cert_files = None
        self.is_logged_in = False

    def _extract_cert_and_key(self):
        try:
            with open(self.p12_file_path, 'rb') as f:
                p12_data = f.read()
            private_key, certificate, _ = pkcs12.load_key_and_certificates(
                p12_data, self.p12_password.encode() if self.p12_password else None
            )
            if not private_key or not certificate:
                raise Exception("无法从P12文件中提取有效的证书或私钥")
            print("P12证书解析成功！")
            
            cert_temp = tempfile.NamedTemporaryFile(mode='wb', suffix='.crt', delete=False)
            key_temp = tempfile.NamedTemporaryFile(mode='wb', suffix='.key', delete=False)
            
            cert_temp.write(certificate.public_bytes(serialization.Encoding.PEM))
            cert_temp.flush()
            
            key_temp.write(private_key.private_bytes(
                encoding=serialization.Encoding.PEM,
                format=serialization.PrivateFormat.PKCS8,
                encryption_algorithm=serialization.NoEncryption()
            ))
            key_temp.flush()
            
            cert_temp.close()
            key_temp.close()
            return cert_temp.name, key_temp.name
        except Exception as e:
            raise Exception(f"解析P12证书失败: {e}")

    def connect(self):
        print("正在使用P12证书建立SSL连接...")
        self.cert_files = self._extract_cert_and_key()
        self.session = requests.Session()
        self.session.trust_env = False  # 忽略系统代理
        self.session.proxies = {}
        self.session.cert = self.cert_files
        response = self.session.get(self.jira_url, verify=False, timeout=30, allow_redirects=True)
        if response.status_code == 200:
            print("P12证书SSL连接成功")
        else:
            raise Exception(f"SSL连接失败，状态码: {response.status_code}")

    def login(self):
        if not self.session:
            raise Exception("请先调用connect()建立SSL连接")
        print(f"正在使用账号 {self.jira_username} 登录Jira...")
        try:
            login_data = {'username': self.jira_username, 'password': self.jira_password}
            headers = {'Content-Type': 'application/json', 'X-Atlassian-Token': 'no-check'}
            response = self.session.post(
                urljoin(self.jira_url, '/rest/auth/1/session'),
                json=login_data, headers=headers, timeout=30
            )
            if response.status_code == 200:
                print("REST API登录成功")
                self.is_logged_in = True
            else:
                raise Exception(f"登录失败，状态码: {response.status_code}, 响应: {response.text}")
        except Exception as e:
            raise Exception(f"Jira登录异常: {e}")

    def _make_request(self, method, endpoint, **kwargs):
        if not self.is_logged_in:
            raise Exception("未登录，请先调用login()方法")
        url = urljoin(self.jira_url, endpoint)
        headers = kwargs.pop('headers', {})
        headers.setdefault('Content-Type', 'application/json')
        response = self.session.request(method, url, headers=headers, timeout=30, **kwargs)
        if 200 <= response.status_code < 300:
            if response.content:
                return response.json()
            return True # For responses with no content like PUT
        else:
            raise Exception(f"API请求失败 ({method.upper()} {url}), 状态码: {response.status_code}, 响应: {response.text}")

    # --- 为批量创建脚本新增或适配的接口方法 ---
    def get_project_info(self, project_key: str) -> Optional[Dict]:
        try:
            return self._make_request('GET', f'/rest/api/2/project/{project_key}')
        except Exception as e:
            print(f"获取项目信息失败: {e}")
            return None

    def get_components(self, project_key: str) -> List[Dict]:
        try:
            return self._make_request('GET', f'/rest/api/2/project/{project_key}/components')
        except Exception as e:
            print(f"获取组件失败: {e}")
            return []

    def create_issue(self, issue_data: Dict) -> Dict:
        return self._make_request('POST', '/rest/api/2/issue', json={"fields": issue_data})

    def add_comment(self, issue_key: str, comment_text: str) -> Dict:
        return self._make_request('POST', f'/rest/api/2/issue/{issue_key}/comment', json={"body": comment_text})
        
    def validate_user(self, username: str) -> bool:
        try:
            # Jira Cloud uses a different endpoint. This one is for Server.
            result = self._make_request('GET', '/rest/api/2/user/search', params={"username": username, "maxResults": 1})
            return len(result) > 0
        except Exception:
            return False

    def close(self):
        if self.session:
            self.session.close()
        if self.cert_files:
            try:
                os.unlink(self.cert_files[0])
                os.unlink(self.cert_files[1])
            except:
                pass
        print("连接已关闭")

# ==============================================================================
# 批量创建脚本核心逻辑
# ==============================================================================

def read_excel_file(file_path: str) -> Optional[pd.DataFrame]:
    try:
        print(f"\n正在读取Excel文件: {file_path}")
        df = pd.read_excel(file_path)
        print(f"成功读取 {len(df)} 行数据")
        print(f"表头: {list(df.columns)}")
        if 'Summary' in df.columns:
            df = df.dropna(subset=['Summary'])
        print(f"有效数据行数: {len(df)}")
        return df
    except Exception as e:
        print(f"[失败] 读取Excel文件失败: {e}")
        return None

def validate_excel_format(df: pd.DataFrame) -> bool:
    required_columns = ['Summary']
    if not all(col in df.columns for col in required_columns):
        print(f"[错误] Excel文件缺少必需的列: {required_columns}")
        return False
    print("[成功] Excel文件格式验证通过")
    return True

def map_priority_to_name(priority_str: Any) -> str:
    priority_map = {
        'highest': 'Highest', 'high': 'High', 'medium': 'Medium', 'low': 'Low', 'lowest': 'Lowest',
        '最高': 'Highest', '高': 'High', '中等': 'Medium', '中': 'Medium', '低': 'Low', '最低': 'Lowest',
        '1': 'Highest', '2': 'High', '3': 'Medium', '4': 'Low', '5': 'Lowest'
    }
    return priority_map.get(str(priority_str).strip().lower(), 'Medium')

def create_issue_from_row(jira_client: JiraP12Client, row: pd.Series, row_index: int, project_key: str) -> Dict:
    print(f"\n--- 创建第 {row_index + 1} 个问题 ---")
    summary = str(row.get('Summary', ''))
    if not summary or summary == 'nan':
        return {'success': False, 'error': 'Summary字段为空', 'summary': '未指定概要'}

    try:
        issue_dict = {
            'project': {'key': str(row.get('Project', project_key))},
            'issuetype': {'name': str(row.get('Issue Type', 'Bug'))},
            'summary': summary,
            'priority': {'name': map_priority_to_name(row.get('Priority', 'Medium'))},
            'description': str(row.get('Description', ''))
        }
        
        assignee = row.get('Assignee')
        if pd.notna(assignee) and str(assignee).strip() and str(assignee) != 'nan':
            if jira_client.validate_user(str(assignee)):
                issue_dict['assignee'] = {'name': str(assignee)}
            else:
                print(f"[警告] 用户 {assignee} 不存在，跳过经办人分配")
        
        # --- FIX: 根据错误提示和初始脚本，添加必需的字段 ---
        
        # 1. 添加组件 (模块), 对应 'Module' 列
        # 错误信息: "components":"模块是必需的。"
        module = row.get('Module')
        if pd.notna(module) and str(module).strip() and str(module) != 'nan':
            # 支持多个组件，用逗号或分号分隔
            component_names = [c.strip() for c in str(module).replace(';', ',').split(',')]
            issue_dict['components'] = [{'name': name} for name in component_names if name]
            
        # 2. 添加 Bug Severity (customfield_10120), 对应 'Bug Severity' 列
        # 错误信息: "customfield_10120":"bugSeverity是必需的。"
        bug_severity = row.get('Bug Severity')
        if pd.notna(bug_severity) and str(bug_severity).strip() and str(bug_severity) != 'nan':
            issue_dict['customfield_10120'] = {'value': str(bug_severity)}

        # 3. (可选) 添加其他从初始脚本中提取的自定义字段
        # Previous Version Status (customfield_10123, customfield_10124)
        prev_status = row.get('Previous Version Status')
        if pd.notna(prev_status) and str(prev_status).strip() and str(prev_status) != 'nan':
            issue_dict['customfield_10123'] = {'value': 'Previous version exists'}
            issue_dict['customfield_10124'] = {'value': str(prev_status)}
            
        # key_information (customfield_10500)
        key_info = row.get('key_information')
        if pd.notna(key_info) and str(key_info).strip() and str(key_info) != 'nan':
            issue_dict['customfield_10500'] = str(key_info)
        
        print(f"概要: {summary[:80]}..." if len(summary) > 80 else f"概要: {summary}")
        
        created_issue = jira_client.create_issue(issue_dict)
        issue_key = created_issue['key']
        print(f"[成功] 问题创建成功! Key: {issue_key}")

        result = {
            'success': True, 'issue_key': issue_key, 'summary': summary,
            'issue_url': f"{jira_client.jira_url}/browse/{issue_key}", 'comment_added': False
        }

        comment_text = row.get('PS', '')
        if pd.notna(comment_text) and str(comment_text).strip() and str(comment_text) != 'nan':
            try:
                jira_client.add_comment(issue_key, str(comment_text))
                result['comment_added'] = True
                print(f"[成功] 备注已添加到问题 {issue_key}")
            except Exception as comment_e:
                print(f"[警告] 添加备注失败: {comment_e}")
        
        return result

    except Exception as e:
        error_msg = f"创建问题时发生异常: {e}"
        print(f"[失败] {error_msg}")
        return {'success': False, 'error': error_msg, 'summary': summary}

def batch_create_issues(jira_client: JiraP12Client, df: pd.DataFrame, project_key: str) -> List[Dict]:
    print(f"\n开始批量创建 {len(df)} 个JIRA问题到项目 {project_key}...")
    results = []
    for index, row in df.iterrows():
        result = create_issue_from_row(jira_client, row, index, project_key)
        results.append(result)
        time.sleep(0.5) # 添加短暂延迟，避免请求过快
    
    success_count = sum(1 for r in results if r['success'])
    failed_count = len(results) - success_count
    
    print(f"\n{'='*60}\n批量创建完成")
    print(f"总计: {len(results)}, 成功: {success_count}, 失败: {failed_count}\n{'='*60}")
    return results

def save_results(results: List[Dict], excel_file: str, server: str):
    timestamp = datetime.now().strftime('%Y%m%d_%H%M%S')
    result_file = f"jira_batch_create_result_{timestamp}.txt"
    with open(result_file, 'w', encoding='utf-8') as f:
        # ... (此处省略了报告写入的详细代码，功能与原脚本一致) ...
        f.write(f"JIRA批量创建结果报告 - {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"源文件: {excel_file}\n\n")
        successful = [r for r in results if r['success']]
        failed = [r for r in results if not r['success']]
        if successful:
            f.write("✅ 成功创建的问题:\n")
            for r in successful:
                f.write(f"  - {r['issue_key']}: {r['summary']} (链接: {r['issue_url']})\n")
        if failed:
            f.write("\n❌ 创建失败的问题:\n")
            for r in failed:
                f.write(f"  - {r['summary']} (错误: {r['error']})\n")
    print(f"📄 结果已保存到: {result_file}")

def main():
    parser = argparse.ArgumentParser(description='Excel文件批量创建JIRA问题工具 - Tinno P12证书优化版本')
    parser.add_argument('excel_file', help='包含问题列表的Excel文件路径')
    parser.add_argument('--server', default=JIRA_SERVER, help='JIRA服务器地址')
    parser.add_argument('--p12file', required=P12_FILE_PATH is None, default=P12_FILE_PATH, help='P12证书文件路径')
    parser.add_argument('--p12password', required=P12_PASSWORD is None, default=P12_PASSWORD, help='P12证书密码')
    parser.add_argument('--user', required=JIRA_USER is None, default=JIRA_USER, help='JIRA用户名')
    parser.add_argument('--password', required=JIRA_PASSWORD is None, default=JIRA_PASSWORD, help='JIRA密码')
    parser.add_argument('--project', default=PROJECT_KEY, help='JIRA目标项目Key')
    parser.add_argument('--test', action='store_true', help='只测试连接和项目信息，不创建问题')
    args = parser.parse_args()

    print("=" * 60 + "\nJIRA 批量问题创建工具 - P12 证书版\n" + "=" * 60)
    
    if not os.path.exists(args.excel_file) and not args.test:
        print(f"[错误] Excel文件不存在: {args.excel_file}")
        return 1
    if not os.path.exists(args.p12file):
        print(f"[错误] P12证书文件不存在: {args.p12file}")
        return 1

    jira_client = None
    try:
        jira_client = JiraP12Client(
            jira_url=args.server, p12_file_path=args.p12file, p12_password=args.p12password,
            jira_username=args.user, jira_password=args.password
        )
        jira_client.connect()
        jira_client.login()

        if args.test:
            print("\n[信息] 测试模式 - 仅测试连接和项目信息")
            project_info = jira_client.get_project_info(args.project)
            if project_info:
                print(f"\n项目 '{project_info.get('name')}' ({args.project}) 信息获取成功。")
            else:
                print(f"\n[警告] 无法获取项目 {args.project} 的信息")
            return 0
        
        df = read_excel_file(args.excel_file)
        if df is None or not validate_excel_format(df):
            return 1
            
        confirm = input(f"\n准备在项目 '{args.project}' 中创建 {len(df)} 个问题。是否继续？(y/n): ")
        if confirm.lower() != 'y':
            print("操作已取消")
            return 0
        
        results = batch_create_issues(jira_client, df, args.project)
        if results:
            save_results(results, args.excel_file, args.server)

    except Exception as e:
        print(f"\n[致命错误] 操作失败: {e}")
        return 1
    finally:
        if jira_client:
            jira_client.close()
            
    return 0

if __name__ == "__main__":
    sys.exit(main())

