import json
import sys
import unittest
from pathlib import Path
from types import SimpleNamespace

TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from retro_patch_tinno_labels import (
    build_search_jql,
    collect_issue_records,
    execute_label_patch,
    plan_issue_labels,
)


def _monkey_summary() -> str:
    return (
        "[自动化][V551A][Total Number 7][V551A-15-250905V60][MonkeyAEE]"
        "[Java (JE)]com.android.settings发生Java (JE)"
    )


def _mtbf_summary() -> str:
    return (
        "[自动化][V552AA][Total Number 6][MLD-LX2-16-260523V6][MTBF]"
        "[Java (JE)]com.android.settings发生Java (JE)"
    )


class _FakeJiraClient:
    def __init__(self, issue_payloads=None, search_results=None) -> None:
        self.issue_payloads = issue_payloads or {}
        self.search_results = search_results or []
        self.updated = []
        self.fail_keys = set()

    def get_issue(self, issue_key: str):
        return self.issue_payloads.get(issue_key, {"key": issue_key, "fields": {}})

    def search_issues(self, jql: str, maxResults: int = 50, fields: str = "*all"):  # noqa: N803
        self.last_jql = jql
        return self.search_results

    def update_issue(self, issue_key: str, fields):
        if issue_key in self.fail_keys:
            raise RuntimeError("boom")
        self.updated.append((issue_key, fields))
        return {}


class RetroPatchTinnoLabelsTest(unittest.TestCase):
    def setUp(self) -> None:
        defaults_path = TOOL_DIR / "config" / "tinno_jira_defaults.json"
        with defaults_path.open("r", encoding="utf-8") as fp:
            self.defaults = json.load(fp)

    # ---------- plan_issue_labels ----------

    def test_plan_no_change_when_specialty_and_fixed_already_present(self) -> None:
        plan = plan_issue_labels("VCAME-1", _monkey_summary(), ["MonkeyAEE", "稳定性测试"], self.defaults)
        self.assertEqual("NO_CHANGE", plan["action"])
        self.assertEqual(["MonkeyAEE", "稳定性测试"], plan["new_labels"])

    def test_plan_adds_fixed_label_only_for_monkey_issue(self) -> None:
        plan = plan_issue_labels("VCAME-2", _monkey_summary(), ["MonkeyAEE"], self.defaults)
        self.assertEqual("ADD_LABELS", plan["action"])
        self.assertEqual(["MonkeyAEE", "稳定性测试"], plan["new_labels"])
        self.assertEqual(["稳定性测试"], plan["added"])
        self.assertEqual([], plan["removed"])

    def test_plan_replaces_legacy_default_when_summary_specialty_differs(self) -> None:
        plan = plan_issue_labels("VCAME-3", _mtbf_summary(), ["MonkeyAEE"], self.defaults)
        self.assertEqual("FIX_LEGACY", plan["action"])
        self.assertEqual(["MTBF", "稳定性测试"], plan["new_labels"])
        self.assertEqual(["MonkeyAEE"], plan["removed"])
        self.assertEqual(["MTBF", "稳定性测试"], plan["added"])

    def test_plan_append_mode_when_cleanup_disabled(self) -> None:
        plan = plan_issue_labels("VCAME-4", _mtbf_summary(), ["MonkeyAEE"], self.defaults, cleanup_legacy=False)
        self.assertEqual("ADD_LABELS", plan["action"])
        self.assertEqual(["MonkeyAEE", "MTBF", "稳定性测试"], plan["new_labels"])
        self.assertEqual([], plan["removed"])

    def test_plan_keeps_extra_manual_labels_and_never_replaces_them(self) -> None:
        plan = plan_issue_labels("VCAME-5", _mtbf_summary(), ["MonkeyAEE", "紧急"], self.defaults)
        self.assertEqual("ADD_LABELS", plan["action"])
        self.assertEqual(["MonkeyAEE", "紧急", "MTBF", "稳定性测试"], plan["new_labels"])
        self.assertEqual([], plan["removed"])

    def test_plan_adds_fixed_only_when_specialty_unrecognized(self) -> None:
        plan = plan_issue_labels("VCAME-6", "手工单标题", ["自维护"], self.defaults)
        self.assertEqual("ADD_LABELS", plan["action"])
        self.assertEqual(["自维护", "稳定性测试"], plan["new_labels"])

    def test_plan_falls_back_to_builtin_fixed_labels_when_config_missing(self) -> None:
        defaults = {"labels": ["MonkeyAEE"]}
        plan = plan_issue_labels("VCAME-7", _mtbf_summary(), ["MonkeyAEE"], defaults)
        self.assertEqual(["MTBF", "稳定性测试"], plan["new_labels"])

    def test_plan_case_insensitive_duplicate_fixed_label(self) -> None:
        defaults = {"labels": ["MonkeyAEE"], "fixed_labels": ["Stability"]}
        plan = plan_issue_labels("VCAME-8", _monkey_summary(), ["stability", "monkeyaee"], defaults)
        self.assertEqual("NO_CHANGE", plan["action"])

    def test_plan_rejects_summary_token_not_in_known_whitelist(self) -> None:
        # 其它自动化系统借用相同结构，第 5 段是计数而非专项：不得当作专项
        summary = "[自动化][V552AA][Total Number 1][VVTB35.41-1][62次][ANR]x发生ANR"
        plan = plan_issue_labels("VFFCA-9", summary, ["MonkeyAEE"], self.defaults)
        self.assertEqual("", plan["specialty"])
        self.assertEqual("ADD_LABELS", plan["action"])
        self.assertEqual(["MonkeyAEE", "稳定性测试"], plan["new_labels"])
        self.assertEqual([], plan["removed"])

    def test_plan_maps_specialty_name_token_to_label(self) -> None:
        summary = "[自动化][V552AA][Total Number 1][VVTB35.41-1][Monkey专项][ANR]x发生ANR"
        plan = plan_issue_labels("VFFCA-8", summary, [], self.defaults)
        self.assertEqual("MonkeyAEE", plan["specialty"])
        self.assertEqual(["MonkeyAEE", "稳定性测试"], plan["new_labels"])

    # ---------- build_search_jql ----------

    def test_build_search_jql_defaults_to_automation_only(self) -> None:
        args = SimpleNamespace(
            jql=None, project="VCAME", reporter=None, status=None,
            specialty_token=None, include_non_auto=False,
        )
        jql = build_search_jql(args, self.defaults)
        self.assertEqual('project = VCAME AND (summary ~ "\\\\[自动化\\\\]")', jql)

    def test_build_search_jql_supports_filters_and_override(self) -> None:
        base_args = dict(
            jql=None, project=None, reporter="dai.lv", status="Open",
            specialty_token="MTBF", include_non_auto=True, exclude_status=[],
        )
        jql = build_search_jql(SimpleNamespace(**base_args), self.defaults)
        self.assertEqual(
            'project = VCAME AND reporter in (dai.lv) AND status = "Open" AND (summary ~ "\\\\[MTBF\\\\]")',
            jql,
        )

        exclude_args = dict(
            jql=None, project="VFFCA", reporter=None, status=None,
            specialty_token=None, include_non_auto=False, exclude_status=["Closed"],
        )
        jql = build_search_jql(SimpleNamespace(**exclude_args), self.defaults)
        self.assertIn('status != "Closed"', jql)

        both_args = dict(
            jql=None, project="VFFCA", reporter=None, status=None,
            specialty_token="MTBF", include_non_auto=False, exclude_status=[],
        )
        jql = build_search_jql(SimpleNamespace(**both_args), self.defaults)
        self.assertIn("自动化", jql)
        self.assertIn("MTBF", jql)
        self.assertEqual(2, jql.count(" AND (summary ~ "), jql)

        jql = build_search_jql(SimpleNamespace(jql='project = X', project=None, reporter=None, status=None, specialty_token=None, include_non_auto=False, exclude_status=[]), self.defaults)
        self.assertEqual('project = X', jql)

    # ---------- collect_issue_records ----------

    def test_collect_issue_records_by_keys(self) -> None:
        client = _FakeJiraClient(
            issue_payloads={
                "VCAME-1": {"key": "VCAME-1", "fields": {"summary": _monkey_summary(), "labels": ["MonkeyAEE"]}},
            }
        )
        args = SimpleNamespace(issue_keys=["VCAME-1"], jql=None, project=None, reporter=None, status=None, specialty_token=None, include_non_auto=False, max_issues=500)
        records = collect_issue_records(client, args, self.defaults)
        self.assertEqual(1, len(records))
        self.assertEqual("VCAME-1", records[0]["issue_key"])
        self.assertEqual(["MonkeyAEE"], records[0]["labels"])

    def test_collect_issue_records_via_search(self) -> None:
        client = _FakeJiraClient(
            search_results=[
                SimpleNamespace(key="VCAME-2", fields=SimpleNamespace(summary=_mtbf_summary(), labels=["MonkeyAEE"])),
            ]
        )
        args = SimpleNamespace(issue_keys=[], jql=None, project="VCAME", reporter=None, status=None, specialty_token=None, include_non_auto=False, max_issues=10)
        records = collect_issue_records(client, args, self.defaults)
        self.assertEqual(1, len(records))
        self.assertTrue(client.last_jql.startswith("project = VCAME AND "))
        self.assertIn("自动化", client.last_jql)

    # ---------- execute_label_patch ----------

    def test_execute_dry_run_does_not_update(self) -> None:
        plan = plan_issue_labels("VCAME-3", _mtbf_summary(), ["MonkeyAEE"], self.defaults)
        client = _FakeJiraClient()
        results = execute_label_patch(client, [plan], dry_run=True, wait_seconds=0, sleep_fn=None)
        self.assertEqual("DRY_RUN", results[0]["status"])
        self.assertEqual([], client.updated)

    def test_execute_updates_and_skips_no_change(self) -> None:
        plans = [
            plan_issue_labels("VCAME-3", _mtbf_summary(), ["MonkeyAEE"], self.defaults),
            plan_issue_labels("VCAME-1", _monkey_summary(), ["MonkeyAEE", "稳定性测试"], self.defaults),
        ]
        client = _FakeJiraClient()
        results = execute_label_patch(client, plans, dry_run=False, wait_seconds=0, sleep_fn=None)
        self.assertEqual("UPDATED", results[0]["status"])
        self.assertEqual("NO_CHANGE", results[1]["status"])
        self.assertEqual(1, len(client.updated))
        self.assertEqual((("VCAME-3"), {"labels": ["MTBF", "稳定性测试"]}), client.updated[0])

    def test_execute_records_failure(self) -> None:
        plan = plan_issue_labels("VCAME-3", _mtbf_summary(), ["MonkeyAEE"], self.defaults)
        client = _FakeJiraClient()
        client.fail_keys = {"VCAME-3"}
        results = execute_label_patch(client, [plan], dry_run=False, wait_seconds=0, sleep_fn=None)
        self.assertEqual("FAILED", results[0]["status"])
        self.assertIn("boom", results[0]["error"])


if __name__ == "__main__":
    unittest.main()
