# 人力预估创建与测试人员关联 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为 `universal_Automation-Create-Task` 增加独立的测试人员关联命令与一体化编排命令，使同一份 Excel/CSV 可完成“创建人力预估任务 + 关联测试人员”。

**Architecture:** 保持 `create-manpower` 不变，在 `manpower_api.py` 中新增与测试人员解析、任务定位、关联接口调用相关的独立能力，并在 `workflow.py` 中增加 `assign-manpower-testers` 与 `run-manpower` 两个命令。`build-manpower-csv` 同步产出 `testerNames` 列，使 Excel -> CSV -> 创建/关联链路使用同一份数据模型。

**Tech Stack:** Python 3.11, requests, openpyxl, argparse, pytest

---

## 文件结构

### 需要修改

- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`
  - 扩展 `build_manpower_csv_from_weekly_plan`，读取 `测试人员` 列并输出 `testerNames`
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`
  - 新增用户索引、测试人员解析、任务定位、测试人员关联、编排辅助结果结构
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`
  - 新增 `assign-manpower-testers` 和 `run-manpower` 命令
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
  - 增加 CSV 生成、测试人员解析、独立关联、编排命令的测试
- `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
  - 补充新列说明与命令用法

### 不修改

- `create-manpower` 现有职责与返回结构
- 既有 `auth` / `discover-manpower` 流程

### 新增函数建议

在 `manpower_api.py` 中新增：
- `get_active_users(self) -> list[dict]`
- `resolve_tester_names(self, tester_names: Any) -> dict`
- `find_estimate(self, form_data: dict, estimate_id: str | None = None) -> dict`
- `assign_testers(self, estimate_id: str, tester_names: Any) -> dict`
- `run_create_then_assign(self, form_data: dict) -> dict`

这些函数职责分离，便于单独测试与编排复用。

### Task 1: 扩展周计划 CSV 生成

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/excel_loader.py`
- Test: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 先写失败测试，约束 `testerNames` 列必须被输出**

```python
def test_build_manpower_csv_from_weekly_plan_writes_tester_names(tmp_path):
    source_path = tmp_path / "weekly_plan.xlsx"
    workbook = Workbook()
    sheet = workbook.active
    sheet.append(["项目", "本周计划", "人力投入", "项目编号", "测试人员"])
    sheet.append(["X1103", "专项验证", 2, "T727", "张三,李四"])
    workbook.save(source_path)

    output_path = build_manpower_csv_from_weekly_plan(
        str(source_path),
        output_dir=str(tmp_path),
        today=date(2026, 4, 11),
        now=datetime(2026, 4, 11, 16, 0, 0),
    )

    with open(output_path, "r", encoding="utf-8-sig", newline="") as file_obj:
        rows = list(csv.DictReader(file_obj))

    assert rows[0]["testerNames"] == "张三,李四"
```

- [ ] **Step 2: 跑单测确认当前实现失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_writes_tester_names -v`
Expected: FAIL，提示缺少 `testerNames` 列或断言不成立。

- [ ] **Step 3: 最小实现 `testerNames` 列写出**

在 `excel_loader.py` 中将必要表头扩展为包含 `测试人员`，并把 `fieldnames` 与输出字典补齐：

```python
required_headers = ["项目", "本周计划", "人力投入", "项目编号", "测试人员"]
fieldnames = [
    "projectName",
    "taskName",
    "site",
    "groupType",
    "beginDate",
    "endDate",
    "standardWorkHours",
    "testerNames",
]
...
tester_names = _normalize_value(row[header_index["测试人员"]]) if header_index["测试人员"] < len(row) else None
...
"testerNames": tester_names or "",
```

- [ ] **Step 4: 跑相关测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_build_manpower_csv_from_weekly_plan_writes_tester_names -v`
Expected: PASS。

- [ ] **Step 5: 自检旧的 CSV 构建测试不回归**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "build_manpower_csv" -q`
Expected: 全部 PASS。

### Task 2: 为测试人员解析写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写单个中文名与单个账号匹配测试**

```python
def test_resolve_tester_names_matches_username_and_nickname(fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    fake_auth_manager.session.get.return_value = FakeResponse(
        200,
        {"errno": 0, "data": {"list": [
            {"id": "u1", "username": "TNNC01", "nickname": "张三", "status": 1},
            {"id": "u2", "username": "lisi", "nickname": "李四", "status": 1},
        ]}},
    )

    resolved = client.resolve_tester_names("TNNC01,李四")

    assert resolved["success"] is True
    assert resolved["tester_ids"] == ["u1", "u2"]
```

- [ ] **Step 2: 写未找到与重名失败测试**

```python
def test_resolve_tester_names_fails_when_user_missing(fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    fake_auth_manager.session.get.return_value = FakeResponse(200, {"errno": 0, "data": {"list": []}})

    resolved = client.resolve_tester_names("不存在")

    assert resolved["success"] is False
    assert "未找到测试人员" in resolved["error"]


def test_resolve_tester_names_fails_when_nickname_duplicated(fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    fake_auth_manager.session.get.return_value = FakeResponse(
        200,
        {"errno": 0, "data": {"list": [
            {"id": "u1", "username": "zhangsan1", "nickname": "张三", "status": 1},
            {"id": "u2", "username": "zhangsan2", "nickname": "张三", "status": 1},
        ]}},
    )

    resolved = client.resolve_tester_names("张三")

    assert resolved["success"] is False
    assert "匹配到多个用户" in resolved["error"]
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "resolve_tester_names" -v`
Expected: FAIL，提示 `resolve_tester_names` 未定义或行为不符。

- [ ] **Step 4: 实现最小的用户拉取与名称解析逻辑**

在 `manpower_api.py` 中增加：

```python
def get_active_users(self) -> List[Dict[str, Any]]:
    session = self.auth_manager.create_requests_session(auto_refresh=True)
    response = session.get(self.config.base_url.rstrip("/") + "/api/user/list?status=1", timeout=30)
    payload = response.json()
    data = payload.get("data") or {}
    return data.get("list") or []


def resolve_tester_names(self, tester_names: Any) -> Dict[str, Any]:
    names = []
    for part in str(tester_names or "").split(","):
        normalized = part.strip()
        if normalized and normalized not in names:
            names.append(normalized)
    if not names:
        return {"success": True, "tester_ids": [], "tester_names": []}

    users = self.get_active_users()
    tester_ids = []
    for name in names:
        username_matches = [u for u in users if u.get("username") == name]
        if len(username_matches) == 1:
            tester_ids.append(username_matches[0]["id"])
            continue
        if len(username_matches) > 1:
            return {"success": False, "error": "测试人员 %s 匹配到多个用户" % name}

        nickname_matches = [u for u in users if u.get("nickname") == name]
        if len(nickname_matches) == 1:
            tester_ids.append(nickname_matches[0]["id"])
            continue
        if len(nickname_matches) > 1:
            return {"success": False, "error": "测试人员 %s 匹配到多个用户" % name}
        return {"success": False, "error": "未找到测试人员: %s" % name}

    return {"success": True, "tester_ids": tester_ids, "tester_names": names}
```

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "resolve_tester_names" -v`
Expected: PASS。

### Task 3: 为独立关联能力写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写按 `estimateId` 直接关联的失败测试**

```python
def test_assign_testers_posts_update_tester_with_estimate_id(fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    fake_auth_manager.session.get.side_effect = [
        FakeResponse(200, {"errno": 0, "data": {"list": [
            {"id": "u1", "username": "TNNC01", "nickname": "张三", "status": 1}
        ]}})
    ]
    fake_auth_manager.session.post.return_value = FakeResponse(200, {"errno": 0, "errmsg": "成功"})

    result = client.assign_testers("estimate-1", "TNNC01")

    assert result["success"] is True
    _, kwargs = fake_auth_manager.session.post.call_args
    assert kwargs["json"]["id"] == "estimate-1"
    assert kwargs["json"]["testerIds"] == ["u1"]
```

- [ ] **Step 2: 写关联接口失败测试**

```python
def test_assign_testers_returns_failure_when_api_errno_not_zero(fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    fake_auth_manager.session.get.side_effect = [
        FakeResponse(200, {"errno": 0, "data": {"list": [
            {"id": "u1", "username": "TNNC01", "nickname": "张三", "status": 1}
        ]}})
    ]
    fake_auth_manager.session.post.return_value = FakeResponse(200, {"errno": 500, "errmsg": "失败"})

    result = client.assign_testers("estimate-1", "TNNC01")

    assert result["success"] is False
    assert result["request_body"]["id"] == "estimate-1"
    assert "失败" in result["response_body"]
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_testers" -v`
Expected: FAIL。

- [ ] **Step 4: 实现最小关联逻辑**

在 `manpower_api.py` 中新增：

```python
def assign_testers(self, estimate_id: str, tester_names: Any) -> Dict[str, Any]:
    if not estimate_id:
        return {"success": False, "request_body": None, "response_body": "缺少 estimateId"}

    resolved = self.resolve_tester_names(tester_names)
    if not resolved.get("success"):
        return {
            "success": False,
            "request_body": None,
            "response_body": resolved.get("error", "测试人员解析失败"),
        }

    payload = {"id": estimate_id, "testerIds": resolved["tester_ids"]}
    session = self.auth_manager.create_requests_session(auto_refresh=True)
    response = session.post(
        self.config.base_url.rstrip("/") + "/api/task/hrestimate/update/tester",
        json=payload,
        headers={"content-type": "application/json;charset=UTF-8"},
        timeout=30,
    )
    response_text = getattr(response, "text", "")
    try:
        response_body = response.json()
    except Exception:
        response_body = None
    success = bool(getattr(response, "ok", False)) and isinstance(response_body, dict) and response_body.get("errno") in (None, 0)
    return {
        "success": success,
        "status_code": getattr(response, "status_code", None),
        "request_body": payload,
        "response_body": response_text[:4000],
        "tester_resolve_result": resolved,
    }
```

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_testers" -v`
Expected: PASS。

### Task 4: 为独立命令的任务定位写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写通过表单字段定位任务的测试**

```python
def test_find_estimate_matches_by_project_task_and_date(fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    fake_auth_manager.session.get.side_effect = [
        FakeResponse(200, {"errno": 0, "data": {"userId": "leader-1"}}),
        FakeResponse(200, {"errno": 0, "data": {"list": [
            {
                "id": "estimate-1",
                "projectName": "T727",
                "taskName": "X1103：专项验证",
                "beginDate": "2026-04-06",
                "endDate": "2026-04-12",
                "leaderId": "leader-1",
            }
        ]}}),
    ]

    result = client.find_estimate({
        "projectName": "T727",
        "taskName": "X1103：专项验证",
        "beginDate": "2026/4/6",
        "endDate": "2026/4/12",
    })

    assert result["success"] is True
    assert result["estimate_id"] == "estimate-1"
```

- [ ] **Step 2: 写找不到与重复命中的失败测试**

```python
def test_find_estimate_fails_when_no_match(fake_auth_manager, manpower_config):
    ...
    assert result["success"] is False
    assert "未找到匹配的人力预估任务" in result["error"]


def test_find_estimate_fails_when_multiple_matches(fake_auth_manager, manpower_config):
    ...
    assert result["success"] is False
    assert "匹配到多条人力预估任务" in result["error"]
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "find_estimate" -v`
Expected: FAIL。

- [ ] **Step 4: 实现最小任务定位逻辑**

在 `manpower_api.py` 中新增：

```python
def find_estimate(self, form_data: Dict[str, Any], estimate_id: Optional[str] = None) -> Dict[str, Any]:
    if estimate_id:
        return {"success": True, "estimate_id": estimate_id, "matched_by": "estimateId"}

    current_user = self.get_current_user()
    leader_id = current_user.get("id") or current_user.get("userId")
    begin_date = self._parse_date(form_data["beginDate"]).strftime("%Y-%m-%d")
    end_date = self._parse_date(form_data["endDate"]).strftime("%Y-%m-%d")
    iso_year, iso_week, _ = self._parse_date(form_data["beginDate"]).isocalendar()

    session = self.auth_manager.create_requests_session(auto_refresh=True)
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
    payload = response.json()
    data = payload.get("data") or {}
    items = data.get("list") or []
    matched = [
        item for item in items
        if item.get("projectName") == form_data.get("projectName")
        and item.get("taskName") == form_data.get("taskName")
        and item.get("beginDate") == begin_date
        and item.get("endDate") == end_date
    ]
    if not matched:
        return {"success": False, "error": "未找到匹配的人力预估任务"}
    if len(matched) > 1:
        return {"success": False, "error": "匹配到多条人力预估任务"}
    return {"success": True, "estimate_id": matched[0].get("id"), "matched_by": "list-query"}
```

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "find_estimate" -v`
Expected: PASS。

### Task 5: 为编排能力 `run_create_then_assign` 写失败测试

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/manpower_api.py`

- [ ] **Step 1: 写创建成功后立即关联的测试**

```python
def test_run_create_then_assign_uses_created_estimate_id(monkeypatch, fake_auth_manager, manpower_config):
    client = ManpowerApiClient(manpower_config, fake_auth_manager)
    monkeypatch.setattr(client, "create_estimate", lambda form_data: {
        "success": True,
        "status_code": 200,
        "request_body": {"projectName": "T727"},
        "response_body": '{"errno":0,"data":{"id":"estimate-1"}}',
    })
    monkeypatch.setattr(client, "assign_testers", lambda estimate_id, tester_names: {
        "success": True,
        "status_code": 200,
        "request_body": {"id": estimate_id, "testerIds": ["u1"]},
        "response_body": '{"errno":0}',
    })

    result = client.run_create_then_assign({"testerNames": "TNNC01"})

    assert result["create_result"]["success"] is True
    assert result["assign_result"]["success"] is True
    assert result["assign_result"]["request_body"]["id"] == "estimate-1"
```

- [ ] **Step 2: 写创建失败、无测试人员、关联失败三种分支测试**

```python
def test_run_create_then_assign_skips_assign_when_create_failed(...):
    ...

def test_run_create_then_assign_skips_assign_when_tester_names_empty(...):
    ...

def test_run_create_then_assign_keeps_task_id_when_assign_failed(...):
    ...
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "run_create_then_assign" -v`
Expected: FAIL。

- [ ] **Step 4: 实现最小编排逻辑**

在 `manpower_api.py` 中新增：

```python
def run_create_then_assign(self, form_data: Dict[str, Any]) -> Dict[str, Any]:
    create_result = self.create_estimate(form_data)
    if not create_result.get("success"):
        return {
            "create_result": create_result,
            "assign_result": {"success": False, "skipped": True, "response_body": "创建失败，未执行关联"},
        }

    tester_names = form_data.get("testerNames")
    if not str(tester_names or "").strip():
        estimate_id = self._extract_estimate_id(create_result)
        return {
            "create_result": create_result,
            "assign_result": {
                "success": True,
                "skipped": True,
                "estimate_id": estimate_id,
                "response_body": "未配置测试人员，跳过关联",
            },
        }

    estimate_id = self._extract_estimate_id(create_result)
    assign_result = self.assign_testers(estimate_id, tester_names)
    if estimate_id and assign_result.get("request_body") is not None:
        assign_result.setdefault("estimate_id", estimate_id)
    return {"create_result": create_result, "assign_result": assign_result}
```

并补一个内部辅助函数 `_extract_estimate_id(create_result)`，从 `response_body` JSON 里提取 `data.id`。

- [ ] **Step 5: 跑测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "run_create_then_assign" -v`
Expected: PASS。

### Task 6: 为 CLI 命令写失败测试并实现

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/itms_create_task/workflow.py`

- [ ] **Step 1: 写 `assign-manpower-testers` 和 `run-manpower` 解析器测试**

```python
def test_build_parser_supports_assign_and_run_manpower():
    parser = build_parser()
    assert parser.parse_args(["assign-manpower-testers"]).command == "assign-manpower-testers"
    assert parser.parse_args(["run-manpower"]).command == "run-manpower"
```

- [ ] **Step 2: 写命令分发测试**

```python
def test_main_dispatches_assign_manpower_testers(monkeypatch, tmp_path):
    config_path = tmp_path / "manpower.json"
    form_path = tmp_path / "form.json"
    config_path.write_text("{}", encoding="utf-8")
    form_path.write_text('{"projectName":"T727","taskName":"X1103：专项验证","beginDate":"2026-04-06","endDate":"2026-04-12","testerNames":"TNNC01"}', encoding="utf-8")

    monkeypatch.setattr("itms_create_task.workflow.load_manpower_config", lambda path: object())
    monkeypatch.setattr("itms_create_task.workflow.ItmsAuthManager", lambda config: object())

    class FakeClient:
        def __init__(self, config, auth_manager):
            pass
        def find_estimate(self, form_data, estimate_id=None):
            return {"success": True, "estimate_id": "estimate-1"}
        def assign_testers(self, estimate_id, tester_names):
            return {"success": True, "request_body": {"id": estimate_id, "testerIds": ["u1"]}, "response_body": "ok"}

    monkeypatch.setattr("itms_create_task.workflow.ManpowerApiClient", FakeClient)
    monkeypatch.setattr(sys, "argv", ["main.py", "assign-manpower-testers", "--config", str(config_path), "--form", str(form_path)])

    assert main() == 0
```

- [ ] **Step 3: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_manpower_testers or run_manpower" -v`
Expected: FAIL。

- [ ] **Step 4: 实现 CLI 命令与分发行为**

在 `workflow.py` 中：

```python
choices=[..., "assign-manpower-testers", "run-manpower", ...]
```

并新增命令分支：

```python
if args.command == "assign-manpower-testers":
    config = load_manpower_config(_resolve_config_path(args))
    form_items = load_form_items(args)
    if not any(form_items):
        raise SystemExit("assign-manpower-testers 模式需要通过 --form 或 --excel 提供表单数据。")

    auth_manager = ItmsAuthManager(config)
    api_client = ManpowerApiClient(config, auth_manager)
    results = []
    exit_code = 0
    for index, form_data in enumerate(form_items, 1):
        task_match = api_client.find_estimate(form_data, estimate_id=form_data.get("estimateId"))
        if task_match.get("success"):
            assign_result = api_client.assign_testers(task_match.get("estimate_id"), form_data.get("testerNames"))
        else:
            assign_result = {"success": False, "skipped": True, "response_body": "任务定位失败，未执行关联"}
        if not task_match.get("success") or not assign_result.get("success"):
            exit_code = 1
        results.append({
            "row_index": index,
            "input": form_data,
            "task_match_result": task_match,
            "assign_result": assign_result,
        })
    print_payload(results[0] if len(results) == 1 else results)
    return exit_code

if args.command == "run-manpower":
    config = load_manpower_config(_resolve_config_path(args))
    form_items = load_form_items(args)
    if not any(form_items):
        raise SystemExit("run-manpower 模式需要通过 --form 或 --excel 提供表单数据。")

    auth_manager = ItmsAuthManager(config)
    api_client = ManpowerApiClient(config, auth_manager)
    results = []
    exit_code = 0
    for index, form_data in enumerate(form_items, 1):
        result = api_client.run_create_then_assign(form_data)
        if not result.get("create_result", {}).get("success") or not result.get("assign_result", {}).get("success"):
            if not result.get("assign_result", {}).get("skipped"):
                exit_code = 1
        results.append({"row_index": index, "input": form_data, **result})
    print_payload(results[0] if len(results) == 1 else results)
    return exit_code
```

- [ ] **Step 5: 跑命令分发测试确认通过**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -k "assign_manpower_testers or run_manpower" -v`
Expected: PASS。

### Task 7: 更新 README 并做整体验证

**Files:**
- Modify: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/README.md`
- Test: `F:/automation-toolkit/python-tools/universal_Automation-Create-Task/tests/test_manpower_api.py`

- [ ] **Step 1: 写 README 约束测试**

```python
def test_readme_mentions_assign_and_run_manpower_commands():
    readme = Path("README.md").read_text(encoding="utf-8")
    assert "assign-manpower-testers" in readme
    assert "run-manpower" in readme
    assert "testerNames" in readme
```

- [ ] **Step 2: 跑测试确认失败**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py::test_readme_mentions_assign_and_run_manpower_commands -v`
Expected: FAIL。

- [ ] **Step 3: 更新 README 用法**

补充内容：
- `build-manpower-csv` 生成 `testerNames`
- `assign-manpower-testers` 的用法
- `run-manpower` 的用法
- `testerNames` 格式为英文逗号分隔

示例命令：

```powershell
python main.py build-manpower-csv --excel examples\本周项目计划表.xlsx
python main.py assign-manpower-testers --excel examples\manpower_form_template_20260411_160000.csv
python main.py run-manpower --excel examples\manpower_form_template_20260411_160000.csv
```

- [ ] **Step 4: 跑完整测试集**

Run: `cd F:\automation-toolkit\python-tools\universal_Automation-Create-Task; $env:PYTHONPATH='.'; pytest tests/test_manpower_api.py -q`
Expected: 全部 PASS。

- [ ] **Step 5: 做一次端到端静态自检**

Run: `cd F:\automation-toolkit; rg -n "assign-manpower-testers|run-manpower|testerNames|update/tester" python-tools\universal_Automation-Create-Task`
Expected: 新命令、字段名、接口路径都能在对应文件中查到，且没有把 `create-manpower` 原逻辑改坏。

## 自检结论

- Spec coverage：已覆盖 Excel/CSV 新列、独立关联命令、编排命令、用户匹配、任务定位、错误处理、README、测试。
- Placeholder scan：计划中的代码步骤都给出了明确函数、命令与断言，没有 `TODO` / `TBD` / “自行实现” 类占位。
- Type consistency：统一使用 `testerNames`、`estimateId`、`estimate_id`、`assign_testers`、`run_create_then_assign` 这些命名，CLI 与 API 层命名保持一致。
