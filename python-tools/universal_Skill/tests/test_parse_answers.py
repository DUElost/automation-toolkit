# -*- coding: utf-8 -*-
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from parse_answers import parse_answers_text


FIXTURE = (ROOT / "tests" / "fixtures" / "sample_answers.txt").read_text(encoding="utf-8")


def test_parse_single_maps_letter_to_text():
    items = parse_answers_text(FIXTURE)
    assert items[0]["qtype"] == "single"
    assert items[0]["answer_letters"] == ["D"]
    assert items[0]["answer_texts"] == ["20台*7天*24H"]


def test_parse_judge():
    items = parse_answers_text(FIXTURE)
    assert items[1]["qtype"] == "judge"
    assert items[1]["answer_texts"] == ["正确"]


def test_parse_multi():
    items = parse_answers_text(FIXTURE)
    assert items[2]["qtype"] == "multi"
    assert items[2]["answer_letters"] == ["A", "B", "D"]
    assert "电量耗尽" in items[2]["answer_texts"]
    assert "系统内核崩溃" in items[2]["answer_texts"]
    assert "电源管理IC故障" in items[2]["answer_texts"]
    assert len(items[2]["answer_texts"]) == 3


def test_parse_full_july_file_has_many_items():
    text = (ROOT / "7月考试.txt").read_text(encoding="utf-8")
    items = parse_answers_text(text)
    assert len(items) >= 50
    assert all(item["answer_texts"] for item in items)
