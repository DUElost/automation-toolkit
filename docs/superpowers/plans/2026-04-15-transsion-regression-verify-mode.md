# Transsion 回归验证模式 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 为第二阶段脚本新增“回归验证模式”，按项目、专项、版本、reporter 自动构建 Jira 查询，对历史已解决问题执行 PASS 回归验证，并与 Excel 模式在同一项目内共享本地累计状态。

**Architecture:** 在现有 `create_transsion_jira_batch_from_excel.py` 中新增模式解析与分发，保留 Excel 模式原行为；新增业务参数驱动的回归验证分支，复用现有 `RegressionStore`、`export_jira_snapshot(...)`、`evaluate_regression_pass(...)` 和结果输出。SQLite 路由改为“按 Jira 项目 Key 拆库”，同项目共享、跨项目隔离。

**Tech Stack:** Python 3、pytest、pandas、jira、sqlite3

---

### Task 1: 模式参数与入口校验

**Files:**
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`

- [ ] **Step 1: 写失败测试，锁定模式互斥规则**

```python
def test_resolve_run_mode_returns_excel_for_excel_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file="upload.xlsx",
        regression_project=None,
        regression_specialties=[],
        current_version=None,
        history_reporter=None,
    )

    mode = module.resolve_run_mode(args)

    assert mode == "excel"


def test_resolve_run_mode_returns_regression_verify_for_regression_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
    )

    mode = module.resolve_run_mode(args)

    assert mode == "regression_verify"


def test_resolve_run_mode_rejects_mixed_excel_and_regression_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file="upload.xlsx",
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
    )

    with pytest.raises(ValueError, match="模式参数不能同时"):
        module.resolve_run_mode(args)


def test_resolve_run_mode_rejects_missing_required_regression_args(batch_entry_module):
    module = batch_entry_module
    args = SimpleNamespace(
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=[],
        current_version=None,
        history_reporter=None,
    )

    with pytest.raises(ValueError, match="regression-specialty|current-version|history-reporter"):
        module.resolve_run_mode(args)
```

- [ ] **Step 2: 跑测试，确认红灯**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q
```

Expected: FAIL，提示 `resolve_run_mode` 未定义或模式校验不符合预期。

- [ ] **Step 3: 最小实现参数与模式解析**

```python
# 在现有 parse_args() 中新增以下参数定义
parser.add_argument("--add-excel-file", dest="excel_file", default=None, help="上传模板 Excel 路径")
parser.add_argument("--regression-project", dest="regression_project", default=None, help="回归验证模式的 Jira 项目 Key")
parser.add_argument(
    "--regression-specialty",
    dest="regression_specialties",
    action="append",
    default=[],
    help="回归验证模式的专项名称，支持重复传参",
)
parser.add_argument("--current-version", dest="current_version", default=None, help="回归验证模式的当前验证版本")
parser.add_argument("--history-reporter", dest="history_reporter", default=None, help="回归验证模式用于粗筛历史问题的 reporter")


def resolve_run_mode(args: argparse.Namespace) -> str:
    has_excel_mode = bool(str(getattr(args, "excel_file", "") or "").strip())
    has_regression_mode = bool(str(getattr(args, "regression_project", "") or "").strip())
    if has_excel_mode and has_regression_mode:
        raise ValueError("Excel 模式参数与回归验证模式参数不能同时使用")
    if not has_excel_mode and not has_regression_mode:
        raise ValueError("必须选择 Excel 模式或回归验证模式")
    if has_regression_mode:
        missing = []
        if not getattr(args, "regression_specialties", []):
            missing.append("--regression-specialty")
        if not str(getattr(args, "current_version", "") or "").strip():
            missing.append("--current-version")
        if not str(getattr(args, "history_reporter", "") or "").strip():
            missing.append("--history-reporter")
        if missing:
            raise ValueError(f"回归验证模式缺少必要参数: {', '.join(missing)}")
        return "regression_verify"
    return "excel"
```

- [ ] **Step 4: 跑测试，确认转绿**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q
```

Expected: 新增模式测试 PASS，其余已有测试保持通过。

- [ ] **Step 5: Commit**

```powershell
git add F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\create_transsion_jira_batch_from_excel.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py
git commit -m "feat(transsion): add regression verify mode argument parsing"
```

### Task 2: 项目级 SQLite 路由

**Files:**
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/config/regression_rules.json`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`

- [ ] **Step 1: 写失败测试，锁定项目级 DB 路径**

```python
def test_build_project_scoped_sqlite_path_returns_project_db_under_regression_cache(batch_entry_module, tmp_path):
    module = batch_entry_module

    resolved = module.build_project_scoped_sqlite_path(
        project_key="X6851OS16",
        sqlite_path_setting="result/regression_cache",
    )

    assert resolved == module.CURRENT_DIR / "result" / "regression_cache" / "X6851OS16.db"


def test_run_batch_create_uses_project_scoped_store_path_for_excel_mode(tmp_path, monkeypatch, batch_entry_module):
    module = batch_entry_module
    args = _make_args(tmp_path, dry_run=True, excel_file="fake.xlsx")
    df = pd.DataFrame([_make_row(Project="X6851OS16")])
    captured_paths = []

    monkeypatch.setattr(module, "read_excel_smart", lambda _: df)
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com", "project_key": "X6851OS16", "issue_type": "故障"})
    monkeypatch.setattr(module, "load_regression_rules", lambda _: SimpleNamespace(
        jira_export=SimpleNamespace(enabled=True, jql="reporter in (dailv.tinno)", max_results=50, fields=["key"]),
        matching=SimpleNamespace(required_exact_fields=["affect_project", "environment", "exp_class"], cause_similarity_threshold=0.9),
        regression=SimpleNamespace(enabled=True, required_regression_pass_versions=2),
        output=SimpleNamespace(sqlite_path="result/regression_cache", excel_summary_dir=str(tmp_path / "result")),
    ))
    monkeypatch.setattr(module, "connect_to_jira", lambda *_: SimpleNamespace(current_user=lambda: "robot", search_issues=lambda *a, **k: []))
    monkeypatch.setattr(module, "RegressionStore", lambda db_path: captured_paths.append(db_path) or SimpleNamespace(save_sync_run=lambda *_a, **_k: None, save_snapshot=lambda *_a, **_k: None, save_execution_result=lambda *_a, **_k: None))

    module.run_batch_create(args)

    assert captured_paths == [module.CURRENT_DIR / "result" / "regression_cache" / "X6851OS16.db"]
```

- [ ] **Step 2: 跑测试，确认红灯**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py -q
```

Expected: FAIL，提示尚未按项目构建 SQLite 路径或配置契约不匹配。

- [ ] **Step 3: 最小实现项目级 DB 路由**

```python
def build_project_scoped_sqlite_path(project_key: str, sqlite_path_setting: Any) -> Path:
    project_text = str(project_key or "").strip()
    if not project_text:
        raise ValueError("project_key 不能为空")
    base_path = Path(str(sqlite_path_setting or "result/regression_cache"))
    if not base_path.is_absolute():
        base_path = CURRENT_DIR / base_path
    if base_path.suffix.lower() == ".db":
        base_path = base_path.parent
    return base_path / f"{project_text}.db"
```

```python
store = RegressionStore(
    build_project_scoped_sqlite_path(
        batch_project_key,
        getattr(regression_rules.output, "sqlite_path", "result/regression_cache"),
    )
)
```

```json
{
  "output": {
    "sqlite_path": "result/regression_cache",
    "excel_summary_dir": "result"
  }
}
```

- [ ] **Step 4: 跑测试，确认转绿**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py -q
```

Expected: 项目级 DB 测试 PASS，配置契约更新后的测试 PASS。

- [ ] **Step 5: Commit**

```powershell
git add F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\create_transsion_jira_batch_from_excel.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\config\regression_rules.json F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py
git commit -m "feat(transsion): isolate regression cache by jira project"
```

### Task 3: 专项驱动 JQL 构造与候选去重

**Files:**
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`

- [ ] **Step 1: 写失败测试，锁定专项 JQL 与去重逻辑**

```python
def test_build_regression_verify_jql_uses_monkey_keyword_for_monkey_specialty(batch_entry_module):
    module = batch_entry_module

    jql = module.build_regression_verify_jql(
        project_key="X6851OS16",
        reporter="dailv.tinno",
        specialty="Monkey专项",
    )

    assert jql == 'project = X6851OS16 AND reporter in (dailv.tinno) AND (summary ~ "\\\\[MonkeyAEE\\\\]")'


def test_build_regression_verify_jql_uses_stability_keyword_for_non_monkey_specialty(batch_entry_module):
    module = batch_entry_module

    jql = module.build_regression_verify_jql(
        project_key="X6851OS16",
        reporter="dailv.tinno",
        specialty="休眠唤醒专项",
    )

    assert jql == 'project = X6851OS16 AND reporter in (dailv.tinno) AND (summary ~ "【稳定性专项】")'


def test_deduplicate_snapshot_rows_by_jira_key_keeps_latest_first(batch_entry_module):
    module = batch_entry_module

    rows = module.deduplicate_snapshot_rows_by_jira_key([
        {"jira_key": "X6851OS16-607", "summary": "a"},
        {"jira_key": "X6851OS16-607", "summary": "b"},
        {"jira_key": "X6851OS16-608", "summary": "c"},
    ])

    assert rows == [
        {"jira_key": "X6851OS16-607", "summary": "a"},
        {"jira_key": "X6851OS16-608", "summary": "c"},
    ]
```

- [ ] **Step 2: 跑测试，确认红灯**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q
```

Expected: FAIL，提示 JQL 构造和去重 helper 尚未实现。

- [ ] **Step 3: 最小实现专项 JQL 与去重 helper**

```python
def build_regression_verify_jql(project_key: str, reporter: str, specialty: str) -> str:
    summary_keyword = MONKEY_SUMMARY_KEYWORD if str(specialty or "").strip() == "Monkey专项" else STABILITY_SUMMARY_KEYWORD
    base_jql = build_regression_base_jql(project_key, f"reporter in ({str(reporter or '').strip()})")
    return build_regression_export_jql(base_jql, [summary_keyword])


def deduplicate_snapshot_rows_by_jira_key(rows: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
    seen: set[str] = set()
    deduped: List[Dict[str, Any]] = []
    for row in rows:
        jira_key = str((row or {}).get("jira_key") or "").strip()
        if not jira_key or jira_key in seen:
            continue
        seen.add(jira_key)
        deduped.append(dict(row))
    return deduped
```

- [ ] **Step 4: 跑测试，确认转绿**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py -q
```

Expected: 新增专项 JQL 与去重测试 PASS。

- [ ] **Step 5: Commit**

```powershell
git add F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\create_transsion_jira_batch_from_excel.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py
git commit -m "feat(transsion): add specialty-driven regression verify jql helpers"
```

### Task 4: 回归验证模式主流程

**Files:**
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/create_transsion_jira_batch_from_excel.py`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_pass.py`

- [ ] **Step 1: 写失败测试，锁定回归验证模式行为**

```python
def test_run_batch_create_regression_verify_mode_builds_queries_per_specialty_and_writes_execution_results(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    args = _make_args(
        tmp_path,
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项", "Monkey专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
        dry_run=True,
    )
    captured_jql = []
    saved_results = []

    class FakeJira:
        def current_user(self):
            return "robot"

        def search_issues(self, jql: str, maxResults: int = 50, fields: str | None = None):
            captured_jql.append(jql)
            return [SimpleNamespace(key="X6851OS16-607")]

        def issue(self, issue_key: str):
            return SimpleNamespace(
                key=issue_key,
                raw={
                    "fields": {
                        "summary": "【天珑团队】【BUG】【X6851】【OP】【Alpha】【稳定性专项】【休眠唤醒专项】问题",
                        "status": {"name": "Verified"},
                        "resolution": {"name": "已修复"},
                        "fixVersions": [{"name": "X6851-16.3.0.020(OP001PF001AZ)_SU"}],
                    }
                },
            )

    monkeypatch.setattr(module, "connect_to_jira", lambda *_: FakeJira())
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, tmp_path / "result"))
    monkeypatch.setattr(
        module,
        "RegressionStore",
        lambda *_args, **_kwargs: SimpleNamespace(
            save_sync_run=lambda *_a, **_k: None,
            save_snapshot=lambda *_a, **_k: None,
            save_execution_result=lambda payload: saved_results.append(payload),
        ),
    )

    exit_code = module.run_batch_create(args)

    assert exit_code == 0
    assert len(captured_jql) == 2
    assert any("MonkeyAEE" in item for item in captured_jql)
    assert any("稳定性专项" in item for item in captured_jql)
    assert saved_results
```

```python
def test_run_batch_create_regression_verify_mode_dry_run_does_not_record_pass_state(
    tmp_path: Path,
    monkeypatch: pytest.MonkeyPatch,
    batch_entry_module,
):
    module = batch_entry_module
    args = _make_args(
        tmp_path,
        excel_file=None,
        regression_project="X6851OS16",
        regression_specialties=["休眠唤醒专项"],
        current_version="X6851-16.3.0.021(OP001PF001AZ)_SU",
        history_reporter="dailv.tinno",
        dry_run=True,
    )
    record_calls = []

    class FakeStore:
        def save_sync_run(self, *_args, **_kwargs):
            return None

        def save_snapshot(self, *_args, **_kwargs):
            return None

        def save_execution_result(self, *_args, **_kwargs):
            return None

        def record_regression_pass(self, *_args, **_kwargs):
            record_calls.append("called")

    monkeypatch.setattr(module, "connect_to_jira", lambda *_: SimpleNamespace(current_user=lambda: "robot", search_issues=lambda *_a, **_k: []))
    monkeypatch.setattr(module, "load_defaults", lambda _: {"jira_server": "http://jira.example.com"})
    monkeypatch.setattr(module, "load_priority_mapping_from_rules_excel", lambda _: {"severity_to_priority": {}, "priority_aliases": {}})
    monkeypatch.setattr(module, "load_regression_rules", lambda _: _make_rules(tmp_path, tmp_path / "result"))
    monkeypatch.setattr(module, "RegressionStore", lambda *_args, **_kwargs: FakeStore())

    module.run_batch_create(args)

    assert record_calls == []
```

- [ ] **Step 2: 跑测试，确认红灯**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_pass.py -q
```

Expected: FAIL，提示 `run_batch_create` 仍强依赖 Excel 链路，尚未支持新模式。

- [ ] **Step 3: 最小实现回归验证模式分支**

```python
def run_regression_verify_mode(args: argparse.Namespace) -> int:
    defaults = load_defaults(args.config_file)
    regression_rules = load_regression_rules(DEFAULT_REGRESSION_RULES_FILE)
    jira = connect_to_jira(args.jira_server or defaults.get("jira_server"), args.jira_username, args.jira_password)
    current_user = str(jira.current_user() or "").strip()
    project_key = str(args.regression_project).strip()
    specialties = [str(item).strip() for item in (args.regression_specialties or []) if str(item).strip()]
    current_version = str(args.current_version or "").strip()
    store = RegressionStore(
        build_project_scoped_sqlite_path(
            project_key,
            getattr(regression_rules.output, "sqlite_path", "result/regression_cache"),
        )
    )
    run_id = datetime.now().strftime("%Y%m%d_%H%M%S")
    snapshot_field_mapping = build_snapshot_field_mapping(defaults)
    all_snapshot_rows: List[Dict[str, Any]] = []
    summary_rows: List[Dict[str, Any]] = []
    results: List[Dict[str, Any]] = []
    jqls: List[str] = []

    for specialty in specialties:
        jql = build_regression_verify_jql(project_key, str(args.history_reporter or "").strip(), specialty)
        jqls.append(jql)
        logger.info("回归验证模式: project=%s reporter=%s version=%s specialty=%s", project_key, args.history_reporter, current_version, specialty)
        logger.info("专项 %s 使用 JQL: %s", specialty, jql)
        rows = export_jira_snapshot(
            jira,
            regression_rules,
            base_jql=build_regression_base_jql(project_key, f"reporter in ({str(args.history_reporter or '').strip()})"),
            summary_keywords=[MONKEY_SUMMARY_KEYWORD if specialty == "Monkey专项" else STABILITY_SUMMARY_KEYWORD],
            field_mapping=snapshot_field_mapping,
        )
        all_snapshot_rows.extend(rows)

    snapshot_rows = deduplicate_snapshot_rows_by_jira_key(all_snapshot_rows)
    store.save_sync_run({"run_id": run_id, "started_at": datetime.now().isoformat(timespec="seconds"), "jql": "\n".join(jqls), "current_version": current_version})
    store.save_snapshot(run_id, snapshot_rows)
    process_regression_pass_candidates(
        jira_client=jira,
        store=store,
        run_id=run_id,
        current_version=current_version,
        regression_rules=regression_rules,
        snapshot_rows=snapshot_rows,
        matched_jira_keys=set(),
        allowed_specialties=set(specialties),
        args=args,
        results=results,
        summary_rows=summary_rows,
    )
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    result_path = RESULT_DIR / f"transsion_jira_batch_create_result_{timestamp}.json"
    with open(result_path, "w", encoding="utf-8") as fp:
        json.dump(results, fp, ensure_ascii=False, indent=2)
    write_excel_summary(RESULT_DIR / f"transsion_jira_batch_create_summary_{timestamp}.xlsx", summary_rows)
    store.save_sync_run({"run_id": run_id, "finished_at": datetime.now().isoformat(timespec="seconds")})
    failed_count = sum(1 for item in results if item["status"] == "FAILED")
    return 0 if failed_count == 0 else 1
```

```python
def run_batch_create(args: argparse.Namespace) -> int:
    mode = resolve_run_mode(args)
    if mode == "regression_verify":
        return run_regression_verify_mode(args)
    return run_excel_mode(args)
```

- [ ] **Step 4: 跑测试，确认转绿**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_pass.py -q
```

Expected: 回归验证模式测试 PASS，Excel 模式历史测试保持通过。

- [ ] **Step 5: Commit**

```powershell
git add F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\create_transsion_jira_batch_from_excel.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_pass.py
git commit -m "feat(transsion): add regression verify runtime flow"
```

### Task 5: 文档与全量验证

**Files:**
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/readme.txt`
- Modify: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/handoff_transsion_stage2.md`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_generate_transsion_upload_list.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_upload_template_common.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_common.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_batch_entry.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_config.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_matcher.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_pass.py`
- Test: `F:/automation-toolkit/python-tools/stability_Jira-Automation/Transsion_Jira_Tool_20260323/test/test_transsion_regression_store.py`

- [ ] **Step 1: 更新使用文档**

```text
新增“回归验证模式”命令示例：

python create_transsion_jira_batch_from_excel.py ^
  --regression-project X6851OS16 ^
  --regression-specialty 休眠唤醒专项 ^
  --regression-specialty Monkey专项 ^
  --current-version X6851-16.3.0.021(OP001PF001AZ)_SU ^
  --history-reporter dailv.tinno ^
  --jira-username your_user ^
  --jira-password your_password ^
  --dry-run

模式互斥规则：
- 传 --add-excel-file 走 Excel 模式
- 传 --regression-project 走回归验证模式
- 两种模式参数不能同时使用

本地库路径：
- result/regression_cache/<Project>.db
```

- [ ] **Step 2: 跑全量相关测试**

Run:

```powershell
python -m pytest F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_generate_transsion_upload_list.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_upload_template_common.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_common.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_batch_entry.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_config.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_matcher.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_pass.py F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\test\test_transsion_regression_store.py -q
```

Expected: PASS，所有相关测试通过；若有 pytest cache / asyncio warning，可记录但不阻塞。

- [ ] **Step 3: 记录一个 dry-run 手工验收命令**

```powershell
python .\create_transsion_jira_batch_from_excel.py --regression-project X6851OS16 --regression-specialty 休眠唤醒专项 --current-version X6851-16.3.0.021(OP001PF001AZ)_SU --history-reporter dailv.tinno --jira-username <user> --jira-password <password> --dry-run
```

Expected:

```text
回归验证模式
专项 休眠唤醒专项 使用 JQL: project = X6851OS16 AND reporter in (dailv.tinno) AND (summary ~ "【稳定性专项】")
结果已写入: F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\result\transsion_jira_batch_create_result_20260415_120000.json
Excel 摘要已写入: F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\result\transsion_jira_batch_create_summary_20260415_120000.xlsx
```

- [ ] **Step 4: Commit**

```powershell
git add F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\readme.txt F:\automation-toolkit\python-tools\stability_Jira-Automation\Transsion_Jira_Tool_20260323\handoff_transsion_stage2.md
git commit -m "docs(transsion): document regression verify mode"
```

## Self-Review

### Spec coverage

- 模式互斥规则：Task 1
- 新增业务参数：Task 1
- 项目级 SQLite 隔离：Task 2
- JQL 自动构造与多专项逐个处理：Task 3
- 内部保护性过滤与 PASS 判定复用：Task 4
- dry-run 与落库语义：Task 4
- 文档与验收命令：Task 5

### Placeholder scan

- 无 `TODO/TBD/implement later`
- 每个代码步骤均给出目标代码或测试代码
- 每个测试步骤都包含精确命令和预期

### Type consistency

- 模式名称统一使用 `excel` / `regression_verify`
- 新参数统一使用 `regression_project` / `regression_specialties` / `current_version` / `history_reporter`
- SQLite 路由 helper 统一使用 `build_project_scoped_sqlite_path(...)`
