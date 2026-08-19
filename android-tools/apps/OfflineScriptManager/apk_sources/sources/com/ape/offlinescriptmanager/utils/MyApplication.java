package com.ape.offlinescriptmanager.utils;

import android.annotation.SuppressLint;
import android.app.Application;
import android.widget.Toast;
/* loaded from: classes.dex */
public class MyApplication extends Application {

    /* renamed from: b  reason: collision with root package name */
    public static MyApplication f2062b;

    /* renamed from: c  reason: collision with root package name */
    private static Toast f2063c;

    public static MyApplication a() {
        return f2062b;
    }

    @SuppressLint({"ShowToast"})
    public void b(String str) {
        Toast toast = f2063c;
        if (toast == null) {
            f2063c = Toast.makeText(this, str, 0);
            return;
        }
        toast.cancel();
        f2063c.setText(str);
        f2063c.show();
    }

    @Override // android.app.Application
    public void onCreate() {
        super.onCreate();
        d.a().b(this);
        b.h("Start Crashhandler");
        f2062b = this;
    }
}
