package d.n.j.h;

import d.g;
import d.j;
import d.k;
import d.n.f;
import d.n.j.a;
import d.q.b;
import java.io.IOException;
import java.net.SocketAddress;
import java.nio.channels.SocketChannel;
/* loaded from: classes.dex */
public class c extends g implements d.q.a {
    protected final d.n.c m;
    private final d.n.j.a n;
    private SocketChannel o;
    private b.a p;
    protected final boolean q;
    private boolean r;
    private final f s;
    private int t;
    private final j u;

    public c(d.n.d dVar, f fVar, d.f fVar2, d.n.j.a aVar, boolean z) {
        super(dVar, fVar2);
        this.m = new d.n.c(dVar, this);
        this.n = aVar;
        this.o = null;
        this.q = z;
        this.r = false;
        this.s = fVar;
        this.t = this.e.l;
        aVar.toString();
        this.u = fVar.N0();
    }

    private void H0() {
        int J0 = J0();
        this.m.c(J0, 1);
        try {
            this.n.e(this.e.q);
        } catch (Exception unused) {
        }
        this.u.X0(this.n.toString(), J0);
        this.r = true;
    }

    private SocketChannel I0() {
        try {
            this.o.finishConnect();
            return this.o;
        } catch (IOException unused) {
            return null;
        }
    }

    private int J0() {
        int i = this.t;
        int c2 = d.s.e.c();
        d.f fVar = this.e;
        int i2 = fVar.l;
        int i3 = i + (c2 % i2);
        int i4 = fVar.m;
        if (i4 > 0 && i4 > i2) {
            this.t = Math.min(this.t * 2, i4);
        }
        return i3;
    }

    private boolean K0() {
        d.n.j.a aVar = this.n;
        if (aVar != null) {
            aVar.e(this.e.q);
            a.InterfaceC0113a f = this.n.f();
            if (f != null) {
                SocketAddress c2 = f.c();
                if (c2 != null) {
                    SocketChannel open = SocketChannel.open();
                    this.o = open;
                    if (open == null && f.b() == d.n.j.d.INET6 && this.e.q) {
                        f = this.n.e(false);
                        if (f == null) {
                            return false;
                        }
                        c2 = f.c();
                        this.o = SocketChannel.open();
                    }
                    if (f.b() == d.n.j.d.INET6) {
                        e.a(this.o);
                    }
                    e.i(this.o);
                    int i = this.e.g;
                    if (i != 0) {
                        e.f(this.o, i);
                    }
                    int i2 = this.e.h;
                    if (i2 != 0) {
                        e.e(this.o, i2);
                    }
                    int i3 = this.e.i;
                    if (i3 != 0) {
                        e.b(this.o, i3);
                    }
                    f.a();
                    try {
                        boolean connect = this.o.connect(c2);
                        if (!connect) {
                            this.l.c(36);
                        }
                        return connect;
                    } catch (IllegalArgumentException e) {
                        throw new IOException(e.getMessage(), e);
                    }
                }
                throw new IOException("Socket address not resolved");
            }
            throw new IOException("Address not resolved");
        }
        throw new IOException("Null address");
    }

    private void L0() {
        try {
            if (K0()) {
                this.p = this.m.a(this.o);
                q();
            } else {
                b.a a2 = this.m.a(this.o);
                this.p = a2;
                this.m.l(a2);
                this.u.W0(this.n.toString(), -1);
            }
        } catch (IOException | RuntimeException unused) {
            if (this.o != null) {
                close();
            }
            H0();
        }
    }

    @Override // d.m
    protected void R() {
        this.m.f();
        if (this.q) {
            H0();
        } else {
            L0();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.g, d.m
    public void W(int i) {
        if (this.r) {
            this.m.d(1);
            this.r = false;
        }
        b.a aVar = this.p;
        if (aVar != null) {
            this.m.g(aVar);
            this.p = null;
        }
        if (this.o != null) {
            close();
        }
        super.W(i);
    }

    @Override // d.q.a
    public void b() {
        throw new UnsupportedOperationException();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void close() {
        try {
            this.o.close();
            this.u.V0(this.n.toString(), this.o);
        } catch (IOException e) {
            this.u.U0(this.n.toString(), k.a(e));
        }
        this.o = null;
    }

    public void e() {
    }

    public void h(int i) {
        this.r = false;
        L0();
    }

    @Override // d.q.a
    public void q() {
        this.m.g(this.p);
        this.p = null;
        SocketChannel I0 = I0();
        if (I0 == null) {
            close();
            H0();
            return;
        }
        try {
            e.h(I0);
            d.f fVar = this.e;
            e.g(I0, fVar.w, fVar.x, fVar.y, fVar.z);
            try {
                d.n.g gVar = new d.n.g(I0, this.e, this.n.toString());
                this.o = null;
                c0(this.s, gVar);
                F0();
                this.u.Y0(this.n.toString(), I0);
            } catch (k.c unused) {
            }
        } catch (IOException e) {
            throw new k.b(e);
        }
    }

    public void s() {
    }

    public String toString() {
        return String.valueOf(getClass().getSimpleName()) + "[" + this.e.J + "]";
    }

    @Override // d.g
    protected void y0() {
        this.m.o();
    }
}
