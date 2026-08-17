package d.n.h.h;

import d.n.h.c;
import d.s.g;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class b extends c {
    private final ByteBuffer j;

    public b(d.s.c cVar, int i) {
        super(cVar, i);
        this.j = ByteBuffer.allocate(10);
        d(this.i, true);
    }

    @Override // d.n.h.c
    protected void h() {
        int B = this.g.B() + 1;
        this.j.position(0);
        if (B < 255) {
            this.j.limit(2);
            this.j.put((byte) B);
        } else {
            this.j.limit(10);
            this.j.put((byte) -1);
            g.f(this.j, B);
        }
        this.j.put((byte) (this.g.d() & 1));
        ByteBuffer byteBuffer = this.j;
        f(byteBuffer, byteBuffer.limit(), this.h, false);
    }

    @Override // d.n.h.c
    protected void i() {
        f(this.g.a(), this.g.B(), this.i, true);
    }
}
