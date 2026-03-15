import argparse
import os
import sys
import urllib3

from dotenv import load_dotenv
from jira import JIRA
from jira.exceptions import JIRAError


urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

JIRA_SERVER = "http://jira.transsion.com"


def get_jira_credentials(cli_user, cli_password):
    load_dotenv()
    user = cli_user or os.getenv("JIRA_USERNAME") or os.getenv("JIRA_USER")
    password = cli_password or os.getenv("JIRA_PASSWORD")

    if not user or not password:
        print("❌ 缺少 JIRA 凭据，请在 .env 中配置:")
        print("   JIRA_USERNAME=your_user")
        print("   JIRA_PASSWORD=your_password")
        return None, None
    return user, password


def connect_to_jira(server, user, password, verify_ssl=True):
    print(f"正在连接到 JIRA 服务器: {server}")
    print(f"SSL 验证: {'启用' if verify_ssl else '禁用'}")
    try:
        options = {
            'verify': verify_ssl,
            'server': server
        }
        jira_client = JIRA(options=options, basic_auth=(user, password))
        current_user = jira_client.current_user()
        print(f"[成功] JIRA 连接成功，当前登录用户: {current_user}")
        return jira_client
    except JIRAError as e:
        print(f"[失败] JIRA 连接失败: {e.text} (状态码: {e.status_code})")
        return None
    except Exception as e:
        print(f"[失败] JIRA 连接失败: {type(e).__name__}: {e}")
        import traceback
        traceback.print_exc()
        return None


def get_issue_status(client, issue_key):
    """获取问题单当前状态"""
    try:
        issue = client.issue(issue_key)
        status = issue.fields.status
        print(f"\n📋 问题单 {issue_key} 当前状态:")
        print(f"   状态名称: {status.name}")
        print(f"   状态ID: {status.id}")
        print(f"   状态描述: {getattr(status, 'description', 'N/A')}")
        return issue, status
    except JIRAError as e:
        print(f"[失败] 获取问题单 {issue_key} 失败: {e.text} (状态码: {e.status_code})")
        return None, None
    except Exception as e:
        print(f"[失败] 获取问题单 {issue_key} 失败: {e}")
        return None, None


def get_available_transitions(client, issue_key):
    """获取问题单可用的状态转换"""
    try:
        transitions = client.transitions(issue_key)
        print(f"\n🔄 可用的状态转换 ({len(transitions)} 个):")
        if not transitions:
            print("   无可用的状态转换")
            return []

        for t in transitions:
            print(f"   - ID: {t['id']}, 名称: {t['name']}, 目标状态: {t['to']['name']}")
        return transitions
    except JIRAError as e:
        print(f"[失败] 获取转换失败: {e.text} (状态码: {e.status_code})")
        return []
    except Exception as e:
        print(f"[失败] 获取转换失败: {e}")
        return []


def transition_issue(client, issue_key, transition_id, comment=None):
    """执行状态转换"""
    try:
        print(f"\n🚀 尝试转换问题单 {issue_key}...")
        print(f"   转换ID: {transition_id}")

        kwargs = {"transition": transition_id}
        if comment:
            kwargs["comment"] = comment

        client.transition_issue(issue_key, **kwargs)
        print(f"[成功] 问题单 {issue_key} 状态转换成功!")

        # 验证新状态
        issue = client.issue(issue_key)
        new_status = issue.fields.status
        print(f"   新状态: {new_status.name}")
        return True
    except JIRAError as e:
        print(f"[失败] 状态转换失败: {e.text} (状态码: {e.status_code})")
        if e.status_code == 400:
            print("   💡 提示: 可能是转换不适用于当前状态，或者缺少必需字段")
        elif e.status_code == 401:
            print("   💡 提示: 权限不足，无法执行此转换")
        elif e.status_code == 404:
            print("   💡 提示: 转换ID不存在")
        return False
    except Exception as e:
        print(f"[失败] 状态转换失败: {e}")
        return False


def try_reopen_issue(client, issue_key, comment=None):
    """尝试将已关闭问题单重新打开"""
    print(f"\n{'='*60}")
    print(f"尝试重新打开问题单: {issue_key}")
    print(f"{'='*60}")

    # 1. 获取当前状态
    issue, status = get_issue_status(client, issue_key)
    if not issue:
        return False

    # 2. 获取可用转换
    transitions = get_available_transitions(client, issue_key)
    if not transitions:
        print("\n⚠️ 问题单可能处于终态，没有可用的状态转换")
        print("   对于已关闭的问题单，通常需要:")
        print("   1. 检查是否有 'Reopen' 或 '重新打开' 转换")
        print("   2. 确认当前用户有权限执行此操作")
        print("   3. 某些工作流可能不允许重新打开已关闭的问题单")
        return False

    # 3. 查找重新打开相关的转换
    reopen_transitions = []
    for t in transitions:
        name = t['name'].lower()
        to_name = t['to']['name'].lower()
        if any(keyword in name or keyword in to_name for keyword in
                ['reopen', '重新打开', '打开', 'open', 'active', '激活']):
            reopen_transitions.append(t)

    if reopen_transitions:
        print(f"\n🔍 找到 {len(reopen_transitions)} 个可能用于重新打开的转换:")
        for t in reopen_transitions:
            print(f"   - ID: {t['id']}, 名称: {t['name']}")

        # 尝试第一个匹配的转换
        chosen = reopen_transitions[0]
        print(f"\n➡️  尝试使用转换: {chosen['name']} (ID: {chosen['id']})")
        return transition_issue(client, issue_key, chosen['id'], comment)
    else:
        print("\n⚠️ 未找到明确的重新打开转换")
        print("   可用转换列表:")
        for t in transitions:
            print(f"   - {t['name']} (到: {t['to']['name']})")

        # 让用户选择
        return None


def interactive_transition(client, issue_key):
    """交互式选择并执行转换"""
    issue, status = get_issue_status(client, issue_key)
    if not issue:
        return False

    transitions = get_available_transitions(client, issue_key)
    if not transitions:
        print("没有可用的转换")
        return False

    print("\n请选择要执行的转换 (输入数字):")
    for i, t in enumerate(transitions, 1):
        print(f"   {i}. {t['name']} (到: {t['to']['name']}, ID: {t['id']})")

    try:
        choice = input("\n选择 (或按Enter取消): ").strip()
        if not choice:
            print("已取消")
            return False

        idx = int(choice) - 1
        if 0 <= idx < len(transitions):
            chosen = transitions[idx]
            comment = input("添加注释 (可选，直接回车跳过): ").strip()
            return transition_issue(client, issue_key, chosen['id'],
                                   comment if comment else None)
        else:
            print("无效的选择")
            return False
    except ValueError:
        print("请输入数字")
        return False


def parse_args():
    parser = argparse.ArgumentParser(
        description="改变 JIRA 问题单状态 (特别是尝试重新打开已关闭问题单)"
    )
    parser.add_argument(
        "--issue-key",
        "-i",
        required=True,
        help="问题单号，例如 KO5OS16-1794",
    )
    parser.add_argument(
        "--jira-username",
        "-u",
        help="JIRA 用户名（可选，未提供则读取 .env）",
    )
    parser.add_argument(
        "--jira-password",
        "-w",
        help="JIRA 密码（可选，未提供则读取 .env）",
    )
    parser.add_argument(
        "--transition-id",
        "-t",
        help="指定转换ID（可选，不提供则自动尝试重新打开）",
    )
    parser.add_argument(
        "--comment",
        "-c",
        help="添加注释到转换操作（可选）",
    )
    parser.add_argument(
        "--interactive",
        "-I",
        action="store_true",
        help="交互模式：列出所有可用转换并选择",
    )
    parser.add_argument(
        "--check-only",
        action="store_true",
        help="仅检查状态和可用转换，不执行任何操作",
    )
    parser.add_argument(
        "--no-verify-ssl",
        action="store_true",
        help="禁用 SSL 证书验证（用于自签名证书）",
    )
    parser.add_argument(
        "--https",
        action="store_true",
        help="使用 HTTPS 而不是 HTTP",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    user, password = get_jira_credentials(args.jira_username, args.jira_password)
    if not user or not password:
        sys.exit(1)

    # 根据参数构建服务器地址
    server = JIRA_SERVER
    if args.https:
        server = JIRA_SERVER.replace("http://", "https://")

    jira = connect_to_jira(server, user, password, verify_ssl=not args.no_verify_ssl)
    if not jira:
        sys.exit(1)

    # 仅检查模式
    if args.check_only:
        issue, status = get_issue_status(jira, args.issue_key)
        if issue:
            get_available_transitions(jira, args.issue_key)
        sys.exit(0)

    # 交互模式
    if args.interactive:
        result = interactive_transition(jira, args.issue_key)
        sys.exit(0 if result else 1)

    # 指定转换ID模式
    if args.transition_id:
        success = transition_issue(jira, args.issue_key, args.transition_id, args.comment)
        sys.exit(0 if success else 1)

    # 默认模式：尝试重新打开
    result = try_reopen_issue(jira, args.issue_key, args.comment)
    if result is None:
        # 没有明确重新打开选项，切换到交互模式
        print("\n" + "="*60)
        print("切换到交互模式...")
        print("="*60)
        result = interactive_transition(jira, args.issue_key)
        sys.exit(0 if result else 1)

    sys.exit(0 if result else 1)


if __name__ == "__main__":
    main()
