package d.n.h;

import d.n.h.e;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public abstract class b implements e {

    /* renamed from: b  reason: collision with root package name */
    private boolean f2595b;

    /* renamed from: d  reason: collision with root package name */
    private int f2597d;
    private ByteBuffer e;
    private final d.s.c g;
    private e.a f = null;

    /* renamed from: a  reason: collision with root package name */
    private ByteBuffer f2594a = null;

    /* renamed from: c  reason: collision with root package name */
    private int f2596c = 0;

    public b(d.s.c cVar, int i) {
        this.f2597d = i;
        this.e = ByteBuffer.allocateDirect(i);
        this.g = cVar;
    }

    @Override // d.n.h.e
    public void a() {
    }

    @Override // d.n.h.e
    public e.a.EnumC0107a c(ByteBuffer byteBuffer, int i, d.s.f<Integer> fVar) {
        fVar.b(0);
        if (this.f2595b) {
            ByteBuffer byteBuffer2 = this.f2594a;
            byteBuffer2.position(byteBuffer2.position() + i);
            this.f2596c -= i;
            fVar.b(Integer.valueOf(i));
            while (this.f2594a.remaining() == 0) {
                e.a.EnumC0107a a2 = this.f.a();
                if (a2 != e.a.EnumC0107a.MORE_DATA) {
                    return a2;
                }
            }
            return e.a.EnumC0107a.MORE_DATA;
        }
        while (fVar.a().intValue() < i) {
            int min = Math.min(this.f2596c, i - fVar.a().intValue());
            int limit = byteBuffer.limit();
            byteBuffer.limit(byteBuffer.position() + min);
            this.f2594a.put(byteBuffer);
            byteBuffer.limit(limit);
            this.f2596c -= min;
            fVar.b(Integer.valueOf(fVar.a().intValue() + min));
            while (this.f2594a.remaining() == 0) {
                e.a.EnumC0107a a3 = this.f.a();
                if (a3 != e.a.EnumC0107a.MORE_DATA) {
                    return a3;
                }
            }
        }
        return e.a.EnumC0107a.MORE_DATA;
    }

    @Override // d.n.h.e
    public ByteBuffer d() {
        if (this.f2596c >= this.f2597d) {
            this.f2595b = true;
            return this.f2594a.duplicate();
        }
        this.f2595b = false;
        this.e.clear();
        return this.e;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void e(int i) {
        this.g.c(i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void f(ByteBuffer byteBuffer, e.a aVar) {
        this.f2594a = byteBuffer;
        this.f2596c = byteBuffer.remaining();
        this.f = aVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void g(d.e eVar, e.a aVar) {
        f(eVar.a(), aVar);
    }
}
