# -*- coding: utf-8 -*-
"""从 dbg.DEC 目录解析设备 Rom+Ram 市场 SKU（如 256GB+8GB）。"""
import os
import re
from typing import Dict, Optional, Tuple

SERIAL_COMBO_PATTERN = re.compile(
    r"(\d+)\s*G(?:B)?\s*\+\s*(\d+)\s*G(?:B)?",
    re.IGNORECASE,
)
BOOT_MEM_RAM_PATTERN = re.compile(r"LPDDR[^_]*_(\d+)", re.IGNORECASE)
BOOT_MEM_ROM_PATTERN = re.compile(r"EMMC_(\d+)", re.IGNORECASE)
PROPERTY_LINE_PATTERN = re.compile(r"^\[(?P<key>[^\]]+)\]:\s*\[(?P<value>.*)\]\s*$")
ANDROID_BOOT_LINE_PATTERN = re.compile(
    r'^androidboot\.(?P<key>[a-zA-Z0-9_.]+)\s*=\s*"(?P<value>[^"]*)"',
)

ROM_MARKET_SKU_GB = (32, 64, 128, 256, 512, 1024)
RAM_MARKET_SKU_GB = (2, 3, 4, 6, 8, 12, 16, 24, 32)


def _ceil_market_sku_gb(value_gb: float, sku_table: Tuple[int, ...]) -> int:
    for sku in sku_table:
        if value_gb <= sku:
            return sku
    return sku_table[-1]


def normalize_market_sku_gb(value_gb: float, kind: str) -> int:
    if value_gb <= 0:
        return 0
    if kind == "rom":
        return _ceil_market_sku_gb(value_gb, ROM_MARKET_SKU_GB)
    return _ceil_market_sku_gb(value_gb, RAM_MARKET_SKU_GB)


def format_rom_ram(rom_gb: int, ram_gb: int) -> str:
    if rom_gb > 0 and ram_gb > 0:
        return f"{rom_gb}GB+{ram_gb}GB"
    return ""


def _parse_serial_combo(serial_value: str) -> str:
    if not serial_value:
        return ""
    match = SERIAL_COMBO_PATTERN.search(serial_value)
    if not match:
        return ""
    rom_gb = int(match.group(1))
    ram_gb = int(match.group(2))
    return format_rom_ram(rom_gb, ram_gb)


def _parse_capacity_text_gb(value: str) -> Optional[float]:
    if not value:
        return None
    text = str(value).strip()
    if not text:
        return None
    match = re.match(r"^(\d+(?:\.\d+)?)\s*(GB|G|MB|GiB|MiB)?$", text, re.IGNORECASE)
    if not match:
        return None
    amount = float(match.group(1))
    unit = (match.group(2) or "GB").upper()
    if unit in ("GB", "G"):
        return amount
    if unit == "MB":
        return amount / 1024.0
    if unit == "GIB":
        return amount * (1024.0 ** 3) / (1000.0 ** 3) if amount < 64 else amount
    if unit == "MIB":
        return amount / 1024.0
    return amount


def _parse_boot_mem(value: str) -> Tuple[Optional[int], Optional[int]]:
    if not value:
        return None, None
    ram_match = BOOT_MEM_RAM_PATTERN.search(value)
    rom_match = BOOT_MEM_ROM_PATTERN.search(value)
    ram_gb = int(ram_match.group(1)) if ram_match else None
    rom_gb = int(rom_match.group(1)) if rom_match else None
    return rom_gb, ram_gb


def _parse_emmc_size_value(value: str) -> Optional[float]:
    if not value:
        return None
    first_part = str(value).split(",", 1)[0].strip()
    physical_gb = _parse_capacity_text_gb(first_part)
    if physical_gb is None:
        return None
    if first_part.upper().endswith("GIB"):
        return physical_gb
    return physical_gb


def _load_properties_file(file_path: str) -> Dict[str, str]:
    properties: Dict[str, str] = {}
    if not os.path.isfile(file_path):
        return properties
    with open(file_path, "r", encoding="utf-8", errors="ignore") as handle:
        for line in handle:
            match = PROPERTY_LINE_PATTERN.match(line.strip())
            if match:
                properties[match.group("key")] = match.group("value")
    return properties


def _supplement_from_version_info(properties: Dict[str, str], file_path: str) -> None:
    if not os.path.isfile(file_path):
        return
    mapping = {
        "mmcsize": "ro.boot.mmcsize",
        "emmc_size": "ro.boot.emmc_size",
        "ddrsize": "ro.boot.ddrsize",
        "ddr_size": "ro.boot.ddr_size",
        "mem": "ro.boot.mem",
    }
    with open(file_path, "r", encoding="utf-8", errors="ignore") as handle:
        for line in handle:
            match = ANDROID_BOOT_LINE_PATTERN.match(line.strip())
            if not match:
                continue
            target_key = mapping.get(match.group("key"))
            if target_key and target_key not in properties:
                properties[target_key] = match.group("value")


def _parse_ram_gb_from_properties(properties: Dict[str, str]) -> Optional[int]:
    for key in ("ro.odm.tran.ddrsize", "ro.boot.ddrsize", "ro.boot.ddr_size"):
        raw_value = properties.get(key)
        if not raw_value:
            continue
        if key == "ro.boot.ddr_size" and raw_value.isdigit():
            physical_gb = int(raw_value) / (1024 ** 3)
            return normalize_market_sku_gb(physical_gb, "ram")
        physical_gb = _parse_capacity_text_gb(raw_value)
        if physical_gb is None:
            continue
        if key == "ro.odm.tran.ddrsize" or str(raw_value).upper().endswith(("GB", "G", "MB")):
            sku = int(round(physical_gb))
            if sku in RAM_MARKET_SKU_GB:
                return sku
        return normalize_market_sku_gb(physical_gb, "ram")
    return None


def _parse_rom_gb_from_properties(properties: Dict[str, str]) -> Optional[int]:
    mmcsize = properties.get("ro.boot.mmcsize")
    if mmcsize:
        physical_gb = _parse_capacity_text_gb(mmcsize)
        if physical_gb is not None:
            sku = int(round(physical_gb))
            if sku in ROM_MARKET_SKU_GB:
                return sku
            return normalize_market_sku_gb(physical_gb, "rom")

    emmc_size = properties.get("ro.boot.emmc_size")
    if emmc_size:
        physical_gb = _parse_emmc_size_value(emmc_size)
        if physical_gb is not None:
            return normalize_market_sku_gb(physical_gb, "rom")
    return None


def _parse_from_memory_and_filesystems(dec_dir: str) -> str:
    mem_info_path = os.path.join(dec_dir, "SYS_MEMORY_INFO")
    fs_path = os.path.join(dec_dir, "SYS_FILE_SYSTEMS")
    if not os.path.isfile(mem_info_path) or not os.path.isfile(fs_path):
        return ""

    ram_gb = None
    with open(mem_info_path, "r", encoding="utf-8", errors="ignore") as handle:
        for line in handle:
            match = re.search(r"MemTotal:\s+(\d+)\s+kB", line)
            if match:
                physical_gb = int(match.group(1)) / 1048576.0
                ram_gb = normalize_market_sku_gb(physical_gb, "ram")
                break

    rom_gb = None
    with open(fs_path, "r", encoding="utf-8", errors="ignore") as handle:
        for line in handle:
            if not re.search(r"\s+/data\s*$", line):
                continue
            match = re.match(r"^\S+\s+(\d+)\s", line)
            if match:
                physical_gb = int(match.group(1)) / 1048576.0
                rom_gb = normalize_market_sku_gb(physical_gb, "rom")
                break

    if rom_gb and ram_gb:
        return format_rom_ram(rom_gb, ram_gb)
    return ""


def _parse_from_boot_properties(properties: Dict[str, str]) -> str:
    rom_gb = _parse_rom_gb_from_properties(properties)
    ram_gb = _parse_ram_gb_from_properties(properties)
    if rom_gb and ram_gb:
        return format_rom_ram(rom_gb, ram_gb)
    return ""


def _parse_from_boot_mem(properties: Dict[str, str]) -> str:
    boot_mem = properties.get("ro.boot.mem")
    if not boot_mem:
        return ""
    rom_gb, ram_gb = _parse_boot_mem(boot_mem)
    if rom_gb and ram_gb:
        return format_rom_ram(rom_gb, ram_gb)
    return ""


def parse_rom_ram_from_dec_dir(dec_dir: str) -> str:
    """从 dbg.DEC 目录解析 Rom+Ram 市场 SKU 字符串。"""
    if not dec_dir or not os.path.isdir(dec_dir):
        return ""

    properties_path = os.path.join(dec_dir, "SYS_PROPERTIES")
    version_info_path = os.path.join(dec_dir, "SYS_VERSION_INFO")
    properties = _load_properties_file(properties_path)
    _supplement_from_version_info(properties, version_info_path)

    serial_value = properties.get("vendor.gsm.serial", "")
    serial_combo = _parse_serial_combo(serial_value)
    if serial_combo:
        return serial_combo

    memory_combo = _parse_from_memory_and_filesystems(dec_dir)
    if memory_combo:
        return memory_combo

    boot_combo = _parse_from_boot_properties(properties)
    if boot_combo:
        return boot_combo

    return _parse_from_boot_mem(properties)


def parse_rom_ram_from_exp_main_path(exp_main_path: str) -> str:
    if not exp_main_path:
        return ""
    return parse_rom_ram_from_dec_dir(os.path.dirname(exp_main_path))
