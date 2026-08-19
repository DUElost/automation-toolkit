package b.c.a.i;

import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
/* loaded from: classes.dex */
public class h extends b.e.a.b implements b {
    private int m;
    private int n;

    public h() {
        super("dref");
    }

    @Override // b.e.a.b, b.c.a.i.b
    public long a() {
        long B = B() + 8;
        return B + ((this.l || 8 + B >= 4294967296L) ? 16 : 8);
    }

    @Override // b.e.a.b, b.c.a.i.b
    public void b(b.e.a.e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
        ByteBuffer allocate = ByteBuffer.allocate(8);
        eVar.y(allocate);
        allocate.rewind();
        this.m = b.c.a.e.n(allocate);
        this.n = b.c.a.e.j(allocate);
        C(eVar, j - 8, bVar);
    }

    @Override // b.e.a.b, b.c.a.i.b
    public void t(WritableByteChannel writableByteChannel) {
        writableByteChannel.write(F());
        ByteBuffer allocate = ByteBuffer.allocate(8);
        b.c.a.f.j(allocate, this.m);
        b.c.a.f.f(allocate, this.n);
        b.c.a.f.g(allocate, e().size());
        writableByteChannel.write((ByteBuffer) allocate.rewind());
        h(writableByteChannel);
    }
}
