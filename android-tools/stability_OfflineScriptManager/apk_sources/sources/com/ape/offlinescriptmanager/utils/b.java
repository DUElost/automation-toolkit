package com.ape.offlinescriptmanager.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class b {

    /* renamed from: a  reason: collision with root package name */
    private static OutputStream f2068a;

    /* renamed from: b  reason: collision with root package name */
    private static OutputStreamWriter f2069b;

    public static synchronized void a() {
        OutputStream outputStream;
        synchronized (b.class) {
            OutputStreamWriter outputStreamWriter = f2069b;
            if (outputStreamWriter != null) {
                try {
                    outputStreamWriter.flush();
                    f2069b.close();
                    f2069b = null;
                    outputStream = f2068a;
                } catch (IOException e) {
                    e.printStackTrace();
                    f2069b = null;
                    outputStream = f2068a;
                }
                g.d(outputStream);
            }
        }
    }

    public static synchronized void b() {
        OutputStream outputStream;
        synchronized (b.class) {
            try {
                try {
                    f2068a = new FileOutputStream(new File(f.a().f(g.q()), "log.txt"));
                    f2069b = new OutputStreamWriter(f2068a, "utf-8");
                } catch (FileNotFoundException e) {
                    e.printStackTrace();
                    outputStream = f2068a;
                    g.d(outputStream);
                }
            } catch (UnsupportedEncodingException e2) {
                e2.printStackTrace();
                outputStream = f2068a;
                g.d(outputStream);
            } catch (Exception e3) {
                e3.printStackTrace();
                outputStream = f2068a;
                g.d(outputStream);
            }
        }
    }

    public static synchronized void c(String str) {
        synchronized (b.class) {
            g(e("e", f(), str));
        }
    }

    public static synchronized void d(String str, Object... objArr) {
        synchronized (b.class) {
            g(e("e", f(), String.format(str, objArr)));
        }
    }

    public static String e(String str, String str2, String str3) {
        return String.format("%s %s %s: %s\n", new SimpleDateFormat("MM-dd HH:mm:ss.SSS").format(new Date()), str, str2, str3);
    }

    public static String f() {
        StringBuffer stringBuffer = new StringBuffer();
        StackTraceElement[] stackTrace = new Throwable().getStackTrace();
        if (stackTrace.length == 0) {
            return BuildConfig.FLAVOR;
        }
        char c2 = stackTrace.length > 1 ? (char) 2 : (char) 0;
        String fileName = stackTrace[c2].getFileName();
        stringBuffer.append(fileName != null ? fileName.replace(".java", BuildConfig.FLAVOR) : "Unknown Source");
        stringBuffer.append(" : ");
        stringBuffer.append(stackTrace[c2].getLineNumber());
        return stringBuffer.toString();
    }

    public static synchronized void g(String str) {
        synchronized (b.class) {
            try {
                OutputStreamWriter outputStreamWriter = f2069b;
                if (outputStreamWriter != null) {
                    outputStreamWriter.write(str);
                    f2069b.flush();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static synchronized void h(String str) {
        synchronized (b.class) {
            g(e("v", f(), str));
        }
    }

    public static synchronized void i(String str, Object... objArr) {
        synchronized (b.class) {
            g(e("v", f(), String.format(str, objArr)));
        }
    }
}
