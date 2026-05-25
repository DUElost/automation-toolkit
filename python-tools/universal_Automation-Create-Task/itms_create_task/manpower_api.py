# -*- coding: utf-8 -*-
"""
人力预估请求体生成。
"""

import time
from copy import deepcopy
from datetime import datetime, timedelta, timezone
import json
import re
from typing import Any, Dict, List, Optional

import requests


class ManpowerApiClient:
    """人力预估请求体生成客户端。"""

    REQUIRED_FIELDS = (
        "projectName",
        "taskName",
        "site",
        "groupType",
        "beginDate",
        "endDate",
        "standardWorkHours",
    )
    TEXT_FIELDS = ("projectName", "taskName", "site", "groupType", "beginDate", "endDate")

    def __init__(self, config, auth_manager):
        self.config = config
        self.auth_manager = auth_manager

    def get_current_user(self) -> Dict[str, Any]:
        """获取当前登录用户，并补齐 id 字段。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        response = session.get(
            self.config.base_url.rstrip("/") + "/api/auth/info",
            timeout=30,
        )
        if not getattr(response, "ok", False):
            raise RuntimeError("获取当前用户失败: /api/auth/info 请求未成功")

        try:
            payload = response.json()
        except Exception as exc:
            raise RuntimeError("获取当前用户失败: /api/auth/info 响应解析失败") from exc

        if not isinstance(payload, dict):
            raise RuntimeError("获取当前用户失败: /api/auth/info 响应格式不正确")

        errno = payload.get("errno")
        if errno not in (None, 0):
            errmsg = payload.get("errmsg", "")
            if errmsg:
                raise RuntimeError("获取当前用户失败: errno=%s errmsg=%s" % (errno, errmsg))
            raise RuntimeError("获取当前用户失败: errno=%s" % errno)

        data = payload.get("data") or {}
        if not isinstance(data, dict):
            raise RuntimeError("获取当前用户失败: data 不是对象")
        if data.get("userId") and not data.get("id"):
            data["id"] = data["userId"]
        return data

    def build_request_payload(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """根据表单数据构造请求体。"""
        self._validate_form_data(form_data)

        begin_date = self._parse_date(form_data["beginDate"])
        end_date = self._parse_date(form_data["endDate"])
        if begin_date > end_date:
            raise ValueError("beginDate 不能大于 endDate")
        standard_work_hours = self._normalize_standard_work_hours(form_data["standardWorkHours"])

        current_user = self.get_current_user()
        leader_id = current_user.get("id") or current_user.get("userId")
        if not leader_id:
            raise ValueError("当前用户缺少 id 或 userId")

        payload = deepcopy(form_data)
        payload["beginDate"] = begin_date.strftime("%Y-%m-%d")
        payload["endDate"] = end_date.strftime("%Y-%m-%d")
        payload["leaderId"] = leader_id
        payload["daterange"] = [
            self._to_utc_midnight_iso(begin_date),
            self._to_utc_midnight_iso(end_date),
        ]
        payload["standardWorkHours"] = standard_work_hours
        payload["weekList"] = self._build_week_list(begin_date, end_date, standard_work_hours)
        return payload

    def create_estimate(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """提交人力预估创建请求。"""
        try:
            payload = self.build_request_payload(form_data)
        except Exception as exc:
            return self.build_failure_result(exc)

        session = self.auth_manager.create_requests_session(auto_refresh=True)
        try:
            response = session.post(
                self.config.base_url.rstrip("/") + "/api/task/hrestimate/create",
                json=payload,
                headers={"content-type": "application/json;charset=UTF-8"},
                timeout=30,
            )
        except Exception as exc:
            return self.build_failure_result(exc, request_body=payload)

        response_text = getattr(response, "text", "")
        try:
            response_body = response.json()
        except Exception:
            response_body = None

        success = False
        if bool(getattr(response, "ok", False)) and isinstance(response_body, dict):
            success = response_body.get("errno") in (None, 0)

        return {
            "success": success,
            "status_code": getattr(response, "status_code", None),
            "request_body": payload,
            "response_body": response_text[:4000],
        }

    def get_active_users(self) -> List[Dict[str, Any]]:
        """获取启用用户列表。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        response = session.get(
            self.config.base_url.rstrip("/") + "/api/user/list?status=1",
            timeout=30,
        )
        if not getattr(response, "ok", False):
            raise RuntimeError("获取用户列表失败: /api/user/list 请求未成功")

        try:
            payload = response.json()
        except Exception as exc:
            raise RuntimeError("获取用户列表失败: /api/user/list 响应解析失败") from exc

        if not isinstance(payload, dict):
            raise RuntimeError("获取用户列表失败: 响应格式不正确")

        errno = payload.get("errno")
        if errno not in (None, 0):
            errmsg = payload.get("errmsg", "")
            if errmsg:
                raise RuntimeError("获取用户列表失败: errno=%s errmsg=%s" % (errno, errmsg))
            raise RuntimeError("获取用户列表失败: errno=%s" % errno)

        data = payload.get("data") or {}
        if isinstance(data, dict):
            users = data.get("list") or []
        elif isinstance(data, list):
            users = data
        else:
            raise RuntimeError("获取用户列表失败: data 格式不正确")

        if not isinstance(users, list):
            raise RuntimeError("获取用户列表失败: list 不是数组")
        return users

    def resolve_tester_names(self, tester_names: Any) -> Dict[str, Any]:
        """将测试人员名称解析为用户 id 列表。"""
        names = self._normalize_name_list(tester_names)

        if not names:
            return {"success": True, "tester_ids": [], "tester_names": []}

        users = self.get_active_users()
        tester_ids: List[str] = []
        matched_users: List[Dict[str, Any]] = []
        for name in names:
            username_matches = [user for user in users if user.get("username") == name]
            if len(username_matches) == 1:
                tester_ids.append(username_matches[0]["id"])
                matched_users.append(self._filter_user_fields(username_matches[0]))
                continue
            if len(username_matches) > 1:
                return {"success": False, "error": "测试人员 %s 匹配到多个用户" % name}

            nickname_matches = [user for user in users if user.get("nickname") == name]
            if len(nickname_matches) == 1:
                tester_ids.append(nickname_matches[0]["id"])
                matched_users.append(self._filter_user_fields(nickname_matches[0]))
                continue
            if len(nickname_matches) > 1:
                return {"success": False, "error": "测试人员 %s 匹配到多个用户" % name}
            return {"success": False, "error": "未找到测试人员: %s" % name}

        return {
            "success": True,
            "tester_ids": tester_ids,
            "tester_names": names,
            "matched_users": matched_users,
        }

    def _request_with_retry(
        self, session, method: str, url: str, max_retries: int = 2, **kwargs
    ):
        """带重试的 HTTP 请求，指数退避。"""
        last_exc = None
        for attempt in range(1 + max_retries):
            try:
                response = session.request(method, url, **kwargs)
                return response
            except (requests.ConnectionError, requests.Timeout) as exc:
                last_exc = exc
                if attempt < max_retries:
                    wait = 2 ** attempt
                    time.sleep(wait)
                continue
        raise last_exc  # type: ignore

    def read_estimate_detail(self, estimate_id: str) -> Dict[str, Any]:
        """读取已创建的人力预估详情。"""
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        response = self._request_with_retry(
            session, "GET",
            self.config.base_url.rstrip("/") + "/api/task/hrestimate/read",
            params={"id": estimate_id},
            timeout=30,
        )
        if not getattr(response, "ok", False):
            raise RuntimeError("获取人力预估详情失败: /api/task/hrestimate/read 请求未成功")

        try:
            payload = response.json()
        except Exception as exc:
            raise RuntimeError("获取人力预估详情失败: 响应解析失败") from exc

        if not isinstance(payload, dict):
            raise RuntimeError("获取人力预估详情失败: 响应格式不正确")

        errno = payload.get("errno")
        if errno not in (None, 0):
            errmsg = payload.get("errmsg", "")
            if errmsg:
                raise RuntimeError("获取人力预估详情失败: errno=%s errmsg=%s" % (errno, errmsg))
            raise RuntimeError("获取人力预估详情失败: errno=%s" % errno)

        data = payload.get("data") or {}
        if not isinstance(data, dict):
            raise RuntimeError("获取人力预估详情失败: data 不是对象")
        return data

    def read_estimate_weeks(self, estimate_id: str, estimate_detail: Optional[Dict[str, Any]] = None) -> List[Dict[str, Any]]:
        """读取人力预估周明细。"""
        detail = estimate_detail or self.read_estimate_detail(estimate_id)
        week_list = detail.get("weekList") or []
        if isinstance(week_list, list) and week_list:
            return week_list

        session = self.auth_manager.create_requests_session(auto_refresh=True)
        params_candidates = (
            {"taskEstimateId": estimate_id},
            {"estimateId": estimate_id},
            {"id": estimate_id},
        )
        for params in params_candidates:
            response = session.get(
                self.config.base_url.rstrip("/") + "/api/task/hrweekly/list",
                params=params,
                timeout=30,
            )
            if not getattr(response, "ok", False):
                continue
            try:
                payload = response.json()
            except Exception:
                continue
            if not isinstance(payload, dict) or payload.get("errno") not in (None, 0):
                continue
            data = payload.get("data")
            normalized = self._normalize_week_list_payload(data)
            if normalized:
                return normalized
        return []

    def find_estimate(self, form_data: Dict[str, Any], estimate_id: Optional[str] = None) -> Dict[str, Any]:
        """根据 estimateId 或表单信息定位已存在的人力预估任务。"""
        if estimate_id:
            return {"success": True, "estimate_id": estimate_id, "matched_by": "estimateId"}

        current_user = self.get_current_user()
        leader_id = current_user.get("id") or current_user.get("userId")
        if not leader_id:
            return {"success": False, "error": "当前用户缺少 id 或 userId"}

        begin_date = self._parse_date(form_data["beginDate"])
        end_date = self._parse_date(form_data["endDate"])
        iso_year, iso_week, _ = begin_date.isocalendar()

        session = self.auth_manager.create_requests_session(auto_refresh=True)
        try:
            response = session.get(
                self.config.base_url.rstrip("/") + "/api/task/hrestimate/list",
                params={
                    "page": 1,
                    "limit": 50,
                    "leaderId": leader_id,
                    "year": iso_year,
                    "week": iso_week,
                    "sort": "create_time",
                    "order": "asc",
                },
                timeout=30,
            )
        except Exception as exc:
            return {"success": False, "error": str(exc)}

        try:
            payload = response.json()
        except Exception as exc:
            return {"success": False, "error": str(exc)}

        data = payload.get("data") or {}
        items = data.get("list") or []
        task_name_candidates = self._build_task_name_candidates(form_data.get("taskName"))
        matched = [
            item
            for item in items
            if item.get("projectName") == form_data.get("projectName")
            and item.get("taskName") in task_name_candidates
            and item.get("beginDate") == begin_date.strftime("%Y-%m-%d")
            and item.get("endDate") == end_date.strftime("%Y-%m-%d")
        ]
        if not matched:
            return {"success": False, "error": "未找到匹配的人力预估任务"}
        if len(matched) > 1:
            return {"success": False, "error": "匹配到多条人力预估任务"}
        return {
            "success": True,
            "estimate_id": matched[0].get("id"),
            "matched_by": "list-query",
            "leaderId": leader_id,
        }

    def assign_testers(self, estimate_id: str, tester_names: Any) -> Dict[str, Any]:
        """调用接口关联测试人员。"""
        if not estimate_id:
            return {"success": False, "status_code": None, "request_body": None, "response_body": "缺少 estimateId"}

        try:
            resolved = self.resolve_tester_names(tester_names)
        except Exception as exc:
            return self.build_failure_result(exc)
        if not resolved.get("success"):
            return {
                "success": False,
                "status_code": None,
                "request_body": None,
                "response_body": resolved.get("error", "测试人员解析失败"),
                "tester_resolve_result": resolved,
            }

        payload = {"id": estimate_id, "userIds": resolved["tester_ids"]}
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        try:
            response = session.post(
                self.config.base_url.rstrip("/") + "/api/task/hrestimate/update/tester",
                json=payload,
                headers={"content-type": "application/json;charset=UTF-8"},
                timeout=30,
            )
        except Exception as exc:
            result = self.build_failure_result(exc, request_body=payload)
            result["tester_resolve_result"] = resolved
            return result

        response_text = getattr(response, "text", "")
        try:
            response_body = response.json()
        except Exception:
            response_body = None
        success = False
        if bool(getattr(response, "ok", False)) and isinstance(response_body, dict):
            success = response_body.get("errno") in (None, 0)
        return {
            "success": success,
            "status_code": getattr(response, "status_code", None),
            "request_body": payload,
            "response_body": response_text[:4000],
            "tester_resolve_result": resolved,
        }

    def fill_actual_work(self, estimate_id: str, effort: Any, tester_names: Any, actual_ratios: Any) -> Dict[str, Any]:
        """给已存在的人力预估填写测试人员实际工时。"""
        if not estimate_id:
            return {"success": False, "status_code": None, "request_body": None, "response_body": "缺少 estimateId"}

        try:
            estimate_detail = self.read_estimate_detail(estimate_id)
            week_list = self.read_estimate_weeks(estimate_id, estimate_detail=estimate_detail)
            if len(week_list) != 1:
                raise ValueError("当前仅支持单周任务")
            resolved = self.resolve_tester_names(tester_names)
            if not resolved.get("success"):
                return {
                    "success": False,
                    "status_code": None,
                    "request_body": None,
                    "response_body": resolved.get("error", "测试人员解析失败"),
                    "tester_resolve_result": resolved,
                }
            weekly_personal_list = self._build_weekly_personal_list(
                estimate_id=estimate_id,
                task_weekly_id=week_list[0].get("id"),
                matched_users=resolved.get("matched_users") or [],
                effort=effort,
                actual_ratios=actual_ratios,
            )
            if not weekly_personal_list:
                raise ValueError("缺少可提交的实际工时")
            payload = {
                "id": estimate_id,
                "weekList": [
                    self._build_actual_week_payload(week_list[0], weekly_personal_list),
                ],
            }
        except Exception as exc:
            return self.build_failure_result(exc)

        session = self.auth_manager.create_requests_session(auto_refresh=True)
        try:
            response = session.post(
                self.config.base_url.rstrip("/") + "/api/task/hrestimate/update/actual",
                json=payload,
                headers={"content-type": "application/json;charset=UTF-8"},
                timeout=30,
            )
        except Exception as exc:
            result = self.build_failure_result(exc, request_body=payload)
            result["tester_resolve_result"] = resolved
            return result

        response_text = getattr(response, "text", "")
        try:
            response_body = response.json()
        except Exception:
            response_body = None
        success = False
        if bool(getattr(response, "ok", False)) and isinstance(response_body, dict):
            success = response_body.get("errno") in (None, 0)
        return {
            "success": success,
            "status_code": getattr(response, "status_code", None),
            "request_body": payload,
            "response_body": response_text[:4000],
            "tester_resolve_result": resolved,
        }

    def complete_estimate(self, estimate_id: str) -> Dict[str, Any]:
        """将已存在的人力预估任务标记为已完成。"""
        if not estimate_id:
            return {"success": False, "status_code": None, "request_body": None, "response_body": "缺少 estimateId"}

        payload = "ids=%s&status=2" % estimate_id
        session = self.auth_manager.create_requests_session(auto_refresh=True)
        try:
            response = session.post(
                self.config.base_url.rstrip("/") + "/api/task/hrestimate/update/status",
                data=payload,
                headers={"content-type": "application/x-www-form-urlencoded; charset=UTF-8"},
                timeout=30,
            )
        except Exception as exc:
            return self.build_failure_result(exc, request_body={"ids": estimate_id, "status": 2})

        response_text = getattr(response, "text", "")
        try:
            response_body = response.json()
        except Exception:
            response_body = None
        success = False
        if bool(getattr(response, "ok", False)) and isinstance(response_body, dict):
            success = response_body.get("errno") in (None, 0)
        return {
            "success": success,
            "status_code": getattr(response, "status_code", None),
            "request_body": {"ids": estimate_id, "status": 2},
            "response_body": response_text[:4000],
        }

    def run_create_then_assign(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
        """先创建任务，再按需关联测试人员。"""
        create_result = self.create_estimate(form_data)
        if not create_result.get("success"):
            return {
                "create_result": create_result,
                "assign_result": {"success": False, "skipped": True, "response_body": "创建失败，未执行关联"},
            }

        estimate_id = self._extract_estimate_id(create_result)
        tester_names = form_data.get("testerNames")
        if not str(tester_names or "").strip():
            return {
                "create_result": create_result,
                "assign_result": {
                    "success": True,
                    "skipped": True,
                    "estimate_id": estimate_id,
                    "response_body": "未配置测试人员，跳过关联",
                },
            }

        assign_result = self.assign_testers(estimate_id, tester_names)
        assign_result.setdefault("estimate_id", estimate_id)
        return {"create_result": create_result, "assign_result": assign_result}

    @staticmethod
    def build_failure_result(exc: Exception, request_body: Optional[Dict[str, Any]] = None) -> Dict[str, Any]:
        """构造统一失败结果。"""
        return {
            "success": False,
            "status_code": None,
            "request_body": request_body,
            "response_body": str(exc)[:4000],
        }

    def _validate_form_data(self, form_data: Dict[str, Any]) -> None:
        """校验必填字段。"""
        for field_name in self.REQUIRED_FIELDS:
            value = form_data.get(field_name)
            if value is None:
                raise ValueError("缺少必填字段: %s" % field_name)
            if field_name in self.TEXT_FIELDS:
                if not isinstance(value, str) or not value.strip():
                    raise ValueError("缺少必填字段: %s" % field_name)
            elif value == "":
                raise ValueError("缺少必填字段: %s" % field_name)

    def _parse_date(self, value: Any) -> datetime:
        """解析 YYYY-MM-DD 日期。"""
        if not isinstance(value, str):
            raise ValueError("日期格式必须为 YYYY-MM-DD")
        normalized = value.strip()
        for fmt in ("%Y-%m-%d", "%Y/%m/%d"):
            try:
                return datetime.strptime(normalized, fmt)
            except ValueError:
                continue
        raise ValueError("日期格式必须为 YYYY-MM-DD")

    def _normalize_standard_work_hours(self, value: Any) -> int:
        """把工时规范成整数。"""
        if isinstance(value, bool):
            raise ValueError("standardWorkHours 必须是整数")
        if isinstance(value, int):
            return value
        if isinstance(value, str):
            if not value.strip():
                raise ValueError("standardWorkHours 必须是整数")
            try:
                normalized = int(value)
            except ValueError as exc:
                raise ValueError("standardWorkHours 必须是整数") from exc
            if str(normalized) != value.strip():
                raise ValueError("standardWorkHours 必须是整数")
            return normalized
        raise ValueError("standardWorkHours 必须是整数")

    def _to_utc_midnight_iso(self, date_value: datetime) -> str:
        """将北京时间 00:00:00 转为 UTC ISO 字符串。"""
        beijing_tz = timezone(timedelta(hours=8))
        utc_value = date_value.replace(tzinfo=beijing_tz).astimezone(timezone.utc)
        return utc_value.strftime("%Y-%m-%dT%H:%M:%S.000Z")

    def _build_week_list(self, begin_date: datetime, end_date: datetime, standard_work_hours: Any) -> List[Dict[str, Any]]:
        """按自然周拆分周列表。"""
        week_list: List[Dict[str, Any]] = []
        current = begin_date
        while current <= end_date:
            iso_year, iso_week, _ = current.isocalendar()
            week_end = current + timedelta(days=6 - current.weekday())
            if week_end > end_date:
                week_end = end_date
            week_list.append(
                {
                    "year": str(iso_year),
                    "week": iso_week,
                    "splitBeginDate": current.strftime("%Y-%m-%d"),
                    "splitEndDate": week_end.strftime("%Y-%m-%d"),
                    "standardWorkHours": standard_work_hours,
                }
            )
            current = week_end + timedelta(days=1)
        return week_list

    @staticmethod
    def _normalize_week_list_payload(data: Any) -> List[Dict[str, Any]]:
        """把不同接口返回的周明细结构统一成列表。"""
        if isinstance(data, list):
            return [item for item in data if isinstance(item, dict)]
        if isinstance(data, dict):
            for key in ("list", "weekList"):
                value = data.get(key)
                if isinstance(value, list):
                    return [item for item in value if isinstance(item, dict)]
        return []

    @staticmethod
    def _build_actual_week_payload(week_data: Dict[str, Any], weekly_personal_list: List[Dict[str, Any]]) -> Dict[str, Any]:
        """构造 update/actual 的单周请求体。"""
        payload = {
            "id": week_data.get("id"),
            "taskEstimateId": week_data.get("taskEstimateId"),
            "year": week_data.get("year"),
            "week": week_data.get("week"),
            "splitBeginDate": week_data.get("splitBeginDate"),
            "splitEndDate": week_data.get("splitEndDate"),
            "standardWorkHours": week_data.get("standardWorkHours"),
            "weeklyPersonalList": weekly_personal_list,
        }
        for key in ("updatemanId", "createmanId", "createTime", "updateTime"):
            if week_data.get(key) is not None:
                payload[key] = week_data.get(key)
        return payload

    def _build_weekly_personal_list(
        self,
        estimate_id: str,
        task_weekly_id: Any,
        matched_users: List[Dict[str, Any]],
        effort: Any,
        actual_ratios: Any,
    ) -> List[Dict[str, Any]]:
        """按测试人员顺序构造单周个人实际工时列表。"""
        effort_value = self._parse_number(effort, "人力投入必须是数字")
        ratios = list(actual_ratios or [])
        result: List[Dict[str, Any]] = []
        for index, user in enumerate(matched_users):
            if index >= len(ratios):
                continue
            ratio = ratios[index]
            if ratio in (None, ""):
                continue
            ratio_value = self._parse_number(ratio, "实际工时必须是数字")
            actual_hours = self._normalize_actual_work_hours(effort_value * ratio_value * 8)
            user_name = user.get("nickname") or user.get("username")
            result.append(
                {
                    "taskEstimateId": estimate_id,
                    "taskWeeklyId": task_weekly_id,
                    "userId": user.get("id"),
                    "userName": user_name,
                    "personalActualWorkHours": actual_hours,
                }
            )
        return result

    @staticmethod
    def _normalize_name_list(tester_names: Any) -> List[str]:
        """把逗号分隔字符串或列表统一成名称数组。"""
        if tester_names is None:
            return []
        if isinstance(tester_names, (list, tuple, set)):
            parts = tester_names
        else:
            parts = str(tester_names).split(",")
        names: List[str] = []
        for part in parts:
            normalized = str(part).strip()
            if normalized and normalized not in names:
                names.append(normalized)
        return names

    @staticmethod
    def _parse_number(value: Any, error_message: str) -> float:
        """把输入值解析为数字。"""
        if isinstance(value, bool):
            raise ValueError(error_message)
        if isinstance(value, (int, float)):
            return float(value)
        normalized = str(value or "").strip()
        if not normalized:
            raise ValueError(error_message)
        try:
            return float(normalized)
        except ValueError as exc:
            raise ValueError(error_message) from exc

    @staticmethod
    def _normalize_actual_work_hours(value: float) -> Any:
        """规范化实际工时，避免浮点残差。"""
        normalized = round(value, 4)
        if float(normalized).is_integer():
            return int(normalized)
        return normalized

    @staticmethod
    def _filter_user_fields(user: Dict[str, Any]) -> Dict[str, Any]:
        """仅保留调试所需的最小用户字段。"""
        return {
            "id": user.get("id"),
            "username": user.get("username"),
            "nickname": user.get("nickname"),
            "status": user.get("status"),
        }

    @staticmethod
    def _build_task_name_candidates(task_name: Any) -> List[str]:
        """构造任务名候选列表，兼容历史未追加周次后缀的数据。"""
        normalized = str(task_name or "").strip()
        if not normalized:
            return [normalized]

        candidates = [normalized]
        legacy_name = re.sub(r"[（(]WK\d+[）)]$", "", normalized)
        if legacy_name != normalized:
            candidates.append(legacy_name)
        return candidates

    @staticmethod
    def _extract_estimate_id(create_result: Dict[str, Any]) -> Optional[str]:
        """从创建结果中提取 estimate id。"""
        response_body = create_result.get("response_body")
        if not response_body:
            return None
        try:
            payload = json.loads(response_body)
        except Exception:
            return None
        data = payload.get("data") or {}
        if isinstance(data, dict):
            return data.get("id")
        return None
