package d;

import d.q.b;
import java.io.Closeable;
import java.util.concurrent.atomic.AtomicBoolean;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public final class h extends m implements d.q.a, Closeable {
    private final d e;
    private final b.a f;
    private final d.q.b g;
    private int h;
    private final AtomicBoolean i;
    private final String j;

    /* JADX INFO: Access modifiers changed from: package-private */
    public h(c cVar, int i) {
        super(cVar, i);
        this.i = new AtomicBoolean();
        this.h = 0;
        String str = "reaper-" + i;
        this.j = str;
        d.q.b bVar = new d.q.b(cVar, str);
        this.g = bVar;
        d dVar = new d(cVar, str, i);
        this.e = dVar;
        b.a h = bVar.h(dVar.a(), this);
        this.f = h;
        bVar.r(h);
    }

    private void x0() {
        h0();
        this.g.m(this.f);
        this.g.u();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void A0() {
        if (this.i.get()) {
            return;
        }
        r0();
    }

    @Override // d.m
    protected void S(j jVar) {
        this.h++;
        jVar.h1(this.g);
    }

    @Override // d.m
    protected void T() {
        int i = this.h - 1;
        this.h = i;
        if (i == 0 && this.i.get()) {
            x0();
        }
    }

    @Override // d.m
    protected void V() {
        this.i.set(true);
        if (this.h == 0) {
            x0();
        }
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
            a b2 = this.e.b(0L);
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

    /* JADX INFO: Access modifiers changed from: package-private */
    public d y0() {
        return this.e;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void z0() {
        this.g.t();
    }
}
