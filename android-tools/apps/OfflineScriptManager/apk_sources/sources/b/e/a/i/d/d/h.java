package b.e.a.i.d.d;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class h extends b {

    /* renamed from: a  reason: collision with root package name */
    private ByteBuffer f1593a;

    /* renamed from: b  reason: collision with root package name */
    private String f1594b;

    public h(String str) {
        this.f1594b = str;
    }

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        return this.f1593a.duplicate();
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return this.f1594b;
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        this.f1593a = (ByteBuffer) byteBuffer.duplicate().rewind();
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || h.class != obj.getClass()) {
            return false;
        }
        ByteBuffer byteBuffer = this.f1593a;
        ByteBuffer byteBuffer2 = ((h) obj).f1593a;
        return byteBuffer == null ? byteBuffer2 == null : byteBuffer.equals(byteBuffer2);
    }

    public int hashCode() {
        ByteBuffer byteBuffer = this.f1593a;
        if (byteBuffer != null) {
            return byteBuffer.hashCode();
        }
        return 0;
    }

    public String toString() {
        ByteBuffer duplicate = this.f1593a.duplicate();
        duplicate.rewind();
        byte[] bArr = new byte[duplicate.limit()];
        duplicate.get(bArr);
        return "UnknownEntry{content=" + b.c.a.c.a(bArr) + '}';
    }
}
