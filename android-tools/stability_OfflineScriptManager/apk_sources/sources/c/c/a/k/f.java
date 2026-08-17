package c.c.a.k;
/* loaded from: classes.dex */
public final class f {

    /* renamed from: a  reason: collision with root package name */
    private final d f1804a;

    /* renamed from: b  reason: collision with root package name */
    private final d f1805b;

    public f(d dVar, d dVar2) {
        if (dVar == null || dVar2 == null) {
            throw new NullPointerException("Nodes must be provided.");
        }
        this.f1804a = dVar;
        this.f1805b = dVar2;
    }

    public final d a() {
        return this.f1804a;
    }

    public final d b() {
        return this.f1805b;
    }

    public String toString() {
        return "<NodeTuple keyNode=" + this.f1804a.toString() + "; valueNode=" + this.f1805b.toString() + ">";
    }
}
