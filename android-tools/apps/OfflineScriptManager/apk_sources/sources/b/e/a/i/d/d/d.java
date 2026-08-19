package b.e.a.i.d.d;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class d extends b {

    /* renamed from: a  reason: collision with root package name */
    private short f1588a;

    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        ByteBuffer allocate = ByteBuffer.allocate(2);
        allocate.putShort(this.f1588a);
        allocate.rewind();
        return allocate;
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "roll";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
        this.f1588a = byteBuffer.getShort();
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return obj != null && d.class == obj.getClass() && this.f1588a == ((d) obj).f1588a;
    }

    public int hashCode() {
        return this.f1588a;
    }
}
