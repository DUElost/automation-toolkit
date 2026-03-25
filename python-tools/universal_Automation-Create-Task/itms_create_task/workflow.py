# -*- coding: utf-8 -*-
"""
CLI 主工作流。
"""

import argparse
import json
import logging
import sys
from typing import Any, Dict, List

from .api_client import ItmsApiClient
from .auth import ItmsAuthManager
from .config_loader import load_config, load_form_data
from .context_resolver import ItmsContextResolver
from .discovery import ApiDiscovery
from .excel_loader import load_form_rows
from .ui_automation import ItmsUiAutomation


def setup_logging() -> None:
    """设置日志。"""
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(name)s - %(message)s",
        handlers=[logging.StreamHandler(sys.stdout)],
    )


def build_parser() -> argparse.ArgumentParser:
    """构建命令行解析器。"""
    parser = argparse.ArgumentParser(description="ITMS 子计划自动化创建工具")
    parser.add_argument("command", choices=["auth", "discover", "run", "ui", "api", "inspect-options"], help="执行模式")
    parser.add_argument("--config", default="examples/itms_config.example.json", help="配置文件路径")
    parser.add_argument("--form", help="表单数据 JSON 文件路径")
    parser.add_argument("--excel", help="Excel/CSV 表单文件路径")
    parser.add_argument("--sheet", help="Excel 工作表名称")
    parser.add_argument("--header-row", type=int, default=1, help="Excel 表头所在行，默认第 1 行")
    parser.add_argument("--project-name", help="覆盖项目名")
    parser.add_argument("--main-plan-name", help="覆盖主计划名")
    parser.add_argument("--testsuite-component-name", help="覆盖测试组件名")
    parser.add_argument("--task-type", help="覆盖任务类型")
    parser.add_argument("--task-sub-type", help="覆盖任务子类型")
    parser.add_argument("--owner-name", help="覆盖 Owner 名")
    parser.add_argument("--sub-plan-name", help="覆盖子计划名")
    return parser


def apply_cli_overrides(form_data: Dict[str, Any], args) -> Dict[str, Any]:
    """应用命令行覆盖项。"""
    result = dict(form_data)
    if args.project_name:
        result["project_name"] = args.project_name
    if args.main_plan_name:
        result["main_plan_name"] = args.main_plan_name
    if args.testsuite_component_name:
        result["testsuite_component_name"] = args.testsuite_component_name
    if args.task_type:
        result["task_type"] = args.task_type
    if args.task_sub_type:
        result["task_sub_type"] = args.task_sub_type
    if args.owner_name:
        result["owner_name"] = args.owner_name
    if args.sub_plan_name:
        result["sub_plan_name"] = args.sub_plan_name
    return result


def load_form_items(args) -> List[Dict[str, Any]]:
    """读取 JSON/Excel 表单数据。"""
    base_form = load_form_data(args.form) if args.form else {}

    if args.excel:
        rows = load_form_rows(args.excel, sheet_name=args.sheet, header_row=args.header_row)
        return [apply_cli_overrides(_merge_dicts(base_form, row), args) for row in rows]

    return [apply_cli_overrides(base_form, args)]


def _merge_dicts(base: Dict[str, Any], override: Dict[str, Any]) -> Dict[str, Any]:
    """浅合并 dict。"""
    result = dict(base)
    result.update(override)
    return result


def apply_form_defaults_to_config(config, form_data: Dict[str, Any]) -> None:
    """将本次输入中的默认字段同步到配置对象。"""
    if form_data.get("project_name"):
        config.project_name = form_data["project_name"]
    if form_data.get("main_plan_name"):
        config.main_plan_name = form_data["main_plan_name"]
    if form_data.get("testsuite_component_name"):
        config.testsuite_component_name = form_data["testsuite_component_name"]
    if form_data.get("task_type"):
        config.task_type = form_data["task_type"]
    if form_data.get("task_sub_type"):
        config.task_sub_type = form_data["task_sub_type"]
    if form_data.get("owner_name"):
        config.owner_name = form_data["owner_name"]


def print_payload(payload: Any) -> None:
    """统一打印 JSON。"""
    print(json.dumps(payload, ensure_ascii=False, indent=2))


def main() -> int:
    """命令行主入口。"""
    setup_logging()
    parser = build_parser()
    args = parser.parse_args()

    config = load_config(args.config)
    form_items = load_form_items(args)

    auth_manager = ItmsAuthManager(config)
    api_discovery = ApiDiscovery(config, auth_manager)
    api_client = ItmsApiClient(config, auth_manager)
    context_resolver = ItmsContextResolver(config, auth_manager)
    ui_automation = ItmsUiAutomation(config, auth_manager)

    if args.command == "auth":
        auth_manager.ensure_storage_state()
        return 0

    if args.command == "discover":
        payload = api_discovery.record_manual_flow()
        print(json.dumps(payload.get("candidate_request"), ensure_ascii=False, indent=2))
        return 0

    if args.command == "api":
        if not any(form_items):
            raise SystemExit("api 模式需要通过 --form 或 --excel 提供表单数据。")
        results = []
        exit_code = 0
        for index, form_data in enumerate(form_items, 1):
            apply_form_defaults_to_config(config, form_data)
            try:
                result = api_client.create_sub_plan(form_data)
                item = {"row_index": index, "input": form_data, "result": result.__dict__}
                if not result.success:
                    exit_code = 1
            except Exception as exc:
                exit_code = 1
                item = {
                    "row_index": index,
                    "input": form_data,
                    "result": {"success": False, "recoverable": False, "error": str(exc)},
                }
            results.append(item)
        print_payload(results[0]["result"] if len(results) == 1 else results)
        return exit_code

    if args.command == "inspect-options":
        outputs = []
        has_error = False
        for index, form_data in enumerate(form_items, 1):
            apply_form_defaults_to_config(config, form_data)
            try:
                payload = context_resolver.inspect_options(form_data)
                outputs.append({"row_index": index, "input": form_data, "payload": payload})
            except Exception as exc:
                has_error = True
                outputs.append({"row_index": index, "input": form_data, "error": str(exc)})
        if len(outputs) == 1 and "payload" in outputs[0]:
            snapshot_payload = outputs[0]["payload"]
        else:
            snapshot_payload = {"items": outputs}
        output_path = context_resolver.save_snapshot(snapshot_payload, "itms_context_snapshot.json")
        print_payload({"output_path": output_path, "payload": snapshot_payload})
        return 1 if has_error else 0

    if args.command == "ui":
        if not any(form_items):
            raise SystemExit("ui 模式需要通过 --form 或 --excel 提供表单数据。")
        for form_data in form_items:
            apply_form_defaults_to_config(config, form_data)
            ui_automation.create_sub_plan(form_data)
        return 0

    if args.command == "run":
        if not any(form_items):
            raise SystemExit("run 模式需要通过 --form 或 --excel 提供表单数据。")

        results = []
        exit_code = 0
        for index, form_data in enumerate(form_items, 1):
            apply_form_defaults_to_config(config, form_data)

            if config.api.enabled and api_client.has_profile():
                try:
                    result = api_client.create_sub_plan(form_data)
                    results.append({"row_index": index, "mode": "api", "input": form_data, "result": result.__dict__})
                    if result.success:
                        continue
                    if not result.recoverable:
                        exit_code = 1
                        logging.warning("第 %s 行接口执行失败，且属于业务错误，不再回退 UI。", index)
                        continue
                    logging.warning("第 %s 行接口执行失败，准备回退到 UI 自动化。", index)
                except Exception as exc:
                    exit_code = 1
                    results.append(
                        {
                            "row_index": index,
                            "mode": "api",
                            "input": form_data,
                            "result": {"success": False, "recoverable": False, "error": str(exc)},
                        }
                    )
                    logging.warning("第 %s 行接口执行异常，不再回退 UI。", index)
                    continue

            try:
                ui_automation.create_sub_plan(form_data)
                results.append({"row_index": index, "mode": "ui", "input": form_data, "result": {"success": True}})
            except Exception as exc:
                exit_code = 1
                results.append({"row_index": index, "mode": "ui", "input": form_data, "result": {"success": False, "error": str(exc)}})

        print_payload(results)
        return exit_code

    return 0
