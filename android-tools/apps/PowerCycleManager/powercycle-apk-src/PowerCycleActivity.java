package com.mediatek.schpwronoff.powercycle;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Looper;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.mediatek.schpwronoff.R;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

/**
 * 开关机测试入口（可由 PC deploy 脚本通过 adb 启动，无需手点）。
 */
public class PowerCycleActivity extends AppCompatActivity {

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

    /**
     * 开机 / 闹钟唤醒后拉起界面，便于现场确认测试是否在跑。
     */
    public static void bringToFront(Context context) {
        Intent ui = new Intent(context, PowerCycleActivity.class);
        ui.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK
                | Intent.FLAG_ACTIVITY_CLEAR_TOP
                | Intent.FLAG_ACTIVITY_SINGLE_TOP
                | Intent.FLAG_ACTIVITY_REORDER_TO_FRONT);
        try {
            context.startActivity(ui);
        } catch (Exception ignored) {
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_power_cycle);
        statusView = findViewById(R.id.power_cycle_status);
        scheduleView = findViewById(R.id.power_cycle_schedule);

        updateStatus();
        Intent service = new Intent(this, PowerCycleService.class);
        service.setAction(PowerCycleService.ACTION_START);
        startForegroundService(service);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        updateStatus();
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

    private void updateStatus() {
        int current = PowerCyclePrefs.getCurrentCount(this);
        int total = PowerCyclePrefs.getTestTimes(this);
        String mode = PowerCyclePrefs.getMode(this);
        int waitSec = PowerCyclePrefs.getWaitSeconds(this);
        boolean running = PowerCyclePrefs.isRunning(this);
        String state = running ? "WAITING" : "IDLE";
        if (running && PowerCyclePrefs.getNextActionAt(this) > 0
                && System.currentTimeMillis() >= PowerCyclePrefs.getNextActionAt(this)) {
            state = PowerCyclePrefs.MODE_POWER_OFF.equals(mode) ? "POWERING_OFF" : "REBOOTING";
        }
        statusView.setText(getString(R.string.power_cycle_status_fmt,
                current, total, mode + " | wait=" + waitSec + "s", state));
        scheduleView.setText(buildScheduleText(mode));
    }

    private String buildScheduleText(String mode) {
        long actionAt = PowerCyclePrefs.getNextActionAt(this);
        if (PowerCyclePrefs.MODE_POWER_OFF.equals(mode)) {
            long powerOnAt = PowerCyclePrefs.getNextPowerOnAt(this);
            return getString(R.string.power_cycle_schedule_poweroff_fmt,
                    formatScheduleTime(actionAt),
                    formatCountdown(actionAt),
                    formatScheduleTime(powerOnAt),
                    formatCountdown(powerOnAt));
        }
        return getString(R.string.power_cycle_schedule_reboot_fmt,
                formatScheduleTime(actionAt),
                formatCountdown(actionAt));
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
        return getString(R.string.power_cycle_countdown_sec_fmt, remainSec);
    }
}
