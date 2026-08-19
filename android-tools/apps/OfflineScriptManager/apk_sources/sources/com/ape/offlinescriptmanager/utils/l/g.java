package com.ape.offlinescriptmanager.utils.l;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
/* loaded from: classes.dex */
public class g extends com.ape.offlinescriptmanager.utils.l.b {
    private static final Set<String> r;

    /* renamed from: d  reason: collision with root package name */
    private final Collection<b.b.a.a.b.b> f2096d;
    private b e;
    private b f;
    private String g;
    private StringBuilder h;
    private boolean i;
    private boolean j;
    private boolean k;
    private boolean l;
    private int m;
    private int n;
    private boolean o;
    private Map<String, String> p;
    private Map<String, String> q;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        private Integer f2097a;

        /* renamed from: b  reason: collision with root package name */
        private String f2098b;

        /* renamed from: c  reason: collision with root package name */
        private String f2099c;

        /* renamed from: d  reason: collision with root package name */
        private String f2100d;
        private Integer e;

        private b() {
            this.f2097a = null;
            this.f2098b = null;
            this.f2099c = null;
            this.f2100d = null;
            this.e = null;
        }

        boolean i() {
            return (this.f2097a == null || this.f2098b == null || this.f2099c == null) ? false : true;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder();
            String str = this.f2099c;
            if (str != null) {
                sb.append(str);
                sb.append('#');
            }
            String str2 = this.f2098b;
            if (str2 != null) {
                sb.append(str2);
            }
            return sb.length() > 0 ? sb.toString() : "unknown result";
        }
    }

    static {
        HashSet hashSet = new HashSet();
        r = hashSet;
        hashSet.add("test");
        hashSet.add("class");
        hashSet.add("stack");
        hashSet.add("numtests");
        hashSet.add("Error");
        hashSet.add("shortMsg");
        hashSet.add("stream");
        hashSet.add("id");
        hashSet.add("current");
    }

    public g(b.b.a.a.b.b bVar) {
        this(Collections.singletonList(bVar));
    }

    public g(Collection<b.b.a.a.b.b> collection) {
        this.e = null;
        this.f = null;
        this.g = null;
        this.h = null;
        this.i = false;
        this.j = false;
        this.k = false;
        this.l = false;
        this.m = 0;
        this.n = 0;
        this.o = false;
        this.p = new HashMap();
        this.q = new HashMap();
        this.f2096d = new ArrayList(collection);
    }

    private void e() {
        this.f = this.e;
        this.e = null;
    }

    private b f() {
        if (this.e == null) {
            this.e = new b();
        }
        return this.e;
    }

    private String g(b bVar) {
        if (bVar.f2100d != null) {
            return bVar.f2100d;
        }
        com.ape.offlinescriptmanager.utils.b.d("%s %s", "UiautomatorResultParser", "Could not find stack trace for failed test ");
        return new Throwable("Unknown failure").toString();
    }

    private void h() {
        String format;
        if (this.i || this.j) {
            int i = this.n;
            if (i <= this.m) {
                for (b.b.a.a.b.b bVar : this.f2096d) {
                    if (!this.i) {
                        bVar.b();
                    }
                    bVar.c();
                }
                return;
            }
            format = String.format("%1$s. Expected %2$d tests, received %3$d", "Test run failed to complete", Integer.valueOf(i), Integer.valueOf(this.m));
        } else {
            format = "No test results";
        }
        i(format);
    }

    private void j(String str) {
        if (str.startsWith("INSTRUMENTATION_STATUS_CODE: ")) {
            q();
            this.o = false;
            l(str);
            return;
        }
        if (str.startsWith("INSTRUMENTATION_STATUS: ")) {
            q();
            this.o = false;
        } else if (!str.startsWith("INSTRUMENTATION_RESULT: ")) {
            if (str.startsWith("INSTRUMENTATION_FAILED: ") || str.startsWith("INSTRUMENTATION_CODE: ")) {
                q();
                this.o = false;
                this.j = true;
                return;
            } else if (str.startsWith("Time: ")) {
                m(str);
                return;
            } else {
                StringBuilder sb = this.h;
                if (sb != null) {
                    sb.append("\n");
                    this.h.append(str);
                    return;
                } else if (str.trim().isEmpty()) {
                    return;
                } else {
                    com.ape.offlinescriptmanager.utils.b.i("%s %s", "UiautomatorResultParser", "unrecognized line " + str);
                    return;
                }
            }
        } else {
            q();
            this.o = true;
        }
        k(str, 24);
    }

    private void k(String str, int i) {
        int indexOf = str.indexOf(61, i);
        if (indexOf != -1) {
            this.g = str.substring(i, indexOf).trim();
            n(str, indexOf + 1);
        }
    }

    private void l(String str) {
        String trim = str.substring(29).trim();
        b f = f();
        f.f2097a = -1;
        try {
            f.f2097a = Integer.valueOf(Integer.parseInt(trim));
        } catch (NumberFormatException unused) {
            f.f2097a = -1;
        }
        if (f.f2097a.intValue() != 2) {
            o(f);
            e();
        }
    }

    private void m(String str) {
        Matcher matcher = Pattern.compile(String.format("%s\\s*([\\d\\.]+)", "Time: ")).matcher(str);
        if (!matcher.find()) {
            com.ape.offlinescriptmanager.utils.b.i("%s %s", "UiautomatorResultParser", String.format("Unexpected time format %1$s", str));
            return;
        }
        try {
            Float.parseFloat(matcher.group(1));
        } catch (NumberFormatException unused) {
            com.ape.offlinescriptmanager.utils.b.i("%s %s", "UiautomatorResultParser", String.format("Unexpected time format %1$s", str));
        }
    }

    private void n(String str, int i) {
        StringBuilder sb = new StringBuilder();
        this.h = sb;
        sb.append(str.substring(i));
    }

    private void o(b bVar) {
        if (bVar.i()) {
            p(bVar);
            int intValue = bVar.f2097a.intValue();
            if (intValue == -2 || intValue == -1) {
                for (b.b.a.a.b.b bVar2 : this.f2096d) {
                    bVar2.d(g(bVar));
                    bVar2.c();
                }
            } else if (intValue == 0) {
                for (b.b.a.a.b.b bVar3 : this.f2096d) {
                    bVar3.c();
                }
            } else if (intValue == 1) {
                for (b.b.a.a.b.b bVar4 : this.f2096d) {
                    bVar4.b();
                }
                return;
            } else {
                com.ape.offlinescriptmanager.utils.b.d("%s %s", "UiautomatorResultParser", "Unknown status code received: " + bVar.f2097a);
                for (b.b.a.a.b.b bVar5 : this.f2096d) {
                    bVar5.c();
                }
            }
            this.m++;
        }
    }

    private void p(b bVar) {
        if (this.i || bVar.e == null) {
            return;
        }
        for (b.b.a.a.b.b bVar2 : this.f2096d) {
            bVar2.b();
        }
        this.n = bVar.e.intValue();
        this.i = true;
    }

    private void q() {
        StringBuilder sb;
        Map<String, String> map;
        if (this.g == null || (sb = this.h) == null) {
            return;
        }
        String sb2 = sb.toString();
        if (this.o) {
            if (!r.contains(this.g)) {
                map = this.p;
                map.put(this.g, sb2);
                this.g = null;
                this.h = null;
            }
            if (this.g.equals("shortMsg")) {
                sb2 = String.format("Instrumentation run failed due to '%1$s'", sb2);
                i(sb2);
            }
            this.g = null;
            this.h = null;
        }
        b f = f();
        if (this.g.equals("class")) {
            f.f2099c = sb2.trim();
        } else if (this.g.equals("test")) {
            f.f2098b = sb2.trim();
        } else if (this.g.equals("numtests")) {
            try {
                f.e = Integer.valueOf(Integer.parseInt(sb2));
            } catch (NumberFormatException unused) {
                com.ape.offlinescriptmanager.utils.b.i("%s %s", "UiautomatorResultParser", "Unexpected integer number of tests, received " + sb2);
            }
        } else {
            if (!this.g.equals("Error")) {
                if (this.g.equals("stack")) {
                    f.f2100d = sb2;
                } else if (!r.contains(this.g)) {
                    map = this.q;
                    map.put(this.g, sb2);
                }
            }
            i(sb2);
        }
        this.g = null;
        this.h = null;
    }

    @Override // com.ape.offlinescriptmanager.utils.l.a
    public boolean a() {
        return this.l;
    }

    @Override // com.ape.offlinescriptmanager.utils.l.b
    public void c() {
        super.c();
        if (this.k) {
            return;
        }
        h();
    }

    @Override // com.ape.offlinescriptmanager.utils.l.b
    public void d(String[] strArr) {
        for (String str : strArr) {
            j(str);
        }
    }

    public void i(String str) {
        if (str == null) {
            str = "Unknown error";
        }
        b bVar = this.f;
        if (bVar != null && bVar.i() && 1 == this.f.f2097a.intValue()) {
            for (b.b.a.a.b.b bVar2 : this.f2096d) {
                bVar2.d(String.format("%1$s. Reason: '%2$s'. %3$s", "Test failed to run to completion", str, "Check device logcat for details"));
                bVar2.c();
            }
        }
        for (b.b.a.a.b.b bVar3 : this.f2096d) {
            if (!this.i) {
                bVar3.b();
            }
            bVar3.d(str);
            bVar3.c();
        }
        this.i = true;
        this.k = true;
    }
}
