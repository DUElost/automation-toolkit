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
JIRA_SERVER = 'http://jira.transsion.com'
JIRA_USER = 'dailv.tinno'
JIRA_PASSWORD = '59e-LJB-KbB-Hbb'
PROJECT_KEY = 'KO5OS16AEE'
ISSUE_KEY = 'KO5OS16AEE-393'

# self.jira_server = 'http://jira.transsion.com'
# self.jira_user = 'dailv.tinno'
# self.jira_password = '59e-LJB-KbB-Hbb'
# self.project_key = 'KO5OS16AEE'

TARGET_FIELD_NAME = '必解标签'
TARGET_FIELD_VALUE = 'Not MP Block'

# ==========================================================
# 2. 定义功能函数
# ==========================================================
def test_server_connection(server):
    """测试服务器连接"""
    try:
        print(f"测试服务器连接: {server}")

        response = requests.get(server, timeout=10)
        print(f"基本连接状态码: {response.status_code}")

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
                return True
        if response.status_code == 401:
            print("⚠️ 需要认证，这是正常的")
            return True
        if response.status_code == 403:
            print("⚠️ 权限不足，但服务器可达")
            return True
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


def connect_to_jira(server, user, password):
    """连接到 JIRA 并返回一个客户端对象"""
    print(f"正在连接到 JIRA 服务器: {server}")
    print(f"用户名: {user}")

    try:
        jira_client = JIRA(server, basic_auth=(user, password))
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


def _normalize_field_name(name):
    """统一字段名，便于匹配（移除中英文冒号）"""
    if not name:
        return ''
    return name.strip().rstrip(':：')


def get_issue_all_fields(client, issue_key, target_field_name):
    """获取并打印问题所有字段，并定位目标字段详情"""
    print(f"\n--- 正在读取问题: {issue_key} ---")
    try:
        issue = client.issue(issue_key, expand='names,schema')
        names = issue.raw.get('names', {})
        schemas = issue.raw.get('schema', {})
        fields = issue.raw.get('fields', {})

        print(f"  Key: {issue.key}")
        print(f"  概要: {issue.fields.summary}")
        print(f"  状态: {issue.fields.status.name}")
        print(f"  创建时间: {issue.fields.created}")

        target_norm = _normalize_field_name(target_field_name)
        matched_field_ids = []

        print("\n--- 字段清单 (字段ID -> 字段名 | 类型 | 值) ---")
        for field_id in sorted(fields.keys()):
            field_name = names.get(field_id, field_id)
            schema = schemas.get(field_id, {})
            field_type = schema.get('type', 'unknown')
            field_value = fields.get(field_id, None)

            print(f"{field_id} -> {field_name} | {field_type} | {field_value}")

            if _normalize_field_name(field_name) == target_norm:
                matched_field_ids.append(field_id)

        if not matched_field_ids:
            print(f"\n⚠️ 未找到字段名为 '{target_field_name}' 的字段。")
            print("请确认字段名称是否包含中文冒号或空格。")
            return None

        print("\n--- 目标字段匹配结果 ---")
        for field_id in matched_field_ids:
            field_name = names.get(field_id, field_id)
            schema = schemas.get(field_id, {})
            field_type = schema.get('type', 'unknown')
            custom_type = schema.get('custom', 'unknown')
            field_value = fields.get(field_id, None)

            print(f"字段ID: {field_id}")
            print(f"字段名: {field_name}")
            print(f"字段类型: {field_type}")
            print(f"自定义类型: {custom_type}")
            print(f"当前值: {field_value}")

        return matched_field_ids

    except JIRAError as e:
        print(f"  错误: 无法读取问题 {issue_key} (状态码: {e.status_code})")
        return None


def get_field_allowed_values_from_editmeta(client, issue_key, target_field_name):
    """从 editmeta 获取目标字段的可选值，确认是否为下拉框"""
    print(f"\n--- 正在获取 editmeta 以解析字段可选值 ---")
    try:
        edit_meta = client.editmeta(issue_key)
        fields = edit_meta.get('fields', {})
        target_norm = _normalize_field_name(target_field_name)

        for field_id, field_info in fields.items():
            field_name = field_info.get('name', field_id)
            if _normalize_field_name(field_name) != target_norm:
                continue

            schema = field_info.get('schema', {})
            field_type = schema.get('type', 'unknown')
            print(f"目标字段: {field_name} (ID: {field_id})")
            print(f"字段类型: {field_type}")

            allowed_values = field_info.get('allowedValues', [])
            if allowed_values:
                print("可选值示例:")
                for value in allowed_values:
                    display_value = value.get('value', value.get('name', str(value)))
                    print(f"  - {display_value}")
            else:
                print("⚠️ editmeta 未返回可选值，可能是权限或字段配置原因。")
            return field_id

        print(f"⚠️ editmeta 中未找到字段 '{target_field_name}'。")
        return None

    except JIRAError as e:
        print(f"[失败] 获取 editmeta 失败: {e.text} (状态码: {e.status_code})")
        return None


# ==========================================================
# 3. 主程序入口
# ==========================================================
if __name__ == "__main__":
    print("=" * 60)
    print("JIRA 问题字段信息查看工具（Transsion）")
    print("=" * 60)

    if not test_server_connection(JIRA_SERVER):
        print("服务器不可用，退出。")
        raise SystemExit(1)

    jira = connect_to_jira(JIRA_SERVER, JIRA_USER, JIRA_PASSWORD)

    if jira:
        matched_ids = get_issue_all_fields(jira, ISSUE_KEY, TARGET_FIELD_NAME)
        get_field_allowed_values_from_editmeta(jira, ISSUE_KEY, TARGET_FIELD_NAME)

        if matched_ids:
            print("\n--- 下一步建议 ---")
            print(f"已定位字段 '{TARGET_FIELD_NAME}'，后续可尝试设置值为: {TARGET_FIELD_VALUE}")
