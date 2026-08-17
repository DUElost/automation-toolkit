package d.p;

import d.e;
/* loaded from: classes.dex */
public class e<T extends d.e> implements d<T> {

    /* renamed from: a  reason: collision with root package name */
    private boolean f2670a;

    /* renamed from: b  reason: collision with root package name */
    private final a<T> f2671b = new a<>();

    @Override // d.p.d
    public boolean c() {
        boolean a2 = this.f2671b.a();
        if (!a2) {
            this.f2670a = false;
        }
        return a2;
    }

    @Override // d.p.d
    /* renamed from: f */
    public T a() {
        return this.f2671b.b();
    }

    @Override // d.p.d
    public boolean flush() {
        return this.f2670a;
    }

    @Override // d.p.d
    /* renamed from: g */
    public T d() {
        if (c()) {
            return this.f2671b.c();
        }
        return null;
    }

    @Override // d.p.d
    /* renamed from: h */
    public T e() {
        return null;
    }

    @Override // d.p.d
    /* renamed from: i */
    public void b(T t, boolean z) {
        this.f2671b.d(t);
    }
}
