package d;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.atomic.AtomicLong;
/* loaded from: classes.dex */
public abstract class g extends m {
    protected final f e;
    private boolean f;
    private final AtomicLong g;
    private long h;
    private g i;
    private final Set<g> j;
    private int k;
    public final d.s.c l;

    /* JADX INFO: Access modifiers changed from: protected */
    public g(c cVar, int i) {
        super(cVar, i);
        this.f = false;
        this.g = new AtomicLong(0L);
        this.h = 0L;
        this.i = null;
        this.k = 0;
        f fVar = new f();
        this.e = fVar;
        this.l = fVar.P;
        this.j = new HashSet();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public g(d.n.d dVar, f fVar) {
        super(dVar);
        this.e = fVar;
        this.f = false;
        this.g = new AtomicLong(0L);
        this.h = 0L;
        this.i = null;
        this.k = 0;
        this.l = fVar.P;
        this.j = new HashSet();
    }

    private void E0(g gVar) {
        this.i = gVar;
    }

    private void x0() {
        if (this.f && this.h == this.g.get() && this.k == 0) {
            g gVar = this.i;
            if (gVar != null) {
                t0(gVar);
            }
            C0();
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final boolean A0() {
        return this.f;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void B0(g gVar) {
        gVar.E0(this);
        n0(gVar);
        k0(this, gVar);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void C0() {
        y0();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void D0(int i) {
        this.k += i;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final void F0() {
        if (this.f) {
            return;
        }
        g gVar = this.i;
        if (gVar == null) {
            W(this.e.k);
        } else {
            u0(gVar, this);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void G0() {
        this.k--;
        x0();
    }

    @Override // d.m
    protected final void O(g gVar) {
        if (!this.f) {
            this.j.add(gVar);
            return;
        }
        D0(1);
        s0(gVar, 0);
    }

    @Override // d.m
    protected final void U() {
        this.h++;
        x0();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // d.m
    public void W(int i) {
        for (g gVar : this.j) {
            s0(gVar, i);
        }
        D0(this.j.size());
        this.j.clear();
        this.f = true;
        x0();
    }

    @Override // d.m
    protected final void X() {
        G0();
    }

    @Override // d.m
    protected final void Y(g gVar) {
        if (!this.f && this.j.remove(gVar)) {
            D0(1);
            s0(gVar, this.e.k);
        }
    }

    protected abstract void y0();

    /* JADX INFO: Access modifiers changed from: protected */
    public void z0() {
        this.g.incrementAndGet();
    }
}
