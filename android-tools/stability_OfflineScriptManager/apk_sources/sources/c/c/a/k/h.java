package c.c.a.k;

import java.util.List;
import java.util.Objects;
/* loaded from: classes.dex */
public class h extends b {
    private final List<d> e;

    public h(i iVar, List<d> list, Boolean bool) {
        this(iVar, true, list, null, null, bool);
    }

    public h(i iVar, boolean z, List<d> list, c.c.a.g.a aVar, c.c.a.g.a aVar2, Boolean bool) {
        super(iVar, aVar, aVar2, bool);
        Objects.requireNonNull(list, "value in a Node is required.");
        this.e = list;
    }

    @Override // c.c.a.k.d
    public e b() {
        return e.sequence;
    }

    public List<d> h() {
        return this.e;
    }

    public String toString() {
        return "<" + h.class.getName() + " (tag=" + d() + ", value=" + h() + ")>";
    }
}
