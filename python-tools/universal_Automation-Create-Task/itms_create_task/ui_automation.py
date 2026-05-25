# -*- coding: utf-8 -*-
"""
UI 自动化兜底逻辑。
"""

from pathlib import Path
from typing import Any, Dict, Iterable

from playwright.sync_api import TimeoutError as PlaywrightTimeoutError
from playwright.sync_api import sync_playwright

from .auth import ItmsAuthManager
from .models import ItmsToolConfig, UiFieldBinding


class ItmsUiAutomation:
    """使用 Playwright 进行 UI 自动化。"""

    def __init__(self, config: ItmsToolConfig, auth_manager: ItmsAuthManager):
        self.config = config
        self.auth_manager = auth_manager

    def create_sub_plan(self, form_data: Dict[str, Any]) -> None:
        """执行 UI 模式的子计划创建。"""
        context_kwargs = self.auth_manager.build_context_kwargs()
        storage_path = Path(self.config.browser.storage_state_path)
        storage_path.parent.mkdir(parents=True, exist_ok=True)

        with sync_playwright() as playwright:
            browser = playwright.chromium.launch(**self.auth_manager.build_launch_kwargs())
            context = browser.new_context(**context_kwargs)
            context.set_default_timeout(self.config.browser.timeout_ms)
            page = context.new_page()

            self._open_form(page, form_data)
            self._fill_form(page, form_data)
            self._submit(page)

            context.storage_state(path=str(storage_path))
            browser.close()

    def _open_form(self, page, form_data: Dict[str, Any]) -> None:
        """根据配置打开子计划表单页面。"""
        prefer_direct = self.config.ui.prefer_direct_urls
        owner_name = form_data.get("owner_name") or self.config.owner_name

        if prefer_direct and self.config.sub_plan_form_url:
            page.goto(self.config.sub_plan_form_url)
            return

        if self.config.main_plan_content_url:
            page.goto(self.config.main_plan_content_url)
            self._open_form_from_content_page(page, owner_name)
            return

        page.goto(self.config.workbench_url)
        self._click_text(page, [self.config.ui.texts.get("project_center", "项目中心")])
        if self.config.project_center_url:
            page.goto(self.config.project_center_url)
        self._open_project(page, self.config.project_name)
        self._click_text(page, [self.config.ui.texts.get("test_plan", "测试计划")])
        if self.config.plans_url:
            page.goto(self.config.plans_url)
        self._open_main_plan(page, self.config.main_plan_name)
        self._open_form_from_content_page(page, owner_name)

    def _open_form_from_content_page(self, page, owner_name: str) -> None:
        """在主计划内容页中选择 Owner 行并打开子计划表单。"""
        add_text = self.config.ui.texts.get("add_sub_plan", "添加子计划")
        if owner_name:
            row = page.locator("tr").filter(has_text=owner_name).first
            if row.count():
                buttons = row.get_by_text(add_text, exact=False)
                if buttons.count():
                    buttons.first.click()
                    return
                row.click()
        self._click_text(page, [add_text])

    def _open_project(self, page, project_name: str) -> None:
        """打开项目行。"""
        row = page.locator("tr").filter(has_text=project_name).first
        if row.count():
            row.click()
            return
        self._click_text(page, [project_name])

    def _open_main_plan(self, page, main_plan_name: str) -> None:
        """打开主计划。"""
        row = page.locator("tr").filter(has_text=main_plan_name).first
        if row.count():
            row.click()
            return
        self._click_text(page, [main_plan_name])

    def _fill_form(self, page, form_data: Dict[str, Any]) -> None:
        """按绑定规则填写表单。"""
        for binding in self.config.ui.field_bindings:
            value = form_data.get(binding.field)
            if value in (None, ""):
                continue
            self._fill_field(page, binding, value)

    def _fill_field(self, page, binding: UiFieldBinding, value: Any) -> None:
        """填写单个字段。"""
        field_type = binding.field_type.lower()
        locator = self._resolve_locator(page, binding)
        if locator is None:
            raise RuntimeError("未找到字段定位信息: %s" % binding.field)

        if field_type in ("text", "date", "textarea"):
            locator.click()
            locator.fill(str(value))
            return

        if field_type == "select":
            locator.click()
            option_text = binding.option_text or str(value)
            self._click_text(page, [option_text])
            return

        if field_type == "checkbox":
            if str(value).lower() in ("true", "1", "yes", "y"):
                locator.check()
            else:
                locator.uncheck()
            return

        raise RuntimeError("暂不支持的字段类型: %s" % binding.field_type)

    def _resolve_locator(self, page, binding: UiFieldBinding):
        """通过 selector 或 label 定位表单控件。"""
        if binding.selector:
            locator = page.locator(binding.selector).first
            if locator.count():
                return locator

        if binding.label:
            label_locator = page.get_by_label(binding.label, exact=False)
            if label_locator.count():
                return label_locator.first

            xpaths = [
                (
                    "xpath=//*[contains(normalize-space(text()), \"%s\")]"
                    "/ancestor::*[self::div or self::td or self::form][1]"
                    "//*[self::input or self::textarea][1]"
                )
                % binding.label,
                (
                    "xpath=//*[contains(normalize-space(text()), \"%s\")]"
                    "/following::*[self::input or self::textarea][1]"
                )
                % binding.label,
            ]
            for item in xpaths:
                locator = page.locator(item).first
                if locator.count():
                    return locator

        return None

    def _submit(self, page) -> None:
        """提交表单。"""
        submit_texts = self.config.ui.texts.get("submit_buttons", ["确定", "提交", "保存"])
        self._click_text(page, submit_texts)

    def _click_text(self, page, texts: Iterable[str]) -> None:
        """按文本点击首个可用元素。"""
        for text in texts:
            if not text:
                continue

            candidates = [
                page.get_by_role("button", name=text),
                page.get_by_text(text, exact=False),
                page.locator("text=%s" % text),
            ]

            for locator in candidates:
                try:
                    if locator.count():
                        locator.first.click()
                        return
                except PlaywrightTimeoutError:
                    continue

        raise RuntimeError("未找到可点击文本: %s" % list(texts))
