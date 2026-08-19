package d.n.h.i;

import d.e;
import d.n.h.e;
import d.s.c;
import d.s.g;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class a extends d.n.h.a {
    private final ByteBuffer o;
    private int p;

    public a(c cVar, int i, long j, d.o.a aVar) {
        super(cVar, i, j, aVar);
        ByteBuffer allocate = ByteBuffer.allocate(8);
        this.o = allocate;
        allocate.limit(1);
        f(allocate, this.l);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.n.h.a
    public e h(int i) {
        e h = super.h(i);
        h.y(this.p);
        return h;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a i() {
        this.o.position(0);
        this.o.limit(8);
        e.a.EnumC0107a m = m(g.b(this.o, 0));
        if (m != e.a.EnumC0107a.ERROR) {
            g(this.i, this.m);
        }
        return m;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a j() {
        ByteBuffer byteBuffer;
        e.a aVar;
        this.p = 0;
        int i = this.o.get(0) & 255;
        if ((i & 1) > 0) {
            this.p |= 1;
        }
        if ((i & 4) > 0) {
            this.p |= 2;
        }
        this.o.position(0);
        if ((i & 2) > 0) {
            this.o.limit(8);
            byteBuffer = this.o;
            aVar = this.k;
        } else {
            this.o.limit(1);
            byteBuffer = this.o;
            aVar = this.j;
        }
        f(byteBuffer, aVar);
        return e.a.EnumC0107a.MORE_DATA;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a k() {
        this.o.position(0);
        this.o.limit(1);
        f(this.o, this.l);
        return e.a.EnumC0107a.DECODED;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a l() {
        e.a.EnumC0107a m = m(this.o.get(0) & 255);
        if (m != e.a.EnumC0107a.ERROR) {
            g(this.i, this.m);
        }
        return m;
    }
}
