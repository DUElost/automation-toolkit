import requests
from requests.auth import HTTPBasicAuth
import json
import os
import ssl
from requests.adapters import HTTPAdapter
from urllib3.poolmanager import PoolManager
from urllib3.util.ssl_ import create_urllib3_context

# --- 配置信息 ---
JIRA_URL = "https://jira.tinno.com"
JIRA_USERNAME = os.getenv("JIRA_USERNAME", "dai.lv")
JIRA_PASSWORD = os.getenv("JIRA_PASSWORD", "l,74926520")

# --- 证书文件路径 ---
CERT_FILE = "client.crt"
KEY_FILE = "client.key"
# 如果您在浏览器中导出了公司CA证书，请取消下面这行的注释
# CA_BUNDLE_FILE = "company-ca.pem"
CA_BUNDLE_FILE = None # 如果不需要单独的CA文件，则设为None

# --- 自定义SSL适配器 ---
class CustomHttpAdapter(HTTPAdapter):
    def init_poolmanager(self, connections, maxsize, block=False, **pool_kwargs):
        context = create_urllib3_context(ciphers='ALL:@SECLEVEL=1')
        # 如果提供了公司CA文件，就加载它
        if CA_BUNDLE_FILE and os.path.exists(CA_BUNDLE_FILE):
            try:
                context.load_verify_locations(cafile=CA_BUNDLE_FILE)
            except ssl.SSLError as e:
                print(f"!!! 致命错误: 无法加载CA文件 '{CA_BUNDLE_FILE}'. 原因: {e}")
                exit()
        elif CA_BUNDLE_FILE:
            print(f"!!! 警告: 指定的CA文件 '{CA_BUNDLE_FILE}' 不存在。")
            
        self.poolmanager = PoolManager(
            num_pools=connections,
            maxsize=maxsize,
            block=block,
            ssl_context=context
        )

# --- 主要API函数 ---

def setup_jira_session():
    """配置并返回一个可复用的Jira session对象"""
    auth = HTTPBasicAuth(JIRA_USERNAME, JIRA_PASSWORD)
    cert = (CERT_FILE, KEY_FILE) if os.path.exists(CERT_FILE) and os.path.exists(KEY_FILE) else None
    if not cert:
        print(f"!!! 致命错误: 客户端证书文件 '{CERT_FILE}' 或 '{KEY_FILE}' 未找到。")
        return None

    session = requests.Session()
    adapter = CustomHttpAdapter()
    session.mount("https://", adapter)
    
    session.auth = auth
    session.cert = cert
    session.headers.update({"Accept": "application/json", "Content-Type": "application/json"})
    
    return session

def get_my_info(session):
    """获取当前用户信息"""
    print("\n--- 正在获取当前用户信息 ---")
    try:
        response = session.get(f"{JIRA_URL}/rest/api/2/myself", timeout=20)
        response.raise_for_status()
        user_info = response.json()
        print(f"✓ 成功! 用户: {user_info.get('displayName')} ({user_info.get('name')})")
        return user_info
    except requests.exceptions.RequestException as e:
        print(f"✗ 获取用户信息失败: {e}")
        if e.response is not None:
             print(f"  响应内容: {e.response.text[:200]}")
        return None

def get_my_created_issues(session):
    """查询当前用户创建的问题"""
    print("\n--- 正在查询当前用户创建的问题 ---")
    jql_query = "reporter = currentUser() ORDER BY created DESC"
    search_url = f"{JIRA_URL}/rest/api/2/search"
    params = {'jql': jql_query, 'fields': 'summary,status', 'maxResults': 10}

    try:
        response = session.get(search_url, params=params, timeout=30)
        response.raise_for_status()
        data = response.json()
        issues = data.get('issues', [])
        
        print(f"✓ 找到了 {len(issues)} 个由您创建的问题 (显示前10个):")
        for issue in issues:
            print(f"  - [{issue['key']}] {issue['fields']['summary']} (状态: {issue['fields']['status']['name']})")
        return issues
    except requests.exceptions.RequestException as e:
        print(f"✗ 查询问题时出错: {e}")
        return None

# --- 主程序 ---
if __name__ == "__main__":
    jira_session = setup_jira_session()
    
    if jira_session:
        get_my_info(jira_session)
        get_my_created_issues(jira_session)