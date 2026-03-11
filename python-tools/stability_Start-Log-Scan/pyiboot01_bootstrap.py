# uncompyle6 version 3.9.3
# Python bytecode version base 3.7.0 (3394)
# Decompiled from: Python 3.8.3 (tags/v3.8.3:6f8c832, May 13 2020, 22:37:02) [MSC v.1924 64 bit (AMD64)]
# Embedded file name: PyInstaller\loader\pyiboot01_bootstrap.py
import sys, pyimod02_importers
pyimod02_importers.install()
import os
if not hasattr(sys, "frozen"):
    sys.frozen = True
sys.prefix = sys._MEIPASS
sys.exec_prefix = sys.prefix
sys.base_prefix = sys.prefix
sys.base_exec_prefix = sys.exec_prefix
VIRTENV = "VIRTUAL_ENV"
if VIRTENV in os.environ:
    os.environ[VIRTENV] = ""
    del os.environ[VIRTENV]
python_path = []
for pth in sys.path:
    python_path.append(os.path.abspath(pth))
    sys.path = python_path

try:
    import encodings
except ImportError:
    pass

if sys.warnoptions:
    import warnings
import pyimod03_ctypes
pyimod03_ctypes.install()
if sys.platform.startswith("win"):
    import pyimod04_pywin32
    pyimod04_pywin32.install()
d = "eggs"
d = os.path.join(sys._MEIPASS, d)
if os.path.isdir(d):
    for fn in os.listdir(d):
        sys.path.append(os.path.join(d, fn))

# okay decompiling start_log_scan.exe_extracted\pyiboot01_bootstrap.pyc
