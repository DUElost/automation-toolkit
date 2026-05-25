# -*- coding: utf-8 -*-
from pathlib import Path
from types import SimpleNamespace

import pytest

import itms_create_task.workflow as workflow
from itms_create_task.config_loader import load_manpower_config
from itms_create_task.discovery import ManpowerCaptureDiscovery


def test_load_manpower_config_resolves_runtime_paths(tmp_path):
    config_path = tmp_path / "manpower.json"
    config_path.write_text(
        """
        {
          "base_url": "http://itms.tinno.com",
          "entry_url": "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy",
          "page_name": "我的预估任务管理",
          "browser": {
            "storage_state_path": ".runtime/itms_storage_state.json"
          },
          "capture": {
            "discovery_output_path": ".runtime/manpower_task_capture.json",
            "candidate_output_path": ".runtime/manpower_task_candidate.json",
            "create_keywords": ["manpower", "submit"]
          }
        }
        """,
        encoding="utf-8",
    )

    config = load_manpower_config(str(config_path))

    assert config.entry_url.endswith("tab=taskhrmy")
    assert config.page_name == "我的预估任务管理"
    assert Path(config.browser.storage_state_path).is_absolute()
    assert Path(config.capture.discovery_output_path).is_absolute()
    assert Path(config.capture.candidate_output_path).is_absolute()
    assert config.capture.create_keywords == ["manpower", "submit"]


def test_select_candidate_prefers_last_matching_request():
    config = SimpleNamespace(
        capture=SimpleNamespace(create_keywords=["manpower", "submit"]),
    )
    discovery = ManpowerCaptureDiscovery(config, auth_manager=None)
    captures = [
        {
            "method": "POST",
            "url": "http://itms.tinno.com/api/manpower/task/save",
            "request_headers": {"content-type": "application/json"},
            "post_data": '{"name":"draft"}',
        },
        {
            "method": "POST",
            "url": "http://itms.tinno.com/api/manpower/task/submit",
            "request_headers": {"content-type": "application/json"},
            "post_data": '{"name":"final"}',
        },
    ]

    candidate = discovery._select_candidate(captures)

    assert candidate["url"].endswith("/submit")
    assert candidate["body_sample"] == {"name": "final"}


def test_build_parser_supports_discover_manpower():
    parser = workflow.build_parser()
    args = parser.parse_args(["discover-manpower", "--config", "examples/manpower_config.example.json"])

    assert args.command == "discover-manpower"


def test_main_dispatches_discover_manpower(monkeypatch):
    events = []

    class DummyDiscovery:
        def __init__(self, config, auth_manager):
            events.append(("init", config.entry_url))

        def record_manual_flow(self):
            events.append(("record", True))
            return {"candidate_request": {"url": "http://itms.tinno.com/api/manpower/task/submit"}}

    monkeypatch.setattr(workflow, "setup_logging", lambda: None)
    monkeypatch.setattr(
        workflow,
        "load_manpower_config",
        lambda path: SimpleNamespace(entry_url="http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy"),
    )
    monkeypatch.setattr(workflow, "ItmsAuthManager", lambda config: object())
    monkeypatch.setattr(workflow, "ManpowerCaptureDiscovery", DummyDiscovery)
    monkeypatch.setattr(
        workflow.sys,
        "argv",
        ["main.py", "discover-manpower", "--config", "examples/manpower_config.example.json"],
    )

    assert workflow.main() == 0
    assert events == [
        ("init", "http://itms.tinno.com/#/manpowerhub/manpower/task?tab=taskhrmy"),
        ("record", True),
    ]


def test_readme_mentions_discover_manpower():
    readme = Path(__file__).resolve().parents[1] / "README.md"
    content = readme.read_text(encoding="utf-8")

    assert "discover-manpower" in content
    assert "manpower_config.example.json" in content
    assert "manpower_task_capture.json" in content
