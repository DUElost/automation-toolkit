# -*- coding: utf-8 -*-
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from matching import normalize_text, match_stem, match_options_by_text


def test_normalize_strips_number_and_spaces():
    assert normalize_text("12.  hello，世界") == normalize_text("hello世界")


def test_match_stem_ignores_order():
    bank = [
        {"stem": normalize_text("MTBF的测试周期是什么"), "id": 1},
        {"stem": normalize_text("样机不支持某项功能"), "id": 2},
    ]
    hit = match_stem("【稳定性测试】MTBF的测试周期是什么？", bank, threshold=0.72)
    assert hit is not None
    assert hit["id"] == 1


def test_match_options_by_text_ignores_letters():
    page_options = [
        {"letter": "A", "text": "Wi-Fi连接不稳定", "locator_hint": 0},
        {"letter": "B", "text": "死机", "locator_hint": 1},
        {"letter": "C", "text": "重启", "locator_hint": 2},
    ]
    idxs = match_options_by_text(["死机"], page_options, threshold=0.9)
    assert idxs == [1]


def test_match_stem_ambiguous_returns_none():
    # Identical stems force gap=0 so match_stem returns None (ambiguous).
    same = normalize_text("关于MTBF测项的通过标准描述")
    bank = [
        {"stem": same, "id": 1},
        {"stem": same, "id": 2},
    ]
    hit = match_stem("关于MTBF测项的通过标准描述正确的是", bank, threshold=0.5, min_gap=0.05)
    assert hit is None  # ambiguous
