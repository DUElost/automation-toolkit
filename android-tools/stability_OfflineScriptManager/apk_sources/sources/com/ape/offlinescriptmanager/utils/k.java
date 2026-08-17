package com.ape.offlinescriptmanager.utils;

import android.app.Activity;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.util.Log;
import android.widget.Toast;
/* loaded from: classes.dex */
public class k {

    /* renamed from: a  reason: collision with root package name */
    private Context f2082a;

    /* renamed from: b  reason: collision with root package name */
    private String f2083b = "2099-12-31 23:59:59";

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements DialogInterface.OnClickListener {
        a() {
        }

        @Override // android.content.DialogInterface.OnClickListener
        public void onClick(DialogInterface dialogInterface, int i) {
            ((Activity) k.this.f2082a).finish();
        }
    }

    public k(Context context) {
        this.f2082a = context;
    }

    public void b() {
        f("deadline", this.f2083b);
        f("latest", g.M(System.currentTimeMillis()));
        h();
        e();
    }

    public boolean c() {
        Log.d("TimeTips", "isPreferenceNull :" + this.f2083b.equals(this.f2082a.getSharedPreferences("timetips", 0).getString("deadline", this.f2083b)));
        return this.f2083b.equals(this.f2082a.getSharedPreferences("timetips", 0).getString("deadline", this.f2083b));
    }

    public boolean d() {
        try {
            String string = this.f2082a.getSharedPreferences("timetips", 0).getString("deadline", this.f2083b);
            Log.d("TimeTips", ",deadline:" + string);
            String string2 = this.f2082a.getSharedPreferences("timetips", 0).getString("latest", g.N(String.valueOf(System.currentTimeMillis())));
            Log.d("TimeTips", ",latest:" + string2);
            if (g.h(string2) > g.h(string)) {
                return true;
            }
            return System.currentTimeMillis() > g.h(string);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public void e() {
        if (d()) {
            g();
        } else if (c()) {
            try {
                String string = this.f2082a.getSharedPreferences("timetips", 0).getString("latest", g.N(String.valueOf(System.currentTimeMillis())));
                Log.d("TimeTips", ",mDefaultime:" + this.f2083b);
                Log.d("TimeTips", ",latest:" + string);
                if (g.h(string) > g.h(this.f2083b)) {
                    g();
                } else if (g.h(this.f2083b) < System.currentTimeMillis()) {
                    g();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public void f(String str, String str2) {
        SharedPreferences.Editor edit = this.f2082a.getSharedPreferences("timetips", 0).edit();
        edit.putString(str, str2);
        edit.apply();
    }

    public void g() {
        g.J(this.f2082a, "更新", "该app已经过期,请到ITMS下载更新版本!", new a(), null);
    }

    public void h() {
        Context context = this.f2082a;
        Toast.makeText(context, "App 使用有效期至:" + this.f2083b, 1).show();
    }
}
