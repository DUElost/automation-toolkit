# -*- coding: utf-8 -*-
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "scripts"))

from qr_decode import decode_qr


def test_decode_exam_entry_qr():
    # Prefer ASCII copy; fall back to data/exam_qr.png
    candidates = [
        ROOT / "exam_entry_qr.png",
        ROOT / "data" / "exam_qr.png",
    ]
    image = next((p for p in candidates if p.is_file()), None)
    assert image is not None, "exam_entry_qr.png or data/exam_qr.png required"
    url = decode_qr(image)
    assert url.startswith("http")
    assert "7720452" in url or "moxueyuan.com" in url
