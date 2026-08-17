package androidx.recyclerview.widget;

import a.f.l.a0.c;
import android.content.Context;
import android.graphics.Rect;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseIntArray;
import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
/* loaded from: classes.dex */
public class GridLayoutManager extends LinearLayoutManager {
    boolean H;
    int I;
    int[] J;
    View[] K;
    final SparseIntArray L;
    final SparseIntArray M;
    c N;
    final Rect O;

    /* loaded from: classes.dex */
    public static final class a extends c {
        @Override // androidx.recyclerview.widget.GridLayoutManager.c
        public int d(int i, int i2) {
            return i % i2;
        }

        @Override // androidx.recyclerview.widget.GridLayoutManager.c
        public int e(int i) {
            return 1;
        }
    }

    /* loaded from: classes.dex */
    public static class b extends RecyclerView.p {
        int e;
        int f;

        public b(int i, int i2) {
            super(i, i2);
            this.e = -1;
            this.f = 0;
        }

        public b(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.e = -1;
            this.f = 0;
        }

        public b(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.e = -1;
            this.f = 0;
        }

        public b(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
            this.e = -1;
            this.f = 0;
        }

        public int e() {
            return this.e;
        }

        public int f() {
            return this.f;
        }
    }

    /* loaded from: classes.dex */
    public static abstract class c {

        /* renamed from: a  reason: collision with root package name */
        final SparseIntArray f1097a = new SparseIntArray();

        /* renamed from: b  reason: collision with root package name */
        private boolean f1098b = false;

        int a(int i) {
            int size = this.f1097a.size() - 1;
            int i2 = 0;
            while (i2 <= size) {
                int i3 = (i2 + size) >>> 1;
                if (this.f1097a.keyAt(i3) < i) {
                    i2 = i3 + 1;
                } else {
                    size = i3 - 1;
                }
            }
            int i4 = i2 - 1;
            if (i4 < 0 || i4 >= this.f1097a.size()) {
                return -1;
            }
            return this.f1097a.keyAt(i4);
        }

        int b(int i, int i2) {
            if (this.f1098b) {
                int i3 = this.f1097a.get(i, -1);
                if (i3 != -1) {
                    return i3;
                }
                int d2 = d(i, i2);
                this.f1097a.put(i, d2);
                return d2;
            }
            return d(i, i2);
        }

        public int c(int i, int i2) {
            int e = e(i);
            int i3 = 0;
            int i4 = 0;
            for (int i5 = 0; i5 < i; i5++) {
                int e2 = e(i5);
                i3 += e2;
                if (i3 == i2) {
                    i4++;
                    i3 = 0;
                } else if (i3 > i2) {
                    i4++;
                    i3 = e2;
                }
            }
            return i3 + e > i2 ? i4 + 1 : i4;
        }

        /* JADX WARN: Removed duplicated region for block: B:14:0x002a  */
        /* JADX WARN: Removed duplicated region for block: B:20:0x0039  */
        /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:16:0x0031 -> B:19:0x0036). Please submit an issue!!! */
        /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:17:0x0033 -> B:19:0x0036). Please submit an issue!!! */
        /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:18:0x0035 -> B:19:0x0036). Please submit an issue!!! */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public int d(int r6, int r7) {
            /*
                r5 = this;
                int r0 = r5.e(r6)
                r1 = 0
                if (r0 != r7) goto L8
                return r1
            L8:
                boolean r2 = r5.f1098b
                if (r2 == 0) goto L26
                android.util.SparseIntArray r2 = r5.f1097a
                int r2 = r2.size()
                if (r2 <= 0) goto L26
                int r2 = r5.a(r6)
                if (r2 < 0) goto L26
                android.util.SparseIntArray r3 = r5.f1097a
                int r3 = r3.get(r2)
                int r4 = r5.e(r2)
                int r3 = r3 + r4
                goto L36
            L26:
                r2 = r1
                r3 = r2
            L28:
                if (r2 >= r6) goto L39
                int r4 = r5.e(r2)
                int r3 = r3 + r4
                if (r3 != r7) goto L33
                r3 = r1
                goto L36
            L33:
                if (r3 <= r7) goto L36
                r3 = r4
            L36:
                int r2 = r2 + 1
                goto L28
            L39:
                int r0 = r0 + r3
                if (r0 > r7) goto L3d
                return r3
            L3d:
                return r1
            */
            throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.GridLayoutManager.c.d(int, int):int");
        }

        public abstract int e(int i);

        public void f() {
            this.f1097a.clear();
        }
    }

    public GridLayoutManager(Context context, int i) {
        super(context);
        this.H = false;
        this.I = -1;
        this.L = new SparseIntArray();
        this.M = new SparseIntArray();
        this.N = new a();
        this.O = new Rect();
        V2(i);
    }

    public GridLayoutManager(Context context, AttributeSet attributeSet, int i, int i2) {
        super(context, attributeSet, i, i2);
        this.H = false;
        this.I = -1;
        this.L = new SparseIntArray();
        this.M = new SparseIntArray();
        this.N = new a();
        this.O = new Rect();
        V2(RecyclerView.o.g0(context, attributeSet, i, i2).f1145b);
    }

    private void G2(RecyclerView.v vVar, RecyclerView.z zVar, int i, int i2, boolean z) {
        int i3;
        int i4;
        int i5 = 0;
        int i6 = -1;
        if (z) {
            i4 = 1;
            i6 = i;
            i3 = 0;
        } else {
            i3 = i - 1;
            i4 = -1;
        }
        while (i3 != i6) {
            View view = this.K[i3];
            b bVar = (b) view.getLayoutParams();
            int R2 = R2(vVar, zVar, f0(view));
            bVar.f = R2;
            bVar.e = i5;
            i5 += R2;
            i3 += i4;
        }
    }

    private void H2() {
        int I = I();
        for (int i = 0; i < I; i++) {
            b bVar = (b) H(i).getLayoutParams();
            int a2 = bVar.a();
            this.L.put(a2, bVar.f());
            this.M.put(a2, bVar.e());
        }
    }

    private void I2(int i) {
        this.J = J2(this.J, this.I, i);
    }

    static int[] J2(int[] iArr, int i, int i2) {
        int i3;
        if (iArr == null || iArr.length != i + 1 || iArr[iArr.length - 1] != i2) {
            iArr = new int[i + 1];
        }
        int i4 = 0;
        iArr[0] = 0;
        int i5 = i2 / i;
        int i6 = i2 % i;
        int i7 = 0;
        for (int i8 = 1; i8 <= i; i8++) {
            i4 += i6;
            if (i4 <= 0 || i - i4 >= i6) {
                i3 = i5;
            } else {
                i3 = i5 + 1;
                i4 -= i;
            }
            i7 += i3;
            iArr[i8] = i7;
        }
        return iArr;
    }

    private void K2() {
        this.L.clear();
        this.M.clear();
    }

    private void L2(RecyclerView.v vVar, RecyclerView.z zVar, LinearLayoutManager.a aVar, int i) {
        boolean z = i == 1;
        int Q2 = Q2(vVar, zVar, aVar.f1103b);
        if (z) {
            while (Q2 > 0) {
                int i2 = aVar.f1103b;
                if (i2 <= 0) {
                    return;
                }
                int i3 = i2 - 1;
                aVar.f1103b = i3;
                Q2 = Q2(vVar, zVar, i3);
            }
            return;
        }
        int b2 = zVar.b() - 1;
        int i4 = aVar.f1103b;
        while (i4 < b2) {
            int i5 = i4 + 1;
            int Q22 = Q2(vVar, zVar, i5);
            if (Q22 <= Q2) {
                break;
            }
            i4 = i5;
            Q2 = Q22;
        }
        aVar.f1103b = i4;
    }

    private void M2() {
        View[] viewArr = this.K;
        if (viewArr == null || viewArr.length != this.I) {
            this.K = new View[this.I];
        }
    }

    private int P2(RecyclerView.v vVar, RecyclerView.z zVar, int i) {
        if (zVar.e()) {
            int f = vVar.f(i);
            if (f == -1) {
                Log.w("GridLayoutManager", "Cannot find span size for pre layout position. " + i);
                return 0;
            }
            return this.N.c(f, this.I);
        }
        return this.N.c(i, this.I);
    }

    private int Q2(RecyclerView.v vVar, RecyclerView.z zVar, int i) {
        if (zVar.e()) {
            int i2 = this.M.get(i, -1);
            if (i2 != -1) {
                return i2;
            }
            int f = vVar.f(i);
            if (f == -1) {
                Log.w("GridLayoutManager", "Cannot find span size for pre layout position. It is not cached, not in the adapter. Pos:" + i);
                return 0;
            }
            return this.N.b(f, this.I);
        }
        return this.N.b(i, this.I);
    }

    private int R2(RecyclerView.v vVar, RecyclerView.z zVar, int i) {
        if (zVar.e()) {
            int i2 = this.L.get(i, -1);
            if (i2 != -1) {
                return i2;
            }
            int f = vVar.f(i);
            if (f == -1) {
                Log.w("GridLayoutManager", "Cannot find span size for pre layout position. It is not cached, not in the adapter. Pos:" + i);
                return 1;
            }
            return this.N.e(f);
        }
        return this.N.e(i);
    }

    private void S2(float f, int i) {
        I2(Math.max(Math.round(f * this.I), i));
    }

    private void T2(View view, int i, boolean z) {
        int i2;
        int i3;
        b bVar = (b) view.getLayoutParams();
        Rect rect = bVar.f1149b;
        int i4 = rect.top + rect.bottom + ((ViewGroup.MarginLayoutParams) bVar).topMargin + ((ViewGroup.MarginLayoutParams) bVar).bottomMargin;
        int i5 = rect.left + rect.right + ((ViewGroup.MarginLayoutParams) bVar).leftMargin + ((ViewGroup.MarginLayoutParams) bVar).rightMargin;
        int N2 = N2(bVar.e, bVar.f);
        if (this.s == 1) {
            i3 = RecyclerView.o.J(N2, i, i5, ((ViewGroup.MarginLayoutParams) bVar).width, false);
            i2 = RecyclerView.o.J(this.u.n(), W(), i4, ((ViewGroup.MarginLayoutParams) bVar).height, true);
        } else {
            int J = RecyclerView.o.J(N2, i, i4, ((ViewGroup.MarginLayoutParams) bVar).height, false);
            int J2 = RecyclerView.o.J(this.u.n(), n0(), i5, ((ViewGroup.MarginLayoutParams) bVar).width, true);
            i2 = J;
            i3 = J2;
        }
        U2(view, i3, i2, z);
    }

    private void U2(View view, int i, int i2, boolean z) {
        RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
        if (z ? E1(view, i, i2, pVar) : C1(view, i, i2, pVar)) {
            view.measure(i, i2);
        }
    }

    private void X2() {
        int V;
        int e0;
        if (j2() == 1) {
            V = m0() - d0();
            e0 = c0();
        } else {
            V = V() - b0();
            e0 = e0();
        }
        I2(V - e0);
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p C() {
        return this.s == 0 ? new b(-2, -1) : new b(-1, -2);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p D(Context context, AttributeSet attributeSet) {
        return new b(context, attributeSet);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p E(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof ViewGroup.MarginLayoutParams ? new b((ViewGroup.MarginLayoutParams) layoutParams) : new b(layoutParams);
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    public boolean G1() {
        return this.D == null && !this.H;
    }

    /* JADX WARN: Code restructure failed: missing block: B:59:0x00d6, code lost:
        if (r13 == (r2 > r15)) goto L50;
     */
    /* JADX WARN: Code restructure failed: missing block: B:72:0x00f6, code lost:
        if (r13 == (r2 > r7)) goto L51;
     */
    /* JADX WARN: Removed duplicated region for block: B:79:0x0107  */
    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View H0(android.view.View r24, int r25, androidx.recyclerview.widget.RecyclerView.v r26, androidx.recyclerview.widget.RecyclerView.z r27) {
        /*
            Method dump skipped, instructions count: 337
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.GridLayoutManager.H0(android.view.View, int, androidx.recyclerview.widget.RecyclerView$v, androidx.recyclerview.widget.RecyclerView$z):android.view.View");
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager
    void H1(RecyclerView.z zVar, LinearLayoutManager.c cVar, RecyclerView.o.c cVar2) {
        int i = this.I;
        for (int i2 = 0; i2 < this.I && cVar.c(zVar) && i > 0; i2++) {
            int i3 = cVar.f1113d;
            cVar2.a(i3, Math.max(0, cVar.g));
            i -= this.N.e(i3);
            cVar.f1113d += cVar.e;
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int M(RecyclerView.v vVar, RecyclerView.z zVar) {
        if (this.s == 1) {
            return this.I;
        }
        if (zVar.b() < 1) {
            return 0;
        }
        return P2(vVar, zVar, zVar.b() - 1) + 1;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void N0(RecyclerView.v vVar, RecyclerView.z zVar, View view, a.f.l.a0.c cVar) {
        int i;
        int e;
        int f;
        boolean z;
        boolean z2;
        int i2;
        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
        if (!(layoutParams instanceof b)) {
            super.M0(view, cVar);
            return;
        }
        b bVar = (b) layoutParams;
        int P2 = P2(vVar, zVar, bVar.a());
        if (this.s == 0) {
            int e2 = bVar.e();
            i = bVar.f();
            f = 1;
            z = this.I > 1 && bVar.f() == this.I;
            z2 = false;
            i2 = e2;
            e = P2;
        } else {
            i = 1;
            e = bVar.e();
            f = bVar.f();
            z = this.I > 1 && bVar.f() == this.I;
            z2 = false;
            i2 = P2;
        }
        cVar.y(c.b.a(i2, i, e, f, z, z2));
    }

    int N2(int i, int i2) {
        if (this.s != 1 || !k2()) {
            int[] iArr = this.J;
            return iArr[i2 + i] - iArr[i];
        }
        int[] iArr2 = this.J;
        int i3 = this.I;
        return iArr2[i3 - i] - iArr2[(i3 - i) - i2];
    }

    public int O2() {
        return this.I;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void P0(RecyclerView recyclerView, int i, int i2) {
        this.N.f();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void Q0(RecyclerView recyclerView) {
        this.N.f();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void R0(RecyclerView recyclerView, int i, int i2, int i3) {
        this.N.f();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void S0(RecyclerView recyclerView, int i, int i2) {
        this.N.f();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void U0(RecyclerView recyclerView, int i, int i2, Object obj) {
        this.N.f();
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    public void V0(RecyclerView.v vVar, RecyclerView.z zVar) {
        if (zVar.e()) {
            H2();
        }
        super.V0(vVar, zVar);
        K2();
    }

    public void V2(int i) {
        if (i == this.I) {
            return;
        }
        this.H = true;
        if (i >= 1) {
            this.I = i;
            this.N.f();
            q1();
            return;
        }
        throw new IllegalArgumentException("Span count should be at least 1. Provided " + i);
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    public void W0(RecyclerView.z zVar) {
        super.W0(zVar);
        this.H = false;
    }

    public void W2(c cVar) {
        this.N = cVar;
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager
    View b2(RecyclerView.v vVar, RecyclerView.z zVar, int i, int i2, int i3) {
        N1();
        int m = this.u.m();
        int i4 = this.u.i();
        int i5 = i2 > i ? 1 : -1;
        View view = null;
        View view2 = null;
        while (i != i2) {
            View H = H(i);
            int f0 = f0(H);
            if (f0 >= 0 && f0 < i3 && Q2(vVar, zVar, f0) == 0) {
                if (((RecyclerView.p) H.getLayoutParams()).c()) {
                    if (view2 == null) {
                        view2 = H;
                    }
                } else if (this.u.g(H) < i4 && this.u.d(H) >= m) {
                    return H;
                } else {
                    if (view == null) {
                        view = H;
                    }
                }
            }
            i += i5;
        }
        return view != null ? view : view2;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int i0(RecyclerView.v vVar, RecyclerView.z zVar) {
        if (this.s == 0) {
            return this.I;
        }
        if (zVar.b() < 1) {
            return 0;
        }
        return P2(vVar, zVar, zVar.b() - 1) + 1;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean l(RecyclerView.p pVar) {
        return pVar instanceof b;
    }

    /* JADX WARN: Code restructure failed: missing block: B:37:0x00a1, code lost:
        r22.f1107b = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:38:0x00a3, code lost:
        return;
     */
    @Override // androidx.recyclerview.widget.LinearLayoutManager
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    void l2(androidx.recyclerview.widget.RecyclerView.v r19, androidx.recyclerview.widget.RecyclerView.z r20, androidx.recyclerview.widget.LinearLayoutManager.c r21, androidx.recyclerview.widget.LinearLayoutManager.b r22) {
        /*
            Method dump skipped, instructions count: 577
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.GridLayoutManager.l2(androidx.recyclerview.widget.RecyclerView$v, androidx.recyclerview.widget.RecyclerView$z, androidx.recyclerview.widget.LinearLayoutManager$c, androidx.recyclerview.widget.LinearLayoutManager$b):void");
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // androidx.recyclerview.widget.LinearLayoutManager
    public void n2(RecyclerView.v vVar, RecyclerView.z zVar, LinearLayoutManager.a aVar, int i) {
        super.n2(vVar, zVar, aVar, i);
        X2();
        if (zVar.b() > 0 && !zVar.e()) {
            L2(vVar, zVar, aVar, i);
        }
        M2();
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    public int t1(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        X2();
        M2();
        return super.t1(i, vVar, zVar);
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager, androidx.recyclerview.widget.RecyclerView.o
    public int v1(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        X2();
        M2();
        return super.v1(i, vVar, zVar);
    }

    @Override // androidx.recyclerview.widget.LinearLayoutManager
    public void x2(boolean z) {
        if (z) {
            throw new UnsupportedOperationException("GridLayoutManager does not support stack from end. Consider using reverse layout");
        }
        super.x2(false);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void z1(Rect rect, int i, int i2) {
        int m;
        int m2;
        if (this.J == null) {
            super.z1(rect, i, i2);
        }
        int c0 = c0() + d0();
        int e0 = e0() + b0();
        if (this.s == 1) {
            m2 = RecyclerView.o.m(i2, rect.height() + e0, Z());
            int[] iArr = this.J;
            m = RecyclerView.o.m(i, iArr[iArr.length - 1] + c0, a0());
        } else {
            m = RecyclerView.o.m(i, rect.width() + c0, a0());
            int[] iArr2 = this.J;
            m2 = RecyclerView.o.m(i2, iArr2[iArr2.length - 1] + e0, Z());
        }
        y1(m, m2);
    }
}
