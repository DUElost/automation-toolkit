import json
import os

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def load_config():
    with open(os.path.join(PROJECT_ROOT, "config.json"), encoding="utf-8") as f:
        return json.load(f)


def test_config_has_14_dropbox_types():
    types = load_config()["dropbox"]["types"]
    assert len(types) == 14
    for t in ("data_app_anr", "data_app_crash", "data_app_native_crash",
              "system_app_anr", "system_app_crash", "system_app_native_crash",
              "system_server_crash", "system_server_native_crash", "system_server_watchdog",
              "system_server_anr", "KERNEL_PANIC", "MODEM_SILENT_PANIC",
              "SUBSYS_SILENT_PANIC", "SYSTEM_TOMBSTONE"):
        assert t in types


def test_monkey_resource_dir():
    config = load_config()
    assert config["monkey"]["resource_dir"] == "tools/monkey"
    for key in ("apk", "android_test_apk", "blacklist", "monkey_script", "aim_jar"):
        assert os.path.isfile(os.path.join(PROJECT_ROOT, config["monkey"]["resource_dir"],
                                           config["monkey"][key]))


def test_dropbox_type_config_keys():
    for t, c in load_config()["dropbox"]["types"].items():
        assert "folder" in c and "name_field" in c
