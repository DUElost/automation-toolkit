# -*- coding: utf-8 -*-
import os
import sys
import tempfile
import unittest

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))
if PROJECT_ROOT not in sys.path:
    sys.path.insert(0, PROJECT_ROOT)

from modules.analyse.aee.files.rom_ram import (
    format_rom_ram,
    normalize_market_sku_gb,
    parse_rom_ram_from_dec_dir,
)


class RomRamParserTest(unittest.TestCase):
    def _write_properties(self, directory, lines):
        with open(os.path.join(directory, "SYS_PROPERTIES"), "w", encoding="utf-8") as handle:
            handle.write("\n".join(lines))

    def _write_memory_info(self, directory, mem_total_kb):
        with open(os.path.join(directory, "SYS_MEMORY_INFO"), "w", encoding="utf-8") as handle:
            handle.write(f"MemTotal:        {mem_total_kb} kB\n")

    def _write_file_systems(self, directory, data_blocks_kb):
        with open(os.path.join(directory, "SYS_FILE_SYSTEMS"), "w", encoding="utf-8") as handle:
            handle.write(f"/dev/block/dm-80 {data_blocks_kb} 1 2 3% /data\n")

    def test_serial_combo_normalizes_g_suffix(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self._write_properties(temp_dir, [
                '[vendor.gsm.serial]: [H8925_A1_128G+4G_V1.1                   10P]',
            ])
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "128GB+4GB")

    def test_memory_and_filesystems_maps_to_market_sku(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self._write_memory_info(temp_dir, int(7.35 * 1048576))
            self._write_file_systems(temp_dir, int(224.65 * 1048576))
            self._write_properties(temp_dir, [])
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "256GB+8GB")

    def test_ddrsize_and_emmc_size_maps_to_market_sku(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self._write_properties(temp_dir, [
                "[ro.boot.ddrsize]: [3GB]",
                "[ro.boot.emmc_size]: [29GiB,30560256KiB]",
            ])
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "32GB+3GB")

    def test_boot_mem_parses_market_sku(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self._write_properties(temp_dir, [
                "[ro.boot.mem]: [CXMT_LPDDR4X_4_BIWIN_EMMC_128]",
            ])
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "128GB+4GB")

    def test_mmcsize_used_directly(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self._write_properties(temp_dir, [
                "[ro.boot.mmcsize]: [64GB]",
                "[ro.boot.ddrsize]: [3GB]",
            ])
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "64GB+3GB")

    def test_serial_has_priority_over_memory_files(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            self._write_memory_info(temp_dir, int(7.35 * 1048576))
            self._write_file_systems(temp_dir, int(224.65 * 1048576))
            self._write_properties(temp_dir, [
                "[vendor.gsm.serial]: [X6852_A1_256GB+8GB_V1.0                P10P]",
            ])
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "256GB+8GB")

    def test_market_sku_helpers(self):
        self.assertEqual(normalize_market_sku_gb(58, "rom"), 64)
        self.assertEqual(normalize_market_sku_gb(7.35, "ram"), 8)
        self.assertEqual(format_rom_ram(256, 8), "256GB+8GB")

    def test_lk_dump_ke_fallback(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            with open(os.path.join(temp_dir, "SYS_EXP_PL_LK"), "w", encoding="utf-8") as handle:
                handle.write(
                    "[SD0] Size: 59648 MB, Max.Speed: 52000 kHz, blklen(512), nblks(122159104)\n"
                    "total_dram_size: 0x00000000C0000000, max_dram_size: 0x0000000800000000\n"
                )
            self.assertEqual(parse_rom_ram_from_dec_dir(temp_dir), "64GB+3GB")


class RomRamSampleIntegrationTest(unittest.TestCase):
    SAMPLE_CASES = {
        r"C:\Users\dai.lv\Desktop\NEW\2026_0530_124907_000_db.fatal.00.KE\db.fatal.00.KE.dbg.DEC": "32GB+3GB",
        r"C:\Users\dai.lv\Desktop\NEW\2025_1129_141335_000_db.fatal.00.HANG\db.fatal.00.HANG.dbg.DEC": "128GB+4GB",
        r"C:\Users\dai.lv\Desktop\Stability\X6852AEE-419_db.06.JE.dbg.DEC": "256GB+8GB",
    }

    def test_local_samples_when_available(self):
        for sample_dir, expected in self.SAMPLE_CASES.items():
            if not os.path.isdir(sample_dir):
                continue
            with self.subTest(sample=sample_dir):
                self.assertEqual(parse_rom_ram_from_dec_dir(sample_dir), expected)


if __name__ == "__main__":
    unittest.main()
