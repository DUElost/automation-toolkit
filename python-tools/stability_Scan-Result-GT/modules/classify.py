# -*- coding: utf-8 -*-
"""ExpClass 分类映射（spec 决策表）。

输入为问题包的 ExpType（dropbox 类型名或 uniview event_name），输出官方分类
（ANR/JE/NE/SWT/KE/SR/Jank/Assert/WCN/MSP/SSP）。未知类型返回原样。
"""

import json
import os

_CONFIG_PATH = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "config.json")


def load_expclass_map(config=None):
    if config is None:
        with open(_CONFIG_PATH, encoding="utf-8") as f:
            config = json.load(f)
    return config["expclass_map"]


def classify(exp_type, expclass_map=None):
    """dropbox 类型/event_name -> ExpClass；未知类型返回 exp_type 原样。"""
    if expclass_map is None:
        expclass_map = load_expclass_map()
    return expclass_map.get(exp_type, exp_type)


_NE_FAMILY = frozenset({"NE", "FATAL.NE"})


def is_ne_family(expclass):
    """ExpClass 是否属于 Native 崩溃族（含 uniview FATAL.NE）。"""
    return expclass in _NE_FAMILY


def expclass_family(expclass):
    """ExpClass → 提取/去重逻辑族（FATAL.NE 与 NE 同族，报表 ExpClass 仍区分）。"""
    if expclass in _NE_FAMILY:
        return "NE"
    return expclass
