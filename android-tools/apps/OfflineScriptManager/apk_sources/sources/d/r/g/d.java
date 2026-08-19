package d.r.g;
/* loaded from: classes.dex */
public class d extends g {
    public d(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        d.f fVar = this.e;
        fVar.j = 2;
        fVar.s = true;
    }

    @Override // d.r.g.g, d.j
    protected boolean o1(d.e eVar) {
        this.l.c(45);
        throw new UnsupportedOperationException();
    }

    @Override // d.j
    public boolean p1(int i, Object obj) {
        if ((i != 6 && i != 7) || obj == null) {
            this.l.c(22);
            return false;
        }
        byte[] d2 = d.f.d(i, obj);
        d.e eVar = new d.e(d2.length + 1);
        if (i == 6) {
            eVar.p((byte) 1);
        } else {
            eVar.p((byte) 0);
        }
        eVar.u(d2);
        if (super.o1(eVar)) {
            return true;
        }
        this.l.c(22);
        throw new IllegalStateException("Failed to send subscribe/unsubscribe message");
    }
}
