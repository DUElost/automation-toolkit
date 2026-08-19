package xcrash;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Process;
import android.text.TextUtils;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.Thread;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Pattern;
/* JADX INFO: Access modifiers changed from: package-private */
@SuppressLint({"StaticFieldLeak"})
/* loaded from: classes.dex */
public class g implements Thread.UncaughtExceptionHandler {
    private static final g q = new g();

    /* renamed from: b  reason: collision with root package name */
    private int f2844b;

    /* renamed from: c  reason: collision with root package name */
    private String f2845c;

    /* renamed from: d  reason: collision with root package name */
    private String f2846d;
    private String e;
    private boolean f;
    private String g;
    private int h;
    private int i;
    private int j;
    private boolean k;
    private boolean l;
    private int m;
    private String[] n;
    private d o;

    /* renamed from: a  reason: collision with root package name */
    private final Date f2843a = new Date();
    private Thread.UncaughtExceptionHandler p = null;

    private g() {
    }

    private String a(Date date, Thread thread, Throwable th) {
        StringWriter stringWriter = new StringWriter();
        th.printStackTrace(new PrintWriter(stringWriter));
        String stringWriter2 = stringWriter.toString();
        return i.g(this.f2843a, date, "java", this.f2846d, this.e) + "pid: " + this.f2844b + ", tid: " + Process.myTid() + ", name: " + thread.getName() + "  >>> " + this.f2845c + " <<<\n\njava stacktrace:\n" + stringWriter2 + "\n";
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static g b() {
        return q;
    }

    private String c(Thread thread) {
        ArrayList<Pattern> arrayList;
        if (this.n != null) {
            arrayList = new ArrayList<>();
            for (String str : this.n) {
                try {
                    arrayList.add(Pattern.compile(str));
                } catch (Exception e) {
                    j.a().a("xcrash", "JavaCrashHandler pattern compile failed", e);
                }
            }
        } else {
            arrayList = null;
        }
        StringBuilder sb = new StringBuilder();
        Map<Thread, StackTraceElement[]> allStackTraces = Thread.getAllStackTraces();
        int i = 0;
        int i2 = 0;
        int i3 = 0;
        for (Map.Entry<Thread, StackTraceElement[]> entry : allStackTraces.entrySet()) {
            Thread key = entry.getKey();
            StackTraceElement[] value = entry.getValue();
            if (!key.getName().equals(thread.getName()) && (arrayList == null || f(arrayList, key.getName()))) {
                i2++;
                int i4 = this.m;
                if (i4 <= 0 || i < i4) {
                    sb.append("--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---\n");
                    sb.append("pid: ");
                    sb.append(this.f2844b);
                    sb.append(", tid: ");
                    sb.append(key.getId());
                    sb.append(", name: ");
                    sb.append(key.getName());
                    sb.append("  >>> ");
                    sb.append(this.f2845c);
                    sb.append(" <<<\n");
                    sb.append("\n");
                    sb.append("java stacktrace:\n");
                    for (StackTraceElement stackTraceElement : value) {
                        sb.append("    at ");
                        sb.append(stackTraceElement.toString());
                        sb.append("\n");
                    }
                    sb.append("\n");
                    i++;
                } else {
                    i3++;
                }
            }
        }
        if (allStackTraces.size() > 1) {
            if (i == 0) {
                sb.append("--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---\n");
            }
            sb.append("total JVM threads (exclude the crashed thread): ");
            sb.append(allStackTraces.size() - 1);
            sb.append("\n");
            if (arrayList != null) {
                sb.append("JVM threads matched whitelist: ");
                sb.append(i2);
                sb.append("\n");
            }
            if (this.m > 0) {
                sb.append("JVM threads ignored by max count limit: ");
                sb.append(i3);
                sb.append("\n");
            }
            sb.append("dumped JVM threads:");
            sb.append(i);
            sb.append("\n");
            sb.append("+++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++\n");
        }
        return sb.toString();
    }

    /* JADX WARN: Removed duplicated region for block: B:51:0x00f0  */
    /* JADX WARN: Removed duplicated region for block: B:62:0x00e0 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:68:0x00e8 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:79:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void d(java.lang.Thread r12, java.lang.Throwable r13) {
        /*
            Method dump skipped, instructions count: 251
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: xcrash.g.d(java.lang.Thread, java.lang.Throwable):void");
    }

    private boolean f(ArrayList<Pattern> arrayList, String str) {
        Iterator<Pattern> it = arrayList.iterator();
        while (it.hasNext()) {
            if (it.next().matcher(str).matches()) {
                return true;
            }
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void e(Context context, int i, String str, String str2, String str3, String str4, boolean z, int i2, int i3, int i4, boolean z2, boolean z3, int i5, String[] strArr, d dVar) {
        this.f2844b = i;
        if (TextUtils.isEmpty(str)) {
            str = "unknown";
        }
        this.f2845c = str;
        this.f2846d = str2;
        this.e = str3;
        this.f = z;
        this.g = str4;
        this.h = i2;
        this.i = i3;
        this.j = i4;
        this.k = z2;
        this.l = z3;
        this.m = i5;
        this.n = strArr;
        this.o = dVar;
        this.p = Thread.getDefaultUncaughtExceptionHandler();
        try {
            Thread.setDefaultUncaughtExceptionHandler(this);
        } catch (Exception e) {
            j.a().d("xcrash", "JavaCrashHandler setDefaultUncaughtExceptionHandler failed", e);
        }
    }

    @Override // java.lang.Thread.UncaughtExceptionHandler
    public void uncaughtException(Thread thread, Throwable th) {
        Thread.UncaughtExceptionHandler uncaughtExceptionHandler;
        try {
            d(thread, th);
        } catch (Exception e) {
            j.a().d("xcrash", "JavaCrashHandler handleException failed", e);
        }
        if (!this.f || (uncaughtExceptionHandler = this.p) == null) {
            Process.killProcess(this.f2844b);
        } else {
            uncaughtExceptionHandler.uncaughtException(thread, th);
        }
    }
}
