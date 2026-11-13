#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import sys
import tempfile
import unittest
from pathlib import Path

TOOL_DIR = Path(__file__).resolve().parents[1]
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

import tinno_anr_hold as anr_hold
from tinno_database_manager import DatabaseManager
from tinno_regression_models import load_regression_rules


class TinnoAnrHoldTest(unittest.TestCase):
    def test_is_anr_issue_detects_exp_class_and_summary(self) -> None:
        self.assertTrue(anr_hold.is_anr_issue(exp_class="ANR", summary="x"))
        self.assertTrue(anr_hold.is_anr_issue(exp_class="Java (JE)", summary="发生ANR"))
        self.assertFalse(anr_hold.is_anr_issue(exp_class="Java (JE)", summary="发生Java (JE)"))

    def test_evaluate_anr_hold_keeps_below_threshold_and_releases_at_six(self) -> None:
        current = {
            "affect_project": "PAANX",
            "environment": "*ExpClass:* ANR",
            "exp_class": "ANR",
            "caused_by": "Input dispatching timed out",
        }
        held = [
            {
                "id": 1,
                "affect_project": "PAANX",
                "environment": "*ExpClass:* ANR",
                "exp_class": "ANR",
                "caused_by": "Input dispatching timed out",
                "count": 2,
                "version": "MLD-NX3-Claro-16-261101V1",
            },
            {
                "id": 2,
                "affect_project": "PAANX",
                "environment": "*ExpClass:* ANR",
                "exp_class": "ANR",
                "caused_by": "Input dispatching timed out",
                "count": 2,
                "version": "MLD-NX3-Claro-16-261102V2",
            },
        ]
        below = anr_hold.evaluate_anr_hold(
            current_row=current,
            current_count=1,
            hold_records=held,
            min_submit_count=6,
        )
        self.assertTrue(below.hold)
        self.assertEqual(5, below.cumulative_count)

        release = anr_hold.evaluate_anr_hold(
            current_row=current,
            current_count=2,
            hold_records=held,
            min_submit_count=6,
        )
        self.assertFalse(release.hold)
        self.assertEqual(6, release.cumulative_count)
        self.assertEqual([1, 2], release.matched_record_ids)

    def test_apply_total_number_to_summary(self) -> None:
        summary = "[自动化][P535AA][Total Number 1][MLD-NX3-16-261101V1][MonkeyAEE][ANR]x发生ANR"
        updated = anr_hold.apply_total_number_to_summary(summary, 6)
        self.assertIn("[Total Number 6]", updated)

    def test_database_anr_hold_roundtrip(self) -> None:
        with tempfile.TemporaryDirectory() as temp_dir:
            db_path = Path(temp_dir) / "PAANX.db"
            db = DatabaseManager({"type": "sqlite", "path": str(db_path)})
            try:
                record_id = db.insert_anr_hold_record(
                    {
                        "affect_project": "PAANX",
                        "environment": "*ExpClass:* ANR",
                        "exp_class": "ANR",
                        "caused_by": "Input dispatching timed out",
                        "version": "MLD-NX3-Claro-16-261101V1",
                        "count": 3,
                        "source_file": "a.xls",
                        "row_number": 2,
                        "occurrence_payload": {"summary": "anr"},
                        "processed_at": "2026-11-12T21:00:00",
                    }
                )
                rows = db.list_anr_hold_records()
                self.assertEqual(1, len(rows))
                self.assertEqual(record_id, rows[0]["id"])
                self.assertEqual(3, rows[0]["count"])
                db.delete_anr_hold_records([record_id])
                self.assertEqual([], db.list_anr_hold_records())
            finally:
                db.close()

    def test_regression_rules_load_anr_hold_section(self) -> None:
        rules = load_regression_rules(TOOL_DIR / "config" / "regression_rules.json")
        self.assertTrue(rules.anr_hold.enabled)
        self.assertEqual(6, rules.anr_hold.min_submit_count)
        self.assertEqual(["ANR"], rules.anr_hold.exp_class_keywords)


if __name__ == "__main__":
    unittest.main()
