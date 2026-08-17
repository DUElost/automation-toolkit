package androidx.recyclerview.widget;

import android.content.Context;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.View;
import android.view.accessibility.AccessibilityEvent;
import androidx.recyclerview.widget.RecyclerView;
import java.util.List;
/* loaded from: classes.dex */
public class LinearLayoutManager extends RecyclerView.o {
    int A;
    int B;
    private boolean C;
    SavedState D;
    final a E;
    private final b F;
    private int G;
    int s;
    private c t;
    i u;
    private boolean v;
    private boolean w;
    boolean x;
    private boolean y;
    private boolean z;

    /* loaded from: classes.dex */
    public static class SavedState implements Parcelable {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: b  reason: collision with root package name */
        int f1099b;

        /* renamed from: c  reason: collision with root package name */
        int f1100c;

        /* renamed from: d  reason: collision with root package name */
        boolean f1101d;

        /* loaded from: classes.dex */
        static class a implements Parcelable.Creator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel);
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: b */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        }

        public SavedState() {
        }

        SavedState(Parcel parcel) {
            this.f1099b = parcel.readInt();
            this.f1100c = parcel.readInt();
            this.f1101d = parcel.readInt() == 1;
        }

        public SavedState(SavedState savedState) {
            this.f1099b = savedState.f1099b;
            this.f1100c = savedState.f1100c;
            this.f1101d = savedState.f1101d;
        }

        boolean a() {
            return this.f1099b >= 0;
        }

        void b() {
            this.f1099b = -1;
        }

        @Override // android.os.Parcelable
        public int describeContents() {
            return 0;
        }

        @Override // android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            parcel.writeInt(this.f1099b);
            parcel.writeInt(this.f1100c);
            parcel.writeInt(this.f1101d ? 1 : 0);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a {

        /* renamed from: a  reason: collision with root package name */
        i f1102a;

        /* renamed from: b  reason: collision with root package name */
        int f1103b;

        /* renamed from: c  reason: collision with root package name */
        int f1104c;

        /* renamed from: d  reason: collision with root package name */
        boolean f1105d;
        boolean e;

        a() {
            e();
        }

        void a() {
            this.f1104c = this.f1105d ? this.f1102a.i() : this.f1102a.m();
        }

        public void b(View view, int i) {
            this.f1104c = this.f1105d ? this.f1102a.d(view) + this.f1102a.o() : this.f1102a.g(view);
            this.f1103b = i;
        }

        public void c(View view, int i) {
            int o = this.f1102a.o();
            if (o >= 0) {
                b(view, i);
                return;
            }
            this.f1103b = i;
            if (this.f1105d) {
                int i2 = (this.f1102a.i() - o) - this.f1102a.d(view);
                this.f1104c = this.f1102a.i() - i2;
                if (i2 > 0) {
                    int e = this.f1104c - this.f1102a.e(view);
                    int m = this.f1102a.m();
                    int min = e - (m + Math.min(this.f1102a.g(view) - m, 0));
                    if (min < 0) {
                        this.f1104c += Math.min(i2, -min);
                        return;
                    }
                    return;
                }
                return;
            }
            int g = this.f1102a.g(view);
            int m2 = g - this.f1102a.m();
            this.f1104c = g;
            if (m2 > 0) {
                int i3 = (this.f1102a.i() - Math.min(0, (this.f1102a.i() - o) - this.f1102a.d(view))) - (g + this.f1102a.e(view));
                if (i3 < 0) {
                    this.f1104c -= Math.min(m2, -i3);
                }
            }
        }

        boolean d(View view, RecyclerView.z zVar) {
            RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
            return !pVar.c() && pVar.a() >= 0 && pVar.a() < zVar.b();
        }

        void e() {
            this.f1103b = -1;
            this.f1104c = Integer.MIN_VALUE;
            this.f1105d = false;
            this.e = false;
        }

        public String toString() {
            return "AnchorInfo{mPosition=" + this.f1103b + ", mCoordinate=" + this.f1104c + ", mLayoutFromEnd=" + this.f1105d + ", mValid=" + this.e + '}';
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class b {

        /* renamed from: a  reason: collision with root package name */
        public int f1106a;

        /* renamed from: b  reason: collision with root package name */
        public boolean f1107b;

        /* renamed from: c  reason: collision with root package name */
        public boolean f1108c;

        /* renamed from: d  reason: collision with root package name */
        public boolean f1109d;

        protected b() {
        }

        void a() {
            this.f1106a = 0;
            this.f1107b = false;
            this.f1108c = false;
            this.f1109d = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class c {

        /* renamed from: b  reason: collision with root package name */
        int f1111b;

        /* renamed from: c  reason: collision with root package name */
        int f1112c;

        /* renamed from: d  reason: collision with root package name */
        int f1113d;
        int e;
        int f;
        int g;
        boolean i;
        int j;
        boolean l;

        /* renamed from: a  reason: collision with root package name */
        boolean f1110a = true;
        int h = 0;
        List<RecyclerView.c0> k = null;

        c() {
        }

        private View e() {
            int size = this.k.size();
            for (int i = 0; i < size; i++) {
                View view = this.k.get(i).f1123b;
                RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
                if (!pVar.c() && this.f1113d == pVar.a()) {
                    b(view);
                    return view;
                }
            }
            return null;
        }

        public void a() {
            b(null);
        }

        public void b(View view) {
            View f = f(view);
            this.f1113d = f == null ? -1 : ((RecyclerView.p) f.getLayoutParams()).a();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean c(RecyclerView.z zVar) {
            int i = this.f1113d;
            return i >= 0 && i < zVar.b();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public View d(RecyclerView.v vVar) {
            if (this.k != null) {
                return e();
            }
            View o = vVar.o(this.f1113d);
            this.f1113d += this.e;
            return o;
        }

        public View f(View view) {
            int a2;
            int size = this.k.size();
            View view2 = null;
            int i = Integer.MAX_VALUE;
            for (int i2 = 0; i2 < size; i2++) {
                View view3 = this.k.get(i2).f1123b;
                RecyclerView.p pVar = (RecyclerView.p) view3.getLayoutParams();
                if (view3 != view && !pVar.c() && (a2 = (pVar.a() - this.f1113d) * this.e) >= 0 && a2 < i) {
                    view2 = view3;
                    if (a2 == 0) {
                        break;
                    }
                    i = a2;
                }
            }
            return view2;
        }
    }

    public LinearLayoutManager(Context context) {
        this(context, 1, false);
    }

    public LinearLayoutManager(Context context, int i, boolean z) {
        this.s = 1;
        this.w = false;
        this.x = false;
        this.y = false;
        this.z = true;
        this.A = -1;
        this.B = Integer.MIN_VALUE;
        this.D = null;
        this.E = new a();
        this.F = new b();
        this.G = 2;
        v2(i);
        w2(z);
    }

    public LinearLayoutManager(Context context, AttributeSet attributeSet, int i, int i2) {
        this.s = 1;
        this.w = false;
        this.x = false;
        this.y = false;
        this.z = true;
        this.A = -1;
        this.B = Integer.MIN_VALUE;
        this.D = null;
        this.E = new a();
        this.F = new b();
        this.G = 2;
        RecyclerView.o.d g0 = RecyclerView.o.g0(context, attributeSet, i, i2);
        v2(g0.f1144a);
        w2(g0.f1146c);
        x2(g0.f1147d);
    }

    private void A2(RecyclerView.v vVar, RecyclerView.z zVar, a aVar) {
        if (z2(zVar, aVar) || y2(vVar, zVar, aVar)) {
            return;
        }
        aVar.a();
        aVar.f1103b = this.y ? zVar.b() - 1 : 0;
    }

    private void B2(int i, int i2, boolean z, RecyclerView.z zVar) {
        int m;
        this.t.l = s2();
        this.t.h = i2(zVar);
        c cVar = this.t;
        cVar.f = i;
        if (i == 1) {
            cVar.h += this.u.j();
            View g2 = g2();
            c cVar2 = this.t;
            cVar2.e = this.x ? -1 : 1;
            int f0 = f0(g2);
            c cVar3 = this.t;
            cVar2.f1113d = f0 + cVar3.e;
            cVar3.f1111b = this.u.d(g2);
            m = this.u.d(g2) - this.u.i();
        } else {
            View h2 = h2();
            this.t.h += this.u.m();
            c cVar4 = this.t;
            cVar4.e = this.x ? 1 : -1;
            int f02 = f0(h2);
            c cVar5 = this.t;
            cVar4.f1113d = f02 + cVar5.e;
            cVar5.f1111b = this.u.g(h2);
            m = (-this.u.g(h2)) + this.u.m();
        }
        c cVar6 = this.t;
        cVar6.f1112c = i2;
        if (z) {
            cVar6.f1112c = i2 - m;
        }
        cVar6.g = m;
    }

    private void C2(int i, int i2) {
        this.t.f1112c = this.u.i() - i2;
        c cVar = this.t;
        cVar.e = this.x ? -1 : 1;
        cVar.f1113d = i;
        cVar.f = 1;
        cVar.f1111b = i2;
        cVar.g = Integer.MIN_VALUE;
    }

    private void D2(a aVar) {
        C2(aVar.f1103b, aVar.f1104c);
    }

    private void E2(int i, int i2) {
        this.t.f1112c = i2 - this.u.m();
        c cVar = this.t;
        cVar.f1113d = i;
        cVar.e = this.x ? 1 : -1;
        cVar.f = -1;
        cVar.f1111b = i2;
        cVar.g = Integer.MIN_VALUE;
    }

    private void F2(a aVar) {
        E2(aVar.f1103b, aVar.f1104c);
    }

    private int I1(RecyclerView.z zVar) {
        if (I() == 0) {
            return 0;
        }
        N1();
        return k.a(zVar, this.u, S1(!this.z, true), R1(!this.z, true), this, this.z);
    }

    private int J1(RecyclerView.z zVar) {
        if (I() == 0) {
            return 0;
        }
        N1();
        return k.b(zVar, this.u, S1(!this.z, true), R1(!this.z, true), this, this.z, this.x);
    }

    private int K1(RecyclerView.z zVar) {
        if (I() == 0) {
            return 0;
        }
        N1();
        return k.c(zVar, this.u, S1(!this.z, true), R1(!this.z, true), this, this.z);
    }

    private View P1(RecyclerView.v vVar, RecyclerView.z zVar) {
        return X1(0, I());
    }

    private View Q1(RecyclerView.v vVar, RecyclerView.z zVar) {
        return b2(vVar, zVar, 0, I(), zVar.b());
    }

    private View R1(boolean z, boolean z2) {
        int I;
        int i;
        if (this.x) {
            I = 0;
            i = I();
        } else {
            I = I() - 1;
            i = -1;
        }
        return Y1(I, i, z, z2);
    }

    private View S1(boolean z, boolean z2) {
        int i;
        int I;
        if (this.x) {
            i = I() - 1;
            I = -1;
        } else {
            i = 0;
            I = I();
        }
        return Y1(i, I, z, z2);
    }

    private View U1(RecyclerView.v vVar, RecyclerView.z zVar) {
        return X1(I() - 1, -1);
    }

    private View V1(RecyclerView.v vVar, RecyclerView.z zVar) {
        return b2(vVar, zVar, I() - 1, -1, zVar.b());
    }

    private View Z1(RecyclerView.v vVar, RecyclerView.z zVar) {
        return this.x ? P1(vVar, zVar) : U1(vVar, zVar);
    }

    private View a2(RecyclerView.v vVar, RecyclerView.z zVar) {
        return this.x ? U1(vVar, zVar) : P1(vVar, zVar);
    }

    private View c2(RecyclerView.v vVar, RecyclerView.z zVar) {
        return this.x ? Q1(vVar, zVar) : V1(vVar, zVar);
    }

    private View d2(RecyclerView.v vVar, RecyclerView.z zVar) {
        return this.x ? V1(vVar, zVar) : Q1(vVar, zVar);
    }

    private int e2(int i, RecyclerView.v vVar, RecyclerView.z zVar, boolean z) {
        int i2;
        int i3 = this.u.i() - i;
        if (i3 > 0) {
            int i4 = -u2(-i3, vVar, zVar);
            int i5 = i + i4;
            if (!z || (i2 = this.u.i() - i5) <= 0) {
                return i4;
            }
            this.u.r(i2);
            return i2 + i4;
        }
        return 0;
    }

    private int f2(int i, RecyclerView.v vVar, RecyclerView.z zVar, boolean z) {
        int m;
        int m2 = i - this.u.m();
        if (m2 > 0) {
            int i2 = -u2(m2, vVar, zVar);
            int i3 = i + i2;
            if (!z || (m = i3 - this.u.m()) <= 0) {
                return i2;
            }
            this.u.r(-m);
            return i2 - m;
        }
        return 0;
    }

    private View g2() {
        return H(this.x ? 0 : I() - 1);
    }

    private View h2() {
        return H(this.x ? I() - 1 : 0);
    }

    private void m2(RecyclerView.v vVar, RecyclerView.z zVar, int i, int i2) {
        if (!zVar.g() || I() == 0 || zVar.e() || !G1()) {
            return;
        }
        List<RecyclerView.c0> k = vVar.k();
        int size = k.size();
        int f0 = f0(H(0));
        int i3 = 0;
        int i4 = 0;
        for (int i5 = 0; i5 < size; i5++) {
            RecyclerView.c0 c0Var = k.get(i5);
            if (!c0Var.v()) {
                boolean z = (c0Var.m() < f0) != this.x ? true : true;
                int e = this.u.e(c0Var.f1123b);
                if (z) {
                    i3 += e;
                } else {
                    i4 += e;
                }
            }
        }
        this.t.k = k;
        if (i3 > 0) {
            E2(f0(h2()), i);
            c cVar = this.t;
            cVar.h = i3;
            cVar.f1112c = 0;
            cVar.a();
            O1(vVar, this.t, zVar, false);
        }
        if (i4 > 0) {
            C2(f0(g2()), i2);
            c cVar2 = this.t;
            cVar2.h = i4;
            cVar2.f1112c = 0;
            cVar2.a();
            O1(vVar, this.t, zVar, false);
        }
        this.t.k = null;
    }

    private void o2(RecyclerView.v vVar, c cVar) {
        if (!cVar.f1110a || cVar.l) {
            return;
        }
        int i = cVar.f;
        int i2 = cVar.g;
        if (i == -1) {
            q2(vVar, i2);
        } else {
            r2(vVar, i2);
        }
    }

    private void p2(RecyclerView.v vVar, int i, int i2) {
        if (i == i2) {
            return;
        }
        if (i2 <= i) {
            while (i > i2) {
                k1(i, vVar);
                i--;
            }
            return;
        }
        for (int i3 = i2 - 1; i3 >= i; i3--) {
            k1(i3, vVar);
        }
    }

    private void q2(RecyclerView.v vVar, int i) {
        int I = I();
        if (i < 0) {
            return;
        }
        int h = this.u.h() - i;
        if (this.x) {
            for (int i2 = 0; i2 < I; i2++) {
                View H = H(i2);
                if (this.u.g(H) < h || this.u.q(H) < h) {
                    p2(vVar, 0, i2);
                    return;
                }
            }
            return;
        }
        int i3 = I - 1;
        for (int i4 = i3; i4 >= 0; i4--) {
            View H2 = H(i4);
            if (this.u.g(H2) < h || this.u.q(H2) < h) {
                p2(vVar, i3, i4);
                return;
            }
        }
    }

    private void r2(RecyclerView.v vVar, int i) {
        if (i < 0) {
            return;
        }
        int I = I();
        if (!this.x) {
            for (int i2 = 0; i2 < I; i2++) {
                View H = H(i2);
                if (this.u.d(H) > i || this.u.p(H) > i) {
                    p2(vVar, 0, i2);
                    return;
                }
            }
            return;
        }
        int i3 = I - 1;
        for (int i4 = i3; i4 >= 0; i4--) {
            View H2 = H(i4);
            if (this.u.d(H2) > i || this.u.p(H2) > i) {
                p2(vVar, i3, i4);
                return;
            }
        }
    }

    private void t2() {
        this.x = (this.s == 1 || !k2()) ? this.w : !this.w;
    }

    private boolean y2(RecyclerView.v vVar, RecyclerView.z zVar, a aVar) {
        boolean z = false;
        if (I() == 0) {
            return false;
        }
        View U = U();
        if (U != null && aVar.d(U, zVar)) {
            aVar.c(U, f0(U));
            return true;
        } else if (this.v != this.y) {
            return false;
        } else {
            View c2 = aVar.f1105d ? c2(vVar, zVar) : d2(vVar, zVar);
            if (c2 != null) {
                aVar.b(c2, f0(c2));
                if (!zVar.e() && G1()) {
                    if (this.u.g(c2) >= this.u.i() || this.u.d(c2) < this.u.m()) {
                        z = true;
                    }
                    if (z) {
                        aVar.f1104c = aVar.f1105d ? this.u.i() : this.u.m();
                    }
                }
                return true;
            }
            return false;
        }
    }

    private boolean z2(RecyclerView.z zVar, a aVar) {
        int i;
        if (!zVar.e() && (i = this.A) != -1) {
            if (i >= 0 && i < zVar.b()) {
                aVar.f1103b = this.A;
                SavedState savedState = this.D;
                if (savedState != null && savedState.a()) {
                    boolean z = this.D.f1101d;
                    aVar.f1105d = z;
                    aVar.f1104c = z ? this.u.i() - this.D.f1100c : this.u.m() + this.D.f1100c;
                    return true;
                } else if (this.B != Integer.MIN_VALUE) {
                    boolean z2 = this.x;
                    aVar.f1105d = z2;
                    aVar.f1104c = z2 ? this.u.i() - this.B : this.u.m() + this.B;
                    return true;
                } else {
                    View B = B(this.A);
                    if (B == null) {
                        if (I() > 0) {
                            aVar.f1105d = (this.A < f0(H(0))) == this.x;
                        }
                        aVar.a();
                    } else if (this.u.e(B) > this.u.n()) {
                        aVar.a();
                        return true;
                    } else if (this.u.g(B) - this.u.m() < 0) {
                        aVar.f1104c = this.u.m();
                        aVar.f1105d = false;
                        return true;
                    } else if (this.u.i() - this.u.d(B) < 0) {
                        aVar.f1104c = this.u.i();
                        aVar.f1105d = true;
                        return true;
                    } else {
                        aVar.f1104c = aVar.f1105d ? this.u.d(B) + this.u.o() : this.u.g(B);
                    }
                    return true;
                }
            }
            this.A = -1;
            this.B = Integer.MIN_VALUE;
        }
        return false;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public View B(int i) {
        int I = I();
        if (I == 0) {
            return null;
        }
        int f0 = i - f0(H(0));
        if (f0 >= 0 && f0 < I) {
            View H = H(f0);
            if (f0(H) == i) {
                return H;
            }
        }
        return super.B(i);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public RecyclerView.p C() {
        return new RecyclerView.p(-2, -2);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    boolean D1() {
        return (W() == 1073741824 || n0() == 1073741824 || !o0()) ? false : true;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void G0(RecyclerView recyclerView, RecyclerView.v vVar) {
        super.G0(recyclerView, vVar);
        if (this.C) {
            h1(vVar);
            vVar.c();
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean G1() {
        return this.D == null && this.v == this.y;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public View H0(View view, int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        int L1;
        t2();
        if (I() == 0 || (L1 = L1(i)) == Integer.MIN_VALUE) {
            return null;
        }
        N1();
        N1();
        B2(L1, (int) (this.u.n() * 0.33333334f), false, zVar);
        c cVar = this.t;
        cVar.g = Integer.MIN_VALUE;
        cVar.f1110a = false;
        O1(vVar, cVar, zVar, true);
        View a2 = L1 == -1 ? a2(vVar, zVar) : Z1(vVar, zVar);
        View h2 = L1 == -1 ? h2() : g2();
        if (h2.hasFocusable()) {
            if (a2 == null) {
                return null;
            }
            return h2;
        }
        return a2;
    }

    void H1(RecyclerView.z zVar, c cVar, RecyclerView.o.c cVar2) {
        int i = cVar.f1113d;
        if (i < 0 || i >= zVar.b()) {
            return;
        }
        cVar2.a(i, Math.max(0, cVar.g));
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void I0(AccessibilityEvent accessibilityEvent) {
        super.I0(accessibilityEvent);
        if (I() > 0) {
            accessibilityEvent.setFromIndex(T1());
            accessibilityEvent.setToIndex(W1());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int L1(int i) {
        return i != 1 ? i != 2 ? i != 17 ? i != 33 ? i != 66 ? (i == 130 && this.s == 1) ? 1 : Integer.MIN_VALUE : this.s == 0 ? 1 : Integer.MIN_VALUE : this.s == 1 ? -1 : Integer.MIN_VALUE : this.s == 0 ? -1 : Integer.MIN_VALUE : (this.s != 1 && k2()) ? -1 : 1 : (this.s != 1 && k2()) ? 1 : -1;
    }

    c M1() {
        return new c();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void N1() {
        if (this.t == null) {
            this.t = M1();
        }
    }

    int O1(RecyclerView.v vVar, c cVar, RecyclerView.z zVar, boolean z) {
        int i = cVar.f1112c;
        int i2 = cVar.g;
        if (i2 != Integer.MIN_VALUE) {
            if (i < 0) {
                cVar.g = i2 + i;
            }
            o2(vVar, cVar);
        }
        int i3 = cVar.f1112c + cVar.h;
        b bVar = this.F;
        while (true) {
            if ((!cVar.l && i3 <= 0) || !cVar.c(zVar)) {
                break;
            }
            bVar.a();
            l2(vVar, zVar, cVar, bVar);
            if (!bVar.f1107b) {
                cVar.f1111b += bVar.f1106a * cVar.f;
                if (!bVar.f1108c || this.t.k != null || !zVar.e()) {
                    int i4 = cVar.f1112c;
                    int i5 = bVar.f1106a;
                    cVar.f1112c = i4 - i5;
                    i3 -= i5;
                }
                int i6 = cVar.g;
                if (i6 != Integer.MIN_VALUE) {
                    int i7 = i6 + bVar.f1106a;
                    cVar.g = i7;
                    int i8 = cVar.f1112c;
                    if (i8 < 0) {
                        cVar.g = i7 + i8;
                    }
                    o2(vVar, cVar);
                }
                if (z && bVar.f1109d) {
                    break;
                }
            } else {
                break;
            }
        }
        return i - cVar.f1112c;
    }

    public int T1() {
        View Y1 = Y1(0, I(), false, true);
        if (Y1 == null) {
            return -1;
        }
        return f0(Y1);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void V0(RecyclerView.v vVar, RecyclerView.z zVar) {
        int i;
        int i2;
        int i3;
        int i4;
        int i5;
        int e2;
        int i6;
        View B;
        int g;
        int i7;
        int i8 = -1;
        if (!(this.D == null && this.A == -1) && zVar.b() == 0) {
            h1(vVar);
            return;
        }
        SavedState savedState = this.D;
        if (savedState != null && savedState.a()) {
            this.A = this.D.f1099b;
        }
        N1();
        this.t.f1110a = false;
        t2();
        View U = U();
        a aVar = this.E;
        if (!aVar.e || this.A != -1 || this.D != null) {
            aVar.e();
            a aVar2 = this.E;
            aVar2.f1105d = this.x ^ this.y;
            A2(vVar, zVar, aVar2);
            this.E.e = true;
        } else if (U != null && (this.u.g(U) >= this.u.i() || this.u.d(U) <= this.u.m())) {
            this.E.c(U, f0(U));
        }
        int i22 = i2(zVar);
        if (this.t.j >= 0) {
            i = i22;
            i22 = 0;
        } else {
            i = 0;
        }
        int m = i22 + this.u.m();
        int j = i + this.u.j();
        if (zVar.e() && (i6 = this.A) != -1 && this.B != Integer.MIN_VALUE && (B = B(i6)) != null) {
            if (this.x) {
                i7 = this.u.i() - this.u.d(B);
                g = this.B;
            } else {
                g = this.u.g(B) - this.u.m();
                i7 = this.B;
            }
            int i9 = i7 - g;
            if (i9 > 0) {
                m += i9;
            } else {
                j -= i9;
            }
        }
        a aVar3 = this.E;
        if (!aVar3.f1105d ? !this.x : this.x) {
            i8 = 1;
        }
        n2(vVar, zVar, aVar3, i8);
        v(vVar);
        this.t.l = s2();
        this.t.i = zVar.e();
        a aVar4 = this.E;
        if (aVar4.f1105d) {
            F2(aVar4);
            c cVar = this.t;
            cVar.h = m;
            O1(vVar, cVar, zVar, false);
            c cVar2 = this.t;
            i3 = cVar2.f1111b;
            int i10 = cVar2.f1113d;
            int i11 = cVar2.f1112c;
            if (i11 > 0) {
                j += i11;
            }
            D2(this.E);
            c cVar3 = this.t;
            cVar3.h = j;
            cVar3.f1113d += cVar3.e;
            O1(vVar, cVar3, zVar, false);
            c cVar4 = this.t;
            i2 = cVar4.f1111b;
            int i12 = cVar4.f1112c;
            if (i12 > 0) {
                E2(i10, i3);
                c cVar5 = this.t;
                cVar5.h = i12;
                O1(vVar, cVar5, zVar, false);
                i3 = this.t.f1111b;
            }
        } else {
            D2(aVar4);
            c cVar6 = this.t;
            cVar6.h = j;
            O1(vVar, cVar6, zVar, false);
            c cVar7 = this.t;
            i2 = cVar7.f1111b;
            int i13 = cVar7.f1113d;
            int i14 = cVar7.f1112c;
            if (i14 > 0) {
                m += i14;
            }
            F2(this.E);
            c cVar8 = this.t;
            cVar8.h = m;
            cVar8.f1113d += cVar8.e;
            O1(vVar, cVar8, zVar, false);
            c cVar9 = this.t;
            i3 = cVar9.f1111b;
            int i15 = cVar9.f1112c;
            if (i15 > 0) {
                C2(i13, i2);
                c cVar10 = this.t;
                cVar10.h = i15;
                O1(vVar, cVar10, zVar, false);
                i2 = this.t.f1111b;
            }
        }
        if (I() > 0) {
            if (this.x ^ this.y) {
                int e22 = e2(i2, vVar, zVar, true);
                i4 = i3 + e22;
                i5 = i2 + e22;
                e2 = f2(i4, vVar, zVar, false);
            } else {
                int f2 = f2(i3, vVar, zVar, true);
                i4 = i3 + f2;
                i5 = i2 + f2;
                e2 = e2(i5, vVar, zVar, false);
            }
            i3 = i4 + e2;
            i2 = i5 + e2;
        }
        m2(vVar, zVar, i3, i2);
        if (zVar.e()) {
            this.E.e();
        } else {
            this.u.s();
        }
        this.v = this.y;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void W0(RecyclerView.z zVar) {
        super.W0(zVar);
        this.D = null;
        this.A = -1;
        this.B = Integer.MIN_VALUE;
        this.E.e();
    }

    public int W1() {
        View Y1 = Y1(I() - 1, -1, false, true);
        if (Y1 == null) {
            return -1;
        }
        return f0(Y1);
    }

    View X1(int i, int i2) {
        int i3;
        int i4;
        N1();
        if ((i2 > i ? (char) 1 : i2 < i ? (char) 65535 : (char) 0) == 0) {
            return H(i);
        }
        if (this.u.g(H(i)) < this.u.m()) {
            i3 = 16644;
            i4 = 16388;
        } else {
            i3 = 4161;
            i4 = 4097;
        }
        return (this.s == 0 ? this.e : this.f).a(i, i2, i3, i4);
    }

    View Y1(int i, int i2, boolean z, boolean z2) {
        N1();
        return (this.s == 0 ? this.e : this.f).a(i, i2, z ? 24579 : 320, z2 ? 320 : 0);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void a1(Parcelable parcelable) {
        if (parcelable instanceof SavedState) {
            this.D = (SavedState) parcelable;
            q1();
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public Parcelable b1() {
        if (this.D != null) {
            return new SavedState(this.D);
        }
        SavedState savedState = new SavedState();
        if (I() > 0) {
            N1();
            boolean z = this.v ^ this.x;
            savedState.f1101d = z;
            if (z) {
                View g2 = g2();
                savedState.f1100c = this.u.i() - this.u.d(g2);
                savedState.f1099b = f0(g2);
            } else {
                View h2 = h2();
                savedState.f1099b = f0(h2);
                savedState.f1100c = this.u.g(h2) - this.u.m();
            }
        } else {
            savedState.b();
        }
        return savedState;
    }

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
            if (f0 >= 0 && f0 < i3) {
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
    public void f(String str) {
        if (this.D == null) {
            super.f(str);
        }
    }

    protected int i2(RecyclerView.z zVar) {
        if (zVar.d()) {
            return this.u.n();
        }
        return 0;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean j() {
        return this.s == 0;
    }

    public int j2() {
        return this.s;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean k() {
        return this.s == 1;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public boolean k2() {
        return X() == 1;
    }

    void l2(RecyclerView.v vVar, RecyclerView.z zVar, c cVar, b bVar) {
        int i;
        int i2;
        int i3;
        int i4;
        int f;
        View d2 = cVar.d(vVar);
        if (d2 == null) {
            bVar.f1107b = true;
            return;
        }
        RecyclerView.p pVar = (RecyclerView.p) d2.getLayoutParams();
        if (cVar.k == null) {
            if (this.x == (cVar.f == -1)) {
                c(d2);
            } else {
                d(d2, 0);
            }
        } else {
            if (this.x == (cVar.f == -1)) {
                a(d2);
            } else {
                b(d2, 0);
            }
        }
        y0(d2, 0, 0);
        bVar.f1106a = this.u.e(d2);
        if (this.s == 1) {
            if (k2()) {
                f = m0() - d0();
                i4 = f - this.u.f(d2);
            } else {
                i4 = c0();
                f = this.u.f(d2) + i4;
            }
            int i5 = cVar.f;
            int i6 = cVar.f1111b;
            if (i5 == -1) {
                i3 = i6;
                i2 = f;
                i = i6 - bVar.f1106a;
            } else {
                i = i6;
                i2 = f;
                i3 = bVar.f1106a + i6;
            }
        } else {
            int e0 = e0();
            int f2 = this.u.f(d2) + e0;
            int i7 = cVar.f;
            int i8 = cVar.f1111b;
            if (i7 == -1) {
                i2 = i8;
                i = e0;
                i3 = f2;
                i4 = i8 - bVar.f1106a;
            } else {
                i = e0;
                i2 = bVar.f1106a + i8;
                i3 = f2;
                i4 = i8;
            }
        }
        x0(d2, i4, i, i2, i3);
        if (pVar.c() || pVar.b()) {
            bVar.f1108c = true;
        }
        bVar.f1109d = d2.hasFocusable();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void n(int i, int i2, RecyclerView.z zVar, RecyclerView.o.c cVar) {
        if (this.s != 0) {
            i = i2;
        }
        if (I() == 0 || i == 0) {
            return;
        }
        N1();
        B2(i > 0 ? 1 : -1, Math.abs(i), true, zVar);
        H1(zVar, this.t, cVar);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void n2(RecyclerView.v vVar, RecyclerView.z zVar, a aVar, int i) {
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void o(int i, RecyclerView.o.c cVar) {
        boolean z;
        int i2;
        SavedState savedState = this.D;
        if (savedState == null || !savedState.a()) {
            t2();
            z = this.x;
            i2 = this.A;
            if (i2 == -1) {
                i2 = z ? i - 1 : 0;
            }
        } else {
            SavedState savedState2 = this.D;
            z = savedState2.f1101d;
            i2 = savedState2.f1099b;
        }
        int i3 = z ? -1 : 1;
        for (int i4 = 0; i4 < this.G && i2 >= 0 && i2 < i; i4++) {
            cVar.a(i2, 0);
            i2 += i3;
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int p(RecyclerView.z zVar) {
        return I1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int q(RecyclerView.z zVar) {
        return J1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public boolean q0() {
        return true;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int r(RecyclerView.z zVar) {
        return K1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int s(RecyclerView.z zVar) {
        return I1(zVar);
    }

    boolean s2() {
        return this.u.k() == 0 && this.u.h() == 0;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int t(RecyclerView.z zVar) {
        return J1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int t1(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        if (this.s == 1) {
            return 0;
        }
        return u2(i, vVar, zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int u(RecyclerView.z zVar) {
        return K1(zVar);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public void u1(int i) {
        this.A = i;
        this.B = Integer.MIN_VALUE;
        SavedState savedState = this.D;
        if (savedState != null) {
            savedState.b();
        }
        q1();
    }

    int u2(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        if (I() == 0 || i == 0) {
            return 0;
        }
        this.t.f1110a = true;
        N1();
        int i2 = i > 0 ? 1 : -1;
        int abs = Math.abs(i);
        B2(i2, abs, true, zVar);
        c cVar = this.t;
        int O1 = cVar.g + O1(vVar, cVar, zVar, false);
        if (O1 < 0) {
            return 0;
        }
        if (abs > O1) {
            i = i2 * O1;
        }
        this.u.r(-i);
        this.t.j = i;
        return i;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.o
    public int v1(int i, RecyclerView.v vVar, RecyclerView.z zVar) {
        if (this.s == 0) {
            return 0;
        }
        return u2(i, vVar, zVar);
    }

    public void v2(int i) {
        if (i != 0 && i != 1) {
            throw new IllegalArgumentException("invalid orientation:" + i);
        }
        f(null);
        if (i != this.s || this.u == null) {
            i b2 = i.b(this, i);
            this.u = b2;
            this.E.f1102a = b2;
            this.s = i;
            q1();
        }
    }

    public void w2(boolean z) {
        f(null);
        if (z == this.w) {
            return;
        }
        this.w = z;
        q1();
    }

    public void x2(boolean z) {
        f(null);
        if (this.y == z) {
            return;
        }
        this.y = z;
        q1();
    }
}
