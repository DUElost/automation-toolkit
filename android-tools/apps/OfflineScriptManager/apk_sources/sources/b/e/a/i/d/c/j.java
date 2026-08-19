package b.e.a.i.d.c;

import java.nio.ByteBuffer;
@g(tags = {19})
/* loaded from: classes.dex */
public class j extends b {

    /* renamed from: d  reason: collision with root package name */
    byte[] f1573d;

    public j() {
        this.f1560a = 19;
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        throw new RuntimeException("Not Implemented");
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        if (b() > 0) {
            byte[] bArr = new byte[b()];
            this.f1573d = bArr;
            byteBuffer.get(bArr);
        }
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("ExtensionDescriptor");
        sb.append("{bytes=");
        byte[] bArr = this.f1573d;
        sb.append(bArr == null ? "null" : b.c.a.c.a(bArr));
        sb.append('}');
        return sb.toString();
    }
}
