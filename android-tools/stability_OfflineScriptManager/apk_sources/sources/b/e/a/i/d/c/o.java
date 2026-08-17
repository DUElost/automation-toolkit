package b.e.a.i.d.c;

import java.nio.ByteBuffer;
import java.util.logging.Logger;
/* loaded from: classes.dex */
public class o extends b {

    /* renamed from: d  reason: collision with root package name */
    private ByteBuffer f1578d;

    static {
        Logger.getLogger(o.class.getName());
    }

    @Override // b.e.a.i.d.c.b
    int a() {
        throw new RuntimeException("sdjlhfl");
    }

    @Override // b.e.a.i.d.c.b
    public void e(ByteBuffer byteBuffer) {
        this.f1578d = byteBuffer.slice();
    }

    @Override // b.e.a.i.d.c.b
    public String toString() {
        return "UnknownDescriptor{tag=" + this.f1560a + ", sizeOfInstance=" + this.f1561b + ", data=" + this.f1578d + '}';
    }
}
