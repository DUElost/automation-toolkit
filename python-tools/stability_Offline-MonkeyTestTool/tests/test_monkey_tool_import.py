# -*- coding: utf-8 -*-
import importlib.util
import os
import sys
import unittest


TOOL_DIR = os.path.abspath(os.path.join(os.path.dirname(__file__), ".."))


class MonkeyToolImportTest(unittest.TestCase):
    def test_main_script_imports_without_module_not_found(self) -> None:
        script_path = os.path.join(TOOL_DIR, "MonkeyAEEinfo_260523.py")
        module_name = "monkey_aeeinfo_import_test"

        if TOOL_DIR not in sys.path:
            sys.path.insert(0, TOOL_DIR)

        spec = importlib.util.spec_from_file_location(module_name, script_path)
        self.assertIsNotNone(spec)
        self.assertIsNotNone(spec.loader)

        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)

        self.assertTrue(hasattr(module, "ENABLE_FILL_STORAGE"))


if __name__ == "__main__":
    unittest.main()
