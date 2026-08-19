package com.ape.offlinescriptmanager.utils;

/**
 * 离线脚本管理器 - 可修改配置
 *
 * 修改 EXPIRY_DATE 后，请运行上级目录的 build-offline-apk.bat 重新打包。
 * 也可直接改 app-config.properties 中的 expiry.date（推荐）。
 */
public final class AppConfig {

    /** App 使用有效期截止时间 */
    public static final String EXPIRY_DATE = "2099-12-31 23:59:59";

    /** 设为 true 可完全跳过过期弹窗（需配合 smali 补丁，见构建脚本） */
    public static final boolean DISABLE_EXPIRY_CHECK = false;

    private AppConfig() {
    }
}
