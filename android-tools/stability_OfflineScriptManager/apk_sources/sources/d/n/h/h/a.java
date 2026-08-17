package d.n.h.h;

import d.n.h.e;
import d.s.c;
import d.s.g;
import java.nio.ByteBuffer;
/* loaded from: classes.dex */
public class a extends d.n.h.a {
    private final ByteBuffer o;

    public a(c cVar, int i, long j, d.o.a aVar) {
        super(cVar, i, j, aVar);
        ByteBuffer allocate = ByteBuffer.allocate(8);
        this.o = allocate;
        allocate.limit(1);
        f(allocate, this.j);
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a i() {
        this.o.position(0);
        this.o.limit(8);
        long b2 = g.b(this.o, 0);
        if (b2 <= 0) {
            e(156384820);
            return e.a.EnumC0107a.ERROR;
        }
        this.o.limit(1);
        e.a.EnumC0107a m = m(b2 - 1);
        if (m != e.a.EnumC0107a.ERROR) {
            f(this.o, this.l);
        }
        return m;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a j() {
        if ((this.o.get(0) & 255 & 1) > 0) {
            this.i.y(1);
        }
        g(this.i, this.m);
        return e.a.EnumC0107a.MORE_DATA;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a k() {
        this.o.position(0);
        this.o.limit(1);
        f(this.o, this.j);
        return e.a.EnumC0107a.DECODED;
    }

    @Override // d.n.h.a
    protected e.a.EnumC0107a l() {
        int i = this.o.get(0) & 255;
        if (i == 255) {
            this.o.position(0);
            this.o.limit(8);
            f(this.o, this.k);
            return e.a.EnumC0107a.MORE_DATA;
        } else if (i <= 0) {
            e(156384820);
            return e.a.EnumC0107a.ERROR;
        } else {
            this.o.position(0);
            this.o.limit(1);
            e.a.EnumC0107a m = m(i - 1);
            if (m != e.a.EnumC0107a.ERROR) {
                f(this.o, this.l);
            }
            return m;
        }
    }
}
