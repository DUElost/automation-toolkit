package com.ape.offlinescriptmanager.utils.l;

import com.ape.offlinescriptmanager.utils.l.e;
/* loaded from: classes.dex */
public final class d {

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a implements e.a {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ Process f2089a;

        a(Process process) {
            this.f2089a = process;
        }

        @Override // com.ape.offlinescriptmanager.utils.l.e.a
        public void a() {
            this.f2089a.destroy();
            com.ape.offlinescriptmanager.utils.b.h("RunListener: out of max time and destroy process");
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:18:0x0058, code lost:
        com.ape.offlinescriptmanager.utils.b.i("RunCaseTestTimeOut: %s", java.lang.Integer.valueOf(r14));
     */
    /* JADX WARN: Code restructure failed: missing block: B:19:0x006a, code lost:
        throw new java.util.concurrent.TimeoutException();
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public static void a(java.lang.String r12, com.ape.offlinescriptmanager.utils.l.a r13, int r14) {
        /*
            java.util.concurrent.TimeUnit r0 = java.util.concurrent.TimeUnit.MILLISECONDS
            r1 = 0
            if (r14 <= 0) goto L11
            java.lang.String r3 = "Time unit must not be null for non-zero max."
            java.util.Objects.requireNonNull(r0, r3)
            long r3 = (long) r14
            long r3 = r0.toMillis(r3)
            goto L12
        L11:
            r3 = r1
        L12:
            r0 = 0
            java.lang.Process r12 = com.ape.offlinescriptmanager.utils.g.i(r12)     // Catch: java.lang.Throwable -> La3
            com.ape.offlinescriptmanager.utils.l.e r5 = new com.ape.offlinescriptmanager.utils.l.e     // Catch: java.lang.Throwable -> La3
            com.ape.offlinescriptmanager.utils.l.d$a r6 = new com.ape.offlinescriptmanager.utils.l.d$a     // Catch: java.lang.Throwable -> La3
            r6.<init>(r12)     // Catch: java.lang.Throwable -> La3
            r5.<init>(r6)     // Catch: java.lang.Throwable -> La3
            r5.c(r14)     // Catch: java.lang.Throwable -> La3
            r6 = 1
            r5.a(r6)     // Catch: java.lang.Throwable -> La3
            r5.d()     // Catch: java.lang.Throwable -> La3
            java.io.BufferedReader r5 = new java.io.BufferedReader     // Catch: java.lang.Throwable -> La3
            java.io.InputStreamReader r7 = new java.io.InputStreamReader     // Catch: java.lang.Throwable -> La3
            java.io.InputStream r12 = r12.getInputStream()     // Catch: java.lang.Throwable -> La3
            java.nio.charset.Charset r8 = java.nio.charset.Charset.defaultCharset()     // Catch: java.lang.Throwable -> La3
            r7.<init>(r12, r8)     // Catch: java.lang.Throwable -> La3
            r5.<init>(r7)     // Catch: java.lang.Throwable -> La3
            r7 = r1
        L3e:
            java.lang.String r12 = r5.readLine()     // Catch: java.lang.Throwable -> La0
            if (r12 == 0) goto L99
            boolean r0 = r12.isEmpty()     // Catch: java.lang.Throwable -> La0
            r9 = 0
            if (r0 == 0) goto L6f
            r0 = 25
            long r10 = (long) r0     // Catch: java.lang.Throwable -> La0
            long r7 = r7 + r10
            int r0 = (r3 > r1 ? 1 : (r3 == r1 ? 0 : -1))
            if (r0 <= 0) goto L6b
            int r0 = (r7 > r3 ? 1 : (r7 == r3 ? 0 : -1))
            if (r0 > 0) goto L58
            goto L6b
        L58:
            java.lang.String r12 = "RunCaseTestTimeOut: %s"
            java.lang.Object[] r13 = new java.lang.Object[r6]     // Catch: java.lang.Throwable -> La0
            java.lang.Integer r14 = java.lang.Integer.valueOf(r14)     // Catch: java.lang.Throwable -> La0
            r13[r9] = r14     // Catch: java.lang.Throwable -> La0
            com.ape.offlinescriptmanager.utils.b.i(r12, r13)     // Catch: java.lang.Throwable -> La0
            java.util.concurrent.TimeoutException r12 = new java.util.concurrent.TimeoutException     // Catch: java.lang.Throwable -> La0
            r12.<init>()     // Catch: java.lang.Throwable -> La0
            throw r12     // Catch: java.lang.Throwable -> La0
        L6b:
            com.ape.offlinescriptmanager.utils.g.L(r10)     // Catch: java.lang.Throwable -> La0
            goto L8a
        L6f:
            java.lang.String r0 = "cmdReviceer: %s"
            java.lang.Object[] r7 = new java.lang.Object[r6]     // Catch: java.lang.Throwable -> La0
            r7[r9] = r12     // Catch: java.lang.Throwable -> La0
            com.ape.offlinescriptmanager.utils.b.i(r0, r7)     // Catch: java.lang.Throwable -> La0
            java.lang.StringBuilder r0 = new java.lang.StringBuilder     // Catch: java.lang.Throwable -> La0
            r0.<init>()     // Catch: java.lang.Throwable -> La0
            r0.append(r12)     // Catch: java.lang.Throwable -> La0
            java.lang.String r12 = "\r\n"
            r0.append(r12)     // Catch: java.lang.Throwable -> La0
            java.lang.String r12 = r0.toString()     // Catch: java.lang.Throwable -> La0
            r7 = r1
        L8a:
            if (r13 == 0) goto L3e
            byte[] r0 = r12.getBytes()     // Catch: java.lang.Throwable -> La0
            byte[] r12 = r12.getBytes()     // Catch: java.lang.Throwable -> La0
            int r12 = r12.length     // Catch: java.lang.Throwable -> La0
            r13.b(r0, r9, r12)     // Catch: java.lang.Throwable -> La0
            goto L3e
        L99:
            com.ape.offlinescriptmanager.utils.g.e(r5)
            r13.flush()
            return
        La0:
            r12 = move-exception
            r0 = r5
            goto La4
        La3:
            r12 = move-exception
        La4:
            com.ape.offlinescriptmanager.utils.g.e(r0)
            throw r12
        */
        throw new UnsupportedOperationException("Method not decompiled: com.ape.offlinescriptmanager.utils.l.d.a(java.lang.String, com.ape.offlinescriptmanager.utils.l.a, int):void");
    }
}
