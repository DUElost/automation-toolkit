package org.xmlpull.v1;

import java.io.PrintStream;
/* loaded from: classes.dex */
public class a extends Exception {

    /* renamed from: b  reason: collision with root package name */
    protected Throwable f2820b;

    public a(String str) {
        super(str);
    }

    @Override // java.lang.Throwable
    public void printStackTrace() {
        if (this.f2820b == null) {
            super.printStackTrace();
            return;
        }
        synchronized (System.err) {
            PrintStream printStream = System.err;
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append(super.getMessage());
            stringBuffer.append("; nested exception is:");
            printStream.println(stringBuffer.toString());
            this.f2820b.printStackTrace();
        }
    }
}
