package b.e.a;
/* loaded from: classes.dex */
public class g {

    /* renamed from: a  reason: collision with root package name */
    private static /* synthetic */ Throwable f1519a;

    /* renamed from: b  reason: collision with root package name */
    public static final /* synthetic */ g f1520b = null;

    static {
        try {
            a();
        } catch (Throwable th) {
            f1519a = th;
        }
    }

    private static /* synthetic */ void a() {
        f1520b = new g();
    }

    public static g b() {
        g gVar = f1520b;
        if (gVar != null) {
            return gVar;
        }
        throw new c.b.a.a.b("com.googlecode.mp4parser.RequiresParseDetailAspect", f1519a);
    }

    public void c(c.b.a.a.a aVar) {
        if (aVar.a() instanceof a) {
            if (((a) aVar.a()).h()) {
                return;
            }
            ((a) aVar.a()).j();
            return;
        }
        throw new RuntimeException("Only methods in subclasses of " + a.class.getName() + " can  be annotated with ParseDetail");
    }
}
