package d.n;

import d.m;
import d.q.b;
import java.io.Closeable;
/* loaded from: classes.dex */
public class d extends m implements d.q.a, Closeable {
    private final d.d e;
    private final b.a f;
    private final d.q.b g;
    private final String h;

    public d(d.c cVar, int i) {
        super(cVar, i);
        String str = "iothread-" + i;
        this.h = str;
        d.q.b bVar = new d.q.b(cVar, str);
        this.g = bVar;
        d.d dVar = new d.d(cVar, str, i);
        this.e = dVar;
        b.a h = bVar.h(dVar.a(), this);
        this.f = h;
        bVar.r(h);
    }

    public void A0() {
        this.g.t();
    }

    public void B0() {
        r0();
    }

    @Override // d.m
    protected void V() {
        this.g.m(this.f);
        this.g.u();
    }

    @Override // d.q.a
    public void b() {
        throw new UnsupportedOperationException();
    }

    @Override // java.io.Closeable, java.lang.AutoCloseable
    public void close() {
        this.g.i();
        this.e.close();
    }

    @Override // d.q.a
    public void e() {
        while (true) {
            d.a b2 = this.e.b(0L);
            if (b2 == null) {
                return;
            }
            b2.a();
        }
    }

    @Override // d.q.a
    public void h(int i) {
        throw new UnsupportedOperationException();
    }

    @Override // d.q.a
    public void q() {
        throw new UnsupportedOperationException();
    }

    @Override // d.q.a
    public void s() {
        throw new UnsupportedOperationException();
    }

    public int x0() {
        return this.g.g();
    }

    public d.d y0() {
        return this.e;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public d.q.b z0() {
        return this.g;
    }
}
