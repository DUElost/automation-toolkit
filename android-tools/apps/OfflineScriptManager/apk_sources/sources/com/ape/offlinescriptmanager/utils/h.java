package com.ape.offlinescriptmanager.utils;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class h {

    /* renamed from: b  reason: collision with root package name */
    private static h f2079b;

    /* renamed from: a  reason: collision with root package name */
    private Map<String, String> f2080a = new HashMap();

    private h() {
    }

    public static synchronized h b() {
        h hVar;
        synchronized (h.class) {
            if (f2079b == null) {
                f2079b = new h();
            }
            hVar = f2079b;
        }
        return hVar;
    }

    private void d(File file) {
        File[] listFiles;
        for (File file2 : file.listFiles()) {
            if (file2.isDirectory()) {
                if (!file2.getName().equalsIgnoreCase(".") || !file2.getName().equalsIgnoreCase("..")) {
                    d(file2);
                }
            } else if (!this.f2080a.containsKey(file2.getName())) {
                this.f2080a.put(file2.getName(), file2.getAbsolutePath());
            }
        }
    }

    public synchronized String a(String str) {
        return this.f2080a.get(str);
    }

    public synchronized void c() {
        this.f2080a.clear();
        File d2 = f.a().d();
        if (d2.exists()) {
            d(d2);
        }
    }
}
