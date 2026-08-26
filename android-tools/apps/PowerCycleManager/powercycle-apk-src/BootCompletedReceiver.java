package com.mediatek.schpwronoff.powercycle;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Handler;
import android.os.Looper;

import com.mediatek.schpwronoff.screen.UnlockUtils;
import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 开机后自动恢复开关机测试，并拉起界面便于现场确认进度。
 */
public class BootCompletedReceiver extends BroadcastReceiver {

    private static final String TAG = "BootCompletedReceiver";
    private static final long RESUME_UI_DELAY_MS = 1500L;

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
        final Context app = context.getApplicationContext();
        UnlockUtils.unlockBySwipe();

        Intent service = new Intent(app, PowerCycleService.class);
        service.setAction(PowerCycleService.ACTION_START);
        app.startForegroundService(service);

        // 稍等解锁/桌面就绪后再拉起界面，避免被启动动画挡住
        new Handler(Looper.getMainLooper()).postDelayed(
                () -> PowerCycleActivity.bringToFront(app), RESUME_UI_DELAY_MS);
    }
}
