package b.c.a.i.j0;

import b.c.a.d;
import b.c.a.i.b;
import b.c.a.i.e;
import b.c.a.i.f0;
import b.e.a.h.f;
import java.util.AbstractList;
import java.util.List;
/* loaded from: classes.dex */
public class a extends AbstractList<f> {

    /* renamed from: b  reason: collision with root package name */
    List<f> f1457b;

    public a(f0 f0Var, d... dVarArr) {
        e parent = ((b) f0Var.getParent()).getParent();
        if (!f0Var.getParent().q(b.c.a.i.i0.a.class).isEmpty()) {
            this.f1457b = new b.e.a.h.k.b(f0Var.I().A(), parent, dVarArr);
        } else if (dVarArr.length > 0) {
            throw new RuntimeException("The TrackBox comes from a standard MP4 file. Only use the additionalFragments param if you are dealing with ( fragmented MP4 files AND additional fragments in standalone files )");
        } else {
            this.f1457b = new b.e.a.h.k.a(f0Var.I().A(), parent);
        }
    }

    @Override // java.util.AbstractList, java.util.List
    /* renamed from: a */
    public f get(int i) {
        return this.f1457b.get(i);
    }

    @Override // java.util.AbstractCollection, java.util.Collection, java.util.List
    public int size() {
        return this.f1457b.size();
    }
}
