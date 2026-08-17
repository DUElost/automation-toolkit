package androidx.lifecycle;
/* loaded from: classes.dex */
public class q {

    /* renamed from: a  reason: collision with root package name */
    private final a f1086a;

    /* renamed from: b  reason: collision with root package name */
    private final r f1087b;

    /* loaded from: classes.dex */
    public interface a {
        <T extends p> T a(Class<T> cls);
    }

    public q(r rVar, a aVar) {
        this.f1086a = aVar;
        this.f1087b = rVar;
    }

    public <T extends p> T a(Class<T> cls) {
        String canonicalName = cls.getCanonicalName();
        if (canonicalName != null) {
            return (T) b("androidx.lifecycle.ViewModelProvider.DefaultKey:" + canonicalName, cls);
        }
        throw new IllegalArgumentException("Local and anonymous classes can not be ViewModels");
    }

    public <T extends p> T b(String str, Class<T> cls) {
        T t = (T) this.f1087b.b(str);
        if (cls.isInstance(t)) {
            return t;
        }
        T t2 = (T) this.f1086a.a(cls);
        this.f1087b.c(str, t2);
        return t2;
    }
}
