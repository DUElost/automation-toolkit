package c.c.a.k;

import java.util.Objects;
/* loaded from: classes.dex */
public abstract class d {

    /* renamed from: a  reason: collision with root package name */
    private i f1798a;

    /* renamed from: b  reason: collision with root package name */
    private c.c.a.g.a f1799b;

    /* renamed from: c  reason: collision with root package name */
    protected c.c.a.g.a f1800c;

    public d(i iVar, c.c.a.g.a aVar, c.c.a.g.a aVar2) {
        e(iVar);
    }

    public c.c.a.g.a a() {
        return this.f1800c;
    }

    public abstract e b();

    public c.c.a.g.a c() {
        return this.f1799b;
    }

    public i d() {
        return this.f1798a;
    }

    public void e(i iVar) {
        Objects.requireNonNull(iVar, "tag in a Node is required.");
        this.f1798a = iVar;
    }

    public final boolean equals(Object obj) {
        return super.equals(obj);
    }

    public final int hashCode() {
        return super.hashCode();
    }
}
