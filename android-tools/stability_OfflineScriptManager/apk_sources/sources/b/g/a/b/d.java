package b.g.a.b;

import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class d extends b.e.a.i.d.d.b {
    @Override // b.e.a.i.d.d.b
    public ByteBuffer a() {
        return ByteBuffer.allocate(0);
    }

    @Override // b.e.a.i.d.d.b
    public String b() {
        return "tsas";
    }

    @Override // b.e.a.i.d.d.b
    public void c(ByteBuffer byteBuffer) {
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        return obj != null && d.class == obj.getClass();
    }

    public int hashCode() {
        return 41;
    }
}
