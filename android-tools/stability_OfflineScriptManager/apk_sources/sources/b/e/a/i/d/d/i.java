package b.e.a.i.d.d;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class i extends b {

    /* renamed from: a  reason: collision with root package name */
    private boolean f1595a;

    /* renamed from: b  reason: collision with root package name */
    private short f1596b;

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        ByteBuffer allocate = ByteBuffer.allocate(1);
        allocate.put((byte) ((this.f1595a ? 128 : 0) | (this.f1596b & 127)));
        allocate.rewind();
        return allocate;
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "rap ";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        byte b2 = byteBuffer.get();
        this.f1595a = (b2 & 128) == 128;
        this.f1596b = (short) (b2 & Byte.MAX_VALUE);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || i.class != obj.getClass()) {
            return false;
        }
        i iVar = (i) obj;
        return this.f1596b == iVar.f1596b && this.f1595a == iVar.f1595a;
    }

    public int hashCode() {
        return ((this.f1595a ? 1 : 0) * 31) + this.f1596b;
    }

    public String toString() {
        return "VisualRandomAccessEntry{numLeadingSamplesKnown=" + this.f1595a + ", numLeadingSamples=" + ((int) this.f1596b) + '}';
    }
}
