import argparse
import os
import sys
import urllib3

from dotenv import load_dotenv
from jira import JIRA
from jira.exceptions import JIRAError


urllib3.disable_warnings(urllib3.exceptions.InsecureRequestWarning)

JIRA_SERVER = "http://jira.transsion.com"
TARGET_FIELD_NAME = "必解标签"
TARGET_FIELD_VALUE = "Not MP Block"

def normalize_field_name(name):
    if not name:
        return ""
    return name.strip().rstrip(":：")


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


def resolve_field_id(client, target_field_name):
    try:
        fields = client.fields()
    except JIRAError as e:
        print(f"[失败] 获取字段列表失败: {e.text} (状态码: {e.status_code})")
        return None

    target_norm = normalize_field_name(target_field_name)
    matches = []
    for field in fields:
        name = field.get("name", "")
        if normalize_field_name(name) == target_norm:
            matches.append(field.get("id"))

    if not matches:
        return None
    if len(matches) > 1:
        print(f"⚠️ 找到多个同名字段 {target_field_name}: {matches}")
    return matches[0]


def get_field_meta_from_editmeta(client, issue_key, target_field_name):
    edit_meta = client.editmeta(issue_key)
    fields = edit_meta.get("fields", {})
    target_norm = normalize_field_name(target_field_name)

    for field_id, field_info in fields.items():
        field_name = field_info.get("name", field_id)
        if normalize_field_name(field_name) == target_norm:
            return field_id, field_info
    return None, None


def has_not_mp_block(value):
    if value is None:
        return False
    if isinstance(value, list):
        return any(item.get("value") == TARGET_FIELD_VALUE for item in value if isinstance(item, dict))
    if isinstance(value, dict):
        return value.get("value") == TARGET_FIELD_VALUE
    if isinstance(value, str):
        return value.strip() == TARGET_FIELD_VALUE
    return False


def build_clear_value(field_info):
    schema = field_info.get("schema", {})
    field_type = schema.get("type", "")
    if field_type == "array":
        return []
    return None


def build_jql(project_key, reporter, priority_value, component_name):
    reporter_clause = f'reporter = "{reporter}"' if reporter else "reporter = currentUser()"
    clauses = [
        f'project = "{project_key}"',
        reporter_clause,
    ]
    if priority_value:
        clauses.append(f'priority = "{priority_value}"')
    if component_name:
        clauses.append(f'component = "{component_name}"')
    jql = " AND ".join(clauses) + " ORDER BY created DESC"
    return jql


def find_latest_issue_with_not_mp_block(
    client, project_key, reporter, priority_value, component_name
):
    jql = build_jql(project_key, reporter, priority_value, component_name)
    print(f"JQL: {jql}")
    start_at = 0
    max_per_page = 100
    field_id = resolve_field_id(client, TARGET_FIELD_NAME)

    while True:
        if field_id:
            batch = client.search_issues(
                jql,
                startAt=start_at,
                maxResults=max_per_page,
                fields=field_id,
            )
        else:
            batch = client.search_issues(
                jql,
                startAt=start_at,
                maxResults=max_per_page,
            )

        if not batch:
            break

        for issue in batch:
            issue_field_id = field_id
            issue_value = None
            if issue_field_id:
                issue_value = issue.raw.get("fields", {}).get(issue_field_id)
            if issue_value is None:
                detail = client.issue(issue.key, fields=issue_field_id or "*all")
                issue_field_id = issue_field_id or resolve_field_id(client, TARGET_FIELD_NAME)
                issue_value = detail.raw.get("fields", {}).get(issue_field_id)

            if has_not_mp_block(issue_value):
                return issue, issue_field_id

        if len(batch) < max_per_page:
            break
        start_at += max_per_page

    return None, None


def find_all_issues_with_not_mp_block(
    client, project_key, reporter, priority_value, component_name
):
    jql = build_jql(project_key, reporter, priority_value, component_name)
    print(f"JQL: {jql}")
    start_at = 0
    max_per_page = 100
    field_id = resolve_field_id(client, TARGET_FIELD_NAME)
    all_matches = []

    while True:
        if field_id:
            batch = client.search_issues(
                jql,
                startAt=start_at,
                maxResults=max_per_page,
                fields=field_id,
            )
        else:
            batch = client.search_issues(
                jql,
                startAt=start_at,
                maxResults=max_per_page,
            )

        if not batch:
            break

        for issue in batch:
            issue_field_id = field_id
            issue_value = None
            if issue_field_id:
                issue_value = issue.raw.get("fields", {}).get(issue_field_id)
            if issue_value is None:
                detail = client.issue(issue.key, fields=issue_field_id or "*all")
                issue_field_id = issue_field_id or resolve_field_id(client, TARGET_FIELD_NAME)
                issue_value = detail.raw.get("fields", {}).get(issue_field_id)

            if has_not_mp_block(issue_value):
                all_matches.append((issue, issue_field_id))

        if len(batch) < max_per_page:
            break
        start_at += max_per_page

    return all_matches


def clear_not_mp_block_for_latest_issue(
    client, project_key, reporter, priority_value, component_name, update_all
):
    if update_all:
        targets = find_all_issues_with_not_mp_block(
            client, project_key, reporter, priority_value, component_name
        )
        if not targets:
            print("未找到满足条件的问题单。")
            return None

        updated_keys = []
        for issue, field_id in targets:
            _, field_info = get_field_meta_from_editmeta(client, issue.key, TARGET_FIELD_NAME)
            if not field_info:
                print(f"问题 {issue.key} 未找到字段 {TARGET_FIELD_NAME}，跳过。")
                continue

            clear_value = build_clear_value(field_info)
            try:
                issue.update(fields={field_id: clear_value})
                print(f"[成功] 已清空 {TARGET_FIELD_NAME}: {issue.key}")
                updated_keys.append(issue.key)
            except JIRAError as e:
                print(f"[失败] 更新问题 {issue.key} 失败: {e.text} (状态码: {e.status_code})")
                continue

        if not updated_keys:
            print("未能更新任何问题单，请检查字段权限或问题状态。")
            return None

        print(f"批量更新完成，共更新 {len(updated_keys)} 个问题单。")
        print(f"更新列表: {', '.join(updated_keys)}")
        return updated_keys

    issue, field_id = find_latest_issue_with_not_mp_block(
        client, project_key, reporter, priority_value, component_name
    )
    if not issue or not field_id:
        print("未找到满足条件的问题单。")
        return None

    _, field_info = get_field_meta_from_editmeta(client, issue.key, TARGET_FIELD_NAME)
    if not field_info:
        print(f"问题 {issue.key} 未找到字段 {TARGET_FIELD_NAME}，跳过。")
        return None

    clear_value = build_clear_value(field_info)
    try:
        issue.update(fields={field_id: clear_value})
        print(f"[成功] 已清空 {TARGET_FIELD_NAME}")
        print(f"对应单号: {issue.key}")
        return issue.key
    except JIRAError as e:
        print(f"[失败] 更新问题 {issue.key} 失败: {e.text} (状态码: {e.status_code})")
        return None


def parse_args():
    parser = argparse.ArgumentParser(
        description="清空最新一条已设置 Not MP Block 且优先级为重要的问题单"
    )
    parser.add_argument(
        "--project-key",
        "-p",
        required=True,
        help="项目 Key，例如 KO5OS16AEE",
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
        "--report-username",
        "-r",
        help="问题单提单人用户名（可选，默认使用 currentUser）",
    )
    parser.add_argument(
        "--priority-name",
        help="优先级名称（可选，不填写则不限制优先级）",
    )
    parser.add_argument(
        "--component-name",
        help="模块名称（可选，不填写则不限制模块）",
    )
    parser.add_argument(
        "--update-all",
        action="store_true",
        help="更新所有符合条件的问题单（默认只更新最新一条）",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    user, password = get_jira_credentials(args.jira_username, args.jira_password)
    if not user or not password:
        sys.exit(1)

    jira = connect_to_jira(JIRA_SERVER, user, password)
    if not jira:
        sys.exit(1)

    clear_not_mp_block_for_latest_issue(
        jira,
        args.project_key,
        args.report_username,
        args.priority_name,
        args.component_name,
        args.update_all,
    )


if __name__ == "__main__":
    main()
