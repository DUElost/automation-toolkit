# -*- coding: utf-8 -*-
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from exam_bot import extract_exam_id, to_study_exam_url


def test_extract_id_from_ceping_share():
    url = "https://tinno.m.moxueyuan.com/task/ceping?id=7720452&_requestFrom=share_redirect"
    assert extract_exam_id(url) == "7720452"


def test_normalize_ceping_to_study_questions():
    url = "https://tinno.m.moxueyuan.com/task/ceping?id=7720452&_requestFrom=share_redirect"
    assert (
        to_study_exam_url(url)
        == "https://tinno.study.moxueyuan.com/task/exam/questions/7720452"
    )


def test_study_questions_url_unchanged_target():
    url = "https://tinno.study.moxueyuan.com/task/exam/questions/7720452?resource_relation="
    assert to_study_exam_url(url).startswith(
        "https://tinno.study.moxueyuan.com/task/exam/questions/7720452"
    )
