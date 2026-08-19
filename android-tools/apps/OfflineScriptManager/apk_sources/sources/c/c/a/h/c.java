package c.c.a.h;
/* loaded from: classes.dex */
public abstract class c extends j {

    /* renamed from: b  reason: collision with root package name */
    private final String f1766b;

    /* renamed from: c  reason: collision with root package name */
    private final boolean f1767c;

    /* renamed from: d  reason: collision with root package name */
    private final Boolean f1768d;

    public c(String str, String str2, boolean z, c.c.a.g.a aVar, c.c.a.g.a aVar2, Boolean bool) {
        super(str, aVar, aVar2);
        this.f1766b = str2;
        this.f1767c = z;
        this.f1768d = bool;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // c.c.a.h.j, c.c.a.h.f
    public String a() {
        return super.a() + ", tag=" + this.f1766b + ", implicit=" + this.f1767c;
    }

    public Boolean c() {
        return this.f1768d;
    }

    public boolean d() {
        return this.f1767c;
    }

    public String e() {
        return this.f1766b;
    }
}
