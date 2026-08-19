package b.b.a.a.b;
/* loaded from: classes.dex */
public class a implements b {

    /* renamed from: a  reason: collision with root package name */
    private String f1344a;

    /* renamed from: b  reason: collision with root package name */
    private String f1345b;

    /* renamed from: c  reason: collision with root package name */
    private h f1346c;

    /* renamed from: d  reason: collision with root package name */
    private c f1347d = null;

    public a(String str, String str2) {
        this.f1344a = str;
        this.f1345b = str2;
    }

    public static String e() {
        return "adb";
    }

    @Override // b.b.a.a.b.b
    public void a(h hVar) {
        this.f1346c = hVar;
        f fVar = new f();
        this.f1347d = fVar;
        fVar.i(this.f1344a);
        this.f1347d.h(this.f1345b);
        this.f1347d.g(g.NOTEXECUTED);
        this.f1347d.l(e());
        this.f1346c.b(this.f1347d);
    }

    @Override // b.b.a.a.b.b
    public void b() {
        long m = com.ape.offlinescriptmanager.utils.g.m();
        this.f1347d.m(m);
        this.f1347d.n(m);
        com.ape.offlinescriptmanager.utils.b.i("start time %s %s", com.ape.offlinescriptmanager.utils.g.y(m), this.f1344a);
    }

    @Override // b.b.a.a.b.b
    public void c() {
        long m = com.ape.offlinescriptmanager.utils.g.m();
        this.f1347d.n(m);
        if (this.f1347d.o() == g.NOTEXECUTED) {
            this.f1347d.g(g.PASS);
            com.ape.offlinescriptmanager.utils.b.i("%s pass", this.f1344a);
        }
        com.ape.offlinescriptmanager.utils.b.i("end time %s", com.ape.offlinescriptmanager.utils.g.y(m));
    }

    @Override // b.b.a.a.b.b
    public void d(String str) {
        c cVar = this.f1347d;
        g gVar = g.FAILURE;
        cVar.g(gVar);
        this.f1346c.o(gVar);
        this.f1347d.k(com.ape.offlinescriptmanager.utils.g.c(str));
        com.ape.offlinescriptmanager.utils.b.i("%s fail", this.f1344a);
    }
}
