package d.r.h;

import d.e;
/* loaded from: classes.dex */
public class b extends d {
    private boolean K;

    public b(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.K = false;
        this.e.j = 4;
    }

    @Override // d.r.h.d, d.j
    protected boolean o1(e eVar) {
        if (!this.K) {
            this.l.c(156384763);
            return false;
        }
        boolean j = eVar.j();
        if (super.o1(eVar)) {
            if (j) {
                return true;
            }
            this.K = false;
            return true;
        }
        return false;
    }
}
