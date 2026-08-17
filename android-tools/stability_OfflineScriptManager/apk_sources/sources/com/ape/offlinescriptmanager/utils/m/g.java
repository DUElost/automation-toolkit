package com.ape.offlinescriptmanager.utils.m;

import b.b.a.a.d.i;
import b.b.a.a.d.j;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Iterator;
import java.util.List;
/* loaded from: classes.dex */
public class g {

    /* renamed from: c  reason: collision with root package name */
    private static final String f2131c = null;

    /* renamed from: a  reason: collision with root package name */
    private b.b.a.a.d.f f2132a;

    /* renamed from: b  reason: collision with root package name */
    private OutputStream f2133b = null;

    public g(b.b.a.a.d.f fVar) {
        this.f2132a = null;
        this.f2132a = fVar;
    }

    private OutputStream a(String str) {
        return new FileOutputStream(new File(str));
    }

    private c.a.a.a b(String str) {
        try {
            c.a.a.a aVar = new c.a.a.a();
            OutputStream a2 = a(str);
            this.f2133b = a2;
            aVar.j(a2, "UTF-8");
            aVar.i("http://xmlpull.org/v1/doc/features.html#indent-output", true);
            aVar.m("UTF-8", null);
            return aVar;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    private void c(c.a.a.a aVar) {
        try {
            aVar.c();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void d(c.a.a.a aVar, List<b.b.a.a.d.b> list) {
        if (list.size() > 0) {
            aVar.n(f2131c, "attribute");
        }
        for (b.b.a.a.d.b bVar : list) {
            String str = f2131c;
            aVar.n(str, "arg");
            aVar.a(str, "name", bVar.f1396b);
            aVar.a(str, "value", bVar.f1397c);
            aVar.d(str, "arg");
        }
        if (list.size() > 0) {
            aVar.d(f2131c, "attribute");
        }
    }

    private void e(c.a.a.a aVar, String str) {
        String str2 = f2131c;
        aVar.n(str2, "description");
        aVar.a(str2, "content", str);
        aVar.d(str2, "description");
    }

    private boolean f(c.a.a.a aVar) {
        if (this.f2132a.f() != null) {
            i(aVar, this.f2132a.f(), true);
        }
        return true;
    }

    private boolean g(c.a.a.a aVar) {
        try {
            String str = f2131c;
            aVar.n(str, "task");
            aVar.a(str, "name", this.f2132a.d());
            aVar.a(str, "times", String.valueOf(this.f2132a.l()));
            aVar.a(str, "testTimeOut", String.valueOf(this.f2132a.k()));
            aVar.a(str, "takeScreenshot", this.f2132a.g() ? "true" : "false");
            aVar.a(str, "taskRegressionType", String.valueOf(this.f2132a.h()));
            aVar.a(str, "caseRegressionType", String.valueOf(this.f2132a.b()));
            aVar.a(str, "testpointRegressionTimes", String.valueOf(this.f2132a.j()));
            f(aVar);
            j(aVar);
            aVar.d(str, "task");
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void h(c.a.a.a aVar, b.b.a.a.d.c cVar) {
        String str;
        String o;
        String str2;
        String str3 = f2131c;
        aVar.n(str3, "testcase");
        aVar.a(str3, "type", cVar.getType());
        aVar.a(str3, "times", String.valueOf(cVar.a()));
        aVar.n(str3, "device");
        aVar.a(str3, "name", cVar.d());
        aVar.d(str3, "device");
        if (cVar instanceof j) {
            str = "jar";
            aVar.n(str3, "jar");
            o = cVar.h();
        } else if (!(cVar instanceof i) && !(cVar instanceof b.b.a.a.d.e)) {
            if (!(cVar instanceof b.b.a.a.d.a)) {
                str2 = cVar instanceof b.b.a.a.d.d ? "command" : "command";
                e(aVar, cVar.i());
                d(aVar, cVar.e());
                aVar.d(str3, "testcase");
            }
            str2 = "cmd";
            aVar.n(str3, str2);
            aVar.a(str3, "name", cVar.h());
            aVar.d(str3, str2);
            e(aVar, cVar.i());
            d(aVar, cVar.e());
            aVar.d(str3, "testcase");
        } else {
            aVar.n(str3, "apk");
            aVar.a(str3, "name", cVar.h());
            aVar.d(str3, "apk");
            str = "package";
            aVar.n(str3, "package");
            o = ((b.b.a.a.d.e) cVar).o();
        }
        aVar.a(str3, "name", o);
        aVar.d(str3, str);
        aVar.n(str3, "class");
        aVar.a(str3, "name", cVar.k());
        aVar.d(str3, "class");
        aVar.n(str3, "method");
        aVar.a(str3, "name", cVar.b());
        aVar.d(str3, "method");
        e(aVar, cVar.i());
        d(aVar, cVar.e());
        aVar.d(str3, "testcase");
    }

    private void i(c.a.a.a aVar, b.b.a.a.d.h hVar, boolean z) {
        String str = f2131c;
        if (z) {
            aVar.n(str, "proviouspoint");
        } else {
            aVar.n(str, "testpoint");
        }
        String str2 = f2131c;
        aVar.a(str2, "name", hVar.m());
        aVar.a(str2, "times", String.valueOf(hVar.a()));
        String i = hVar.i();
        if (i != null && !i.isEmpty()) {
            e(aVar, i);
        }
        for (b.b.a.a.d.c cVar : hVar.n()) {
            h(aVar, cVar);
        }
        String str3 = f2131c;
        if (z) {
            aVar.d(str3, "proviouspoint");
        } else {
            aVar.d(str3, "testpoint");
        }
    }

    private boolean j(c.a.a.a aVar) {
        Iterator<b.b.a.a.d.h> it = this.f2132a.i().iterator();
        while (it.hasNext()) {
            i(aVar, it.next(), false);
        }
        return true;
    }

    /* JADX WARN: Code restructure failed: missing block: B:19:0x003e, code lost:
        if (r1 != null) goto L22;
     */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x0049, code lost:
        if (r1 == null) goto L21;
     */
    /* JADX WARN: Code restructure failed: missing block: B:27:0x004b, code lost:
        com.ape.offlinescriptmanager.utils.g.d(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:28:0x004e, code lost:
        return true;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean k() {
        /*
            r5 = this;
            r0 = 1
            b.b.a.a.d.f r1 = r5.f2132a     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            java.lang.String r1 = r1.e()     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            c.a.a.a r2 = r5.b(r1)     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            r3 = 0
            if (r2 != 0) goto L1f
            java.lang.String r2 = "create %s fail"
            java.lang.Object[] r4 = new java.lang.Object[r0]     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            r4[r3] = r1     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            com.ape.offlinescriptmanager.utils.b.d(r2, r4)     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            java.io.OutputStream r0 = r5.f2133b
            if (r0 == 0) goto L1e
            com.ape.offlinescriptmanager.utils.g.d(r0)
        L1e:
            return r3
        L1f:
            boolean r4 = r5.g(r2)     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            if (r4 != 0) goto L30
            r5.c(r2)     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            java.io.OutputStream r0 = r5.f2133b
            if (r0 == 0) goto L2f
            com.ape.offlinescriptmanager.utils.g.d(r0)
        L2f:
            return r3
        L30:
            r5.c(r2)     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            java.lang.String r2 = "save %s success"
            java.lang.Object[] r4 = new java.lang.Object[r0]     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            r4[r3] = r1     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            com.ape.offlinescriptmanager.utils.b.i(r2, r4)     // Catch: java.lang.Throwable -> L41 java.lang.Exception -> L43
            java.io.OutputStream r1 = r5.f2133b
            if (r1 == 0) goto L4e
            goto L4b
        L41:
            r0 = move-exception
            goto L4f
        L43:
            r1 = move-exception
            r1.printStackTrace()     // Catch: java.lang.Throwable -> L41
            java.io.OutputStream r1 = r5.f2133b
            if (r1 == 0) goto L4e
        L4b:
            com.ape.offlinescriptmanager.utils.g.d(r1)
        L4e:
            return r0
        L4f:
            java.io.OutputStream r1 = r5.f2133b
            if (r1 == 0) goto L56
            com.ape.offlinescriptmanager.utils.g.d(r1)
        L56:
            throw r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.utils.m.g.k():boolean");
    }
}
