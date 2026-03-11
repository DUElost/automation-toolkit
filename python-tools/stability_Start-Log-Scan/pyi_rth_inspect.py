# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: PyInstaller\hooks\rthooks\pyi_rth_inspect.py


def _pyi_rthook():
    import inspect, os, sys
    _orig_inspect_getsourcefile = inspect.getsourcefile

    def _pyi_getsourcefile(object):
        filename = inspect.getfile(object)
        main_file = os.path.isabs(filename) or getattr(sys.modules["__main__"], "__file__", None)
        if main_file:
            if filename == os.path.basename(main_file):
                return main_file
        elif filename.endswith(".py"):
            filename = os.path.normpath(os.path.join(sys._MEIPASS, filename + "c"))
            if filename.startswith(sys._MEIPASS):
                return filename
            else:
                if filename.startswith(sys._MEIPASS):
                    if filename.endswith(".pyc"):
                        return filename
        return _orig_inspect_getsourcefile(object)

    inspect.getsourcefile = _pyi_getsourcefile


_pyi_rthook()
del _pyi_rthook

# okay decompiling start_log_scan.exe_extracted\pyi_rth_inspect.pyc
