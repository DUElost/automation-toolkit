# -*- coding: utf-8 -*-
"""
ITMS 项目上下文与默认值解析。
"""

import json
from copy import deepcopy
from pathlib import Path
from typing import Any, Dict, List, Optional

from .auth import ItmsAuthManager
from .models import ItmsToolConfig


class ItmsContextResolver:
    """基于接口动态解析项目、主计划与默认字段。"""

    def __init__(self, config: ItmsToolConfig, auth_manager: ItmsAuthManager):
        self.config = config
        self.auth_manager = auth_manager

    def inspect_options(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """输出当前项目上下文与可选项信息。"""
        context = self.resolve_context(form_data)
        project_id = context["project"]["id"]
        task_type = context["task_type"]
        task_sub_type = context["task_sub_type"]
        project_label = context.get("project_label", "")

        payload = {
            "project": context["project"],
            "content": context["content"],
            "current_user": context.get("current_user"),
            "task_type": task_type,
            "task_sub_type": task_sub_type,
            "project_versions": self.fetch_project_versions(project_id),
            "project_labels": self.fetch_project_labels(project_id),
            "task_types": self.fetch_field_options("TASKTYPE"),
            "prototype_stages": self.fetch_field_options("PROTOTYPESTAGE"),
            "task_sub_types": self.fetch_task_sub_types(task_type),
            "download_tools": self.fetch_download_tools(project_id),
            "accessories": self.fetch_accessories(project_id),
            "refphones": self.fetch_refphones(project_id),
            "result_standard": self.fetch_result_standard(project_id, task_sub_type),
            "project_jira": self.fetch_project_jira(project_id),
            "materials": self.fetch_materials(project_id, project_label, task_type, task_sub_type),
        }
        return payload

    def resolve_context(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """解析项目、主计划内容、用户与模板。"""
        project_name = form_data.get("project_name") or self.config.project_name
        main_plan_name = form_data.get("main_plan_name") or self.config.main_plan_name
        component_name = form_data.get("testsuite_component_name") or self.config.testsuite_component_name
        task_type = form_data.get("task_type") or self.config.task_type
        task_sub_type = form_data.get("task_sub_type") or self.config.task_sub_type

        project = self.resolve_project(project_name)
        content = self.resolve_main_plan_content(project["id"], main_plan_name, component_name)
        current_user = self.fetch_current_user()
        latest_task = self.fetch_latest_task(project["suiteId"], content["id"])
        project_labels = self.fetch_project_labels(project["id"])

        project_label = (
            form_data.get("project_label")
            or (latest_task or {}).get("projectLabel")
            or self._pick_default_label(project_labels)
        )

        project_version = (
            form_data.get("project_version")
            or (latest_task or {}).get("projectVersion")
            or self._pick_latest_version(self.fetch_project_versions(project["id"]))
        )

        prototype_stage = (
            form_data.get("prototype_stage")
            or (latest_task or {}).get("prototypeStage")
            or ""
        )

        prototype_num = form_data.get("prototype_num")
        if prototype_num is None:
            prototype_num = (latest_task or {}).get("prototypeNum", 0)

        return {
            "project": project,
            "content": content,
            "current_user": current_user,
            "latest_task": latest_task,
            "task_type": task_type,
            "task_sub_type": task_sub_type,
            "project_label": project_label,
            "project_version": project_version,
            "prototype_stage": prototype_stage,
            "prototype_num": prototype_num,
        }

    def build_request_payload(self, form_data: Dict[str, Any], profile_body: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """根据动态解析结果构建创建请求体。"""
        context = self.resolve_context(form_data)
        latest_task = context.get("latest_task")

        if latest_task:
            payload = self._build_from_latest_task(context, latest_task)
        else:
            payload = self._build_from_project_defaults(context)

        if isinstance(profile_body, dict):
            payload = self._deep_merge(deepcopy(profile_body), payload)

        payload.update(
            {
                "taskmaincontentId": context["content"]["id"],
                "testsuiteId": context["project"]["suiteId"],
                "project": context["project"]["name"],
                "bpmProject": context["project"].get("bpmProject") or context["project"]["name"],
                "projectKey": context["project"].get("jiraKey", ""),
                "projectVersion": context["project_version"],
                "taskType": context["task_type"],
                "taskSubType": context["task_sub_type"],
                "projectLabel": context["project_label"],
                "prototypeStage": context["prototype_stage"],
                "prototypeNum": context["prototype_num"],
            }
        )

        return payload

    def resolve_project(self, project_name: str) -> Dict[str, Any]:
        """按项目名解析项目。"""
        data = self._get_json("/api/project/list", {"projectId": 0, "sort": "create_time", "order": "desc"})
        for item in data.get("list", []):
            if self._match_text(item.get("name"), project_name) or self._match_text(item.get("bpmProject"), project_name):
                return {
                    "id": item["id"],
                    "name": item["name"],
                    "suiteId": item.get("suiteId") or item.get("suiteProjectId"),
                    "suiteName": item.get("suiteName") or item.get("name"),
                    "jiraKey": item.get("jiraKey", ""),
                    "bpmProject": item.get("bpmProject") or item.get("name"),
                    "leaderId": item.get("leaderId", ""),
                    "leaderName": item.get("leaderName", ""),
                }
        raise RuntimeError("未找到项目: %s" % project_name)

    def resolve_main_plan_content(self, project_id: str, main_plan_name: str, component_name: str) -> Dict[str, Any]:
        """解析主计划内容。"""
        data = self._get_json("/api/task/main/content/contentlist", {"projectId": project_id})
        candidates = []
        for item in data.get("list", []):
            if not self._match_text(item.get("taskmainName"), main_plan_name):
                continue
            candidates.append(item)

        if not candidates:
            raise RuntimeError("未找到主计划: %s" % main_plan_name)

        if component_name:
            for item in candidates:
                if self._match_text(item.get("testsuiteComponentName"), component_name):
                    return {
                        "id": item["id"],
                        "taskmainName": item.get("taskmainName", ""),
                        "testsuiteComponentName": item.get("testsuiteComponentName", ""),
                        "testsuiteComponentId": item.get("testsuiteComponentId", ""),
                    }

        item = candidates[0]
        return {
            "id": item["id"],
            "taskmainName": item.get("taskmainName", ""),
            "testsuiteComponentName": item.get("testsuiteComponentName", ""),
            "testsuiteComponentId": item.get("testsuiteComponentId", ""),
        }

    def fetch_latest_task(self, testsuite_id: str, taskmaincontent_id: str) -> Optional[Dict[str, Any]]:
        """获取当前主计划下最新的一个子计划，作为默认模板。"""
        data = self._get_json(
            "/api/task/list",
            {
                "page": 1,
                "limit": 10,
                "taskmaincontentId": taskmaincontent_id,
                "testsuiteId": testsuite_id,
                "sort": "create_time",
                "order": "desc",
            },
        )
        items = data.get("list", [])
        return items[0] if items else None

    def fetch_current_user(self) -> Dict[str, Any]:
        """获取当前登录用户。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        token = session.cookies.get("X-Tfts-Token") or session.cookies.get("JSESSIONID")
        if not token:
            return {}
        response = session.get(self.config.base_url.rstrip("/") + "/api/auth/info", params={"token": token}, timeout=30)
        payload = response.json()
        data = payload.get("data", {})
        if "id" not in data and data.get("userId"):
            data["id"] = data["userId"]
        return data

    def fetch_field_options(self, option_type: str) -> List[Dict[str, Any]]:
        """读取通用字段选项。"""
        data = self._get_json(
            "/api/fieldoption/list",
            {"type": option_type, "status": 1, "sort": "sequence", "order": "asc"},
        )
        return data.get("list", [])

    def fetch_task_sub_types(self, task_type: str) -> List[Dict[str, Any]]:
        """读取测试类型下的子类型。"""
        data = self._get_json("/api/tasktypeoption/list/tasktype", {"taskType": task_type, "defContent": "测试类型"})
        return data.get("list", [])

    def fetch_project_versions(self, project_id: str) -> List[Dict[str, Any]]:
        """读取项目版本。"""
        data = self._get_json("/api/version/project", {"projectId": project_id})
        return data.get("list", [])

    def fetch_project_labels(self, project_id: str) -> List[Dict[str, Any]]:
        """读取项目样机标签。"""
        data = self._get_json("/api/project/info/list/protolabel", {"projectId": project_id})
        return data.get("list", [])

    def fetch_download_tools(self, project_id: str) -> List[Dict[str, Any]]:
        """读取下载工具。"""
        data = self._get_json("/api/project/info/list/downloadtoolinfo", {"projectId": project_id})
        return data.get("list", [])

    def fetch_accessories(self, project_id: str) -> List[Dict[str, Any]]:
        """读取配件信息。"""
        data = self._get_json("/api/project/info/list/accessoryinfo", {"projectId": project_id})
        return data.get("list", [])

    def fetch_refphones(self, project_id: str) -> List[Dict[str, Any]]:
        """读取参考机信息。"""
        data = self._get_json("/api/project/info/list/refphoneinfo", {"projectId": project_id})
        return data.get("list", [])

    def fetch_materials(self, project_id: str, project_label: str, task_type: str, task_sub_type: str) -> List[Dict[str, Any]]:
        """读取物料信息。"""
        if not project_label:
            return []
        data = self._get_json(
            "/api/project/info/list/phonematerial",
            {
                "projectId": project_id,
                "labelList": project_label,
                "taskType": task_type,
                "taskSubType": task_sub_type,
            },
        )
        return data.get("list", [])

    def fetch_result_standard(self, project_id: str, task_sub_type: str) -> str:
        """读取结果判定标准。"""
        data = self._get_json(
            "/api/project/info/list",
            {"projectId": project_id, "majorType": "resultStandard", "label": task_sub_type},
        )
        items = data.get("list", [])
        if items:
            return items[0].get("name", "")
        return ""

    def fetch_project_jira(self, project_id: str) -> str:
        """读取项目 JIRA 地址。"""
        data = self._get_json(
            "/api/project/info/list",
            {"projectId": project_id, "majorType": "jiraAddr", "status": 1},
        )
        items = data.get("list", [])
        if items:
            return items[0].get("name", "")
        return ""

    def save_snapshot(self, payload: Dict[str, Any], output_name: str) -> str:
        """保存上下文快照。"""
        output_path = Path(self.config.config_path).parent / ".runtime" / output_name
        output_path.parent.mkdir(parents=True, exist_ok=True)
        with open(output_path, "w", encoding="utf-8") as file_obj:
            json.dump(payload, file_obj, ensure_ascii=False, indent=2)
        return str(output_path)

    def _build_from_latest_task(self, context: Dict[str, Any], latest_task: Dict[str, Any]) -> Dict[str, Any]:
        """从同主计划下最新任务构建请求体。"""
        payload = deepcopy(latest_task)
        self._remove_keys(
            payload,
            [
                "id",
                "status",
                "resultStatus",
                "createTime",
                "updateTime",
                "taskmaincontentName",
                "taskmainName",
                "testingLocation",
                "taskInfo",
            ],
        )

        current_user = context.get("current_user") or {}
        content_detail = self._get_json("/api/task/main/content/readsimple", {"id": context["content"]["id"]})
        project_id = context["project"]["id"]
        project_label = context["project_label"]
        task_type = context["task_type"]
        task_sub_type = context["task_sub_type"]
        user_id = current_user.get("id", "")
        user_name = current_user.get("nickName", "")

        payload["leaderId"] = content_detail.get("contentLeaderId") or payload.get("leaderId") or context["project"].get("leaderId", "")
        if user_id:
            payload["updatemanId"] = user_id
            payload["createmanId"] = user_id
        if current_user.get("email"):
            payload["mailto"] = current_user["email"]

        payload["projectJira"] = self.fetch_project_jira(project_id) or payload.get("projectJira", "")
        payload["resultStandard"] = self.fetch_result_standard(project_id, task_sub_type) or payload.get("resultStandard", "")

        materials = self.fetch_materials(project_id, project_label, task_type, task_sub_type)
        if materials:
            payload["materialList"] = materials

        download_tools = self.fetch_download_tools(project_id)
        if download_tools:
            payload["toolList"] = [
                {
                    "jobContent": item.get("name", ""),
                    "executeId": user_id,
                    "testerName": user_name,
                    "updatemanId": user_id,
                    "createmanId": user_id,
                }
                for item in download_tools
            ]

        accessories = self.fetch_accessories(project_id)
        if accessories:
            payload["accessoryList"] = [
                {
                    "jobContentType": item.get("typeName", ""),
                    "jobContent": item.get("name", ""),
                    "jobContentTypeLabel": item.get("label", ""),
                    "updatemanId": user_id,
                    "createmanId": user_id,
                    "executeId": item.get("id", ""),
                }
                for item in accessories
            ]

        refphones = self.fetch_refphones(project_id)
        if refphones:
            payload["refphoneList"] = [
                {
                    "jobType": "refphoneinfo",
                    "jobContentType": item.get("typeName", "") or item.get("type", ""),
                    "jobContent": item.get("name", ""),
                    "updatemanId": user_id,
                    "createmanId": user_id,
                }
                for item in refphones
            ]

        return payload

    def _build_from_project_defaults(self, context: Dict[str, Any]) -> Dict[str, Any]:
        """当没有可继承任务时，从项目默认信息拼装请求体。"""
        project = context["project"]
        current_user = context.get("current_user") or {}
        project_id = project["id"]
        project_label = context["project_label"]
        task_type = context["task_type"]
        task_sub_type = context["task_sub_type"]

        user_id = current_user.get("id", "")
        user_name = current_user.get("nickName", "")

        download_tools = self.fetch_download_tools(project_id)
        accessories = self.fetch_accessories(project_id)
        refphones = self.fetch_refphones(project_id)
        materials = self.fetch_materials(project_id, project_label, task_type, task_sub_type)

        payload = {
            "leaderId": project.get("leaderId", ""),
            "taskOta": "",
            "taskSwpath": "",
            "projectJira": self.fetch_project_jira(project_id),
            "resultStandard": self.fetch_result_standard(project_id, task_sub_type),
            "taskPreparation": "",
            "taskStrategy": "",
            "taskModification": "",
            "taskRisk": "",
            "mailto": current_user.get("email", ""),
            "updatemanId": user_id,
            "createmanId": user_id,
            "naChecked": False,
            "toolList": [
                {
                    "jobContent": item.get("name", ""),
                    "executeId": user_id,
                    "testerName": user_name,
                    "updatemanId": user_id,
                    "createmanId": user_id,
                }
                for item in download_tools
            ],
            "materialList": materials,
            "accessoryList": [
                {
                    "jobContentType": item.get("typeName", ""),
                    "jobContent": item.get("name", ""),
                    "jobContentTypeLabel": item.get("label", ""),
                    "updatemanId": user_id,
                    "createmanId": user_id,
                    "executeId": item.get("id", ""),
                }
                for item in accessories
            ],
            "refphoneList": [
                {
                    "jobType": "refphoneinfo",
                    "jobContentType": item.get("typeName", "") or item.get("type", ""),
                    "jobContent": item.get("name", ""),
                    "updatemanId": user_id,
                    "createmanId": user_id,
                }
                for item in refphones
            ],
            "preparationList": [],
            "extendInfoList": [],
            "scriptList": [],
        }
        return payload

    def _get_json(self, path: str, params: Dict[str, Any]) -> Dict[str, Any]:
        """调用 JSON 接口并返回 data。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        response = session.get(self.config.base_url.rstrip("/") + path, params=params, timeout=30)
        payload = response.json()
        errno = payload.get("errno")
        if errno not in (None, 0):
            errmsg = payload.get("errmsg", "")
            if errno == 501:
                raise RuntimeError(
                    "接口调用失败: %s errno=501，当前登录态可能已失效，请先重新执行 auth 命令刷新 storage_state。"
                    % path
                )
            if errmsg:
                raise RuntimeError("接口调用失败: %s errno=%s errmsg=%s" % (path, errno, errmsg))
            raise RuntimeError("接口调用失败: %s errno=%s" % (path, errno))
        return payload.get("data", {})

    @staticmethod
    def _remove_keys(data: Dict[str, Any], keys: List[str]) -> None:
        """原地删除不应提交的字段。"""
        for key in keys:
            data.pop(key, None)

    @staticmethod
    def _match_text(left: Optional[str], right: Optional[str]) -> bool:
        """忽略空白进行文本匹配。"""
        return (left or "").strip() == (right or "").strip()

    @staticmethod
    def _pick_default_label(labels: List[Dict[str, Any]]) -> str:
        """选择默认标签。"""
        if not labels:
            return ""
        return labels[0].get("label", "")

    @staticmethod
    def _pick_latest_version(versions: List[Dict[str, Any]]) -> str:
        """选择最新版本。"""
        if not versions:
            return ""
        return versions[0].get("name", "")

    def _deep_merge(self, base: Dict[str, Any], override: Dict[str, Any]) -> Dict[str, Any]:
        """深度合并 dict。"""
        for key, value in override.items():
            if isinstance(value, dict) and isinstance(base.get(key), dict):
                base[key] = self._deep_merge(base[key], value)
            else:
                base[key] = value
        return base
