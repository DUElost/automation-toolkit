package c.c.a.k;

import java.util.Objects;
/* loaded from: classes.dex */
public class g extends d {

    /* renamed from: d  reason: collision with root package name */
    private Character f1806d;
    private String e;

    public g(i iVar, String str, c.c.a.g.a aVar, c.c.a.g.a aVar2, Character ch) {
        this(iVar, true, str, aVar, aVar2, ch);
    }

    public g(i iVar, boolean z, String str, c.c.a.g.a aVar, c.c.a.g.a aVar2, Character ch) {
        super(iVar, aVar, aVar2);
        Objects.requireNonNull(str, "value in a Node is required.");
        this.e = str;
        this.f1806d = ch;
    }

    @Override // c.c.a.k.d
    public e b() {
        return e.scalar;
    }

    public Character f() {
        return this.f1806d;
    }

    public String g() {
        return this.e;
    }

    public String toString() {
        return "<" + g.class.getName() + " (tag=" + d() + ", value=" + g() + ")>";
    }
}
