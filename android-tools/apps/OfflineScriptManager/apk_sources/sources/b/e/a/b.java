package b.e.a;

import java.nio.ByteBuffer;
import java.nio.channels.WritableByteChannel;
/* loaded from: classes.dex */
public class b extends d implements b.c.a.i.b {
    b.c.a.i.e j;
    protected String k;
    protected boolean l;

    public b(String str) {
        this.k = str;
    }

    @Override // b.e.a.d
    public void C(e eVar, long j, b.c.a.b bVar) {
        this.f1515c = eVar;
        long l = eVar.l();
        this.e = l;
        this.f = l - ((this.l || 8 + j >= 4294967296L) ? 16 : 8);
        eVar.u(eVar.l() + j);
        this.g = eVar.l();
        this.f1514b = bVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public ByteBuffer F() {
        ByteBuffer wrap;
        if (this.l || a() >= 4294967296L) {
            byte[] bArr = new byte[16];
            bArr[3] = 1;
            bArr[4] = this.k.getBytes()[0];
            bArr[5] = this.k.getBytes()[1];
            bArr[6] = this.k.getBytes()[2];
            bArr[7] = this.k.getBytes()[3];
            wrap = ByteBuffer.wrap(bArr);
            wrap.position(8);
            b.c.a.f.i(wrap, a());
        } else {
            wrap = ByteBuffer.wrap(new byte[]{0, 0, 0, 0, this.k.getBytes()[0], this.k.getBytes()[1], this.k.getBytes()[2], this.k.getBytes()[3]});
            b.c.a.f.g(wrap, a());
        }
        wrap.rewind();
        return wrap;
    }

    public long a() {
        long B = B();
        return B + ((this.l || 8 + B >= 4294967296L) ? 16 : 8);
    }

    public void b(e eVar, ByteBuffer byteBuffer, long j, b.c.a.b bVar) {
        eVar.l();
        byteBuffer.remaining();
        this.l = byteBuffer.remaining() == 16;
        C(eVar, j, bVar);
    }

    @Override // b.c.a.i.b
    public b.c.a.i.e getParent() {
        return this.j;
    }

    @Override // b.c.a.i.b
    public String getType() {
        return this.k;
    }

    @Override // b.c.a.i.b
    public void m(b.c.a.i.e eVar) {
        this.j = eVar;
    }

    public void t(WritableByteChannel writableByteChannel) {
        writableByteChannel.write(F());
        h(writableByteChannel);
    }
}
