#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Tinno 新项目初始化。

运行时只需要客户系统项目（版本前缀）和 Jira 项目关键字。
模块与经办人从 Jira 项目组件的实际经办人读取，并写入本地配置。
"""

from __future__ import annotations

import argparse
import json
import logging
import os
import re
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional

CURRENT_DIR = Path(__file__).resolve().parent
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

from jira_issue_template import SUMMARY_PRODUCT_MAPPING_FILE, load_summary_product_mapping
from tinno_batch_jira_common import connect_to_jira
from tinno_upload_template_common import load_defaults

logger = logging.getLogger(__name__)

CONFIG_DIR = CURRENT_DIR / "config"
LOG_DIR = CURRENT_DIR / "log"
DEFAULT_CONFIG_FILE = CONFIG_DIR / "tinno_jira_defaults.json"
DEFAULT_AFFECT_PROJECT_MAPPING = CONFIG_DIR / "affect_project_mapping.json"
DEFAULT_MODULE_ASSIGNEE_MAPPING = CONFIG_DIR / "module_assignee_mapping.json"
DEFAULT_LOCAL_ENV_FILE = CURRENT_DIR / ".env.local"
JIRA_KEY_PATTERN = re.compile(r"^[A-Z][A-Z0-9]+$")


def load_local_env(env_file: str | Path = DEFAULT_LOCAL_ENV_FILE, override: bool = False) -> None:
    path = Path(env_file)
    if not path.exists():
        return
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("export "):
            line = line[7:].strip()
        key, separator, value = line.partition("=")
        if not separator:
            continue
        env_key = key.strip()
        env_value = value.strip()
        if len(env_value) >= 2 and env_value[0] == env_value[-1] and env_value[0] in {"'", '"'}:
            env_value = env_value[1:-1]
        if override or not os.getenv(env_key):
            os.environ[env_key] = env_value


def setup_logging() -> None:
    LOG_DIR.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
        handlers=[
            logging.StreamHandler(),
            logging.FileHandler(LOG_DIR / "init_tinno_project.log", encoding="utf-8"),
        ],
    )


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="初始化 Tinno Jira 新项目：登记版本前缀，并从 Jira 拉取模块经办人")
    parser.add_argument("--customer-project", dest="customer_project", default=None, help="客户系统项目，即 Monkey 版本前缀，多个用逗号分隔")
    parser.add_argument("--jira-key", dest="jira_key", default=None, help="Jira 项目关键字，例如 PFDFAA")
    parser.add_argument("--summary-product", dest="summary_product", default=None, help="标题中的产品名；省略时按客户项目和 Jira Key 推断")
    parser.add_argument("--force", action="store_true", help="版本前缀已指向其他 Jira 项目时覆盖")
    parser.add_argument("--workspace", dest="workspace", default=None, help="试运行工作区目录。配置只写入该目录，不修改 config/ 下的正式文件")
    parser.add_argument("--config-file", dest="config_file", default=str(DEFAULT_CONFIG_FILE), help="默认配置路径")
    parser.add_argument("--jira-username", dest="jira_username", default=os.getenv("JIRA_USERNAME"), help="Jira 用户名")
    parser.add_argument("--jira-password", dest="jira_password", default=os.getenv("JIRA_PASSWORD"), help="Jira 密码")
    parser.add_argument("--jira-server", dest="jira_server", default=None, help="Jira 服务地址")
    parser.add_argument("--jira-p12-path", dest="jira_p12_path", default=os.getenv("JIRA_P12_PATH"), help="P12 证书路径")
    parser.add_argument("--jira-p12-password", dest="jira_p12_password", default=os.getenv("JIRA_P12_PASSWORD"), help="P12 证书密码")
    parser.add_argument("--jira-cookie-string", dest="jira_cookie_string", default=os.getenv("JIRA_COOKIE_STRING"), help="完整 Cookie 字符串")
    parser.add_argument("--jira-cookie-jsessionid", dest="jira_cookie_jsessionid", default=os.getenv("JIRA_COOKIE_JSESSIONID"), help="JSESSIONID")
    parser.add_argument("--jira-cookie-xsrf-token", dest="jira_cookie_xsrf_token", default=os.getenv("JIRA_COOKIE_XSRF_TOKEN"), help="atlassian.xsrf.token")
    return parser.parse_args()


def parse_customer_projects(text: str) -> List[str]:
    projects: List[str] = []
    for part in re.split(r"[,，;；\s]+", str(text or "").strip()):
        token = str(part or "").strip().upper()
        if token and token not in projects:
            projects.append(token)
    return projects


def normalize_jira_key(text: str) -> str:
    return str(text or "").strip().upper()


def infer_summary_product(customer_projects: List[str], jira_key: str) -> str:
    for item in customer_projects:
        if re.fullmatch(r"V\d+[A-Z0-9]*", item):
            return item
    if len(customer_projects) == 1 and not re.search(r"-[A-Z]+\d+\Z", customer_projects[0]):
        return customer_projects[0]
    return jira_key


def prompt_required(label: str, current: Optional[str]) -> str:
    value = str(current or "").strip()
    if value:
        return value
    while True:
        entered = input(f"{label}: ").strip()
        if entered:
            return entered
        print("不能为空，请重新输入。")


def collect_project_inputs(args: argparse.Namespace) -> tuple[List[str], str, str]:
    customer_text = prompt_required(
        "客户系统项目（版本前缀，多个用逗号分隔，例如 PFDFAA 或 MLD-LX2,V552AA）",
        args.customer_project,
    )
    customer_projects = parse_customer_projects(customer_text)
    if not customer_projects:
        raise ValueError("客户系统项目不能为空")
    jira_key = normalize_jira_key(prompt_required("Jira 项目关键字", args.jira_key))
    if not JIRA_KEY_PATTERN.fullmatch(jira_key):
        raise ValueError(f"Jira 项目关键字格式不正确: {jira_key}")
    summary_product = normalize_jira_key(args.summary_product) if str(args.summary_product or "").strip() else ""
    if not summary_product:
        summary_product = infer_summary_product(customer_projects, jira_key)
        if not args.customer_project or not args.jira_key:
            entered = input(f"标题产品名 [{summary_product}]: ").strip()
            if entered:
                summary_product = normalize_jira_key(entered)
    if not summary_product:
        raise ValueError("标题产品名不能为空")
    return customer_projects, jira_key, summary_product


def _load_json_object(path: Path) -> Dict[str, Any]:
    if not path.exists():
        return {}
    data = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(data, dict):
        raise ValueError(f"配置不是 JSON 对象: {path}")
    return data


def _write_json_object(path: Path, data: Dict[str, Any]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")


def _existing_jira_project(raw_value: Any) -> str:
    if isinstance(raw_value, dict):
        return normalize_jira_key(raw_value.get("jira_project") or "")
    return normalize_jira_key(raw_value or "")


def update_affect_project_mapping(
    path: Path,
    customer_projects: List[str],
    jira_key: str,
    *,
    force: bool = False,
) -> None:
    data = _load_json_object(path)
    conflicts: List[str] = []
    replacements: Dict[str, Any] = {}
    for prefix in customer_projects:
        existing_key = next((key for key in data if str(key).strip().upper() == prefix), None)
        current_jira = _existing_jira_project(data.get(existing_key)) if existing_key else ""
        if current_jira and current_jira != jira_key and not force:
            conflicts.append(f"{prefix} 已映射到 {current_jira}")
            continue
        if existing_key and existing_key != prefix:
            data.pop(existing_key, None)
        replacements[prefix] = {"jira_project": jira_key, "monkey_project": jira_key}
    if conflicts:
        raise ValueError("；".join(conflicts) + "。确认要改挂项目时加上 --force")
    data.update(replacements)
    _write_json_object(path, data)


def update_summary_product_mapping(path: Path, customer_projects: List[str], summary_product: str) -> None:
    data = {key: value for key, value in load_summary_product_mapping(path).items()}
    for prefix in customer_projects:
        data[prefix] = summary_product
    _write_json_object(path, data)


def extract_component_assignee(component: Dict[str, Any]) -> str:
    for field_name in ("realAssignee", "lead", "assignee"):
        user = component.get(field_name)
        if isinstance(user, dict):
            username = str(user.get("name") or user.get("key") or "").strip()
        else:
            username = str(user or "").strip()
        if username:
            return username
    return ""


def extract_component_assignees(components: List[Dict[str, Any]]) -> tuple[Dict[str, str], List[str]]:
    assignees: Dict[str, str] = {}
    missing: List[str] = []
    for component in components:
        module_name = str(component.get("name") or "").strip()
        if not module_name:
            continue
        assignee = extract_component_assignee(component)
        if not assignee:
            missing.append(module_name)
            continue
        assignees[module_name] = assignee
    return assignees, missing


def update_module_assignee_mapping(path: Path, jira_key: str, assignees: Dict[str, str]) -> None:
    data = _load_json_object(path)
    stale_keys = [key for key in list(data) if str(key).strip().upper() == jira_key and key != jira_key]
    for key in stale_keys:
        data.pop(key, None)
    data[jira_key] = assignees
    _write_json_object(path, data)


def fetch_project_components(jira_client: Any, jira_key: str) -> List[Dict[str, Any]]:
    project = jira_client.project(jira_key)
    resolved_key = normalize_jira_key(getattr(project, "key", "") or "")
    if resolved_key != jira_key:
        raise RuntimeError(f"Jira 未找到项目 {jira_key}")
    return jira_client.project_components(jira_key)


def prepare_workspace(workspace: str | Path) -> Dict[str, Path]:
    """把正式配置复制到独立工作区。已有工作区文件保持不动。"""
    root = Path(workspace)
    config_dir = root / "config"
    config_dir.mkdir(parents=True, exist_ok=True)
    sources = {
        "affect": (DEFAULT_AFFECT_PROJECT_MAPPING, "affect_project_mapping.json"),
        "summary": (SUMMARY_PRODUCT_MAPPING_FILE, "summary_product_mapping.json"),
        "module": (DEFAULT_MODULE_ASSIGNEE_MAPPING, "module_assignee_mapping.json"),
    }
    paths: Dict[str, Path] = {}
    for key, (source, name) in sources.items():
        target = config_dir / name
        if not target.exists():
            if source.exists():
                target.write_text(source.read_text(encoding="utf-8"), encoding="utf-8")
            else:
                target.write_text("{}\n", encoding="utf-8")
        paths[key] = target
    return paths


def register_project(
    *,
    customer_projects: List[str],
    jira_key: str,
    summary_product: str,
    components: List[Dict[str, Any]],
    force: bool = False,
    affect_mapping_path: Path = DEFAULT_AFFECT_PROJECT_MAPPING,
    summary_mapping_path: Path = SUMMARY_PRODUCT_MAPPING_FILE,
    module_assignee_path: Path = DEFAULT_MODULE_ASSIGNEE_MAPPING,
) -> Dict[str, Any]:
    assignees, missing_assignees = extract_component_assignees(components)
    update_affect_project_mapping(
        affect_mapping_path,
        customer_projects,
        jira_key,
        force=force,
    )
    update_summary_product_mapping(summary_mapping_path, customer_projects, summary_product)
    update_module_assignee_mapping(module_assignee_path, jira_key, assignees)
    return {
        "customer_projects": customer_projects,
        "jira_key": jira_key,
        "summary_product": summary_product,
        "assignees": assignees,
        "missing_assignees": missing_assignees,
        "workspace": "",
        "affect_mapping_path": str(affect_mapping_path),
        "summary_mapping_path": str(summary_mapping_path),
        "module_assignee_path": str(module_assignee_path),
    }


def print_registration_report(result: Dict[str, Any]) -> None:
    assignees = result.get("assignees") or {}
    missing = result.get("missing_assignees") or []
    print("项目已登记")
    workspace = str(result.get("workspace") or "").strip()
    if workspace:
        print(f"  工作区: {workspace}")
        print("  正式配置未修改")
    print(f"  客户系统项目: {', '.join(result.get('customer_projects') or [])}")
    print(f"  Jira 关键字: {result.get('jira_key')}")
    print(f"  标题产品名: {result.get('summary_product')}")
    print(f"  模块/经办人: {len(assignees)} 条")
    for module_name, assignee in assignees.items():
        print(f"    {module_name} -> {assignee}")
    if missing:
        print("  以下模块没有经办人，建单时仍使用包名表或默认经办人:")
        for module_name in missing:
            print(f"    {module_name}")
    if not assignees:
        print("  未从 Jira 读到模块经办人。包名仍按现有包名表匹配模块，经办人使用默认值。")


def main() -> int:
    setup_logging()
    load_local_env()
    args = parse_args()
    try:
        customer_projects, jira_key, summary_product = collect_project_inputs(args)
    except ValueError as exc:
        logger.error("%s", exc)
        return 1

    defaults = load_defaults(args.config_file)
    if not args.jira_cookie_jsessionid and not args.jira_cookie_xsrf_token and (not args.jira_username or not args.jira_password):
        logger.error("需要提供 Cookie 或 Jira 用户名密码")
        return 1
    if not args.jira_p12_path or not args.jira_p12_password:
        logger.error("需要提供 Tinno P12 证书路径和密码")
        return 1

    jira = None
    try:
        jira = connect_to_jira(
            server=args.jira_server or defaults.get("jira_server") or "https://jira.tinno.com",
            username=args.jira_username,
            password=args.jira_password,
            p12_file_path=args.jira_p12_path,
            p12_password=args.jira_p12_password,
            verify=bool(defaults.get("verify", False)),
            cookie_string=args.jira_cookie_string,
            cookie_jsessionid=args.jira_cookie_jsessionid,
            cookie_xsrf_token=args.jira_cookie_xsrf_token,
        )
        logger.info("当前认证来源: %s", getattr(jira, "auth_mode", "unknown"))
        components = fetch_project_components(jira, jira_key)
        workspace_paths = prepare_workspace(args.workspace) if args.workspace else {}
        result = register_project(
            customer_projects=customer_projects,
            jira_key=jira_key,
            summary_product=summary_product,
            components=components,
            force=bool(args.force),
            affect_mapping_path=workspace_paths.get("affect", DEFAULT_AFFECT_PROJECT_MAPPING),
            summary_mapping_path=workspace_paths.get("summary", SUMMARY_PRODUCT_MAPPING_FILE),
            module_assignee_path=workspace_paths.get("module", DEFAULT_MODULE_ASSIGNEE_MAPPING),
        )
        if args.workspace:
            result["workspace"] = str(Path(args.workspace))
    except Exception as exc:
        logger.error("项目初始化失败: %s", exc)
        return 1
    finally:
        close = getattr(jira, "close", None)
        if callable(close):
            close()

    print_registration_report(result)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
