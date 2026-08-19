package com.ape.offlinescriptmanager.batterytool.g;

import android.annotation.SuppressLint;
import android.content.ContentResolver;
import android.content.Context;
import android.content.SharedPreferences;
import android.database.Cursor;
import android.os.Handler;
import android.os.Looper;
import android.os.Message;
import com.ape.offlinescriptmanager.batterytool.g.a;
import com.ape.offlinescriptmanager.database.d;
import com.ape.offlinescriptmanager.database.f;
import com.ape.offlinescriptmanager.database.h;
import com.ape.offlinescriptmanager.utils.e;
import com.ape.offlinescriptmanager.utils.g;
import com.ape.offlinescriptmanager.utils.i;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
/* loaded from: classes.dex */
public class b extends com.ape.offlinescriptmanager.batterytool.g.a {
    double A;
    List<List<a.C0070a>> B;
    List<a.C0070a> C;
    List<a.C0070a> D;
    List<String> E;
    List<String> F;
    @SuppressLint({"HandlerLeak"})
    private Handler G;
    private Context h;
    private c i;
    private String j;
    private String k;
    Cursor l;
    Cursor m;
    Cursor n;
    Cursor o;
    Cursor p;
    Cursor q;
    private boolean r;
    List<a.C0070a> s;
    private SharedPreferences t;
    private SharedPreferences u;
    private String v;
    private e w;
    DecimalFormat x;
    double y;
    double z;

    /* loaded from: classes.dex */
    class a extends Handler {
        a(Looper looper) {
            super(looper);
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            int i = message.what;
            if (i == 4) {
                try {
                    List<a.C0070a> list = b.this.s;
                    if (list != null && list.size() > 0) {
                        b bVar = b.this;
                        bVar.d(bVar.B, bVar.E, bVar.n(bVar.s.size(), b.this.k), BuildConfig.FLAVOR, b.this.v, b.this.k);
                    }
                } finally {
                }
            } else if (i != 5) {
            } else {
                try {
                    List<a.C0070a> list2 = b.this.s;
                    if (list2 != null && list2.size() > 0) {
                        b bVar2 = b.this;
                        bVar2.d(bVar2.B, bVar2.E, bVar2.n(bVar2.s.size(), b.this.j), BuildConfig.FLAVOR, b.this.v, b.this.j);
                    }
                } finally {
                }
            }
        }
    }

    public b(Context context, String str, boolean z, boolean z2) {
        super(context, str, z, z2);
        this.j = "1";
        this.k = "10";
        this.l = null;
        this.m = null;
        this.n = null;
        this.o = null;
        this.p = null;
        this.q = null;
        this.r = false;
        this.x = new DecimalFormat("#.00");
        this.h = context;
        this.w = new e();
        this.G = new a(this.h.getMainLooper());
    }

    private long k(String str) {
        long parseLong;
        String[] split = str.split("s");
        if (split[0].contains("m")) {
            String[] split2 = split[0].split("m");
            long parseLong2 = Long.parseLong(split2[1]);
            if (split2[0].contains("h")) {
                String[] split3 = split2[0].split("h");
                parseLong2 += Long.parseLong(split3[1]) * 60;
                parseLong = Long.parseLong(split3[0]) * 60;
            } else {
                parseLong = Long.parseLong(split2[0]);
            }
            return parseLong2 + (parseLong * 60);
        }
        return Long.parseLong(split[0]);
    }

    private void m() {
        ContentResolver contentResolver = this.h.getContentResolver();
        this.l = contentResolver.query(com.ape.offlinescriptmanager.database.c.f1975a, com.ape.offlinescriptmanager.database.c.f1976b, null, null, "time ASC");
        this.m = contentResolver.query(h.f1984a, h.f1985b, null, null, "time ASC");
        this.n = contentResolver.query(f.f1981a, f.f1982b, null, null, "_id ASC");
        this.o = contentResolver.query(com.ape.offlinescriptmanager.database.e.f1979a, com.ape.offlinescriptmanager.database.e.f1980b, null, null, "_id ASC");
        this.p = contentResolver.query(com.ape.offlinescriptmanager.database.b.f1973a, com.ape.offlinescriptmanager.database.b.f1974b, null, null, "_id ASC");
        this.q = contentResolver.query(d.f1977a, d.f1978b, null, null, "_id ASC");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public org.achartengine.h.d n(int i, String str) {
        int i2;
        new org.achartengine.h.d();
        int i3 = 0;
        org.achartengine.h.d a2 = g.a(new int[]{-65536, -16776961, -16711936}, new org.achartengine.f.d[]{org.achartengine.f.d.SQUARE, org.achartengine.f.d.CIRCLE, org.achartengine.f.d.TRIANGLE});
        a2.X(true);
        a2.b1(-12303292);
        double d2 = this.s.get(0).f1918a;
        List<a.C0070a> list = this.s;
        g.F(a2, "Every " + str + "% used time chart", "Time", "UsedTime", d2, list.get(list.size() - 1).f1918a, 0.0d, this.y * 2.0d, -16777216, -16777216);
        a2.N(-1);
        a2.l1(10);
        a2.t1(5);
        double d3 = this.s.get(0).f1918a;
        List<a.C0070a> list2 = this.s;
        List<Double> b2 = org.achartengine.j.b.b(d3, list2.get(list2.size() - 1).f1918a, 10);
        ArrayList arrayList = new ArrayList(b2);
        for (Double d4 : b2) {
            if (d4.isNaN()) {
                arrayList.remove(d4);
            }
        }
        if (this.F.size() > 10) {
            a2.d0(1.0d, this.F.get(0));
            while (i3 < arrayList.size()) {
                double doubleValue = ((Double) arrayList.get(i3)).doubleValue();
                a2.d0(doubleValue, this.F.get(((int) doubleValue) - 1));
                i.b("Renderer " + i3 + " is:" + doubleValue + "::::" + this.F.get(i2));
                i3++;
            }
            List<String> list3 = this.F;
            a2.d0(this.F.size(), list3.get(list3.size() - 1));
        } else {
            while (i3 < this.F.size()) {
                int i4 = i3 + 1;
                a2.d0(i4, this.F.get(i3));
                i3 = i4;
            }
        }
        return a2;
    }

    @Override // com.ape.offlinescriptmanager.batterytool.g.a
    protected void c(Boolean bool) {
        Cursor cursor = this.l;
        if (cursor != null && !cursor.isClosed()) {
            this.l.close();
        }
        Cursor cursor2 = this.m;
        if (cursor2 != null && !cursor2.isClosed()) {
            this.m.close();
        }
        Cursor cursor3 = this.n;
        if (cursor3 != null && !cursor3.isClosed()) {
            this.n.close();
        }
        Cursor cursor4 = this.o;
        if (cursor4 != null && !cursor4.isClosed()) {
            this.o.close();
        }
        Cursor cursor5 = this.p;
        if (cursor5 != null && !cursor5.isClosed()) {
            this.p.close();
        }
        Cursor cursor6 = this.q;
        if (cursor6 != null && !cursor6.isClosed()) {
            this.q.close();
        }
        super.onPostExecute(bool);
        new com.ape.offlinescriptmanager.utils.a(this.h).h("com.ape.offlinescriptmanager.pref", "export_battery_finish", true);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.os.AsyncTask
    /* renamed from: l */
    public Boolean doInBackground(Void... voidArr) {
        int i;
        String str;
        String str2;
        String str3;
        String str4;
        String str5;
        String str6;
        String str7;
        int i2;
        String string;
        int i3;
        String string2;
        int i4;
        String string3;
        int i5;
        String string4;
        int i6;
        m();
        if (this.l.getCount() != 0 || this.l.moveToNext() || this.m.getCount() != 0 || this.m.moveToNext() || this.q.getCount() != 0 || this.q.moveToNext()) {
            this.i = new c(this.h, this.f1917d, "battery");
            this.v = g.l(this.f1917d, "battery");
            this.u = this.h.getSharedPreferences("xuhang_data", 0);
            this.t = this.h.getSharedPreferences("circle_data", 0);
            this.B = new ArrayList();
            this.s = new ArrayList();
            this.C = new ArrayList();
            this.D = new ArrayList();
            this.E = new ArrayList();
            this.F = new ArrayList();
            List<com.ape.offlinescriptmanager.batterytool.f.b> b2 = this.w.b(this.l);
            int i7 = 1;
            if (b2 != null && b2.size() > 0) {
                int i8 = 2;
                for (com.ape.offlinescriptmanager.batterytool.f.b bVar : b2) {
                    a(0, i8, g.o(bVar.c()));
                    a(1, i8, bVar.a());
                    a(2, i8, Double.toString(bVar.b()));
                    i8++;
                }
                c cVar = this.i;
                cVar.d(cVar.f1923c, this.f);
                this.f.clear();
                b2.clear();
            }
            List<com.ape.offlinescriptmanager.batterytool.f.d> f = this.w.f(this.m);
            if (f != null && f.size() > 0) {
                int i9 = 2;
                for (com.ape.offlinescriptmanager.batterytool.f.d dVar : f) {
                    a(0, i9, g.o(dVar.b()));
                    a(1, i9, dVar.c());
                    a(2, i9, Double.toString(dVar.a()));
                    i9++;
                }
                c cVar2 = this.i;
                cVar2.d(cVar2.f1924d, this.f);
                this.f.clear();
                f.clear();
            }
            this.y = 0.0d;
            List<com.ape.offlinescriptmanager.batterytool.f.c> d2 = this.w.d(this.o);
            if (d2 != null && d2.size() > 0) {
                for (com.ape.offlinescriptmanager.batterytool.f.c cVar3 : d2) {
                    this.y += k(cVar3.c());
                }
                double size = this.y / d2.size();
                this.y = size;
                double d3 = size * 1.4d;
                this.z = d3;
                String format = this.x.format(d3);
                double d4 = this.y * 0.6d;
                this.A = d4;
                String format2 = this.x.format(d4);
                int i10 = 0;
                int i11 = 2;
                for (com.ape.offlinescriptmanager.batterytool.f.c cVar4 : d2) {
                    int i12 = i10 + i7;
                    a.C0070a c0070a = new a.C0070a(this);
                    c0070a.f1919b = k(cVar4.c());
                    c0070a.f1918a = i12;
                    this.s.add(c0070a);
                    this.F.add(cVar4.a());
                    a.C0070a c0070a2 = new a.C0070a(this);
                    c0070a2.f1919b = this.z;
                    c0070a2.f1918a = c0070a.f1918a;
                    this.C.add(c0070a2);
                    a.C0070a c0070a3 = new a.C0070a(this);
                    c0070a3.f1919b = this.A;
                    c0070a3.f1918a = c0070a.f1918a;
                    this.D.add(c0070a3);
                    a(0, i11, cVar4.a());
                    a(1, i11, Long.toString(k(cVar4.c())));
                    a(2, i11, cVar4.b());
                    a(3, i11, format);
                    a(4, i11, format2);
                    i11++;
                    i10 = i12;
                    d2 = d2;
                    i7 = 1;
                }
                List<com.ape.offlinescriptmanager.batterytool.f.c> list = d2;
                this.B.add(this.C);
                this.E.add("Upper limit");
                this.B.add(this.s);
                this.E.add("Every " + this.j + "% used time");
                this.B.add(this.D);
                this.E.add("Lower limit");
                a(0, i11, this.h.getString(R.string.battery_usetime_average));
                a(1, i11, this.x.format(this.y));
                int i13 = i11 + 1;
                a(0, i13, this.h.getString(R.string.battery_usetime_upper_limit));
                a(1, i13, format);
                int i14 = i13 + 1;
                a(0, i14, this.h.getString(R.string.battery_usetime_lower_limit));
                a(1, i14, format2);
                this.r = false;
                Message message = new Message();
                message.what = 5;
                this.G.sendMessage(message);
                while (!this.r) {
                    try {
                        TimeUnit.MILLISECONDS.sleep(500L);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
                c cVar5 = this.i;
                cVar5.d(cVar5.e, this.f);
                c cVar6 = this.i;
                cVar6.c(cVar6.e, 5.0d, 1.0d, 8.0d, 23.0d, this.j);
                this.f.clear();
                list.clear();
            }
            List<com.ape.offlinescriptmanager.batterytool.f.c> e2 = this.w.e(this.n);
            this.B.clear();
            this.s.clear();
            this.C.clear();
            this.D.clear();
            this.F.clear();
            this.E.clear();
            this.y = 0.0d;
            if (e2 != null && e2.size() > 0) {
                for (com.ape.offlinescriptmanager.batterytool.f.c cVar7 : e2) {
                    this.y += k(cVar7.c());
                }
                double size2 = this.y / e2.size();
                this.y = size2;
                double d5 = size2 * 1.4d;
                this.z = d5;
                String format3 = this.x.format(d5);
                double d6 = this.y * 0.6d;
                this.A = d6;
                String format4 = this.x.format(d6);
                Iterator<com.ape.offlinescriptmanager.batterytool.f.c> it = e2.iterator();
                int i15 = 0;
                int i16 = 2;
                while (it.hasNext()) {
                    com.ape.offlinescriptmanager.batterytool.f.c next = it.next();
                    int i17 = i15 + 1;
                    a.C0070a c0070a4 = new a.C0070a(this);
                    c0070a4.f1919b = k(next.c());
                    c0070a4.f1918a = i17;
                    this.s.add(c0070a4);
                    i.b("usedHelper00 x:" + c0070a4.f1918a + "::" + next.a().split("%~")[0]);
                    this.F.add(next.a());
                    a.C0070a c0070a5 = new a.C0070a(this);
                    Iterator<com.ape.offlinescriptmanager.batterytool.f.c> it2 = it;
                    c0070a5.f1919b = this.z;
                    c0070a5.f1918a = c0070a4.f1918a;
                    this.C.add(c0070a5);
                    a.C0070a c0070a6 = new a.C0070a(this);
                    c0070a6.f1919b = this.A;
                    c0070a6.f1918a = c0070a4.f1918a;
                    this.D.add(c0070a6);
                    a(0, i16, next.a());
                    a(1, i16, Long.toString(k(next.c())));
                    a(2, i16, next.b());
                    a(3, i16, format3);
                    a(4, i16, format4);
                    i16++;
                    it = it2;
                    i15 = i17;
                }
                this.B.add(this.C);
                this.E.add("Upper limit");
                this.B.add(this.s);
                this.E.add("Every " + this.k + "% used time");
                this.B.add(this.D);
                this.E.add("Lower limit");
                a(0, i16, this.h.getString(R.string.battery_usetime_average));
                a(1, i16, this.x.format(this.y));
                int i18 = i16 + 1;
                a(0, i18, this.h.getString(R.string.battery_usetime_upper_limit));
                a(1, i18, format3);
                int i19 = i18 + 1;
                a(0, i19, this.h.getString(R.string.battery_usetime_lower_limit));
                a(1, i19, format4);
                this.r = false;
                Message message2 = new Message();
                message2.what = 4;
                this.G.sendMessage(message2);
                while (!this.r) {
                    try {
                        TimeUnit.MILLISECONDS.sleep(500L);
                    } catch (InterruptedException e3) {
                        e3.printStackTrace();
                    }
                }
                c cVar8 = this.i;
                cVar8.d(cVar8.f, this.f);
                c cVar9 = this.i;
                cVar9.c(cVar9.f, 5.0d, 1.0d, 8.0d, 23.0d, this.k);
                this.f.clear();
                e2.clear();
            }
            this.n.close();
            List<com.ape.offlinescriptmanager.batterytool.f.a> a2 = this.w.a(this.p);
            if (a2 != null && a2.size() > 0) {
                int i20 = 2;
                for (com.ape.offlinescriptmanager.batterytool.f.a aVar : a2) {
                    a(0, i20, aVar.a());
                    a(1, i20, aVar.b());
                    i20++;
                }
                c cVar10 = this.i;
                cVar10.d(cVar10.g, this.f);
                this.f.clear();
                a2.clear();
            }
            List<b.b.a.a.b.h> c2 = this.w.c(this.q);
            int i21 = 6;
            if (c2 != null && c2.size() > 0) {
                b.b.a.a.b.h hVar = null;
                int i22 = 2;
                for (b.b.a.a.b.h hVar2 : c2) {
                    String str8 = hVar2.h().get("startbattery");
                    String str9 = hVar2.h().get("stopbattery");
                    String str10 = hVar2.h().get("regression");
                    if (hVar == null || !hVar2.g().equals(hVar.g()) || Integer.valueOf(str10).intValue() <= 0) {
                        a(0, i22, hVar2.g());
                        a(1, i22, hVar2.j().a());
                        a(2, i22, g.n(hVar2.i()));
                        a(3, i22, g.n(hVar2.e()));
                        a(4, i22, g.j(hVar2.e() - hVar2.i()));
                        a(5, i22, String.valueOf(str8) + "%");
                        a(6, i22, String.valueOf(str9) + "%");
                        a(7, i22, String.valueOf(Integer.valueOf(str9).intValue() - Integer.valueOf(str8).intValue()) + "%");
                        a(8, i22, str10);
                        hVar = hVar2;
                        i6 = 1;
                    } else {
                        i22--;
                        a(3, i22, g.n(hVar2.e()));
                        a(4, i22, g.j(hVar2.e() - hVar.i()));
                        a(6, i22, String.valueOf(str9) + "%");
                        a(7, i22, String.valueOf(Integer.valueOf(str9).intValue() - Integer.valueOf(hVar.h().get("startbattery")).intValue()) + "%");
                        a(8, i22, str10);
                        i6 = 1;
                        a(1, i22, hVar2.j().a());
                    }
                    i22 += i6;
                }
                c cVar11 = this.i;
                cVar11.d(cVar11.i, this.f);
                this.f.clear();
                c2.clear();
            }
            int i23 = this.u.getInt("xuhang_count", 1);
            int i24 = 11;
            i.a("current count is :----------------" + i23);
            int i25 = 0;
            while (i25 < i23) {
                i.a("current a is :----------------" + i25);
                if (i25 >= 1) {
                    int i26 = i25 + 1;
                    i = (i25 * 11) + i26;
                    a(0, i, String.format(this.h.getString(R.string.str_times), Integer.valueOf(i26)));
                } else {
                    i = 1;
                }
                int i27 = i;
                int i28 = 0;
                while (i28 < i24) {
                    i27++;
                    i.b("current v is: " + i28 + " z is: " + i27);
                    switch (i28) {
                        case 0:
                            a(0, i27, this.h.getString(R.string.str_call));
                            str = "call_start_time";
                            str2 = "call_end_time";
                            str3 = "call_start_percentage";
                            str4 = "call_end_percentage";
                            str5 = "call_start_temperature";
                            str6 = "call_end_temperature";
                            str7 = str6;
                            break;
                        case 1:
                            a(0, i27, this.h.getString(R.string.str_call_times));
                            str = "call_times_start_time";
                            str2 = "call_times_end_time";
                            str3 = "call_times_start_percentage";
                            str4 = "call_times_end_percentage";
                            str5 = "call_times_start_temperature";
                            str6 = "call_times_end_temperature";
                            str7 = str6;
                            break;
                        case 2:
                            a(0, i27, this.h.getString(R.string.str_browseweb));
                            str = "browseweb_start_time";
                            str2 = "browseweb_end_time";
                            str3 = "browseweb_start_percentage";
                            str4 = "browseweb_end_percentage";
                            str5 = "browseweb_start_temperature";
                            str6 = "browseweb_end_temperature";
                            str7 = str6;
                            break;
                        case 3:
                            a(0, i27, this.h.getString(R.string.str_playvideo));
                            str = "playvideo_start_time";
                            str2 = "playvideo_end_time";
                            str3 = "playvideo_start_percentage";
                            str4 = "playvideo_end_percentage";
                            str5 = "playvideo_start_temperature";
                            str6 = "playvideo_end_temperature";
                            str7 = str6;
                            break;
                        case 4:
                            a(0, i27, this.h.getString(R.string.str_tdgame));
                            str = "tdgame_start_time";
                            str2 = "tdgame_end_time";
                            str3 = "tdgame_start_percentage";
                            str4 = "tdgame_end_percentage";
                            str5 = "tdgame_start_temperature";
                            str6 = "tdgame_end_temperature";
                            str7 = str6;
                            break;
                        case 5:
                            a(0, i27, this.h.getString(R.string.str_video));
                            str = "video_start_time";
                            str2 = "video_end_time";
                            str3 = "video_start_percentage";
                            str4 = "video_end_percentage";
                            str5 = "video_start_temperature";
                            str6 = "video_end_temperature";
                            str7 = str6;
                            break;
                        case 6:
                            a(0, i27, this.h.getString(R.string.str_camera));
                            str = "camera_start_time";
                            str2 = "camera_end_time";
                            str3 = "camera_start_percentage";
                            str4 = "camera_end_percentage";
                            str5 = "camera_start_temperature";
                            str6 = "camera_end_temperature";
                            str7 = str6;
                            break;
                        case 7:
                            a(0, i27, this.h.getString(R.string.str_ebook));
                            str = "music_ebook_start_time";
                            str2 = "music_ebook_end_time";
                            str3 = "music_ebook_start_percentage";
                            str4 = "music_ebook_end_percentage";
                            str5 = "music_ebook_start_temperature";
                            str6 = "music_ebook_end_temperature";
                            str7 = str6;
                            break;
                        case 8:
                            a(0, i27, this.h.getString(R.string.str_download));
                            str = "download_start_time";
                            str2 = "download_end_time";
                            str3 = "download_start_percentage";
                            str4 = "download_end_percentage";
                            str5 = "download_start_temperature";
                            str6 = "download_end_temperature";
                            str7 = str6;
                            break;
                        case 9:
                            a(0, i27, this.h.getString(R.string.str_music_low));
                            str = "music_start_time";
                            str2 = "music_end_time";
                            str3 = "music_start_percentage";
                            str4 = "music_end_percentage";
                            str5 = "music_start_temperature";
                            str6 = "music_end_temperature";
                            str7 = str6;
                            break;
                        case 10:
                            a(0, i27, this.h.getString(R.string.str_videotape_low));
                            str = "videocamera_start_time";
                            str2 = "videocamera_end_time";
                            str3 = "videocamera_start_percentage";
                            str4 = "videocamera_end_percentage";
                            str5 = "videocamera_start_temperature";
                            str6 = "videocamera_end_temperature";
                            str7 = str6;
                            break;
                        default:
                            str = BuildConfig.FLAVOR;
                            str7 = str;
                            str2 = str7;
                            str3 = str2;
                            str4 = str3;
                            str5 = str4;
                            break;
                    }
                    i.b("start time string : " + str);
                    SharedPreferences sharedPreferences = this.t;
                    StringBuilder sb = new StringBuilder();
                    sb.append(str);
                    int i29 = i25 + 1;
                    sb.append(i29);
                    String string5 = sharedPreferences.getString(sb.toString(), null);
                    if (string5 == null) {
                        string5 = this.h.getString(R.string.no_data);
                    }
                    a(1, i27, string5);
                    String string6 = this.t.getString(str2 + i29, null);
                    if (string6 == null) {
                        string6 = this.h.getString(R.string.no_data);
                    }
                    a(2, i27, string6);
                    int i30 = this.t.getInt(str3 + i29, 0);
                    if (i30 != 0) {
                        string = i30 + BuildConfig.FLAVOR;
                        i2 = 3;
                    } else {
                        i2 = 3;
                        string = this.h.getString(R.string.no_data);
                    }
                    a(i2, i27, string);
                    int i31 = this.t.getInt(str4 + i29, 0);
                    if (i31 != 0) {
                        string2 = i31 + BuildConfig.FLAVOR;
                        i3 = 4;
                    } else {
                        i3 = 4;
                        string2 = this.h.getString(R.string.no_data);
                    }
                    a(i3, i27, string2);
                    float f2 = this.t.getFloat(str5 + i29, 0.0f);
                    if (f2 != 0.0f) {
                        string3 = f2 + BuildConfig.FLAVOR;
                        i4 = 5;
                    } else {
                        i4 = 5;
                        string3 = this.h.getString(R.string.no_data);
                    }
                    a(i4, i27, string3);
                    float f3 = this.t.getFloat(str7 + i29, 0.0f);
                    if (f3 != 0.0f) {
                        string4 = f3 + BuildConfig.FLAVOR;
                        i5 = 6;
                    } else {
                        i5 = 6;
                        string4 = this.h.getString(R.string.no_data);
                    }
                    a(i5, i27, string4);
                    i28++;
                    i21 = i5;
                    i24 = 11;
                }
                i25++;
                i24 = 11;
            }
            c cVar12 = this.i;
            cVar12.d(cVar12.h, this.f);
            this.f.clear();
            this.i.b();
            this.i.a();
            this.i = null;
            b(this.v);
            return Boolean.TRUE;
        }
        return Boolean.FALSE;
    }
}
