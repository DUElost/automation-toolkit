package d.n.j.e;

import d.f;
import d.j;
import d.n.j.h.d;
import java.net.InetSocketAddress;
/* loaded from: classes.dex */
public class c extends d {
    private a t;

    public c(d.n.d dVar, j jVar, f fVar) {
        super(dVar, jVar, fVar);
    }

    @Override // d.n.j.h.d
    public String I0() {
        return this.t.toString();
    }

    @Override // d.n.j.h.d
    public boolean J0(String str) {
        a aVar = new a(str);
        this.t = aVar;
        InetSocketAddress inetSocketAddress = (InetSocketAddress) aVar.c();
        return super.J0(String.valueOf(inetSocketAddress.getAddress().getHostAddress()) + ":" + inetSocketAddress.getPort());
    }
}
