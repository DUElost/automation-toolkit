package com.mediatek.schpwronoff.powercycle;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.mediatek.schpwronoff.screen.UnlockUtils;
import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 开机后自动恢复开关机测试。
 */
public class BootCompletedReceiver extends BroadcastReceiver {

    private static final String TAG = "BootCompletedReceiver";

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

        if (!PowerCyclePrefs.isRunning(context)) {
            LogUtil.i(TAG, "not running, skip boot resume");
            return;
        }
        if (!PowerCyclePrefs.isAutoResume(context)) {
            LogUtil.i(TAG, "auto_resume=false, skip");
            return;
        }

        LogUtil.i(TAG, "resume after " + action);
        UnlockUtils.unlockBySwipe();

        Intent service = new Intent(context, PowerCycleService.class);
        service.setAction(PowerCycleService.ACTION_START);
        context.startForegroundService(service);
    }
}
