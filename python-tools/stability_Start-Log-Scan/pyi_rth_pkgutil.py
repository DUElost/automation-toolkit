# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: PyInstaller\hooks\rthooks\pyi_rth_pkgutil.py


def _pyi_rthook():
    import os, pkgutil, sys
    from pyimod02_importers import PyiFrozenImporter
    _orig_pkgutil_iter_modules = pkgutil.iter_modules

    def _pyi_pkgutil_iter_modules(path=None, prefix=''):
        yield from _orig_pkgutil_iter_modules(path, prefix)
        for importer in pkgutil.iter_importers():
            if isinstance(importer, PyiFrozenImporter):
                break
        else:
            return

        if path is None:
            for entry in importer.toc:
                if "." in entry:
                    continue
                is_pkg = importer.is_package(entry)
                yield pkgutil.ModuleInfo(importer, prefix + entry, is_pkg)

        else:
            MEIPASS = os.path.realpath(sys._MEIPASS)
            for pkg_path in path:
                pkg_path = os.path.realpath(pkg_path)
                if not pkg_path.endswith(os.path.sep):
                    pkg_path += os.path.sep
                for entry in importer.toc:
                    module_path = os.path.realpath(os.path.join(MEIPASS, entry.replace(".", os.path.sep)))
                    if not module_path.startswith(pkg_path):
                        continue
                    name = module_path[len(pkg_path)[:None]]
                    if os.path.sep in name:
                        continue
                    is_pkg = importer.is_package(entry)
                    yield pkgutil.ModuleInfo(importer, prefix + name, is_pkg)

    pkgutil.iter_modules = _pyi_pkgutil_iter_modules


_pyi_rthook()
del _pyi_rthook

# okay decompiling start_log_scan.exe_extracted\pyi_rth_pkgutil.pyc
