# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: PyInstaller\hooks\rthooks\pyi_rth_multiprocessing.py


def _pyi_rthook():
    import os, sys, threading, multiprocessing, multiprocessing.spawn
    from subprocess import _args_from_interpreter_flags
    multiprocessing.process.ORIGINAL_DIR = None

    def _freeze_support():
        if len(sys.argv) >= 2:
            if sys.argv[-2] == "-c":
                if sys.argv[-1].startswith(('from multiprocessing.semaphore_tracker import main',
                                            'from multiprocessing.resource_tracker import main',
                                            'from multiprocessing.forkserver import main')):
                    if set(sys.argv[1[:-2]]) == set(_args_from_interpreter_flags()):
                        exec(sys.argv[-1])
                        sys.exit()
        if multiprocessing.spawn.is_forking(sys.argv):
            kwds = {}
            for arg in sys.argv[2:]:
                name, value = arg.split("=")
                if value == "None":
                    kwds[name] = None
                else:
                    kwds[name] = int(value)

            (multiprocessing.spawn.spawn_main)(**kwds)
            sys.exit()

    multiprocessing.freeze_support = multiprocessing.spawn.freeze_support = _freeze_support

    class FrozenSupportMixIn:
        _lock = threading.Lock()

        def __init__(self, *args, **kw):
            with self._lock:
                os.putenv("_MEIPASS2", sys._MEIPASS)
                try:
                    (super().__init__)(*args, **kw)
                finally:
                    if hasattr(os, "unsetenv"):
                        os.unsetenv("_MEIPASS2")
                    else:
                        os.putenv("_MEIPASS2", "")

    if sys.platform.startswith("win"):
        from multiprocessing import popen_spawn_win32

        class _SpawnPopen(FrozenSupportMixIn, popen_spawn_win32.Popen):
            return

        popen_spawn_win32.Popen = _SpawnPopen
    else:
        from multiprocessing import popen_spawn_posix
        from multiprocessing import popen_forkserver

        class _SpawnPopen(FrozenSupportMixIn, popen_spawn_posix.Popen):
            return

        class _ForkserverPopen(FrozenSupportMixIn, popen_forkserver.Popen):
            return

        popen_spawn_posix.Popen = _SpawnPopen
        popen_forkserver.Popen = _ForkserverPopen


_pyi_rthook()
del _pyi_rthook

# okay decompiling start_log_scan.exe_extracted\pyi_rth_multiprocessing.pyc
