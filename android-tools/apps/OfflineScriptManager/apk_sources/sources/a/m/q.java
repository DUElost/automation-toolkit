package a.m;

import a.m.m;
import android.animation.TimeInterpolator;
import android.util.AndroidRuntimeException;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.Iterator;
/* loaded from: classes.dex */
public class q extends m {
    int M;
    private ArrayList<m> K = new ArrayList<>();
    private boolean L = true;
    boolean N = false;
    private int O = 0;

    /* loaded from: classes.dex */
    class a extends n {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ m f310a;

        a(q qVar, m mVar) {
            this.f310a = mVar;
        }

        @Override // a.m.m.f
        public void d(m mVar) {
            this.f310a.S();
            mVar.O(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b extends n {

        /* renamed from: a  reason: collision with root package name */
        q f311a;

        b(q qVar) {
            this.f311a = qVar;
        }

        @Override // a.m.n, a.m.m.f
        public void c(m mVar) {
            q qVar = this.f311a;
            if (qVar.N) {
                return;
            }
            qVar.Z();
            this.f311a.N = true;
        }

        @Override // a.m.m.f
        public void d(m mVar) {
            q qVar = this.f311a;
            int i = qVar.M - 1;
            qVar.M = i;
            if (i == 0) {
                qVar.N = false;
                qVar.o();
            }
            mVar.O(this);
        }
    }

    private void m0() {
        b bVar = new b(this);
        Iterator<m> it = this.K.iterator();
        while (it.hasNext()) {
            it.next().a(bVar);
        }
        this.M = this.K.size();
    }

    @Override // a.m.m
    public void M(View view) {
        super.M(view);
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            this.K.get(i).M(view);
        }
    }

    @Override // a.m.m
    public void Q(View view) {
        super.Q(view);
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            this.K.get(i).Q(view);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // a.m.m
    public void S() {
        if (this.K.isEmpty()) {
            Z();
            o();
            return;
        }
        m0();
        if (this.L) {
            Iterator<m> it = this.K.iterator();
            while (it.hasNext()) {
                it.next().S();
            }
            return;
        }
        for (int i = 1; i < this.K.size(); i++) {
            this.K.get(i - 1).a(new a(this, this.K.get(i)));
        }
        m mVar = this.K.get(0);
        if (mVar != null) {
            mVar.S();
        }
    }

    @Override // a.m.m
    public /* bridge */ /* synthetic */ m T(long j) {
        i0(j);
        return this;
    }

    @Override // a.m.m
    public void U(m.e eVar) {
        super.U(eVar);
        this.O |= 8;
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            this.K.get(i).U(eVar);
        }
    }

    @Override // a.m.m
    public void W(g gVar) {
        super.W(gVar);
        this.O |= 4;
        for (int i = 0; i < this.K.size(); i++) {
            this.K.get(i).W(gVar);
        }
    }

    @Override // a.m.m
    public void X(p pVar) {
        super.X(pVar);
        this.O |= 2;
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            this.K.get(i).X(pVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // a.m.m
    public String a0(String str) {
        String a0 = super.a0(str);
        for (int i = 0; i < this.K.size(); i++) {
            StringBuilder sb = new StringBuilder();
            sb.append(a0);
            sb.append("\n");
            sb.append(this.K.get(i).a0(str + "  "));
            a0 = sb.toString();
        }
        return a0;
    }

    @Override // a.m.m
    /* renamed from: b0 */
    public q a(m.f fVar) {
        super.a(fVar);
        return this;
    }

    @Override // a.m.m
    /* renamed from: c0 */
    public q b(View view) {
        for (int i = 0; i < this.K.size(); i++) {
            this.K.get(i).b(view);
        }
        super.b(view);
        return this;
    }

    public q d0(m mVar) {
        this.K.add(mVar);
        mVar.s = this;
        long j = this.f295d;
        if (j >= 0) {
            mVar.T(j);
        }
        if ((this.O & 1) != 0) {
            mVar.V(r());
        }
        if ((this.O & 2) != 0) {
            mVar.X(v());
        }
        if ((this.O & 4) != 0) {
            mVar.W(u());
        }
        if ((this.O & 8) != 0) {
            mVar.U(q());
        }
        return this;
    }

    public m e0(int i) {
        if (i < 0 || i >= this.K.size()) {
            return null;
        }
        return this.K.get(i);
    }

    @Override // a.m.m
    public void f(s sVar) {
        if (F(sVar.f316b)) {
            Iterator<m> it = this.K.iterator();
            while (it.hasNext()) {
                m next = it.next();
                if (next.F(sVar.f316b)) {
                    next.f(sVar);
                    sVar.f317c.add(next);
                }
            }
        }
    }

    public int f0() {
        return this.K.size();
    }

    @Override // a.m.m
    /* renamed from: g0 */
    public q O(m.f fVar) {
        super.O(fVar);
        return this;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // a.m.m
    public void h(s sVar) {
        super.h(sVar);
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            this.K.get(i).h(sVar);
        }
    }

    @Override // a.m.m
    /* renamed from: h0 */
    public q P(View view) {
        for (int i = 0; i < this.K.size(); i++) {
            this.K.get(i).P(view);
        }
        super.P(view);
        return this;
    }

    @Override // a.m.m
    public void i(s sVar) {
        if (F(sVar.f316b)) {
            Iterator<m> it = this.K.iterator();
            while (it.hasNext()) {
                m next = it.next();
                if (next.F(sVar.f316b)) {
                    next.i(sVar);
                    sVar.f317c.add(next);
                }
            }
        }
    }

    public q i0(long j) {
        super.T(j);
        if (this.f295d >= 0) {
            int size = this.K.size();
            for (int i = 0; i < size; i++) {
                this.K.get(i).T(j);
            }
        }
        return this;
    }

    @Override // a.m.m
    /* renamed from: j0 */
    public q V(TimeInterpolator timeInterpolator) {
        this.O |= 1;
        ArrayList<m> arrayList = this.K;
        if (arrayList != null) {
            int size = arrayList.size();
            for (int i = 0; i < size; i++) {
                this.K.get(i).V(timeInterpolator);
            }
        }
        super.V(timeInterpolator);
        return this;
    }

    public q k0(int i) {
        if (i == 0) {
            this.L = true;
        } else if (i != 1) {
            throw new AndroidRuntimeException("Invalid parameter for TransitionSet ordering: " + i);
        } else {
            this.L = false;
        }
        return this;
    }

    @Override // a.m.m
    /* renamed from: l */
    public m clone() {
        q qVar = (q) super.clone();
        qVar.K = new ArrayList<>();
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            qVar.d0(this.K.get(i).clone());
        }
        return qVar;
    }

    @Override // a.m.m
    /* renamed from: l0 */
    public q Y(long j) {
        super.Y(j);
        return this;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // a.m.m
    public void n(ViewGroup viewGroup, t tVar, t tVar2, ArrayList<s> arrayList, ArrayList<s> arrayList2) {
        long x = x();
        int size = this.K.size();
        for (int i = 0; i < size; i++) {
            m mVar = this.K.get(i);
            if (x > 0 && (this.L || i == 0)) {
                long x2 = mVar.x();
                if (x2 > 0) {
                    mVar.Y(x2 + x);
                } else {
                    mVar.Y(x);
                }
            }
            mVar.n(viewGroup, tVar, tVar2, arrayList, arrayList2);
        }
    }
}
