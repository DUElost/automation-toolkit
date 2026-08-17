package b.e.a.j;
/* loaded from: classes.dex */
public abstract class f {
    public static f a(Class cls) {
        return System.getProperty("java.vm.name").equalsIgnoreCase("Dalvik") ? new a(cls.getSimpleName()) : new d(cls.getSimpleName());
    }

    public abstract void b(String str);

    public abstract void c(String str);

    public abstract void d(String str);
}
