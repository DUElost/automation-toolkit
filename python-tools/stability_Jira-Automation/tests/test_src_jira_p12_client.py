import sys
import unittest
from pathlib import Path
from unittest import mock

from requests.auth import HTTPBasicAuth


MODULE_DIR = Path(__file__).resolve().parents[1] / "src" / "modules"
if str(MODULE_DIR) not in sys.path:
    sys.path.insert(0, str(MODULE_DIR))

from jira_p12_client import JiraP12Client, LegacySSLHttpAdapter


class SrcJiraP12ClientTest(unittest.TestCase):
    def test_build_session_mounts_legacy_ssl_adapter(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
        )

        session = client._build_session(("cert.pem", "key.pem"))
        adapter = session.get_adapter("https://jira.tinno.com")
        ssl_context = adapter.poolmanager.connection_pool_kw["ssl_context"]

        self.assertIsInstance(adapter, LegacySSLHttpAdapter)
        self.assertEqual("ALL:@SECLEVEL=0", adapter.ciphers)
        self.assertFalse(ssl_context.check_hostname)
        self.assertEqual(("cert.pem", "key.pem"), session.cert)
        self.assertFalse(session.trust_env)
        self.assertEqual({}, session.proxies)

    def test_login_falls_back_to_basic_auth(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
        )
        client.session = mock.Mock()
        client.session.post.return_value.status_code = 401
        client.session.post.return_value.text = '{"errorMessages":["Login failed"]}'
        client.session.get.return_value.status_code = 200
        client.session.get.return_value.text = "{}"

        client.login()

        self.assertTrue(client.is_logged_in)
        self.assertIsInstance(client.session.auth, HTTPBasicAuth)
        client.session.get.assert_called_once()

    def test_login_raises_clear_error_when_captcha_detected(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
        )
        client.session = mock.Mock()
        client.session.post.return_value.status_code = 403
        client.session.post.return_value.text = "forbidden"

        myself_response = mock.Mock()
        myself_response.status_code = 401
        myself_response.text = "<status>auth required</status>"

        captcha_page = mock.Mock()
        captcha_page.text = '<div class="aui-message error">Sorry, your userid is required to answer a CAPTCHA question correctly.</div>'

        client.session.get.side_effect = [myself_response, captcha_page]

        with self.assertRaises(RuntimeError) as ctx:
            client.login()

        self.assertIn("CAPTCHA", str(ctx.exception))


if __name__ == "__main__":
    unittest.main()
