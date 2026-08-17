package com.ape.offlinescriptmanager.batterytool;

import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.IBinder;
/* loaded from: classes.dex */
public class UpdateDataService extends Service {

    /* renamed from: b  reason: collision with root package name */
    private BatteryChangeBroadcastReceiver f1884b;

    @Override // android.app.Service
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override // android.app.Service
    public void onCreate() {
        super.onCreate();
    }

    @Override // android.app.Service
    public void onDestroy() {
        BatteryChangeBroadcastReceiver batteryChangeBroadcastReceiver = this.f1884b;
        if (batteryChangeBroadcastReceiver != null) {
            unregisterReceiver(batteryChangeBroadcastReceiver);
        }
        super.onDestroy();
    }

    @Override // android.app.Service
    public int onStartCommand(Intent intent, int i, int i2) {
        this.f1884b = new BatteryChangeBroadcastReceiver();
        IntentFilter intentFilter = new IntentFilter();
        intentFilter.addAction("android.intent.action.BATTERY_CHANGED");
        registerReceiver(this.f1884b, intentFilter);
        return 1;
    }
}
