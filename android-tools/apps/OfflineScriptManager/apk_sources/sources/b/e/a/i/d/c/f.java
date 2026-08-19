package b.e.a.i.d.c;

import java.nio.ByteBuffer;
import java.util.Arrays;
@g(tags = {5})
/* loaded from: classes.dex */
public class f extends b {

    /* renamed from: d  reason: collision with root package name */
    byte[] f1570d;

    public f() {
        this.f1560a = 5;
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        return this.f1570d.length;
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        byte[] bArr = new byte[byteBuffer.remaining()];
        this.f1570d = bArr;
        byteBuffer.get(bArr);
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return obj != null && f.class == obj.getClass() && Arrays.equals(this.f1570d, ((f) obj).f1570d);
    }

    public ByteBuffer g() {
        ByteBuffer allocate = ByteBuffer.allocate(b());
        b.c.a.f.j(allocate, this.f1560a);
        f(allocate, a());
        allocate.put(this.f1570d);
        return (ByteBuffer) allocate.rewind();
    }

    public int hashCode() {
        byte[] bArr = this.f1570d;
        if (bArr != null) {
            return Arrays.hashCode(bArr);
        }
        return 0;
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("DecoderSpecificInfo");
        sb.append("{bytes=");
        byte[] bArr = this.f1570d;
        sb.append(bArr == null ? "null" : b.c.a.c.a(bArr));
        sb.append('}');
        return sb.toString();
    }
}
