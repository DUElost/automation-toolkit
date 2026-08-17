package d.n.i;

import d.e;
import d.n.f;
import d.n.i.a;
/* loaded from: classes.dex */
class c extends a {
    private boolean i;
    private boolean j;
    private boolean k;
    private boolean l;
    private boolean m;
    private boolean n;
    private boolean o;

    /* JADX INFO: Access modifiers changed from: package-private */
    public c(f fVar, d.n.j.a aVar, d.f fVar2) {
        super(fVar, aVar, fVar2);
        String str = fVar2.D;
        if (str == null || str.length() <= 0 || fVar.V0() != 0) {
            return;
        }
        this.m = true;
    }

    private int A(e eVar) {
        if (eVar.B() >= 7 && eVar.e(6) <= eVar.B() - 7) {
            this.l = true;
            return 0;
        }
        return 156384820;
    }

    private int B(e eVar) {
        this.k = true;
        return o(eVar, 6, false);
    }

    @Override // d.n.i.a
    public int m(e eVar) {
        if (this.i || this.j) {
            return 35;
        }
        if (this.m && !this.o) {
            if (this.n) {
                return 35;
            }
            u(b.NULL, false);
            this.n = true;
            int t = t();
            if (t != 0) {
                return t;
            }
            this.o = true;
        }
        if (this.o && !"200".equals(this.h)) {
            f(eVar, "ERROR");
            f(eVar, this.h);
            this.j = true;
            return 0;
        }
        f(eVar, "READY");
        d(eVar, "Socket-Type", x(this.f2609a.j));
        d.f fVar = this.f2609a;
        int i = fVar.j;
        if (i == 3 || i == 5 || i == 6) {
            e(eVar, "Identity", fVar.e);
        }
        this.i = true;
        return 0;
    }

    @Override // d.n.i.a
    public int q(e eVar) {
        String str;
        if (this.k || this.l) {
            str = "NULL I: client sent invalid NULL handshake (duplicate READY)";
        } else {
            int B = eVar.B();
            if (B >= 6 && h(eVar, "READY", true)) {
                return B(eVar);
            }
            if (B >= 6 && h(eVar, "ERROR", true)) {
                return A(eVar);
            }
            str = "NULL I: client sent invalid NULL handshake (not READY) ";
        }
        s(str);
        return 156384820;
    }

    @Override // d.n.i.a
    public a.b y() {
        boolean z = this.i;
        boolean z2 = false;
        boolean z3 = z || this.j;
        boolean z4 = this.k;
        if (z4 || this.l) {
            z2 = true;
        }
        return (z && z4) ? a.b.READY : (z3 && z2) ? a.b.ERROR : a.b.HANDSHAKING;
    }

    @Override // d.n.i.a
    public int z() {
        if (this.o) {
            return 156384763;
        }
        int t = t();
        if (t == 0) {
            this.o = true;
        }
        return t;
    }
}
