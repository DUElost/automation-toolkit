import os
from jira import JIRA
from jira.exceptions import JIRAError
import requests
import json
import urllib3

# 禁用SSL警告
urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

# ==========================================================
# 1. 配置你的 JIRA 信息
# ==========================================================
JIRA_SERVER = 'https://edart.motorola.com'  # Motorola edart 服务器地址
# JIRA_USER = 'tin_baoyu.deng_tmp@extlenovo.com'  # 用户邮箱
# JIRA_PASSWORD = '2119849017Dby.'  # JIRA登录密码
# JIRA_USER = 'tin_runlong.bao_tmp@extlenovo.com'  # 用户邮箱
# JIRA_PASSWORD = 'ICK5324ad.com'  # JIRA登录密码

# 使用 Personal Access Token (PAT) 认证
JIRA_TOKEN = os.getenv('JIRA_TOKEN', '')  # Personal Access Token from env

PROJECT_KEY = 'EKLAMUC'  # 项目Key

# ==========================================================
# 2. 定义功能函数
# ==========================================================
def test_server_connection(server):
    """测试服务器连接"""
    try:
        print(f"测试服务器连接: {server}")

        # 首先测试基本连接
        response = requests.get(server, timeout=10, verify=False)
        print(f"基本连接状态码: {response.status_code}")

        # 测试API端点
        api_url = f"{server}/rest/api/2/serverInfo"
        print(f"测试API端点: {api_url}")
        response = requests.get(api_url, timeout=10, verify=False)
        print(f"API响应状态码: {response.status_code}")
        print(f"响应内容前200字符: {response.text[:200]}")

        if response.status_code == 200:
            try:
                server_info = response.json()
                print(f"✅ 服务器连接正常，JIRA版本: {server_info.get('version', '未知')}")
                return True
            except json.JSONDecodeError:
                print("⚠️ 服务器响应不是有效的JSON格式，可能需要认证")
                print("这通常意味着JIRA需要登录才能访问API")
                return True  # 服务器可达，但需要认证
        elif response.status_code == 401:
            print("⚠️ 需要认证，这是正常的")
            return True
        elif response.status_code == 403:
            print("⚠️ 权限不足，但服务器可达")
            return True
        else:
            print(f"⚠️ 服务器响应异常，状态码: {response.status_code}")
            return False

    except requests.exceptions.Timeout:
        print("❌ 连接超时，请检查网络连接")
        return False
    except requests.exceptions.ConnectionError:
        print("❌ 无法连接到服务器，请检查服务器地址")
        return False
    except Exception as e:
        print(f"❌ 测试连接时发生错误: {e}")
        return False

def test_jira_auth(server, token):
    """测试JIRA认证（使用Personal Access Token）"""
    try:
        # 使用PAT认证测试API端点
        auth_url = f"{server}/rest/api/2/myself"
        print(f"测试认证端点: {auth_url}")

        # 设置Bearer Token认证头
        headers = {
            "Authorization": f"Bearer {token}",
            "Accept": "application/json"
        }

        response = requests.get(auth_url, headers=headers, timeout=10, verify=False)
        print(f"认证响应状态码: {response.status_code}")
        print(f"认证响应内容: {response.text[:300]}")

        if response.status_code == 200:
            user_info = response.json()
            print(f"✅ Token认证成功，当前用户: {user_info.get('displayName', '未知')}")
            return True
        else:
            print(f"❌ Token认证失败，状态码: {response.status_code}")
            return False

    except Exception as e:
        print(f"❌ 测试Token认证时发生错误: {e}")
        return False

def connect_to_jira(server, token):
    """连接到 JIRA 并返回一个客户端对象（使用Personal Access Token）"""
    print(f"正在连接到 JIRA 服务器: {server}")
    print("使用Personal Access Token认证")

    try:
        # 使用Token认证方式
        jira_client = JIRA(
            server=server,
            token_auth=token,
            options={'verify': False}
        )

        # 验证连接
        current_user = jira_client.current_user()
        print(f"[成功] JIRA 连接成功!")
        print(f"当前登录用户: {current_user}")
        return jira_client

    except JIRAError as e:
        print(f"[失败] JIRA 连接失败 (JIRA错误): {e.text} (状态码: {e.status_code})")
        if e.status_code == 401:
            print("  Token认证失败，请检查Token是否正确")
        elif e.status_code == 403:
            print("  权限不足，请检查Token权限")
        elif e.status_code == 404:
            print("  服务器地址不正确或服务不可用")
        else:
            print("  请检查网络连接和服务器状态")
        return None

    except Exception as e:
        print(f"[失败] JIRA 连接失败: {e}")
        print(f"错误类型: {type(e).__name__}")
        return None

def get_issue_details(client, issue_key):
    """获取并打印单个问题的详细信息"""
    print(f"\n--- 正在读取问题: {issue_key} ---")
    try:
        issue = client.issue(issue_key)
        print(f"  Key: {issue.key}")
        print(f"  概要: {issue.fields.summary}")
        print(f"  报告人: {issue.fields.reporter.displayName}")
        print(f"  状态: {issue.fields.status.name}")
        print(f"  创建时间: {issue.fields.created}")
        if hasattr(issue.fields, 'priority') and issue.fields.priority:
            print(f"  优先级: {issue.fields.priority.name}")
        if hasattr(issue.fields, 'assignee') and issue.fields.assignee:
            print(f"  经办人: {issue.fields.assignee.displayName}")
        else:
            print(f"  经办人: 未分配")
        if issue.fields.comment and issue.fields.comment.comments:
            print(f"  备注: {issue.fields.comment.comments[0].body}")
        else:
            print(f"  备注: 无备注")

        return issue

    except JIRAError as e:
        print(f"  错误: 无法读取问题 {issue_key} (状态码: {e.status_code})")
        return None

def get_project_bugs(client, project_key, max_results=5):
    """获取指定项目中的Bug单"""
    print(f"\n--- 正在获取项目 {project_key} 中的前 {max_results} 个Bug单 ---")
    try:
        # 构建JQL查询语句：查找项目中的Bug问题，按创建时间降序排列
        jql_query = f"project = '{project_key}' AND issuetype = Bug ORDER BY created DESC"
        print(f"JQL查询语句: {jql_query}")

        # 执行查询
        issues = client.search_issues(jql_query, maxResults=max_results)

        if not issues:
            print("\n[提示] 没有找到任何Bug单。")
            print("可能的原因：")
            print("1. 项目中没有Bug类型的问题")
            print("2. 项目Key不正确")
            print("3. 您没有查看该项目的权限")
            return []

        print(f"\n[成功] 找到 {len(issues)} 个Bug单:")
        print("-" * 80)

        issue_list = []
        for i, issue in enumerate(issues, 1):
            print(f"{i:2d}. [{issue.key}] {issue.fields.summary}")
            print(f"    状态: {issue.fields.status.name}")
            print(f"    问题类型: {issue.fields.issuetype.name}")
            print(f"    创建时间: {issue.fields.created}")
            if hasattr(issue.fields, 'priority') and issue.fields.priority:
                print(f"    优先级: {issue.fields.priority.name}")
            if hasattr(issue.fields, 'assignee') and issue.fields.assignee:
                print(f"    经办人: {issue.fields.assignee.displayName}")
            else:
                print(f"    经办人: 未分配")
            if hasattr(issue.fields, 'reporter') and issue.fields.reporter:
                print(f"    报告人: {issue.fields.reporter.displayName}")
            print(f"    链接: {JIRA_SERVER}/browse/{issue.key}")
            print("-" * 80)

            # 将问题信息添加到列表中
            issue_info = {
                'key': issue.key,
                'summary': issue.fields.summary,
                'status': issue.fields.status.name,
                'issuetype': issue.fields.issuetype.name,
                'created': issue.fields.created,
                'priority': issue.fields.priority.name if hasattr(issue.fields, 'priority') and issue.fields.priority else '未设置',
                'assignee': issue.fields.assignee.displayName if hasattr(issue.fields, 'assignee') and issue.fields.assignee else '未分配',
                'reporter': issue.fields.reporter.displayName if hasattr(issue.fields, 'reporter') and issue.fields.reporter else '未知',
                'url': f"{JIRA_SERVER}/browse/{issue.key}"
            }
            issue_list.append(issue_info)

        print(f"\n[统计] 统计信息:")
        print(f"总Bug数: {len(issues)}")

        # 按状态统计
        status_count = {}
        for issue in issues:
            status = issue.fields.status.name
            status_count[status] = status_count.get(status, 0) + 1

        print("按状态分布:")
        for status, count in status_count.items():
            print(f"  - {status}: {count} 个")

        return issue_list

    except JIRAError as e:
        print(f"[失败] 获取Bug列表失败: {e.text} (状态码: {e.status_code})")
        print("请检查：")
        print("1. 项目Key是否正确")
        print("2. 您是否有查看该项目的权限")
        print("3. 网络连接是否正常")
        return []

def get_project_info(client, project_key):
    """获取项目基本信息"""
    print(f"\n--- 正在获取项目 {project_key} 的基本信息 ---")
    try:
        project = client.project(project_key)
        print(f"项目名称: {project.name}")
        print(f"项目Key: {project.key}")
        print(f"项目类型: {project.projectTypeKey}")
        print(f"项目分类: {project.projectCategory.name if hasattr(project, 'projectCategory') and project.projectCategory else '未设置'}")
        print(f"项目领导: {project.lead.displayName}")
        print(f"描述: {project.description if hasattr(project, 'description') and project.description else '无描述'}")

        return project

    except JIRAError as e:
        print(f"[失败] 获取项目信息失败: {e.text} (状态码: {e.status_code})")
        return None

# ==========================================================
# 3. 主程序入口
# ==========================================================
if __name__ == "__main__":
    print("=" * 60)
    print("Motorola edart JIRA 连接测试")
    print("=" * 60)

    # 测试服务器连接
    print("\n1. 测试服务器连接...")
    if test_server_connection(JIRA_SERVER):
        print("✅ 服务器连接测试通过")
    else:
        print("❌ 服务器连接测试失败，请检查网络和服务器地址")
        exit(1)

    # 测试认证
    print("\n2. 测试Token认证...")
    if test_jira_auth(JIRA_SERVER, JIRA_TOKEN):
        print("✅ Token认证测试通过")
    else:
        print("❌ Token认证测试失败，请检查Token是否正确")
        exit(1)

    # 连接到 JIRA
    print("\n3. 连接到 JIRA...")
    jira = connect_to_jira(JIRA_SERVER, JIRA_TOKEN)

    if jira:
        # 获取项目信息
        print("\n4. 获取项目信息...")
        project_info = get_project_info(jira, PROJECT_KEY)

        if project_info:
            print("✅ 项目信息获取成功")

            # 获取项目中的Bug单
            print("\n5. 获取Bug单...")
            bug_issues = get_project_bugs(jira, PROJECT_KEY, max_results=5)

            if bug_issues:
                print(f"\n✅ 成功获取到 {len(bug_issues)} 个Bug单")

                # 显示第一个Bug的详细信息
                print("\n6. 显示第一个Bug的详细信息...")
                first_bug = get_issue_details(jira, bug_issues[0]['key'])
            else:
                print("❌ 未能获取到Bug单")
        else:
            print("❌ 未能获取项目信息，请检查项目Key是否正确")
    else:
        print("❌ JIRA 连接失败，请检查配置信息")
        exit(1)