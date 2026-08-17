package com.ape.offlinescriptmanager.utils;

import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Environment;
import android.os.Process;
import android.util.Log;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.Thread;
import java.text.SimpleDateFormat;
import java.util.Date;
/* loaded from: classes.dex */
public class d implements Thread.UncaughtExceptionHandler {

    /* renamed from: b  reason: collision with root package name */
    private static final String f2070b;

    /* renamed from: c  reason: collision with root package name */
    private static Thread.UncaughtExceptionHandler f2071c;

    /* renamed from: d  reason: collision with root package name */
    private static d f2072d;

    /* renamed from: a  reason: collision with root package name */
    private Context f2073a;

    static {
        StringBuilder sb = new StringBuilder();
        sb.append(Environment.getExternalStorageDirectory().getPath());
        String str = File.separator;
        sb.append(str);
        sb.append("results");
        sb.append(str);
        sb.append("crash");
        f2070b = sb.toString();
        f2072d = new d();
    }

    private d() {
    }

    public static d a() {
        return f2072d;
    }

    private void c(Throwable th) {
        if (!Environment.getExternalStorageState().equals("mounted")) {
            Log.v("CrashHandler", "No Sdcard Return");
            return;
        }
        String str = f2070b;
        File file = new File(str);
        if (!file.exists()) {
            file.mkdirs();
        }
        String format = new SimpleDateFormat("yyyyMMdd_HHmmss").format(new Date(System.currentTimeMillis()));
        File file2 = new File(str + File.separator + "crash_" + format + ".log");
        PrintWriter printWriter = new PrintWriter(new BufferedWriter(new FileWriter(file2)));
        StringBuilder sb = new StringBuilder();
        sb.append("Crash Log Path: ");
        sb.append(file2.getAbsolutePath());
        Log.e("CrashHandler", sb.toString());
        printWriter.println(format);
        PackageInfo packageInfo = this.f2073a.getPackageManager().getPackageInfo(this.f2073a.getPackageName(), 1);
        printWriter.println("App Version:" + packageInfo.versionName + "_" + packageInfo.versionCode);
        printWriter.println("OS version:" + Build.VERSION.RELEASE + "_" + Build.VERSION.SDK_INT);
        StringBuilder sb2 = new StringBuilder();
        sb2.append("Vendor:");
        sb2.append(Build.MANUFACTURER);
        printWriter.println(sb2.toString());
        printWriter.println("Model:" + Build.MODEL);
        printWriter.println("CPU ABI:" + Build.CPU_ABI);
        th.printStackTrace(printWriter);
        printWriter.close();
    }

    public void b(Context context) {
        f2071c = Thread.getDefaultUncaughtExceptionHandler();
        Thread.setDefaultUncaughtExceptionHandler(this);
        this.f2073a = context.getApplicationContext();
    }

    @Override // java.lang.Thread.UncaughtExceptionHandler
    public void uncaughtException(Thread thread, Throwable th) {
        try {
            c(th);
            Log.v("CrashHandler", "writeToSDcard");
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e2) {
            e2.printStackTrace();
        }
        Thread.UncaughtExceptionHandler uncaughtExceptionHandler = f2071c;
        if (uncaughtExceptionHandler != null) {
            uncaughtExceptionHandler.uncaughtException(thread, th);
        } else {
            Process.killProcess(Process.myPid());
        }
    }
}
