package c.c.a.k;

import java.util.List;
import java.util.Objects;
/* loaded from: classes.dex */
public class c extends b {
    private List<f> e;

    public c(i iVar, List<f> list, Boolean bool) {
        this(iVar, true, list, null, null, bool);
    }

    public c(i iVar, boolean z, List<f> list, c.c.a.g.a aVar, c.c.a.g.a aVar2, Boolean bool) {
        super(iVar, aVar, aVar2, bool);
        Objects.requireNonNull(list, "value in a Node is required.");
        this.e = list;
    }

    @Override // c.c.a.k.d
    public e b() {
        return e.mapping;
    }

    public List<f> h() {
        return this.e;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (f fVar : h()) {
            sb.append("{ key=");
            sb.append(fVar.a());
            sb.append("; value=");
            if (fVar.b() instanceof b) {
                sb.append(System.identityHashCode(fVar.b()));
            } else {
                sb.append(fVar.toString());
            }
            sb.append(" }");
        }
        String sb2 = sb.toString();
        return "<" + c.class.getName() + " (tag=" + d() + ", values=" + sb2 + ")>";
    }
}
