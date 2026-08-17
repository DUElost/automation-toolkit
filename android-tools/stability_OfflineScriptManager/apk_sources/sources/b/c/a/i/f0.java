package b.c.a.i;
/* loaded from: classes.dex */
public class f0 extends b.e.a.b {
    private w m;

    public f0() {
        super("trak");
    }

    public n G() {
        for (b bVar : e()) {
            if (bVar instanceof n) {
                return (n) bVar;
            }
        }
        return null;
    }

    public w H() {
        p I;
        w wVar = this.m;
        if (wVar != null) {
            return wVar;
        }
        n G = G();
        if (G == null || (I = G.I()) == null) {
            return null;
        }
        w G2 = I.G();
        this.m = G2;
        return G2;
    }

    public g0 I() {
        for (b bVar : e()) {
            if (bVar instanceof g0) {
                return (g0) bVar;
            }
        }
        return null;
    }
}
