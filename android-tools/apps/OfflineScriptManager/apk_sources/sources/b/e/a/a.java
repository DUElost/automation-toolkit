package b.e.a;

import java.nio.Buffer;
import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
/* loaded from: classes.dex */
public abstract class a implements b.c.a.i.b {
    private static b.e.a.j.f h = b.e.a.j.f.a(a.class);

    /* renamed from: b  reason: collision with root package name */
    protected String f1511b;

    /* renamed from: c  reason: collision with root package name */
    private byte[] f1512c;

    /* renamed from: d  reason: collision with root package name */
    private b.c.a.i.e f1513d;
    private ByteBuffer f;
    private ByteBuffer g = null;
    boolean e = true;

    /* JADX INFO: Access modifiers changed from: protected */
    public a(String str) {
        this.f1511b = str;
    }

    private void f(ByteBuffer byteBuffer) {
        if (i()) {
            b.c.a.f.g(byteBuffer, a());
            byteBuffer.put(b.c.a.d.F(getType()));
        } else {
            b.c.a.f.g(byteBuffer, 1L);
            byteBuffer.put(b.c.a.d.F(getType()));
            b.c.a.f.i(byteBuffer, a());
        }
        if ("uuid".equals(getType())) {
            byteBuffer.put(g());
        }
    }

    private boolean i() {
        int i = "uuid".equals(getType()) ? 24 : 8;
        if (!this.e) {
            return ((long) (this.f.limit() + i)) < 4294967296L;
        }
        long e = e();
        ByteBuffer byteBuffer = this.g;
        return (e + ((long) (byteBuffer != null ? byteBuffer.limit() : 0))) + ((long) i) < 4294967296L;
    }

    @Override // b.c.a.i.b
    public long a() {
        long limit;
        ByteBuffer byteBuffer;
        if (this.e) {
            limit = e();
        } else {
            ByteBuffer byteBuffer2 = this.f;
            limit = byteBuffer2 != null ? byteBuffer2.limit() : 0;
        }
        return limit + (limit >= 4294967288L ? 8 : 0) + 8 + ("uuid".equals(getType()) ? 16 : 0) + (this.g != null ? byteBuffer.limit() : 0);
    }

    @Override // b.c.a.i.b
    public void b(e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
        eVar.l();
        byteBuffer.remaining();
        this.f = ByteBuffer.allocate(b.e.a.j.b.a(j));
        while (this.f.remaining() > 0) {
            eVar.y(this.f);
        }
        this.f.position(0);
        this.e = false;
    }

    protected abstract void c(ByteBuffer byteBuffer);

    protected abstract void d(ByteBuffer byteBuffer);

    protected abstract long e();

    public byte[] g() {
        return this.f1512c;
    }

    @Override // b.c.a.i.b
    public b.c.a.i.e getParent() {
        return this.f1513d;
    }

    @Override // b.c.a.i.b
    public String getType() {
        return this.f1511b;
    }

    public boolean h() {
        return this.e;
    }

    public final synchronized void j() {
        b.e.a.j.f fVar = h;
        fVar.b("parsing details of " + getType());
        ByteBuffer byteBuffer = this.f;
        if (byteBuffer != null) {
            this.e = true;
            byteBuffer.rewind();
            c(byteBuffer);
            if (byteBuffer.remaining() > 0) {
                this.g = byteBuffer.slice();
            }
            this.f = null;
        }
    }

    @Override // b.c.a.i.b
    public void m(b.c.a.i.e eVar) {
        this.f1513d = eVar;
    }

    @Override // b.c.a.i.b
    public void t(WritableByteChannel writableByteChannel) {
        Buffer position;
        if (this.e) {
            ByteBuffer allocate = ByteBuffer.allocate(b.e.a.j.b.a(a()));
            f(allocate);
            d(allocate);
            ByteBuffer byteBuffer = this.g;
            if (byteBuffer != null) {
                byteBuffer.rewind();
                while (this.g.remaining() > 0) {
                    allocate.put(this.g);
                }
            }
            position = allocate.rewind();
        } else {
            ByteBuffer allocate2 = ByteBuffer.allocate((i() ? 8 : 16) + ("uuid".equals(getType()) ? 16 : 0));
            f(allocate2);
            writableByteChannel.write((ByteBuffer) allocate2.rewind());
            position = this.f.position(0);
        }
        writableByteChannel.write((ByteBuffer) position);
    }
}
