package com.mediatek.schpwronoff.sleeptest;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.mediatek.schpwronoff.screen.UnlockUtils;
import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 开机后自动恢复休眠唤醒测试。
 */
public class SleepTestBootReceiver extends BroadcastReceiver {

    private static final String TAG = "SleepTestBoot";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || intent.getAction() == null) {
            return;
        }
        String action = intent.getAction();
        if (!Intent.ACTION_BOOT_COMPLETED.equals(action)
                && !Intent.ACTION_LOCKED_BOOT_COMPLETED.equals(action)) {
            return;
        }
        if (!SleepTestPrefs.isRunning(context) || !SleepTestPrefs.isAutoResume(context)) {
            LogUtil.i(TAG, "skip boot resume running=" + SleepTestPrefs.isRunning(context));
            return;
        }
        LogUtil.i(TAG, "resume after " + action);
        UnlockUtils.unlockBySwipe();
        Intent service = new Intent(context, SleepTestService.class);
        service.setAction(SleepTestService.ACTION_START);
        context.startForegroundService(service);
    }
}
