package b.e.a.i.d.c;

import java.nio.ByteBuffer;
@g(tags = {6})
/* loaded from: classes.dex */
public class n extends b {

    /* renamed from: d  reason: collision with root package name */
    int f1577d;

    public n() {
        this.f1560a = 6;
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        return 1;
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        this.f1577d = b.c.a.e.n(byteBuffer);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return obj != null && n.class == obj.getClass() && this.f1577d == ((n) obj).f1577d;
    }

    public ByteBuffer g() {
        ByteBuffer allocate = ByteBuffer.allocate(b());
        b.c.a.f.j(allocate, 6);
        f(allocate, a());
        b.c.a.f.j(allocate, this.f1577d);
        return allocate;
    }

    public int hashCode() {
        return this.f1577d;
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        return "SLConfigDescriptor{predefined=" + this.f1577d + '}';
    }
}
