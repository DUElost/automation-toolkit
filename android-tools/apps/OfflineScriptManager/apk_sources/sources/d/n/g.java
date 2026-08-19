package d.n;

import d.e;
import d.k;
import d.n.h.e;
import d.n.i.a;
import d.q.b;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.SocketChannel;
/* loaded from: classes.dex */
public class g implements d.n.b, d.q.a {
    private boolean A;
    private boolean B;
    private d.j C;
    private d.n.j.a D;
    private final d.s.c E;
    private final e F;
    private final e G;
    private final e H;
    private final e I;
    private final e J;
    private final e K;
    private final e L;
    private final e M;
    private final e N;
    private final e O;

    /* renamed from: b  reason: collision with root package name */
    private d.n.c f2573b;

    /* renamed from: c  reason: collision with root package name */
    private SocketChannel f2574c;

    /* renamed from: d  reason: collision with root package name */
    private b.a f2575d;
    private ByteBuffer e;
    private int f;
    private d.n.h.e g;
    private final d.s.f<ByteBuffer> h;
    private int i;
    private d.n.h.f j;
    private d.n.e k;
    private boolean l;
    private int m;
    private final ByteBuffer n;
    private final ByteBuffer o;
    private f p;
    private d.n.f q;
    private d.f r;
    private String s;
    private boolean t;
    private e u;
    private e v;
    private boolean w;
    private boolean x;
    private d.n.i.a y;
    private boolean z;

    /* loaded from: classes.dex */
    private final class a extends e.a {
        private a() {
        }

        /* synthetic */ a(g gVar, a aVar) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public boolean a(d.e eVar) {
            d.e i = g.this.y.i(eVar);
            if (i == null) {
                return false;
            }
            if (g.this.k != null) {
                i.z(g.this.k);
            }
            if (g.this.q.P0(i)) {
                return true;
            }
            if (g.this.E.b(35)) {
                g gVar = g.this;
                gVar.v = gVar.O;
            }
            return false;
        }
    }

    /* loaded from: classes.dex */
    public enum b {
        PROTOCOL,
        CONNECTION,
        TIMEOUT;

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static b[] valuesCustom() {
            b[] valuesCustom = values();
            int length = valuesCustom.length;
            b[] bVarArr = new b[length];
            System.arraycopy(valuesCustom, 0, bVarArr, 0, length);
            return bVarArr;
        }
    }

    /* loaded from: classes.dex */
    private final class c extends e.a {
        private c() {
        }

        /* synthetic */ c(g gVar, c cVar) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public boolean a(d.e eVar) {
            return g.this.G(eVar);
        }

        @Override // d.n.g.e.a, d.n.g.e
        public d.e b() {
            return g.this.F();
        }
    }

    /* loaded from: classes.dex */
    private final class d implements e {
        private d() {
        }

        /* synthetic */ d(g gVar, d dVar) {
            this();
        }

        @Override // d.n.g.e
        public boolean a(d.e eVar) {
            return g.this.H(eVar);
        }

        @Override // d.n.g.e
        public d.e b() {
            return g.this.C();
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public interface e {

        /* loaded from: classes.dex */
        public static class a implements e {
            @Override // d.n.g.e
            public boolean a(d.e eVar) {
                throw new UnsupportedOperationException("processMsg is not implemented and should not be used here");
            }

            @Override // d.n.g.e
            public d.e b() {
                throw new UnsupportedOperationException("nextMsg is not implemented and should not be used here");
            }
        }

        boolean a(d.e eVar);

        d.e b();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public enum f {
        V0(-1),
        V1(0),
        V2(1),
        V3(3);
        

        /* renamed from: b  reason: collision with root package name */
        private final byte f2584b;

        f(int i) {
            this.f2584b = (byte) i;
        }

        /* renamed from: values  reason: to resolve conflict with enum method */
        public static f[] valuesCustom() {
            f[] valuesCustom = values();
            int length = valuesCustom.length;
            f[] fVarArr = new f[length];
            System.arraycopy(valuesCustom, 0, fVarArr, 0, length);
            return fVarArr;
        }
    }

    /* renamed from: d.n.g$g  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private final class C0105g extends e.a {
        private C0105g() {
        }

        /* synthetic */ C0105g(g gVar, C0105g c0105g) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public d.e b() {
            d.e O0 = g.this.q.O0();
            if (O0 == null) {
                return null;
            }
            return g.this.y.k(O0);
        }
    }

    /* loaded from: classes.dex */
    private final class h extends e.a {
        private h() {
        }

        /* synthetic */ h(g gVar, h hVar) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public boolean a(d.e eVar) {
            return g.this.J(eVar);
        }

        @Override // d.n.g.e.a, d.n.g.e
        public d.e b() {
            return g.this.I();
        }
    }

    /* loaded from: classes.dex */
    private final class i extends e.a {
        private i() {
        }

        /* synthetic */ i(g gVar, i iVar) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public boolean a(d.e eVar) {
            boolean P0 = g.this.q.P0(eVar);
            if (P0) {
                g gVar = g.this;
                gVar.v = gVar.N;
            }
            return P0;
        }
    }

    /* loaded from: classes.dex */
    private final class j extends e.a {
        private j() {
        }

        /* synthetic */ j(g gVar, j jVar) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public boolean a(d.e eVar) {
            return g.this.K(eVar);
        }
    }

    /* loaded from: classes.dex */
    private final class k extends e.a {
        private k() {
        }

        /* synthetic */ k(g gVar, k kVar) {
            this();
        }

        @Override // d.n.g.e.a, d.n.g.e
        public boolean a(d.e eVar) {
            return g.this.P(eVar);
        }
    }

    public g(SocketChannel socketChannel, d.f fVar, String str) {
        d dVar = new d(this, null);
        this.F = dVar;
        c cVar = new c(this, null);
        this.G = cVar;
        this.H = cVar;
        h hVar = new h(this, null);
        this.I = hVar;
        this.J = hVar;
        this.K = new j(this, null);
        this.L = new k(this, null);
        this.M = new C0105g(this, null);
        this.N = new a(this, null);
        this.O = new i(this, null);
        this.E = fVar.P;
        this.f2574c = socketChannel;
        this.l = true;
        this.m = 12;
        this.r = fVar;
        this.s = str;
        this.u = dVar;
        this.v = dVar;
        this.h = new d.s.f<>();
        this.n = ByteBuffer.allocate(64);
        this.o = ByteBuffer.allocate(64);
        try {
            d.s.e.f(this.f2574c);
            this.D = d.s.e.a(socketChannel);
        } catch (IOException e2) {
            throw new k.b(e2);
        }
    }

    private void A(b bVar) {
        if (this.r.u) {
            this.v.a(new d.e());
        }
        this.C.Z0(this.s, this.f2574c);
        this.q.M0();
        this.q.L0(bVar);
        N();
        z();
    }

    /* JADX WARN: Removed duplicated region for block: B:63:0x01c1  */
    /* JADX WARN: Removed duplicated region for block: B:66:0x01ce  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private boolean B() {
        /*
            Method dump skipped, instructions count: 708
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: d.n.g.B():boolean");
    }

    /* JADX INFO: Access modifiers changed from: private */
    public d.e C() {
        d.e eVar = new d.e(this.r.f2550d);
        d.f fVar = this.r;
        byte b2 = fVar.f2550d;
        if (b2 > 0) {
            eVar.v(fVar.e, 0, b2);
        }
        this.u = this.J;
        return eVar;
    }

    private Object D(Class<?> cls, int i2, long j2) {
        if (cls == null) {
            return null;
        }
        try {
            return cls.getConstructor(Integer.TYPE, Long.TYPE).newInstance(Integer.valueOf(i2), Long.valueOf(j2));
        } catch (Exception e2) {
            e2.printStackTrace();
            return null;
        }
    }

    private void E() {
        if (this.r.t) {
            if (!this.q.P0(this.y.p()) && this.E.b(35)) {
                return;
            }
            this.q.M0();
        }
        this.u = this.M;
        this.v = this.L;
        this.k = new d.n.e();
        d.n.j.a aVar = this.D;
        if (aVar != null && !aVar.a().isEmpty()) {
            this.k.d("Peer-Address", this.D.a());
        }
        this.k.e(this.y.f2612d);
        this.k.e(this.y.e);
        if (this.k.b()) {
            this.k = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public d.e F() {
        int m;
        d.s.c cVar;
        if (this.y.y() == a.b.READY) {
            E();
            return this.M.b();
        }
        if (this.y.y() == a.b.ERROR) {
            cVar = this.E;
            m = 156384820;
        } else {
            e.a aVar = new e.a();
            m = this.y.m(aVar);
            if (m == 0) {
                aVar.y(2);
                return aVar.D();
            }
            cVar = this.E;
        }
        cVar.c(m);
        return null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean G(d.e eVar) {
        int q = this.y.q(eVar);
        if (q == 0) {
            if (this.y.y() == a.b.READY) {
                E();
            } else if (this.y.y() == a.b.ERROR) {
                this.E.c(156384820);
                return false;
            }
            if (this.A) {
                f();
            }
        } else {
            this.E.c(q);
        }
        return q == 0;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean H(d.e eVar) {
        if (this.r.t) {
            eVar.y(64);
            this.q.P0(eVar);
        }
        if (this.x) {
            d.e eVar2 = new d.e(1);
            eVar2.p((byte) 1);
            this.q.P0(eVar2);
        }
        this.v = this.I;
        return true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public d.e I() {
        return this.q.O0();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean J(d.e eVar) {
        return this.q.P0(eVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean K(d.e eVar) {
        d.n.e eVar2 = this.k;
        if (eVar2 != null && !eVar2.equals(eVar.h())) {
            eVar.z(this.k);
        }
        return J(eVar);
    }

    private int L(ByteBuffer byteBuffer) {
        try {
            int read = this.f2574c.read(byteBuffer);
            if (read == -1) {
                this.E.c(57);
            } else if (read == 0 && !this.f2574c.isBlocking()) {
                this.E.c(35);
                return -1;
            }
            return read;
        } catch (IOException unused) {
            this.E.c(57);
            return -1;
        }
    }

    private void M() {
        int i2;
        d.f fVar = this.r;
        if (fVar.u || (i2 = fVar.L) <= 0) {
            return;
        }
        this.f2573b.c(i2, 64);
        this.B = true;
    }

    private void N() {
        this.t = false;
        if (this.B) {
            this.f2573b.d(64);
            this.B = false;
        }
        if (!this.w) {
            this.f2573b.g(this.f2575d);
            this.f2575d = null;
        }
        this.f2573b.o();
        this.q = null;
    }

    private int O(ByteBuffer byteBuffer) {
        try {
            int write = this.f2574c.write(byteBuffer);
            if (write == 0) {
                this.E.c(35);
                return write;
            }
            return write;
        } catch (IOException unused) {
            this.E.c(57);
            return -1;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean P(d.e eVar) {
        d.s.a l = this.y.l();
        if (l != null && l.e() > 0) {
            d.e eVar2 = new d.e(l.e());
            eVar2.v(l.d(), 0, l.e());
            eVar2.y(32);
            if (!this.q.P0(eVar2)) {
                return false;
            }
        }
        e eVar3 = this.N;
        this.v = eVar3;
        return eVar3.a(eVar);
    }

    @Override // d.n.b
    public void a() {
        b bVar;
        boolean a2 = this.v.a(this.g.b());
        if (!a2) {
            if (this.E.b(35)) {
                this.q.M0();
                return;
            } else {
                A(b.PROTOCOL);
                return;
            }
        }
        while (true) {
            if (this.f > 0) {
                d.s.f<Integer> fVar = new d.s.f<>(0);
                e.a.EnumC0107a c2 = this.g.c(this.e, this.f, fVar);
                this.f -= fVar.a().intValue();
                if (c2 != e.a.EnumC0107a.MORE_DATA) {
                    if (c2 != e.a.EnumC0107a.ERROR) {
                        a2 = this.v.a(this.g.b());
                        if (!a2) {
                            break;
                        }
                    } else {
                        a2 = false;
                        break;
                    }
                } else {
                    a2 = true;
                    break;
                }
            } else {
                break;
            }
        }
        if (!a2 && this.E.b(35)) {
            this.q.M0();
            return;
        }
        if (this.w) {
            bVar = b.CONNECTION;
        } else if (a2) {
            this.z = false;
            this.f2573b.m(this.f2575d);
            this.q.M0();
            e();
            return;
        } else {
            bVar = b.PROTOCOL;
        }
        A(bVar);
    }

    @Override // d.q.a
    public void b() {
        throw new UnsupportedOperationException();
    }

    @Override // d.n.b
    public void c(d.n.d dVar, d.n.f fVar) {
        this.t = true;
        this.q = fVar;
        this.C = fVar.N0();
        d.n.c cVar = new d.n.c(dVar, this);
        this.f2573b = cVar;
        cVar.f();
        this.f2575d = this.f2573b.a(this.f2574c);
        this.w = false;
        d.f fVar2 = this.r;
        if (fVar2.u) {
            Class<? extends d.n.h.e> cls = fVar2.M;
            d.b bVar = d.b.IN_BATCH_SIZE;
            d.n.h.e eVar = (d.n.h.e) D(cls, bVar.a(), this.r.o);
            this.g = eVar;
            if (eVar == null) {
                this.g = new d.n.h.g.a(bVar.a());
            }
            Class<? extends d.n.h.f> cls2 = this.r.N;
            d.b bVar2 = d.b.OUT_BATCH_SIZE;
            d.n.h.f fVar3 = (d.n.h.f) D(cls2, bVar2.a(), this.r.o);
            this.j = fVar3;
            if (fVar3 == null) {
                this.j = new d.n.h.g.b(this.E, bVar2.a());
            }
            this.l = false;
            this.u = this.J;
            this.v = this.K;
            d.n.j.a aVar = this.D;
            if (aVar != null && !aVar.a().isEmpty()) {
                d.n.e eVar2 = new d.n.e();
                this.k = eVar2;
                eVar2.d("Peer-Address", this.D.a());
            }
            K(new d.e());
            fVar.M0();
        } else {
            M();
            this.o.put((byte) -1);
            d.s.g.f(this.o, this.r.f2550d + 1);
            this.o.put(Byte.MAX_VALUE);
            this.h.b(this.o);
            this.i = this.o.position();
            this.o.flip();
        }
        this.f2573b.m(this.f2575d);
        this.f2573b.n(this.f2575d);
        e();
    }

    @Override // d.n.b
    public void d() {
        N();
        z();
    }

    @Override // d.q.a
    public void e() {
        if (!this.l || B()) {
            if (this.z) {
                this.f2573b.g(this.f2575d);
                this.f2575d = null;
                this.w = true;
                return;
            }
            if (this.f == 0) {
                ByteBuffer d2 = this.g.d();
                this.e = d2;
                int L = L(d2);
                if (L == 0) {
                    A(b.CONNECTION);
                }
                if (L == -1) {
                    if (this.E.b(35)) {
                        return;
                    }
                    A(b.CONNECTION);
                    return;
                }
                this.e.flip();
                this.f = L;
            }
            boolean z = false;
            d.s.f<Integer> fVar = new d.s.f<>(0);
            boolean z2 = false;
            do {
                int i2 = this.f;
                if (i2 <= 0) {
                    break;
                }
                e.a.EnumC0107a c2 = this.g.c(this.e, i2, fVar);
                this.f -= fVar.a().intValue();
                if (c2 == e.a.EnumC0107a.MORE_DATA) {
                    z = true;
                    break;
                } else if (c2 == e.a.EnumC0107a.ERROR) {
                    break;
                } else {
                    z2 = this.v.a(this.g.b());
                }
            } while (z2);
            z = z2;
            if (!z) {
                if (!this.E.b(35)) {
                    A(b.PROTOCOL);
                    return;
                } else {
                    this.z = true;
                    this.f2573b.i(this.f2575d);
                }
            }
            this.q.M0();
        }
    }

    @Override // d.n.b
    public void f() {
        if (this.w) {
            return;
        }
        if (this.A) {
            this.f2573b.n(this.f2575d);
            this.A = false;
        }
        s();
    }

    @Override // d.n.b
    public void g() {
        if (this.y.z() == -1) {
            A(b.PROTOCOL);
            return;
        }
        if (this.z) {
            a();
        }
        if (this.A) {
            f();
        }
    }

    @Override // d.q.a
    public void h(int i2) {
        this.B = false;
        A(b.TIMEOUT);
    }

    @Override // d.q.a
    public void q() {
        throw new UnsupportedOperationException();
    }

    @Override // d.q.a
    public void s() {
        d.b bVar;
        d.e b2;
        if (this.i == 0) {
            if (this.j == null) {
                return;
            }
            this.h.b(null);
            this.i = this.j.b(this.h, 0);
            while (true) {
                int i2 = this.i;
                bVar = d.b.OUT_BATCH_SIZE;
                if (i2 < bVar.a() && (b2 = this.u.b()) != null) {
                    this.j.c(b2);
                    this.i += this.j.b(this.h, bVar.a() - this.i);
                }
            }
            if (this.i == 0) {
                this.A = true;
                this.f2573b.j(this.f2575d);
            }
            ByteBuffer a2 = this.h.a();
            if (this.i <= bVar.a()) {
                a2.flip();
            }
        }
        int O = O(this.h.a());
        if (O != -1) {
            int i3 = this.i - O;
            this.i = i3;
            if (this.l && i3 == 0) {
                this.f2573b.j(this.f2575d);
                return;
            }
            return;
        }
        this.f2573b.j(this.f2575d);
    }

    public String toString() {
        return String.valueOf(g.class.getSimpleName()) + this.C + "-" + this.p;
    }

    public void z() {
        SocketChannel socketChannel = this.f2574c;
        if (socketChannel != null) {
            try {
                socketChannel.close();
            } catch (IOException unused) {
            }
            this.f2574c = null;
        }
        d.n.h.f fVar = this.j;
        if (fVar != null) {
            fVar.a();
        }
        d.n.h.e eVar = this.g;
        if (eVar != null) {
            eVar.a();
        }
        d.n.i.a aVar = this.y;
        if (aVar != null) {
            aVar.j();
        }
    }
}
