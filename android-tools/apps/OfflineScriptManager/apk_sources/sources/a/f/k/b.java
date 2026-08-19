package a.f.k;

import android.util.Log;
import java.io.Writer;
/* loaded from: classes.dex */
public class b extends Writer {

    /* renamed from: b  reason: collision with root package name */
    private final String f166b;

    /* renamed from: c  reason: collision with root package name */
    private StringBuilder f167c = new StringBuilder(128);

    public b(String str) {
        this.f166b = str;
    }

    private void a() {
        if (this.f167c.length() > 0) {
            Log.d(this.f166b, this.f167c.toString());
            StringBuilder sb = this.f167c;
            sb.delete(0, sb.length());
        }
    }

    @Override // java.io.Writer, java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        a();
    }

    @Override // java.io.Writer, java.io.Flushable
    public void flush() {
        a();
    }

    @Override // java.io.Writer
    public void write(char[] cArr, int i, int i2) {
        for (int i3 = 0; i3 < i2; i3++) {
            char c2 = cArr[i + i3];
            if (c2 == '\n') {
                a();
            } else {
                this.f167c.append(c2);
            }
        }
    }
}
