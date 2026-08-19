package androidx.recyclerview.widget;

import a.f.l.a0.c;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.database.Observable;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.util.Log;
import android.util.SparseArray;
import android.view.Display;
import android.view.FocusFinder;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.accessibility.AccessibilityEvent;
import android.view.accessibility.AccessibilityManager;
import android.view.animation.Interpolator;
import android.widget.EdgeEffect;
import android.widget.OverScroller;
import androidx.customview.view.AbsSavedState;
import androidx.recyclerview.widget.a;
import androidx.recyclerview.widget.b;
import androidx.recyclerview.widget.f;
import androidx.recyclerview.widget.m;
import androidx.recyclerview.widget.n;
import java.lang.ref.WeakReference;
import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public class RecyclerView extends ViewGroup implements a.f.l.i {
    private static final int[] A0 = {16843830};
    private static final int[] B0 = {16842987};
    static final boolean C0;
    static final boolean D0;
    static final boolean E0;
    static final boolean F0;
    private static final boolean G0;
    private static final boolean H0;
    private static final Class<?>[] I0;
    static final Interpolator J0;
    private int A;
    boolean B;
    private final AccessibilityManager C;
    private List<q> D;
    boolean E;
    boolean F;
    private int G;
    private int H;
    private k I;
    private EdgeEffect J;
    private EdgeEffect K;
    private EdgeEffect L;
    private EdgeEffect M;
    l N;
    private int O;
    private int P;
    private VelocityTracker Q;
    private int R;
    private int S;
    private int T;
    private int U;
    private int V;
    private r W;
    private final int a0;

    /* renamed from: b  reason: collision with root package name */
    private final x f1114b;
    private final int b0;

    /* renamed from: c  reason: collision with root package name */
    final v f1115c;
    private float c0;

    /* renamed from: d  reason: collision with root package name */
    private SavedState f1116d;
    private float d0;
    androidx.recyclerview.widget.a e;
    private boolean e0;
    androidx.recyclerview.widget.b f;
    final b0 f0;
    final androidx.recyclerview.widget.n g;
    androidx.recyclerview.widget.f g0;
    boolean h;
    f.b h0;
    final Runnable i;
    final z i0;
    final Rect j;
    private t j0;
    private final Rect k;
    private List<t> k0;
    final RectF l;
    boolean l0;
    g m;
    boolean m0;
    o n;
    private l.b n0;
    w o;
    boolean o0;
    final ArrayList<n> p;
    androidx.recyclerview.widget.j p0;
    private final ArrayList<s> q;
    private j q0;
    private s r;
    private final int[] r0;
    boolean s;
    private a.f.l.k s0;
    boolean t;
    private final int[] t0;
    boolean u;
    final int[] u0;
    boolean v;
    private final int[] v0;
    private int w;
    final int[] w0;
    boolean x;
    final List<c0> x0;
    boolean y;
    private Runnable y0;
    private boolean z;
    private final n.b z0;

    /* loaded from: classes.dex */
    public static class SavedState extends AbsSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: d  reason: collision with root package name */
        Parcelable f1117d;

        /* loaded from: classes.dex */
        static class a implements Parcelable.ClassLoaderCreator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel, null);
            }

            @Override // android.os.Parcelable.ClassLoaderCreator
            /* renamed from: b */
            public SavedState createFromParcel(Parcel parcel, ClassLoader classLoader) {
                return new SavedState(parcel, classLoader);
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: c */
            public SavedState[] newArray(int i) {
                return new SavedState[i];
            }
        }

        SavedState(Parcel parcel, ClassLoader classLoader) {
            super(parcel, classLoader);
            this.f1117d = parcel.readParcelable(classLoader == null ? o.class.getClassLoader() : classLoader);
        }

        SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        void b(SavedState savedState) {
            this.f1117d = savedState.f1117d;
        }

        @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeParcelable(this.f1117d, 0);
        }
    }

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            RecyclerView recyclerView = RecyclerView.this;
            if (!recyclerView.v || recyclerView.isLayoutRequested()) {
                return;
            }
            RecyclerView recyclerView2 = RecyclerView.this;
            if (!recyclerView2.s) {
                recyclerView2.requestLayout();
            } else if (recyclerView2.y) {
                recyclerView2.x = true;
            } else {
                recyclerView2.v();
            }
        }
    }

    /* loaded from: classes.dex */
    public static abstract class a0 {
        public abstract View a(v vVar, int i, int i2);
    }

    /* loaded from: classes.dex */
    class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            l lVar = RecyclerView.this.N;
            if (lVar != null) {
                lVar.u();
            }
            RecyclerView.this.o0 = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b0 implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private int f1120b;

        /* renamed from: c  reason: collision with root package name */
        private int f1121c;

        /* renamed from: d  reason: collision with root package name */
        OverScroller f1122d;
        Interpolator e;
        private boolean f;
        private boolean g;

        b0() {
            Interpolator interpolator = RecyclerView.J0;
            this.e = interpolator;
            this.f = false;
            this.g = false;
            this.f1122d = new OverScroller(RecyclerView.this.getContext(), interpolator);
        }

        private int a(int i, int i2, int i3, int i4) {
            int i5;
            int abs = Math.abs(i);
            int abs2 = Math.abs(i2);
            boolean z = abs > abs2;
            int sqrt = (int) Math.sqrt((i3 * i3) + (i4 * i4));
            int sqrt2 = (int) Math.sqrt((i * i) + (i2 * i2));
            RecyclerView recyclerView = RecyclerView.this;
            int width = z ? recyclerView.getWidth() : recyclerView.getHeight();
            int i6 = width / 2;
            float f = width;
            float f2 = i6;
            float c2 = f2 + (c(Math.min(1.0f, (sqrt2 * 1.0f) / f)) * f2);
            if (sqrt > 0) {
                i5 = Math.round(Math.abs(c2 / sqrt) * 1000.0f) * 4;
            } else {
                if (!z) {
                    abs = abs2;
                }
                i5 = (int) (((abs / f) + 1.0f) * 300.0f);
            }
            return Math.min(i5, 2000);
        }

        private void b() {
            this.g = false;
            this.f = true;
        }

        private float c(float f) {
            return (float) Math.sin((f - 0.5f) * 0.47123894f);
        }

        private void d() {
            this.f = false;
            if (this.g) {
                f();
            }
        }

        public void e(int i, int i2) {
            RecyclerView.this.setScrollState(2);
            this.f1121c = 0;
            this.f1120b = 0;
            this.f1122d.fling(0, 0, i, i2, Integer.MIN_VALUE, Integer.MAX_VALUE, Integer.MIN_VALUE, Integer.MAX_VALUE);
            f();
        }

        void f() {
            if (this.f) {
                this.g = true;
                return;
            }
            RecyclerView.this.removeCallbacks(this);
            a.f.l.r.L(RecyclerView.this, this);
        }

        public void g(int i, int i2, int i3, Interpolator interpolator) {
            if (this.e != interpolator) {
                this.e = interpolator;
                this.f1122d = new OverScroller(RecyclerView.this.getContext(), interpolator);
            }
            RecyclerView.this.setScrollState(2);
            this.f1121c = 0;
            this.f1120b = 0;
            this.f1122d.startScroll(0, 0, i, i2, i3);
            if (Build.VERSION.SDK_INT < 23) {
                this.f1122d.computeScrollOffset();
            }
            f();
        }

        public void h(int i, int i2, Interpolator interpolator) {
            int a2 = a(i, i2, 0, 0);
            if (interpolator == null) {
                interpolator = RecyclerView.J0;
            }
            g(i, i2, a2, interpolator);
        }

        public void i() {
            RecyclerView.this.removeCallbacks(this);
            this.f1122d.abortAnimation();
        }

        /* JADX WARN: Code restructure failed: missing block: B:48:0x00e6, code lost:
            if (r9 > 0) goto L44;
         */
        /* JADX WARN: Removed duplicated region for block: B:46:0x00e2  */
        /* JADX WARN: Removed duplicated region for block: B:53:0x00f2  */
        /* JADX WARN: Removed duplicated region for block: B:55:0x00f9 A[ADDED_TO_REGION] */
        @Override // java.lang.Runnable
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void run() {
            /*
                Method dump skipped, instructions count: 416
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.b0.run():void");
        }
    }

    /* loaded from: classes.dex */
    static class c implements Interpolator {
        c() {
        }

        @Override // android.animation.TimeInterpolator
        public float getInterpolation(float f) {
            float f2 = f - 1.0f;
            return (f2 * f2 * f2 * f2 * f2) + 1.0f;
        }
    }

    /* loaded from: classes.dex */
    public static abstract class c0 {
        private static final List<Object> t = Collections.emptyList();

        /* renamed from: b  reason: collision with root package name */
        public final View f1123b;

        /* renamed from: c  reason: collision with root package name */
        WeakReference<RecyclerView> f1124c;
        int k;
        RecyclerView s;

        /* renamed from: d  reason: collision with root package name */
        int f1125d = -1;
        int e = -1;
        long f = -1;
        int g = -1;
        int h = -1;
        c0 i = null;
        c0 j = null;
        List<Object> l = null;
        List<Object> m = null;
        private int n = 0;
        v o = null;
        boolean p = false;
        private int q = 0;
        int r = -1;

        public c0(View view) {
            if (view == null) {
                throw new IllegalArgumentException("itemView may not be null");
            }
            this.f1123b = view;
        }

        private void g() {
            if (this.l == null) {
                ArrayList arrayList = new ArrayList();
                this.l = arrayList;
                this.m = Collections.unmodifiableList(arrayList);
            }
        }

        void A(int i, boolean z) {
            if (this.e == -1) {
                this.e = this.f1125d;
            }
            if (this.h == -1) {
                this.h = this.f1125d;
            }
            if (z) {
                this.h += i;
            }
            this.f1125d += i;
            if (this.f1123b.getLayoutParams() != null) {
                ((p) this.f1123b.getLayoutParams()).f1150c = true;
            }
        }

        void B(RecyclerView recyclerView) {
            int i = this.r;
            if (i == -1) {
                i = a.f.l.r.o(this.f1123b);
            }
            this.q = i;
            recyclerView.j1(this, 4);
        }

        void C(RecyclerView recyclerView) {
            recyclerView.j1(this, this.q);
            this.q = 0;
        }

        void D() {
            this.k = 0;
            this.f1125d = -1;
            this.e = -1;
            this.f = -1L;
            this.h = -1;
            this.n = 0;
            this.i = null;
            this.j = null;
            d();
            this.q = 0;
            this.r = -1;
            RecyclerView.s(this);
        }

        void E() {
            if (this.e == -1) {
                this.e = this.f1125d;
            }
        }

        void F(int i, int i2) {
            this.k = (i & i2) | (this.k & (~i2));
        }

        public final void G(boolean z) {
            int i;
            int i2 = this.n;
            int i3 = z ? i2 - 1 : i2 + 1;
            this.n = i3;
            if (i3 < 0) {
                this.n = 0;
                Log.e("View", "isRecyclable decremented below 0: unmatched pair of setIsRecyable() calls for " + this);
                return;
            }
            if (!z && i3 == 1) {
                i = this.k | 16;
            } else if (!z || i3 != 0) {
                return;
            } else {
                i = this.k & (-17);
            }
            this.k = i;
        }

        void H(v vVar, boolean z) {
            this.o = vVar;
            this.p = z;
        }

        boolean I() {
            return (this.k & 16) != 0;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean J() {
            return (this.k & 128) != 0;
        }

        void K() {
            this.o.J(this);
        }

        boolean L() {
            return (this.k & 32) != 0;
        }

        void a(Object obj) {
            if (obj == null) {
                b(1024);
            } else if ((1024 & this.k) == 0) {
                g();
                this.l.add(obj);
            }
        }

        void b(int i) {
            this.k = i | this.k;
        }

        void c() {
            this.e = -1;
            this.h = -1;
        }

        void d() {
            List<Object> list = this.l;
            if (list != null) {
                list.clear();
            }
            this.k &= -1025;
        }

        void e() {
            this.k &= -33;
        }

        void f() {
            this.k &= -257;
        }

        boolean h() {
            return (this.k & 16) == 0 && a.f.l.r.C(this.f1123b);
        }

        void i(int i, int i2, boolean z) {
            b(8);
            A(i2, z);
            this.f1125d = i;
        }

        public final int j() {
            RecyclerView recyclerView = this.s;
            if (recyclerView == null) {
                return -1;
            }
            return recyclerView.c0(this);
        }

        public final long k() {
            return this.f;
        }

        public final int l() {
            return this.g;
        }

        public final int m() {
            int i = this.h;
            return i == -1 ? this.f1125d : i;
        }

        public final int n() {
            return this.e;
        }

        @Deprecated
        public final int o() {
            int i = this.h;
            return i == -1 ? this.f1125d : i;
        }

        List<Object> p() {
            if ((this.k & 1024) == 0) {
                List<Object> list = this.l;
                return (list == null || list.size() == 0) ? t : this.m;
            }
            return t;
        }

        boolean q(int i) {
            return (i & this.k) != 0;
        }

        boolean r() {
            return (this.k & 512) != 0 || t();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean s() {
            return (this.k & 1) != 0;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean t() {
            return (this.k & 4) != 0;
        }

        public String toString() {
            StringBuilder sb = new StringBuilder("ViewHolder{" + Integer.toHexString(hashCode()) + " position=" + this.f1125d + " id=" + this.f + ", oldPos=" + this.e + ", pLpos:" + this.h);
            if (w()) {
                sb.append(" scrap ");
                sb.append(this.p ? "[changeScrap]" : "[attachedScrap]");
            }
            if (t()) {
                sb.append(" invalid");
            }
            if (!s()) {
                sb.append(" unbound");
            }
            if (z()) {
                sb.append(" update");
            }
            if (v()) {
                sb.append(" removed");
            }
            if (J()) {
                sb.append(" ignored");
            }
            if (x()) {
                sb.append(" tmpDetached");
            }
            if (!u()) {
                sb.append(" not recyclable(" + this.n + ")");
            }
            if (r()) {
                sb.append(" undefined adapter position");
            }
            if (this.f1123b.getParent() == null) {
                sb.append(" no parent");
            }
            sb.append("}");
            return sb.toString();
        }

        public final boolean u() {
            return (this.k & 16) == 0 && !a.f.l.r.C(this.f1123b);
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean v() {
            return (this.k & 8) != 0;
        }

        boolean w() {
            return this.o != null;
        }

        boolean x() {
            return (this.k & 256) != 0;
        }

        boolean y() {
            return (this.k & 2) != 0;
        }

        boolean z() {
            return (this.k & 2) != 0;
        }
    }

    /* loaded from: classes.dex */
    class d implements n.b {
        d() {
        }

        @Override // androidx.recyclerview.widget.n.b
        public void a(c0 c0Var) {
            RecyclerView recyclerView = RecyclerView.this;
            recyclerView.n.j1(c0Var.f1123b, recyclerView.f1115c);
        }

        @Override // androidx.recyclerview.widget.n.b
        public void b(c0 c0Var, l.c cVar, l.c cVar2) {
            RecyclerView.this.m(c0Var, cVar, cVar2);
        }

        @Override // androidx.recyclerview.widget.n.b
        public void c(c0 c0Var, l.c cVar, l.c cVar2) {
            RecyclerView.this.f1115c.J(c0Var);
            RecyclerView.this.o(c0Var, cVar, cVar2);
        }

        @Override // androidx.recyclerview.widget.n.b
        public void d(c0 c0Var, l.c cVar, l.c cVar2) {
            c0Var.G(false);
            RecyclerView recyclerView = RecyclerView.this;
            boolean z = recyclerView.E;
            l lVar = recyclerView.N;
            if (z) {
                if (!lVar.b(c0Var, c0Var, cVar, cVar2)) {
                    return;
                }
            } else if (!lVar.d(c0Var, cVar, cVar2)) {
                return;
            }
            RecyclerView.this.M0();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements b.InterfaceC0040b {
        e() {
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public View a(int i) {
            return RecyclerView.this.getChildAt(i);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void b(View view) {
            c0 f0 = RecyclerView.f0(view);
            if (f0 != null) {
                f0.B(RecyclerView.this);
            }
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void c(int i) {
            View childAt = RecyclerView.this.getChildAt(i);
            if (childAt != null) {
                RecyclerView.this.A(childAt);
                childAt.clearAnimation();
            }
            RecyclerView.this.removeViewAt(i);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void d() {
            int k = k();
            for (int i = 0; i < k; i++) {
                View a2 = a(i);
                RecyclerView.this.A(a2);
                a2.clearAnimation();
            }
            RecyclerView.this.removeAllViews();
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public c0 e(View view) {
            return RecyclerView.f0(view);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void f(int i) {
            c0 f0;
            View a2 = a(i);
            if (a2 != null && (f0 = RecyclerView.f0(a2)) != null) {
                if (f0.x() && !f0.J()) {
                    throw new IllegalArgumentException("called detach on an already detached child " + f0 + RecyclerView.this.R());
                }
                f0.b(256);
            }
            RecyclerView.this.detachViewFromParent(i);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void g(View view) {
            c0 f0 = RecyclerView.f0(view);
            if (f0 != null) {
                f0.C(RecyclerView.this);
            }
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void h(View view, int i, ViewGroup.LayoutParams layoutParams) {
            c0 f0 = RecyclerView.f0(view);
            if (f0 != null) {
                if (!f0.x() && !f0.J()) {
                    throw new IllegalArgumentException("Called attach on a child which is not detached: " + f0 + RecyclerView.this.R());
                }
                f0.f();
            }
            RecyclerView.this.attachViewToParent(view, i, layoutParams);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public void i(View view, int i) {
            RecyclerView.this.addView(view, i);
            RecyclerView.this.z(view);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public int j(View view) {
            return RecyclerView.this.indexOfChild(view);
        }

        @Override // androidx.recyclerview.widget.b.InterfaceC0040b
        public int k() {
            return RecyclerView.this.getChildCount();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements a.InterfaceC0039a {
        f() {
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void a(int i, int i2) {
            RecyclerView.this.C0(i, i2);
            RecyclerView.this.l0 = true;
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void b(a.b bVar) {
            i(bVar);
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public c0 c(int i) {
            c0 a0 = RecyclerView.this.a0(i, true);
            if (a0 == null || RecyclerView.this.f.n(a0.f1123b)) {
                return null;
            }
            return a0;
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void d(int i, int i2) {
            RecyclerView.this.D0(i, i2, true);
            RecyclerView recyclerView = RecyclerView.this;
            recyclerView.l0 = true;
            recyclerView.i0.f1166d += i2;
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void e(int i, int i2) {
            RecyclerView.this.D0(i, i2, false);
            RecyclerView.this.l0 = true;
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void f(a.b bVar) {
            i(bVar);
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void g(int i, int i2) {
            RecyclerView.this.B0(i, i2);
            RecyclerView.this.l0 = true;
        }

        @Override // androidx.recyclerview.widget.a.InterfaceC0039a
        public void h(int i, int i2, Object obj) {
            RecyclerView.this.t1(i, i2, obj);
            RecyclerView.this.m0 = true;
        }

        void i(a.b bVar) {
            int i = bVar.f1188a;
            if (i == 1) {
                RecyclerView recyclerView = RecyclerView.this;
                recyclerView.n.P0(recyclerView, bVar.f1189b, bVar.f1191d);
            } else if (i == 2) {
                RecyclerView recyclerView2 = RecyclerView.this;
                recyclerView2.n.S0(recyclerView2, bVar.f1189b, bVar.f1191d);
            } else if (i == 4) {
                RecyclerView recyclerView3 = RecyclerView.this;
                recyclerView3.n.U0(recyclerView3, bVar.f1189b, bVar.f1191d, bVar.f1190c);
            } else if (i != 8) {
            } else {
                RecyclerView recyclerView4 = RecyclerView.this;
                recyclerView4.n.R0(recyclerView4, bVar.f1189b, bVar.f1191d, 1);
            }
        }
    }

    /* loaded from: classes.dex */
    public static abstract class g<VH extends c0> {

        /* renamed from: a  reason: collision with root package name */
        private final h f1129a = new h();

        /* renamed from: b  reason: collision with root package name */
        private boolean f1130b = false;

        public final void a(VH vh, int i) {
            vh.f1125d = i;
            if (f()) {
                vh.f = d(i);
            }
            vh.F(1, 519);
            a.f.h.a.a("RV OnBindView");
            m(vh, i, vh.p());
            vh.d();
            ViewGroup.LayoutParams layoutParams = vh.f1123b.getLayoutParams();
            if (layoutParams instanceof p) {
                ((p) layoutParams).f1150c = true;
            }
            a.f.h.a.b();
        }

        public final VH b(ViewGroup viewGroup, int i) {
            try {
                a.f.h.a.a("RV CreateView");
                VH n = n(viewGroup, i);
                if (n.f1123b.getParent() == null) {
                    n.g = i;
                    return n;
                }
                throw new IllegalStateException("ViewHolder views must not be attached when created. Ensure that you are not passing 'true' to the attachToRoot parameter of LayoutInflater.inflate(..., boolean attachToRoot)");
            } finally {
                a.f.h.a.b();
            }
        }

        public abstract int c();

        public long d(int i) {
            return -1L;
        }

        public int e(int i) {
            return 0;
        }

        public final boolean f() {
            return this.f1130b;
        }

        public final void g() {
            this.f1129a.a();
        }

        public final void h(int i) {
            this.f1129a.b(i, 1);
        }

        public final void i(int i, int i2) {
            this.f1129a.b(i, i2);
        }

        public final void j(int i) {
            this.f1129a.d(i, 1);
        }

        public void k(RecyclerView recyclerView) {
        }

        public abstract void l(VH vh, int i);

        public void m(VH vh, int i, List<Object> list) {
            l(vh, i);
        }

        public abstract VH n(ViewGroup viewGroup, int i);

        public void o(RecyclerView recyclerView) {
        }

        public boolean p(VH vh) {
            return false;
        }

        public void q(VH vh) {
        }

        public void r(VH vh) {
        }

        public void s(VH vh) {
        }

        public void t(i iVar) {
            this.f1129a.registerObserver(iVar);
        }

        public void u(i iVar) {
            this.f1129a.unregisterObserver(iVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class h extends Observable<i> {
        h() {
        }

        public void a() {
            for (int size = ((Observable) this).mObservers.size() - 1; size >= 0; size--) {
                ((i) ((Observable) this).mObservers.get(size)).a();
            }
        }

        public void b(int i, int i2) {
            c(i, i2, null);
        }

        public void c(int i, int i2, Object obj) {
            for (int size = ((Observable) this).mObservers.size() - 1; size >= 0; size--) {
                ((i) ((Observable) this).mObservers.get(size)).c(i, i2, obj);
            }
        }

        public void d(int i, int i2) {
            for (int size = ((Observable) this).mObservers.size() - 1; size >= 0; size--) {
                ((i) ((Observable) this).mObservers.get(size)).d(i, i2);
            }
        }
    }

    /* loaded from: classes.dex */
    public static abstract class i {
        public void a() {
        }

        public void b(int i, int i2) {
        }

        public void c(int i, int i2, Object obj) {
            b(i, i2);
        }

        public void d(int i, int i2) {
        }
    }

    /* loaded from: classes.dex */
    public interface j {
        int a(int i, int i2);
    }

    /* loaded from: classes.dex */
    public static class k {
        protected EdgeEffect a(RecyclerView recyclerView, int i) {
            return new EdgeEffect(recyclerView.getContext());
        }
    }

    /* loaded from: classes.dex */
    public static abstract class l {

        /* renamed from: a  reason: collision with root package name */
        private b f1131a = null;

        /* renamed from: b  reason: collision with root package name */
        private ArrayList<a> f1132b = new ArrayList<>();

        /* renamed from: c  reason: collision with root package name */
        private long f1133c = 120;

        /* renamed from: d  reason: collision with root package name */
        private long f1134d = 120;
        private long e = 250;
        private long f = 250;

        /* loaded from: classes.dex */
        public interface a {
            void a();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public interface b {
            void a(c0 c0Var);
        }

        /* loaded from: classes.dex */
        public static class c {

            /* renamed from: a  reason: collision with root package name */
            public int f1135a;

            /* renamed from: b  reason: collision with root package name */
            public int f1136b;

            public c a(c0 c0Var) {
                b(c0Var, 0);
                return this;
            }

            public c b(c0 c0Var, int i) {
                View view = c0Var.f1123b;
                this.f1135a = view.getLeft();
                this.f1136b = view.getTop();
                view.getRight();
                view.getBottom();
                return this;
            }
        }

        static int e(c0 c0Var) {
            int i = c0Var.k & 14;
            if (c0Var.t()) {
                return 4;
            }
            if ((i & 4) == 0) {
                int n = c0Var.n();
                int j = c0Var.j();
                return (n == -1 || j == -1 || n == j) ? i : i | 2048;
            }
            return i;
        }

        public abstract boolean a(c0 c0Var, c cVar, c cVar2);

        public abstract boolean b(c0 c0Var, c0 c0Var2, c cVar, c cVar2);

        public abstract boolean c(c0 c0Var, c cVar, c cVar2);

        public abstract boolean d(c0 c0Var, c cVar, c cVar2);

        public abstract boolean f(c0 c0Var);

        public boolean g(c0 c0Var, List<Object> list) {
            return f(c0Var);
        }

        public final void h(c0 c0Var) {
            r(c0Var);
            b bVar = this.f1131a;
            if (bVar != null) {
                bVar.a(c0Var);
            }
        }

        public final void i() {
            int size = this.f1132b.size();
            for (int i = 0; i < size; i++) {
                this.f1132b.get(i).a();
            }
            this.f1132b.clear();
        }

        public abstract void j(c0 c0Var);

        public abstract void k();

        public long l() {
            return this.f1133c;
        }

        public long m() {
            return this.f;
        }

        public long n() {
            return this.e;
        }

        public long o() {
            return this.f1134d;
        }

        public abstract boolean p();

        public c q() {
            return new c();
        }

        public void r(c0 c0Var) {
        }

        public c s(z zVar, c0 c0Var) {
            c q = q();
            q.a(c0Var);
            return q;
        }

        public c t(z zVar, c0 c0Var, int i, List<Object> list) {
            c q = q();
            q.a(c0Var);
            return q;
        }

        public abstract void u();

        void v(b bVar) {
            this.f1131a = bVar;
        }
    }

    /* loaded from: classes.dex */
    private class m implements l.b {
        m() {
        }

        @Override // androidx.recyclerview.widget.RecyclerView.l.b
        public void a(c0 c0Var) {
            c0Var.G(true);
            if (c0Var.i != null && c0Var.j == null) {
                c0Var.i = null;
            }
            c0Var.j = null;
            if (c0Var.I() || RecyclerView.this.V0(c0Var.f1123b) || !c0Var.x()) {
                return;
            }
            RecyclerView.this.removeDetachedView(c0Var.f1123b, false);
        }
    }

    /* loaded from: classes.dex */
    public static abstract class n {
        @Deprecated
        public void d(Rect rect, int i, RecyclerView recyclerView) {
            rect.set(0, 0, 0, 0);
        }

        public void e(Rect rect, View view, RecyclerView recyclerView, z zVar) {
            d(rect, ((p) view.getLayoutParams()).a(), recyclerView);
        }

        @Deprecated
        public void f(Canvas canvas, RecyclerView recyclerView) {
        }

        public void g(Canvas canvas, RecyclerView recyclerView, z zVar) {
            f(canvas, recyclerView);
        }

        @Deprecated
        public void h(Canvas canvas, RecyclerView recyclerView) {
        }

        public void i(Canvas canvas, RecyclerView recyclerView, z zVar) {
            h(canvas, recyclerView);
        }
    }

    /* loaded from: classes.dex */
    public static abstract class o {

        /* renamed from: a  reason: collision with root package name */
        androidx.recyclerview.widget.b f1138a;

        /* renamed from: b  reason: collision with root package name */
        RecyclerView f1139b;

        /* renamed from: c  reason: collision with root package name */
        private final m.b f1140c;

        /* renamed from: d  reason: collision with root package name */
        private final m.b f1141d;
        androidx.recyclerview.widget.m e;
        androidx.recyclerview.widget.m f;
        y g;
        boolean h;
        boolean i;
        boolean j;
        private boolean k;
        private boolean l;
        int m;
        boolean n;
        private int o;
        private int p;
        private int q;
        private int r;

        /* loaded from: classes.dex */
        class a implements m.b {
            a() {
            }

            @Override // androidx.recyclerview.widget.m.b
            public View a(int i) {
                return o.this.H(i);
            }

            @Override // androidx.recyclerview.widget.m.b
            public int b() {
                return o.this.m0() - o.this.d0();
            }

            @Override // androidx.recyclerview.widget.m.b
            public int c() {
                return o.this.c0();
            }

            @Override // androidx.recyclerview.widget.m.b
            public int d(View view) {
                return o.this.S(view) + ((ViewGroup.MarginLayoutParams) ((p) view.getLayoutParams())).rightMargin;
            }

            @Override // androidx.recyclerview.widget.m.b
            public int e(View view) {
                return o.this.P(view) - ((ViewGroup.MarginLayoutParams) ((p) view.getLayoutParams())).leftMargin;
            }
        }

        /* loaded from: classes.dex */
        class b implements m.b {
            b() {
            }

            @Override // androidx.recyclerview.widget.m.b
            public View a(int i) {
                return o.this.H(i);
            }

            @Override // androidx.recyclerview.widget.m.b
            public int b() {
                return o.this.V() - o.this.b0();
            }

            @Override // androidx.recyclerview.widget.m.b
            public int c() {
                return o.this.e0();
            }

            @Override // androidx.recyclerview.widget.m.b
            public int d(View view) {
                return o.this.N(view) + ((ViewGroup.MarginLayoutParams) ((p) view.getLayoutParams())).bottomMargin;
            }

            @Override // androidx.recyclerview.widget.m.b
            public int e(View view) {
                return o.this.T(view) - ((ViewGroup.MarginLayoutParams) ((p) view.getLayoutParams())).topMargin;
            }
        }

        /* loaded from: classes.dex */
        public interface c {
            void a(int i, int i2);
        }

        /* loaded from: classes.dex */
        public static class d {

            /* renamed from: a  reason: collision with root package name */
            public int f1144a;

            /* renamed from: b  reason: collision with root package name */
            public int f1145b;

            /* renamed from: c  reason: collision with root package name */
            public boolean f1146c;

            /* renamed from: d  reason: collision with root package name */
            public boolean f1147d;
        }

        public o() {
            a aVar = new a();
            this.f1140c = aVar;
            b bVar = new b();
            this.f1141d = bVar;
            this.e = new androidx.recyclerview.widget.m(aVar);
            this.f = new androidx.recyclerview.widget.m(bVar);
            this.h = false;
            this.i = false;
            this.j = false;
            this.k = true;
            this.l = true;
        }

        /* JADX WARN: Code restructure failed: missing block: B:9:0x0017, code lost:
            if (r5 == 1073741824) goto L8;
         */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public static int J(int r4, int r5, int r6, int r7, boolean r8) {
            /*
                int r4 = r4 - r6
                r6 = 0
                int r4 = java.lang.Math.max(r6, r4)
                r0 = -2
                r1 = -1
                r2 = -2147483648(0xffffffff80000000, float:-0.0)
                r3 = 1073741824(0x40000000, float:2.0)
                if (r8 == 0) goto L1a
                if (r7 < 0) goto L11
                goto L1c
            L11:
                if (r7 != r1) goto L2f
                if (r5 == r2) goto L20
                if (r5 == 0) goto L2f
                if (r5 == r3) goto L20
                goto L2f
            L1a:
                if (r7 < 0) goto L1e
            L1c:
                r5 = r3
                goto L31
            L1e:
                if (r7 != r1) goto L22
            L20:
                r7 = r4
                goto L31
            L22:
                if (r7 != r0) goto L2f
                if (r5 == r2) goto L2c
                if (r5 != r3) goto L29
                goto L2c
            L29:
                r7 = r4
                r5 = r6
                goto L31
            L2c:
                r7 = r4
                r5 = r2
                goto L31
            L2f:
                r5 = r6
                r7 = r5
            L31:
                int r4 = android.view.View.MeasureSpec.makeMeasureSpec(r7, r5)
                return r4
            */
            throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.o.J(int, int, int, int, boolean):int");
        }

        private int[] K(RecyclerView recyclerView, View view, Rect rect, boolean z) {
            int[] iArr = new int[2];
            int c0 = c0();
            int e0 = e0();
            int m0 = m0() - d0();
            int V = V() - b0();
            int left = (view.getLeft() + rect.left) - view.getScrollX();
            int top = (view.getTop() + rect.top) - view.getScrollY();
            int width = rect.width() + left;
            int height = rect.height() + top;
            int i = left - c0;
            int min = Math.min(0, i);
            int i2 = top - e0;
            int min2 = Math.min(0, i2);
            int i3 = width - m0;
            int max = Math.max(0, i3);
            int max2 = Math.max(0, height - V);
            if (X() != 1) {
                if (min == 0) {
                    min = Math.min(i, max);
                }
                max = min;
            } else if (max == 0) {
                max = Math.max(min, i3);
            }
            if (min2 == 0) {
                min2 = Math.min(i2, max2);
            }
            iArr[0] = max;
            iArr[1] = min2;
            return iArr;
        }

        private void e(View view, int i, boolean z) {
            c0 f0 = RecyclerView.f0(view);
            if (z || f0.v()) {
                this.f1139b.g.b(f0);
            } else {
                this.f1139b.g.p(f0);
            }
            p pVar = (p) view.getLayoutParams();
            if (f0.L() || f0.w()) {
                if (f0.w()) {
                    f0.K();
                } else {
                    f0.e();
                }
                this.f1138a.c(view, i, view.getLayoutParams(), false);
            } else if (view.getParent() == this.f1139b) {
                int m = this.f1138a.m(view);
                if (i == -1) {
                    i = this.f1138a.g();
                }
                if (m == -1) {
                    throw new IllegalStateException("Added View has RecyclerView as parent but view is not a real child. Unfiltered index:" + this.f1139b.indexOfChild(view) + this.f1139b.R());
                } else if (m != i) {
                    this.f1139b.n.z0(m, i);
                }
            } else {
                this.f1138a.a(view, i, false);
                pVar.f1150c = true;
                y yVar = this.g;
                if (yVar != null && yVar.c()) {
                    this.g.e(view);
                }
            }
            if (pVar.f1151d) {
                f0.f1123b.invalidate();
                pVar.f1151d = false;
            }
        }

        public static d g0(Context context, AttributeSet attributeSet, int i, int i2) {
            d dVar = new d();
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, a.k.b.RecyclerView, i, i2);
            dVar.f1144a = obtainStyledAttributes.getInt(a.k.b.RecyclerView_android_orientation, 1);
            dVar.f1145b = obtainStyledAttributes.getInt(a.k.b.RecyclerView_spanCount, 1);
            dVar.f1146c = obtainStyledAttributes.getBoolean(a.k.b.RecyclerView_reverseLayout, false);
            dVar.f1147d = obtainStyledAttributes.getBoolean(a.k.b.RecyclerView_stackFromEnd, false);
            obtainStyledAttributes.recycle();
            return dVar;
        }

        public static int m(int i, int i2, int i3) {
            int mode = View.MeasureSpec.getMode(i);
            int size = View.MeasureSpec.getSize(i);
            return mode != Integer.MIN_VALUE ? mode != 1073741824 ? Math.max(i2, i3) : size : Math.min(size, Math.max(i2, i3));
        }

        private boolean r0(RecyclerView recyclerView, int i, int i2) {
            View focusedChild = recyclerView.getFocusedChild();
            if (focusedChild == null) {
                return false;
            }
            int c0 = c0();
            int e0 = e0();
            int m0 = m0() - d0();
            int V = V() - b0();
            Rect rect = this.f1139b.j;
            O(focusedChild, rect);
            return rect.left - i < m0 && rect.right - i > c0 && rect.top - i2 < V && rect.bottom - i2 > e0;
        }

        private void s1(v vVar, int i, View view) {
            c0 f0 = RecyclerView.f0(view);
            if (f0.J()) {
                return;
            }
            if (f0.t() && !f0.v() && !this.f1139b.m.f()) {
                n1(i);
                vVar.C(f0);
                return;
            }
            w(i);
            vVar.D(view);
            this.f1139b.g.k(f0);
        }

        private static boolean u0(int i, int i2, int i3) {
            int mode = View.MeasureSpec.getMode(i2);
            int size = View.MeasureSpec.getSize(i2);
            if (i3 <= 0 || i == i3) {
                if (mode == Integer.MIN_VALUE) {
                    return size >= i;
                } else if (mode != 0) {
                    return mode == 1073741824 && size == i;
                } else {
                    return true;
                }
            }
            return false;
        }

        private void x(int i, View view) {
            this.f1138a.d(i);
        }

        public View A(View view) {
            View T;
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null || (T = recyclerView.T(view)) == null || this.f1138a.n(T)) {
                return null;
            }
            return T;
        }

        public void A0(int i) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                recyclerView.z0(i);
            }
        }

        void A1(int i, int i2) {
            int I = I();
            if (I == 0) {
                this.f1139b.x(i, i2);
                return;
            }
            int i3 = Integer.MIN_VALUE;
            int i4 = Integer.MAX_VALUE;
            int i5 = Integer.MAX_VALUE;
            int i6 = Integer.MIN_VALUE;
            for (int i7 = 0; i7 < I; i7++) {
                View H = H(i7);
                Rect rect = this.f1139b.j;
                O(H, rect);
                int i8 = rect.left;
                if (i8 < i4) {
                    i4 = i8;
                }
                int i9 = rect.right;
                if (i9 > i3) {
                    i3 = i9;
                }
                int i10 = rect.top;
                if (i10 < i5) {
                    i5 = i10;
                }
                int i11 = rect.bottom;
                if (i11 > i6) {
                    i6 = i11;
                }
            }
            this.f1139b.j.set(i4, i5, i3, i6);
            z1(this.f1139b.j, i, i2);
        }

        public View B(int i) {
            int I = I();
            for (int i2 = 0; i2 < I; i2++) {
                View H = H(i2);
                c0 f0 = RecyclerView.f0(H);
                if (f0 != null && f0.m() == i && !f0.J() && (this.f1139b.i0.e() || !f0.v())) {
                    return H;
                }
            }
            return null;
        }

        public void B0(int i) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                recyclerView.A0(i);
            }
        }

        void B1(RecyclerView recyclerView) {
            int height;
            if (recyclerView == null) {
                this.f1139b = null;
                this.f1138a = null;
                height = 0;
                this.q = 0;
            } else {
                this.f1139b = recyclerView;
                this.f1138a = recyclerView.f;
                this.q = recyclerView.getWidth();
                height = recyclerView.getHeight();
            }
            this.r = height;
            this.o = 1073741824;
            this.p = 1073741824;
        }

        public abstract p C();

        public void C0(g gVar, g gVar2) {
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean C1(View view, int i, int i2, p pVar) {
            return (!view.isLayoutRequested() && this.k && u0(view.getWidth(), i, ((ViewGroup.MarginLayoutParams) pVar).width) && u0(view.getHeight(), i2, ((ViewGroup.MarginLayoutParams) pVar).height)) ? false : true;
        }

        public p D(Context context, AttributeSet attributeSet) {
            return new p(context, attributeSet);
        }

        public boolean D0(RecyclerView recyclerView, ArrayList<View> arrayList, int i, int i2) {
            return false;
        }

        boolean D1() {
            return false;
        }

        public p E(ViewGroup.LayoutParams layoutParams) {
            return layoutParams instanceof p ? new p((p) layoutParams) : layoutParams instanceof ViewGroup.MarginLayoutParams ? new p((ViewGroup.MarginLayoutParams) layoutParams) : new p(layoutParams);
        }

        public void E0(RecyclerView recyclerView) {
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean E1(View view, int i, int i2, p pVar) {
            return (this.k && u0(view.getMeasuredWidth(), i, ((ViewGroup.MarginLayoutParams) pVar).width) && u0(view.getMeasuredHeight(), i2, ((ViewGroup.MarginLayoutParams) pVar).height)) ? false : true;
        }

        public int F() {
            return -1;
        }

        @Deprecated
        public void F0(RecyclerView recyclerView) {
        }

        void F1() {
            y yVar = this.g;
            if (yVar != null) {
                yVar.g();
            }
        }

        public int G(View view) {
            return ((p) view.getLayoutParams()).f1149b.bottom;
        }

        public void G0(RecyclerView recyclerView, v vVar) {
            F0(recyclerView);
        }

        public boolean G1() {
            return false;
        }

        public View H(int i) {
            androidx.recyclerview.widget.b bVar = this.f1138a;
            if (bVar != null) {
                return bVar.f(i);
            }
            return null;
        }

        public View H0(View view, int i, v vVar, z zVar) {
            return null;
        }

        public int I() {
            androidx.recyclerview.widget.b bVar = this.f1138a;
            if (bVar != null) {
                return bVar.g();
            }
            return 0;
        }

        public void I0(AccessibilityEvent accessibilityEvent) {
            RecyclerView recyclerView = this.f1139b;
            J0(recyclerView.f1115c, recyclerView.i0, accessibilityEvent);
        }

        public void J0(v vVar, z zVar, AccessibilityEvent accessibilityEvent) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null || accessibilityEvent == null) {
                return;
            }
            boolean z = true;
            if (!recyclerView.canScrollVertically(1) && !this.f1139b.canScrollVertically(-1) && !this.f1139b.canScrollHorizontally(-1) && !this.f1139b.canScrollHorizontally(1)) {
                z = false;
            }
            accessibilityEvent.setScrollable(z);
            g gVar = this.f1139b.m;
            if (gVar != null) {
                accessibilityEvent.setItemCount(gVar.c());
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void K0(a.f.l.a0.c cVar) {
            RecyclerView recyclerView = this.f1139b;
            L0(recyclerView.f1115c, recyclerView.i0, cVar);
        }

        public boolean L() {
            RecyclerView recyclerView = this.f1139b;
            return recyclerView != null && recyclerView.h;
        }

        public void L0(v vVar, z zVar, a.f.l.a0.c cVar) {
            if (this.f1139b.canScrollVertically(-1) || this.f1139b.canScrollHorizontally(-1)) {
                cVar.a(8192);
                cVar.A(true);
            }
            if (this.f1139b.canScrollVertically(1) || this.f1139b.canScrollHorizontally(1)) {
                cVar.a(4096);
                cVar.A(true);
            }
            cVar.x(c.a.a(i0(vVar, zVar), M(vVar, zVar), t0(vVar, zVar), j0(vVar, zVar)));
        }

        public int M(v vVar, z zVar) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null || recyclerView.m == null || !j()) {
                return 1;
            }
            return this.f1139b.m.c();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void M0(View view, a.f.l.a0.c cVar) {
            c0 f0 = RecyclerView.f0(view);
            if (f0 == null || f0.v() || this.f1138a.n(f0.f1123b)) {
                return;
            }
            RecyclerView recyclerView = this.f1139b;
            N0(recyclerView.f1115c, recyclerView.i0, view, cVar);
        }

        public int N(View view) {
            return view.getBottom() + G(view);
        }

        public void N0(v vVar, z zVar, View view, a.f.l.a0.c cVar) {
            cVar.y(c.b.a(k() ? f0(view) : 0, 1, j() ? f0(view) : 0, 1, false, false));
        }

        public void O(View view, Rect rect) {
            RecyclerView.h0(view, rect);
        }

        public View O0(View view, int i) {
            return null;
        }

        public int P(View view) {
            return view.getLeft() - Y(view);
        }

        public void P0(RecyclerView recyclerView, int i, int i2) {
        }

        public int Q(View view) {
            Rect rect = ((p) view.getLayoutParams()).f1149b;
            return view.getMeasuredHeight() + rect.top + rect.bottom;
        }

        public void Q0(RecyclerView recyclerView) {
        }

        public int R(View view) {
            Rect rect = ((p) view.getLayoutParams()).f1149b;
            return view.getMeasuredWidth() + rect.left + rect.right;
        }

        public void R0(RecyclerView recyclerView, int i, int i2, int i3) {
        }

        public int S(View view) {
            return view.getRight() + h0(view);
        }

        public void S0(RecyclerView recyclerView, int i, int i2) {
        }

        public int T(View view) {
            return view.getTop() - k0(view);
        }

        public void T0(RecyclerView recyclerView, int i, int i2) {
        }

        public View U() {
            View focusedChild;
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null || (focusedChild = recyclerView.getFocusedChild()) == null || this.f1138a.n(focusedChild)) {
                return null;
            }
            return focusedChild;
        }

        public void U0(RecyclerView recyclerView, int i, int i2, Object obj) {
            T0(recyclerView, i, i2);
        }

        public int V() {
            return this.r;
        }

        public void V0(v vVar, z zVar) {
            Log.e("RecyclerView", "You must override onLayoutChildren(Recycler recycler, State state) ");
        }

        public int W() {
            return this.p;
        }

        public void W0(z zVar) {
        }

        public int X() {
            return a.f.l.r.q(this.f1139b);
        }

        public void X0(v vVar, z zVar, int i, int i2) {
            this.f1139b.x(i, i2);
        }

        public int Y(View view) {
            return ((p) view.getLayoutParams()).f1149b.left;
        }

        @Deprecated
        public boolean Y0(RecyclerView recyclerView, View view, View view2) {
            return v0() || recyclerView.v0();
        }

        public int Z() {
            return a.f.l.r.r(this.f1139b);
        }

        public boolean Z0(RecyclerView recyclerView, z zVar, View view, View view2) {
            return Y0(recyclerView, view, view2);
        }

        public void a(View view) {
            b(view, -1);
        }

        public int a0() {
            return a.f.l.r.s(this.f1139b);
        }

        public void a1(Parcelable parcelable) {
        }

        public void b(View view, int i) {
            e(view, i, true);
        }

        public int b0() {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                return recyclerView.getPaddingBottom();
            }
            return 0;
        }

        public Parcelable b1() {
            return null;
        }

        public void c(View view) {
            d(view, -1);
        }

        public int c0() {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                return recyclerView.getPaddingLeft();
            }
            return 0;
        }

        public void c1(int i) {
        }

        public void d(View view, int i) {
            e(view, i, false);
        }

        public int d0() {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                return recyclerView.getPaddingRight();
            }
            return 0;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean d1(int i, Bundle bundle) {
            RecyclerView recyclerView = this.f1139b;
            return e1(recyclerView.f1115c, recyclerView.i0, i, bundle);
        }

        public int e0() {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                return recyclerView.getPaddingTop();
            }
            return 0;
        }

        public boolean e1(v vVar, z zVar, int i, Bundle bundle) {
            int V;
            int m0;
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null) {
                return false;
            }
            if (i == 4096) {
                V = recyclerView.canScrollVertically(1) ? (V() - e0()) - b0() : 0;
                if (this.f1139b.canScrollHorizontally(1)) {
                    m0 = (m0() - c0()) - d0();
                }
                m0 = 0;
            } else if (i != 8192) {
                V = 0;
                m0 = 0;
            } else {
                V = recyclerView.canScrollVertically(-1) ? -((V() - e0()) - b0()) : 0;
                if (this.f1139b.canScrollHorizontally(-1)) {
                    m0 = -((m0() - c0()) - d0());
                }
                m0 = 0;
            }
            if (V == 0 && m0 == 0) {
                return false;
            }
            this.f1139b.l1(m0, V);
            return true;
        }

        public void f(String str) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                recyclerView.p(str);
            }
        }

        public int f0(View view) {
            return ((p) view.getLayoutParams()).a();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean f1(View view, int i, Bundle bundle) {
            RecyclerView recyclerView = this.f1139b;
            return g1(recyclerView.f1115c, recyclerView.i0, view, i, bundle);
        }

        public void g(View view, int i) {
            h(view, i, (p) view.getLayoutParams());
        }

        public boolean g1(v vVar, z zVar, View view, int i, Bundle bundle) {
            return false;
        }

        public void h(View view, int i, p pVar) {
            c0 f0 = RecyclerView.f0(view);
            if (f0.v()) {
                this.f1139b.g.b(f0);
            } else {
                this.f1139b.g.p(f0);
            }
            this.f1138a.c(view, i, pVar, f0.v());
        }

        public int h0(View view) {
            return ((p) view.getLayoutParams()).f1149b.right;
        }

        public void h1(v vVar) {
            for (int I = I() - 1; I >= 0; I--) {
                if (!RecyclerView.f0(H(I)).J()) {
                    k1(I, vVar);
                }
            }
        }

        public void i(View view, Rect rect) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null) {
                rect.set(0, 0, 0, 0);
            } else {
                rect.set(recyclerView.k0(view));
            }
        }

        public int i0(v vVar, z zVar) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView == null || recyclerView.m == null || !k()) {
                return 1;
            }
            return this.f1139b.m.c();
        }

        void i1(v vVar) {
            int j = vVar.j();
            for (int i = j - 1; i >= 0; i--) {
                View n = vVar.n(i);
                c0 f0 = RecyclerView.f0(n);
                if (!f0.J()) {
                    f0.G(false);
                    if (f0.x()) {
                        this.f1139b.removeDetachedView(n, false);
                    }
                    l lVar = this.f1139b.N;
                    if (lVar != null) {
                        lVar.j(f0);
                    }
                    f0.G(true);
                    vVar.y(n);
                }
            }
            vVar.e();
            if (j > 0) {
                this.f1139b.invalidate();
            }
        }

        public boolean j() {
            return false;
        }

        public int j0(v vVar, z zVar) {
            return 0;
        }

        public void j1(View view, v vVar) {
            m1(view);
            vVar.B(view);
        }

        public boolean k() {
            return false;
        }

        public int k0(View view) {
            return ((p) view.getLayoutParams()).f1149b.top;
        }

        public void k1(int i, v vVar) {
            View H = H(i);
            n1(i);
            vVar.B(H);
        }

        public boolean l(p pVar) {
            return pVar != null;
        }

        public void l0(View view, boolean z, Rect rect) {
            Matrix matrix;
            if (z) {
                Rect rect2 = ((p) view.getLayoutParams()).f1149b;
                rect.set(-rect2.left, -rect2.top, view.getWidth() + rect2.right, view.getHeight() + rect2.bottom);
            } else {
                rect.set(0, 0, view.getWidth(), view.getHeight());
            }
            if (this.f1139b != null && (matrix = view.getMatrix()) != null && !matrix.isIdentity()) {
                RectF rectF = this.f1139b.l;
                rectF.set(rect);
                matrix.mapRect(rectF);
                rect.set((int) Math.floor(rectF.left), (int) Math.floor(rectF.top), (int) Math.ceil(rectF.right), (int) Math.ceil(rectF.bottom));
            }
            rect.offset(view.getLeft(), view.getTop());
        }

        public boolean l1(Runnable runnable) {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                return recyclerView.removeCallbacks(runnable);
            }
            return false;
        }

        public int m0() {
            return this.q;
        }

        public void m1(View view) {
            this.f1138a.p(view);
        }

        public void n(int i, int i2, z zVar, c cVar) {
        }

        public int n0() {
            return this.o;
        }

        public void n1(int i) {
            if (H(i) != null) {
                this.f1138a.q(i);
            }
        }

        public void o(int i, c cVar) {
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public boolean o0() {
            int I = I();
            for (int i = 0; i < I; i++) {
                ViewGroup.LayoutParams layoutParams = H(i).getLayoutParams();
                if (layoutParams.width < 0 && layoutParams.height < 0) {
                    return true;
                }
            }
            return false;
        }

        public boolean o1(RecyclerView recyclerView, View view, Rect rect, boolean z) {
            return p1(recyclerView, view, rect, z, false);
        }

        public int p(z zVar) {
            return 0;
        }

        public boolean p0() {
            return this.i;
        }

        public boolean p1(RecyclerView recyclerView, View view, Rect rect, boolean z, boolean z2) {
            int[] K = K(recyclerView, view, rect, z);
            int i = K[0];
            int i2 = K[1];
            if ((!z2 || r0(recyclerView, i, i2)) && !(i == 0 && i2 == 0)) {
                if (z) {
                    recyclerView.scrollBy(i, i2);
                } else {
                    recyclerView.l1(i, i2);
                }
                return true;
            }
            return false;
        }

        public int q(z zVar) {
            return 0;
        }

        public boolean q0() {
            return this.j;
        }

        public void q1() {
            RecyclerView recyclerView = this.f1139b;
            if (recyclerView != null) {
                recyclerView.requestLayout();
            }
        }

        public int r(z zVar) {
            return 0;
        }

        public void r1() {
            this.h = true;
        }

        public int s(z zVar) {
            return 0;
        }

        public final boolean s0() {
            return this.l;
        }

        public int t(z zVar) {
            return 0;
        }

        public boolean t0(v vVar, z zVar) {
            return false;
        }

        public int t1(int i, v vVar, z zVar) {
            return 0;
        }

        public int u(z zVar) {
            return 0;
        }

        public void u1(int i) {
        }

        public void v(v vVar) {
            for (int I = I() - 1; I >= 0; I--) {
                s1(vVar, I, H(I));
            }
        }

        public boolean v0() {
            y yVar = this.g;
            return yVar != null && yVar.c();
        }

        public int v1(int i, v vVar, z zVar) {
            return 0;
        }

        public void w(int i) {
            x(i, H(i));
        }

        public boolean w0(View view, boolean z, boolean z2) {
            boolean z3 = this.e.b(view, 24579) && this.f.b(view, 24579);
            return z ? z3 : !z3;
        }

        void w1(RecyclerView recyclerView) {
            x1(View.MeasureSpec.makeMeasureSpec(recyclerView.getWidth(), 1073741824), View.MeasureSpec.makeMeasureSpec(recyclerView.getHeight(), 1073741824));
        }

        public void x0(View view, int i, int i2, int i3, int i4) {
            p pVar = (p) view.getLayoutParams();
            Rect rect = pVar.f1149b;
            view.layout(i + rect.left + ((ViewGroup.MarginLayoutParams) pVar).leftMargin, i2 + rect.top + ((ViewGroup.MarginLayoutParams) pVar).topMargin, (i3 - rect.right) - ((ViewGroup.MarginLayoutParams) pVar).rightMargin, (i4 - rect.bottom) - ((ViewGroup.MarginLayoutParams) pVar).bottomMargin);
        }

        void x1(int i, int i2) {
            this.q = View.MeasureSpec.getSize(i);
            int mode = View.MeasureSpec.getMode(i);
            this.o = mode;
            if (mode == 0 && !RecyclerView.D0) {
                this.q = 0;
            }
            this.r = View.MeasureSpec.getSize(i2);
            int mode2 = View.MeasureSpec.getMode(i2);
            this.p = mode2;
            if (mode2 != 0 || RecyclerView.D0) {
                return;
            }
            this.r = 0;
        }

        void y(RecyclerView recyclerView) {
            this.i = true;
            E0(recyclerView);
        }

        public void y0(View view, int i, int i2) {
            p pVar = (p) view.getLayoutParams();
            Rect k0 = this.f1139b.k0(view);
            int i3 = i + k0.left + k0.right;
            int i4 = i2 + k0.top + k0.bottom;
            int J = J(m0(), n0(), c0() + d0() + ((ViewGroup.MarginLayoutParams) pVar).leftMargin + ((ViewGroup.MarginLayoutParams) pVar).rightMargin + i3, ((ViewGroup.MarginLayoutParams) pVar).width, j());
            int J2 = J(V(), W(), e0() + b0() + ((ViewGroup.MarginLayoutParams) pVar).topMargin + ((ViewGroup.MarginLayoutParams) pVar).bottomMargin + i4, ((ViewGroup.MarginLayoutParams) pVar).height, k());
            if (C1(view, J, J2, pVar)) {
                view.measure(J, J2);
            }
        }

        public void y1(int i, int i2) {
            this.f1139b.setMeasuredDimension(i, i2);
        }

        void z(RecyclerView recyclerView, v vVar) {
            this.i = false;
            G0(recyclerView, vVar);
        }

        public void z0(int i, int i2) {
            View H = H(i);
            if (H != null) {
                w(i);
                g(H, i2);
                return;
            }
            throw new IllegalArgumentException("Cannot move a child from non-existing index:" + i + this.f1139b.toString());
        }

        public void z1(Rect rect, int i, int i2) {
            y1(m(i, rect.width() + c0() + d0(), a0()), m(i2, rect.height() + e0() + b0(), Z()));
        }
    }

    /* loaded from: classes.dex */
    public static class p extends ViewGroup.MarginLayoutParams {

        /* renamed from: a  reason: collision with root package name */
        c0 f1148a;

        /* renamed from: b  reason: collision with root package name */
        final Rect f1149b;

        /* renamed from: c  reason: collision with root package name */
        boolean f1150c;

        /* renamed from: d  reason: collision with root package name */
        boolean f1151d;

        public p(int i, int i2) {
            super(i, i2);
            this.f1149b = new Rect();
            this.f1150c = true;
            this.f1151d = false;
        }

        public p(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f1149b = new Rect();
            this.f1150c = true;
            this.f1151d = false;
        }

        public p(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.f1149b = new Rect();
            this.f1150c = true;
            this.f1151d = false;
        }

        public p(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
            this.f1149b = new Rect();
            this.f1150c = true;
            this.f1151d = false;
        }

        public p(p pVar) {
            super((ViewGroup.LayoutParams) pVar);
            this.f1149b = new Rect();
            this.f1150c = true;
            this.f1151d = false;
        }

        public int a() {
            return this.f1148a.m();
        }

        public boolean b() {
            return this.f1148a.y();
        }

        public boolean c() {
            return this.f1148a.v();
        }

        public boolean d() {
            return this.f1148a.t();
        }
    }

    /* loaded from: classes.dex */
    public interface q {
        void a(View view);

        void b(View view);
    }

    /* loaded from: classes.dex */
    public static abstract class r {
        public abstract boolean a(int i, int i2);
    }

    /* loaded from: classes.dex */
    public interface s {
        boolean a(RecyclerView recyclerView, MotionEvent motionEvent);

        void b(RecyclerView recyclerView, MotionEvent motionEvent);

        void c(boolean z);
    }

    /* loaded from: classes.dex */
    public static abstract class t {
        public void a(RecyclerView recyclerView, int i) {
        }

        public void b(RecyclerView recyclerView, int i, int i2) {
        }
    }

    /* loaded from: classes.dex */
    public static class u {

        /* renamed from: a  reason: collision with root package name */
        SparseArray<a> f1152a = new SparseArray<>();

        /* renamed from: b  reason: collision with root package name */
        private int f1153b = 0;

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public static class a {

            /* renamed from: a  reason: collision with root package name */
            final ArrayList<c0> f1154a = new ArrayList<>();

            /* renamed from: b  reason: collision with root package name */
            int f1155b = 5;

            /* renamed from: c  reason: collision with root package name */
            long f1156c = 0;

            /* renamed from: d  reason: collision with root package name */
            long f1157d = 0;

            a() {
            }
        }

        private a g(int i) {
            a aVar = this.f1152a.get(i);
            if (aVar == null) {
                a aVar2 = new a();
                this.f1152a.put(i, aVar2);
                return aVar2;
            }
            return aVar;
        }

        void a() {
            this.f1153b++;
        }

        public void b() {
            for (int i = 0; i < this.f1152a.size(); i++) {
                this.f1152a.valueAt(i).f1154a.clear();
            }
        }

        void c() {
            this.f1153b--;
        }

        void d(int i, long j) {
            a g = g(i);
            g.f1157d = j(g.f1157d, j);
        }

        void e(int i, long j) {
            a g = g(i);
            g.f1156c = j(g.f1156c, j);
        }

        public c0 f(int i) {
            a aVar = this.f1152a.get(i);
            if (aVar == null || aVar.f1154a.isEmpty()) {
                return null;
            }
            ArrayList<c0> arrayList = aVar.f1154a;
            return arrayList.remove(arrayList.size() - 1);
        }

        void h(g gVar, g gVar2, boolean z) {
            if (gVar != null) {
                c();
            }
            if (!z && this.f1153b == 0) {
                b();
            }
            if (gVar2 != null) {
                a();
            }
        }

        public void i(c0 c0Var) {
            int l = c0Var.l();
            ArrayList<c0> arrayList = g(l).f1154a;
            if (this.f1152a.get(l).f1155b <= arrayList.size()) {
                return;
            }
            c0Var.D();
            arrayList.add(c0Var);
        }

        long j(long j, long j2) {
            return j == 0 ? j2 : ((j / 4) * 3) + (j2 / 4);
        }

        boolean k(int i, long j, long j2) {
            long j3 = g(i).f1157d;
            return j3 == 0 || j + j3 < j2;
        }

        boolean l(int i, long j, long j2) {
            long j3 = g(i).f1156c;
            return j3 == 0 || j + j3 < j2;
        }
    }

    /* loaded from: classes.dex */
    public final class v {

        /* renamed from: a  reason: collision with root package name */
        final ArrayList<c0> f1158a;

        /* renamed from: b  reason: collision with root package name */
        ArrayList<c0> f1159b;

        /* renamed from: c  reason: collision with root package name */
        final ArrayList<c0> f1160c;

        /* renamed from: d  reason: collision with root package name */
        private final List<c0> f1161d;
        private int e;
        int f;
        u g;
        private a0 h;

        public v() {
            ArrayList<c0> arrayList = new ArrayList<>();
            this.f1158a = arrayList;
            this.f1159b = null;
            this.f1160c = new ArrayList<>();
            this.f1161d = Collections.unmodifiableList(arrayList);
            this.e = 2;
            this.f = 2;
        }

        private boolean H(c0 c0Var, int i, int i2, long j) {
            c0Var.s = RecyclerView.this;
            int l = c0Var.l();
            long nanoTime = RecyclerView.this.getNanoTime();
            if (j == Long.MAX_VALUE || this.g.k(l, nanoTime, j)) {
                RecyclerView.this.m.a(c0Var, i);
                this.g.d(c0Var.l(), RecyclerView.this.getNanoTime() - nanoTime);
                b(c0Var);
                if (RecyclerView.this.i0.e()) {
                    c0Var.h = i2;
                    return true;
                }
                return true;
            }
            return false;
        }

        private void b(c0 c0Var) {
            if (RecyclerView.this.u0()) {
                View view = c0Var.f1123b;
                if (a.f.l.r.o(view) == 0) {
                    a.f.l.r.Y(view, 1);
                }
                if (a.f.l.r.z(view)) {
                    return;
                }
                c0Var.b(16384);
                a.f.l.r.O(view, RecyclerView.this.p0.k());
            }
        }

        private void q(ViewGroup viewGroup, boolean z) {
            for (int childCount = viewGroup.getChildCount() - 1; childCount >= 0; childCount--) {
                View childAt = viewGroup.getChildAt(childCount);
                if (childAt instanceof ViewGroup) {
                    q((ViewGroup) childAt, true);
                }
            }
            if (z) {
                if (viewGroup.getVisibility() == 4) {
                    viewGroup.setVisibility(0);
                    viewGroup.setVisibility(4);
                    return;
                }
                int visibility = viewGroup.getVisibility();
                viewGroup.setVisibility(4);
                viewGroup.setVisibility(visibility);
            }
        }

        private void r(c0 c0Var) {
            View view = c0Var.f1123b;
            if (view instanceof ViewGroup) {
                q((ViewGroup) view, false);
            }
        }

        void A(int i) {
            a(this.f1160c.get(i), true);
            this.f1160c.remove(i);
        }

        public void B(View view) {
            c0 f0 = RecyclerView.f0(view);
            if (f0.x()) {
                RecyclerView.this.removeDetachedView(view, false);
            }
            if (f0.w()) {
                f0.K();
            } else if (f0.L()) {
                f0.e();
            }
            C(f0);
        }

        void C(c0 c0Var) {
            boolean z;
            boolean z2 = true;
            if (c0Var.w() || c0Var.f1123b.getParent() != null) {
                StringBuilder sb = new StringBuilder();
                sb.append("Scrapped or attached views may not be recycled. isScrap:");
                sb.append(c0Var.w());
                sb.append(" isAttached:");
                sb.append(c0Var.f1123b.getParent() != null);
                sb.append(RecyclerView.this.R());
                throw new IllegalArgumentException(sb.toString());
            } else if (c0Var.x()) {
                throw new IllegalArgumentException("Tmp detached view should be removed from RecyclerView before it can be recycled: " + c0Var + RecyclerView.this.R());
            } else if (c0Var.J()) {
                throw new IllegalArgumentException("Trying to recycle an ignored view holder. You should first call stopIgnoringView(view) before calling recycle." + RecyclerView.this.R());
            } else {
                boolean h = c0Var.h();
                g gVar = RecyclerView.this.m;
                if ((gVar != null && h && gVar.p(c0Var)) || c0Var.u()) {
                    if (this.f <= 0 || c0Var.q(526)) {
                        z = false;
                    } else {
                        int size = this.f1160c.size();
                        if (size >= this.f && size > 0) {
                            A(0);
                            size--;
                        }
                        if (RecyclerView.F0 && size > 0 && !RecyclerView.this.h0.d(c0Var.f1125d)) {
                            int i = size - 1;
                            while (i >= 0) {
                                if (!RecyclerView.this.h0.d(this.f1160c.get(i).f1125d)) {
                                    break;
                                }
                                i--;
                            }
                            size = i + 1;
                        }
                        this.f1160c.add(size, c0Var);
                        z = true;
                    }
                    if (z) {
                        z2 = false;
                    } else {
                        a(c0Var, true);
                    }
                    r1 = z;
                } else {
                    z2 = false;
                }
                RecyclerView.this.g.q(c0Var);
                if (r1 || z2 || !h) {
                    return;
                }
                c0Var.s = null;
            }
        }

        void D(View view) {
            ArrayList<c0> arrayList;
            c0 f0 = RecyclerView.f0(view);
            if (!f0.q(12) && f0.y() && !RecyclerView.this.q(f0)) {
                if (this.f1159b == null) {
                    this.f1159b = new ArrayList<>();
                }
                f0.H(this, true);
                arrayList = this.f1159b;
            } else if (f0.t() && !f0.v() && !RecyclerView.this.m.f()) {
                throw new IllegalArgumentException("Called scrap view with an invalid view. Invalid views cannot be reused from scrap, they should rebound from recycler pool." + RecyclerView.this.R());
            } else {
                f0.H(this, false);
                arrayList = this.f1158a;
            }
            arrayList.add(f0);
        }

        void E(u uVar) {
            u uVar2 = this.g;
            if (uVar2 != null) {
                uVar2.c();
            }
            this.g = uVar;
            if (uVar == null || RecyclerView.this.getAdapter() == null) {
                return;
            }
            this.g.a();
        }

        void F(a0 a0Var) {
        }

        public void G(int i) {
            this.e = i;
            K();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* JADX WARN: Removed duplicated region for block: B:101:0x0211  */
        /* JADX WARN: Removed duplicated region for block: B:107:0x0226 A[ADDED_TO_REGION] */
        /* JADX WARN: Removed duplicated region for block: B:18:0x0037  */
        /* JADX WARN: Removed duplicated region for block: B:27:0x005c  */
        /* JADX WARN: Removed duplicated region for block: B:29:0x005f  */
        /* JADX WARN: Removed duplicated region for block: B:76:0x018a  */
        /* JADX WARN: Removed duplicated region for block: B:82:0x01a7  */
        /* JADX WARN: Removed duplicated region for block: B:85:0x01ca  */
        /* JADX WARN: Removed duplicated region for block: B:90:0x01d9  */
        /* JADX WARN: Removed duplicated region for block: B:99:0x0203  */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public androidx.recyclerview.widget.RecyclerView.c0 I(int r17, boolean r18, long r19) {
            /*
                Method dump skipped, instructions count: 613
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.v.I(int, boolean, long):androidx.recyclerview.widget.RecyclerView$c0");
        }

        void J(c0 c0Var) {
            (c0Var.p ? this.f1159b : this.f1158a).remove(c0Var);
            c0Var.o = null;
            c0Var.p = false;
            c0Var.e();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void K() {
            o oVar = RecyclerView.this.n;
            this.f = this.e + (oVar != null ? oVar.m : 0);
            for (int size = this.f1160c.size() - 1; size >= 0 && this.f1160c.size() > this.f; size--) {
                A(size);
            }
        }

        boolean L(c0 c0Var) {
            if (c0Var.v()) {
                return RecyclerView.this.i0.e();
            }
            int i = c0Var.f1125d;
            if (i >= 0 && i < RecyclerView.this.m.c()) {
                if (RecyclerView.this.i0.e() || RecyclerView.this.m.e(c0Var.f1125d) == c0Var.l()) {
                    return !RecyclerView.this.m.f() || c0Var.k() == RecyclerView.this.m.d(c0Var.f1125d);
                }
                return false;
            }
            throw new IndexOutOfBoundsException("Inconsistency detected. Invalid view holder adapter position" + c0Var + RecyclerView.this.R());
        }

        void M(int i, int i2) {
            int i3;
            int i4 = i2 + i;
            for (int size = this.f1160c.size() - 1; size >= 0; size--) {
                c0 c0Var = this.f1160c.get(size);
                if (c0Var != null && (i3 = c0Var.f1125d) >= i && i3 < i4) {
                    c0Var.b(2);
                    A(size);
                }
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void a(c0 c0Var, boolean z) {
            RecyclerView.s(c0Var);
            if (c0Var.q(16384)) {
                c0Var.F(0, 16384);
                a.f.l.r.O(c0Var.f1123b, null);
            }
            if (z) {
                g(c0Var);
            }
            c0Var.s = null;
            i().i(c0Var);
        }

        public void c() {
            this.f1158a.clear();
            z();
        }

        void d() {
            int size = this.f1160c.size();
            for (int i = 0; i < size; i++) {
                this.f1160c.get(i).c();
            }
            int size2 = this.f1158a.size();
            for (int i2 = 0; i2 < size2; i2++) {
                this.f1158a.get(i2).c();
            }
            ArrayList<c0> arrayList = this.f1159b;
            if (arrayList != null) {
                int size3 = arrayList.size();
                for (int i3 = 0; i3 < size3; i3++) {
                    this.f1159b.get(i3).c();
                }
            }
        }

        void e() {
            this.f1158a.clear();
            ArrayList<c0> arrayList = this.f1159b;
            if (arrayList != null) {
                arrayList.clear();
            }
        }

        public int f(int i) {
            if (i >= 0 && i < RecyclerView.this.i0.b()) {
                return !RecyclerView.this.i0.e() ? i : RecyclerView.this.e.m(i);
            }
            throw new IndexOutOfBoundsException("invalid position " + i + ". State item count is " + RecyclerView.this.i0.b() + RecyclerView.this.R());
        }

        void g(c0 c0Var) {
            w wVar = RecyclerView.this.o;
            if (wVar != null) {
                wVar.a(c0Var);
            }
            g gVar = RecyclerView.this.m;
            if (gVar != null) {
                gVar.s(c0Var);
            }
            RecyclerView recyclerView = RecyclerView.this;
            if (recyclerView.i0 != null) {
                recyclerView.g.q(c0Var);
            }
        }

        c0 h(int i) {
            int size;
            int m;
            ArrayList<c0> arrayList = this.f1159b;
            if (arrayList != null && (size = arrayList.size()) != 0) {
                for (int i2 = 0; i2 < size; i2++) {
                    c0 c0Var = this.f1159b.get(i2);
                    if (!c0Var.L() && c0Var.m() == i) {
                        c0Var.b(32);
                        return c0Var;
                    }
                }
                if (RecyclerView.this.m.f() && (m = RecyclerView.this.e.m(i)) > 0 && m < RecyclerView.this.m.c()) {
                    long d2 = RecyclerView.this.m.d(m);
                    for (int i3 = 0; i3 < size; i3++) {
                        c0 c0Var2 = this.f1159b.get(i3);
                        if (!c0Var2.L() && c0Var2.k() == d2) {
                            c0Var2.b(32);
                            return c0Var2;
                        }
                    }
                }
            }
            return null;
        }

        u i() {
            if (this.g == null) {
                this.g = new u();
            }
            return this.g;
        }

        int j() {
            return this.f1158a.size();
        }

        public List<c0> k() {
            return this.f1161d;
        }

        c0 l(long j, int i, boolean z) {
            for (int size = this.f1158a.size() - 1; size >= 0; size--) {
                c0 c0Var = this.f1158a.get(size);
                if (c0Var.k() == j && !c0Var.L()) {
                    if (i == c0Var.l()) {
                        c0Var.b(32);
                        if (c0Var.v() && !RecyclerView.this.i0.e()) {
                            c0Var.F(2, 14);
                        }
                        return c0Var;
                    } else if (!z) {
                        this.f1158a.remove(size);
                        RecyclerView.this.removeDetachedView(c0Var.f1123b, false);
                        y(c0Var.f1123b);
                    }
                }
            }
            int size2 = this.f1160c.size();
            while (true) {
                size2--;
                if (size2 < 0) {
                    return null;
                }
                c0 c0Var2 = this.f1160c.get(size2);
                if (c0Var2.k() == j) {
                    if (i == c0Var2.l()) {
                        if (!z) {
                            this.f1160c.remove(size2);
                        }
                        return c0Var2;
                    } else if (!z) {
                        A(size2);
                        return null;
                    }
                }
            }
        }

        c0 m(int i, boolean z) {
            View e;
            int size = this.f1158a.size();
            for (int i2 = 0; i2 < size; i2++) {
                c0 c0Var = this.f1158a.get(i2);
                if (!c0Var.L() && c0Var.m() == i && !c0Var.t() && (RecyclerView.this.i0.h || !c0Var.v())) {
                    c0Var.b(32);
                    return c0Var;
                }
            }
            if (z || (e = RecyclerView.this.f.e(i)) == null) {
                int size2 = this.f1160c.size();
                for (int i3 = 0; i3 < size2; i3++) {
                    c0 c0Var2 = this.f1160c.get(i3);
                    if (!c0Var2.t() && c0Var2.m() == i) {
                        if (!z) {
                            this.f1160c.remove(i3);
                        }
                        return c0Var2;
                    }
                }
                return null;
            }
            c0 f0 = RecyclerView.f0(e);
            RecyclerView.this.f.s(e);
            int m = RecyclerView.this.f.m(e);
            if (m != -1) {
                RecyclerView.this.f.d(m);
                D(e);
                f0.b(8224);
                return f0;
            }
            throw new IllegalStateException("layout index should not be -1 after unhiding a view:" + f0 + RecyclerView.this.R());
        }

        View n(int i) {
            return this.f1158a.get(i).f1123b;
        }

        public View o(int i) {
            return p(i, false);
        }

        View p(int i, boolean z) {
            return I(i, z, Long.MAX_VALUE).f1123b;
        }

        void s() {
            int size = this.f1160c.size();
            for (int i = 0; i < size; i++) {
                p pVar = (p) this.f1160c.get(i).f1123b.getLayoutParams();
                if (pVar != null) {
                    pVar.f1150c = true;
                }
            }
        }

        void t() {
            int size = this.f1160c.size();
            for (int i = 0; i < size; i++) {
                c0 c0Var = this.f1160c.get(i);
                if (c0Var != null) {
                    c0Var.b(6);
                    c0Var.a(null);
                }
            }
            g gVar = RecyclerView.this.m;
            if (gVar == null || !gVar.f()) {
                z();
            }
        }

        void u(int i, int i2) {
            int size = this.f1160c.size();
            for (int i3 = 0; i3 < size; i3++) {
                c0 c0Var = this.f1160c.get(i3);
                if (c0Var != null && c0Var.f1125d >= i) {
                    c0Var.A(i2, true);
                }
            }
        }

        void v(int i, int i2) {
            int i3;
            int i4;
            int i5;
            int i6;
            if (i < i2) {
                i3 = -1;
                i5 = i;
                i4 = i2;
            } else {
                i3 = 1;
                i4 = i;
                i5 = i2;
            }
            int size = this.f1160c.size();
            for (int i7 = 0; i7 < size; i7++) {
                c0 c0Var = this.f1160c.get(i7);
                if (c0Var != null && (i6 = c0Var.f1125d) >= i5 && i6 <= i4) {
                    if (i6 == i) {
                        c0Var.A(i2 - i, false);
                    } else {
                        c0Var.A(i3, false);
                    }
                }
            }
        }

        void w(int i, int i2, boolean z) {
            int i3 = i + i2;
            for (int size = this.f1160c.size() - 1; size >= 0; size--) {
                c0 c0Var = this.f1160c.get(size);
                if (c0Var != null) {
                    int i4 = c0Var.f1125d;
                    if (i4 >= i3) {
                        c0Var.A(-i2, z);
                    } else if (i4 >= i) {
                        c0Var.b(8);
                        A(size);
                    }
                }
            }
        }

        void x(g gVar, g gVar2, boolean z) {
            c();
            i().h(gVar, gVar2, z);
        }

        void y(View view) {
            c0 f0 = RecyclerView.f0(view);
            f0.o = null;
            f0.p = false;
            f0.e();
            C(f0);
        }

        void z() {
            for (int size = this.f1160c.size() - 1; size >= 0; size--) {
                A(size);
            }
            this.f1160c.clear();
            if (RecyclerView.F0) {
                RecyclerView.this.h0.b();
            }
        }
    }

    /* loaded from: classes.dex */
    public interface w {
        void a(c0 c0Var);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class x extends i {
        x() {
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void a() {
            RecyclerView.this.p(null);
            RecyclerView recyclerView = RecyclerView.this;
            recyclerView.i0.g = true;
            recyclerView.P0(true);
            if (RecyclerView.this.e.p()) {
                return;
            }
            RecyclerView.this.requestLayout();
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void c(int i, int i2, Object obj) {
            RecyclerView.this.p(null);
            if (RecyclerView.this.e.r(i, i2, obj)) {
                e();
            }
        }

        @Override // androidx.recyclerview.widget.RecyclerView.i
        public void d(int i, int i2) {
            RecyclerView.this.p(null);
            if (RecyclerView.this.e.s(i, i2)) {
                e();
            }
        }

        void e() {
            if (RecyclerView.E0) {
                RecyclerView recyclerView = RecyclerView.this;
                if (recyclerView.t && recyclerView.s) {
                    a.f.l.r.L(recyclerView, recyclerView.i);
                    return;
                }
            }
            RecyclerView recyclerView2 = RecyclerView.this;
            recyclerView2.B = true;
            recyclerView2.requestLayout();
        }
    }

    /* loaded from: classes.dex */
    public static abstract class y {
        public abstract int a();

        public abstract boolean b();

        public abstract boolean c();

        abstract void d(int i, int i2);

        protected abstract void e(View view);

        public abstract void f(int i);

        protected final void g() {
            throw null;
        }
    }

    /* loaded from: classes.dex */
    public static class z {

        /* renamed from: b  reason: collision with root package name */
        private SparseArray<Object> f1164b;
        int m;
        long n;
        int o;
        int p;
        int q;

        /* renamed from: a  reason: collision with root package name */
        int f1163a = -1;

        /* renamed from: c  reason: collision with root package name */
        int f1165c = 0;

        /* renamed from: d  reason: collision with root package name */
        int f1166d = 0;
        int e = 1;
        int f = 0;
        boolean g = false;
        boolean h = false;
        boolean i = false;
        boolean j = false;
        boolean k = false;
        boolean l = false;

        void a(int i) {
            if ((this.e & i) != 0) {
                return;
            }
            throw new IllegalStateException("Layout state should be one of " + Integer.toBinaryString(i) + " but it is " + Integer.toBinaryString(this.e));
        }

        public int b() {
            return this.h ? this.f1165c - this.f1166d : this.f;
        }

        public int c() {
            return this.f1163a;
        }

        public boolean d() {
            return this.f1163a != -1;
        }

        public boolean e() {
            return this.h;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        public void f(g gVar) {
            this.e = 1;
            this.f = gVar.c();
            this.h = false;
            this.i = false;
            this.j = false;
        }

        public boolean g() {
            return this.l;
        }

        public String toString() {
            return "State{mTargetPosition=" + this.f1163a + ", mData=" + this.f1164b + ", mItemCount=" + this.f + ", mIsMeasuring=" + this.j + ", mPreviousLayoutItemCount=" + this.f1165c + ", mDeletedInvisibleItemCountSincePreviousLayout=" + this.f1166d + ", mStructureChanged=" + this.g + ", mInPreLayout=" + this.h + ", mRunSimpleAnimations=" + this.k + ", mRunPredictiveAnimations=" + this.l + '}';
        }
    }

    static {
        int i2 = Build.VERSION.SDK_INT;
        C0 = i2 == 18 || i2 == 19 || i2 == 20;
        D0 = i2 >= 23;
        E0 = i2 >= 16;
        F0 = i2 >= 21;
        G0 = i2 <= 15;
        H0 = i2 <= 15;
        Class<?> cls = Integer.TYPE;
        I0 = new Class[]{Context.class, AttributeSet.class, cls, cls};
        J0 = new c();
    }

    public RecyclerView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public RecyclerView(Context context, AttributeSet attributeSet, int i2) {
        super(context, attributeSet, i2);
        this.f1114b = new x();
        this.f1115c = new v();
        this.g = new androidx.recyclerview.widget.n();
        this.i = new a();
        this.j = new Rect();
        this.k = new Rect();
        this.l = new RectF();
        this.p = new ArrayList<>();
        this.q = new ArrayList<>();
        this.w = 0;
        this.E = false;
        this.F = false;
        this.G = 0;
        this.H = 0;
        this.I = new k();
        this.N = new androidx.recyclerview.widget.c();
        this.O = 0;
        this.P = -1;
        this.c0 = Float.MIN_VALUE;
        this.d0 = Float.MIN_VALUE;
        boolean z2 = true;
        this.e0 = true;
        this.f0 = new b0();
        this.h0 = F0 ? new f.b() : null;
        this.i0 = new z();
        this.l0 = false;
        this.m0 = false;
        this.n0 = new m();
        this.o0 = false;
        this.r0 = new int[2];
        this.t0 = new int[2];
        this.u0 = new int[2];
        this.v0 = new int[2];
        this.w0 = new int[2];
        this.x0 = new ArrayList();
        this.y0 = new b();
        this.z0 = new d();
        if (attributeSet != null) {
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, B0, i2, 0);
            this.h = obtainStyledAttributes.getBoolean(0, true);
            obtainStyledAttributes.recycle();
        } else {
            this.h = true;
        }
        setScrollContainer(true);
        setFocusableInTouchMode(true);
        ViewConfiguration viewConfiguration = ViewConfiguration.get(context);
        this.V = viewConfiguration.getScaledTouchSlop();
        this.c0 = a.f.l.s.b(viewConfiguration, context);
        this.d0 = a.f.l.s.d(viewConfiguration, context);
        this.a0 = viewConfiguration.getScaledMinimumFlingVelocity();
        this.b0 = viewConfiguration.getScaledMaximumFlingVelocity();
        setWillNotDraw(getOverScrollMode() == 2);
        this.N.v(this.n0);
        p0();
        r0();
        q0();
        if (a.f.l.r.o(this) == 0) {
            a.f.l.r.Y(this, 1);
        }
        this.C = (AccessibilityManager) getContext().getSystemService("accessibility");
        setAccessibilityDelegateCompat(new androidx.recyclerview.widget.j(this));
        if (attributeSet != null) {
            TypedArray obtainStyledAttributes2 = context.obtainStyledAttributes(attributeSet, a.k.b.RecyclerView, i2, 0);
            String string = obtainStyledAttributes2.getString(a.k.b.RecyclerView_layoutManager);
            if (obtainStyledAttributes2.getInt(a.k.b.RecyclerView_android_descendantFocusability, -1) == -1) {
                setDescendantFocusability(262144);
            }
            boolean z3 = obtainStyledAttributes2.getBoolean(a.k.b.RecyclerView_fastScrollEnabled, false);
            this.u = z3;
            if (z3) {
                s0((StateListDrawable) obtainStyledAttributes2.getDrawable(a.k.b.RecyclerView_fastScrollVerticalThumbDrawable), obtainStyledAttributes2.getDrawable(a.k.b.RecyclerView_fastScrollVerticalTrackDrawable), (StateListDrawable) obtainStyledAttributes2.getDrawable(a.k.b.RecyclerView_fastScrollHorizontalThumbDrawable), obtainStyledAttributes2.getDrawable(a.k.b.RecyclerView_fastScrollHorizontalTrackDrawable));
            }
            obtainStyledAttributes2.recycle();
            w(context, string, attributeSet, i2, 0);
            if (Build.VERSION.SDK_INT >= 21) {
                TypedArray obtainStyledAttributes3 = context.obtainStyledAttributes(attributeSet, A0, i2, 0);
                boolean z4 = obtainStyledAttributes3.getBoolean(0, true);
                obtainStyledAttributes3.recycle();
                z2 = z4;
            }
        } else {
            setDescendantFocusability(262144);
        }
        setNestedScrollingEnabled(z2);
    }

    private void B() {
        int i2 = this.A;
        this.A = 0;
        if (i2 == 0 || !u0()) {
            return;
        }
        AccessibilityEvent obtain = AccessibilityEvent.obtain();
        obtain.setEventType(2048);
        a.f.l.a0.a.b(obtain, i2);
        sendAccessibilityEventUnchecked(obtain);
    }

    private void D() {
        boolean z2 = true;
        this.i0.a(1);
        S(this.i0);
        this.i0.j = false;
        n1();
        this.g.f();
        G0();
        O0();
        d1();
        z zVar = this.i0;
        zVar.i = (zVar.k && this.m0) ? false : false;
        this.m0 = false;
        this.l0 = false;
        zVar.h = zVar.l;
        zVar.f = this.m.c();
        V(this.r0);
        if (this.i0.k) {
            int g2 = this.f.g();
            for (int i2 = 0; i2 < g2; i2++) {
                c0 f0 = f0(this.f.f(i2));
                if (!f0.J() && (!f0.t() || this.m.f())) {
                    this.g.e(f0, this.N.t(this.i0, f0, l.e(f0), f0.p()));
                    if (this.i0.i && f0.y() && !f0.v() && !f0.J() && !f0.t()) {
                        this.g.c(d0(f0), f0);
                    }
                }
            }
        }
        if (this.i0.l) {
            e1();
            z zVar2 = this.i0;
            boolean z3 = zVar2.g;
            zVar2.g = false;
            this.n.V0(this.f1115c, zVar2);
            this.i0.g = z3;
            for (int i3 = 0; i3 < this.f.g(); i3++) {
                c0 f02 = f0(this.f.f(i3));
                if (!f02.J() && !this.g.i(f02)) {
                    int e2 = l.e(f02);
                    boolean q2 = f02.q(8192);
                    if (!q2) {
                        e2 |= 4096;
                    }
                    l.c t2 = this.N.t(this.i0, f02, e2, f02.p());
                    if (q2) {
                        R0(f02, t2);
                    } else {
                        this.g.a(f02, t2);
                    }
                }
            }
        }
        t();
        H0();
        p1(false);
        this.i0.e = 2;
    }

    private void E() {
        n1();
        G0();
        this.i0.a(6);
        this.e.j();
        this.i0.f = this.m.c();
        z zVar = this.i0;
        zVar.f1166d = 0;
        zVar.h = false;
        this.n.V0(this.f1115c, zVar);
        z zVar2 = this.i0;
        zVar2.g = false;
        this.f1116d = null;
        zVar2.k = zVar2.k && this.N != null;
        zVar2.e = 4;
        H0();
        p1(false);
    }

    private void F() {
        this.i0.a(4);
        n1();
        G0();
        z zVar = this.i0;
        zVar.e = 1;
        if (zVar.k) {
            for (int g2 = this.f.g() - 1; g2 >= 0; g2--) {
                c0 f0 = f0(this.f.f(g2));
                if (!f0.J()) {
                    long d0 = d0(f0);
                    l.c s2 = this.N.s(this.i0, f0);
                    c0 g3 = this.g.g(d0);
                    if (g3 != null && !g3.J()) {
                        boolean h2 = this.g.h(g3);
                        boolean h3 = this.g.h(f0);
                        if (!h2 || g3 != f0) {
                            l.c n2 = this.g.n(g3);
                            this.g.d(f0, s2);
                            l.c m2 = this.g.m(f0);
                            if (n2 == null) {
                                l0(d0, f0, g3);
                            } else {
                                n(g3, f0, n2, m2, h2, h3);
                            }
                        }
                    }
                    this.g.d(f0, s2);
                }
            }
            this.g.o(this.z0);
        }
        this.n.i1(this.f1115c);
        z zVar2 = this.i0;
        zVar2.f1165c = zVar2.f;
        this.E = false;
        this.F = false;
        zVar2.k = false;
        zVar2.l = false;
        this.n.h = false;
        ArrayList<c0> arrayList = this.f1115c.f1159b;
        if (arrayList != null) {
            arrayList.clear();
        }
        o oVar = this.n;
        if (oVar.n) {
            oVar.m = 0;
            oVar.n = false;
            this.f1115c.K();
        }
        this.n.W0(this.i0);
        H0();
        p1(false);
        this.g.f();
        int[] iArr = this.r0;
        if (y(iArr[0], iArr[1])) {
            L(0, 0);
        }
        S0();
        b1();
    }

    private boolean I(MotionEvent motionEvent) {
        int action = motionEvent.getAction();
        s sVar = this.r;
        if (sVar != null) {
            if (action != 0) {
                sVar.b(this, motionEvent);
                if (action == 3 || action == 1) {
                    this.r = null;
                }
                return true;
            }
            this.r = null;
        }
        if (action != 0) {
            int size = this.q.size();
            for (int i2 = 0; i2 < size; i2++) {
                s sVar2 = this.q.get(i2);
                if (sVar2.a(this, motionEvent)) {
                    this.r = sVar2;
                    return true;
                }
            }
        }
        return false;
    }

    private boolean J(MotionEvent motionEvent) {
        int action = motionEvent.getAction();
        if (action == 3 || action == 0) {
            this.r = null;
        }
        int size = this.q.size();
        for (int i2 = 0; i2 < size; i2++) {
            s sVar = this.q.get(i2);
            if (sVar.a(this, motionEvent) && action != 3) {
                this.r = sVar;
                return true;
            }
        }
        return false;
    }

    private void J0(MotionEvent motionEvent) {
        int actionIndex = motionEvent.getActionIndex();
        if (motionEvent.getPointerId(actionIndex) == this.P) {
            int i2 = actionIndex == 0 ? 1 : 0;
            this.P = motionEvent.getPointerId(i2);
            int x2 = (int) (motionEvent.getX(i2) + 0.5f);
            this.T = x2;
            this.R = x2;
            int y2 = (int) (motionEvent.getY(i2) + 0.5f);
            this.U = y2;
            this.S = y2;
        }
    }

    private boolean N0() {
        return this.N != null && this.n.G1();
    }

    private void O0() {
        boolean z2;
        if (this.E) {
            this.e.w();
            if (this.F) {
                this.n.Q0(this);
            }
        }
        if (N0()) {
            this.e.u();
        } else {
            this.e.j();
        }
        boolean z3 = false;
        boolean z4 = this.l0 || this.m0;
        this.i0.k = this.v && this.N != null && ((z2 = this.E) || z4 || this.n.h) && (!z2 || this.m.f());
        z zVar = this.i0;
        if (zVar.k && z4 && !this.E && N0()) {
            z3 = true;
        }
        zVar.l = z3;
    }

    /* JADX WARN: Removed duplicated region for block: B:12:0x003d  */
    /* JADX WARN: Removed duplicated region for block: B:13:0x0053  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void Q0(float r7, float r8, float r9, float r10) {
        /*
            r6 = this;
            r0 = 0
            int r1 = (r8 > r0 ? 1 : (r8 == r0 ? 0 : -1))
            r2 = 1065353216(0x3f800000, float:1.0)
            r3 = 1
            if (r1 >= 0) goto L21
            r6.O()
            android.widget.EdgeEffect r1 = r6.J
            float r4 = -r8
            int r5 = r6.getWidth()
            float r5 = (float) r5
            float r4 = r4 / r5
            int r5 = r6.getHeight()
            float r5 = (float) r5
            float r9 = r9 / r5
            float r9 = r2 - r9
        L1c:
            androidx.core.widget.d.a(r1, r4, r9)
            r9 = r3
            goto L39
        L21:
            int r1 = (r8 > r0 ? 1 : (r8 == r0 ? 0 : -1))
            if (r1 <= 0) goto L38
            r6.P()
            android.widget.EdgeEffect r1 = r6.L
            int r4 = r6.getWidth()
            float r4 = (float) r4
            float r4 = r8 / r4
            int r5 = r6.getHeight()
            float r5 = (float) r5
            float r9 = r9 / r5
            goto L1c
        L38:
            r9 = 0
        L39:
            int r1 = (r10 > r0 ? 1 : (r10 == r0 ? 0 : -1))
            if (r1 >= 0) goto L53
            r6.Q()
            android.widget.EdgeEffect r9 = r6.K
            float r1 = -r10
            int r2 = r6.getHeight()
            float r2 = (float) r2
            float r1 = r1 / r2
            int r2 = r6.getWidth()
            float r2 = (float) r2
            float r7 = r7 / r2
            androidx.core.widget.d.a(r9, r1, r7)
            goto L6f
        L53:
            int r1 = (r10 > r0 ? 1 : (r10 == r0 ? 0 : -1))
            if (r1 <= 0) goto L6e
            r6.N()
            android.widget.EdgeEffect r9 = r6.M
            int r1 = r6.getHeight()
            float r1 = (float) r1
            float r1 = r10 / r1
            int r4 = r6.getWidth()
            float r4 = (float) r4
            float r7 = r7 / r4
            float r2 = r2 - r7
            androidx.core.widget.d.a(r9, r1, r2)
            goto L6f
        L6e:
            r3 = r9
        L6f:
            if (r3 != 0) goto L79
            int r7 = (r8 > r0 ? 1 : (r8 == r0 ? 0 : -1))
            if (r7 != 0) goto L79
            int r7 = (r10 > r0 ? 1 : (r10 == r0 ? 0 : -1))
            if (r7 == 0) goto L7c
        L79:
            a.f.l.r.K(r6)
        L7c:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.Q0(float, float, float, float):void");
    }

    private void S0() {
        View findViewById;
        if (!this.e0 || this.m == null || !hasFocus() || getDescendantFocusability() == 393216) {
            return;
        }
        if (getDescendantFocusability() == 131072 && isFocused()) {
            return;
        }
        if (!isFocused()) {
            View focusedChild = getFocusedChild();
            if (!H0 || (focusedChild.getParent() != null && focusedChild.hasFocus())) {
                if (!this.f.n(focusedChild)) {
                    return;
                }
            } else if (this.f.g() == 0) {
                requestFocus();
                return;
            }
        }
        View view = null;
        c0 Z = (this.i0.n == -1 || !this.m.f()) ? null : Z(this.i0.n);
        if (Z != null && !this.f.n(Z.f1123b) && Z.f1123b.hasFocusable()) {
            view = Z.f1123b;
        } else if (this.f.g() > 0) {
            view = X();
        }
        if (view != null) {
            int i2 = this.i0.o;
            if (i2 != -1 && (findViewById = view.findViewById(i2)) != null && findViewById.isFocusable()) {
                view = findViewById;
            }
            view.requestFocus();
        }
    }

    private void T0() {
        boolean z2;
        EdgeEffect edgeEffect = this.J;
        if (edgeEffect != null) {
            edgeEffect.onRelease();
            z2 = this.J.isFinished();
        } else {
            z2 = false;
        }
        EdgeEffect edgeEffect2 = this.K;
        if (edgeEffect2 != null) {
            edgeEffect2.onRelease();
            z2 |= this.K.isFinished();
        }
        EdgeEffect edgeEffect3 = this.L;
        if (edgeEffect3 != null) {
            edgeEffect3.onRelease();
            z2 |= this.L.isFinished();
        }
        EdgeEffect edgeEffect4 = this.M;
        if (edgeEffect4 != null) {
            edgeEffect4.onRelease();
            z2 |= this.M.isFinished();
        }
        if (z2) {
            a.f.l.r.K(this);
        }
    }

    private void V(int[] iArr) {
        int g2 = this.f.g();
        if (g2 == 0) {
            iArr[0] = -1;
            iArr[1] = -1;
            return;
        }
        int i2 = Integer.MAX_VALUE;
        int i3 = Integer.MIN_VALUE;
        for (int i4 = 0; i4 < g2; i4++) {
            c0 f0 = f0(this.f.f(i4));
            if (!f0.J()) {
                int m2 = f0.m();
                if (m2 < i2) {
                    i2 = m2;
                }
                if (m2 > i3) {
                    i3 = m2;
                }
            }
        }
        iArr[0] = i2;
        iArr[1] = i3;
    }

    static RecyclerView W(View view) {
        if (view instanceof ViewGroup) {
            if (view instanceof RecyclerView) {
                return (RecyclerView) view;
            }
            ViewGroup viewGroup = (ViewGroup) view;
            int childCount = viewGroup.getChildCount();
            for (int i2 = 0; i2 < childCount; i2++) {
                RecyclerView W = W(viewGroup.getChildAt(i2));
                if (W != null) {
                    return W;
                }
            }
            return null;
        }
        return null;
    }

    private View X() {
        c0 Y;
        z zVar = this.i0;
        int i2 = zVar.m;
        if (i2 == -1) {
            i2 = 0;
        }
        int b2 = zVar.b();
        for (int i3 = i2; i3 < b2; i3++) {
            c0 Y2 = Y(i3);
            if (Y2 == null) {
                break;
            } else if (Y2.f1123b.hasFocusable()) {
                return Y2.f1123b;
            }
        }
        int min = Math.min(b2, i2);
        while (true) {
            min--;
            if (min < 0 || (Y = Y(min)) == null) {
                return null;
            }
            if (Y.f1123b.hasFocusable()) {
                return Y.f1123b;
            }
        }
    }

    private void a1(View view, View view2) {
        View view3 = view2 != null ? view2 : view;
        this.j.set(0, 0, view3.getWidth(), view3.getHeight());
        ViewGroup.LayoutParams layoutParams = view3.getLayoutParams();
        if (layoutParams instanceof p) {
            p pVar = (p) layoutParams;
            if (!pVar.f1150c) {
                Rect rect = pVar.f1149b;
                Rect rect2 = this.j;
                rect2.left -= rect.left;
                rect2.right += rect.right;
                rect2.top -= rect.top;
                rect2.bottom += rect.bottom;
            }
        }
        if (view2 != null) {
            offsetDescendantRectToMyCoords(view2, this.j);
            offsetRectIntoDescendantCoords(view, this.j);
        }
        this.n.p1(this, view, this.j, !this.v, view2 == null);
    }

    private void b1() {
        z zVar = this.i0;
        zVar.n = -1L;
        zVar.m = -1;
        zVar.o = -1;
    }

    private void c1() {
        VelocityTracker velocityTracker = this.Q;
        if (velocityTracker != null) {
            velocityTracker.clear();
        }
        a(0);
        T0();
    }

    private void d1() {
        View focusedChild = (this.e0 && hasFocus() && this.m != null) ? getFocusedChild() : null;
        c0 U = focusedChild != null ? U(focusedChild) : null;
        if (U == null) {
            b1();
            return;
        }
        this.i0.n = this.m.f() ? U.k() : -1L;
        this.i0.m = this.E ? -1 : U.v() ? U.e : U.j();
        this.i0.o = i0(U.f1123b);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static c0 f0(View view) {
        if (view == null) {
            return null;
        }
        return ((p) view.getLayoutParams()).f1148a;
    }

    private a.f.l.k getScrollingChildHelper() {
        if (this.s0 == null) {
            this.s0 = new a.f.l.k(this);
        }
        return this.s0;
    }

    private void h(c0 c0Var) {
        View view = c0Var.f1123b;
        boolean z2 = view.getParent() == this;
        this.f1115c.J(e0(view));
        if (c0Var.x()) {
            this.f.c(view, -1, view.getLayoutParams(), true);
            return;
        }
        androidx.recyclerview.widget.b bVar = this.f;
        if (z2) {
            bVar.k(view);
        } else {
            bVar.b(view, true);
        }
    }

    static void h0(View view, Rect rect) {
        p pVar = (p) view.getLayoutParams();
        Rect rect2 = pVar.f1149b;
        rect.set((view.getLeft() - rect2.left) - ((ViewGroup.MarginLayoutParams) pVar).leftMargin, (view.getTop() - rect2.top) - ((ViewGroup.MarginLayoutParams) pVar).topMargin, view.getRight() + rect2.right + ((ViewGroup.MarginLayoutParams) pVar).rightMargin, view.getBottom() + rect2.bottom + ((ViewGroup.MarginLayoutParams) pVar).bottomMargin);
    }

    private int i0(View view) {
        int id;
        loop0: while (true) {
            id = view.getId();
            while (!view.isFocused() && (view instanceof ViewGroup) && view.hasFocus()) {
                view = ((ViewGroup) view).getFocusedChild();
                if (view.getId() != -1) {
                    break;
                }
            }
        }
        return id;
    }

    private void i1(g gVar, boolean z2, boolean z3) {
        g gVar2 = this.m;
        if (gVar2 != null) {
            gVar2.u(this.f1114b);
            this.m.o(this);
        }
        if (!z2 || z3) {
            U0();
        }
        this.e.w();
        g gVar3 = this.m;
        this.m = gVar;
        if (gVar != null) {
            gVar.t(this.f1114b);
            gVar.k(this);
        }
        o oVar = this.n;
        if (oVar != null) {
            oVar.C0(gVar3, this.m);
        }
        this.f1115c.x(gVar3, this.m, z2);
        this.i0.g = true;
    }

    private String j0(Context context, String str) {
        if (str.charAt(0) == '.') {
            return context.getPackageName() + str;
        } else if (str.contains(".")) {
            return str;
        } else {
            return RecyclerView.class.getPackage().getName() + '.' + str;
        }
    }

    private void l0(long j2, c0 c0Var, c0 c0Var2) {
        int g2 = this.f.g();
        for (int i2 = 0; i2 < g2; i2++) {
            c0 f0 = f0(this.f.f(i2));
            if (f0 != c0Var && d0(f0) == j2) {
                g gVar = this.m;
                if (gVar == null || !gVar.f()) {
                    throw new IllegalStateException("Two different ViewHolders have the same change ID. This might happen due to inconsistent Adapter update events or if the LayoutManager lays out the same View multiple times.\n ViewHolder 1:" + f0 + " \n View Holder 2:" + c0Var + R());
                }
                throw new IllegalStateException("Two different ViewHolders have the same stable ID. Stable IDs in your adapter MUST BE unique and SHOULD NOT change.\n ViewHolder 1:" + f0 + " \n View Holder 2:" + c0Var + R());
            }
        }
        Log.e("RecyclerView", "Problem while matching changed view holders with the newones. The pre-layout information for the change holder " + c0Var2 + " cannot be found but it is necessary for " + c0Var + R());
    }

    private void n(c0 c0Var, c0 c0Var2, l.c cVar, l.c cVar2, boolean z2, boolean z3) {
        c0Var.G(false);
        if (z2) {
            h(c0Var);
        }
        if (c0Var != c0Var2) {
            if (z3) {
                h(c0Var2);
            }
            c0Var.i = c0Var2;
            h(c0Var);
            this.f1115c.J(c0Var);
            c0Var2.G(false);
            c0Var2.j = c0Var;
        }
        if (this.N.b(c0Var, c0Var2, cVar, cVar2)) {
            M0();
        }
    }

    private boolean o0() {
        int g2 = this.f.g();
        for (int i2 = 0; i2 < g2; i2++) {
            c0 f0 = f0(this.f.f(i2));
            if (f0 != null && !f0.J() && f0.y()) {
                return true;
            }
        }
        return false;
    }

    @SuppressLint({"InlinedApi"})
    private void q0() {
        if (a.f.l.r.p(this) == 0) {
            a.f.l.r.Z(this, 8);
        }
    }

    private void r() {
        c1();
        setScrollState(0);
    }

    private void r0() {
        this.f = new androidx.recyclerview.widget.b(new e());
    }

    private void r1() {
        this.f0.i();
        o oVar = this.n;
        if (oVar != null) {
            oVar.F1();
        }
    }

    static void s(c0 c0Var) {
        WeakReference<RecyclerView> weakReference = c0Var.f1124c;
        if (weakReference != null) {
            ViewParent viewParent = weakReference.get();
            while (true) {
                for (View view = (View) viewParent; view != null; view = null) {
                    if (view == c0Var.f1123b) {
                        return;
                    }
                    viewParent = view.getParent();
                    if (viewParent instanceof View) {
                        break;
                    }
                }
                c0Var.f1124c = null;
                return;
            }
        }
    }

    private void w(Context context, String str, AttributeSet attributeSet, int i2, int i3) {
        Constructor constructor;
        if (str != null) {
            String trim = str.trim();
            if (trim.isEmpty()) {
                return;
            }
            String j0 = j0(context, trim);
            try {
                Class<? extends U> asSubclass = (isInEditMode() ? getClass().getClassLoader() : context.getClassLoader()).loadClass(j0).asSubclass(o.class);
                Object[] objArr = null;
                try {
                    constructor = asSubclass.getConstructor(I0);
                    objArr = new Object[]{context, attributeSet, Integer.valueOf(i2), Integer.valueOf(i3)};
                } catch (NoSuchMethodException e2) {
                    try {
                        constructor = asSubclass.getConstructor(new Class[0]);
                    } catch (NoSuchMethodException e3) {
                        e3.initCause(e2);
                        throw new IllegalStateException(attributeSet.getPositionDescription() + ": Error creating LayoutManager " + j0, e3);
                    }
                }
                constructor.setAccessible(true);
                setLayoutManager((o) constructor.newInstance(objArr));
            } catch (ClassCastException e4) {
                throw new IllegalStateException(attributeSet.getPositionDescription() + ": Class is not a LayoutManager " + j0, e4);
            } catch (ClassNotFoundException e5) {
                throw new IllegalStateException(attributeSet.getPositionDescription() + ": Unable to find LayoutManager " + j0, e5);
            } catch (IllegalAccessException e6) {
                throw new IllegalStateException(attributeSet.getPositionDescription() + ": Cannot access non-public constructor " + j0, e6);
            } catch (InstantiationException e7) {
                throw new IllegalStateException(attributeSet.getPositionDescription() + ": Could not instantiate the LayoutManager: " + j0, e7);
            } catch (InvocationTargetException e8) {
                throw new IllegalStateException(attributeSet.getPositionDescription() + ": Could not instantiate the LayoutManager: " + j0, e8);
            }
        }
    }

    private boolean w0(View view, View view2, int i2) {
        int i3;
        if (view2 == null || view2 == this || T(view2) == null) {
            return false;
        }
        if (view == null || T(view) == null) {
            return true;
        }
        this.j.set(0, 0, view.getWidth(), view.getHeight());
        this.k.set(0, 0, view2.getWidth(), view2.getHeight());
        offsetDescendantRectToMyCoords(view, this.j);
        offsetDescendantRectToMyCoords(view2, this.k);
        char c2 = 65535;
        int i4 = this.n.X() == 1 ? -1 : 1;
        Rect rect = this.j;
        int i5 = rect.left;
        Rect rect2 = this.k;
        int i6 = rect2.left;
        if ((i5 < i6 || rect.right <= i6) && rect.right < rect2.right) {
            i3 = 1;
        } else {
            int i7 = rect.right;
            int i8 = rect2.right;
            i3 = ((i7 > i8 || i5 >= i8) && i5 > i6) ? -1 : 0;
        }
        int i9 = rect.top;
        int i10 = rect2.top;
        if ((i9 < i10 || rect.bottom <= i10) && rect.bottom < rect2.bottom) {
            c2 = 1;
        } else {
            int i11 = rect.bottom;
            int i12 = rect2.bottom;
            if ((i11 <= i12 && i9 < i12) || i9 <= i10) {
                c2 = 0;
            }
        }
        if (i2 == 1) {
            return c2 < 0 || (c2 == 0 && i3 * i4 <= 0);
        } else if (i2 == 2) {
            return c2 > 0 || (c2 == 0 && i3 * i4 >= 0);
        } else if (i2 == 17) {
            return i3 < 0;
        } else if (i2 == 33) {
            return c2 < 0;
        } else if (i2 == 66) {
            return i3 > 0;
        } else if (i2 == 130) {
            return c2 > 0;
        } else {
            throw new IllegalArgumentException("Invalid direction: " + i2 + R());
        }
    }

    private boolean y(int i2, int i3) {
        V(this.r0);
        int[] iArr = this.r0;
        return (iArr[0] == i2 && iArr[1] == i3) ? false : true;
    }

    void A(View view) {
        c0 f0 = f0(view);
        F0(view);
        g gVar = this.m;
        if (gVar != null && f0 != null) {
            gVar.r(f0);
        }
        List<q> list = this.D;
        if (list != null) {
            for (int size = list.size() - 1; size >= 0; size--) {
                this.D.get(size).b(view);
            }
        }
    }

    public void A0(int i2) {
        int g2 = this.f.g();
        for (int i3 = 0; i3 < g2; i3++) {
            this.f.f(i3).offsetTopAndBottom(i2);
        }
    }

    void B0(int i2, int i3) {
        int j2 = this.f.j();
        for (int i4 = 0; i4 < j2; i4++) {
            c0 f0 = f0(this.f.i(i4));
            if (f0 != null && !f0.J() && f0.f1125d >= i2) {
                f0.A(i3, false);
                this.i0.g = true;
            }
        }
        this.f1115c.u(i2, i3);
        requestLayout();
    }

    void C() {
        String str;
        if (this.m == null) {
            str = "No adapter attached; skipping layout";
        } else if (this.n != null) {
            z zVar = this.i0;
            zVar.j = false;
            if (zVar.e == 1) {
                D();
            } else if (!this.e.q() && this.n.m0() == getWidth() && this.n.V() == getHeight()) {
                this.n.w1(this);
                F();
                return;
            }
            this.n.w1(this);
            E();
            F();
            return;
        } else {
            str = "No layout manager attached; skipping layout";
        }
        Log.e("RecyclerView", str);
    }

    void C0(int i2, int i3) {
        int i4;
        int i5;
        int i6;
        int i7;
        int j2 = this.f.j();
        if (i2 < i3) {
            i6 = -1;
            i5 = i2;
            i4 = i3;
        } else {
            i4 = i2;
            i5 = i3;
            i6 = 1;
        }
        for (int i8 = 0; i8 < j2; i8++) {
            c0 f0 = f0(this.f.i(i8));
            if (f0 != null && (i7 = f0.f1125d) >= i5 && i7 <= i4) {
                if (i7 == i2) {
                    f0.A(i3 - i2, false);
                } else {
                    f0.A(i6, false);
                }
                this.i0.g = true;
            }
        }
        this.f1115c.v(i2, i3);
        requestLayout();
    }

    void D0(int i2, int i3, boolean z2) {
        int i4 = i2 + i3;
        int j2 = this.f.j();
        for (int i5 = 0; i5 < j2; i5++) {
            c0 f0 = f0(this.f.i(i5));
            if (f0 != null && !f0.J()) {
                int i6 = f0.f1125d;
                if (i6 >= i4) {
                    f0.A(-i3, z2);
                } else if (i6 >= i2) {
                    f0.i(i2 - 1, -i3, z2);
                }
                this.i0.g = true;
            }
        }
        this.f1115c.w(i2, i3, z2);
        requestLayout();
    }

    public void E0(View view) {
    }

    public void F0(View view) {
    }

    public boolean G(int i2, int i3, int[] iArr, int[] iArr2, int i4) {
        return getScrollingChildHelper().d(i2, i3, iArr, iArr2, i4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void G0() {
        this.G++;
    }

    public boolean H(int i2, int i3, int i4, int i5, int[] iArr, int i6) {
        return getScrollingChildHelper().f(i2, i3, i4, i5, iArr, i6);
    }

    void H0() {
        I0(true);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void I0(boolean z2) {
        int i2 = this.G - 1;
        this.G = i2;
        if (i2 < 1) {
            this.G = 0;
            if (z2) {
                B();
                M();
            }
        }
    }

    void K(int i2) {
        o oVar = this.n;
        if (oVar != null) {
            oVar.c1(i2);
        }
        K0(i2);
        t tVar = this.j0;
        if (tVar != null) {
            tVar.a(this, i2);
        }
        List<t> list = this.k0;
        if (list != null) {
            for (int size = list.size() - 1; size >= 0; size--) {
                this.k0.get(size).a(this, i2);
            }
        }
    }

    public void K0(int i2) {
    }

    void L(int i2, int i3) {
        this.H++;
        int scrollX = getScrollX();
        int scrollY = getScrollY();
        onScrollChanged(scrollX, scrollY, scrollX, scrollY);
        L0(i2, i3);
        t tVar = this.j0;
        if (tVar != null) {
            tVar.b(this, i2, i3);
        }
        List<t> list = this.k0;
        if (list != null) {
            for (int size = list.size() - 1; size >= 0; size--) {
                this.k0.get(size).b(this, i2, i3);
            }
        }
        this.H--;
    }

    public void L0(int i2, int i3) {
    }

    void M() {
        int i2;
        for (int size = this.x0.size() - 1; size >= 0; size--) {
            c0 c0Var = this.x0.get(size);
            if (c0Var.f1123b.getParent() == this && !c0Var.J() && (i2 = c0Var.r) != -1) {
                a.f.l.r.Y(c0Var.f1123b, i2);
                c0Var.r = -1;
            }
        }
        this.x0.clear();
    }

    void M0() {
        if (this.o0 || !this.s) {
            return;
        }
        a.f.l.r.L(this, this.y0);
        this.o0 = true;
    }

    void N() {
        int measuredWidth;
        int measuredHeight;
        if (this.M != null) {
            return;
        }
        EdgeEffect a2 = this.I.a(this, 3);
        this.M = a2;
        if (this.h) {
            measuredWidth = (getMeasuredWidth() - getPaddingLeft()) - getPaddingRight();
            measuredHeight = (getMeasuredHeight() - getPaddingTop()) - getPaddingBottom();
        } else {
            measuredWidth = getMeasuredWidth();
            measuredHeight = getMeasuredHeight();
        }
        a2.setSize(measuredWidth, measuredHeight);
    }

    void O() {
        int measuredHeight;
        int measuredWidth;
        if (this.J != null) {
            return;
        }
        EdgeEffect a2 = this.I.a(this, 0);
        this.J = a2;
        if (this.h) {
            measuredHeight = (getMeasuredHeight() - getPaddingTop()) - getPaddingBottom();
            measuredWidth = (getMeasuredWidth() - getPaddingLeft()) - getPaddingRight();
        } else {
            measuredHeight = getMeasuredHeight();
            measuredWidth = getMeasuredWidth();
        }
        a2.setSize(measuredHeight, measuredWidth);
    }

    void P() {
        int measuredHeight;
        int measuredWidth;
        if (this.L != null) {
            return;
        }
        EdgeEffect a2 = this.I.a(this, 2);
        this.L = a2;
        if (this.h) {
            measuredHeight = (getMeasuredHeight() - getPaddingTop()) - getPaddingBottom();
            measuredWidth = (getMeasuredWidth() - getPaddingLeft()) - getPaddingRight();
        } else {
            measuredHeight = getMeasuredHeight();
            measuredWidth = getMeasuredWidth();
        }
        a2.setSize(measuredHeight, measuredWidth);
    }

    void P0(boolean z2) {
        this.F = z2 | this.F;
        this.E = true;
        y0();
    }

    void Q() {
        int measuredWidth;
        int measuredHeight;
        if (this.K != null) {
            return;
        }
        EdgeEffect a2 = this.I.a(this, 1);
        this.K = a2;
        if (this.h) {
            measuredWidth = (getMeasuredWidth() - getPaddingLeft()) - getPaddingRight();
            measuredHeight = (getMeasuredHeight() - getPaddingTop()) - getPaddingBottom();
        } else {
            measuredWidth = getMeasuredWidth();
            measuredHeight = getMeasuredHeight();
        }
        a2.setSize(measuredWidth, measuredHeight);
    }

    String R() {
        return " " + super.toString() + ", adapter:" + this.m + ", layout:" + this.n + ", context:" + getContext();
    }

    void R0(c0 c0Var, l.c cVar) {
        c0Var.F(0, 8192);
        if (this.i0.i && c0Var.y() && !c0Var.v() && !c0Var.J()) {
            this.g.c(d0(c0Var), c0Var);
        }
        this.g.e(c0Var, cVar);
    }

    final void S(z zVar) {
        if (getScrollState() != 2) {
            zVar.p = 0;
            zVar.q = 0;
            return;
        }
        OverScroller overScroller = this.f0.f1122d;
        zVar.p = overScroller.getFinalX() - overScroller.getCurrX();
        zVar.q = overScroller.getFinalY() - overScroller.getCurrY();
    }

    /* JADX WARN: Code restructure failed: missing block: B:15:?, code lost:
        return r3;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public android.view.View T(android.view.View r3) {
        /*
            r2 = this;
        L0:
            android.view.ViewParent r0 = r3.getParent()
            if (r0 == 0) goto L10
            if (r0 == r2) goto L10
            boolean r1 = r0 instanceof android.view.View
            if (r1 == 0) goto L10
            r3 = r0
            android.view.View r3 = (android.view.View) r3
            goto L0
        L10:
            if (r0 != r2) goto L13
            goto L14
        L13:
            r3 = 0
        L14:
            return r3
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.T(android.view.View):android.view.View");
    }

    public c0 U(View view) {
        View T = T(view);
        if (T == null) {
            return null;
        }
        return e0(T);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void U0() {
        l lVar = this.N;
        if (lVar != null) {
            lVar.k();
        }
        o oVar = this.n;
        if (oVar != null) {
            oVar.h1(this.f1115c);
            this.n.i1(this.f1115c);
        }
        this.f1115c.c();
    }

    boolean V0(View view) {
        n1();
        boolean r2 = this.f.r(view);
        if (r2) {
            c0 f0 = f0(view);
            this.f1115c.J(f0);
            this.f1115c.C(f0);
        }
        p1(!r2);
        return r2;
    }

    public void W0(n nVar) {
        o oVar = this.n;
        if (oVar != null) {
            oVar.f("Cannot remove item decoration during a scroll  or layout");
        }
        this.p.remove(nVar);
        if (this.p.isEmpty()) {
            setWillNotDraw(getOverScrollMode() == 2);
        }
        x0();
        requestLayout();
    }

    public void X0(s sVar) {
        this.q.remove(sVar);
        if (this.r == sVar) {
            this.r = null;
        }
    }

    public c0 Y(int i2) {
        c0 c0Var = null;
        if (this.E) {
            return null;
        }
        int j2 = this.f.j();
        for (int i3 = 0; i3 < j2; i3++) {
            c0 f0 = f0(this.f.i(i3));
            if (f0 != null && !f0.v() && c0(f0) == i2) {
                if (!this.f.n(f0.f1123b)) {
                    return f0;
                }
                c0Var = f0;
            }
        }
        return c0Var;
    }

    public void Y0(t tVar) {
        List<t> list = this.k0;
        if (list != null) {
            list.remove(tVar);
        }
    }

    public c0 Z(long j2) {
        g gVar = this.m;
        c0 c0Var = null;
        if (gVar != null && gVar.f()) {
            int j3 = this.f.j();
            for (int i2 = 0; i2 < j3; i2++) {
                c0 f0 = f0(this.f.i(i2));
                if (f0 != null && !f0.v() && f0.k() == j2) {
                    if (!this.f.n(f0.f1123b)) {
                        return f0;
                    }
                    c0Var = f0;
                }
            }
        }
        return c0Var;
    }

    void Z0() {
        c0 c0Var;
        int g2 = this.f.g();
        for (int i2 = 0; i2 < g2; i2++) {
            View f2 = this.f.f(i2);
            c0 e0 = e0(f2);
            if (e0 != null && (c0Var = e0.j) != null) {
                View view = c0Var.f1123b;
                int left = f2.getLeft();
                int top = f2.getTop();
                if (left != view.getLeft() || top != view.getTop()) {
                    view.layout(left, top, view.getWidth() + left, view.getHeight() + top);
                }
            }
        }
    }

    @Override // a.f.l.i
    public void a(int i2) {
        getScrollingChildHelper().p(i2);
    }

    /* JADX WARN: Removed duplicated region for block: B:17:0x0034  */
    /* JADX WARN: Removed duplicated region for block: B:22:0x0036 A[SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    androidx.recyclerview.widget.RecyclerView.c0 a0(int r6, boolean r7) {
        /*
            r5 = this;
            androidx.recyclerview.widget.b r0 = r5.f
            int r0 = r0.j()
            r1 = 0
            r2 = 0
        L8:
            if (r2 >= r0) goto L3a
            androidx.recyclerview.widget.b r3 = r5.f
            android.view.View r3 = r3.i(r2)
            androidx.recyclerview.widget.RecyclerView$c0 r3 = f0(r3)
            if (r3 == 0) goto L37
            boolean r4 = r3.v()
            if (r4 != 0) goto L37
            if (r7 == 0) goto L23
            int r4 = r3.f1125d
            if (r4 == r6) goto L2a
            goto L37
        L23:
            int r4 = r3.m()
            if (r4 == r6) goto L2a
            goto L37
        L2a:
            androidx.recyclerview.widget.b r1 = r5.f
            android.view.View r4 = r3.f1123b
            boolean r1 = r1.n(r4)
            if (r1 == 0) goto L36
            r1 = r3
            goto L37
        L36:
            return r3
        L37:
            int r2 = r2 + 1
            goto L8
        L3a:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.a0(int, boolean):androidx.recyclerview.widget.RecyclerView$c0");
    }

    @Override // android.view.ViewGroup, android.view.View
    public void addFocusables(ArrayList<View> arrayList, int i2, int i3) {
        o oVar = this.n;
        if (oVar == null || !oVar.D0(this, arrayList, i2, i3)) {
            super.addFocusables(arrayList, i2, i3);
        }
    }

    public boolean b0(int i2, int i3) {
        o oVar = this.n;
        if (oVar == null) {
            Log.e("RecyclerView", "Cannot fling without a LayoutManager set. Call setLayoutManager with a non-null argument.");
            return false;
        } else if (this.y) {
            return false;
        } else {
            boolean j2 = oVar.j();
            boolean k2 = this.n.k();
            if (!j2 || Math.abs(i2) < this.a0) {
                i2 = 0;
            }
            if (!k2 || Math.abs(i3) < this.a0) {
                i3 = 0;
            }
            if (i2 == 0 && i3 == 0) {
                return false;
            }
            float f2 = i2;
            float f3 = i3;
            if (!dispatchNestedPreFling(f2, f3)) {
                boolean z2 = j2 || k2;
                dispatchNestedFling(f2, f3, z2);
                r rVar = this.W;
                if (rVar != null && rVar.a(i2, i3)) {
                    return true;
                }
                if (z2) {
                    int i4 = j2 ? 1 : 0;
                    if (k2) {
                        i4 |= 2;
                    }
                    o1(i4, 1);
                    int i5 = this.b0;
                    int max = Math.max(-i5, Math.min(i2, i5));
                    int i6 = this.b0;
                    this.f0.e(max, Math.max(-i6, Math.min(i3, i6)));
                    return true;
                }
            }
            return false;
        }
    }

    void c(int i2, int i3) {
        if (i2 < 0) {
            O();
            this.J.onAbsorb(-i2);
        } else if (i2 > 0) {
            P();
            this.L.onAbsorb(i2);
        }
        if (i3 < 0) {
            Q();
            this.K.onAbsorb(-i3);
        } else if (i3 > 0) {
            N();
            this.M.onAbsorb(i3);
        }
        if (i2 == 0 && i3 == 0) {
            return;
        }
        a.f.l.r.K(this);
    }

    int c0(c0 c0Var) {
        if (c0Var.q(524) || !c0Var.s()) {
            return -1;
        }
        return this.e.e(c0Var.f1125d);
    }

    @Override // android.view.ViewGroup
    protected boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return (layoutParams instanceof p) && this.n.l((p) layoutParams);
    }

    @Override // android.view.View
    public int computeHorizontalScrollExtent() {
        o oVar = this.n;
        if (oVar != null && oVar.j()) {
            return this.n.p(this.i0);
        }
        return 0;
    }

    @Override // android.view.View
    public int computeHorizontalScrollOffset() {
        o oVar = this.n;
        if (oVar != null && oVar.j()) {
            return this.n.q(this.i0);
        }
        return 0;
    }

    @Override // android.view.View
    public int computeHorizontalScrollRange() {
        o oVar = this.n;
        if (oVar != null && oVar.j()) {
            return this.n.r(this.i0);
        }
        return 0;
    }

    @Override // android.view.View
    public int computeVerticalScrollExtent() {
        o oVar = this.n;
        if (oVar != null && oVar.k()) {
            return this.n.s(this.i0);
        }
        return 0;
    }

    @Override // android.view.View
    public int computeVerticalScrollOffset() {
        o oVar = this.n;
        if (oVar != null && oVar.k()) {
            return this.n.t(this.i0);
        }
        return 0;
    }

    @Override // android.view.View
    public int computeVerticalScrollRange() {
        o oVar = this.n;
        if (oVar != null && oVar.k()) {
            return this.n.u(this.i0);
        }
        return 0;
    }

    long d0(c0 c0Var) {
        return this.m.f() ? c0Var.k() : c0Var.f1125d;
    }

    @Override // android.view.View
    public boolean dispatchNestedFling(float f2, float f3, boolean z2) {
        return getScrollingChildHelper().a(f2, f3, z2);
    }

    @Override // android.view.View
    public boolean dispatchNestedPreFling(float f2, float f3) {
        return getScrollingChildHelper().b(f2, f3);
    }

    @Override // android.view.View
    public boolean dispatchNestedPreScroll(int i2, int i3, int[] iArr, int[] iArr2) {
        return getScrollingChildHelper().c(i2, i3, iArr, iArr2);
    }

    @Override // android.view.View
    public boolean dispatchNestedScroll(int i2, int i3, int i4, int i5, int[] iArr) {
        return getScrollingChildHelper().e(i2, i3, i4, i5, iArr);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchRestoreInstanceState(SparseArray<Parcelable> sparseArray) {
        dispatchThawSelfOnly(sparseArray);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void dispatchSaveInstanceState(SparseArray<Parcelable> sparseArray) {
        dispatchFreezeSelfOnly(sparseArray);
    }

    @Override // android.view.View
    public void draw(Canvas canvas) {
        boolean z2;
        float f2;
        int i2;
        super.draw(canvas);
        int size = this.p.size();
        boolean z3 = false;
        for (int i3 = 0; i3 < size; i3++) {
            this.p.get(i3).i(canvas, this, this.i0);
        }
        EdgeEffect edgeEffect = this.J;
        boolean z4 = true;
        if (edgeEffect == null || edgeEffect.isFinished()) {
            z2 = false;
        } else {
            int save = canvas.save();
            int paddingBottom = this.h ? getPaddingBottom() : 0;
            canvas.rotate(270.0f);
            canvas.translate((-getHeight()) + paddingBottom, 0.0f);
            EdgeEffect edgeEffect2 = this.J;
            z2 = edgeEffect2 != null && edgeEffect2.draw(canvas);
            canvas.restoreToCount(save);
        }
        EdgeEffect edgeEffect3 = this.K;
        if (edgeEffect3 != null && !edgeEffect3.isFinished()) {
            int save2 = canvas.save();
            if (this.h) {
                canvas.translate(getPaddingLeft(), getPaddingTop());
            }
            EdgeEffect edgeEffect4 = this.K;
            z2 |= edgeEffect4 != null && edgeEffect4.draw(canvas);
            canvas.restoreToCount(save2);
        }
        EdgeEffect edgeEffect5 = this.L;
        if (edgeEffect5 != null && !edgeEffect5.isFinished()) {
            int save3 = canvas.save();
            int width = getWidth();
            int paddingTop = this.h ? getPaddingTop() : 0;
            canvas.rotate(90.0f);
            canvas.translate(-paddingTop, -width);
            EdgeEffect edgeEffect6 = this.L;
            z2 |= edgeEffect6 != null && edgeEffect6.draw(canvas);
            canvas.restoreToCount(save3);
        }
        EdgeEffect edgeEffect7 = this.M;
        if (edgeEffect7 != null && !edgeEffect7.isFinished()) {
            int save4 = canvas.save();
            canvas.rotate(180.0f);
            if (this.h) {
                f2 = (-getWidth()) + getPaddingRight();
                i2 = (-getHeight()) + getPaddingBottom();
            } else {
                f2 = -getWidth();
                i2 = -getHeight();
            }
            canvas.translate(f2, i2);
            EdgeEffect edgeEffect8 = this.M;
            if (edgeEffect8 != null && edgeEffect8.draw(canvas)) {
                z3 = true;
            }
            z2 |= z3;
            canvas.restoreToCount(save4);
        }
        if (z2 || this.N == null || this.p.size() <= 0 || !this.N.p()) {
            z4 = z2;
        }
        if (z4) {
            a.f.l.r.K(this);
        }
    }

    @Override // android.view.ViewGroup
    public boolean drawChild(Canvas canvas, View view, long j2) {
        return super.drawChild(canvas, view, j2);
    }

    public c0 e0(View view) {
        ViewParent parent = view.getParent();
        if (parent == null || parent == this) {
            return f0(view);
        }
        throw new IllegalArgumentException("View " + view + " is not a direct child of " + this);
    }

    void e1() {
        int j2 = this.f.j();
        for (int i2 = 0; i2 < j2; i2++) {
            c0 f0 = f0(this.f.i(i2));
            if (!f0.J()) {
                f0.E();
            }
        }
    }

    boolean f1(int i2, int i3, MotionEvent motionEvent) {
        int i4;
        int i5;
        int i6;
        int i7;
        v();
        if (this.m != null) {
            g1(i2, i3, this.w0);
            int[] iArr = this.w0;
            int i8 = iArr[0];
            int i9 = iArr[1];
            i5 = i9;
            i6 = i8;
            i7 = i2 - i8;
            i4 = i3 - i9;
        } else {
            i4 = 0;
            i5 = 0;
            i6 = 0;
            i7 = 0;
        }
        if (!this.p.isEmpty()) {
            invalidate();
        }
        int i10 = i4;
        if (H(i6, i5, i7, i4, this.t0, 0)) {
            int i11 = this.T;
            int[] iArr2 = this.t0;
            this.T = i11 - iArr2[0];
            this.U -= iArr2[1];
            if (motionEvent != null) {
                motionEvent.offsetLocation(iArr2[0], iArr2[1]);
            }
            int[] iArr3 = this.v0;
            int i12 = iArr3[0];
            int[] iArr4 = this.t0;
            iArr3[0] = i12 + iArr4[0];
            iArr3[1] = iArr3[1] + iArr4[1];
        } else if (getOverScrollMode() != 2) {
            if (motionEvent != null && !a.f.l.h.f(motionEvent, 8194)) {
                Q0(motionEvent.getX(), i7, motionEvent.getY(), i10);
            }
            u(i2, i3);
        }
        if (i6 != 0 || i5 != 0) {
            L(i6, i5);
        }
        if (!awakenScrollBars()) {
            invalidate();
        }
        return (i6 == 0 && i5 == 0) ? false : true;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public View focusSearch(View view, int i2) {
        View view2;
        boolean z2;
        View O0 = this.n.O0(view, i2);
        if (O0 != null) {
            return O0;
        }
        boolean z3 = (this.m == null || this.n == null || v0() || this.y) ? false : true;
        FocusFinder focusFinder = FocusFinder.getInstance();
        if (z3 && (i2 == 2 || i2 == 1)) {
            if (this.n.k()) {
                int i3 = i2 == 2 ? 130 : 33;
                z2 = focusFinder.findNextFocus(this, view, i3) == null;
                if (G0) {
                    i2 = i3;
                }
            } else {
                z2 = false;
            }
            if (!z2 && this.n.j()) {
                int i4 = (this.n.X() == 1) ^ (i2 == 2) ? 66 : 17;
                boolean z4 = focusFinder.findNextFocus(this, view, i4) == null;
                if (G0) {
                    i2 = i4;
                }
                z2 = z4;
            }
            if (z2) {
                v();
                if (T(view) == null) {
                    return null;
                }
                n1();
                this.n.H0(view, i2, this.f1115c, this.i0);
                p1(false);
            }
            view2 = focusFinder.findNextFocus(this, view, i2);
        } else {
            View findNextFocus = focusFinder.findNextFocus(this, view, i2);
            if (findNextFocus == null && z3) {
                v();
                if (T(view) == null) {
                    return null;
                }
                n1();
                view2 = this.n.H0(view, i2, this.f1115c, this.i0);
                p1(false);
            } else {
                view2 = findNextFocus;
            }
        }
        if (view2 == null || view2.hasFocusable()) {
            return w0(view, view2, i2) ? view2 : super.focusSearch(view, i2);
        } else if (getFocusedChild() == null) {
            return super.focusSearch(view, i2);
        } else {
            a1(view2, null);
            return view;
        }
    }

    public void g0(View view, Rect rect) {
        h0(view, rect);
    }

    void g1(int i2, int i3, int[] iArr) {
        n1();
        G0();
        a.f.h.a.a("RV Scroll");
        S(this.i0);
        int t1 = i2 != 0 ? this.n.t1(i2, this.f1115c, this.i0) : 0;
        int v1 = i3 != 0 ? this.n.v1(i3, this.f1115c, this.i0) : 0;
        a.f.h.a.b();
        Z0();
        H0();
        p1(false);
        if (iArr != null) {
            iArr[0] = t1;
            iArr[1] = v1;
        }
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateDefaultLayoutParams() {
        o oVar = this.n;
        if (oVar != null) {
            return oVar.C();
        }
        throw new IllegalStateException("RecyclerView has no LayoutManager" + R());
    }

    @Override // android.view.ViewGroup
    public ViewGroup.LayoutParams generateLayoutParams(AttributeSet attributeSet) {
        o oVar = this.n;
        if (oVar != null) {
            return oVar.D(getContext(), attributeSet);
        }
        throw new IllegalStateException("RecyclerView has no LayoutManager" + R());
    }

    @Override // android.view.ViewGroup
    protected ViewGroup.LayoutParams generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        o oVar = this.n;
        if (oVar != null) {
            return oVar.E(layoutParams);
        }
        throw new IllegalStateException("RecyclerView has no LayoutManager" + R());
    }

    public g getAdapter() {
        return this.m;
    }

    @Override // android.view.View
    public int getBaseline() {
        o oVar = this.n;
        return oVar != null ? oVar.F() : super.getBaseline();
    }

    @Override // android.view.ViewGroup
    protected int getChildDrawingOrder(int i2, int i3) {
        j jVar = this.q0;
        return jVar == null ? super.getChildDrawingOrder(i2, i3) : jVar.a(i2, i3);
    }

    @Override // android.view.ViewGroup
    public boolean getClipToPadding() {
        return this.h;
    }

    public androidx.recyclerview.widget.j getCompatAccessibilityDelegate() {
        return this.p0;
    }

    public k getEdgeEffectFactory() {
        return this.I;
    }

    public l getItemAnimator() {
        return this.N;
    }

    public int getItemDecorationCount() {
        return this.p.size();
    }

    public o getLayoutManager() {
        return this.n;
    }

    public int getMaxFlingVelocity() {
        return this.b0;
    }

    public int getMinFlingVelocity() {
        return this.a0;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public long getNanoTime() {
        if (F0) {
            return System.nanoTime();
        }
        return 0L;
    }

    public r getOnFlingListener() {
        return this.W;
    }

    public boolean getPreserveFocusAfterLayout() {
        return this.e0;
    }

    public u getRecycledViewPool() {
        return this.f1115c.i();
    }

    public int getScrollState() {
        return this.O;
    }

    public void h1(int i2) {
        if (this.y) {
            return;
        }
        q1();
        o oVar = this.n;
        if (oVar == null) {
            Log.e("RecyclerView", "Cannot scroll to position a LayoutManager set. Call setLayoutManager with a non-null argument.");
            return;
        }
        oVar.u1(i2);
        awakenScrollBars();
    }

    @Override // android.view.View
    public boolean hasNestedScrollingParent() {
        return getScrollingChildHelper().h();
    }

    public void i(n nVar) {
        j(nVar, -1);
    }

    @Override // android.view.View
    public boolean isAttachedToWindow() {
        return this.s;
    }

    @Override // android.view.View, a.f.l.j
    public boolean isNestedScrollingEnabled() {
        return getScrollingChildHelper().j();
    }

    public void j(n nVar, int i2) {
        o oVar = this.n;
        if (oVar != null) {
            oVar.f("Cannot add item decoration during a scroll  or layout");
        }
        if (this.p.isEmpty()) {
            setWillNotDraw(false);
        }
        if (i2 < 0) {
            this.p.add(nVar);
        } else {
            this.p.add(i2, nVar);
        }
        x0();
        requestLayout();
    }

    boolean j1(c0 c0Var, int i2) {
        if (!v0()) {
            a.f.l.r.Y(c0Var.f1123b, i2);
            return true;
        }
        c0Var.r = i2;
        this.x0.add(c0Var);
        return false;
    }

    public void k(s sVar) {
        this.q.add(sVar);
    }

    Rect k0(View view) {
        p pVar = (p) view.getLayoutParams();
        if (pVar.f1150c) {
            if (this.i0.e() && (pVar.b() || pVar.d())) {
                return pVar.f1149b;
            }
            Rect rect = pVar.f1149b;
            rect.set(0, 0, 0, 0);
            int size = this.p.size();
            for (int i2 = 0; i2 < size; i2++) {
                this.j.set(0, 0, 0, 0);
                this.p.get(i2).e(this.j, view, this, this.i0);
                int i3 = rect.left;
                Rect rect2 = this.j;
                rect.left = i3 + rect2.left;
                rect.top += rect2.top;
                rect.right += rect2.right;
                rect.bottom += rect2.bottom;
            }
            pVar.f1150c = false;
            return rect;
        }
        return pVar.f1149b;
    }

    boolean k1(AccessibilityEvent accessibilityEvent) {
        if (v0()) {
            int a2 = accessibilityEvent != null ? a.f.l.a0.a.a(accessibilityEvent) : 0;
            this.A |= a2 != 0 ? a2 : 0;
            return true;
        }
        return false;
    }

    public void l(t tVar) {
        if (this.k0 == null) {
            this.k0 = new ArrayList();
        }
        this.k0.add(tVar);
    }

    public void l1(int i2, int i3) {
        m1(i2, i3, null);
    }

    void m(c0 c0Var, l.c cVar, l.c cVar2) {
        c0Var.G(false);
        if (this.N.a(c0Var, cVar, cVar2)) {
            M0();
        }
    }

    public boolean m0(int i2) {
        return getScrollingChildHelper().i(i2);
    }

    public void m1(int i2, int i3, Interpolator interpolator) {
        o oVar = this.n;
        if (oVar == null) {
            Log.e("RecyclerView", "Cannot smooth scroll without a LayoutManager set. Call setLayoutManager with a non-null argument.");
        } else if (this.y) {
        } else {
            if (!oVar.j()) {
                i2 = 0;
            }
            if (!this.n.k()) {
                i3 = 0;
            }
            if (i2 == 0 && i3 == 0) {
                return;
            }
            this.f0.h(i2, i3, interpolator);
        }
    }

    public boolean n0() {
        return !this.v || this.E || this.e.p();
    }

    void n1() {
        int i2 = this.w + 1;
        this.w = i2;
        if (i2 != 1 || this.y) {
            return;
        }
        this.x = false;
    }

    void o(c0 c0Var, l.c cVar, l.c cVar2) {
        h(c0Var);
        c0Var.G(false);
        if (this.N.c(c0Var, cVar, cVar2)) {
            M0();
        }
    }

    public boolean o1(int i2, int i3) {
        return getScrollingChildHelper().n(i2, i3);
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        this.G = 0;
        boolean z2 = true;
        this.s = true;
        if (!this.v || isLayoutRequested()) {
            z2 = false;
        }
        this.v = z2;
        o oVar = this.n;
        if (oVar != null) {
            oVar.y(this);
        }
        this.o0 = false;
        if (F0) {
            ThreadLocal<androidx.recyclerview.widget.f> threadLocal = androidx.recyclerview.widget.f.f;
            androidx.recyclerview.widget.f fVar = threadLocal.get();
            this.g0 = fVar;
            if (fVar == null) {
                this.g0 = new androidx.recyclerview.widget.f();
                Display k2 = a.f.l.r.k(this);
                float f2 = 60.0f;
                if (!isInEditMode() && k2 != null) {
                    float refreshRate = k2.getRefreshRate();
                    if (refreshRate >= 30.0f) {
                        f2 = refreshRate;
                    }
                }
                androidx.recyclerview.widget.f fVar2 = this.g0;
                fVar2.f1246d = 1.0E9f / f2;
                threadLocal.set(fVar2);
            }
            this.g0.a(this);
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onDetachedFromWindow() {
        androidx.recyclerview.widget.f fVar;
        super.onDetachedFromWindow();
        l lVar = this.N;
        if (lVar != null) {
            lVar.k();
        }
        q1();
        this.s = false;
        o oVar = this.n;
        if (oVar != null) {
            oVar.z(this, this.f1115c);
        }
        this.x0.clear();
        removeCallbacks(this.y0);
        this.g.j();
        if (!F0 || (fVar = this.g0) == null) {
            return;
        }
        fVar.j(this);
        this.g0 = null;
    }

    @Override // android.view.View
    public void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        int size = this.p.size();
        for (int i2 = 0; i2 < size; i2++) {
            this.p.get(i2).g(canvas, this, this.i0);
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:31:0x0068  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onGenericMotionEvent(android.view.MotionEvent r6) {
        /*
            r5 = this;
            androidx.recyclerview.widget.RecyclerView$o r0 = r5.n
            r1 = 0
            if (r0 != 0) goto L6
            return r1
        L6:
            boolean r0 = r5.y
            if (r0 == 0) goto Lb
            return r1
        Lb:
            int r0 = r6.getAction()
            r2 = 8
            if (r0 != r2) goto L77
            int r0 = r6.getSource()
            r0 = r0 & 2
            r2 = 0
            if (r0 == 0) goto L3e
            androidx.recyclerview.widget.RecyclerView$o r0 = r5.n
            boolean r0 = r0.k()
            if (r0 == 0) goto L2c
            r0 = 9
            float r0 = r6.getAxisValue(r0)
            float r0 = -r0
            goto L2d
        L2c:
            r0 = r2
        L2d:
            androidx.recyclerview.widget.RecyclerView$o r3 = r5.n
            boolean r3 = r3.j()
            if (r3 == 0) goto L3c
            r3 = 10
            float r3 = r6.getAxisValue(r3)
            goto L64
        L3c:
            r3 = r2
            goto L64
        L3e:
            int r0 = r6.getSource()
            r3 = 4194304(0x400000, float:5.877472E-39)
            r0 = r0 & r3
            if (r0 == 0) goto L62
            r0 = 26
            float r0 = r6.getAxisValue(r0)
            androidx.recyclerview.widget.RecyclerView$o r3 = r5.n
            boolean r3 = r3.k()
            if (r3 == 0) goto L57
            float r0 = -r0
            goto L3c
        L57:
            androidx.recyclerview.widget.RecyclerView$o r3 = r5.n
            boolean r3 = r3.j()
            if (r3 == 0) goto L62
            r3 = r0
            r0 = r2
            goto L64
        L62:
            r0 = r2
            r3 = r0
        L64:
            int r4 = (r0 > r2 ? 1 : (r0 == r2 ? 0 : -1))
            if (r4 != 0) goto L6c
            int r2 = (r3 > r2 ? 1 : (r3 == r2 ? 0 : -1))
            if (r2 == 0) goto L77
        L6c:
            float r2 = r5.c0
            float r3 = r3 * r2
            int r2 = (int) r3
            float r3 = r5.d0
            float r0 = r0 * r3
            int r0 = (int) r0
            r5.f1(r2, r0, r6)
        L77:
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.onGenericMotionEvent(android.view.MotionEvent):boolean");
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        boolean z2;
        if (this.y) {
            return false;
        }
        if (J(motionEvent)) {
            r();
            return true;
        }
        o oVar = this.n;
        if (oVar == null) {
            return false;
        }
        boolean j2 = oVar.j();
        boolean k2 = this.n.k();
        if (this.Q == null) {
            this.Q = VelocityTracker.obtain();
        }
        this.Q.addMovement(motionEvent);
        int actionMasked = motionEvent.getActionMasked();
        int actionIndex = motionEvent.getActionIndex();
        if (actionMasked == 0) {
            if (this.z) {
                this.z = false;
            }
            this.P = motionEvent.getPointerId(0);
            int x2 = (int) (motionEvent.getX() + 0.5f);
            this.T = x2;
            this.R = x2;
            int y2 = (int) (motionEvent.getY() + 0.5f);
            this.U = y2;
            this.S = y2;
            if (this.O == 2) {
                getParent().requestDisallowInterceptTouchEvent(true);
                setScrollState(1);
            }
            int[] iArr = this.v0;
            iArr[1] = 0;
            iArr[0] = 0;
            int i2 = j2;
            if (k2) {
                i2 = (j2 ? 1 : 0) | 2;
            }
            o1(i2, 0);
        } else if (actionMasked == 1) {
            this.Q.clear();
            a(0);
        } else if (actionMasked == 2) {
            int findPointerIndex = motionEvent.findPointerIndex(this.P);
            if (findPointerIndex < 0) {
                Log.e("RecyclerView", "Error processing scroll; pointer index for id " + this.P + " not found. Did any MotionEvents get skipped?");
                return false;
            }
            int x3 = (int) (motionEvent.getX(findPointerIndex) + 0.5f);
            int y3 = (int) (motionEvent.getY(findPointerIndex) + 0.5f);
            if (this.O != 1) {
                int i3 = x3 - this.R;
                int i4 = y3 - this.S;
                if (!j2 || Math.abs(i3) <= this.V) {
                    z2 = false;
                } else {
                    this.T = x3;
                    z2 = true;
                }
                if (k2 && Math.abs(i4) > this.V) {
                    this.U = y3;
                    z2 = true;
                }
                if (z2) {
                    setScrollState(1);
                }
            }
        } else if (actionMasked == 3) {
            r();
        } else if (actionMasked == 5) {
            this.P = motionEvent.getPointerId(actionIndex);
            int x4 = (int) (motionEvent.getX(actionIndex) + 0.5f);
            this.T = x4;
            this.R = x4;
            int y4 = (int) (motionEvent.getY(actionIndex) + 0.5f);
            this.U = y4;
            this.S = y4;
        } else if (actionMasked == 6) {
            J0(motionEvent);
        }
        return this.O == 1;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z2, int i2, int i3, int i4, int i5) {
        a.f.h.a.a("RV OnLayout");
        C();
        a.f.h.a.b();
        this.v = true;
    }

    @Override // android.view.View
    protected void onMeasure(int i2, int i3) {
        o oVar = this.n;
        if (oVar == null) {
            x(i2, i3);
            return;
        }
        boolean z2 = false;
        if (oVar.q0()) {
            int mode = View.MeasureSpec.getMode(i2);
            int mode2 = View.MeasureSpec.getMode(i3);
            this.n.X0(this.f1115c, this.i0, i2, i3);
            if (mode == 1073741824 && mode2 == 1073741824) {
                z2 = true;
            }
            if (z2 || this.m == null) {
                return;
            }
            if (this.i0.e == 1) {
                D();
            }
            this.n.x1(i2, i3);
            this.i0.j = true;
            E();
            this.n.A1(i2, i3);
            if (this.n.D1()) {
                this.n.x1(View.MeasureSpec.makeMeasureSpec(getMeasuredWidth(), 1073741824), View.MeasureSpec.makeMeasureSpec(getMeasuredHeight(), 1073741824));
                this.i0.j = true;
                E();
                this.n.A1(i2, i3);
            }
        } else if (this.t) {
            this.n.X0(this.f1115c, this.i0, i2, i3);
        } else {
            if (this.B) {
                n1();
                G0();
                O0();
                H0();
                z zVar = this.i0;
                if (zVar.l) {
                    zVar.h = true;
                } else {
                    this.e.j();
                    this.i0.h = false;
                }
                this.B = false;
                p1(false);
            } else if (this.i0.l) {
                setMeasuredDimension(getMeasuredWidth(), getMeasuredHeight());
                return;
            }
            g gVar = this.m;
            if (gVar != null) {
                this.i0.f = gVar.c();
            } else {
                this.i0.f = 0;
            }
            n1();
            this.n.X0(this.f1115c, this.i0, i2, i3);
            p1(false);
            this.i0.h = false;
        }
    }

    @Override // android.view.ViewGroup
    protected boolean onRequestFocusInDescendants(int i2, Rect rect) {
        if (v0()) {
            return false;
        }
        return super.onRequestFocusInDescendants(i2, rect);
    }

    @Override // android.view.View
    protected void onRestoreInstanceState(Parcelable parcelable) {
        Parcelable parcelable2;
        if (!(parcelable instanceof SavedState)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        SavedState savedState = (SavedState) parcelable;
        this.f1116d = savedState;
        super.onRestoreInstanceState(savedState.a());
        o oVar = this.n;
        if (oVar == null || (parcelable2 = this.f1116d.f1117d) == null) {
            return;
        }
        oVar.a1(parcelable2);
    }

    @Override // android.view.View
    protected Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        SavedState savedState2 = this.f1116d;
        if (savedState2 != null) {
            savedState.b(savedState2);
        } else {
            o oVar = this.n;
            savedState.f1117d = oVar != null ? oVar.b1() : null;
        }
        return savedState;
    }

    @Override // android.view.View
    protected void onSizeChanged(int i2, int i3, int i4, int i5) {
        super.onSizeChanged(i2, i3, i4, i5);
        if (i2 == i4 && i3 == i5) {
            return;
        }
        t0();
    }

    /* JADX WARN: Removed duplicated region for block: B:53:0x010c  */
    /* JADX WARN: Removed duplicated region for block: B:60:0x011c  */
    @Override // android.view.View
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean onTouchEvent(android.view.MotionEvent r15) {
        /*
            Method dump skipped, instructions count: 449
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.recyclerview.widget.RecyclerView.onTouchEvent(android.view.MotionEvent):boolean");
    }

    void p(String str) {
        if (v0()) {
            if (str != null) {
                throw new IllegalStateException(str);
            }
            throw new IllegalStateException("Cannot call this method while RecyclerView is computing a layout or scrolling" + R());
        } else if (this.H > 0) {
            Log.w("RecyclerView", "Cannot call this method in a scroll callback. Scroll callbacks mightbe run during a measure & layout pass where you cannot change theRecyclerView data. Any method call that might change the structureof the RecyclerView or the adapter contents should be postponed tothe next frame.", new IllegalStateException(BuildConfig.FLAVOR + R()));
        }
    }

    void p0() {
        this.e = new androidx.recyclerview.widget.a(new f());
    }

    void p1(boolean z2) {
        if (this.w < 1) {
            this.w = 1;
        }
        if (!z2 && !this.y) {
            this.x = false;
        }
        if (this.w == 1) {
            if (z2 && this.x && !this.y && this.n != null && this.m != null) {
                C();
            }
            if (!this.y) {
                this.x = false;
            }
        }
        this.w--;
    }

    boolean q(c0 c0Var) {
        l lVar = this.N;
        return lVar == null || lVar.g(c0Var, c0Var.p());
    }

    public void q1() {
        setScrollState(0);
        r1();
    }

    @Override // android.view.ViewGroup
    protected void removeDetachedView(View view, boolean z2) {
        c0 f0 = f0(view);
        if (f0 != null) {
            if (f0.x()) {
                f0.f();
            } else if (!f0.J()) {
                throw new IllegalArgumentException("Called removeDetachedView with a view which is not flagged as tmp detached." + f0 + R());
            }
        }
        view.clearAnimation();
        A(view);
        super.removeDetachedView(view, z2);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestChildFocus(View view, View view2) {
        if (!this.n.Z0(this, this.i0, view, view2) && view2 != null) {
            a1(view, view2);
        }
        super.requestChildFocus(view, view2);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public boolean requestChildRectangleOnScreen(View view, Rect rect, boolean z2) {
        return this.n.o1(this, view, rect, z2);
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestDisallowInterceptTouchEvent(boolean z2) {
        int size = this.q.size();
        for (int i2 = 0; i2 < size; i2++) {
            this.q.get(i2).c(z2);
        }
        super.requestDisallowInterceptTouchEvent(z2);
    }

    @Override // android.view.View, android.view.ViewParent
    public void requestLayout() {
        if (this.w != 0 || this.y) {
            this.x = true;
        } else {
            super.requestLayout();
        }
    }

    void s0(StateListDrawable stateListDrawable, Drawable drawable, StateListDrawable stateListDrawable2, Drawable drawable2) {
        if (stateListDrawable != null && drawable != null && stateListDrawable2 != null && drawable2 != null) {
            Resources resources = getContext().getResources();
            new androidx.recyclerview.widget.e(this, stateListDrawable, drawable, stateListDrawable2, drawable2, resources.getDimensionPixelSize(a.k.a.fastscroll_default_thickness), resources.getDimensionPixelSize(a.k.a.fastscroll_minimum_range), resources.getDimensionPixelOffset(a.k.a.fastscroll_margin));
            return;
        }
        throw new IllegalArgumentException("Trying to set fast scroller without both required drawables." + R());
    }

    public void s1(g gVar, boolean z2) {
        setLayoutFrozen(false);
        i1(gVar, true, z2);
        P0(true);
        requestLayout();
    }

    @Override // android.view.View
    public void scrollBy(int i2, int i3) {
        o oVar = this.n;
        if (oVar == null) {
            Log.e("RecyclerView", "Cannot scroll without a LayoutManager set. Call setLayoutManager with a non-null argument.");
        } else if (this.y) {
        } else {
            boolean j2 = oVar.j();
            boolean k2 = this.n.k();
            if (j2 || k2) {
                if (!j2) {
                    i2 = 0;
                }
                if (!k2) {
                    i3 = 0;
                }
                f1(i2, i3, null);
            }
        }
    }

    @Override // android.view.View
    public void scrollTo(int i2, int i3) {
        Log.w("RecyclerView", "RecyclerView does not support scrolling to an absolute position. Use scrollToPosition instead");
    }

    @Override // android.view.View, android.view.accessibility.AccessibilityEventSource
    public void sendAccessibilityEventUnchecked(AccessibilityEvent accessibilityEvent) {
        if (k1(accessibilityEvent)) {
            return;
        }
        super.sendAccessibilityEventUnchecked(accessibilityEvent);
    }

    public void setAccessibilityDelegateCompat(androidx.recyclerview.widget.j jVar) {
        this.p0 = jVar;
        a.f.l.r.O(this, jVar);
    }

    public void setAdapter(g gVar) {
        setLayoutFrozen(false);
        i1(gVar, false, true);
        P0(false);
        requestLayout();
    }

    public void setChildDrawingOrderCallback(j jVar) {
        if (jVar == this.q0) {
            return;
        }
        this.q0 = jVar;
        setChildrenDrawingOrderEnabled(jVar != null);
    }

    @Override // android.view.ViewGroup
    public void setClipToPadding(boolean z2) {
        if (z2 != this.h) {
            t0();
        }
        this.h = z2;
        super.setClipToPadding(z2);
        if (this.v) {
            requestLayout();
        }
    }

    public void setEdgeEffectFactory(k kVar) {
        a.f.k.g.b(kVar);
        this.I = kVar;
        t0();
    }

    public void setHasFixedSize(boolean z2) {
        this.t = z2;
    }

    public void setItemAnimator(l lVar) {
        l lVar2 = this.N;
        if (lVar2 != null) {
            lVar2.k();
            this.N.v(null);
        }
        this.N = lVar;
        if (lVar != null) {
            lVar.v(this.n0);
        }
    }

    public void setItemViewCacheSize(int i2) {
        this.f1115c.G(i2);
    }

    public void setLayoutFrozen(boolean z2) {
        if (z2 != this.y) {
            p("Do not setLayoutFrozen in layout or scroll");
            if (z2) {
                long uptimeMillis = SystemClock.uptimeMillis();
                onTouchEvent(MotionEvent.obtain(uptimeMillis, uptimeMillis, 3, 0.0f, 0.0f, 0));
                this.y = true;
                this.z = true;
                q1();
                return;
            }
            this.y = false;
            if (this.x && this.n != null && this.m != null) {
                requestLayout();
            }
            this.x = false;
        }
    }

    public void setLayoutManager(o oVar) {
        if (oVar == this.n) {
            return;
        }
        q1();
        if (this.n != null) {
            l lVar = this.N;
            if (lVar != null) {
                lVar.k();
            }
            this.n.h1(this.f1115c);
            this.n.i1(this.f1115c);
            this.f1115c.c();
            if (this.s) {
                this.n.z(this, this.f1115c);
            }
            this.n.B1(null);
            this.n = null;
        } else {
            this.f1115c.c();
        }
        this.f.o();
        this.n = oVar;
        if (oVar != null) {
            if (oVar.f1139b != null) {
                throw new IllegalArgumentException("LayoutManager " + oVar + " is already attached to a RecyclerView:" + oVar.f1139b.R());
            }
            oVar.B1(this);
            if (this.s) {
                this.n.y(this);
            }
        }
        this.f1115c.K();
        requestLayout();
    }

    @Override // android.view.View
    public void setNestedScrollingEnabled(boolean z2) {
        getScrollingChildHelper().k(z2);
    }

    public void setOnFlingListener(r rVar) {
    }

    @Deprecated
    public void setOnScrollListener(t tVar) {
        this.j0 = tVar;
    }

    public void setPreserveFocusAfterLayout(boolean z2) {
        this.e0 = z2;
    }

    public void setRecycledViewPool(u uVar) {
        this.f1115c.E(uVar);
    }

    public void setRecyclerListener(w wVar) {
        this.o = wVar;
    }

    void setScrollState(int i2) {
        if (i2 == this.O) {
            return;
        }
        this.O = i2;
        if (i2 != 2) {
            r1();
        }
        K(i2);
    }

    public void setScrollingTouchSlop(int i2) {
        int scaledTouchSlop;
        ViewConfiguration viewConfiguration = ViewConfiguration.get(getContext());
        if (i2 != 0) {
            if (i2 == 1) {
                scaledTouchSlop = viewConfiguration.getScaledPagingTouchSlop();
                this.V = scaledTouchSlop;
            }
            Log.w("RecyclerView", "setScrollingTouchSlop(): bad argument constant " + i2 + "; using default value");
        }
        scaledTouchSlop = viewConfiguration.getScaledTouchSlop();
        this.V = scaledTouchSlop;
    }

    public void setViewCacheExtension(a0 a0Var) {
        this.f1115c.F(a0Var);
    }

    @Override // android.view.View
    public boolean startNestedScroll(int i2) {
        return getScrollingChildHelper().m(i2);
    }

    @Override // android.view.View, a.f.l.j
    public void stopNestedScroll() {
        getScrollingChildHelper().o();
    }

    void t() {
        int j2 = this.f.j();
        for (int i2 = 0; i2 < j2; i2++) {
            c0 f0 = f0(this.f.i(i2));
            if (!f0.J()) {
                f0.c();
            }
        }
        this.f1115c.d();
    }

    void t0() {
        this.M = null;
        this.K = null;
        this.L = null;
        this.J = null;
    }

    void t1(int i2, int i3, Object obj) {
        int i4;
        int j2 = this.f.j();
        int i5 = i2 + i3;
        for (int i6 = 0; i6 < j2; i6++) {
            View i7 = this.f.i(i6);
            c0 f0 = f0(i7);
            if (f0 != null && !f0.J() && (i4 = f0.f1125d) >= i2 && i4 < i5) {
                f0.b(2);
                f0.a(obj);
                ((p) i7.getLayoutParams()).f1150c = true;
            }
        }
        this.f1115c.M(i2, i3);
    }

    void u(int i2, int i3) {
        boolean z2;
        EdgeEffect edgeEffect = this.J;
        if (edgeEffect == null || edgeEffect.isFinished() || i2 <= 0) {
            z2 = false;
        } else {
            this.J.onRelease();
            z2 = this.J.isFinished();
        }
        EdgeEffect edgeEffect2 = this.L;
        if (edgeEffect2 != null && !edgeEffect2.isFinished() && i2 < 0) {
            this.L.onRelease();
            z2 |= this.L.isFinished();
        }
        EdgeEffect edgeEffect3 = this.K;
        if (edgeEffect3 != null && !edgeEffect3.isFinished() && i3 > 0) {
            this.K.onRelease();
            z2 |= this.K.isFinished();
        }
        EdgeEffect edgeEffect4 = this.M;
        if (edgeEffect4 != null && !edgeEffect4.isFinished() && i3 < 0) {
            this.M.onRelease();
            z2 |= this.M.isFinished();
        }
        if (z2) {
            a.f.l.r.K(this);
        }
    }

    boolean u0() {
        AccessibilityManager accessibilityManager = this.C;
        return accessibilityManager != null && accessibilityManager.isEnabled();
    }

    void v() {
        if (!this.v || this.E) {
            a.f.h.a.a("RV FullInvalidate");
            C();
            a.f.h.a.b();
        } else if (this.e.p()) {
            if (this.e.o(4) && !this.e.o(11)) {
                a.f.h.a.a("RV PartialInvalidate");
                n1();
                G0();
                this.e.u();
                if (!this.x) {
                    if (o0()) {
                        C();
                    } else {
                        this.e.i();
                    }
                }
                p1(true);
                H0();
            } else if (!this.e.p()) {
                return;
            } else {
                a.f.h.a.a("RV FullInvalidate");
                C();
            }
            a.f.h.a.b();
        }
    }

    public boolean v0() {
        return this.G > 0;
    }

    void x(int i2, int i3) {
        setMeasuredDimension(o.m(i2, getPaddingLeft() + getPaddingRight(), a.f.l.r.s(this)), o.m(i3, getPaddingTop() + getPaddingBottom(), a.f.l.r.r(this)));
    }

    void x0() {
        int j2 = this.f.j();
        for (int i2 = 0; i2 < j2; i2++) {
            ((p) this.f.i(i2).getLayoutParams()).f1150c = true;
        }
        this.f1115c.s();
    }

    void y0() {
        int j2 = this.f.j();
        for (int i2 = 0; i2 < j2; i2++) {
            c0 f0 = f0(this.f.i(i2));
            if (f0 != null && !f0.J()) {
                f0.b(6);
            }
        }
        x0();
        this.f1115c.t();
    }

    void z(View view) {
        c0 f0 = f0(view);
        E0(view);
        g gVar = this.m;
        if (gVar != null && f0 != null) {
            gVar.q(f0);
        }
        List<q> list = this.D;
        if (list != null) {
            for (int size = list.size() - 1; size >= 0; size--) {
                this.D.get(size).a(view);
            }
        }
    }

    public void z0(int i2) {
        int g2 = this.f.g();
        for (int i3 = 0; i3 < g2; i3++) {
            this.f.f(i3).offsetLeftAndRight(i2);
        }
    }
}
