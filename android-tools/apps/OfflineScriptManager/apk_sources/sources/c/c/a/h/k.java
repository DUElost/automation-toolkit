package c.c.a.h;
/* loaded from: classes.dex */
public final class k extends j {

    /* renamed from: b  reason: collision with root package name */
    private final String f1776b;

    /* renamed from: c  reason: collision with root package name */
    private final Character f1777c;

    /* renamed from: d  reason: collision with root package name */
    private final String f1778d;
    private final g e;

    public k(String str, String str2, g gVar, String str3, c.c.a.g.a aVar, c.c.a.g.a aVar2, Character ch) {
        super(str, aVar, aVar2);
        this.f1776b = str2;
        this.e = gVar;
        this.f1778d = str3;
        this.f1777c = ch;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // c.c.a.h.j, c.c.a.h.f
    public String a() {
        return super.a() + ", tag=" + this.f1776b + ", " + this.e + ", value=" + this.f1778d;
    }

    public g c() {
        return this.e;
    }

    public Character d() {
        return this.f1777c;
    }

    public String e() {
        return this.f1776b;
    }

    public String f() {
        return this.f1778d;
    }
}
