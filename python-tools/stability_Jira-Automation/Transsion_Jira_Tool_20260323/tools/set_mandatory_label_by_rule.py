import argparse
import re
import sys

from jira.exceptions import JIRAError

import set_mp_block as mp_tool
import set_not_mp_block as not_mp_tool


JIRA_SERVER = mp_tool.JIRA_SERVER
TARGET_FIELD_NAME = mp_tool.TARGET_FIELD_NAME
MP_BLOCK_VALUE = mp_tool.TARGET_FIELD_VALUE
NOT_MP_BLOCK_VALUE = not_mp_tool.TARGET_FIELD_VALUE
EXPCLASS_FIELD_NAME = "ExpClass"
RESOLUTION_SKIP_VALUES = (
    "不能修复",
    "无法再次复现",
    "Platform Limit",
    "Won't Fix",
    "Cannot Reproduce",
)
def _quote_jql_string(value):
    return '"' + value.replace('"', '\\"') + '"'


RESOLUTION_SKIP_JQL_VALUES = tuple(
    _quote_jql_string(value) for value in RESOLUTION_SKIP_VALUES
)
A_PRIORITY_NAME = "Blocker"
B_PRIORITY_NAME = "Critical"
PRIORITY_ALIASES = {
    A_PRIORITY_NAME: {A_PRIORITY_NAME, "紧急"},
    B_PRIORITY_NAME: {B_PRIORITY_NAME, "严重"},
}
EXPCLASS_ALIASES = {
    "JE": {"JE", "JAVA (JE)"},
    "NE": {"NE", "NATIVE (NE)"},
    "ANR": {"ANR"},
}
TOTAL_NUMBER_PATTERN = re.compile(r"(?:\[|【)\s*Total Number\s+(\d+)\s*(?:\]|】)", re.IGNORECASE)


def parse_total_number(summary):
    if not summary:
        return None
    match = TOTAL_NUMBER_PATTERN.search(summary)
    if not match:
        return None
    return int(match.group(1))


def extract_option_value(value):
    if value is None:
        return None
    if isinstance(value, dict):
        return value.get("value") or value.get("name")
    return str(value)


def extract_label_values(value):
    if value is None:
        return []
    if isinstance(value, (list, tuple, set)):
        values = []
        for item in value:
            option_value = extract_option_value(item)
            if option_value:
                values.append(option_value)
        return values

    option_value = extract_option_value(value)
    if not option_value:
        return []
    return [option_value]


def has_exactly_one_label(labels):
    return len(labels) == 1


def normalize_priority_name(priority_name):
    if not priority_name:
        return None
    normalized = str(priority_name).strip()
    for canonical_name, aliases in PRIORITY_ALIASES.items():
        if normalized in aliases:
            return canonical_name
    return normalized


def normalize_exp_class(exp_class):
    if not exp_class:
        return ""
    normalized = str(exp_class).strip().upper()
    for canonical_name, aliases in EXPCLASS_ALIASES.items():
        if normalized in aliases:
            return canonical_name
    return normalized


def determine_target_label(priority_name, exp_class, total_number, resolution_name=None):
    if resolution_name in set(RESOLUTION_SKIP_VALUES):
        return None, "skipped_resolution"

    normalized_priority_name = normalize_priority_name(priority_name)
    if normalized_priority_name == A_PRIORITY_NAME:
        return MP_BLOCK_VALUE, None
    if normalized_priority_name != B_PRIORITY_NAME:
        return None, "unsupported_priority"
    if total_number is None:
        return None, "summary_missing_total_number"

    normalized_exp_class = normalize_exp_class(exp_class)
    if normalized_exp_class in {"JE", "NE"} and total_number >= 20:
        return MP_BLOCK_VALUE, None
    if normalized_exp_class == "ANR" and total_number >= 50:
        return MP_BLOCK_VALUE, None
    return NOT_MP_BLOCK_VALUE, None


def build_failure_message(issue_key, rule_info):
    summary = rule_info.get("summary") or ""
    return (
        f"[失败] 问题 {issue_key} 规则判定失败: "
        f"reason={rule_info.get('fail_reason')}, "
        f"priority={rule_info.get('priority_name')}, "
        f"exp_class={rule_info.get('exp_class')}, "
        f"total_number={rule_info.get('total_number')}, "
        f"summary={summary}"
    )


def build_scope_jql(project_key, reporter, component_name=None):
    clauses = [
        mp_tool._format_project_clause(project_key),
        mp_tool._format_reporter_clause(reporter),
        f'priority in ("{A_PRIORITY_NAME}", "{B_PRIORITY_NAME}")',
        f"(resolution is EMPTY OR resolution not in ({', '.join(RESOLUTION_SKIP_JQL_VALUES)}))",
    ]
    if component_name:
        clauses.append(f'component = "{component_name}"')
    return " AND ".join(clauses) + " ORDER BY created DESC"


def find_all_scope_issues(
    client,
    project_key,
    reporter,
    field_ids=None,
    component_name=None,
):
    jql = build_scope_jql(project_key, reporter, component_name)
    print(f"JQL: {jql}")

    start_at = 0
    max_per_page = 100
    all_issues = []
    search_fields = None
    if field_ids:
        search_fields = [field_id for field_id in field_ids if field_id]

    while True:
        batch = client.search_issues(
            jql,
            startAt=start_at,
            maxResults=max_per_page,
            fields=search_fields,
        )
        if not batch:
            break

        all_issues.extend(batch)
        print(f"已获取 {len(all_issues)} 个问题...")

        if len(batch) < max_per_page:
            break
        start_at += max_per_page

    return all_issues


def get_issue_field_value(client, issue, field_id):
    fields = issue.raw.get("fields", {})
    if field_id in fields:
        return fields.get(field_id)
    detail = client.issue(issue.key, fields=field_id)
    return detail.raw.get("fields", {}).get(field_id)


def get_issue_target_field_meta(client, issue, default_field_id):
    issue_field_id = default_field_id
    if not issue_field_id:
        return mp_tool.get_field_meta_from_editmeta(client, issue.key, TARGET_FIELD_NAME)
    _, field_info = mp_tool.get_field_meta_from_editmeta(client, issue.key, TARGET_FIELD_NAME)
    return issue_field_id, field_info


def update_issue_mandatory_label(client, issue, target_field_id, target_value, dry_run=False):
    issue_field_id, field_info = get_issue_target_field_meta(client, issue, target_field_id)
    if not issue_field_id or not field_info:
        return False, "missing_target_field"

    current_value = get_issue_field_value(client, issue, issue_field_id)
    current_labels = extract_label_values(current_value)
    if current_labels == [target_value]:
        return False, "already_expected"
    if target_value == NOT_MP_BLOCK_VALUE and current_labels:
        return False, "existing_value"

    if dry_run:
        return True, "dry_run"

    field_value = mp_tool.build_field_value(field_info, target_value)
    issue.update(fields={issue_field_id: field_value})
    return True, None


def summarize_issue_rule(issue, expclass_field_id):
    fields = issue.raw.get("fields", {})
    summary = fields.get("summary")
    priority_name = extract_option_value(fields.get("priority"))
    exp_class = extract_option_value(fields.get(expclass_field_id))
    resolution_name = extract_option_value(fields.get("resolution"))
    total_number = parse_total_number(summary)
    target_label, fail_reason = determine_target_label(
        priority_name,
        exp_class,
        total_number,
        resolution_name,
    )
    return {
        "summary": summary,
        "priority_name": priority_name,
        "exp_class": exp_class,
        "resolution_name": resolution_name,
        "total_number": total_number,
        "target_label": target_label,
        "fail_reason": fail_reason,
    }


def validate_scope_labels(
    client,
    project_key,
    reporter,
    target_field_id,
    component_name=None,
    require_non_empty=True,
    exclude_keys=None,
):
    issues = find_all_scope_issues(
        client,
        project_key,
        reporter,
        field_ids=["summary", "priority", target_field_id],
        component_name=component_name,
    )
    empty_keys = []
    multiple_label_keys = []
    excluded = set(exclude_keys or [])

    for issue in issues:
        if issue.key in excluded:
            continue
        label_values = extract_label_values(get_issue_field_value(client, issue, target_field_id))
        if require_non_empty and not label_values:
            empty_keys.append(issue.key)
            continue
        if not label_values:
            continue
        if not has_exactly_one_label(label_values):
            multiple_label_keys.append(issue.key)

    if empty_keys or multiple_label_keys:
        messages = []
        if empty_keys:
            messages.append(f"必解标签为空: {', '.join(empty_keys)}")
        if multiple_label_keys:
            messages.append(f"必解标签存在多个值: {', '.join(multiple_label_keys)}")
        raise AssertionError("；".join(messages))


def apply_rule_based_labels(client, project_key, reporter, component_name=None, dry_run=False):
    target_field_id = mp_tool.resolve_field_id(client, TARGET_FIELD_NAME)
    expclass_field_id = mp_tool.resolve_field_id(client, EXPCLASS_FIELD_NAME)
    if not expclass_field_id:
        raise RuntimeError(f"未找到字段 {EXPCLASS_FIELD_NAME}")

    issues = find_all_scope_issues(
        client,
        project_key,
        reporter,
        field_ids=["summary", "priority", "resolution", target_field_id, expclass_field_id],
        component_name=component_name,
    )
    if not issues:
        print("未找到符合条件的问题单。")
        return {
            "updated_mp": [],
            "updated_not_mp": [],
            "already_expected": [],
            "skipped_existing_value": [],
            "skipped_resolution": [],
            "failed": [],
        }

    result = {
        "updated_mp": [],
        "updated_not_mp": [],
        "already_expected": [],
        "skipped_existing_value": [],
        "skipped_resolution": [],
        "failed": [],
    }

    for issue in issues:
        rule_info = summarize_issue_rule(issue, expclass_field_id)
        if rule_info["fail_reason"]:
            if rule_info["fail_reason"] == "skipped_resolution":
                print(
                    f"[跳过] 问题 {issue.key} 的解决结果为 {rule_info['resolution_name']}，不设置必解标签。"
                )
                result["skipped_resolution"].append(issue.key)
                continue
            print(build_failure_message(issue.key, rule_info))
            result["failed"].append(issue.key)
            continue

        try:
            updated, reason = update_issue_mandatory_label(
                client,
                issue,
                target_field_id,
                rule_info["target_label"],
                dry_run=dry_run,
            )
        except JIRAError as e:
            print(f"[失败] 更新问题 {issue.key} 失败: {e.text} (状态码: {e.status_code})")
            result["failed"].append(issue.key)
            continue

        if reason == "already_expected":
            print(f"[跳过] 问题 {issue.key} 已是 {rule_info['target_label']}")
            result["already_expected"].append(issue.key)
            continue
        if reason == "existing_value":
            print(f"[跳过] 问题 {issue.key} 的 {TARGET_FIELD_NAME} 已有值，保持不变。")
            result["skipped_existing_value"].append(issue.key)
            continue

        if updated:
            if reason == "dry_run":
                print(f"[预演] 问题 {issue.key} 将设置为 {rule_info['target_label']}")
            else:
                print(f"[成功] 问题 {issue.key} 已设置为 {rule_info['target_label']}")
            if rule_info["target_label"] == MP_BLOCK_VALUE:
                result["updated_mp"].append(issue.key)
            else:
                result["updated_not_mp"].append(issue.key)

    return result


def parse_args():
    parser = argparse.ArgumentParser(
        description="按 A/B 类和报错规则批量设置必解标签"
    )
    parser.add_argument(
        "--project-key",
        "-p",
        nargs="+",
        required=True,
        help="项目 Key，支持多个值，例如 X6852OS16 X6851OS16",
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
        "--component-name",
        help="模块名称（可选，不填写则不限制模块）",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="只预览将要设置的标签，不执行 Jira 更新，断言阶段仅做多标签预检",
    )
    return parser.parse_args()


def main():
    args = parse_args()
    user, password = mp_tool.get_jira_credentials(args.jira_username, args.jira_password)
    if not user or not password:
        sys.exit(1)

    jira = mp_tool.connect_to_jira(JIRA_SERVER, user, password)
    if not jira:
        sys.exit(1)

    result = apply_rule_based_labels(
        jira,
        args.project_key,
        args.report_username,
        component_name=args.component_name,
        dry_run=args.dry_run,
    )

    print("=" * 60)
    print("执行结果汇总")
    print("=" * 60)
    if args.dry_run:
        print(f"预计设置为 MP Block: {len(result['updated_mp'])}")
        print(f"预计设置为 Not MP Block: {len(result['updated_not_mp'])}")
    else:
        print(f"设置为 MP Block: {len(result['updated_mp'])}")
        print(f"设置为 Not MP Block: {len(result['updated_not_mp'])}")
    print(f"已符合预期: {len(result['already_expected'])}")
    print(f"已有值跳过: {len(result['skipped_existing_value'])}")
    print(f"解决结果跳过: {len(result['skipped_resolution'])}")
    print(f"失败: {len(result['failed'])}")
    if result["failed"]:
        print(f"失败列表: {', '.join(result['failed'])}")

    assertion_exclude_keys = set(result["failed"]) | set(result["skipped_resolution"])
    try:
        target_field_id = mp_tool.resolve_field_id(jira, TARGET_FIELD_NAME)
        validate_scope_labels(
            jira,
            args.project_key,
            args.report_username,
            target_field_id,
            component_name=args.component_name,
            require_non_empty=not args.dry_run,
            exclude_keys=assertion_exclude_keys,
        )
    except AssertionError as exc:
        print(f"[断言失败] {exc}")
        sys.exit(1)

    if args.dry_run:
        print("[断言通过] Dry-run 预检通过，未发现必解标签存在多个值。")
    else:
        print("[断言通过] 本次处理范围内所有 A/B 类问题必解标签均非空且只有一个值。")

    if result["failed"]:
        sys.exit(1)


if __name__ == "__main__":
    main()
