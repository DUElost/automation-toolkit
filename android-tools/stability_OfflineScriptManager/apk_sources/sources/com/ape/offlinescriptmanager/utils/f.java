package com.ape.offlinescriptmanager.utils;

import java.io.File;
import java.io.FileNotFoundException;
/* loaded from: classes.dex */
public class f {

    /* renamed from: b  reason: collision with root package name */
    private static f f2074b;

    /* renamed from: a  reason: collision with root package name */
    private final File f2075a = new File("/sdcard");

    public static f a() {
        try {
            if (f2074b == null) {
                f2074b = new f();
            }
            f2074b.k();
            return f2074b;
        } catch (FileNotFoundException e) {
            throw new IllegalArgumentException("Invalid UIAutomator build provided.", e);
        }
    }

    private void k() {
        if (!i().exists()) {
            throw new FileNotFoundException(String.format("UIAutomator test case folder %s does not exist.", i().getAbsolutePath()));
        }
    }

    public File b() {
        return new File("/sdcard/MTBF_Data/uiautomatorconfig");
    }

    public File c() {
        File file = new File("/sdcard/MTBF_Data/jar");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public File d() {
        File file = new File("/sdcard/MTBF_Data/localfile");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public File e() {
        return new File(g.s(), "Log");
    }

    public File f(String str) {
        File file = new File(e(), str);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public File g() {
        return new File(g.s(), "realresult");
    }

    public File h(String str) {
        File file = new File(g(), str);
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public File i() {
        return this.f2075a;
    }

    public File j() {
        File file = new File("/sdcard/MTBF_Data/task");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }
}
