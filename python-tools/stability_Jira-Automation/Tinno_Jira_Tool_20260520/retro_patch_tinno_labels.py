#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
retro_patch_tinno_labels.py
---------------------------

给历史已建单批量补打 labels：

1. 保留单上已有的其它标签；
2. 按 Summary 中的专项 token 补齐对应的测试专项标签；
3. 追加固定标签（默认 `稳定性测试`，可配置 `fixed_labels`）；
4. 若单上 labels 恰好等于历史静态默认值（如仅 `MonkeyAEE`）且与 Summary 专项不符，
   默认把这些错误残留替换为正确专项（可用 --no-cleanup-legacy 关闭，改为只追加）。

历史缺陷：建单时 labels 一直取配置静态值，所有单均为 MonkeyAEE 而非对应专项。

用法：

    # 预览某项目所有自动化单将要打的标签
    python "retro_patch_tinno_labels.py" --project VCAME --dry-run ^
        --jira-cookie-jsessionid "<JSESSIONID>" --jira-cookie-xsrf-token "<XSRF_TOKEN>"

    # 真实执行
    python "retro_patch_tinno_labels.py" --project VCAME ^
        --jira-cookie-jsessionid "<JSESSIONID>" --jira-cookie-xsrf-token "<XSRF_TOKEN>"

    # 只处理指定单
    python "retro_patch_tinno_labels.py" --issue-key VCAME-123 --issue-key VCAME-124 ...

    # 完全自定义 JQL
    python "retro_patch_tinno_labels.py" --jql "project = VCAME AND reporter in (dai.lv)" ...
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, List, Optional

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from create_tinno_jira_batch_from_excel import (
    DEFAULT_CONFIG_FILE,
    build_regression_base_jql,
    build_regression_export_jql,
    load_defaults,
    load_local_env,
    setup_logging,
)
from tinno_batch_jira_common import (
    DEFAULT_FIXED_LABELS,
    connect_to_jira,
    normalize_specialty_token_from_summary,
    update_issue_fields,
)

logger = logging.getLogger(__name__)

RESULT_DIR = CURRENT_DIR / "result"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="批量给 Tinno 历史问题单补打/修正 labels")
    parser.add_argument("--project", dest="project", default=None, help="Jira 项目 Key（默认取配置 project_key）")
    parser.add_argument("--jql", dest="jql", default=None, help="完整自定义 JQL，优先于 --project 等过滤条件")
    parser.add_argument(
        "--issue-key", dest="issue_keys", action="append", default=[],
        help="仅处理指定问题单，可重复传参；传了此项则不做 JQL 搜索",
    )
    parser.add_argument("--reporter", dest="reporter", default=None, help="限定 reporter（JQL 过滤）")
    parser.add_argument("--status", dest="status", default=None, help='限定状态，如 "Open"（JQL 过滤）')
    parser.add_argument(
        "--exclude-status", dest="exclude_status", action="append", default=[],
        help='排除状态，如 --exclude-status Closed（Tinno Jira 的 Closed 编辑屏通常不含 labels），可重复传参',
    )
    parser.add_argument(
        "--specialty-token", dest="specialty_token", default=None,
        help="限定 Summary 含指定专项 token，如 MTBF（JQL 过滤）",
    )
    parser.add_argument(
        "--include-non-auto", action="store_true",
        help="处理非 [自动化] 标题的单（默认只处理 Summary 含 [自动化] 的单）",
    )
    parser.add_argument(
        "--no-cleanup-legacy", action="store_true",
        help="labels 恰好等于历史静态默认值时不替换，仅追加专项与固定标签",
    )
    parser.add_argument("--max-issues", dest="max_issues", type=int, default=500, help="JQL 搜索最大条数")
    parser.add_argument("--wait-between-issues", dest="wait_between_issues", type=float, default=0.3, help="每次更新之间的等待秒数")
    parser.add_argument("--dry-run", action="store_true", help="只读取并打印标签计划，不真实提交")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--jira-p12-path", dest="jira_p12_path", default=os.getenv("JIRA_P12_PATH"), help="P12 证书路径")
    parser.add_argument("--jira-p12-password", dest="jira_p12_password", default=os.getenv("JIRA_P12_PASSWORD"), help="P12 证书密码")
    parser.add_argument("--jira-cookie-string", dest="jira_cookie_string", default=os.getenv("JIRA_COOKIE_STRING"), help="完整 Cookie 字符串")
    parser.add_argument("--jira-cookie-jsessionid", dest="jira_cookie_jsessionid", default=os.getenv("JIRA_COOKIE_JSESSIONID"), help="JSESSIONID")
    parser.add_argument("--jira-cookie-xsrf-token", dest="jira_cookie_xsrf_token", default=os.getenv("JIRA_COOKIE_XSRF_TOKEN"), help="atlassian.xsrf.token")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    return parser.parse_args()


def _normalize_label_list(values: Optional[List[Any]]) -> List[str]:
    normalized: List[str] = []
    seen: set = set()
    for value in values or []:
        token = str(value or "").strip()
        if not token:
            continue
        key = token.casefold()
        if key in seen:
            continue
        seen.add(key)
        normalized.append(token)
    return normalized


def _as_list(value: Any, fallback: List[str]) -> List[str]:
    if value is None:
        return list(fallback)
    if isinstance(value, str):
        return [value]
    if isinstance(value, (list, tuple, set)):
        return [str(item) for item in value]
    return list(fallback)


def build_search_jql(args: argparse.Namespace, defaults: Dict[str, Any]) -> str:
    """组装检索 JQL；复用回归导出的 JQL 构造器，保证 Summary 关键词的转义一致。"""
    if str(args.jql or "").strip():
        return str(args.jql).strip()
    project_key = str(args.project or defaults.get("project_key", "VCAME")).strip()
    extra_clauses: List[str] = []
    if str(args.reporter or "").strip():
        extra_clauses.append(f"reporter in ({str(args.reporter).strip()})")
    if str(args.status or "").strip():
        extra_clauses.append(f'status = "{str(args.status).strip()}"')
    for excluded in list(getattr(args, "exclude_status", None) or []):
        name = str(excluded or "").strip().replace('"', "")
        if name:
            extra_clauses.append(f'status != "{name}"')
    base_jql = build_regression_base_jql(project_key, " AND ".join(extra_clauses))

    keywords: List[str] = []
    if not args.include_non_auto:
        keywords.append("[自动化]")
    specialty_token = str(args.specialty_token or "").strip().replace('"', "").replace("\\", "")
    if specialty_token:
        keywords.append(f"[{specialty_token}]")

    # 关键词之间需要 AND 语义（build_regression_export_jql 单批内是 OR），逐个叠加。
    for keyword in keywords:
        base_jql = build_regression_export_jql(base_jql, [keyword])
    return base_jql


def plan_issue_labels(
    issue_key: str,
    summary: Any,
    current_labels: Optional[List[Any]],
    defaults: Dict[str, Any],
    *,
    cleanup_legacy: bool = True,
) -> Dict[str, Any]:
    """计算单个问题单的目标 labels。

    返回 plan: action ∈ NO_CHANGE / ADD_LABELS / FIX_LEGACY
    """
    fixed_labels = _normalize_label_list(_as_list(defaults.get("fixed_labels"), list(DEFAULT_FIXED_LABELS)))
    legacy_labels = _normalize_label_list(_as_list(defaults.get("labels"), ["MonkeyAEE"]))
    normalized_current = _normalize_label_list(current_labels)
    current_set = {token.casefold() for token in normalized_current}
    specialty = normalize_specialty_token_from_summary(summary, defaults)

    base = list(normalized_current)
    removed: List[str] = []
    action = "ADD_LABELS"
    legacy_set = {token.casefold() for token in legacy_labels}
    specialty_in_current = specialty.casefold() in current_set if specialty else False
    if (
        cleanup_legacy
        and specialty
        and not specialty_in_current
        and legacy_set
        and current_set == legacy_set
    ):
        removed = list(normalized_current)
        base = []
        action = "FIX_LEGACY"

    target = _normalize_label_list(base)
    added: List[str] = []
    candidates: List[str] = []
    if specialty:
        candidates.append(specialty)
    candidates.extend(fixed_labels)
    for token in candidates:
        if token.casefold() not in {item.casefold() for item in target}:
            target.append(token)
            added.append(token)

    if {token.casefold() for token in target} == current_set:
        return {
            "issue_key": issue_key,
            "summary": str(summary or ""),
            "specialty": specialty,
            "old_labels": normalized_current,
            "new_labels": normalized_current,
            "added": [],
            "removed": [],
            "action": "NO_CHANGE",
        }

    return {
        "issue_key": issue_key,
        "summary": str(summary or ""),
        "specialty": specialty,
        "old_labels": normalized_current,
        "new_labels": target,
        "added": added,
        "removed": removed,
        "action": action,
    }


def collect_issue_records(jira_client: Any, args: argparse.Namespace, defaults: Dict[str, Any]) -> List[Dict[str, Any]]:
    records: List[Dict[str, Any]] = []
    raw_issue_keys = [str(item or "").strip() for item in (args.issue_keys or []) if str(item or "").strip()]
    if raw_issue_keys:
        for issue_key in raw_issue_keys:
            payload = jira_client.get_issue(issue_key) or {}
            fields = payload.get("fields", {}) if isinstance(payload, dict) else {}
            if not isinstance(fields, dict):
                fields = {}
            records.append(
                {
                    "issue_key": str(payload.get("key") or issue_key),
                    "summary": str(fields.get("summary") or ""),
                    "labels": list(fields.get("labels") or []),
                }
            )
        return records

    jql = build_search_jql(args, defaults)
    logger.info("标签补打 JQL: %s", jql)
    max_issues = int(args.max_issues)
    issues = jira_client.search_issues(jql, maxResults=max_issues, fields="summary,labels")
    if len(issues) >= max_issues:
        logger.warning(
            "返回条数达到 --max-issues 上限（%d），可能存在截断；请加大上限或缩小 JQL 范围后重跑",
            max_issues,
        )
    for issue in issues:
        fields = getattr(issue, "fields", None)
        if fields is None:
            continue
        records.append(
            {
                "issue_key": str(getattr(issue, "key", "") or ""),
                "summary": str(getattr(fields, "summary", "") or ""),
                "labels": list(getattr(fields, "labels", []) or []),
            }
        )
    return [record for record in records if record.get("issue_key")]


def execute_label_patch(
    jira_client: Any,
    plans: List[Dict[str, Any]],
    *,
    dry_run: bool,
    wait_seconds: float = 0.3,
    sleep_fn: Any = time.sleep,
) -> List[Dict[str, Any]]:
    results: List[Dict[str, Any]] = []
    changed = 0
    for plan in plans:
        row = dict(plan)
        if row["action"] == "NO_CHANGE":
            row["status"] = "NO_CHANGE"
            results.append(row)
            continue
        if dry_run:
            row["status"] = "DRY_RUN"
            results.append(row)
            continue
        try:
            update_issue_fields(jira_client, row["issue_key"], {"labels": row["new_labels"]})
            row["status"] = "UPDATED"
            changed += 1
        except Exception as exc:
            row["status"] = "FAILED"
            row["error"] = str(exc)
            logger.error("%s labels 更新失败: %s", row["issue_key"], exc)
        if changed and wait_seconds > 0 and sleep_fn is not None:
            sleep_fn(wait_seconds)
        results.append(row)
    return results


def write_audit(results: List[Dict[str, Any]], stats: Dict[str, Any]) -> Path:
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    target = RESULT_DIR / f"retro_patch_tinno_labels_audit_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    payload = {"stats": stats, "items": results}
    with target.open("w", encoding="utf-8") as fp:
        json.dump(payload, fp, ensure_ascii=False, indent=2)
    return target


def summarize(results: List[Dict[str, Any]]) -> Dict[str, Any]:
    stats = {"total": len(results)}
    for key in ("NO_CHANGE", "DRY_RUN", "UPDATED", "FAILED"):
        stats[key] = 0
    for row in results:
        status = str(row.get("status") or "")
        if status in stats:
            stats[status] += 1
    return stats


def main() -> int:
    load_local_env()
    setup_logging()
    args = parse_args()
    defaults = load_defaults(args.config_file)

    jira_server = args.jira_server or defaults["jira_server"]
    jira = connect_to_jira(
        server=jira_server,
        username=args.jira_username,
        password=args.jira_password,
        p12_file_path=args.jira_p12_path or "",
        p12_password=args.jira_p12_password or "",
        verify=bool(defaults.get("verify", False)),
        cookie_string=args.jira_cookie_string,
        cookie_jsessionid=args.jira_cookie_jsessionid,
        cookie_xsrf_token=args.jira_cookie_xsrf_token,
    )
    logger.info("当前认证来源: %s", getattr(jira, "auth_mode", "unknown"))

    try:
        records = collect_issue_records(jira, args, defaults)
        if not records:
            logger.warning("未找到符合条件的问题单")
            return 0
        logger.info("共读取 %d 个问题单", len(records))

        cleanup_legacy = not bool(args.no_cleanup_legacy)
        plans = [
            plan_issue_labels(
                record["issue_key"],
                record["summary"],
                record["labels"],
                defaults,
                cleanup_legacy=cleanup_legacy,
            )
            for record in records
        ]
        for plan in plans:
            if plan["action"] == "NO_CHANGE":
                logger.info("%s: labels 已满足要求，跳过 %s", plan["issue_key"], plan["old_labels"])
            else:
                logger.info(
                    "%s: [%s] %s -> %s (专项=%s 新增=%s 移除=%s)",
                    plan["issue_key"],
                    plan["action"],
                    plan["old_labels"],
                    plan["new_labels"],
                    plan["specialty"] or "未识别",
                    plan["added"],
                    plan["removed"],
                )

        results = execute_label_patch(
            jira,
            plans,
            dry_run=bool(args.dry_run),
            wait_seconds=float(args.wait_between_issues),
        )
        stats = summarize(results)
        audit_path = write_audit(results, stats)
        logger.info(
            "处理完成: 总数=%d 无变化=%d dry-run=%d 已更新=%d 失败=%d 审计: %s",
            stats["total"],
            stats["NO_CHANGE"],
            stats["DRY_RUN"],
            stats["UPDATED"],
            stats["FAILED"],
            audit_path,
        )
        return 0 if stats["FAILED"] == 0 else 1
    finally:
        jira.close()


if __name__ == "__main__":
    raise SystemExit(main())
