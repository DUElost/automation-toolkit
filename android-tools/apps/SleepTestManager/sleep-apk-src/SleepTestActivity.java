package com.mediatek.schpwronoff.sleeptest;

import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.os.PowerManager;
import android.provider.Settings;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.mediatek.schpwronoff.R;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 休眠唤醒测试入口（可由 PC deploy 脚本通过 adb 启动，无需手点）。
 */
public class SleepTestActivity extends AppCompatActivity {

    private static final long UI_REFRESH_MS = 1000L;

    private TextView statusView;
    private TextView scheduleView;
    private final Handler uiHandler = new Handler(Looper.getMainLooper());
    private final Runnable refreshRunnable = new Runnable() {
        @Override
        public void run() {
            updateStatus();
            uiHandler.postDelayed(this, UI_REFRESH_MS);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sleep_test);
        statusView = findViewById(R.id.sleep_test_status);
        scheduleView = findViewById(R.id.sleep_test_schedule);
        updateStatus();
        requestIgnoreBatteryOptimizations();

        Intent service = new Intent(this, SleepTestService.class);
        service.setAction(SleepTestService.ACTION_START);
        startForegroundService(service);
    }

    @Override
    protected void onResume() {
        super.onResume();
        updateStatus();
        uiHandler.post(refreshRunnable);
    }

    @Override
    protected void onPause() {
        uiHandler.removeCallbacks(refreshRunnable);
        super.onPause();
    }

    private void requestIgnoreBatteryOptimizations() {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            return;
        }
        PowerManager pm = (PowerManager) getSystemService(POWER_SERVICE);
        if (pm != null && pm.isIgnoringBatteryOptimizations(getPackageName())) {
            return;
        }
        try {
            Intent intent = new Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
            intent.setData(Uri.parse("package:" + getPackageName()));
            startActivity(intent);
        } catch (Exception ignored) {
        }
    }

    private void updateStatus() {
        int current = SleepTestPrefs.getCurrentCount(this);
        int total = SleepTestPrefs.getTestTimes(this);
        int wakeSec = SleepTestPrefs.getWakeSeconds(this);
        int sleepSec = SleepTestPrefs.getSleepSeconds(this);
        boolean running = SleepTestPrefs.isRunning(this);
        String phase = SleepTestPrefs.getPhase(this);
        String state = running ? phase.toUpperCase(Locale.US) : "IDLE";
        statusView.setText(getString(R.string.sleep_test_status_fmt,
                current, total, wakeSec, sleepSec, state));
        scheduleView.setText(buildScheduleText());
    }

    private String buildScheduleText() {
        long offAt = SleepTestPrefs.getNextScreenOffAt(this);
        long wakeAt = SleepTestPrefs.getNextWakeAt(this);
        return getString(R.string.sleep_test_schedule_fmt,
                formatScheduleTime(offAt),
                formatCountdown(offAt),
                formatScheduleTime(wakeAt),
                formatCountdown(wakeAt));
    }

    private String formatScheduleTime(long epochMs) {
        if (epochMs <= 0L) {
            return "--";
        }
        return new SimpleDateFormat("HH:mm:ss", Locale.getDefault()).format(new Date(epochMs));
    }

    private String formatCountdown(long epochMs) {
        if (epochMs <= 0L) {
            return "--";
        }
        long remainSec = (epochMs - System.currentTimeMillis() + 999L) / 1000L;
        if (remainSec < 0L) {
            remainSec = 0L;
        }
        return getString(R.string.sleep_test_countdown_sec_fmt, remainSec);
    }
}
