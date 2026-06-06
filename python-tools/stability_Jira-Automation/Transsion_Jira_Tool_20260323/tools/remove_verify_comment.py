import argparse
import os
import sys
import urllib3

from dotenv import load_dotenv
from jira import JIRA
from jira.exceptions import JIRAError


urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

JIRA_SERVER = "http://jira.transsion.com"
TARGET_COMMENT_BODY = "按照原单测试步骤验证。"


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


def build_jql(project_keys):
    quoted_project_keys = ", ".join(f'"{project_key}"' for project_key in project_keys)
    return (
        f'project in ({quoted_project_keys}) AND status in ("Resolved", "Verified") '
        f"AND updated >= -1d ORDER BY updated DESC"
    )


def find_all_project_issues(client, project_keys):
    jql = build_jql(project_keys)
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
        print(f"已获取 {len(all_issues)} 个问题...")

        if len(batch) < max_per_page:
            break
        start_at += max_per_page

    return all_issues


def normalize_comment_body(body):
    return (body or "").strip()


def find_latest_matching_comment(comments):
    for comment in reversed(comments):
        if normalize_comment_body(getattr(comment, "body", "")) == TARGET_COMMENT_BODY:
            return comment
    return None


def remove_latest_verify_comment(client, issue_key):
    try:
        comments = client.comments(issue_key)
        target_comment = find_latest_matching_comment(comments)
        if not target_comment:
            print(f"[跳过] 问题 {issue_key} 未找到目标备注")
            return False

        target_comment.delete()
        print(f"[成功] 已删除问题 {issue_key} 的最新评论: {target_comment.id}")
        return True
    except JIRAError as e:
        print(f"[失败] 删除问题 {issue_key} 备注失败: {e.text} (状态码: {e.status_code})")
        return False
    except Exception as e:
        print(f"[失败] 删除问题 {issue_key} 备注失败: {e}")
        return False


def remove_verify_comment_for_issue(client, issue_key):
    success = remove_latest_verify_comment(client, issue_key)
    if success:
        return [issue_key], [], []

    try:
        comments = client.comments(issue_key)
        target_comment = find_latest_matching_comment(comments)
        if target_comment is None:
            return [], [issue_key], []
    except Exception:
        pass
    return [], [], [issue_key]


def remove_verify_comment_for_issues(client, project_keys):
    issues = find_all_project_issues(client, project_keys)
    if not issues:
        print("未找到符合条件的问题单。")
        return [], [], []

    success_keys = []
    skipped_keys = []
    failed_keys = []

    for issue in issues:
        try:
            comments = client.comments(issue.key)
            target_comment = find_latest_matching_comment(comments)
            if not target_comment:
                print(f"[跳过] 问题 {issue.key} 未找到目标备注")
                skipped_keys.append(issue.key)
                continue

            target_comment.delete()
            print(f"[成功] 已删除问题 {issue.key} 的最新评论: {target_comment.id}")
            success_keys.append(issue.key)
        except JIRAError as e:
            print(f"[失败] 删除问题 {issue.key} 备注失败: {e.text} (状态码: {e.status_code})")
            failed_keys.append(issue.key)
        except Exception as e:
            print(f"[失败] 删除问题 {issue.key} 备注失败: {e}")
            failed_keys.append(issue.key)

    return success_keys, skipped_keys, failed_keys


def parse_args(argv=None):
    parser = argparse.ArgumentParser(
        description="删除错误写入的 Verify 备注，默认按单条 issue 处理"
    )
    parser.add_argument(
        "--issue-key",
        "-i",
        help="单条问题单号，例如 KO5OS16AEE-100",
    )
    parser.add_argument(
        "--project-keys",
        "-p",
        nargs="+",
        help="项目 Key，支持多个值，配合 --update-all 使用",
    )
    parser.add_argument(
        "--update-all",
        action="store_true",
        help="批量处理所有匹配的问题单",
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

    args = parser.parse_args(argv)

    if args.issue_key and args.update_all:
        parser.error("--issue-key 模式下不能同时使用 --update-all")
    if args.issue_key and args.project_keys:
        parser.error("--issue-key 模式下不能同时传入 --project-keys")
    if not args.issue_key and not args.update_all:
        parser.error("未指定 --issue-key 时，必须使用 --update-all")
    if args.update_all and not args.project_keys:
        parser.error("--update-all 模式下必须传入 --project-keys")

    return args


def print_summary(success_keys, skipped_keys, failed_keys):
    print("\n" + "=" * 60)
    print("执行结果汇总")
    print("=" * 60)
    print(f"成功: {len(success_keys)}")
    if success_keys:
        print(f"成功列表: {', '.join(success_keys)}")
    print(f"跳过: {len(skipped_keys)}")
    if skipped_keys:
        print(f"跳过列表: {', '.join(skipped_keys)}")
    print(f"失败: {len(failed_keys)}")
    if failed_keys:
        print(f"失败列表: {', '.join(failed_keys)}")


def main():
    args = parse_args()
    user, password = get_jira_credentials(args.jira_username, args.jira_password)
    if not user or not password:
        sys.exit(1)

    jira = connect_to_jira(JIRA_SERVER, user, password)
    if not jira:
        sys.exit(1)

    if args.issue_key:
        success_keys, skipped_keys, failed_keys = remove_verify_comment_for_issue(
            jira,
            args.issue_key,
        )
    else:
        success_keys, skipped_keys, failed_keys = remove_verify_comment_for_issues(
            jira,
            args.project_keys,
        )

    print_summary(success_keys, skipped_keys, failed_keys)
    if failed_keys:
        sys.exit(1)
    sys.exit(0)


if __name__ == "__main__":
    main()
