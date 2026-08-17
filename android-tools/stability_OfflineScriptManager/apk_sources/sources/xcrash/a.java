package xcrash;

import android.content.Context;
import android.os.Build;
import android.os.FileObserver;
import android.text.TextUtils;
import java.io.BufferedReader;
import java.io.FileReader;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class a {
    private static final a q = new a();

    /* renamed from: d  reason: collision with root package name */
    private Context f2828d;
    private int e;
    private String f;
    private String g;
    private String h;
    private String i;
    private int j;
    private int k;
    private int l;
    private boolean m;
    private d n;

    /* renamed from: a  reason: collision with root package name */
    private final Date f2825a = new Date();

    /* renamed from: b  reason: collision with root package name */
    private final Pattern f2826b = Pattern.compile("^-----\\spid\\s(\\d+)\\sat\\s(.*)\\s-----$");

    /* renamed from: c  reason: collision with root package name */
    private final Pattern f2827c = Pattern.compile("^Cmd\\sline:\\s+(.*)$");
    private long o = 0;
    private FileObserver p = null;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: xcrash.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class FileObserverC0121a extends FileObserver {
        FileObserverC0121a(String str, int i) {
            super(str, i);
        }

        @Override // android.os.FileObserver
        public void onEvent(int i, String str) {
            if (str != null) {
                try {
                    String str2 = "/data/anr/" + str;
                    if (str2.contains("trace")) {
                        a.this.e(str2);
                    }
                } catch (Exception e) {
                    j.a().d("xcrash", "AnrHandler fileObserver onEvent failed", e);
                }
            }
        }
    }

    private a() {
    }

    private String b(Date date, String str) {
        return i.g(this.f2825a, date, "anr", this.g, this.h) + "pid: " + this.e + "  >>> " + this.f + " <<<\n\n--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---\n" + str + "\n+++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++ +++\n\n";
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static a c() {
        return q;
    }

    private String d(String str, long j) {
        BufferedReader bufferedReader;
        Date parse;
        String group;
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.US);
        StringBuilder sb = new StringBuilder();
        BufferedReader bufferedReader2 = null;
        try {
            bufferedReader = new BufferedReader(new FileReader(str));
            boolean z = false;
            while (true) {
                try {
                    String readLine = bufferedReader.readLine();
                    if (readLine == null) {
                        break;
                    } else if (!z && readLine.startsWith("----- pid ")) {
                        Matcher matcher = this.f2826b.matcher(readLine);
                        if (matcher.find() && matcher.groupCount() == 2) {
                            String group2 = matcher.group(1);
                            String group3 = matcher.group(2);
                            if (group2 != null && group3 != null && this.e == Integer.parseInt(group2) && (parse = simpleDateFormat.parse(group3)) != null && Math.abs(parse.getTime() - j) <= 15000) {
                                String readLine2 = bufferedReader.readLine();
                                if (readLine2 == null) {
                                    break;
                                }
                                Matcher matcher2 = this.f2827c.matcher(readLine2);
                                if (matcher2.find() && matcher2.groupCount() == 1 && (group = matcher2.group(1)) != null && group.equals(this.f)) {
                                    sb.append(readLine2);
                                    sb.append('\n');
                                    sb.append("Mode: Watching /data/anr/*\n");
                                    z = true;
                                }
                            }
                        }
                    } else if (!z) {
                        continue;
                    } else if (readLine.startsWith("----- end ")) {
                        break;
                    } else {
                        sb.append(readLine);
                        sb.append('\n');
                    }
                } catch (Exception unused) {
                    if (bufferedReader != null) {
                        try {
                            bufferedReader.close();
                        } catch (Exception unused2) {
                        }
                    }
                    return null;
                } catch (Throwable th) {
                    th = th;
                    bufferedReader2 = bufferedReader;
                    if (bufferedReader2 != null) {
                        try {
                            bufferedReader2.close();
                        } catch (Exception unused3) {
                        }
                    }
                    throw th;
                }
            }
            String sb2 = sb.toString();
            try {
                bufferedReader.close();
            } catch (Exception unused4) {
            }
            return sb2;
        } catch (Exception unused5) {
            bufferedReader = null;
        } catch (Throwable th2) {
            th = th2;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Removed duplicated region for block: B:61:0x0108  */
    /* JADX WARN: Removed duplicated region for block: B:76:0x00f8 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:83:0x0100 A[EXC_TOP_SPLITTER, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:89:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void e(java.lang.String r12) {
        /*
            Method dump skipped, instructions count: 275
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: xcrash.a.e(java.lang.String):void");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void f(Context context, int i, String str, String str2, String str3, String str4, int i2, int i3, int i4, boolean z, d dVar) {
        if (Build.VERSION.SDK_INT >= 21) {
            return;
        }
        this.f2828d = context;
        this.e = i;
        if (TextUtils.isEmpty(str)) {
            str = "unknown";
        }
        this.f = str;
        this.g = str2;
        this.h = str3;
        this.i = str4;
        this.j = i2;
        this.k = i3;
        this.l = i4;
        this.m = z;
        this.n = dVar;
        FileObserverC0121a fileObserverC0121a = new FileObserverC0121a("/data/anr/", 8);
        this.p = fileObserverC0121a;
        try {
            fileObserverC0121a.startWatching();
        } catch (Exception e) {
            this.p = null;
            j.a().d("xcrash", "AnrHandler fileObserver startWatching failed", e);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void g() {
        FileObserver fileObserver = this.p;
        if (fileObserver != null) {
            try {
                try {
                    fileObserver.stopWatching();
                } catch (Exception e) {
                    j.a().d("xcrash", "AnrHandler fileObserver stopWatching failed", e);
                }
            } finally {
                this.p = null;
            }
        }
    }
}
