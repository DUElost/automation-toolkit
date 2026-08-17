package c.b.a.a;
/* loaded from: classes.dex */
public class b extends RuntimeException {

    /* renamed from: b  reason: collision with root package name */
    Throwable f1689b;

    /* JADX WARN: Illegal instructions before constructor call */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public b(java.lang.String r3, java.lang.Throwable r4) {
        /*
            r2 = this;
            if (r4 != 0) goto L3
            goto L1c
        L3:
            java.lang.StringBuffer r0 = new java.lang.StringBuffer
            r0.<init>()
            java.lang.String r1 = "Exception while initializing "
            r0.append(r1)
            r0.append(r3)
            java.lang.String r3 = ": "
            r0.append(r3)
            r0.append(r4)
            java.lang.String r3 = r0.toString()
        L1c:
            r2.<init>(r3)
            r2.f1689b = r4
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: c.b.a.a.b.<init>(java.lang.String, java.lang.Throwable):void");
    }

    @Override // java.lang.Throwable
    public Throwable getCause() {
        return this.f1689b;
    }
}
