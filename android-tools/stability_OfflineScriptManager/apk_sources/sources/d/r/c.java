package d.r;

import d.j;
/* loaded from: classes.dex */
public class c extends j {
    private d.p.b A;
    private d.p.b B;

    public c(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.e.j = 0;
    }

    @Override // d.j
    protected void k1(d.p.b bVar, boolean z) {
        if (this.A == null) {
            this.A = bVar;
        } else {
            bVar.P0(false);
        }
    }

    @Override // d.j
    protected void m1(d.p.b bVar) {
        if (this.A == bVar) {
            d.p.b bVar2 = this.B;
            if (bVar2 == bVar) {
                bVar2.C0();
                this.B = null;
            }
            this.A = null;
        }
    }

    @Override // d.j
    protected void n1(d.p.b bVar) {
    }

    @Override // d.j
    protected boolean o1(d.e eVar) {
        d.p.b bVar = this.A;
        if (bVar == null || !bVar.Q0(eVar)) {
            this.l.c(35);
            return false;
        } else if (eVar.j()) {
            return true;
        } else {
            this.A.B0();
            return true;
        }
    }

    @Override // d.j
    protected void q1(d.p.b bVar) {
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.j, d.g
    public void y0() {
        super.y0();
    }
}
