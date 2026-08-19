package com.ape.offlinescriptmanager.batterytool;

import android.content.BroadcastReceiver;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.widget.Toast;
import com.ape.offlinescriptmanager.database.e;
import com.ape.offlinescriptmanager.database.f;
import com.ape.offlinescriptmanager.database.h;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.i;
import java.io.PrintStream;
import java.text.DecimalFormat;
import java.util.Locale;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class BatteryChangeBroadcastReceiver extends BroadcastReceiver {

    /* renamed from: a  reason: collision with root package name */
    private SharedPreferences f1878a;

    /* renamed from: b  reason: collision with root package name */
    private SharedPreferences.Editor f1879b;

    /* renamed from: c  reason: collision with root package name */
    private int f1880c;

    /* renamed from: d  reason: collision with root package name */
    private int f1881d;
    private String e;
    private float f;
    private long g;
    private int h;
    private double i;
    private Context j;

    private String a(long j) {
        StringBuilder sb = new StringBuilder();
        int i = (int) (j % 60);
        int i2 = (int) ((j / 60) % 60);
        int i3 = (int) (j / 3600);
        if (i3 != 0) {
            sb.append(i3 + "h");
        }
        if (i3 != 0 || i2 != 0) {
            sb.append(i2 + "m");
        }
        sb.append(i + "s");
        return sb.toString();
    }

    private String b(long j, long j2) {
        long j3 = (j2 - j) / 1000;
        PrintStream printStream = System.out;
        printStream.println("viking flag -----------------" + a(j3));
        return a(j3);
    }

    private String c(long j, long j2) {
        String n = g.n(j);
        String n2 = g.n(j2);
        return n + "~" + n2;
    }

    private void e(int i, String str, String str2, int i2, long j) {
        String str3 = this.f1878a.getInt(str, 0) + "%~" + i2 + "%";
        String b2 = b(this.f1878a.getLong(str2, 0L), j);
        String c2 = c(this.f1878a.getLong(str2, 0L), j);
        this.f1879b.putInt(str, i2).commit();
        this.f1879b.putLong(str2, j).commit();
        i.b("recording usedtime : percentRange: " + str3 + " , timeSpend : " + b2);
        if (i == 1) {
            g(str3, b2, c2);
        } else if (i == 2) {
            i(str3, b2, c2);
        } else if (i != 10) {
        } else {
            j(str3, b2, c2);
        }
    }

    private void f(String str, String str2) {
        i.b("recording hop data is : " + str + " , " + str2);
        ContentValues contentValues = new ContentValues();
        StringBuilder sb = new StringBuilder();
        sb.append(this.j.getString(R.string.hop_time_range));
        sb.append(str);
        contentValues.put("hop_time", sb.toString());
        contentValues.put("hop_range", this.j.getString(R.string.hop_percent_range) + str2);
        this.j.getContentResolver().insert(com.ape.offlinescriptmanager.database.b.f1973a, contentValues);
    }

    public boolean d(int i, int i2) {
        int i3 = this.f1878a.getInt("used_percent", 0);
        if (Math.abs(i3 - i) < i2) {
            if (i != 0 || i3 == 0) {
                return i == 100 && i3 != 100;
            }
            return true;
        }
        return true;
    }

    public void g(String str, String str2, String str3) {
        ContentValues contentValues = new ContentValues();
        contentValues.put("range", str);
        contentValues.put("used_time", str2);
        contentValues.put("time_range", str3);
        this.j.getContentResolver().insert(e.f1979a, contentValues);
    }

    public void h(long j, int i, double d2) {
        i.b("recording percentage is : " + i);
        ContentValues contentValues = new ContentValues();
        contentValues.put("time", Long.valueOf(j));
        contentValues.put("percentage", Integer.valueOf(i));
        contentValues.put("temperature", Double.valueOf(d2));
        this.j.getContentResolver().insert(com.ape.offlinescriptmanager.database.c.f1975a, contentValues);
    }

    public void i(String str, String str2, String str3) {
        ContentValues contentValues = new ContentValues();
        contentValues.put("range", str);
        contentValues.put("used_time", str2);
        contentValues.put("time_range", str3);
        this.j.getContentResolver().insert(com.ape.offlinescriptmanager.database.g.f1983a, contentValues);
    }

    public void j(String str, String str2, String str3) {
        i.b("recording usedtime is : " + str + " : " + str2);
        ContentValues contentValues = new ContentValues();
        contentValues.put("range", str);
        contentValues.put("used_time", str2);
        contentValues.put("time_range", str3);
        this.j.getContentResolver().insert(f.f1981a, contentValues);
    }

    public void k(long j, String str, double d2) {
        i.b("recording voltage is : " + str);
        ContentValues contentValues = new ContentValues();
        contentValues.put("time", Long.valueOf(j));
        contentValues.put("voltage", str);
        contentValues.put("temperature", Double.valueOf(d2));
        this.j.getContentResolver().insert(h.f1984a, contentValues);
    }

    @Override // android.content.BroadcastReceiver
    public void onReceive(Context context, Intent intent) {
        this.j = context;
        SharedPreferences sharedPreferences = context.getSharedPreferences("update_data", 0);
        this.f1878a = sharedPreferences;
        this.f1879b = sharedPreferences.edit();
        Locale.setDefault(Locale.CHINA);
        DecimalFormat decimalFormat = new DecimalFormat("#0.00");
        DecimalFormat decimalFormat2 = new DecimalFormat("#0.0");
        if (this.f1878a.getBoolean("isUpdating", false)) {
            this.f1880c = intent.getIntExtra("level", -1);
            this.f1881d = intent.getIntExtra("scale", -1);
            float intExtra = intent.getIntExtra("voltage", -1) / 1000.0f;
            this.f = intExtra;
            this.e = decimalFormat.format(intExtra);
            this.h = (this.f1880c * 100) / this.f1881d;
            this.i = Double.valueOf(decimalFormat2.format(intent.getIntExtra("temperature", 0) * 0.1d)).doubleValue();
            this.g = System.currentTimeMillis();
            if (this.f1878a.getBoolean("isFirst", true)) {
                this.f1879b.putBoolean("isFirst", false).commit();
                this.f1879b.putInt("onePercentage", this.h).commit();
                this.f1879b.putLong("oneUsedTime", this.g).commit();
                this.f1879b.putInt("used_percent", this.h).commit();
                this.f1879b.putLong("used_time", this.g).commit();
                this.f1879b.putFloat("temperature", (float) this.i).commit();
                h(this.g, this.h, this.i);
                k(this.g, this.e, this.i);
            }
            if (this.f1878a.getInt("percentage", 0) != this.h) {
                if (Math.abs(this.f1878a.getInt("onePercentage", 0) - this.h) == 1) {
                    e(1, "onePercentage", "oneUsedTime", this.h, this.g);
                } else {
                    this.f1879b.putInt("onePercentage", this.h).commit();
                    this.f1879b.putLong("oneUsedTime", this.g).commit();
                }
                if (d(this.h, 10)) {
                    e(10, "used_percent", "used_time", this.h, this.g);
                }
                if (Math.abs(this.f1878a.getInt("percentage", 0) - this.h) > 1) {
                    if (this.f1878a.getBoolean("hop_first", false)) {
                        int i = this.f1878a.getInt("percentage", 0);
                        String c2 = c(this.f1878a.getLong("last_time", 0L), System.currentTimeMillis());
                        f(c2, i + "%~" + this.h + "%");
                        Toast.makeText(this.j, (int) R.string.hop_data_record_message, 0).show();
                    }
                    this.f1879b.putBoolean("hop_first", true).commit();
                }
                this.f1879b.putInt("percentage", this.h).commit();
                this.f1879b.putLong("last_time", this.g).commit();
                this.f1879b.putFloat("temperature", (float) this.i).commit();
                h(this.g, this.h, this.i);
            }
            if (Math.abs(this.f1878a.getFloat("voltage", 0.0f) - this.f) >= 0.05f) {
                this.f1879b.putFloat("voltage", this.f).commit();
                k(this.g, this.e, this.i);
            }
        }
    }
}
