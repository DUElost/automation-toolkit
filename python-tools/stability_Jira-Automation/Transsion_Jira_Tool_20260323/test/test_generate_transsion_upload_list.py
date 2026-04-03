from __future__ import annotations

import importlib
import sys
from pathlib import Path
from typing import Generator

import pandas as pd
import pytest


PROJECT_ROOT = Path(__file__).resolve().parents[1]
MODULE_DIR = PROJECT_ROOT


@pytest.fixture
def generate_module() -> Generator[object, None, None]:
    module_name = "generate_transsion_jira_upload_list"
    original_path = list(sys.path)
    original_module = sys.modules.get(module_name)
    sys.modules.pop(module_name, None)
    try:
        if str(MODULE_DIR) not in sys.path:
            sys.path.insert(0, str(MODULE_DIR))
        yield importlib.import_module(module_name)
    finally:
        if original_module is None:
            sys.modules.pop(module_name, None)
        else:
            sys.modules[module_name] = original_module
        sys.path[:] = original_path


def test_save_upload_list_keeps_caused_by_column(tmp_path: Path, generate_module):
    module = generate_module
    output_path = tmp_path / "upload.xlsx"

    module.save_upload_list(
        [
            {
                "Project": "X6851OS16",
                "Issue Type": "故障",
                "Summary": "summary",
                "CausedBy": "Input dispatching timed out",
            }
        ],
        str(output_path),
    )

    df = pd.read_excel(output_path, engine="openpyxl")

    assert "CausedBy" in df.columns
    assert df.loc[0, "CausedBy"] == "Input dispatching timed out"
