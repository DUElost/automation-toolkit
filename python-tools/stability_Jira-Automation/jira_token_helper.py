#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
JIRA Token获取和测试工具
"""

import requests
import urllib3
import base64
import json

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

class JIRATokenHelper:
    """JIRA Token帮助工具"""
    
    def __init__(self, server_url):
        self.server_url = server_url.rstrip('/')
        
    def show_token_acquisition_guide(self):
        """显示Token获取指南"""
        print("""
=== JIRA Personal Access Token (PAT) 获取详细指南 ===

什么是Personal Access Token (PAT)?
- PAT是用于API访问的安全认证方式
- 替代传统的密码认证
- 可以单独撤销，不影响账户安全
- 通常有有效期限制

获取步骤:

1. **登录JIRA系统**
   - 浏览器访问: https://jira.tinno.com
   - 使用您的账户登录

2. **进入个人设置**
   - 点击右上角用户头像/姓名
   - 选择 "个人资料" 或 "Profile"

3. **查找安全设置**
   - 在个人资料页面查找 "安全" 或 "Security"
   - 找到 "API令牌" 或 "API Tokens" 选项

4. **创建新Token**
   - 点击 "创建令牌" 或 "Create Token"
   - 输入令牌描述，如: "JIRA批量创建工具"
   - 设置有效期 (可选，推荐30天)
   - 点击 "创建" 或 "Create"

5. **保存Token**
   - Token生成后立即显示 (只显示一次!)
   - 立即复制并保存到安全位置
   - Token格式通常类似: ATATT3xFfGF0A5X0q...

6. **测试Token**
   - 使用本工具测试Token是否有效
   - 有效后可用于批量创建脚本

Token使用格式:
- 用户名:Token (作为Basic Auth的密码部分)
- 例如: dai.lv:ATATT3xFfGF0A5X0q...

安全建议:
- 不要在代码中硬编码Token
- 使用环境变量或配置文件存储
- 定期更换Token
- 不用时及时撤销
""")
    
    def test_token_with_username(self, username, token):
        """使用用户名和Token测试连接"""
        print(f"=== 测试Token认证 ===")
        print(f"服务器: {self.server_url}")
        print(f"用户名: {username}")
        print(f"Token: {'*' * (len(token) - 4)}{token[-4:] if len(token) > 4 else token}")
        
        try:
            # 创建Basic Auth头
            auth_string = f"{username}:{token}"
            auth_bytes = auth_string.encode('utf-8')
            auth_header = base64.b64encode(auth_bytes).decode('utf-8')
            
            # 创建会话
            session = requests.Session()
            session.verify = False
            session.headers.update({
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': f'Basic {auth_header}'
            })
            
            # 测试用户信息API
            api_url = f"{self.server_url}/rest/api/2/myself"
            response = session.get(api_url)
            
            print(f"响应状态码: {response.status_code}")
            print(f"响应类型: {response.headers.get('Content-Type', 'Unknown')}")
            
            if response.status_code == 200:
                try:
                    user_data = response.json()
                    print(f"[成功] Token认证成功!")
                    print(f"用户信息:")
                    print(f"  用户名: {user_data.get('name', 'Unknown')}")
                    print(f"  显示名: {user_data.get('displayName', 'Unknown')}")
                    print(f"  邮箱: {user_data.get('emailAddress', 'Unknown')}")
                    print(f"  时区: {user_data.get('timeZone', 'Unknown')}")
                    print(f"  状态: {'活跃' if user_data.get('active', False) else '非活跃'}")
                    
                    return True
                    
                except json.JSONDecodeError:
                    print(f"[失败] 响应不是有效的JSON")
                    print(f"响应内容: {response.text[:300]}")
                    return False
            else:
                print(f"[失败] Token认证失败")
                print(f"响应内容: {response.text[:300]}")
                return False
                
        except Exception as e:
            print(f"[异常] 测试失败: {e}")
            return False
    
    def test_server_availability(self):
        """测试服务器可用性"""
        print(f"=== 测试服务器可用性 ===")
        print(f"服务器: {self.server_url}")
        
        try:
            response = requests.get(self.server_url, verify=False, timeout=10)
            print(f"HTTP状态码: {response.status_code}")
            print(f"响应头: {response.headers.get('Server', 'Unknown')}")
            
            if response.status_code == 200:
                print("[成功] 服务器可用")
                return True
            else:
                print(f"[失败] 服务器响应异常")
                return False
                
        except Exception as e:
            print(f"[失败] 无法连接到服务器: {e}")
            return False
    
    def show_available_endpoints(self):
        """显示可用的API端点"""
        print("=== 常用JIRA API端点 ===")
        
        endpoints = [
            ("用户信息", "/rest/api/2/myself"),
            ("项目列表", "/rest/api/2/project"),
            ("问题类型", "/rest/api/2/issuetype"),
            ("优先级", "/rest/api/2/priority"),
            ("创建问题", "/rest/api/2/issue"),
            ("搜索问题", "/rest/api/2/search"),
            ("服务器信息", "/rest/api/2/serverInfo")
        ]
        
        for name, endpoint in endpoints:
            url = f"{self.server_url}{endpoint}"
            print(f"{name}: {url}")
    
    def test_create_sample_issue(self, username, token):
        """测试创建示例问题"""
        print(f"\n=== 测试创建示例问题 ===")
        
        try:
            # 创建Basic Auth头
            auth_string = f"{username}:{token}"
            auth_bytes = auth_string.encode('utf-8')
            auth_header = base64.b64encode(auth_bytes).decode('utf-8')
            
            # 创建会话
            session = requests.Session()
            session.verify = False
            session.headers.update({
                'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': f'Basic {auth_header}'
            })
            
            # 创建示例问题
            api_url = f"{self.server_url}/rest/api/2/issue"
            sample_issue = {
                'fields': {
                    'project': {'key': 'VCAME'},
                    'issuetype': {'name': '故障'},
                    'summary': '[Token测试] Token认证测试问题',
                    'description': '这是一个使用Token认证创建的测试问题，用于验证Token是否有效。',
                    'assignee': {'name': username}
                }
            }
            
            print("正在创建示例问题...")
            response = session.post(api_url, json=sample_issue)
            
            print(f"响应状态码: {response.status_code}")
            
            if response.status_code == 201:
                try:
                    issue_info = response.json()
                    print(f"[成功] 示例问题创建成功!")
                    print(f"问题Key: {issue_info.get('key', 'Unknown')}")
                    print(f"问题ID: {issue_info.get('id', 'Unknown')}")
                    print(f"问题链接: {issue_info.get('self', 'Unknown')}")
                    
                    # 询问是否删除测试问题
                    print(f"\n是否删除这个测试问题? (y/n)")
                    try:
                        choice = input().strip().lower()
                        if choice == 'y':
                            delete_url = f"{self.server_url}/rest/api/2/issue/{issue_info.get('key')}"
                            delete_response = session.delete(delete_url)
                            if delete_response.status_code == 204:
                                print("[成功] 测试问题已删除")
                            else:
                                print("[警告] 无法删除测试问题")
                    except:
                        pass
                    
                    return True
                    
                except json.JSONDecodeError:
                    print(f"[失败] 响应不是有效的JSON")
                    return False
            else:
                print(f"[失败] 创建示例问题失败")
                print(f"响应内容: {response.text[:300]}")
                return False
                
        except Exception as e:
            print(f"[异常] 创建示例问题失败: {e}")
            return False

def main():
    """主函数"""
    import argparse
    
    parser = argparse.ArgumentParser(description='JIRA Token获取和测试工具')
    parser.add_argument('--server', default='https://jira.tinno.com', help='JIRA服务器地址')
    parser.add_argument('--username', default='dai.lv', help='JIRA用户名')
    parser.add_argument('--token', help='JIRA Personal Access Token')
    parser.add_argument('--guide', action='store_true', help='显示Token获取指南')
    parser.add_argument('--test-server', action='store_true', help='测试服务器可用性')
    parser.add_argument('--show-endpoints', action='store_true', help='显示可用的API端点')
    parser.add_argument('--test-create', action='store_true', help='测试创建示例问题')
    
    args = parser.parse_args()
    
    print("=" * 60)
    print("JIRA Token获取和测试工具")
    print("=" * 60)
    
    helper = JIRATokenHelper(args.server)
    
    # 显示指南
    if args.guide:
        helper.show_token_acquisition_guide()
        return
    
    # 测试服务器
    if args.test_server:
        helper.test_server_availability()
        return
    
    # 显示端点
    if args.show_endpoints:
        helper.show_available_endpoints()
        return
    
    # 如果没有提供Token，显示指南并退出
    if not args.token:
        print("请提供JIRA Personal Access Token")
        print("使用 --token 参数或运行 --guide 查看获取指南")
        helper.show_token_acquisition_guide()
        return
    
    # 测试Token认证
    if helper.test_token_with_username(args.username, args.token):
        print("\n[成功] Token认证测试通过!")
        
        # 如果要求测试创建问题
        if args.test_create:
            helper.test_create_sample_issue(args.username, args.token)
        
        print(f"\n现在可以使用以下命令进行批量创建:")
        print(f"python jira_token_auth.py JIRA_Upload_List_20250911_225735.xlsx --username {args.username} --token {args.token}")
        
    else:
        print("\n[失败] Token认证测试失败!")
        print("请检查:")
        print("1. Token是否正确")
        print("2. Token是否已过期")
        print("3. 用户名是否正确")
        print("4. 网络连接是否正常")

if __name__ == "__main__":
    main()