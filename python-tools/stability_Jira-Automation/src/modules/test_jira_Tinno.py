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
JIRA_SERVER = 'https://jira.tinno.com'  # 你的 JIRA 服务器地址
JIRA_USER = 'dai.lv'              # 你的邮箱
JIRA_PASSWORD = 'l,74926520'        # <-- 在这里输入你的JIRA登录密码

# self.jira_server = 'http://jira-ex.transsion.com:6001'
# self.jira_user = 'dailv.tinno'
# self.jira_password = '2j4-Gx6-beJ-x36'
# self.project_key = 'X6851VP865'

ISSUE_KEY_TO_COMMENT = 'VFFBA-738'
COMMENT_TEXT = 'Monkey自动化回归调试用，不做关注'

# 读取VFFBA-2606的备注内容
ISSUE_KEY_TO_READ = 'VFFBA-2606'

ISSUE_KEY_TO_CLOSE = 'VFFBA-2311'
# 我们将寻找包含这些关键字的转换名称
TARGET_TRANSITION_KEYWORDS = ['关闭', 'close', 'done', '已关闭'] 

# ==========================================================
# 2. 定义功能函数
# ==========================================================
def test_server_connection(server):
    """测试服务器连接"""
    try:
        print(f"测试服务器连接: {server}")
        
        # 首先测试基本连接
        response = requests.get(server, timeout=10)
        print(f"基本连接状态码: {response.status_code}")
        
        # 测试API端点
        api_url = f"{server}/rest/api/2/serverInfo"
        print(f"测试API端点: {api_url}")
        response = requests.get(api_url, timeout=10)
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

def test_jira_auth(server, user, password):
    """测试JIRA认证"""
    try:
        # 直接测试认证API
        auth_url = f"{server}/rest/auth/1/session"
        print(f"测试认证端点: {auth_url}")
        
        # 尝试登录
        login_data = {
            "username": user,
            "password": password
        }
        
        response = requests.post(auth_url, json=login_data, timeout=10)
        print(f"认证响应状态码: {response.status_code}")
        print(f"认证响应内容: {response.text[:300]}")
        
        if response.status_code == 200:
            print("✅ 认证成功")
            return True
        else:
            print(f"❌ 认证失败，状态码: {response.status_code}")
            return False
            
    except Exception as e:
        print(f"❌ 测试认证时发生错误: {e}")
        return False

def connect_to_jira(server, user, password):
    """连接到 JIRA 并返回一个客户端对象"""
    print(f"正在连接到 JIRA 服务器: {server}")
    print(f"用户名: {user}")
    
    try:
        # 使用简单的连接方式
        jira_client = JIRA(server, basic_auth=(user, password))
        
        # 验证连接
        current_user = jira_client.current_user()
        print(f"[成功] JIRA 连接成功!")
        print(f"当前登录用户: {current_user}")
        return jira_client
        
    except JIRAError as e:
        print(f"[失败] JIRA 连接失败 (JIRA错误): {e.text} (状态码: {e.status_code})")
        if e.status_code == 401:
            print("  认证失败，请检查用户名和密码是否正确")
        elif e.status_code == 403:
            print("  权限不足，请检查账户权限")
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
        if issue.fields.comment.comments:
            print(f"  备注: {issue.fields.comment.comments[0].body}")
        else:
            print(f"  备注: 无备注")
        
        # 打印所有字段
        print("\n所有字段:")
        for field_name in dir(issue.fields):
            if not field_name.startswith('_'):
                try:
                    field_value = getattr(issue.fields, field_name)
                    if field_value is not None:
                        print(f"  {field_name}: {field_value}")
                except Exception as e:
                    print(f"  {field_name}: 无法获取 ({e})")
                    continue
        
        # 特别查找自定义字段
        print("\n=== 自定义字段详情 ===")
        # 获取问题的原始数据，包含所有自定义字段
        raw_issue = client.issue(issue_key, expand='names')
        
        # 遍历所有字段，查找customfield开头的字段
        for field_id, field_value in raw_issue.raw['fields'].items():
            if field_id.startswith('customfield_'):
                print(f"  {field_id}: {field_value}")
                # 特别标注可能包含关键信息的字段
                if field_value and isinstance(field_value, str) and ('Activity:' in str(field_value) or 'Subject:' in str(field_value) or 'Input dispatching' in str(field_value)):
                    print(f"    *** 可能是key_information字段 ***")


    except JIRAError as e:
        print(f"  错误: 无法读取问题 {issue_key} (状态码: {e.status_code})")

def search_for_issues(client, jql_query):
    """根据 JQL 搜索问题并打印列表"""
    print(f"\n--- 正在执行 JQL 搜索: \"{jql_query}\" ---")
    try:
        issues = client.search_issues(jql_query, maxResults=10)
        if not issues:
            print("  没有找到任何问题。")
            return
        
        print(f"  找到 {len(issues)} 个问题:")
        for issue in issues:
            print(f"    - [{issue.key}] {issue.fields.summary}")
    except JIRAError as e:
        print(f"  JQL 查询失败: {e.text}")

def add_comment_to_issue(client, issue_key, comment_body):
    """为指定问题添加一条评论"""
    print(f"\n--- 正在为问题 {issue_key} 添加评论 ---")
    try:
        # 核心写入操作
        comment = client.add_comment(issue_key, comment_body)
        print(f"[成功] 评论添加成功！")
        print(f"   评论内容: \"{comment.body}\"")
        # JIRA Cloud 会返回一个包含链接的 URL，可以方便地点击查看
        if hasattr(comment, 'self'):
             print(f"   查看链接: {comment.self.split('/comment/')[0]}")
    except JIRAError as e:
        print(f"[失败] 添加评论失败！")
        print(f"   错误原因: {e.text} (状态码: {e.status_code})")
        print("   请检查：\n   1. 问题 Key ('{issue_key}') 是否正确。\n   2. 您是否有权限在该问题下添加评论。")

def close_jira_issue(client, issue_key, target_keywords):
    """关闭一个指定的问题单"""
    print(f"\n--- 正在尝试关闭问题: {issue_key} ---")
    try:
        # --- 步骤 1: 查找所有可用的转换 ---
        available_transitions = client.transitions(issue_key)
        
        if not available_transitions:
            print(f"[错误] 错误: 问题 {issue_key} 当前没有任何可执行的操作。")
            return

        print(f"找到 {len(available_transitions)} 个可用的转换操作:")
        for t in available_transitions:
            print(f"  - ID: {t['id']}, 名称: {t['name']}")

        # --- 步骤 2: 寻找目标转换并执行 ---
        target_transition_id = None
        for t in available_transitions:
            # 将转换名称转为小写以进行不区分大小写的匹配
            transition_name_lower = t['name'].lower()
            for keyword in target_keywords:
                if keyword in transition_name_lower:
                    target_transition_id = t['id']
                    print(f"\n[成功] 找到目标转换: '{t['name']}' (ID: {target_transition_id})")
                    break
            if target_transition_id:
                break
        
        if target_transition_id:
            # 执行转换
            print(f"正在执行转换...")
            client.transition_issue(issue_key, transition=target_transition_id)
            print(f"[成功] 成功！问题 {issue_key} 的状态已流转。")
            # 可以在这里添加代码来获取并打印最新状态
            updated_issue = client.issue(issue_key)
            print(f"   当前最新状态为: '{updated_issue.fields.status.name}'")
        else:
            print(f"\n[失败] 操作失败: 在所有可用的转换中，未找到包含关键字 {target_keywords} 的转换。")
            print(f"   请检查 JIRA 工作流配置，或手动在网页上查看正确的操作名称。")

    except JIRAError as e:
        print(f"[失败] 操作时发生错误！")
        print(f"   错误原因: {e.text} (状态码: {e.status_code})")
        print(f"   请检查问题 Key 是否正确，以及您是否有权限执行此操作。")

def get_project_fields(client, project_key):
    """获取项目的所有可用字段信息"""
    print(f"\n--- 正在获取项目 {project_key} 的字段信息 ---")
    try:
        # 获取项目信息
        project = client.project(project_key)
        
        # 获取创建问题时的字段信息
        create_meta = client.createmeta(projectKeys=project_key, expand='projects.issuetypes.fields')
        
        if create_meta['projects']:
            project_meta = create_meta['projects'][0]
            print(f"项目名称: {project_meta['name']}")
            
            for issue_type in project_meta['issuetypes']:
                print(f"\n问题类型: {issue_type['name']}")
                print("可用字段:")
                
                for field_id, field_info in issue_type['fields'].items():
                    field_name = field_info['name']
                    required = field_info.get('required', False)
                    print(f"  - {field_id}: {field_name} {'(必填)' if required else '(可选)'}")
                    
                    # 特别标注包含severity的字段
                    if 'severity' in field_name.lower() or 'severity' in field_id.lower():
                        print(f"    *** 可能是bugSeverity字段 ***")
        
    except JIRAError as e:
        print(f"[失败] 获取字段信息失败: {e.text} (状态码: {e.status_code})")

def get_current_user_issues(client, project_key, max_results=None):
    """获取当前用户在指定项目下提交的所有问题"""
    print(f"\n--- 正在获取当前用户在项目 {project_key} 下提交的所有问题 ---")
    try:
        # 获取当前用户信息
        current_user = client.current_user()
        print(f"当前用户: {current_user}")
        
        # 构建JQL查询语句：查找当前用户在指定项目中报告的所有问题
        jql_query = f"project = '{project_key}' AND reporter = currentUser() ORDER BY created DESC"
        print(f"JQL查询语句: {jql_query}")
        
        # 如果没有指定最大结果数，则获取所有问题（分页查询）
        if max_results is None:
            print("正在获取所有问题（分页查询）...")
            all_issues = []
            start_at = 0
            max_per_page = 100  # 每页最多100个
            
            while True:
                # 分页查询
                issues_batch = client.search_issues(jql_query, startAt=start_at, maxResults=max_per_page)
                
                if not issues_batch:
                    break
                    
                all_issues.extend(issues_batch)
                print(f"已获取 {len(all_issues)} 个问题...")
                
                # 如果这一批的数量少于每页最大数量，说明已经是最后一页
                if len(issues_batch) < max_per_page:
                    break
                    
                start_at += max_per_page
            
            issues = all_issues
        else:
            # 限制结果数量
            issues = client.search_issues(jql_query, maxResults=max_results)
        
        if not issues:
            print("\n[提示] 没有找到任何问题。")
            print("可能的原因：")
            print("1. 您在该项目中没有提交过问题")
            print("2. 项目Key不正确")
            print("3. 您没有查看该项目问题的权限")
            return []
        
        print(f"\n[成功] 找到 {len(issues)} 个问题:")
        print("-" * 80)
        
        issue_list = []
        for i, issue in enumerate(issues, 1):
            print(f"{i:2d}. [{issue.key}] {issue.fields.summary}")
            print(f"    状态: {issue.fields.status.name}")
            print(f"    问题类型: {issue.fields.issuetype.name}")
            print(f"    创建时间: {issue.fields.created}")
            if hasattr(issue.fields, 'assignee') and issue.fields.assignee:
                print(f"    经办人: {issue.fields.assignee.displayName}")
            else:
                print(f"    经办人: 未分配")
            print(f"    链接: {JIRA_SERVER}/browse/{issue.key}")
            print("-" * 80)
            
            # 将问题信息添加到列表中
            issue_info = {
                'key': issue.key,
                'summary': issue.fields.summary,
                'status': issue.fields.status.name,
                'issuetype': issue.fields.issuetype.name,
                'created': issue.fields.created,
                'assignee': issue.fields.assignee.displayName if hasattr(issue.fields, 'assignee') and issue.fields.assignee else '未分配',
                'url': f"{JIRA_SERVER}/browse/{issue.key}"
            }
            issue_list.append(issue_info)
        
        print(f"\n[统计] 统计信息:")
        print(f"总问题数: {len(issues)}")
        
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
        print(f"[失败] 获取问题列表失败: {e.text} (状态码: {e.status_code})")
        print("请检查：")
        print("1. 项目Key是否正确")
        print("2. 您是否有查看该项目的权限")
        print("3. 网络连接是否正常")
        return []

def create_jira_issue(client, project_key, issue_type, summary, assignee, description, 
                     component=None, priority=None, custom_fields=None):
    """创建一个新的JIRA问题单"""
    print(f"\n--- 正在创建问题单 ---")
    try:
        # 构建问题单字段
        issue_dict = {
            'project': {'key': project_key},
            'issuetype': {'name': issue_type},
            'summary': summary,
            'assignee': {'name': assignee},
            'description': description
        }
        
        # 添加组件
        if component:
            issue_dict['components'] = [{'name': component}]
        
        # 添加优先级
        if priority:
            issue_dict['priority'] = {'name': priority}
        
        # 添加自定义字段
        if custom_fields:
            issue_dict.update(custom_fields)
        
        print(f"正在创建问题单...")
        print(f"  项目: {project_key}")
        print(f"  问题类型: {issue_type}")
        print(f"  概要: {summary}")
        print(f"  经办人: {assignee}")
        if component:
            print(f"  模块: {component}")
        if priority:
            print(f"  优先级: {priority}")
        
        # 创建问题单
        new_issue = client.create_issue(fields=issue_dict)
        
        print(f"\n[成功] 问题单创建成功！")
        print(f"   问题单Key: {new_issue.key}")
        print(f"   查看链接: {JIRA_SERVER}/browse/{new_issue.key}")
        
        return new_issue.key
        
    except JIRAError as e:
        print(f"[失败] 创建问题单失败！")
        print(f"   错误原因: {e.text} (状态码: {e.status_code})")
        print("   请检查：")
        print("   1. 项目Key是否正确")
        print("   2. 问题类型是否存在")
        print("   3. 经办人用户名是否正确")
        print("   4. 您是否有权限在该项目中创建问题")
        print("   5. 必填字段是否都已提供")
        return None


# ==========================================================
# 3. 主程序入口
# ==========================================================
if __name__ == "__main__":
    print("=" * 60)
    print("读取当前用户在VFFBA项目下提交的所有问题")
    print("=" * 60)
    
    # 连接到 JIRA
    jira = connect_to_jira(JIRA_SERVER, JIRA_USER, JIRA_PASSWORD)

    if jira:
        # # 示例1: 读取单个问题
        # get_issue_details(jira, 'VFFBA-2') # 请替换为真实问题Key

        # # 示例2: 搜索问题
        # my_jql = "project = 'VFFBA' AND assignee = currentUser()" # 请替换为真实项目Key
        # search_for_issues(jira, my_jql)
        
        # # 示例3: 添加评论
        # add_comment_to_issue(jira, ISSUE_KEY_TO_COMMENT, COMMENT_TEXT)
        
        # # 示例4: 关闭问题单
        # close_jira_issue(jira, ISSUE_KEY_TO_CLOSE, TARGET_TRANSITION_KEYWORDS)
        
        # 示例5: 读取当前用户在VFFBA项目下提交的所有问题
        # project_key = 'VFFBA'  # V551A (VFFBA)
        # user_issues = get_current_user_issues(jira, project_key)
        
        get_issue_details(jira, ISSUE_KEY_TO_READ)


        # 如需创建新问题单，可以取消注释下面的代码：
        """
        print("\n" + "="*60)
        print("开始创建问题单实验")
        print("="*60)
        
        # 根据用户提供的信息创建问题单
        issue_type = '故障'  # 问题类型：故障
        summary = '[自动化][V551A][V551A-15-250730V29][1次][Monkey_系统][ANR]com.android.launcher3发生ANR'
        assignee = 'dai.lv'  # 经办人：dai.lv
        component = 'Launcher'  # 模块：Launcher
        priority = 'Highest'  # 优先级：Highest
        description = r'\\172.21.15.4\jxtinno\sonic_tinno\V551A-15-250730V29_0731_MonkeyAEEinfo\0E05TN25740000006\aee_exp\2025_0804_140452_958_db.01.ANR\db.01.ANR.dbg.DEC\__exp_main.txt'
        
        # 设置自定义字段（已验证可用的字段ID）
        custom_fields = {
            'customfield_10120': {'value': 'B'},  # bugSeverity：B (必填字段)
            'customfield_10123': {'value': 'Previous version exists'},  # Previous version status
            'customfield_10124': {'value': '100%'}  # Recurrence probability：100%
        }
        
        new_issue_key = create_jira_issue(
            client=jira,
            project_key=project_key,
            issue_type=issue_type,
            summary=summary,
            assignee=assignee,
            description=description,
            component=component,
            priority=priority,
            custom_fields=custom_fields
        )
        
        if new_issue_key:
            print(f"\n🎉 实验完成！新创建的问题单Key为: {new_issue_key}")
        """
