import json
import sys
import unittest
from pathlib import Path
from unittest import mock

import urllib3
from requests.auth import HTTPBasicAuth


TOOL_DIR = Path(__file__).resolve().parent.parent
if str(TOOL_DIR) not in sys.path:
    sys.path.insert(0, str(TOOL_DIR))

from jira_p12_client import JiraP12Client, LegacySSLHttpAdapter


class JiraP12ClientLegacySSLTest(unittest.TestCase):
    def test_init_only_disables_insecure_request_warning_when_verify_is_false(self) -> None:
        with mock.patch("urllib3.disable_warnings") as disable_warnings:
            JiraP12Client(
                jira_url="https://jira.tinno.com",
                p12_file_path="dummy.p12",
                p12_password="secret",
                jira_username="user",
                jira_password="password",
                verify=False,
            )
            disable_warnings.assert_called_once_with(urllib3.exceptions.InsecureRequestWarning)

        with mock.patch("urllib3.disable_warnings") as disable_warnings:
            JiraP12Client(
                jira_url="https://jira.tinno.com",
                p12_file_path="dummy.p12",
                p12_password="secret",
                jira_username="user",
                jira_password="password",
                verify=True,
            )
            disable_warnings.assert_not_called()

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

    def test_connect_uses_custom_session_builder(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
        )
        fake_session = mock.Mock()
        fake_session.get.return_value.status_code = 200

        with mock.patch.object(client, "_extract_cert_and_key", return_value=("cert.pem", "key.pem")):
            with mock.patch.object(client, "_build_session", return_value=fake_session):
                client.connect()

        self.assertIs(fake_session, client.session)
        fake_session.get.assert_called_once()

    def test_login_falls_back_to_basic_auth_when_session_login_fails(self) -> None:
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
        client.session.get.return_value.headers = {"Content-Type": "application/json;charset=UTF-8"}
        client.session.get.return_value.json.return_value = {}

        client.login()

        self.assertTrue(client.is_logged_in)
        self.assertIsInstance(client.session.auth, HTTPBasicAuth)
        client.session.get.assert_called_once()

    def test_load_cookie_values_supports_string_and_explicit_fields(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
            cookie_string="JSESSIONID=from-string; atlassian.xsrf.token=token-from-string",
            cookie_jsessionid="override-session",
            cookie_xsrf_token="override-xsrf",
        )

        cookies = client._load_cookie_values()

        self.assertEqual("override-session", cookies["JSESSIONID"])
        self.assertEqual("override-xsrf", cookies["atlassian.xsrf.token"])

    def test_login_prefers_cookie_when_cookie_is_configured(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
            cookie_jsessionid="session-cookie",
            cookie_xsrf_token="xsrf-cookie",
        )
        client.session = mock.Mock()
        client.session.cookies = mock.Mock()

        cookie_verify = mock.Mock()
        cookie_verify.status_code = 200
        cookie_verify.text = '{"name":"dai.lv"}'
        cookie_verify.headers = {"Content-Type": "application/json;charset=UTF-8"}
        cookie_verify.json.return_value = {"name": "dai.lv"}

        client.session.get.return_value = cookie_verify

        client.login()

        self.assertTrue(client.is_logged_in)
        self.assertEqual("cookie", client.auth_mode)
        client.session.post.assert_not_called()
        client.session.cookies.set.assert_any_call("JSESSIONID", "session-cookie", domain="jira.tinno.com")
        client.session.cookies.set.assert_any_call("atlassian.xsrf.token", "xsrf-cookie", domain="jira.tinno.com")

    def test_login_falls_back_to_password_when_cookie_is_invalid(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
            cookie_jsessionid="session-cookie",
            cookie_xsrf_token="xsrf-cookie",
        )
        client.session = mock.Mock()
        client.session.cookies = mock.Mock()

        invalid_cookie_probe = mock.Mock()
        invalid_cookie_probe.status_code = 401
        invalid_cookie_probe.text = "<status>auth required</status>"
        invalid_cookie_probe.headers = {"Content-Type": "application/xml;charset=UTF-8"}
        invalid_cookie_probe.json.side_effect = json.JSONDecodeError("Expecting value", "", 0)

        basic_verify = mock.Mock()
        basic_verify.status_code = 200
        basic_verify.text = '{"name":"dai.lv"}'
        basic_verify.headers = {"Content-Type": "application/json;charset=UTF-8"}
        basic_verify.json.return_value = {"name": "dai.lv"}

        client.session.get.side_effect = [invalid_cookie_probe, basic_verify]

        client.login()

        self.assertEqual("basic", client.auth_mode)
        client.session.post.assert_not_called()

    def test_login_does_not_treat_html_200_basic_auth_probe_as_success(self) -> None:
        client = JiraP12Client(
            jira_url="https://jira.tinno.com",
            p12_file_path="dummy.p12",
            p12_password="secret",
            jira_username="user",
            jira_password="password",
            cookie_jsessionid="session-cookie",
            cookie_xsrf_token="xsrf-cookie",
        )
        client.session = mock.Mock()
        client.session.cookies = mock.Mock()
        client.session.post.return_value.status_code = 401
        client.session.post.return_value.text = '{"errorMessages":["Login failed"]}'

        invalid_cookie_probe = mock.Mock()
        invalid_cookie_probe.status_code = 401
        invalid_cookie_probe.text = "<status>auth required</status>"
        invalid_cookie_probe.headers = {"Content-Type": "application/xml;charset=UTF-8"}
        invalid_cookie_probe.json.side_effect = json.JSONDecodeError("Expecting value", "", 0)

        html_probe = mock.Mock()
        html_probe.status_code = 200
        html_probe.text = ""
        html_probe.headers = {"Content-Type": "text/html;charset=UTF-8"}
        html_probe.json.side_effect = json.JSONDecodeError("Expecting value", "", 0)

        cookie_verify = mock.Mock()
        cookie_verify.status_code = 200
        cookie_verify.text = '{"name":"dai.lv"}'
        cookie_verify.headers = {"Content-Type": "application/json;charset=UTF-8"}
        cookie_verify.json.return_value = {"name": "dai.lv"}

        client.session.get.side_effect = [invalid_cookie_probe, html_probe, cookie_verify]

        client.login()

        self.assertEqual("cookie", client.auth_mode)


if __name__ == "__main__":
    unittest.main()
