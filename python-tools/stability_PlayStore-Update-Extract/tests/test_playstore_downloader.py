import sys
import types
import unittest
from pathlib import Path
from unittest.mock import MagicMock, patch

TOOL_DIR = Path(__file__).resolve().parents[1]
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

if "playstoreapi" not in sys.modules:
    playstoreapi = types.ModuleType("playstoreapi")
    googleplay = types.ModuleType("playstoreapi.googleplay")

    class _StubGooglePlayAPI:
        def __init__(self, locale="en_US", timezone="America/New_York"):
            self.locale = locale
            self.timezone = timezone
            self.ssl_verify = True
            self.gsfId = 0
            self.authSubToken = ""

        def login(self, **kwargs):
            for key, value in kwargs.items():
                setattr(self, key, value)

    googleplay.GooglePlayAPI = _StubGooglePlayAPI
    playstoreapi.googleplay = googleplay
    sys.modules["playstoreapi"] = playstoreapi
    sys.modules["playstoreapi.googleplay"] = googleplay

from playstore_downloader import PlayStoreDownloader  # noqa: E402


class PlayStoreDownloaderWorkerTests(unittest.TestCase):
    def test_spawn_worker_reuses_parent_auth_on_new_instance(self):
        parent = PlayStoreDownloader()
        parent.api.gsfId = 424242
        parent.api.authSubToken = "cached-token"

        with patch.object(PlayStoreDownloader, "login_anonymous"):
            worker = parent.spawn_worker()

        self.assertIsNot(worker, parent)
        self.assertEqual(worker.api.gsfId, 424242)
        self.assertEqual(worker.api.authSubToken, "cached-token")


if __name__ == "__main__":
    unittest.main()
