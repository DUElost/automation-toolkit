package com.ape.offlinescriptmanager.utils.l;

import android.util.Log;
import c.d.a;
import java.io.PrintStream;
import java.util.HashMap;
import java.util.Map;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class h {

    /* renamed from: c  reason: collision with root package name */
    private static boolean f2101c = true;

    /* renamed from: a  reason: collision with root package name */
    private Map<String, Object> f2102a;

    /* renamed from: b  reason: collision with root package name */
    private c.c.a.d f2103b = new c.c.a.d();

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            a.C0066a a2 = c.d.a.a(1);
            a.b b2 = a2.b(8);
            b2.q(1);
            boolean a3 = b2.a("tcp://172.16.21.56:6906");
            PrintStream printStream = System.out;
            printStream.println("The socket is connect :" + a3);
            try {
                try {
                    String a4 = h.this.f2103b.a(h.this.d());
                    b2.m("-1");
                    b2.m("INFO");
                    b2.m("name");
                    boolean e = b2.e(a4);
                    PrintStream printStream2 = System.out;
                    printStream2.println("The zmq messages is send :" + e);
                } catch (c.d.b unused) {
                    boolean unused2 = h.f2101c = false;
                }
            } finally {
                System.out.println("close zmq context");
                b2.close();
                a2.close();
            }
        }
    }

    public h(Map<String, Object> map) {
        this.f2102a = map;
    }

    public String c() {
        int indexOf;
        String a2 = com.ape.offlinescriptmanager.utils.c.a("getprop", "ro.serialno");
        return (a2 == null || a2.isEmpty() || (indexOf = a2.indexOf(":")) == -1) ? BuildConfig.FLAVOR : a2.substring(indexOf + 1).replace("[", BuildConfig.FLAVOR).replace("]", BuildConfig.FLAVOR).trim();
    }

    public Map<String, Object> d() {
        HashMap hashMap = new HashMap();
        hashMap.put("dt", com.ape.offlinescriptmanager.utils.g.q());
        hashMap.put("lvl", "OFFLINE_RESULT");
        hashMap.put("msg", this.f2102a);
        hashMap.put("serial", c());
        System.out.println(this.f2103b.a(hashMap));
        return hashMap;
    }

    public boolean e() {
        com.ape.offlinescriptmanager.utils.b.h("upload result xml file start");
        Log.v("UploadTestResult", "upload result xml file start");
        new Thread(new a()).start();
        return f2101c;
    }
}
