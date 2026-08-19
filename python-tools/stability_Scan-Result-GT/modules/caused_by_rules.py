# -*- coding: utf-8 -*-
"""CausedBy / Detail 规则：默认与 ABPS config.xml 对齐，可由 config.json caused_by_rules 覆盖。"""

import copy

# 内置默认（config 未配置或缺字段时回退）
DEFAULT_RULES = {
    "ANR": {
        "extra_tag_keywords": [
            {"tag": "InputDispatchTimeout", "pattern": "Input dispatching timed out"},
            {"tag": "ServiceTimeout", "pattern": "executing service"},
            {"tag": "BroadcastTimeout", "pattern": "Broadcast of Intent"},
            {"tag": "ContentProvider", "pattern": "ContentProvider not responding"},
            {"tag": "ForegroundServiceTimeout",
             "pattern": "did not then call Service.startForeground"},
            {"tag": "FailToCompleteStartTimeout", "pattern": "failed to complete startup"},
            {"tag": "NoResponseTimeout", "pattern": "No response to"},
        ],
    },
    "JE": {
        "am_crash_sources": ["SYS_ANDROID_LOG", "events.log"],
        "ylog_patterns": ["FATAL EXCEPTION", "Caused by:", "am_crash:"],
    },
    "KE": {
        "patterns": ["Native hang monitor trigger", "panic", "killed by signal"],
        "kernel_sources": ["SYS_KERNEL_LOG"],
        "ylog_patterns": ["panic", "Native hang monitor trigger", "killed by signal"],
    },
    "SWT": {
        "patterns": [
            "WATCHDOG KILLING SYSTEM PROCESS",
            "Blocked in",
            "watchdog: Blocked in",
        ],
        "android_log_sources": ["SYS_ANDROID_LOG"],
        "ylog_patterns": [
            "Blocked in", "WATCHDOG KILLING", "WAITED_HALF",
            "Watchdog: WAITED", "watchdog: Blocked in",
        ],
    },
    "NE": {
        "ylog_patterns": [
            "Fatal signal", "backtrace:", "DEBUG   : Native Crash",
        ],
    },
    "FATAL.NE": {
        "ylog_patterns": [
            "Fatal signal", "backtrace:", "DEBUG   : Native Crash",
        ],
    },
    "SR": {
        "ylog_patterns": ["reboot", "bootcause", "RescueParty", "sys.powerctl"],
    },
    "MSP": {
        "ylog_patterns": ["Modem Assert", "Modem Blocked"],
    },
    "SSP": {
        "ylog_patterns": ["SUBSYS_SILENT_PANIC"],
    },
    "Assert": {
        "ylog_patterns": [
            "Modem Assert", "Modem Blocked", "WCN-CP2-EXCEPTION",
            "WCN Assert", "Gnss Assert", "GNSS Assert",
        ],
    },
    "WCN": {
        "ylog_patterns": [
            "Modem Assert", "Modem Blocked", "WCN-CP2-EXCEPTION",
            "WCN Assert", "Gnss Assert", "GNSS Assert", "WCN",
        ],
    },
    "sysinfo": [
        {"kind": "lmk", "pattern": "lowmemorykiller: Kill", "log": "SYS_ANDROID_LOG"},
        {"kind": "lmk", "pattern": "lowmemorykiller: Killing", "log": "SYS_ANDROID_LOG"},
        {"kind": "oom", "pattern": "Out of memory: Killed process", "log": "SYS_KERNEL_LOG"},
        {"kind": "oom", "pattern": "Out of memory: Kill process", "log": "SYS_KERNEL_LOG"},
        {"kind": "io_error", "pattern": "I/O error", "log": "SYS_KERNEL_LOG"},
        {"kind": "io_error", "pattern": "CMD17 Error", "log": "SYS_KERNEL_LOG"},
        {"kind": "io_error", "pattern": "CMD18 Error", "log": "SYS_KERNEL_LOG"},
    ],
    "cpassert_patterns": [
        "Modem Assert", "Modem Blocked", "WCN-CP2-EXCEPTION",
        "WCN Assert", "Gnss Assert", "GNSS Assert",
    ],
}

_active = None


def _deep_merge(base, overrides):
    for key, val in (overrides or {}).items():
        if isinstance(val, dict) and isinstance(base.get(key), dict):
            _deep_merge(base[key], val)
        else:
            base[key] = copy.deepcopy(val)


def merge_rules(overrides=None):
    """合并 config caused_by_rules 与 DEFAULT_RULES。"""
    rules = copy.deepcopy(DEFAULT_RULES)
    _deep_merge(rules, overrides)
    return rules


def set_active_rules(config=None):
    """collect_problems 入口设置当前规则集。"""
    global _active
    overrides = None
    if config:
        overrides = config.get("caused_by_rules")
    _active = merge_rules(overrides)
    return _active


def get_active_rules():
    if _active is None:
        return merge_rules()
    return _active


def anr_subtypes(rules=None):
    rules = rules or get_active_rules()
    return [(x["tag"], x["pattern"])
            for x in rules.get("ANR", {}).get("extra_tag_keywords", [])]


def anr_ylog_patterns(rules=None):
    rules = rules or get_active_rules()
    pats = list(rules.get("ANR", {}).get("ylog_patterns") or [])
    if not pats:
        pats = [p for _, p in anr_subtypes(rules)] + ["am_anr", "ANR in"]
    return pats


def sysinfo_patterns(rules=None):
    rules = rules or get_active_rules()
    out = []
    for item in rules.get("sysinfo", []):
        out.append((item["kind"], item["pattern"], item["log"]))
    return out


def cpassert_patterns(rules=None):
    return list((rules or get_active_rules()).get("cpassert_patterns", []))


def ylog_patterns_for(expclass, rules=None):
    """ExpClass / 逻辑族 → ylog 检索关键字。"""
    from modules.classify import expclass_family
    rules = rules or get_active_rules()
    family = expclass_family(expclass)
    if family == "ANR" or expclass == "ANR":
        return anr_ylog_patterns(rules)
    pats = rules.get(expclass, {}).get("ylog_patterns")
    if not pats:
        pats = rules.get(family, {}).get("ylog_patterns")
    return list(pats or [])
