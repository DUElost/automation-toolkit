package c.c.a.j;
/* loaded from: classes.dex */
public abstract class e implements Comparable<e> {

    /* renamed from: b  reason: collision with root package name */
    private final String f1789b;

    /* renamed from: c  reason: collision with root package name */
    private final Class<?> f1790c;

    public e(String str, Class<?> cls) {
        this.f1789b = str;
        this.f1790c = cls;
    }

    @Override // java.lang.Comparable
    /* renamed from: a */
    public int compareTo(e eVar) {
        return this.f1789b.compareTo(eVar.f1789b);
    }

    public abstract Object b(Object obj);

    public abstract Class<?>[] c();

    public String d() {
        return this.f1789b;
    }

    public Class<?> e() {
        return this.f1790c;
    }

    public boolean f() {
        return true;
    }

    public boolean g() {
        return true;
    }

    public String toString() {
        return d() + " of " + e();
    }
}
