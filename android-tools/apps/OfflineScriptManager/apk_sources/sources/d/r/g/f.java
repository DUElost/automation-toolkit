package d.r.g;

import d.j;
import d.r.g.b;
import java.util.ArrayDeque;
import java.util.Deque;
/* loaded from: classes.dex */
public class f extends j {
    private static final b.a H = new a(null);
    private static final b.a I = new b(null);
    private final d.r.g.b A;
    private final d.r.g.a B;
    private boolean C;
    private boolean D;
    private boolean E;
    private final Deque<d.s.a> F;
    private final Deque<Integer> G;

    /* loaded from: classes.dex */
    private static final class a implements b.a {
        private a() {
        }

        /* synthetic */ a(a aVar) {
            this();
        }

        @Override // d.r.g.b.a
        public void a(d.p.b bVar, byte[] bArr, int i, f fVar) {
            fVar.t1(bVar);
        }
    }

    /* loaded from: classes.dex */
    private static final class b implements b.a {
        private b() {
        }

        /* synthetic */ b(b bVar) {
            this();
        }

        @Override // d.r.g.b.a
        public void a(d.p.b bVar, byte[] bArr, int i, f fVar) {
            fVar.u1(bArr, i);
        }
    }

    public f(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.e.j = 9;
        this.C = false;
        this.D = false;
        this.E = true;
        this.A = new d.r.g.b();
        this.B = new d.r.g.a();
        this.F = new ArrayDeque();
        this.G = new ArrayDeque();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void t1(d.p.b bVar) {
        this.B.e(bVar);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void u1(byte[] bArr, int i) {
        if (this.e.j != 1) {
            byte[] bArr2 = new byte[i + 1];
            bArr2[0] = 0;
            System.arraycopy(bArr, 0, bArr2, 1, i);
            this.F.add(d.s.a.b(bArr2));
            this.G.add(0);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j
    public void k1(d.p.b bVar, boolean z) {
        this.B.b(bVar);
        if (z) {
            this.A.c(bVar);
        }
        n1(bVar);
    }

    @Override // d.j
    protected void m1(d.p.b bVar) {
        this.A.h(bVar, I, this);
        this.B.h(bVar);
    }

    @Override // d.j
    protected void n1(d.p.b bVar) {
        while (true) {
            d.e I0 = bVar.I0();
            if (I0 == null) {
                return;
            }
            if (I0.B() <= 0 || !(I0.e(0) == 0 || I0.e(0) == 1)) {
                this.F.add(d.s.a.a(I0));
                this.G.add(Integer.valueOf(I0.d()));
            } else {
                boolean g = I0.e(0) == 0 ? this.A.g(I0, bVar) : this.A.a(I0, bVar);
                if (this.e.j == 9 && (g || (I0.e(0) > 0 && this.C))) {
                    this.F.add(d.s.a.a(I0));
                    this.G.add(0);
                }
            }
        }
    }

    @Override // d.j
    protected boolean o1(d.e eVar) {
        boolean j = eVar.j();
        if (!this.D) {
            this.A.e(eVar.a(), eVar.B(), H, this);
        }
        if (!this.E && !this.B.c()) {
            this.l.c(35);
            return false;
        } else if (this.B.g(eVar)) {
            if (!j) {
                this.B.i();
            }
            this.D = j;
            return true;
        } else {
            return false;
        }
    }

    @Override // d.j
    public boolean p1(int i, Object obj) {
        if (i == 40) {
            this.C = d.f.c(i, obj);
        } else if (i != 69) {
            this.l.c(22);
            return false;
        } else {
            this.E = !d.f.c(i, obj);
        }
        return true;
    }

    @Override // d.j
    protected void q1(d.p.b bVar) {
        this.B.a(bVar);
    }
}
