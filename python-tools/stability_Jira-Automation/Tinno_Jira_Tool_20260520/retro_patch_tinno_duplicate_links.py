#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
retro_patch_tinno_duplicate_links.py
------------------------------------

给「resolution=Duplicate/重复*，但 issuelinks / customfield_14207 都没有主单」的历史单，
从评论里按显式主单句式提取主单号，预览或补写 Duplicate 链接。

规律（自动写入仅认这些）：
- 跟随主单KEY / 跟随主单[KEY] / 跟随主单 https://…/browse/KEY
- 主单是 https://…/browse/KEY
- 跟随 https://…/browse/KEY
- 重复问题：KEY / 重复提交 … browse/KEY
- 同KEY / 同 KEY单子（如「同PFDFAA-1776单子」）
- 同步跟踪KEY …进展

不把分析评论里「与 KEY 同类」的普通提及当主单。

默认只 dry-run；加 --apply 才真实创建链接。

用法：

    # 预览 filter 20261 范围内的孤儿重复单
    python ".\\retro_patch_tinno_duplicate_links.py" --filter-id 20261

    # 真实写入（仅单一候选）
    python ".\\retro_patch_tinno_duplicate_links.py" --filter-id 20261 --apply

    # 指定单
    python ".\\retro_patch_tinno_duplicate_links.py" --issue-key PFDFAA-1759 --issue-key PAANX-357
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import re
import sys
import time
from collections import Counter
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, Iterable, List, Optional, Sequence, Tuple

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from create_tinno_jira_batch_from_excel import (  # noqa: E402
    DEFAULT_CONFIG_FILE,
    DUPLICATE_CUSTOM_FIELD_KEYS,
    DUPLICATE_LINK_KEYWORDS,
    load_defaults,
    load_local_env,
    setup_logging,
)
from tinno_batch_jira_common import connect_to_jira  # noqa: E402

logger = logging.getLogger(__name__)

RESULT_DIR = CURRENT_DIR / "result"
# 不用 \b：中文后紧跟 KEY 时（如「跟随主单PFDFAA-1736」）Unicode \w 会把中文当单词字符，导致 \b 失效。
ISSUE_KEY_RE = re.compile(r"(?<![A-Za-z0-9_])([A-Z][A-Z0-9]+-\d+)(?![A-Za-z0-9_])", re.IGNORECASE)
DUP_RESOLUTION_RE = re.compile(r"duplicate|重复", re.IGNORECASE)
DEFAULT_PROJECT_ALLOWLIST = ("PFDFAA", "PAANX", "VFFCA", "VFFBA", "VCAME")
# 评论里显式声明主单的句式（优先于普通提到的单号）。
EXPLICIT_MAIN_PATTERNS = (
    re.compile(
        r"跟随主单\s*(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
    re.compile(
        r"主单是\s*(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
    re.compile(
        r"主单[为：:\s]+(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
    re.compile(
        r"跟随\s*(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
    re.compile(
        r"重复(?:问题|提交|我问题)?\s*[：:]\s*(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
    re.compile(
        r"重复(?:问题|提交|我问题)?[^\n]{0,20}(?:https?://[^\s]*/browse/)(?P<key>[A-Z][A-Z0-9]+-\d+)",
        re.IGNORECASE,
    ),
    # 「同步跟踪」须在「同 KEY」之前注册，避免被更短的「同」抢先（二者实际不冲突，顺序仅便于阅读）。
    re.compile(
        r"同步跟踪\s*(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
    # 「同PFDFAA-920」「同 PFDFAA-1776单子」；「同一类/同样」后非 KEY，不会误命中。
    re.compile(
        r"(?<![不A-Za-z0-9_])同\s*(?:https?://[^\s]*/browse/)?\[?(?P<key>[A-Z][A-Z0-9]+-\d+)\]?",
        re.IGNORECASE,
    ),
)
BOT_COMMENT_MARKERS = ("*Reporter:*", "*Version:*", "*Path:*", "*Duplicate Number:*")


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="从评论补写 Tinno Duplicate 主单链接")
    parser.add_argument("--filter-id", dest="filter_id", default=None, help="Jira filter id，如 20261")
    parser.add_argument("--jql", dest="jql", default=None, help="自定义 JQL；优先于 --filter-id")
    parser.add_argument(
        "--issue-key",
        dest="issue_keys",
        action="append",
        default=[],
        help="仅处理指定问题单，可重复传参",
    )
    parser.add_argument(
        "--project-allowlist",
        dest="project_allowlist",
        default=",".join(DEFAULT_PROJECT_ALLOWLIST),
        help="评论中识别为候选主单的项目前缀，逗号分隔",
    )
    parser.add_argument(
        "--pick-most-mentioned",
        action="store_true",
        help="多候选时选评论出现次数最多的单号作为主单（默认多候选不自动写）",
    )
    parser.add_argument(
        "--main-map",
        dest="main_maps",
        action="append",
        default=[],
        help="强制指定 重复单=主单，如 PFDFAA-1779=PFDFAA-1736；可重复传参，优先级高于评论推断",
    )
    parser.add_argument(
        "--duplicate-link-type",
        dest="duplicate_link_type",
        default="",
        help='强制指定链接类型名（默认自动匹配名称含 duplicate/重复 的类型）',
    )
    parser.add_argument(
        "--also-custom-field",
        action="store_true",
        help="同时尝试写入 customfield_14207（若存在且可写）",
    )
    parser.add_argument("--max-issues", dest="max_issues", type=int, default=500, help="搜索最大条数")
    parser.add_argument("--wait-between-issues", dest="wait_between_issues", type=float, default=0.3)
    parser.add_argument(
        "--apply",
        action="store_true",
        help="真实创建 Duplicate 链接；默认只预览",
    )
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"))
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"))
    parser.add_argument("--jira-server", dest="jira_server", default=None)
    parser.add_argument("--jira-p12-path", dest="jira_p12_path", default=os.getenv("JIRA_P12_PATH"))
    parser.add_argument("--jira-p12-password", dest="jira_p12_password", default=os.getenv("JIRA_P12_PASSWORD"))
    parser.add_argument("--jira-cookie-string", dest="jira_cookie_string", default=os.getenv("JIRA_COOKIE_STRING"))
    parser.add_argument(
        "--jira-cookie-jsessionid",
        dest="jira_cookie_jsessionid",
        default=os.getenv("JIRA_COOKIE_JSESSIONID"),
    )
    parser.add_argument(
        "--jira-cookie-xsrf-token",
        dest="jira_cookie_xsrf_token",
        default=os.getenv("JIRA_COOKIE_XSRF_TOKEN"),
    )
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE))
    return parser.parse_args()


def extract_issue_keys_from_text(text: Any, project_allowlist: Sequence[str] | None = None) -> List[str]:
    allow = {str(item).strip().upper() for item in (project_allowlist or []) if str(item).strip()}
    found: List[str] = []
    seen: set[str] = set()
    for match in ISSUE_KEY_RE.findall(str(text or "")):
        key = str(match).strip().upper()
        if not key or key in seen:
            continue
        project = key.split("-", 1)[0]
        if allow and project not in allow:
            continue
        seen.add(key)
        found.append(key)
    return found


def _is_bot_template_comment(body: Any) -> bool:
    text = str(body or "")
    return sum(1 for marker in BOT_COMMENT_MARKERS if marker in text) >= 2


def extract_explicit_main_keys_from_text(
    text: Any,
    *,
    self_key: str,
    project_allowlist: Sequence[str] | None = None,
) -> List[str]:
    allow = {str(item).strip().upper() for item in (project_allowlist or []) if str(item).strip()}
    self_norm = str(self_key or "").strip().upper()
    found: List[str] = []
    seen: set[str] = set()
    body = str(text or "")
    for pattern in EXPLICIT_MAIN_PATTERNS:
        for match in pattern.finditer(body):
            key = str(match.group("key") or "").strip().upper()
            if not key or key == self_norm or key in seen:
                continue
            project = key.split("-", 1)[0]
            if allow and project not in allow:
                continue
            seen.add(key)
            found.append(key)
    return found


def extract_issue_keys_from_comments(
    comments: Iterable[Any],
    *,
    self_key: str,
    project_allowlist: Sequence[str] | None = None,
) -> Tuple[List[str], Counter, List[str]]:
    """返回 (普通提到的单号, 计数, 显式主单句式抽出的单号)。"""
    self_norm = str(self_key or "").strip().upper()
    counts: Counter = Counter()
    explicit: List[str] = []
    explicit_seen: set[str] = set()
    for comment in comments or []:
        if isinstance(comment, dict):
            body = comment.get("body")
        else:
            body = getattr(comment, "body", comment)
        if _is_bot_template_comment(body):
            continue
        for key in extract_explicit_main_keys_from_text(
            body, self_key=self_norm, project_allowlist=project_allowlist
        ):
            if key not in explicit_seen:
                explicit_seen.add(key)
                explicit.append(key)
        for key in extract_issue_keys_from_text(body, project_allowlist):
            if key == self_norm:
                continue
            counts[key] += 1
    ordered = [key for key, _ in counts.most_common()]
    return ordered, counts, explicit


def parse_main_maps(raw_maps: Sequence[Any] | None) -> Dict[str, str]:
    mapping: Dict[str, str] = {}
    for raw in raw_maps or []:
        text = str(raw or "").strip()
        if not text or "=" not in text:
            raise ValueError(f"--main-map 格式应为 DUP=MAIN，收到: {text}")
        left, right = text.split("=", 1)
        dup = left.strip().upper()
        main = right.strip().upper()
        if not dup or not main:
            raise ValueError(f"--main-map 格式应为 DUP=MAIN，收到: {text}")
        mapping[dup] = main
    return mapping


def choose_main_candidate(
    candidates: Sequence[str],
    counts: Counter,
    *,
    explicit_mains: Sequence[str] | None = None,
    pick_most_mentioned: bool = False,
    forced_main: str = "",
) -> Dict[str, Any]:
    forced = str(forced_main or "").strip().upper()
    if forced:
        return {
            "action": "AUTO_LINK",
            "main_key": forced,
            "candidates": list(
                dict.fromkeys(
                    [forced]
                    + [str(item).strip().upper() for item in (explicit_mains or []) if str(item).strip()]
                    + [str(item).strip().upper() for item in candidates if str(item).strip()]
                )
            ),
            "counts": {key: int(counts.get(key) or 0) for key in ([forced] + list(candidates))},
            "reason": f"手动指定 --main-map -> {forced}",
        }

    explicit = list(
        dict.fromkeys(str(item).strip().upper() for item in (explicit_mains or []) if str(item).strip())
    )
    if len(explicit) == 1:
        return {
            "action": "AUTO_LINK",
            "main_key": explicit[0],
            "candidates": explicit,
            "counts": {key: int(counts.get(key) or 0) for key in explicit},
            "reason": "评论显式主单句式（跟随主单/主单是/同KEY/同步跟踪/重复问题等）",
        }
    if len(explicit) > 1:
        return {
            "action": "NEED_REVIEW",
            "main_key": "",
            "candidates": explicit,
            "counts": {key: int(counts.get(key) or 0) for key in explicit},
            "reason": "显式主单句式命中多个单号，需人工确认",
        }

    # 没有显式主单句式时：普通提到的单号不可靠（常是同类对比），默认不自动写。
    unique = [str(item).strip().upper() for item in candidates if str(item).strip()]
    unique = list(dict.fromkeys(unique))
    if not unique:
        return {
            "action": "NO_CANDIDATE",
            "main_key": "",
            "candidates": [],
            "counts": {},
            "reason": "评论无显式主单句式，也未提到其它单号",
        }
    if pick_most_mentioned and len(unique) >= 1:
        ranked = sorted(unique, key=lambda key: (-int(counts.get(key) or 0), key))
        top = ranked[0]
        top_count = int(counts.get(top) or 0)
        tied = [key for key in ranked if int(counts.get(key) or 0) == top_count]
        if len(tied) == 1:
            return {
                "action": "AUTO_LINK",
                "main_key": top,
                "candidates": unique,
                "counts": {key: int(counts.get(key) or 0) for key in unique},
                "reason": "无显式句式，回退为出现次数最多（--pick-most-mentioned）",
            }
    return {
        "action": "NEED_REVIEW",
        "main_key": "",
        "candidates": unique,
        "counts": {key: int(counts.get(key) or 0) for key in unique},
        "reason": "仅有普通提及、无显式主单句式，默认不自动写",
    }


def _is_duplicate_link_type_name(name: Any) -> bool:
    text = str(name or "").strip().lower()
    return bool(text) and any(keyword in text for keyword in DUPLICATE_LINK_KEYWORDS)


def has_duplicate_link_or_custom_field(fields: Dict[str, Any]) -> Tuple[bool, List[str]]:
    linked: List[str] = []
    for link in fields.get("issuelinks") or []:
        if not isinstance(link, dict):
            continue
        link_type = link.get("type") or {}
        type_blob = " ".join(
            str(link_type.get(item) or "") for item in ("name", "inward", "outward")
        ).lower()
        if not any(keyword in type_blob for keyword in DUPLICATE_LINK_KEYWORDS):
            continue
        for side in ("outwardIssue", "inwardIssue"):
            other = link.get(side) or {}
            key = str((other or {}).get("key") or "").strip().upper()
            if key and key not in linked:
                linked.append(key)
    for field_key in DUPLICATE_CUSTOM_FIELD_KEYS:
        value = fields.get(field_key)
        items = value if isinstance(value, list) else ([value] if value else [])
        for item in items:
            if isinstance(item, dict):
                key = str(item.get("key") or "").strip().upper()
            else:
                key = str(item or "").strip().upper()
            if key and key not in linked:
                linked.append(key)
    return bool(linked), linked


def resolve_duplicate_link_type_name(jira_client: Any, forced_name: str = "") -> str:
    forced = str(forced_name or "").strip()
    if forced:
        return forced
    types = jira_client.get_issue_link_types() or []
    for item in types:
        name = str((item or {}).get("name") or "").strip()
        if _is_duplicate_link_type_name(name):
            return name
    raise RuntimeError("未找到名称含 duplicate/重复 的 issueLinkType，请用 --duplicate-link-type 指定")


def _search_all_issues(jira_client: Any, jql: str, *, fields: str, max_issues: int) -> List[Dict[str, Any]]:
    issues: List[Dict[str, Any]] = []
    start = 0
    page_size = 50
    while start < max_issues:
        batch_size = min(page_size, max_issues - start)
        payload = jira_client._client._make_request(
            "GET",
            "/rest/api/2/search",
            params={"jql": jql, "startAt": start, "maxResults": batch_size, "fields": fields},
        )
        batch = payload.get("issues") or []
        total = int(payload.get("total") or 0)
        issues.extend(item for item in batch if isinstance(item, dict))
        start += len(batch)
        if start >= total or not batch:
            break
    return issues


def resolve_scope_jql(args: argparse.Namespace, jira_client: Any) -> str:
    if args.jql:
        return str(args.jql).strip()
    if args.filter_id:
        filt = jira_client._client._make_request("GET", f"/rest/api/2/filter/{args.filter_id}")
        jql = str((filt or {}).get("jql") or "").strip()
        if not jql:
            raise RuntimeError(f"filter {args.filter_id} 无 JQL")
        logger.info("使用 filter %s: %s", args.filter_id, (filt or {}).get("name"))
        return jql
    return (
        'project in (PFDFAA, PAANX) AND resolution in (Duplicate, "重复缺陷") '
        "ORDER BY updated DESC"
    )


def collect_orphan_duplicate_records(
    jira_client: Any,
    args: argparse.Namespace,
) -> List[Dict[str, Any]]:
    fields = "summary,status,resolution,issuelinks,comment," + ",".join(DUPLICATE_CUSTOM_FIELD_KEYS)
    records: List[Dict[str, Any]] = []
    raw_issue_keys = [str(item or "").strip().upper() for item in (args.issue_keys or []) if str(item or "").strip()]
    raw_payloads: List[Dict[str, Any]] = []
    if raw_issue_keys:
        for issue_key in raw_issue_keys:
            payload = jira_client._client._make_request(
                "GET",
                f"/rest/api/2/issue/{issue_key}",
                params={"fields": fields},
            ) or {}
            if isinstance(payload, dict) and payload.get("key"):
                raw_payloads.append(payload)
            else:
                logger.warning("无法读取问题单: %s", issue_key)
    else:
        jql = resolve_scope_jql(args, jira_client)
        logger.info("重复链接补写搜索 JQL: %s", jql)
        raw_payloads = _search_all_issues(
            jira_client,
            jql,
            fields=fields,
            max_issues=int(args.max_issues),
        )

    allowlist = [item.strip() for item in str(args.project_allowlist or "").split(",") if item.strip()]
    forced_map = parse_main_maps(getattr(args, "main_maps", []) or [])
    for payload in raw_payloads:
        issue_key = str(payload.get("key") or "").strip().upper()
        field_map = payload.get("fields") or {}
        if not isinstance(field_map, dict):
            field_map = {}
        resolution = str(((field_map.get("resolution") or {}) or {}).get("name") or "")
        if not DUP_RESOLUTION_RE.search(resolution):
            logger.info("跳过 %s: resolution=%s 非重复", issue_key, resolution or "(空)")
            continue
        has_main, linked = has_duplicate_link_or_custom_field(field_map)
        if has_main:
            logger.info("跳过 %s: 已有重复主单字段 %s", issue_key, linked)
            continue
        comments = ((field_map.get("comment") or {}) or {}).get("comments") or []
        candidates, counts, explicit_mains = extract_issue_keys_from_comments(
            comments,
            self_key=issue_key,
            project_allowlist=allowlist,
        )
        decision = choose_main_candidate(
            candidates,
            counts,
            explicit_mains=explicit_mains,
            pick_most_mentioned=bool(args.pick_most_mentioned),
            forced_main=forced_map.get(issue_key, ""),
        )
        records.append(
            {
                "issue_key": issue_key,
                "summary": str(field_map.get("summary") or ""),
                "status": str(((field_map.get("status") or {}) or {}).get("name") or ""),
                "resolution": resolution,
                "existing_linked_keys": linked,
                "explicit_mains": explicit_mains,
                "candidates": decision["candidates"],
                "candidate_counts": decision["counts"],
                "main_key": decision["main_key"],
                "action": decision["action"],
                "reason": decision["reason"],
            }
        )
    return records


def execute_duplicate_link_patch(
    jira_client: Any,
    plans: List[Dict[str, Any]],
    *,
    apply: bool,
    link_type_name: str,
    also_custom_field: bool,
    wait_seconds: float = 0.3,
    sleep_fn: Any = time.sleep,
) -> List[Dict[str, Any]]:
    results: List[Dict[str, Any]] = []
    changed = 0
    for plan in plans:
        row = dict(plan)
        action = str(row.get("action") or "")
        if action != "AUTO_LINK":
            row["status"] = action
            results.append(row)
            continue
        if not apply:
            row["status"] = "DRY_RUN"
            results.append(row)
            continue
        try:
            # outward=重复单 duplicates inward=主单
            jira_client.create_issue_link(
                link_type_name=link_type_name,
                inward_issue_key=str(row["main_key"]),
                outward_issue_key=str(row["issue_key"]),
            )
            if also_custom_field:
                try:
                    jira_client.update_issue(
                        str(row["issue_key"]),
                        {DUPLICATE_CUSTOM_FIELD_KEYS[0]: [{"key": str(row["main_key"])}]},
                    )
                    row["custom_field_updated"] = True
                except Exception as exc:
                    row["custom_field_updated"] = False
                    row["custom_field_error"] = str(exc)
            row["status"] = "LINKED"
            row["link_type"] = link_type_name
            changed += 1
        except Exception as exc:
            row["status"] = "FAILED"
            row["error"] = str(exc)
            logger.error("%s 补写 Duplicate 链接失败: %s", row.get("issue_key"), exc)
        if changed and wait_seconds > 0 and sleep_fn is not None:
            sleep_fn(wait_seconds)
        results.append(row)
    return results


def write_audit(results: List[Dict[str, Any]], stats: Dict[str, Any]) -> Path:
    RESULT_DIR.mkdir(parents=True, exist_ok=True)
    target = RESULT_DIR / f"retro_patch_tinno_duplicate_links_audit_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    with target.open("w", encoding="utf-8") as fp:
        json.dump({"stats": stats, "items": results}, fp, ensure_ascii=False, indent=2)
    return target


def summarize(results: List[Dict[str, Any]]) -> Dict[str, Any]:
    stats: Dict[str, Any] = {"total": len(results)}
    for row in results:
        key = str(row.get("status") or row.get("action") or "UNKNOWN")
        stats[key] = int(stats.get(key) or 0) + 1
    return stats


def main() -> int:
    load_local_env()
    setup_logging()
    args = parse_args()
    defaults = load_defaults(args.config_file)

    if not args.jira_cookie_jsessionid and not args.jira_cookie_xsrf_token and (
        not args.jira_username or not args.jira_password
    ):
        logger.error("需要提供 Cookie 或 Jira 用户名密码")
        return 1
    if not args.jira_p12_path or not args.jira_p12_password:
        logger.error("需要提供 Tinno P12 证书路径和密码")
        return 1

    jira = connect_to_jira(
        server=args.jira_server or defaults["jira_server"],
        username=args.jira_username,
        password=args.jira_password,
        p12_file_path=args.jira_p12_path,
        p12_password=args.jira_p12_password,
        verify=bool(defaults.get("verify", False)),
        cookie_string=args.jira_cookie_string,
        cookie_jsessionid=args.jira_cookie_jsessionid,
        cookie_xsrf_token=args.jira_cookie_xsrf_token,
    )
    try:
        plans = collect_orphan_duplicate_records(jira, args)
        link_type_name = ""
        if any(item.get("action") == "AUTO_LINK" for item in plans):
            link_type_name = resolve_duplicate_link_type_name(jira, args.duplicate_link_type)
            logger.info("将使用 issueLinkType=%s", link_type_name)
        results = execute_duplicate_link_patch(
            jira,
            plans,
            apply=bool(args.apply),
            link_type_name=link_type_name or str(args.duplicate_link_type or "Duplicate"),
            also_custom_field=bool(args.also_custom_field),
            wait_seconds=float(args.wait_between_issues),
        )
        stats = summarize(results)
        audit_path = write_audit(results, stats)
        logger.info("处理完成: %s", stats)
        logger.info("审计已写入: %s", audit_path)
        for row in results:
            logger.info(
                "%s -> %s main=%s candidates=%s reason=%s",
                row.get("issue_key"),
                row.get("status"),
                row.get("main_key") or "-",
                row.get("candidates") or [],
                row.get("reason"),
            )
        failed = int(stats.get("FAILED") or 0)
        return 1 if failed else 0
    finally:
        jira.close()


if __name__ == "__main__":
    raise SystemExit(main())
