package com.mediatek.schpwronoff.powercycle;

import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.mediatek.schpwronoff.R;

/**
 * 开关机测试入口（可由 PC deploy 脚本通过 adb 启动，无需手点）。
 */
public class PowerCycleActivity extends AppCompatActivity {

    private TextView statusView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_power_cycle);
        statusView = findViewById(R.id.power_cycle_status);

        updateStatus();
        Intent service = new Intent(this, PowerCycleService.class);
        service.setAction(PowerCycleService.ACTION_START);
        startForegroundService(service);
    }

    @Override
    protected void onResume() {
        super.onResume();
        updateStatus();
    }

    private void updateStatus() {
        int current = PowerCyclePrefs.getCurrentCount(this);
        int total = PowerCyclePrefs.getTestTimes(this);
        String mode = PowerCyclePrefs.getMode(this);
        boolean running = PowerCyclePrefs.isRunning(this);
        statusView.setText(getString(R.string.power_cycle_status_fmt,
                current, total, mode, running ? "RUNNING" : "IDLE"));
    }
}
