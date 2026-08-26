package com.mediatek.schpwronoff.sleeptest;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;

import com.mediatek.schpwronoff.utils.LogUtil;

/**
 * 看门狗续跑：服务被系统回收时重新拉起。
 */
public class SleepTestKeepAliveReceiver extends BroadcastReceiver {

    public static final String ACTION_KEEPALIVE = "com.tinno.autotesttool.action.SLEEP_TEST_KEEPALIVE";

    private static final String TAG = "SleepTestKeepAlive";

    @Override
    public void onReceive(Context context, Intent intent) {
        if (intent == null || !ACTION_KEEPALIVE.equals(intent.getAction())) {
            return;
        }
        if (!SleepTestPrefs.isRunning(context) || !SleepTestPrefs.isAutoResume(context)) {
            return;
        }
        LogUtil.i(TAG, "keepalive");
        Intent service = new Intent(context, SleepTestService.class);
        service.setAction(SleepTestService.ACTION_START);
        context.startForegroundService(service);
    }
}
