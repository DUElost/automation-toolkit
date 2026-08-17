package d.n.h;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public abstract class d implements f {

    /* renamed from: a  reason: collision with root package name */
    private ByteBuffer f2600a;

    /* renamed from: b  reason: collision with root package name */
    private Runnable f2601b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f2602c;

    /* renamed from: d  reason: collision with root package name */
    private int f2603d;
    private final ByteBuffer e;
    private final int f;
    protected d.e g;

    /* JADX INFO: Access modifiers changed from: protected */
    public d(d.s.c cVar, int i) {
        this.f = i;
        this.e = ByteBuffer.allocateDirect(i);
    }

    private void g(byte[] bArr, int i, Runnable runnable, boolean z) {
        if (bArr != null) {
            ByteBuffer wrap = ByteBuffer.wrap(bArr);
            this.f2600a = wrap;
            wrap.limit(i);
        } else {
            this.f2600a = null;
        }
        this.f2603d = i;
        this.f2601b = runnable;
        this.f2602c = z;
    }

    @Override // d.n.h.f
    public void a() {
    }

    @Override // d.n.h.f
    public final int b(d.s.f<ByteBuffer> fVar, int i) {
        ByteBuffer a2 = fVar.a();
        if (a2 == null) {
            a2 = this.e;
            i = this.f;
            a2.clear();
        }
        if (this.g == null) {
            return 0;
        }
        a2.limit(a2.capacity());
        int i2 = 0;
        while (true) {
            if (i2 >= i) {
                break;
            }
            if (this.f2603d == 0) {
                if (this.f2602c) {
                    this.g = null;
                    break;
                }
                e();
            }
            if (i2 == 0 && fVar.a() == null && this.f2603d >= i) {
                ByteBuffer byteBuffer = this.f2600a;
                byteBuffer.limit(byteBuffer.capacity());
                fVar.b(this.f2600a);
                int i3 = this.f2603d;
                this.f2600a = null;
                this.f2603d = 0;
                return i3;
            }
            int min = Math.min(this.f2603d, i - i2);
            int limit = this.f2600a.limit();
            ByteBuffer byteBuffer2 = this.f2600a;
            byteBuffer2.limit(Math.min(byteBuffer2.capacity(), this.f2600a.position() + min));
            int position = a2.position();
            a2.put(this.f2600a);
            int position2 = a2.position() - position;
            this.f2600a.limit(limit);
            i2 += position2;
            this.f2603d -= position2;
        }
        fVar.b(a2);
        return i2;
    }

    @Override // d.n.h.f
    public final void c(d.e eVar) {
        this.g = eVar;
        e();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void d(Runnable runnable, boolean z) {
        g(null, 0, runnable, z);
    }

    protected void e() {
        Runnable runnable = this.f2601b;
        if (runnable != null) {
            runnable.run();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void f(ByteBuffer byteBuffer, int i, Runnable runnable, boolean z) {
        byteBuffer.limit(i);
        byteBuffer.position(i);
        byteBuffer.flip();
        this.f2600a = byteBuffer;
        this.f2603d = i;
        this.f2601b = runnable;
        this.f2602c = z;
    }
}
