package b.e.a.i.d.d;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class g extends b {

    /* renamed from: a  reason: collision with root package name */
    private boolean f1591a;

    /* renamed from: b  reason: collision with root package name */
    private short f1592b;

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        ByteBuffer allocate = ByteBuffer.allocate(1);
        allocate.put((byte) (this.f1591a ? 128 : 0));
        allocate.rewind();
        return allocate;
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "tele";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        this.f1591a = (byteBuffer.get() & 128) == 128;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || g.class != obj.getClass()) {
            return false;
        }
        g gVar = (g) obj;
        return this.f1591a == gVar.f1591a && this.f1592b == gVar.f1592b;
    }

    public int hashCode() {
        return ((this.f1591a ? 1 : 0) * 31) + this.f1592b;
    }

    public String toString() {
        return "TemporalLevelEntry{levelIndependentlyDecodable=" + this.f1591a + '}';
    }
}
