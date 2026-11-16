# -*- coding: utf-8 -*-
"""归因契约测试：两套工具共用同一份 b8-g8-attribution-v1。"""

from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path

import pandas as pd

TOOL_DIR = Path(__file__).resolve().parents[1]
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

import jira_attribution as attr

CONTRACT_PATH = TOOL_DIR.parent / "contracts" / "attribution-contract-v1.json"
SIBLING_TOOL = "Tinno_Jira_Tool_20260520" if TOOL_DIR.name.startswith("Transsion") else "Transsion_Jira_Tool_20260323"


def _manifest() -> dict:
    return {
        "schema": "stp.jira_delivery_input/v1",
        "plan_run_id": 1096,
        "root_plan_run_id": 1085,
        "platform": "mtk",
        "delivery_version_id": 4,
        "delivery_version_no": 2,
        "issue_ids": [7, 8],
        "event_ids": ["dle-1", "dle-2"],
        "issues": [
            {"signature_id": 7, "occurrence_ids": [101, 102, 103]},
            {"signature_id": 8, "occurrence_ids": [201]},
        ],
        "attribution_candidates": [
            {"signature_id": 7, "occurrence_id": 101, "occurrence_key": "key-101", "dle_id": "dle-1", "serial": "S1"},
            {"signature_id": 7, "occurrence_id": 102, "occurrence_key": "key-102", "dle_id": "dle-1", "serial": "S1"},
            {"signature_id": 7, "occurrence_id": 103, "occurrence_key": "key-103", "dle_id": "dle-2", "serial": "S2"},
            {"signature_id": 8, "occurrence_id": 201, "occurrence_key": "key-201", "dle_id": "dle-2", "serial": "S2"},
        ],
    }


class AttributionContractTest(unittest.TestCase):
    def setUp(self) -> None:
        self.index = attr.ManifestIndex(_manifest())
        self.temp_dir = tempfile.TemporaryDirectory()
        self.workspace = Path(self.temp_dir.name)

    def tearDown(self) -> None:
        self.temp_dir.cleanup()

    def test_contract_version_matches_shared_contract(self) -> None:
        contract = json.loads(CONTRACT_PATH.read_text(encoding="utf-8"))
        self.assertEqual(contract["contract"], attr.CONTRACT_VERSION)
        self.assertEqual(contract["artifact"]["schema"], attr.ARTIFACT_SCHEMA)
        self.assertEqual(contract["platform_manifest_schema"], attr.MANIFEST_SCHEMA)

    def test_sibling_tool_implementation_is_identical(self) -> None:
        sibling = TOOL_DIR.parent / SIBLING_TOOL / "jira_attribution.py"
        if not sibling.is_file():
            self.skipTest("sibling tool not checked out")
        own_lines = [
            line for line in (TOOL_DIR / "jira_attribution.py").read_text(encoding="utf-8").splitlines()
            if "TOOL_NAME =" not in line
        ]
        sibling_lines = [
            line for line in sibling.read_text(encoding="utf-8").splitlines()
            if "TOOL_NAME =" not in line
        ]
        self.assertEqual(own_lines, sibling_lines)

    def test_resolve_rejects_missing_invalid_unknown_and_out_of_scope(self) -> None:
        cases = [
            ("", None, attr.STATUS_MISSING_SIGNATURE_ID),
            ("abc", None, attr.STATUS_INVALID_SIGNATURE_ID),
            (99, None, attr.STATUS_UNKNOWN_SIGNATURE_ID),
            (7, "[101,999]", attr.STATUS_OUT_OF_SCOPE_OCCURRENCE_ID),
            (7, "[101,x]", attr.STATUS_INVALID_OCCURRENCE_ID),
        ]
        for signature, occurrence_ids, expected in cases:
            with self.subTest(signature=signature, occurrence_ids=occurrence_ids):
                resolution = self.index.resolve(signature, occurrence_ids, workbook_row=2)
                self.assertEqual(expected, resolution.status)
                self.assertEqual([], resolution.occurrence_ids)

    def test_resolve_dedupes_repeated_occurrence_and_records_gap(self) -> None:
        resolution = self.index.resolve(7, "[101,101,102]", workbook_row=2)
        self.assertEqual(attr.STATUS_OK, resolution.status)
        self.assertEqual([101, 102], resolution.occurrence_ids)
        self.assertEqual([101], resolution.duplicate_ids)
        rows, items, gaps = attr.annotate_rows(
            [{"_raw_signature": 7, "_raw_occurrence_ids": "[101,101,102]", "_excel_row": 2, "Count": 2}],
            self.index,
        )
        self.assertEqual(1, len(items))
        self.assertEqual("duplicate_occurrence_id", gaps[0]["kind"])

    def test_multi_occurrence_item_keeps_full_set_after_reorder_and_filter(self) -> None:
        rows = [
            {"_raw_signature": 7, "_raw_occurrence_ids": "[101,102,103]", "_excel_row": 2, "Count": 3, "Summary": "issue-7"},
            {"_raw_signature": 8, "_raw_occurrence_ids": "[201]", "_excel_row": 3, "Count": 1, "Summary": "issue-8"},
        ]
        rows, items, gaps = attr.annotate_rows(rows, self.index)
        self.assertEqual([], gaps)
        self.assertEqual([101, 102, 103], items[0]["occurrence_ids"])
        frame = pd.DataFrame(rows)
        reordered = frame.iloc[::-1].reset_index(drop=True)
        filtered = reordered[reordered["Summary"] == "issue-7"].iloc[0]
        self.assertEqual(7, int(filtered["Signature ID"]))
        self.assertEqual([101, 102, 103], json.loads(filtered["Occurrence IDs"]))
        self.assertEqual("OK", filtered["Attribution Status"])

    def test_generator_merges_rows_with_same_signature(self) -> None:
        rows = [
            {"_raw_signature": 7, "_raw_occurrence_ids": "[101,102]", "_excel_row": 2, "Count": 2, "DeviceId": "S1"},
            {"_raw_signature": 7, "_raw_occurrence_ids": "[103]", "_excel_row": 3, "Count": 1, "DeviceId": "S2"},
        ]
        rows, items, gaps = attr.annotate_rows(rows, self.index)
        self.assertEqual(1, len(rows))
        self.assertEqual("MERGED", rows[0]["Attribution Status"])
        self.assertEqual(3, int(rows[0]["Count"]))
        self.assertEqual([101, 102, 103], json.loads(rows[0]["Occurrence IDs"]))
        self.assertEqual([], gaps)

    def test_recorder_links_only_in_scope_occurrences(self) -> None:
        recorder = attr.AttributionRecorder(self.index, workspace=self.workspace, run_id="run-1")
        rows = pd.DataFrame(
            [
                {"Signature ID": "7", "Occurrence IDs": "[101,102]"},
                {"Signature ID": "7", "Occurrence IDs": "[999]"},
                {"Signature ID": "99", "Occurrence IDs": "[]"},
            ]
        )
        resolutions = recorder.prepare(rows)
        recorder.record(resolutions[0], status="SUCCESS", issue_key="MTK-1")
        recorder.record(resolutions[1], status="SUCCESS", issue_key="MTK-2")
        recorder.record(resolutions[2], status="SUCCESS", issue_key="MTK-3")
        payload = recorder.payload()
        self.assertIsNotNone(payload)
        self.assertEqual(
            [(101, "MTK-1"), (102, "MTK-1")],
            [(link["occurrence_id"], link["issue_key"]) for link in payload["links"]],
        )
        kinds = {gap["kind"] for gap in payload["gaps"]}
        self.assertIn("out_of_scope_occurrence_id", kinds)
        self.assertIn("unknown_signature_id", kinds)
        written = recorder.write()
        self.assertTrue(written.is_file())
        on_disk = json.loads(written.read_text(encoding="utf-8"))
        self.assertEqual(attr.ARTIFACT_SCHEMA, on_disk["schema"])
        self.assertEqual(attr.CONTRACT_VERSION, on_disk["contract_version"])
        self.assertEqual(2, len(on_disk["links"]))

    def test_recorder_blocks_duplicate_occurrence_across_items(self) -> None:
        recorder = attr.AttributionRecorder(self.index, workspace=self.workspace, run_id="run-2")
        rows = pd.DataFrame(
            [
                {"Signature ID": "7", "Occurrence IDs": "[101]"},
                {"Signature ID": "7", "Occurrence IDs": "[101]"},
            ]
        )
        resolutions = recorder.prepare(rows)
        self.assertTrue(all(item.blocked for item in resolutions))
        for resolution in resolutions:
            recorder.record(resolution, status="SUCCESS", issue_key="MTK-9")
        payload = recorder.payload()
        self.assertEqual([], payload["links"])
        self.assertTrue(all(gap["kind"] == "duplicate_occurrence_id" for gap in payload["gaps"]))

    def test_generate_stage_payload_records_scope(self) -> None:
        payload = attr.build_payload(
            stage="generate",
            index=self.index,
            items=[],
            links=[],
            gaps=[],
            run_id="gen-1",
            workspace=self.workspace,
        )
        self.assertEqual("generate", payload["stage"])
        self.assertEqual(4, payload["run"]["delivery_version_id"])
        self.assertEqual([7, 8], payload["run"]["issue_ids"])
        self.assertEqual([], payload["links"])

    def test_annotate_rows_records_missing_and_out_of_scope_gaps(self) -> None:
        rows = [
            {"_raw_signature": "", "_raw_occurrence_ids": "", "_excel_row": 2, "Count": 1},
            {"_raw_signature": 7, "_raw_occurrence_ids": "[999]", "_excel_row": 3, "Count": 1},
            {"_raw_signature": 99, "_raw_occurrence_ids": "[]", "_excel_row": 4, "Count": 1},
        ]
        rows, items, gaps = attr.annotate_rows(rows, self.index)
        self.assertEqual(
            ["MISSING_SIGNATURE_ID", "OUT_OF_SCOPE_OCCURRENCE_ID", "UNKNOWN_SIGNATURE_ID"],
            [item["attribution_status"] for item in items],
        )
        self.assertEqual(
            ["missing_signature_id", "out_of_scope_occurrence_id", "unknown_signature_id"],
            [gap["kind"] for gap in gaps],
        )
        self.assertTrue(all(not item["occurrence_ids"] for item in items))
        self.assertEqual([], [row for row in rows if row.get("Occurrence Count")])

    def test_recorder_links_matched_history_key(self) -> None:
        recorder = attr.AttributionRecorder(self.index, workspace=self.workspace, run_id="run-match")
        resolution = recorder.prepare(pd.DataFrame([{"Signature ID": "8", "Occurrence IDs": "[201]"}]))[0]
        recorder.record(resolution, status="SUCCESS", matched_jira_key="MTK-900")
        payload = recorder.payload()
        self.assertEqual(
            [(201, "MTK-900")],
            [(link["occurrence_id"], link["issue_key"]) for link in payload["links"]],
        )
        self.assertEqual("SUCCESS", payload["items"][0]["status"])

    def test_cleared_occurrence_ids_gap_without_manifest_backfill(self) -> None:
        recorder = attr.AttributionRecorder(self.index, workspace=self.workspace, run_id="run-empty")
        rows = pd.DataFrame([{"Signature ID": "7", "Occurrence IDs": ""}])
        resolution = recorder.prepare(rows)[0]
        self.assertEqual(attr.STATUS_EMPTY_OCCURRENCE_IDS, resolution.status)
        self.assertEqual([], resolution.occurrence_ids)
        recorder.record(resolution, status="SUCCESS", issue_key="MTK-EMPTY")
        payload = recorder.payload()
        self.assertEqual([], payload["links"])
        self.assertEqual("empty_occurrence_ids", payload["gaps"][0]["kind"])

    def test_fractional_ids_are_invalid_not_truncated(self) -> None:
        signature = self.index.resolve("7.5", "[101]", occurrence_ids_provided=True, workbook_row=2)
        self.assertEqual(attr.STATUS_INVALID_SIGNATURE_ID, signature.status)
        occurrence = self.index.resolve(7, "[101.5]", occurrence_ids_provided=True, workbook_row=2)
        self.assertEqual(attr.STATUS_INVALID_OCCURRENCE_ID, occurrence.status)
        recorder = attr.AttributionRecorder(self.index, workspace=self.workspace, run_id="run-frac")
        resolutions = recorder.prepare(
            pd.DataFrame(
                [
                    {"Signature ID": "7.5", "Occurrence IDs": "[101]"},
                    {"Signature ID": "7", "Occurrence IDs": "[101.5]"},
                ]
            )
        )
        for resolution in resolutions:
            recorder.record(resolution, status="SUCCESS", issue_key="MTK-FRAC")
        payload = recorder.payload()
        self.assertEqual([], payload["links"])
        self.assertEqual(
            ["invalid_signature_id", "invalid_occurrence_id"],
            [gap["kind"] for gap in payload["gaps"]],
        )

    def test_hidden_row_positions_reads_autofilter(self) -> None:
        from openpyxl import load_workbook

        workbook_path = self.workspace / "hidden.xlsx"
        pd.DataFrame([{"Signature ID": index, "Occurrence IDs": "[]"} for index in range(4)]).to_excel(
            workbook_path, index=False
        )
        workbook = load_workbook(workbook_path)
        sheet = workbook.active
        sheet.auto_filter.ref = sheet.dimensions
        sheet.row_dimensions[3].hidden = True
        workbook.save(workbook_path)
        self.assertEqual({1}, attr.hidden_row_positions(workbook_path))

    def test_filtered_row_has_no_gap_and_no_link(self) -> None:
        recorder = attr.AttributionRecorder(self.index, workspace=self.workspace, run_id="run-filter")
        rows = pd.DataFrame(
            [
                {"Signature ID": "7", "Occurrence IDs": "[101]"},
                {"Signature ID": "7", "Occurrence IDs": ""},
            ]
        )
        resolutions = recorder.prepare(rows, filtered_positions={1})
        recorder.record(resolutions[0], status="SUCCESS", issue_key="MTK-KEEP")
        recorder.record(resolutions[1], status="SKIPPED", error="autofilter_hidden")
        payload = recorder.payload()
        self.assertEqual([101], [link["occurrence_id"] for link in payload["links"]])
        self.assertEqual([], payload["gaps"])
        self.assertTrue(payload["items"][1]["filtered"])

    def test_legacy_workspace_keeps_result_dir(self) -> None:
        default_result = Path("/tmp/tool/result")
        workspace, result_dir, mode = attr.resolve_workspace(None, None, default_result)
        self.assertFalse(mode)
        self.assertEqual(default_result, result_dir)
        self.assertEqual(default_result.parent, workspace)


if __name__ == "__main__":
    unittest.main()
