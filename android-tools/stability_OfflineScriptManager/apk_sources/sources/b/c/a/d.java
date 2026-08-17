package b.c.a;

import b.c.a.i.q;
import java.io.Closeable;
/* loaded from: classes.dex */
public class d extends b.e.a.d implements Closeable {
    static {
        b.e.a.j.f.a(d.class);
    }

    public d(b.e.a.e eVar) {
        this(eVar, new g(new String[0]));
    }

    public d(b.e.a.e eVar, b bVar) {
        C(eVar, eVar.size(), bVar);
    }

    public static byte[] F(String str) {
        byte[] bArr = new byte[4];
        if (str != null) {
            for (int i = 0; i < Math.min(4, str.length()); i++) {
                bArr[i] = (byte) str.charAt(i);
            }
        }
        return bArr;
    }

    public q G() {
        for (b.c.a.i.b bVar : e()) {
            if (bVar instanceof q) {
                return (q) bVar;
            }
        }
        return null;
    }

    @Override // b.e.a.d, java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        this.f1515c.close();
    }

    @Override // b.e.a.d
    public String toString() {
        return "model(" + this.f1515c.toString() + ")";
    }
}
