package androidx.recyclerview.widget;

import android.graphics.Rect;
import android.view.View;
import android.view.ViewGroup;
import androidx.recyclerview.widget.RecyclerView;
/* loaded from: classes.dex */
public abstract class i {

    /* renamed from: a  reason: collision with root package name */
    protected final RecyclerView.o f1260a;

    /* renamed from: b  reason: collision with root package name */
    private int f1261b;

    /* renamed from: c  reason: collision with root package name */
    final Rect f1262c;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a extends i {
        a(RecyclerView.o oVar) {
            super(oVar, null);
        }

        @Override // androidx.recyclerview.widget.i
        public int d(View view) {
            return this.f1260a.S(view) + ((ViewGroup.MarginLayoutParams) ((RecyclerView.p) view.getLayoutParams())).rightMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int e(View view) {
            RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
            return this.f1260a.R(view) + ((ViewGroup.MarginLayoutParams) pVar).leftMargin + ((ViewGroup.MarginLayoutParams) pVar).rightMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int f(View view) {
            RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
            return this.f1260a.Q(view) + ((ViewGroup.MarginLayoutParams) pVar).topMargin + ((ViewGroup.MarginLayoutParams) pVar).bottomMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int g(View view) {
            return this.f1260a.P(view) - ((ViewGroup.MarginLayoutParams) ((RecyclerView.p) view.getLayoutParams())).leftMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int h() {
            return this.f1260a.m0();
        }

        @Override // androidx.recyclerview.widget.i
        public int i() {
            return this.f1260a.m0() - this.f1260a.d0();
        }

        @Override // androidx.recyclerview.widget.i
        public int j() {
            return this.f1260a.d0();
        }

        @Override // androidx.recyclerview.widget.i
        public int k() {
            return this.f1260a.n0();
        }

        @Override // androidx.recyclerview.widget.i
        public int l() {
            return this.f1260a.W();
        }

        @Override // androidx.recyclerview.widget.i
        public int m() {
            return this.f1260a.c0();
        }

        @Override // androidx.recyclerview.widget.i
        public int n() {
            return (this.f1260a.m0() - this.f1260a.c0()) - this.f1260a.d0();
        }

        @Override // androidx.recyclerview.widget.i
        public int p(View view) {
            this.f1260a.l0(view, true, this.f1262c);
            return this.f1262c.right;
        }

        @Override // androidx.recyclerview.widget.i
        public int q(View view) {
            this.f1260a.l0(view, true, this.f1262c);
            return this.f1262c.left;
        }

        @Override // androidx.recyclerview.widget.i
        public void r(int i) {
            this.f1260a.A0(i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b extends i {
        b(RecyclerView.o oVar) {
            super(oVar, null);
        }

        @Override // androidx.recyclerview.widget.i
        public int d(View view) {
            return this.f1260a.N(view) + ((ViewGroup.MarginLayoutParams) ((RecyclerView.p) view.getLayoutParams())).bottomMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int e(View view) {
            RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
            return this.f1260a.Q(view) + ((ViewGroup.MarginLayoutParams) pVar).topMargin + ((ViewGroup.MarginLayoutParams) pVar).bottomMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int f(View view) {
            RecyclerView.p pVar = (RecyclerView.p) view.getLayoutParams();
            return this.f1260a.R(view) + ((ViewGroup.MarginLayoutParams) pVar).leftMargin + ((ViewGroup.MarginLayoutParams) pVar).rightMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int g(View view) {
            return this.f1260a.T(view) - ((ViewGroup.MarginLayoutParams) ((RecyclerView.p) view.getLayoutParams())).topMargin;
        }

        @Override // androidx.recyclerview.widget.i
        public int h() {
            return this.f1260a.V();
        }

        @Override // androidx.recyclerview.widget.i
        public int i() {
            return this.f1260a.V() - this.f1260a.b0();
        }

        @Override // androidx.recyclerview.widget.i
        public int j() {
            return this.f1260a.b0();
        }

        @Override // androidx.recyclerview.widget.i
        public int k() {
            return this.f1260a.W();
        }

        @Override // androidx.recyclerview.widget.i
        public int l() {
            return this.f1260a.n0();
        }

        @Override // androidx.recyclerview.widget.i
        public int m() {
            return this.f1260a.e0();
        }

        @Override // androidx.recyclerview.widget.i
        public int n() {
            return (this.f1260a.V() - this.f1260a.e0()) - this.f1260a.b0();
        }

        @Override // androidx.recyclerview.widget.i
        public int p(View view) {
            this.f1260a.l0(view, true, this.f1262c);
            return this.f1262c.bottom;
        }

        @Override // androidx.recyclerview.widget.i
        public int q(View view) {
            this.f1260a.l0(view, true, this.f1262c);
            return this.f1262c.top;
        }

        @Override // androidx.recyclerview.widget.i
        public void r(int i) {
            this.f1260a.B0(i);
        }
    }

    private i(RecyclerView.o oVar) {
        this.f1261b = Integer.MIN_VALUE;
        this.f1262c = new Rect();
        this.f1260a = oVar;
    }

    /* synthetic */ i(RecyclerView.o oVar, a aVar) {
        this(oVar);
    }

    public static i a(RecyclerView.o oVar) {
        return new a(oVar);
    }

    public static i b(RecyclerView.o oVar, int i) {
        if (i != 0) {
            if (i == 1) {
                return c(oVar);
            }
            throw new IllegalArgumentException("invalid orientation");
        }
        return a(oVar);
    }

    public static i c(RecyclerView.o oVar) {
        return new b(oVar);
    }

    public abstract int d(View view);

    public abstract int e(View view);

    public abstract int f(View view);

    public abstract int g(View view);

    public abstract int h();

    public abstract int i();

    public abstract int j();

    public abstract int k();

    public abstract int l();

    public abstract int m();

    public abstract int n();

    public int o() {
        if (Integer.MIN_VALUE == this.f1261b) {
            return 0;
        }
        return n() - this.f1261b;
    }

    public abstract int p(View view);

    public abstract int q(View view);

    public abstract void r(int i);

    public void s() {
        this.f1261b = n();
    }
}
