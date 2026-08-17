package c.c.a.h;
/* loaded from: classes.dex */
public abstract class j extends f {

    /* renamed from: a  reason: collision with root package name */
    private final String f1775a;

    public j(String str, c.c.a.g.a aVar, c.c.a.g.a aVar2) {
        super(aVar, aVar2);
        this.f1775a = str;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // c.c.a.h.f
    public String a() {
        return "anchor=" + this.f1775a;
    }

    public String b() {
        return this.f1775a;
    }
}
