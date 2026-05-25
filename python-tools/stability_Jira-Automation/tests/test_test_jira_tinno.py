import importlib.util
import json
import unittest
from pathlib import Path
from unittest import mock


MODULE_PATH = Path(__file__).resolve().parents[1] / "src" / "modules" / "test_jira_Tinno.py"


def load_module():
    spec = importlib.util.spec_from_file_location("test_jira_Tinno_under_test", MODULE_PATH)
    module = importlib.util.module_from_spec(spec)
    assert spec.loader is not None
    spec.loader.exec_module(module)
    return module


class TestJiraTinnoConnection(unittest.TestCase):
    def test_test_jira_auth_rejects_html_200(self) -> None:
        module = load_module()
        response = mock.Mock()
        response.status_code = 200
        response.text = "<html><title>error</title></html>"
        response.headers = {"Content-Type": "text/html;charset=UTF-8"}
        response.json.side_effect = json.JSONDecodeError("Expecting value", "", 0)

        with mock.patch("builtins.print"):
            with mock.patch.object(module.requests, "post", return_value=response):
                result = module.test_jira_auth("https://jira.tinno.com", "user", "password")

        self.assertFalse(result)

    def test_connect_to_jira_falls_back_to_p12_probe(self) -> None:
        module = load_module()
        fallback_client = mock.Mock()
        fallback_client.current_user.return_value = "dai.lv"

        with mock.patch("builtins.print"):
            with mock.patch.object(module, "JIRA", side_effect=ValueError("Expecting value")):
                with mock.patch.object(module, "_connect_to_jira_with_p12", return_value=fallback_client, create=True) as fallback:
                    client = module.connect_to_jira("https://jira.tinno.com", "dai.lv", "secret")

        self.assertIs(client, fallback_client)
        fallback.assert_called_once()

    def test_load_tinno_cookie_values_supports_string_and_explicit_fields(self) -> None:
        module = load_module()
        with mock.patch.object(module, "JIRA_COOKIE_STRING", "JSESSIONID=abc; atlassian.xsrf.token=token-from-string"):
            with mock.patch.object(module, "JIRA_COOKIE_JSESSIONID", "override-session"):
                with mock.patch.object(module, "JIRA_COOKIE_XSRF_TOKEN", "override-xsrf"):
                    cookies = module._load_tinno_cookie_values()

        self.assertEqual("override-session", cookies["JSESSIONID"])
        self.assertEqual("override-xsrf", cookies["atlassian.xsrf.token"])

    def test_connect_to_jira_prefers_cookie_fallback_when_cookie_exists(self) -> None:
        module = load_module()
        fallback_client = mock.Mock()

        with mock.patch("builtins.print"):
            with mock.patch.object(module, "JIRA", side_effect=ValueError("Expecting value")):
                with mock.patch.object(module, "_load_tinno_cookie_values", return_value={"JSESSIONID": "abc"}):
                    with mock.patch.object(module, "_connect_to_jira_with_p12_and_cookie", return_value=fallback_client) as cookie_fallback:
                        with mock.patch.object(module, "_connect_to_jira_with_p12", return_value=None) as plain_fallback:
                            client = module.connect_to_jira("https://jira.tinno.com", "dai.lv", "secret")

        self.assertIs(client, fallback_client)
        cookie_fallback.assert_called_once()
        plain_fallback.assert_not_called()

    def test_tinno_p12_readonly_client_rejects_non_json_myself(self) -> None:
        module = load_module()
        raw_client = mock.Mock()
        raw_client.jira_url = "https://jira.tinno.com"
        raw_client.timeout = 30
        raw_client.verify = False
        raw_client.ensure_authenticated = mock.Mock()
        raw_client.session = mock.Mock()

        response = mock.Mock()
        response.status_code = 200
        response.text = ""
        response.headers = {"Content-Type": "text/html;charset=UTF-8"}
        response.json.side_effect = json.JSONDecodeError("Expecting value", "", 0)
        raw_client.session.get.return_value = response

        client = module.TinnoP12ReadonlyClient(raw_client)
        with self.assertRaises(RuntimeError):
            client.current_user()


if __name__ == "__main__":
    unittest.main()
