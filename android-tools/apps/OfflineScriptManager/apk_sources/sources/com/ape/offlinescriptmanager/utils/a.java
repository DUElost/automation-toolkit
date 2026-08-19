package com.ape.offlinescriptmanager.utils;

import android.app.ActivityManager;
import android.app.AlertDialog;
import android.content.ContentResolver;
import android.content.ContentValues;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.BatteryManager;
import android.os.Environment;
import android.util.Log;
import java.lang.reflect.InvocationTargetException;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class a {
    private static a e;

    /* renamed from: a  reason: collision with root package name */
    private Context f2064a;

    /* renamed from: b  reason: collision with root package name */
    private ActivityManager f2065b;

    /* renamed from: c  reason: collision with root package name */
    private PackageManager f2066c;

    /* renamed from: d  reason: collision with root package name */
    private BatteryManager f2067d;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.ape.offlinescriptmanager.utils.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class DialogInterface$OnClickListenerC0081a implements DialogInterface.OnClickListener {
        DialogInterface$OnClickListenerC0081a(a aVar) {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
        }
    }

    public a(Context context) {
        this.f2065b = null;
        this.f2066c = null;
        this.f2067d = null;
        this.f2064a = context;
        this.f2065b = (ActivityManager) context.getSystemService("activity");
        this.f2066c = this.f2064a.getPackageManager();
        this.f2067d = (BatteryManager) this.f2064a.getSystemService("batterymanager");
    }

    public static synchronized a c(Context context) {
        a aVar;
        synchronized (a.class) {
            if (e == null) {
                e = new a(context);
            }
            aVar = e;
        }
        return aVar;
    }

    public void a() {
        SharedPreferences sharedPreferences = this.f2064a.getSharedPreferences("update_data", 0);
        SharedPreferences.Editor edit = sharedPreferences.edit();
        boolean z = sharedPreferences.getBoolean("isUpdating", false);
        edit.clear();
        edit.commit();
        ContentResolver contentResolver = this.f2064a.getContentResolver();
        contentResolver.delete(com.ape.offlinescriptmanager.database.h.f1984a, null, null);
        contentResolver.delete(com.ape.offlinescriptmanager.database.c.f1975a, null, null);
        contentResolver.delete(com.ape.offlinescriptmanager.database.f.f1981a, null, null);
        contentResolver.delete(com.ape.offlinescriptmanager.database.e.f1979a, null, null);
        contentResolver.delete(com.ape.offlinescriptmanager.database.g.f1983a, null, null);
        contentResolver.delete(com.ape.offlinescriptmanager.database.b.f1973a, null, null);
        contentResolver.delete(com.ape.offlinescriptmanager.database.d.f1977a, null, null);
        if (z) {
            edit.putBoolean("isUpdating", true).commit();
        }
    }

    public int b() {
        if (this.f2067d != null) {
            this.f2067d = (BatteryManager) this.f2064a.getSystemService("batterymanager");
        }
        return this.f2067d.getIntProperty(4);
    }

    public boolean d(Class<?> cls) {
        for (ActivityManager.RunningServiceInfo runningServiceInfo : this.f2065b.getRunningServices(Integer.MAX_VALUE)) {
            if (cls.getName().equals(runningServiceInfo.service.getClassName())) {
                return true;
            }
        }
        return false;
    }

    public boolean e(long j) {
        return Environment.getExternalStorageState().equals("mounted") && Environment.getExternalStorageDirectory().getFreeSpace() > (j * 1024) * 1024;
    }

    public void f(String str) {
        for (PackageInfo packageInfo : this.f2066c.getInstalledPackages(0)) {
            if (packageInfo.packageName.contains(str) || packageInfo.packageName.endsWith(".test")) {
                Log.v("AndroidUtil", "processName:" + packageInfo.packageName);
                try {
                    Class.forName("android.app.ActivityManager").getMethod("forceStopPackage", String.class).invoke(this.f2065b, packageInfo.packageName);
                } catch (ClassNotFoundException e2) {
                    e2.printStackTrace();
                } catch (IllegalAccessException e3) {
                    e3.printStackTrace();
                } catch (NoSuchMethodException e4) {
                    e4.printStackTrace();
                } catch (InvocationTargetException e5) {
                    e5.printStackTrace();
                }
            }
        }
    }

    public void g(String str, String str2, long j, long j2, int i, int i2, int i3) {
        i.b("recording test result is about : " + str);
        ContentValues contentValues = new ContentValues();
        contentValues.put("name", str);
        contentValues.put("status", str2);
        contentValues.put("start_time", Long.valueOf(j));
        contentValues.put("stop_time", Long.valueOf(j2));
        contentValues.put("start_battery_percentage", Integer.valueOf(i));
        contentValues.put("stop_battery_percentage", Integer.valueOf(i2));
        contentValues.put("regression", Integer.valueOf(i3));
        this.f2064a.getContentResolver().insert(com.ape.offlinescriptmanager.database.d.f1977a, contentValues);
    }

    public void h(String str, String str2, boolean z) {
        this.f2064a.getSharedPreferences(str, 0).edit().putBoolean(str2, z).commit();
    }

    public void i(String str, String str2, String str3) {
        AlertDialog.Builder builder = new AlertDialog.Builder(this.f2064a);
        builder.setTitle(str).setMessage(str2);
        builder.setPositiveButton(str3, new DialogInterface$OnClickListenerC0081a(this));
        AlertDialog create = builder.create();
        create.getWindow().setType(2008);
        create.getWindow().setType(2003);
        create.setCancelable(false);
        create.show();
    }

    public void j(Context context) {
        i(context.getString(R.string.dialog_alert_title), context.getString(R.string.show_no_space_notice), context.getString(17039370));
    }
}
