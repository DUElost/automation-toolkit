package b.e.a.i.d.c;

import java.nio.ByteBuffer;
@g(tags = {20})
/* loaded from: classes.dex */
public class m extends b {

    /* renamed from: d  reason: collision with root package name */
    int f1576d;

    public m() {
        this.f1560a = 20;
    }

    @Override // b.e.a.i.d.c.b
    public int a() {
        return 1;
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        this.f1576d = b.c.a.e.n(byteBuffer);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return obj != null && m.class == obj.getClass() && this.f1576d == ((m) obj).f1576d;
    }

    public ByteBuffer g() {
        ByteBuffer allocate = ByteBuffer.allocate(b());
        b.c.a.f.j(allocate, 20);
        f(allocate, a());
        b.c.a.f.j(allocate, this.f1576d);
        return allocate;
    }

    public int hashCode() {
        return this.f1576d;
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        return "ProfileLevelIndicationDescriptor{profileLevelIndicationIndex=" + Integer.toHexString(this.f1576d) + '}';
    }
}
