package b.e.a.h.j.a;

import b.c.a.i.f0;
import b.c.a.i.y;
import b.e.a.e;
import b.e.a.h.b;
import b.e.a.h.d;
import b.e.a.j.j;
/* loaded from: classes.dex */
public class a {
    public static d a(e eVar) {
        b.c.a.d dVar = new b.c.a.d(eVar);
        d dVar2 = new d();
        for (f0 f0Var : dVar.G().q(f0.class)) {
            y yVar = (y) j.a(f0Var, "mdia[0]/minf[0]/stbl[0]/stsd[0]/enc.[0]/sinf[0]/schm[0]");
            dVar2.a((yVar == null || !(yVar.s().equals("cenc") || yVar.s().equals("cbc1"))) ? new b.e.a.h.e(String.valueOf(eVar.toString()) + "[" + f0Var.I().A() + "]", f0Var, new b.c.a.d[0]) : new b(String.valueOf(eVar.toString()) + "[" + f0Var.I().A() + "]", f0Var, new b.c.a.d[0]));
        }
        dVar2.h(dVar.G().G().v());
        return dVar2;
    }
}
