package d.n.j.h;

import d.f;
import d.g;
import d.j;
import d.k;
import d.n.j.h.b;
import d.q.b;
import java.io.IOException;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;
/* loaded from: classes.dex */
public class d extends g implements d.q.a {
    private static boolean s = System.getProperty("os.name").toLowerCase().contains("win");
    private b m;
    private ServerSocketChannel n;
    private b.a o;
    private j p;
    private String q;
    private final d.n.c r;

    public d(d.n.d dVar, j jVar, f fVar) {
        super(dVar, fVar);
        this.r = new d.n.c(dVar, this);
        this.n = null;
        this.p = jVar;
    }

    private SocketChannel H0() {
        SocketChannel accept = this.n.accept();
        if (!this.e.A.isEmpty()) {
            boolean z = false;
            Iterator<b.a> it = this.e.A.iterator();
            while (true) {
                if (!it.hasNext()) {
                    break;
                } else if (it.next().e(this.m.c())) {
                    z = true;
                    break;
                }
            }
            if (!z) {
                try {
                    accept.close();
                    return null;
                } catch (IOException unused) {
                    return null;
                }
            }
        }
        int i = this.e.i;
        if (i != 0) {
            e.b(accept, i);
        }
        int i2 = this.e.g;
        if (i2 != 0) {
            e.f(accept, i2);
        }
        int i3 = this.e.h;
        if (i3 != 0) {
            e.e(accept, i3);
        }
        if (!s) {
            e.d(accept, true);
        }
        return accept;
    }

    private void close() {
        try {
            this.n.close();
            this.p.V0(this.q, this.n);
        } catch (IOException e) {
            this.p.U0(this.q, k.a(e));
        }
        this.n = null;
    }

    public String I0() {
        return this.m.toString();
    }

    public boolean J0(String str) {
        b bVar = new b(str, this.e.q);
        this.m = bVar;
        this.q = bVar.toString();
        try {
            ServerSocketChannel open = ServerSocketChannel.open();
            this.n = open;
            if (open == null && this.m.b() == d.n.j.d.INET6) {
                boolean z = this.e.q;
            }
            if (this.m.b() == d.n.j.d.INET6) {
                e.a(this.n);
            }
            e.i(this.n);
            int i = this.e.g;
            if (i != 0) {
                e.f(this.n, i);
            }
            int i2 = this.e.h;
            if (i2 != 0) {
                e.e(this.n, i2);
            }
            if (!s) {
                e.d(this.n, true);
            }
            this.n.socket().bind(this.m.c(), this.e.n);
            this.p.b1(this.q, this.n);
            return true;
        } catch (IOException unused) {
            close();
            this.l.c(48);
            return false;
        }
    }

    @Override // d.m
    protected void R() {
        this.r.f();
        b.a a2 = this.r.a(this.n);
        this.o = a2;
        this.r.k(a2);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.g, d.m
    public void W(int i) {
        this.r.g(this.o);
        this.o = null;
        close();
        super.W(i);
    }

    @Override // d.q.a
    public void b() {
        try {
            SocketChannel H0 = H0();
            if (H0 == null) {
                this.p.R0(this.q, 49);
                return;
            }
            e.h(H0);
            f fVar = this.e;
            e.g(H0, fVar.w, fVar.x, fVar.y, fVar.z);
            try {
                d.n.b gVar = new d.n.g(H0, this.e, this.q);
                d.n.f e = d.r.d.e(C(this.e.f2549c), false, this.p, this.e, null);
                e.z0();
                B0(e);
                d0(e, gVar, false);
                this.p.S0(this.q, H0);
            } catch (k.c unused) {
                this.p.R0(this.q, 22);
            }
        } catch (IOException e2) {
            this.p.R0(this.q, k.a(e2));
        }
    }

    @Override // d.q.a
    public void e() {
        throw new UnsupportedOperationException();
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

    public String toString() {
        return String.valueOf(getClass().getSimpleName()) + "[" + this.e.J + "]";
    }

    @Override // d.g
    public void y0() {
        this.r.o();
    }
}
