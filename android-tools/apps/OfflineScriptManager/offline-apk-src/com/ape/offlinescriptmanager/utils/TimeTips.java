package com.ape.offlinescriptmanager.utils;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.util.Log;
import android.widget.Toast;

/**
 * 有效期校验逻辑（反编译自 k.java，已改为可读命名）
 *
 * 实际打包走 smali 补丁，本文件供阅读与对照修改。
 * 对应 smali: OfflineScriptManager-build/smali/.../utils/k.smali
 */
public class TimeTips {

    private static final String TAG = "TimeTips";
    private static final String PREFS_NAME = "timetips";
    private static final String KEY_DEADLINE = "deadline";
    private static final String KEY_LATEST = "latest";

    private final Context context;
    private final String defaultDeadline = AppConfig.EXPIRY_DATE;

    public TimeTips(Context context) {
        this.context = context;
    }

    public void onResumeCheck() {
        savePreference(KEY_DEADLINE, defaultDeadline);
        savePreference(KEY_LATEST, DateUtils.formatNow(System.currentTimeMillis()));
        showExpiryToast();
        validateExpiry();
    }

    private boolean isDeadlineUnmodified() {
        SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
        String stored = prefs.getString(KEY_DEADLINE, defaultDeadline);
        Log.d(TAG, "isPreferenceNull :" + defaultDeadline.equals(stored));
        return defaultDeadline.equals(stored);
    }

    private boolean isExpired() {
        if (AppConfig.DISABLE_EXPIRY_CHECK) {
            return false;
        }
        try {
            SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
            String deadline = prefs.getString(KEY_DEADLINE, defaultDeadline);
            Log.d(TAG, ",deadline:" + deadline);
            String latest = prefs.getString(KEY_LATEST, DateUtils.formatNow(String.valueOf(System.currentTimeMillis())));
            Log.d(TAG, ",latest:" + latest);
            if (DateUtils.parseTime(latest) > DateUtils.parseTime(deadline)) {
                return true;
            }
            return System.currentTimeMillis() > DateUtils.parseTime(deadline);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private void validateExpiry() {
        if (AppConfig.DISABLE_EXPIRY_CHECK) {
            return;
        }
        if (isExpired()) {
            showExpiredDialog();
        } else if (isDeadlineUnmodified()) {
            try {
                SharedPreferences prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE);
                String latest = prefs.getString(KEY_LATEST, DateUtils.formatNow(String.valueOf(System.currentTimeMillis())));
                Log.d(TAG, ",mDefaultime:" + defaultDeadline);
                Log.d(TAG, ",latest:" + latest);
                if (DateUtils.parseTime(latest) > DateUtils.parseTime(defaultDeadline)) {
                    showExpiredDialog();
                } else if (DateUtils.parseTime(defaultDeadline) < System.currentTimeMillis()) {
                    showExpiredDialog();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void savePreference(String key, String value) {
        SharedPreferences.Editor editor = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE).edit();
        editor.putString(key, value);
        editor.apply();
    }

    private void showExpiredDialog() {
        DialogUtils.showAlert(context, "更新", "该app已经过期,请到ITMS下载更新版本!",
                new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        ((Activity) context).finish();
                    }
                }, null);
    }

    private void showExpiryToast() {
        Toast.makeText(context, "App 使用有效期至:" + defaultDeadline, Toast.LENGTH_LONG).show();
    }
}
