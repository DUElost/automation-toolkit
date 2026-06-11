import argparse
import os
import sys
import urllib3

from dotenv import load_dotenv
from jira import JIRA
from jira.exceptions import JIRAError


urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

JIRA_SERVER = "http://jira.transsion.com"
VERIFY_TRANSITION_NAME = "VerifyIssue"
VERIFY_COMMENT = "按照原单测试步骤验证。"


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


def connect_to_jira(server, user, password):
    print(f"正在连接到 JIRA 服务器: {server}")
    try:
        jira_client = JIRA(server, basic_auth=(user, password))
        current_user = jira_client.current_user()
        print(f"[成功] JIRA 连接成功，当前登录用户: {current_user}")
        return jira_client
    except JIRAError as e:
        print(f"[失败] JIRA 连接失败: {e.text} (状态码: {e.status_code})")
        return None
    except Exception as e:
        print(f"[失败] JIRA 连接失败: {e}")
        return None


def build_reporter_clause(reporters):
    names = [name for name in reporters if name]
    if len(names) == 1:
        return f'reporter = "{names[0]}"'

    quoted_names = ", ".join(f'"{name}"' for name in names)
    return f"reporter in ({quoted_names})"


def build_jql(project_keys, reporters):
    quoted_project_keys = ", ".join(f'"{project_key}"' for project_key in project_keys)
    clauses = [
        f"project in ({quoted_project_keys})",
        'status = "Resolved"',
        build_reporter_clause(reporters),
    ]
    return " AND ".join(clauses) + " ORDER BY created DESC"


def find_all_resolved_issues(client, project_keys, reporters):
    jql = build_jql(project_keys, reporters)
    print(f"JQL: {jql}")

    start_at = 0
    max_per_page = 100
    all_issues = []

    while True:
        batch = client.search_issues(
            jql,
            startAt=start_at,
            maxResults=max_per_page,
        )
        if not batch:
            break

        all_issues.extend(batch)
        print(f"已获取 {len(all_issues)} 个已解决问题...")

        if len(batch) < max_per_page:
            break
        start_at += max_per_page

    return all_issues


def find_verify_transition(transitions):
    for transition in transitions:
        if transition.get("name") == VERIFY_TRANSITION_NAME:
            return transition
    return None


def get_verify_transition_for_issue(client, issue_key):
    transitions = client.transitions(issue_key)
    return find_verify_transition(transitions)


def transition_issue_to_verified(client, issue, dry_run=False):
    issue_key = issue.key if hasattr(issue, "key") else issue

    try:
        transition = get_verify_transition_for_issue(client, issue_key)
        if not transition:
            print(f"[跳过] 问题 {issue_key} 未找到 {VERIFY_TRANSITION_NAME} 转换")
            return "skipped"

        if dry_run:
            print(f"[预演] 问题 {issue_key} 将流转到 Verified")
            return "dry_run"

        client.transition_issue(
            issue_key,
            transition=transition["id"],
            comment=VERIFY_COMMENT,
        )
        print(f"[成功] 问题 {issue_key} 已流转到 Verified")
        return "success"
    except JIRAError as e:
        print(f"[失败] 问题 {issue_key} 流转失败: {e.text} (状态码: {e.status_code})")
        return "failed"
    except Exception as e:
        print(f"[失败] 问题 {issue_key} 流转失败: {e}")
        return "failed"


def verify_resolved_issues(client, project_keys, reporters, dry_run=False):
    issues = find_all_resolved_issues(client, project_keys, reporters)
    if not issues:
        print("未找到状态为 Resolved 的问题单。")
        return [], [], []

    success_keys = []
    skipped_keys = []
    failed_keys = []

    for issue in issues:
        status = transition_issue_to_verified(client, issue, dry_run=dry_run)
        if status in ("success", "dry_run"):
            success_keys.append(issue.key)
        elif status == "skipped":
            skipped_keys.append(issue.key)
        else:
            failed_keys.append(issue.key)

    return success_keys, skipped_keys, failed_keys


def parse_args(argv=None):
    parser = argparse.ArgumentParser(
        description="批量将多个项目中状态为 Resolved 的问题流转到 Verified"
    )
    parser.add_argument(
        "--project-keys",
        "-p",
        nargs="+",
        required=True,
        help="项目 Key，支持多个值，例如 KO5OS16AEE KO5OS16BEE",
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
        "--reporter",
        "--report-username",
        "-r",
        dest="reporter",
        nargs="+",
        required=True,
        help="问题单提单人用户名（必填，支持多个值）",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="只预览将要流转的问题单，不执行 Jira 状态更新",
    )
    return parser.parse_args(argv)


def main():
    args = parse_args()
    user, password = get_jira_credentials(args.jira_username, args.jira_password)
    if not user or not password:
        sys.exit(1)

    jira = connect_to_jira(JIRA_SERVER, user, password)
    if not jira:
        sys.exit(1)

    success_keys, skipped_keys, failed_keys = verify_resolved_issues(
        jira,
        args.project_keys,
        args.reporter,
        dry_run=args.dry_run,
    )

    print("\n" + "=" * 60)
    print("执行结果汇总")
    print("=" * 60)
    if args.dry_run:
        print(f"预计流转: {len(success_keys)}")
    else:
        print(f"成功: {len(success_keys)}")
    if success_keys:
        label = "预计列表" if args.dry_run else "成功列表"
        print(f"{label}: {', '.join(success_keys)}")
    print(f"跳过: {len(skipped_keys)}")
    if skipped_keys:
        print(f"跳过列表: {', '.join(skipped_keys)}")
    print(f"失败: {len(failed_keys)}")
    if failed_keys:
        print(f"失败列表: {', '.join(failed_keys)}")

    if failed_keys:
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    main()
