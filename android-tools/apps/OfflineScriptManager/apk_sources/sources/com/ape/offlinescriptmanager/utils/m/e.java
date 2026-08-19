package com.ape.offlinescriptmanager.utils.m;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;
/* loaded from: classes.dex */
public class e {

    /* renamed from: c  reason: collision with root package name */
    private static final String f2123c = null;

    /* renamed from: a  reason: collision with root package name */
    private b.b.a.a.e.e f2124a;

    /* renamed from: b  reason: collision with root package name */
    private OutputStream f2125b = null;

    public e(b.b.a.a.e.e eVar) {
        this.f2124a = null;
        this.f2124a = eVar;
    }

    private OutputStream a(String str) {
        return new FileOutputStream(new File(str));
    }

    private c.a.a.a b(String str) {
        try {
            c.a.a.a aVar = new c.a.a.a();
            OutputStream a2 = a(str);
            this.f2125b = a2;
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

    private void d(c.a.a.a aVar, b.b.a.a.e.b bVar) {
        String str = f2123c;
        aVar.n(str, "TestData");
        aVar.a(str, "name", bVar.a());
        aVar.a(str, "value", bVar.b());
        aVar.d(str, "TestData");
    }

    private void e(c.a.a.a aVar) {
        for (Map.Entry<String, String> entry : this.f2124a.d().entrySet()) {
            if (entry.getKey() != null && entry.getValue() != null) {
                String str = f2123c;
                aVar.n(str, "SIM");
                aVar.a(str, entry.getKey(), entry.getValue());
                aVar.d(str, "SIM");
            }
        }
    }

    private void f(c.a.a.a aVar, b.b.a.a.e.a aVar2) {
        String str = f2123c;
        aVar.n(str, "TestCase");
        aVar.a(str, "name", aVar2.b());
        for (Map.Entry<String, b.b.a.a.e.c> entry : aVar2.c().entrySet()) {
            h(aVar, entry.getValue());
        }
        aVar.d(f2123c, "TestCase");
    }

    private boolean g(c.a.a.a aVar) {
        try {
            String str = f2123c;
            aVar.n(str, "TestSet");
            aVar.a(str, "name", this.f2124a.c());
            aVar.a(str, "TakeScreenshot", this.f2124a.e());
            e(aVar);
            j(aVar);
            aVar.d(str, "TestSet");
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void h(c.a.a.a aVar, b.b.a.a.e.c cVar) {
        String str = f2123c;
        aVar.n(str, "TestMethod");
        aVar.a(str, "name", cVar.b());
        for (Map.Entry<String, b.b.a.a.e.b> entry : cVar.c().entrySet()) {
            d(aVar, entry.getValue());
        }
        aVar.d(f2123c, "TestMethod");
    }

    private void i(c.a.a.a aVar, b.b.a.a.e.d dVar) {
        String str = f2123c;
        aVar.n(str, "TestPackage");
        aVar.a(str, "appPackageName", dVar.b());
        aVar.a(str, "runner", dVar.c());
        for (Map.Entry<String, b.b.a.a.e.a> entry : dVar.d().entrySet()) {
            f(aVar, entry.getValue());
        }
        aVar.d(f2123c, "TestPackage");
    }

    private void j(c.a.a.a aVar) {
        for (Map.Entry<String, b.b.a.a.e.d> entry : this.f2124a.f().entrySet()) {
            i(aVar, entry.getValue());
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:19:0x003a, code lost:
        if (r1 != null) goto L23;
     */
    /* JADX WARN: Code restructure failed: missing block: B:26:0x0045, code lost:
        if (r1 == null) goto L22;
     */
    /* JADX WARN: Code restructure failed: missing block: B:27:0x0047, code lost:
        com.ape.offlinescriptmanager.utils.g.d(r1);
     */
    /* JADX WARN: Code restructure failed: missing block: B:28:0x004a, code lost:
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
            java.lang.String r1 = "/sdcard/UiAutomatorTestData.xml"
            c.a.a.a r2 = r5.b(r1)     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            r3 = 0
            if (r2 != 0) goto L1b
            java.lang.String r2 = "create %s fail"
            java.lang.Object[] r4 = new java.lang.Object[r0]     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            r4[r3] = r1     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            com.ape.offlinescriptmanager.utils.b.d(r2, r4)     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            java.io.OutputStream r0 = r5.f2125b
            if (r0 == 0) goto L1a
            com.ape.offlinescriptmanager.utils.g.d(r0)
        L1a:
            return r3
        L1b:
            boolean r4 = r5.g(r2)     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            if (r4 != 0) goto L2c
            r5.c(r2)     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            java.io.OutputStream r0 = r5.f2125b
            if (r0 == 0) goto L2b
            com.ape.offlinescriptmanager.utils.g.d(r0)
        L2b:
            return r3
        L2c:
            r5.c(r2)     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            java.lang.String r2 = "save %s success"
            java.lang.Object[] r4 = new java.lang.Object[r0]     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            r4[r3] = r1     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            com.ape.offlinescriptmanager.utils.b.i(r2, r4)     // Catch: java.lang.Throwable -> L3d java.lang.Exception -> L3f
            java.io.OutputStream r1 = r5.f2125b
            if (r1 == 0) goto L4a
            goto L47
        L3d:
            r0 = move-exception
            goto L4b
        L3f:
            r1 = move-exception
            r1.printStackTrace()     // Catch: java.lang.Throwable -> L3d
            java.io.OutputStream r1 = r5.f2125b
            if (r1 == 0) goto L4a
        L47:
            com.ape.offlinescriptmanager.utils.g.d(r1)
        L4a:
            return r0
        L4b:
            java.io.OutputStream r1 = r5.f2125b
            if (r1 == 0) goto L52
            com.ape.offlinescriptmanager.utils.g.d(r1)
        L52:
            throw r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.utils.m.e.k():boolean");
    }
}
