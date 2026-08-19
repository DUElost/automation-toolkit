package a.f.k;
/* loaded from: classes.dex */
public class f<T> extends e<T> {

    /* renamed from: c  reason: collision with root package name */
    private final Object f170c;

    public f(int i) {
        super(i);
        this.f170c = new Object();
    }

    @Override // a.f.k.e, a.f.k.d
    public boolean a(T t) {
        boolean a2;
        synchronized (this.f170c) {
            a2 = super.a(t);
        }
        return a2;
    }

    @Override // a.f.k.e, a.f.k.d
    public T b() {
        T t;
        synchronized (this.f170c) {
            t = (T) super.b();
        }
        return t;
    }
}
