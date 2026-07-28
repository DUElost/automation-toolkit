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


def test_jiexi_block_does_not_leak_into_next_question():
    items = parse_answers_text(FIXTURE)
    marker = "针对有场景触发的问题，测试必须要备注清楚前置条件"
    assert items[1]["stem_raw"] == "由于测试环境产生的bug单，应操作reject（ ）"
    assert marker not in items[1]["stem_raw"]
    for opt in items[1]["options"]:
        assert marker not in opt["text"]
    for item in items:
        assert marker not in item["stem_raw"]
        for opt in item["options"]:
            assert marker not in opt["text"]


def test_parse_full_july_file_has_many_items():
    text = (ROOT / "7月考试.txt").read_text(encoding="utf-8")
    items = parse_answers_text(text)
    assert len(items) >= 50
    assert all(item["answer_texts"] for item in items)


def test_bom_does_not_skip_first_question():
    raw = "\ufeff" + (ROOT / "tests" / "fixtures" / "sample_answers.txt").read_text(encoding="utf-8")
    items = parse_answers_text(raw)
    assert items[0]["stem_raw"].startswith("MTBF")
    assert len(items) == 3


def test_july_file_parses_all_60():
    text = (ROOT / "7月考试.txt").read_text(encoding="utf-8-sig")
    items = parse_answers_text(text)
    assert len(items) == 60
    assert "Bug的未关闭" in items[0]["stem_raw"] or "未关闭前的状态" in items[0]["stem_raw"]
