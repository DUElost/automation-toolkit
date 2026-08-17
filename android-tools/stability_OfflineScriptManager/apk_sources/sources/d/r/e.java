package d.r;

import d.f;
import d.j;
import d.l;
import d.s.g;
import java.nio.ByteBuffer;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
/* loaded from: classes.dex */
public class e extends j {
    private final d.r.a A;
    private Map<d.s.a, a> B;
    private d.p.b C;
    private boolean D;
    private int E;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class a {

        /* renamed from: a  reason: collision with root package name */
        private d.p.b f2701a;

        /* renamed from: b  reason: collision with root package name */
        private boolean f2702b;

        public a(e eVar, d.p.b bVar, boolean z) {
            this.f2701a = bVar;
            this.f2702b = z;
        }
    }

    public e(d.c cVar, int i, int i2) {
        super(cVar, i, i2);
        this.B = new HashMap();
        this.C = null;
        this.D = false;
        this.E = d.s.e.c();
        f fVar = this.e;
        fVar.j = 11;
        fVar.u = true;
        this.A = new d.r.a();
        new d.e();
        new d.e();
    }

    private void r1(d.p.b bVar) {
        d.s.a b2;
        String str = this.y;
        if (str == null || str.isEmpty()) {
            ByteBuffer allocate = ByteBuffer.allocate(5);
            allocate.put((byte) 0);
            int i = this.E;
            this.E = i + 1;
            g.d(allocate, i);
            b2 = d.s.a.b(allocate.array());
        } else {
            b2 = d.s.a.b(this.y.getBytes(l.f2560c));
            this.y = null;
            this.B.get(b2);
        }
        bVar.M0(b2);
        this.B.put(b2, new a(this, bVar, true));
    }

    @Override // d.j
    protected void k1(d.p.b bVar, boolean z) {
        r1(bVar);
        this.A.b(bVar);
    }

    @Override // d.j
    protected void m1(d.p.b bVar) {
        this.B.remove(bVar.D0());
        this.A.d(bVar);
        if (bVar == this.C) {
            this.C = null;
        }
    }

    @Override // d.j
    protected void n1(d.p.b bVar) {
        this.A.a(bVar);
    }

    @Override // d.j
    protected boolean o1(d.e eVar) {
        d.s.c cVar;
        int i;
        if (this.D) {
            eVar.w(1);
            this.D = false;
            if (this.C != null) {
                if (eVar.B() == 0) {
                    this.C.P0(false);
                    this.C = null;
                    return true;
                }
                if (this.C.Q0(eVar)) {
                    this.C.B0();
                }
                this.C = null;
            }
            return true;
        }
        if (eVar.j()) {
            this.D = true;
            a aVar = this.B.get(d.s.a.a(eVar));
            if (aVar != null) {
                d.p.b bVar = aVar.f2701a;
                this.C = bVar;
                if (!bVar.z0()) {
                    aVar.f2702b = false;
                    this.C = null;
                    cVar = this.l;
                    i = 35;
                }
            } else {
                cVar = this.l;
                i = 65;
            }
            cVar.c(i);
            return false;
        }
        this.D = true;
        return true;
    }

    @Override // d.j
    protected boolean p1(int i, Object obj) {
        if (i != 61) {
            this.l.c(22);
            return false;
        }
        this.y = (String) obj;
        return true;
    }

    @Override // d.j
    protected void q1(d.p.b bVar) {
        a aVar;
        Iterator<a> it = this.B.values().iterator();
        while (true) {
            if (!it.hasNext()) {
                aVar = null;
                break;
            }
            a next = it.next();
            if (next.f2701a == bVar) {
                aVar = next;
                break;
            }
        }
        aVar.f2702b = true;
    }
}
