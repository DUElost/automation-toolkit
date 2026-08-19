package com.ape.offlinescriptmanager.utils;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Paint;
import android.os.Build;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.lang.reflect.Constructor;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.TimeZone;
import java.util.concurrent.TimeUnit;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import me.zhanghai.android.materialprogressbar.R;
import org.achartengine.h.e;
@SuppressLint({"DefaultLocale"})
/* loaded from: classes.dex */
public class g {

    /* renamed from: a  reason: collision with root package name */
    private static final String f2076a = "g";

    /* renamed from: b  reason: collision with root package name */
    public static long f2077b;

    /* renamed from: c  reason: collision with root package name */
    public static SimpleDateFormat f2078c = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());

    /* loaded from: classes.dex */
    static class a implements FilenameFilter {
        a() {
        }

        @Override // java.io.FilenameFilter
        public boolean accept(File file, String str) {
            return str.endsWith(".xml");
        }
    }

    public static void A() {
        String str;
        String str2;
        try {
            Class<?> cls = Class.forName("android.webkit.WebViewFactory");
            Field declaredField = cls.getDeclaredField("sProviderInstance");
            declaredField.setAccessible(true);
            Object obj = declaredField.get(null);
            if (obj != null) {
                return;
            }
            Method declaredMethod = cls.getDeclaredMethod("getProviderClass", new Class[0]);
            declaredMethod.setAccessible(true);
            Class cls2 = (Class) declaredMethod.invoke(cls, new Object[0]);
            Class<?> cls3 = Class.forName("android.webkit.WebViewDelegate");
            Constructor<?> declaredConstructor = cls3.getDeclaredConstructor(new Class[0]);
            declaredConstructor.setAccessible(true);
            if (Build.VERSION.SDK_INT < 26) {
                Constructor constructor = cls2.getConstructor(cls3);
                if (constructor != null) {
                    constructor.setAccessible(true);
                    obj = constructor.newInstance(declaredConstructor.newInstance(new Object[0]));
                }
            } else {
                Field declaredField2 = cls.getDeclaredField("CHROMIUM_WEBVIEW_FACTORY_METHOD");
                declaredField2.setAccessible(true);
                String str3 = (String) declaredField2.get(null);
                if (str3 == null) {
                    str3 = "create";
                }
                Method method = cls2.getMethod(str3, cls3);
                if (method != null) {
                    obj = method.invoke(null, declaredConstructor.newInstance(new Object[0]));
                }
            }
            if (obj != null) {
                declaredField.set("sProviderInstance", obj);
                str = f2076a;
                str2 = "Hook success!";
            } else {
                str = f2076a;
                str2 = "Hook failed!";
            }
            Log.i(str, str2);
        } catch (Throwable th) {
            Log.w(f2076a, th);
        }
    }

    public static boolean B(Context context) {
        return context.getSharedPreferences("update_data", 0).getBoolean("isUpdating", false);
    }

    public static boolean C(String str) {
        return str == null || str.length() == 0;
    }

    public static boolean D() {
        return Environment.getExternalStorageState().equals("mounted");
    }

    public static boolean E(ArrayList<b.b.a.a.c.a> arrayList) {
        if (arrayList != null && arrayList.size() > 0) {
            StringBuffer stringBuffer = new StringBuffer();
            Iterator<b.b.a.a.c.a> it = arrayList.iterator();
            while (it.hasNext()) {
                b.b.a.a.c.a next = it.next();
                stringBuffer.append(next.f1370a);
                stringBuffer.append("=");
                String str = next.f1372c;
                if (str != null) {
                    stringBuffer.append(str);
                } else {
                    stringBuffer.append(next.f1371b);
                }
                stringBuffer.append("\n");
            }
            return Q(f.a().b(), stringBuffer.toString(), false);
        }
        return true;
    }

    public static void F(org.achartengine.h.d dVar, String str, String str2, String str3, double d2, double d3, double d4, double d5, int i, int i2) {
        dVar.O(str);
        dVar.o1(str2);
        dVar.x1(str3);
        if (d2 != 0.0d || d3 != 0.0d) {
            dVar.j1(d2);
            dVar.h1(d3);
        }
        dVar.r1(d4);
        dVar.p1(d5);
        dVar.M(i);
        dVar.Q(i2);
        dVar.V(true);
        dVar.Z(true);
        dVar.L(true);
        dVar.N(0);
    }

    public static void G(org.achartengine.h.d dVar, int[] iArr, org.achartengine.f.d[] dVarArr) {
        dVar.a1(16.0f);
        dVar.P(20.0f);
        dVar.R(12.0f);
        dVar.S(15.0f);
        dVar.f1(3.0f);
        dVar.T(new int[]{30, 30, 15, 20});
        dVar.d1(-1);
        dVar.m1(-16777216);
        dVar.w1(0, -16777216);
        int length = iArr.length;
        for (int i = 0; i < length; i++) {
            org.achartengine.h.e eVar = new org.achartengine.h.e();
            eVar.f(iArr[i]);
            eVar.x(dVarArr[i]);
            eVar.v(true);
            dVar.a(eVar);
        }
    }

    public static void H(org.achartengine.h.d dVar, int[] iArr, org.achartengine.f.d[] dVarArr, int i, int i2, int i3, float f) {
        dVar.L(true);
        dVar.N(i3);
        dVar.d1(i3);
        dVar.a1(16.0f);
        dVar.P(20.0f);
        dVar.R(12.0f);
        dVar.S(15.0f);
        dVar.f1(f);
        dVar.T(new int[]{30, 30, 15, 20});
        dVar.l1(i2);
        dVar.t1(15);
        dVar.e1(false, false);
        dVar.z1(false, false);
        dVar.c0(true);
        dVar.n1(false);
        dVar.W(true);
        dVar.u1(Paint.Align.RIGHT);
        int length = iArr.length;
        for (int i4 = 0; i4 < length; i4++) {
            org.achartengine.h.e eVar = new org.achartengine.h.e();
            eVar.f(iArr[i4]);
            eVar.x(dVarArr[i4]);
            eVar.v(true);
            eVar.w(2.0f);
            eVar.g(true);
            e.a aVar = new e.a(e.a.EnumC0120a.BELOW);
            aVar.d(i);
            eVar.h(aVar);
            dVar.a(eVar);
        }
    }

    public static void I(Context context, int i, DialogInterface.OnClickListener onClickListener, DialogInterface.OnClickListener onClickListener2) {
        new AlertDialog.Builder(context).setTitle(R.string.dialog_alert_title).setMessage(i).setCancelable(false).setPositiveButton(17039370, onClickListener).setNegativeButton(17039360, onClickListener2).create().show();
    }

    public static void J(Context context, String str, String str2, DialogInterface.OnClickListener onClickListener, DialogInterface.OnClickListener onClickListener2) {
        K(context, str, str2, null, onClickListener, onClickListener2);
    }

    public static void K(Context context, String str, String str2, View view, DialogInterface.OnClickListener onClickListener, DialogInterface.OnClickListener onClickListener2) {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setTitle(str);
        if (str2 != null) {
            builder.setMessage(str2);
        }
        builder.setCancelable(false);
        if (view != null) {
            builder.setView(view);
        }
        if (onClickListener != null) {
            builder.setPositiveButton(17039370, onClickListener);
        }
        if (onClickListener2 != null) {
            builder.setNegativeButton(17039360, onClickListener2);
        }
        builder.create().show();
    }

    public static void L(long j) {
        try {
            Thread.sleep(j);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }

    public static String M(long j) {
        return f2078c.format(new Date(j));
    }

    public static String N(String str) {
        return f2078c.format(new Date(new Long(str).longValue()));
    }

    public static boolean O(String str, String str2, String str3, String str4, ArrayList<b.b.a.a.c.a> arrayList) {
        b.b.a.b.b.c.c().e();
        b.b.a.a.e.e d2 = b.b.a.b.b.c.c().d();
        b.b.a.a.e.d dVar = new b.b.a.a.e.d(str);
        dVar.f(str4);
        String[] split = str2.split("\\.");
        Log.v("STEVEN_LOG", "classname: " + str2);
        if (split.length > 0) {
            str2 = split[split.length - 1];
        }
        b.b.a.a.e.a aVar = new b.b.a.a.e.a(str2);
        b.b.a.a.e.c cVar = new b.b.a.a.e.c(str3);
        Iterator<b.b.a.a.c.a> it = arrayList.iterator();
        while (it.hasNext()) {
            b.b.a.a.c.a next = it.next();
            cVar.a(new b.b.a.a.e.b(next.f1370a, next.f1371b));
        }
        aVar.a(cVar);
        dVar.a(aVar);
        LinkedHashMap linkedHashMap = new LinkedHashMap();
        linkedHashMap.put(dVar.b(), dVar);
        d2.i(linkedHashMap);
        return new com.ape.offlinescriptmanager.utils.m.e(d2).k();
    }

    public static void P() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm");
        simpleDateFormat.setTimeZone(TimeZone.getDefault());
        f2077b = w(simpleDateFormat.format(new Date()));
        b.h("updateTimeOffset:TIME_OFFSET=" + f2077b);
    }

    public static boolean Q(File file, String str, boolean z) {
        OutputStreamWriter outputStreamWriter;
        OutputStreamWriter outputStreamWriter2 = null;
        try {
            try {
                outputStreamWriter = new OutputStreamWriter(new FileOutputStream(file, z), "UTF-8");
            } catch (Throwable th) {
                th = th;
            }
        } catch (FileNotFoundException e) {
            e = e;
        } catch (UnsupportedEncodingException e2) {
            e = e2;
        } catch (IOException e3) {
            e = e3;
        }
        try {
            outputStreamWriter.write(str);
            outputStreamWriter.write("\n");
            outputStreamWriter.flush();
            b.i("write..........%s", file.getPath());
            f(outputStreamWriter);
            return true;
        } catch (FileNotFoundException e4) {
            e = e4;
            outputStreamWriter2 = outputStreamWriter;
            e.printStackTrace();
            f(outputStreamWriter2);
            return false;
        } catch (UnsupportedEncodingException e5) {
            e = e5;
            outputStreamWriter2 = outputStreamWriter;
            e.printStackTrace();
            f(outputStreamWriter2);
            return false;
        } catch (IOException e6) {
            e = e6;
            outputStreamWriter2 = outputStreamWriter;
            e.printStackTrace();
            f(outputStreamWriter2);
            return false;
        } catch (Throwable th2) {
            th = th2;
            outputStreamWriter2 = outputStreamWriter;
            f(outputStreamWriter2);
            throw th;
        }
    }

    public static org.achartengine.h.d a(int[] iArr, org.achartengine.f.d[] dVarArr) {
        org.achartengine.h.d dVar = new org.achartengine.h.d();
        G(dVar, iArr, dVarArr);
        return dVar;
    }

    public static org.achartengine.h.d b(int[] iArr, org.achartengine.f.d[] dVarArr, int i, int i2, int i3, float f) {
        org.achartengine.h.d dVar = new org.achartengine.h.d();
        H(dVar, iArr, dVarArr, i, i2, i3, f);
        return dVar;
    }

    public static String c(String str) {
        return str.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;").replace("\"", "&quot;").replace("'", "&apos;");
    }

    public static void d(OutputStream outputStream) {
        if (outputStream != null) {
            try {
                outputStream.close();
            } catch (IOException unused) {
            }
        }
    }

    public static void e(Reader reader) {
        if (reader != null) {
            try {
                reader.close();
            } catch (IOException unused) {
            }
        }
    }

    public static void f(Writer writer) {
        if (writer != null) {
            try {
                writer.close();
            } catch (IOException unused) {
            }
        }
    }

    public static File g(String str, String str2, String str3, File file) {
        return new File(file, String.format("%s%s%s", str, str3, str2));
    }

    public static long h(String str) {
        return f2078c.parse(str).getTime();
    }

    public static Process i(String str) {
        return Runtime.getRuntime().exec(String.format("%s %s", p(), str));
    }

    public static String j(long j) {
        TimeUnit timeUnit = TimeUnit.MILLISECONDS;
        long seconds = timeUnit.toSeconds(j) % 60;
        long minutes = timeUnit.toMinutes(j) % 60;
        long hours = timeUnit.toHours(j);
        StringBuilder sb = new StringBuilder();
        if (hours > 0) {
            sb.append(hours);
            sb.append("h ");
        }
        if (minutes > 0) {
            sb.append(minutes);
            sb.append("m ");
        }
        sb.append(seconds);
        sb.append("s");
        return sb.toString();
    }

    public static File k() {
        return new File(s(), "record_data");
    }

    public static String l(String str, String str2) {
        String str3;
        if (str2.equals("battery")) {
            File k = k();
            File file = new File(k, str + File.separator + "battery_data");
            if (!file.exists()) {
                file.mkdirs();
            }
            return file.getAbsolutePath();
        }
        if (str2.equals("signal")) {
            str3 = "signal_data";
        } else if (str2.equals("scrutator")) {
            str3 = "scrutator_data";
        } else if (str2.equals("roadrecorder")) {
            str3 = "road_data";
        } else if (str2.equals("simSignal")) {
            str3 = "simsignal_data";
        } else if (!str2.equals("wifiSignal")) {
            File file2 = new File(k(), str);
            if (!file2.exists()) {
                file2.mkdirs();
            }
            return file2.getAbsolutePath();
        } else {
            str3 = "wifisignal_data";
        }
        String r = r();
        File file3 = new File(r, str + File.separator + str3);
        if (!file3.exists()) {
            file3.mkdirs();
        }
        return file3.getAbsolutePath();
    }

    public static long m() {
        return System.currentTimeMillis() + f2077b;
    }

    @SuppressLint({"SimpleDateFormat"})
    public static String n(long j) {
        return new SimpleDateFormat("yyyy-MM-dd_HH:mm:ss").format(new Date(j));
    }

    @SuppressLint({"SimpleDateFormat"})
    public static String o(String str) {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(Long.parseLong(str)));
    }

    static String p() {
        return System.getProperty("os.name").contains("Windows") ? "cmd.exe /c" : BuildConfig.FLAVOR;
    }

    public static String q() {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd_HH.mm.ss.SSS");
        simpleDateFormat.setTimeZone(TimeZone.getDefault());
        return simpleDateFormat.format(new Date());
    }

    public static String r() {
        File file = new File(Environment.getExternalStorageDirectory(), "Field_Data");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file.getAbsolutePath();
    }

    public static File s() {
        File file = new File(Environment.getExternalStorageDirectory(), "results");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file;
    }

    public static String t() {
        File file = new File(s(), "ScreenShots_crash");
        if (!file.exists()) {
            file.mkdirs();
        }
        return file.getPath();
    }

    public static String u(String str) {
        StringBuffer stringBuffer = new StringBuffer(str);
        stringBuffer.append(File.separator);
        File file = new File(stringBuffer.toString());
        if (!file.exists()) {
            file.mkdirs();
        }
        if (D() && !file.isDirectory()) {
            file.mkdirs();
        }
        return stringBuffer.toString();
    }

    public static String v(String str, String str2, String str3) {
        Date time = Calendar.getInstance().getTime();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(str2);
        StringBuffer stringBuffer = new StringBuffer(u(str));
        stringBuffer.append(str3);
        stringBuffer.append("_");
        stringBuffer.append(simpleDateFormat.format(time));
        stringBuffer.append(".png");
        return stringBuffer.toString();
    }

    public static long w(String str) {
        long j;
        Date date;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd-HH-mm");
        Date date2 = null;
        try {
            simpleDateFormat.setTimeZone(TimeZone.getTimeZone("GMT+08:00"));
            date = simpleDateFormat.parse(str);
            try {
                j = date.getTime();
                try {
                    date2 = simpleDateFormat.parse(simpleDateFormat.format(new Date()));
                } catch (ParseException e) {
                    e = e;
                    b.h("ParseException:" + e.toString());
                    if (date != null) {
                    }
                    return 0L;
                }
            } catch (ParseException e2) {
                e = e2;
                j = 0;
            }
        } catch (ParseException e3) {
            e = e3;
            j = 0;
            date = null;
        }
        if (date != null || date2 == null) {
            return 0L;
        }
        return j - date2.getTime();
    }

    @SuppressLint({"SimpleDateFormat"})
    public static String x() {
        return new SimpleDateFormat("yyyy.MM.dd_HH.mm.ss").format(new Date());
    }

    public static String y(long j) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        simpleDateFormat.setTimeZone(TimeZone.getDefault());
        return simpleDateFormat.format(new Date(j));
    }

    public static File[] z(String str) {
        File[] listFiles;
        File file = new File(str);
        if (file.exists() && (listFiles = file.listFiles(new a())) != null) {
            return listFiles;
        }
        return null;
    }
}
