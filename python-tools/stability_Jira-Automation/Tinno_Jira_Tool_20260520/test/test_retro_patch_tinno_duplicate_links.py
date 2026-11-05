#!/usr/bin/env python3
# -*- coding: utf-8 -*-
from __future__ import annotations

import unittest
from collections import Counter
from pathlib import Path
import sys

CURRENT_DIR = Path(__file__).resolve().parents[1]
if str(CURRENT_DIR) not in sys.path:
    sys.path.insert(0, str(CURRENT_DIR))

import retro_patch_tinno_duplicate_links as module


class RetroPatchTinnoDuplicateLinksTest(unittest.TestCase):
    def test_extract_issue_keys_from_text_filters_allowlist(self) -> None:
        text = "跟 PFDFAA-1776 重复，也提到过 VCAME-1 和 abc-2"
        keys = module.extract_issue_keys_from_text(text, ["PFDFAA", "PAANX"])
        self.assertEqual(["PFDFAA-1776"], keys)

    def test_extract_issue_key_after_chinese_without_word_boundary(self) -> None:
        keys = module.extract_issue_keys_from_text("跟随主单PFDFAA-1736", ["PFDFAA"])
        self.assertEqual(["PFDFAA-1736"], keys)

    def test_extract_explicit_main_patterns(self) -> None:
        cases = [
            ("跟随主单PFDFAA-1736", "PFDFAA-1736"),
            ("跟随主单[PFDFAA-1776] [自动化]...", "PFDFAA-1776"),
            ("重复提交  主单是https://jira.tinno.com/browse/PFDFAA-1776", "PFDFAA-1776"),
            ("重复问题：PFDFAA-1000 请处理", "PFDFAA-1000"),
            ("跟随https://jira.tinno.com/browse/PFDFAA-1000", "PFDFAA-1000"),
            ("同PFDFAA-920", "PFDFAA-920"),
            ("同PFDFAA-1776单子", "PFDFAA-1776"),
            ("同步跟踪PFDFAA-920 进展", "PFDFAA-920"),
            ("同步跟踪 PFDFAA-920进展", "PFDFAA-920"),
        ]
        for body, expected in cases:
            keys = module.extract_explicit_main_keys_from_text(
                body, self_key="PFDFAA-9999", project_allowlist=["PFDFAA"]
            )
            self.assertEqual([expected], keys, body)

    def test_sibling_mention_is_not_explicit_main(self) -> None:
        body = "与 PFDFAA-1780/1782（设备 72）是同一类泄漏模型"
        keys = module.extract_explicit_main_keys_from_text(
            body, self_key="PFDFAA-1779", project_allowlist=["PFDFAA"]
        )
        self.assertEqual([], keys)

    def test_different_prefix_is_not_tong_main(self) -> None:
        body = "不同PFDFAA-920的根因，需另开单"
        keys = module.extract_explicit_main_keys_from_text(
            body, self_key="PFDFAA-1767", project_allowlist=["PFDFAA"]
        )
        self.assertEqual([], keys)

    def test_extract_issue_keys_from_comments_prefers_explicit(self) -> None:
        comments = [
            {"body": "*Reporter:* dai.lv\n*Version:* MLD-NX3-16-261020V38\n*Path:* x"},
            {"body": "与 PFDFAA-1780 是同一类泄漏"},
            {"body": "跟随主单PFDFAA-1736"},
        ]
        mentioned, counts, explicit = module.extract_issue_keys_from_comments(
            comments,
            self_key="PFDFAA-1779",
            project_allowlist=["PFDFAA"],
        )
        self.assertEqual(["PFDFAA-1736"], explicit)
        self.assertIn("PFDFAA-1780", mentioned)
        self.assertEqual(1, counts["PFDFAA-1780"])

    def test_choose_main_candidate_actions(self) -> None:
        explicit = module.choose_main_candidate(
            ["PFDFAA-1780"],
            Counter({"PFDFAA-1780": 1}),
            explicit_mains=["PFDFAA-1736"],
        )
        self.assertEqual("AUTO_LINK", explicit["action"])
        self.assertEqual("PFDFAA-1736", explicit["main_key"])

        review = module.choose_main_candidate(
            ["PFDFAA-1780", "PFDFAA-1782"],
            Counter({"PFDFAA-1780": 1, "PFDFAA-1782": 1}),
        )
        self.assertEqual("NEED_REVIEW", review["action"])
        self.assertIn("无显式主单句式", review["reason"])

        empty = module.choose_main_candidate([], Counter())
        self.assertEqual("NO_CANDIDATE", empty["action"])

    def test_has_duplicate_link_or_custom_field(self) -> None:
        has_main, linked = module.has_duplicate_link_or_custom_field(
            {
                "issuelinks": [
                    {
                        "type": {"name": "Duplicate", "inward": "is duplicated by", "outward": "duplicates"},
                        "outwardIssue": {"key": "PFDFAA-1"},
                    }
                ]
            }
        )
        self.assertTrue(has_main)
        self.assertEqual(["PFDFAA-1"], linked)

        has_main, linked = module.has_duplicate_link_or_custom_field(
            {"issuelinks": [{"type": {"name": "Blocks"}, "outwardIssue": {"key": "PFDFAA-920"}}]}
        )
        self.assertFalse(has_main)
        self.assertEqual([], linked)


if __name__ == "__main__":
    unittest.main()
