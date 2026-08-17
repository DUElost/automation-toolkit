package b.e.a.i.d.c;

import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Logger;
@g(tags = {4})
/* loaded from: classes.dex */
public class e extends b {
    private static Logger n = Logger.getLogger(e.class.getName());

    /* renamed from: d  reason: collision with root package name */
    int f1569d;
    int e;
    int f;
    int g;
    long h;
    long i;
    f j;
    a k;
    List<m> l = new ArrayList();
    byte[] m;

    public e() {
        this.f1560a = 4;
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        a aVar = this.k;
        int b2 = (aVar == null ? 0 : aVar.b()) + 13;
        f fVar = this.j;
        int b3 = b2 + (fVar != null ? fVar.b() : 0);
        for (m mVar : this.l) {
            b3 += mVar.b();
        }
        return b3;
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        int b2;
        this.f1569d = b.c.a.e.n(byteBuffer);
        int n2 = b.c.a.e.n(byteBuffer);
        this.e = n2 >>> 2;
        this.f = (n2 >> 1) & 1;
        this.g = b.c.a.e.j(byteBuffer);
        this.h = b.c.a.e.k(byteBuffer);
        this.i = b.c.a.e.k(byteBuffer);
        while (byteBuffer.remaining() > 2) {
            int position = byteBuffer.position();
            b a2 = l.a(this.f1569d, byteBuffer);
            int position2 = byteBuffer.position() - position;
            Logger logger = n;
            StringBuilder sb = new StringBuilder();
            sb.append(a2);
            sb.append(" - DecoderConfigDescr1 read: ");
            sb.append(position2);
            sb.append(", size: ");
            sb.append(a2 != null ? Integer.valueOf(a2.b()) : null);
            logger.finer(sb.toString());
            if (a2 != null && position2 < (b2 = a2.b())) {
                byte[] bArr = new byte[b2 - position2];
                this.m = bArr;
                byteBuffer.get(bArr);
            }
            if (a2 instanceof f) {
                this.j = (f) a2;
            } else if (a2 instanceof a) {
                this.k = (a) a2;
            } else if (a2 instanceof m) {
                this.l.add((m) a2);
            }
        }
    }

    public a g() {
        return this.k;
    }

    public long h() {
        return this.i;
    }

    public int i() {
        return this.g;
    }

    public f j() {
        return this.j;
    }

    public long k() {
        return this.h;
    }

    public int l() {
        return this.f1569d;
    }

    public List<m> m() {
        return this.l;
    }

    public int n() {
        return this.e;
    }

    public int o() {
        return this.f;
    }

    public ByteBuffer p() {
        ByteBuffer allocate = ByteBuffer.allocate(b());
        b.c.a.f.j(allocate, this.f1560a);
        f(allocate, a());
        b.c.a.f.j(allocate, this.f1569d);
        b.c.a.f.j(allocate, (this.e << 2) | (this.f << 1) | 1);
        b.c.a.f.f(allocate, this.g);
        b.c.a.f.g(allocate, this.h);
        b.c.a.f.g(allocate, this.i);
        f fVar = this.j;
        if (fVar != null) {
            allocate.put(fVar.g());
        }
        a aVar = this.k;
        if (aVar != null) {
            allocate.put(aVar.o());
        }
        for (m mVar : this.l) {
            allocate.put(mVar.g());
        }
        return (ByteBuffer) allocate.rewind();
    }

    public void q(long j) {
        this.i = j;
    }

    public void r(long j) {
        this.h = j;
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("DecoderConfigDescriptor");
        sb.append("{objectTypeIndication=");
        sb.append(this.f1569d);
        sb.append(", streamType=");
        sb.append(this.e);
        sb.append(", upStream=");
        sb.append(this.f);
        sb.append(", bufferSizeDB=");
        sb.append(this.g);
        sb.append(", maxBitRate=");
        sb.append(this.h);
        sb.append(", avgBitRate=");
        sb.append(this.i);
        sb.append(", decoderSpecificInfo=");
        sb.append(this.j);
        sb.append(", audioSpecificInfo=");
        sb.append(this.k);
        sb.append(", configDescriptorDeadBytes=");
        byte[] bArr = this.m;
        if (bArr == null) {
            bArr = new byte[0];
        }
        sb.append(b.c.a.c.a(bArr));
        sb.append(", profileLevelIndicationDescriptors=");
        List<m> list = this.l;
        sb.append(list == null ? "null" : Arrays.asList(list).toString());
        sb.append('}');
        return sb.toString();
    }
}
