package d.r.h;

import d.f;
import d.j;
import d.l;
import d.s.e;
import d.s.g;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
/* loaded from: classes.dex */
public class d extends j {
    private final d.r.a A;
    private final Set<d.p.b> B;
    private final Map<d.s.a, a> C;
    private d.p.b D;
    private boolean E;
    private int F;
    private boolean G;
    private boolean H;
    private boolean I;
    private boolean J;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a {

        /* renamed from: a  reason: collision with root package name */
        private d.p.b f2719a;

        /* renamed from: b  reason: collision with root package name */
        private boolean f2720b;

        public a(d dVar, d.p.b bVar, boolean z) {
            this.f2719a = bVar;
            this.f2720b = z;
        }
    }

    public d(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.D = null;
        this.E = false;
        this.F = e.c();
        this.G = false;
        this.H = false;
        this.J = false;
        f fVar = this.e;
        fVar.j = 6;
        fVar.t = true;
        fVar.u = false;
        this.A = new d.r.a();
        new d.e();
        new d.e();
        this.B = new HashSet();
        this.C = new HashMap();
    }

    private boolean r1(d.p.b bVar) {
        d.s.a a2;
        String str = this.y;
        if (str != null && !str.isEmpty()) {
            a2 = d.s.a.b(this.y.getBytes(l.f2560c));
            this.y = null;
            this.C.get(a2);
        } else if (this.e.u) {
            ByteBuffer allocate = ByteBuffer.allocate(5);
            allocate.put((byte) 0);
            int i = this.F;
            this.F = i + 1;
            g.d(allocate, i);
            a2 = d.s.a.b(allocate.array());
        } else {
            d.e I0 = bVar.I0();
            if (I0 == null) {
                return false;
            }
            if (I0.B() == 0) {
                ByteBuffer allocate2 = ByteBuffer.allocate(5);
                allocate2.put((byte) 0);
                int i2 = this.F;
                this.F = i2 + 1;
                g.d(allocate2, i2);
                a2 = d.s.a.b(allocate2.array());
            } else {
                a2 = d.s.a.a(I0);
                if (this.C.containsKey(a2)) {
                    if (!this.J) {
                        return false;
                    }
                    ByteBuffer allocate3 = ByteBuffer.allocate(5);
                    allocate3.put((byte) 0);
                    int i3 = this.F;
                    this.F = i3 + 1;
                    g.d(allocate3, i3);
                    d.s.a b2 = d.s.a.b(allocate3.array());
                    a remove = this.C.remove(a2);
                    remove.f2719a.M0(b2);
                    this.C.put(b2, remove);
                    remove.f2719a.P0(true);
                }
            }
        }
        bVar.M0(a2);
        this.C.put(a2, new a(this, bVar, true));
        return true;
    }

    @Override // d.j
    public void k1(d.p.b bVar, boolean z) {
        if (this.I) {
            bVar.Q0(new d.e());
            bVar.B0();
        }
        if (r1(bVar)) {
            this.A.b(bVar);
        } else {
            this.B.add(bVar);
        }
    }

    @Override // d.j
    public void m1(d.p.b bVar) {
        if (this.B.remove(bVar)) {
            return;
        }
        this.C.remove(bVar.D0());
        this.A.d(bVar);
        if (bVar == this.D) {
            this.D = null;
        }
    }

    @Override // d.j
    public void n1(d.p.b bVar) {
        if (!this.B.contains(bVar)) {
            this.A.a(bVar);
        } else if (r1(bVar)) {
            this.B.remove(bVar);
            this.A.b(bVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j
    public boolean o1(d.e eVar) {
        d.s.c cVar;
        int i;
        if (this.E) {
            if (this.e.u) {
                eVar.w(1);
            }
            this.E = eVar.j();
            if (this.D != null) {
                if (this.H && eVar.B() == 0) {
                    this.D.P0(false);
                    this.D = null;
                    return true;
                }
                if (this.D.Q0(eVar)) {
                    if (!this.E) {
                        this.D.B0();
                    }
                }
                this.D = null;
            }
            return true;
        }
        if (eVar.j()) {
            this.E = true;
            a aVar = this.C.get(d.s.a.a(eVar));
            if (aVar != null) {
                d.p.b bVar = aVar.f2719a;
                this.D = bVar;
                if (!bVar.z0()) {
                    aVar.f2720b = false;
                    this.D = null;
                    if (this.G) {
                        this.E = false;
                        cVar = this.l;
                        i = 35;
                        cVar.c(i);
                        return false;
                    }
                }
            } else if (this.G) {
                this.E = false;
                cVar = this.l;
                i = 65;
                cVar.c(i);
                return false;
            }
        }
        return true;
    }

    @Override // d.j
    public boolean p1(int i, Object obj) {
        if (i == 61) {
            this.y = f.e(i, obj);
            return true;
        } else if (i == 41) {
            boolean c2 = f.c(i, obj);
            this.H = c2;
            if (c2) {
                f fVar = this.e;
                fVar.t = false;
                fVar.u = true;
            }
            return true;
        } else if (i == 33) {
            this.G = f.c(i, obj);
            return true;
        } else if (i == 51) {
            this.I = f.c(i, obj);
            return true;
        } else if (i == 56) {
            this.J = f.c(i, obj);
            return true;
        } else {
            this.l.c(22);
            return false;
        }
    }

    @Override // d.j
    public void q1(d.p.b bVar) {
        for (a aVar : this.C.values()) {
            if (aVar.f2719a == bVar) {
                aVar.f2720b = true;
                return;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j, d.g
    public void y0() {
        super.y0();
    }
}
