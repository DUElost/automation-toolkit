package d.n.h.g;

import d.n.h.e;
import d.s.f;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class a implements e {

    /* renamed from: a  reason: collision with root package name */
    private final ByteBuffer f2607a;

    /* renamed from: b  reason: collision with root package name */
    protected d.e f2608b = new d.e();

    public a(int i) {
        this.f2607a = ByteBuffer.allocateDirect(i);
    }

    @Override // d.n.h.e
    public void a() {
    }

    @Override // d.n.h.e
    public d.e b() {
        return this.f2608b;
    }

    @Override // d.n.h.e
    public e.a.EnumC0107a c(ByteBuffer byteBuffer, int i, f<Integer> fVar) {
        fVar.b(Integer.valueOf(i));
        d.e eVar = new d.e(i);
        this.f2608b = eVar;
        eVar.s(byteBuffer);
        return e.a.EnumC0107a.DECODED;
    }

    @Override // d.n.h.e
    public ByteBuffer d() {
        this.f2607a.clear();
        return this.f2607a;
    }
}
