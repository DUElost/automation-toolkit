package b.g.a.b;

import b.c.a.e;
import b.c.a.f;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class b extends b.e.a.i.d.d.b {

    /* renamed from: a  reason: collision with root package name */
    int f1627a;

    /* renamed from: b  reason: collision with root package name */
    int f1628b;

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        ByteBuffer allocate = ByteBuffer.allocate(1);
        f.j(allocate, this.f1628b + (this.f1627a << 6));
        return (ByteBuffer) allocate.rewind();
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "sync";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        int n = e.n(byteBuffer);
        this.f1627a = (n & 192) >> 6;
        this.f1628b = n & 63;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || b.class != obj.getClass()) {
            return false;
        }
        b bVar = (b) obj;
        return this.f1628b == bVar.f1628b && this.f1627a == bVar.f1627a;
    }

    public int hashCode() {
        return (this.f1627a * 31) + this.f1628b;
    }

    public String toString() {
        return "SyncSampleEntry{reserved=" + this.f1627a + ", nalUnitType=" + this.f1628b + '}';
    }
}
