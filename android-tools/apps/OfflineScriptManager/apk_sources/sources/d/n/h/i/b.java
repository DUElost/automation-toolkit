package d.n.h.i;

import d.n.h.c;
import d.s.g;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class b extends c {
    private final ByteBuffer j;

    public b(d.s.c cVar, int i) {
        super(cVar, i);
        this.j = ByteBuffer.allocate(9);
        d(this.i, true);
    }

    @Override // d.n.h.c
    protected void h() {
        byte b2 = this.g.j() ? (byte) 1 : (byte) 0;
        if (this.g.B() > 255) {
            b2 = (byte) (b2 | 2);
        }
        if (this.g.l()) {
            b2 = (byte) (b2 | 4);
        }
        int B = this.g.B();
        this.j.position(0);
        this.j.put(b2);
        ByteBuffer byteBuffer = this.j;
        if (B > 255) {
            byteBuffer.limit(9);
            g.f(this.j, B);
        } else {
            byteBuffer.limit(2);
            this.j.put((byte) B);
        }
        ByteBuffer byteBuffer2 = this.j;
        f(byteBuffer2, byteBuffer2.limit(), this.h, false);
    }

    @Override // d.n.h.c
    protected void i() {
        f(this.g.a(), this.g.B(), this.i, true);
    }
}
