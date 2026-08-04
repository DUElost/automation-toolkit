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


def normalize_field_name(name):
    if not name:
        return ""
    return name.strip().rstrip(":：")


def is_empty_field_value(value):
    if value is None:
        return True
    if isinstance(value, str):
        return not value.strip()
    if isinstance(value, (list, tuple, set)):
        return len(value) == 0
    if isinstance(value, dict):
        return len(value) == 0
    return False


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


def _format_priority_clause(priority_name):
    if not priority_name:
        return None
    if isinstance(priority_name, (list, tuple)):
        names = [p for p in priority_name if p]
        if not names:
            return None
        if len(names) == 1:
            return f'priority = "{names[0]}"'
        joined = ", ".join(f'"{name}"' for name in names)
        return f"priority in ({joined})"
    return f'priority = "{priority_name}"'


def _format_exclude_priority_clause(priority_name):
    if not priority_name:
        return None
    if isinstance(priority_name, (list, tuple)):
        names = [p for p in priority_name if p]
        if not names:
            return None
        if len(names) == 1:
            return f'(priority != "{names[0]}" OR priority is EMPTY)'
        joined = ", ".join(f'"{name}"' for name in names)
        return f"(priority not in ({joined}) OR priority is EMPTY)"
    return f'(priority != "{priority_name}" OR priority is EMPTY)'


def _format_project_clause(project_key):
    if isinstance(project_key, (list, tuple)):
        names = [name for name in project_key if name]
        if not names:
            return None
        if len(names) == 1:
            return f'project = "{names[0]}"'
        joined = ", ".join(f'"{name}"' for name in names)
        return f"project in ({joined})"
    return f'project = "{project_key}"'


def _format_reporter_clause(reporter):
    if not reporter:
        return "reporter = currentUser()"
    if isinstance(reporter, (list, tuple)):
        names = [name for name in reporter if name]
        if not names:
            return "reporter = currentUser()"
        if len(names) == 1:
            return f'reporter = "{names[0]}"'
        joined = ", ".join(f'"{name}"' for name in names)
        return f"reporter in ({joined})"
    return f'reporter = "{reporter}"'


def _format_empty_field_clause(field_id, field_name):
    if field_id:
        cf_num = field_id.replace("customfield_", "")
        if cf_num.isdigit():
            return f"cf[{cf_num}] is EMPTY"
    return f'"{field_name}" is EMPTY'


def build_jql(
    project_key,
    reporter,
    priority_name=None,
    component_name=None,
    exclude_priority_names=None,
    require_empty_field=True,
    empty_field_name=TARGET_FIELD_NAME,
    empty_field_id=None,
):
    clauses = [
        _format_project_clause(project_key),
        _format_reporter_clause(reporter),
    ]
    priority_clause = _format_priority_clause(priority_name)
    if priority_clause:
        clauses.append(priority_clause)
    exclude_priority_clause = _format_exclude_priority_clause(exclude_priority_names)
    if exclude_priority_clause:
        clauses.append(exclude_priority_clause)
    if component_name:
        clauses.append(f'component = "{component_name}"')
    if require_empty_field and (empty_field_id or empty_field_name):
        clauses.append(_format_empty_field_clause(empty_field_id, empty_field_name))
    return " AND ".join(clauses) + " ORDER BY created DESC"


def _search_fields(field_id):
    if field_id:
        return field_id
    return None


def search_matching_issues(
    client,
    jql,
    field_id=None,
    max_results=None,
):
    print(f"JQL: {jql}")
    search_fields = _search_fields(field_id)
    kwargs = {"maxResults": max_results or 100}
    if search_fields:
        kwargs["fields"] = search_fields

    if max_results is not None and max_results <= 100:
        return client.search_issues(jql, **kwargs)

    start_at = 0
    max_per_page = 100
    all_issues = []

    while True:
        page_kwargs = dict(kwargs)
        page_kwargs["startAt"] = start_at
        page_kwargs["maxResults"] = max_per_page
        batch = client.search_issues(jql, **page_kwargs)
        if not batch:
            break

        all_issues.extend(batch)
        print(f"已获取 {len(all_issues)} 个问题...")

        if max_results is not None and len(all_issues) >= max_results:
            return all_issues[:max_results]

        if len(batch) < max_per_page:
            break
        start_at += max_per_page

    return all_issues


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


def resolve_field_info(client, issue_key, known_field_id):
    issue_field_id, field_info = get_field_meta_from_editmeta(
        client, issue_key, TARGET_FIELD_NAME
    )
    if issue_field_id and field_info:
        return issue_field_id, field_info
    if known_field_id:
        return known_field_id, None
    return None, None


def build_field_value(field_info, target_value):
    allowed_values = field_info.get("allowedValues", [])
    schema = field_info.get("schema", {})
    field_type = schema.get("type", "")

    selected = None
    if allowed_values:
        for option in allowed_values:
            option_value = option.get("value") or option.get("name")
            if option_value == target_value:
                selected = option
                break

    if selected is None:
        selected = {"value": target_value}

    if field_type == "array":
        return [selected]
    return selected


def set_block_labels(
    client,
    target_value,
    project_key,
    reporter,
    update_all=False,
    priority_name=None,
    component_name=None,
    exclude_priority_names=None,
):
    field_id = resolve_field_id(client, TARGET_FIELD_NAME)
    jql = build_jql(
        project_key,
        reporter,
        priority_name,
        component_name,
        exclude_priority_names=exclude_priority_names,
        require_empty_field=True,
        empty_field_id=field_id,
    )

    if update_all:
        issues = search_matching_issues(client, jql, field_id=field_id)
    else:
        issues = search_matching_issues(client, jql, field_id=field_id, max_results=1)

    if not issues:
        print("未找到符合条件的问题单。")
        return None

    updated_keys = []
    cached_field_info = None

    for issue in issues:
        issue_field_id, field_info = resolve_field_info(client, issue.key, field_id)
        if not issue_field_id or not field_info:
            print(f"问题 {issue.key} 未找到字段 {TARGET_FIELD_NAME}，跳过。")
            continue

        if cached_field_info is None:
            cached_field_info = field_info

        issue_value = issue.raw.get("fields", {}).get(issue_field_id)
        if not is_empty_field_value(issue_value):
            print(f"问题 {issue.key} 的 {TARGET_FIELD_NAME} 已有值，跳过。")
            continue

        field_value = build_field_value(cached_field_info, target_value)
        try:
            issue.update(fields={issue_field_id: field_value})
            print(f"[成功] 已设置 {TARGET_FIELD_NAME} 为 {target_value}")
            print(f"对应单号: {issue.key}")
            updated_keys.append(issue.key)
            if not update_all:
                return issue.key
        except JIRAError as e:
            print(f"[失败] 更新问题 {issue.key} 失败: {e.text} (状态码: {e.status_code})")
            continue

    if not updated_keys:
        print("未能更新任何问题单，请检查字段权限或问题状态。")
        return None

    if update_all:
        print(f"批量更新完成，共更新 {len(updated_keys)} 个问题单。")
        print(f"更新列表: {', '.join(updated_keys)}")
    return updated_keys if update_all else updated_keys[0]


def parse_block_args(description):
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument(
        "--project-key",
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
        "--report-username",
        "-r",
        nargs="+",
        help="问题单提单人用户名（可选，支持多个值，默认使用 currentUser）",
    )
    parser.add_argument(
        "--priority-name",
        nargs="+",
        help="优先级名称（可选，支持多个值：--priority-name Blocker Critical）",
    )
    parser.add_argument(
        "--exclude-priority-name",
        nargs="+",
        help="排除的优先级名称（可选，支持多个值）",
    )
    parser.add_argument(
        "--component-name",
        help="模块名称（可选，不填写则不限制模块）",
    )
    parser.add_argument(
        "--update-all",
        action="store_true",
        help="更新所有必解标签为空的问题单（默认只更新最新一条）",
    )
    return parser.parse_args()


def run_block_tool(target_value):
    args = parse_block_args(
        f"设置当前用户提单的必解标签为 {target_value}"
    )
    user, password = get_jira_credentials(args.jira_username, args.jira_password)
    if not user or not password:
        sys.exit(1)

    jira = connect_to_jira(JIRA_SERVER, user, password)
    if not jira:
        sys.exit(1)

    set_block_labels(
        jira,
        target_value,
        args.project_key,
        args.report_username,
        update_all=args.update_all,
        priority_name=args.priority_name,
        component_name=args.component_name,
        exclude_priority_names=args.exclude_priority_name,
    )
