package com.mediatek.schpwronoff.sleeptest;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.view.WindowManager;

/**
 * 透明唤醒 Activity：用 showWhenLocked + turnScreenOn 请求系统亮屏，不依赖 REBOOT/INJECT_EVENTS。
 */
public class WakeUpActivity extends Activity {

    public static void start(Context context) {
        Intent wakeIntent = new Intent(context, WakeUpActivity.class);
        wakeIntent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(wakeIntent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O_MR1) {
            setShowWhenLocked(true);
            setTurnScreenOn(true);
        }
        getWindow().addFlags(
                WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON
                        | WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED
                        | WindowManager.LayoutParams.FLAG_DISMISS_KEYGUARD
                        | WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);

        Intent service = new Intent(this, SleepTestService.class);
        service.setAction(SleepTestService.ACTION_ALARM_WAKE);
        startForegroundService(service);

        getWindow().getDecorView().postDelayed(this::finish, 800);
    }
}
