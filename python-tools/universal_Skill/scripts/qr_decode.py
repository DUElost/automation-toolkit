# -*- coding: utf-8 -*-
"""Decode exam entry URL from a QR code image."""
from __future__ import annotations

import argparse
import sys
from pathlib import Path
from typing import Optional


def decode_qr(image_path: Path) -> str:
    """Return URL/text embedded in the QR image.

    Raises:
        FileNotFoundError: image missing
        RuntimeError: OpenCV missing or QR not detected
    """
    path = Path(image_path)
    if not path.is_file():
        raise FileNotFoundError(f"QR image not found: {path}")

    try:
        import cv2
    except ImportError as e:
        raise RuntimeError(
            "opencv-python-headless is required for QR decode. "
            "Install: pip install opencv-python-headless"
        ) from e

    img = cv2.imread(str(path))
    if img is None:
        raise RuntimeError(f"Failed to read image: {path}")

    detector = cv2.QRCodeDetector()
    data, points, _ = detector.detectAndDecode(img)
    if not data or points is None:
        raise RuntimeError(f"No QR code detected in: {path}")

    text = str(data).strip()
    if not text:
        raise RuntimeError(f"QR code is empty in: {path}")
    return text


def main(argv: Optional[list] = None) -> int:
    parser = argparse.ArgumentParser(description="Decode moxueyuan exam QR image")
    parser.add_argument("--image", required=True, help="Path to QR code image")
    args = parser.parse_args(argv)
    try:
        url = decode_qr(Path(args.image))
    except Exception as e:
        print(f"ERROR: {e}", file=sys.stderr)
        return 1
    print(url)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
