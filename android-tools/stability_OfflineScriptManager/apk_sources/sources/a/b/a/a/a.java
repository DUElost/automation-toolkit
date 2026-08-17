package a.b.a.a;
/* loaded from: classes.dex */
public class a extends c {

    /* renamed from: c  reason: collision with root package name */
    private static volatile a f55c;

    /* renamed from: a  reason: collision with root package name */
    private c f56a;

    /* renamed from: b  reason: collision with root package name */
    private c f57b;

    private a() {
        b bVar = new b();
        this.f57b = bVar;
        this.f56a = bVar;
    }

    public static a b() {
        if (f55c != null) {
            return f55c;
        }
        synchronized (a.class) {
            if (f55c == null) {
                f55c = new a();
            }
        }
        return f55c;
    }

    @Override // a.b.a.a.c
    public boolean a() {
        return this.f56a.a();
    }
}
