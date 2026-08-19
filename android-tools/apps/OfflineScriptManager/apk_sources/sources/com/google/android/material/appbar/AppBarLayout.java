package com.google.android.material.appbar;

import a.f.l.j;
import a.f.l.o;
import a.f.l.r;
import a.f.l.z;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.AnimationUtils;
import android.view.animation.Interpolator;
import android.widget.LinearLayout;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.customview.view.AbsSavedState;
import b.d.a.a.i;
import com.google.android.material.internal.f;
import java.lang.ref.WeakReference;
import java.util.List;
@CoordinatorLayout.d(Behavior.class)
/* loaded from: classes.dex */
public class AppBarLayout extends LinearLayout {

    /* renamed from: b  reason: collision with root package name */
    private int f2267b;

    /* renamed from: c  reason: collision with root package name */
    private int f2268c;

    /* renamed from: d  reason: collision with root package name */
    private int f2269d;
    private boolean e;
    private int f;
    private z g;
    private List<b> h;
    private boolean i;
    private boolean j;
    private boolean k;
    private boolean l;
    private int[] m;

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class BaseBehavior<T extends AppBarLayout> extends com.google.android.material.appbar.a<T> {
        private int k;
        private int l;
        private ValueAnimator m;
        private int n;
        private boolean o;
        private float p;
        private WeakReference<View> q;
        private b r;

        /* JADX INFO: Access modifiers changed from: protected */
        /* loaded from: classes.dex */
        public static class SavedState extends AbsSavedState {
            public static final Parcelable.Creator<SavedState> CREATOR = new a();

            /* renamed from: d  reason: collision with root package name */
            int f2270d;
            float e;
            boolean f;

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

            public SavedState(Parcel parcel, ClassLoader classLoader) {
                super(parcel, classLoader);
                this.f2270d = parcel.readInt();
                this.e = parcel.readFloat();
                this.f = parcel.readByte() != 0;
            }

            public SavedState(Parcelable parcelable) {
                super(parcelable);
            }

            @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
            public void writeToParcel(Parcel parcel, int i) {
                super.writeToParcel(parcel, i);
                parcel.writeInt(this.f2270d);
                parcel.writeFloat(this.e);
                parcel.writeByte(this.f ? (byte) 1 : (byte) 0);
            }
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public class a implements ValueAnimator.AnimatorUpdateListener {

            /* renamed from: a  reason: collision with root package name */
            final /* synthetic */ CoordinatorLayout f2271a;

            /* renamed from: b  reason: collision with root package name */
            final /* synthetic */ AppBarLayout f2272b;

            a(CoordinatorLayout coordinatorLayout, AppBarLayout appBarLayout) {
                this.f2271a = coordinatorLayout;
                this.f2272b = appBarLayout;
            }

            @Override // android.animation.ValueAnimator.AnimatorUpdateListener
            public void onAnimationUpdate(ValueAnimator valueAnimator) {
                BaseBehavior.this.O(this.f2271a, this.f2272b, ((Integer) valueAnimator.getAnimatedValue()).intValue());
            }
        }

        /* loaded from: classes.dex */
        public static abstract class b<T extends AppBarLayout> {
            public abstract boolean a(T t);
        }

        public BaseBehavior() {
            this.n = -1;
        }

        public BaseBehavior(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.n = -1;
        }

        private void R(CoordinatorLayout coordinatorLayout, T t, int i, float f) {
            int abs = Math.abs(L() - i);
            float abs2 = Math.abs(f);
            S(coordinatorLayout, t, i, abs2 > 0.0f ? Math.round((abs / abs2) * 1000.0f) * 3 : (int) (((abs / t.getHeight()) + 1.0f) * 150.0f));
        }

        private void S(CoordinatorLayout coordinatorLayout, T t, int i, int i2) {
            int L = L();
            if (L == i) {
                ValueAnimator valueAnimator = this.m;
                if (valueAnimator == null || !valueAnimator.isRunning()) {
                    return;
                }
                this.m.cancel();
                return;
            }
            ValueAnimator valueAnimator2 = this.m;
            if (valueAnimator2 == null) {
                ValueAnimator valueAnimator3 = new ValueAnimator();
                this.m = valueAnimator3;
                valueAnimator3.setInterpolator(b.d.a.a.k.a.f1470d);
                this.m.addUpdateListener(new a(coordinatorLayout, t));
            } else {
                valueAnimator2.cancel();
            }
            this.m.setDuration(Math.min(i2, 600));
            this.m.setIntValues(L, i);
            this.m.start();
        }

        private boolean U(CoordinatorLayout coordinatorLayout, T t, View view) {
            return t.g() && coordinatorLayout.getHeight() - view.getHeight() <= t.getHeight();
        }

        private static boolean V(int i, int i2) {
            return (i & i2) == i2;
        }

        private View W(CoordinatorLayout coordinatorLayout) {
            int childCount = coordinatorLayout.getChildCount();
            for (int i = 0; i < childCount; i++) {
                View childAt = coordinatorLayout.getChildAt(i);
                if (childAt instanceof j) {
                    return childAt;
                }
            }
            return null;
        }

        private static View X(AppBarLayout appBarLayout, int i) {
            int abs = Math.abs(i);
            int childCount = appBarLayout.getChildCount();
            for (int i2 = 0; i2 < childCount; i2++) {
                View childAt = appBarLayout.getChildAt(i2);
                if (abs >= childAt.getTop() && abs <= childAt.getBottom()) {
                    return childAt;
                }
            }
            return null;
        }

        private int Y(T t, int i) {
            int childCount = t.getChildCount();
            for (int i2 = 0; i2 < childCount; i2++) {
                View childAt = t.getChildAt(i2);
                int top = childAt.getTop();
                int bottom = childAt.getBottom();
                c cVar = (c) childAt.getLayoutParams();
                if (V(cVar.a(), 32)) {
                    top -= ((LinearLayout.LayoutParams) cVar).topMargin;
                    bottom += ((LinearLayout.LayoutParams) cVar).bottomMargin;
                }
                int i3 = -i;
                if (top <= i3 && bottom >= i3) {
                    return i2;
                }
            }
            return -1;
        }

        private int b0(T t, int i) {
            int abs = Math.abs(i);
            int childCount = t.getChildCount();
            int i2 = 0;
            int i3 = 0;
            while (true) {
                if (i3 >= childCount) {
                    break;
                }
                View childAt = t.getChildAt(i3);
                c cVar = (c) childAt.getLayoutParams();
                Interpolator b2 = cVar.b();
                if (abs < childAt.getTop() || abs > childAt.getBottom()) {
                    i3++;
                } else if (b2 != null) {
                    int a2 = cVar.a();
                    if ((a2 & 1) != 0) {
                        i2 = 0 + childAt.getHeight() + ((LinearLayout.LayoutParams) cVar).topMargin + ((LinearLayout.LayoutParams) cVar).bottomMargin;
                        if ((a2 & 2) != 0) {
                            i2 -= r.r(childAt);
                        }
                    }
                    if (r.n(childAt)) {
                        i2 -= t.getTopInset();
                    }
                    if (i2 > 0) {
                        float f = i2;
                        return Integer.signum(i) * (childAt.getTop() + Math.round(f * b2.getInterpolation((abs - childAt.getTop()) / f)));
                    }
                }
            }
            return i;
        }

        private boolean m0(CoordinatorLayout coordinatorLayout, T t) {
            List<View> r = coordinatorLayout.r(t);
            int size = r.size();
            for (int i = 0; i < size; i++) {
                CoordinatorLayout.c f = ((CoordinatorLayout.f) r.get(i).getLayoutParams()).f();
                if (f instanceof ScrollingViewBehavior) {
                    return ((ScrollingViewBehavior) f).J() != 0;
                }
            }
            return false;
        }

        private void n0(CoordinatorLayout coordinatorLayout, T t) {
            int L = L();
            int Y = Y(t, L);
            if (Y >= 0) {
                View childAt = t.getChildAt(Y);
                c cVar = (c) childAt.getLayoutParams();
                int a2 = cVar.a();
                if ((a2 & 17) == 17) {
                    int i = -childAt.getTop();
                    int i2 = -childAt.getBottom();
                    if (Y == t.getChildCount() - 1) {
                        i2 += t.getTopInset();
                    }
                    if (V(a2, 2)) {
                        i2 += r.r(childAt);
                    } else if (V(a2, 5)) {
                        int r = r.r(childAt) + i2;
                        if (L < r) {
                            i = r;
                        } else {
                            i2 = r;
                        }
                    }
                    if (V(a2, 32)) {
                        i += ((LinearLayout.LayoutParams) cVar).topMargin;
                        i2 -= ((LinearLayout.LayoutParams) cVar).bottomMargin;
                    }
                    if (L < (i2 + i) / 2) {
                        i = i2;
                    }
                    R(coordinatorLayout, t, a.f.g.a.a(i, -t.getTotalScrollRange(), 0), 0.0f);
                }
            }
        }

        private void o0(int i, T t, View view, int i2) {
            if (i2 == 1) {
                int L = L();
                if ((i >= 0 || L != 0) && (i <= 0 || L != (-t.getDownNestedScrollRange()))) {
                    return;
                }
                r.j0(view, 1);
            }
        }

        /* JADX WARN: Removed duplicated region for block: B:26:0x0055  */
        /* JADX WARN: Removed duplicated region for block: B:30:0x0061  */
        /* JADX WARN: Removed duplicated region for block: B:37:? A[RETURN, SYNTHETIC] */
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        private void p0(androidx.coordinatorlayout.widget.CoordinatorLayout r6, T r7, int r8, int r9, boolean r10) {
            /*
                r5 = this;
                android.view.View r0 = X(r7, r8)
                if (r0 == 0) goto L6e
                android.view.ViewGroup$LayoutParams r1 = r0.getLayoutParams()
                com.google.android.material.appbar.AppBarLayout$c r1 = (com.google.android.material.appbar.AppBarLayout.c) r1
                int r1 = r1.a()
                r2 = r1 & 1
                r3 = 1
                r4 = 0
                if (r2 == 0) goto L41
                int r2 = a.f.l.r.r(r0)
                if (r9 <= 0) goto L2f
                r9 = r1 & 12
                if (r9 == 0) goto L2f
                int r8 = -r8
                int r9 = r0.getBottom()
                int r9 = r9 - r2
                int r0 = r7.getTopInset()
                int r9 = r9 - r0
                if (r8 < r9) goto L41
            L2d:
                r8 = r3
                goto L42
            L2f:
                r9 = r1 & 2
                if (r9 == 0) goto L41
                int r8 = -r8
                int r9 = r0.getBottom()
                int r9 = r9 - r2
                int r0 = r7.getTopInset()
                int r9 = r9 - r0
                if (r8 < r9) goto L41
                goto L2d
            L41:
                r8 = r4
            L42:
                boolean r9 = r7.i()
                if (r9 == 0) goto L57
                android.view.View r9 = r5.W(r6)
                if (r9 == 0) goto L57
                int r8 = r9.getScrollY()
                if (r8 <= 0) goto L55
                goto L56
            L55:
                r3 = r4
            L56:
                r8 = r3
            L57:
                boolean r8 = r7.o(r8)
                int r9 = android.os.Build.VERSION.SDK_INT
                r0 = 11
                if (r9 < r0) goto L6e
                if (r10 != 0) goto L6b
                if (r8 == 0) goto L6e
                boolean r6 = r5.m0(r6, r7)
                if (r6 == 0) goto L6e
            L6b:
                r7.jumpDrawablesToCurrentState()
            L6e:
                return
            */
            throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.appbar.AppBarLayout.BaseBehavior.p0(androidx.coordinatorlayout.widget.CoordinatorLayout, com.google.android.material.appbar.AppBarLayout, int, int, boolean):void");
        }

        @Override // com.google.android.material.appbar.a
        int L() {
            return D() + this.k;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.a
        /* renamed from: T */
        public boolean G(T t) {
            b bVar = this.r;
            if (bVar != null) {
                return bVar.a(t);
            }
            WeakReference<View> weakReference = this.q;
            if (weakReference != null) {
                View view = weakReference.get();
                return (view == null || !view.isShown() || view.canScrollVertically(-1)) ? false : true;
            }
            return true;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.a
        /* renamed from: Z */
        public int J(T t) {
            return -t.getDownNestedScrollRange();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.a
        /* renamed from: a0 */
        public int K(T t) {
            return t.getTotalScrollRange();
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.a
        /* renamed from: c0 */
        public void M(CoordinatorLayout coordinatorLayout, T t) {
            n0(coordinatorLayout, t);
        }

        @Override // com.google.android.material.appbar.c, androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: d0 */
        public boolean l(CoordinatorLayout coordinatorLayout, T t, int i) {
            boolean l = super.l(coordinatorLayout, t, i);
            int pendingAction = t.getPendingAction();
            int i2 = this.n;
            if (i2 >= 0 && (pendingAction & 8) == 0) {
                View childAt = t.getChildAt(i2);
                O(coordinatorLayout, t, (-childAt.getBottom()) + (this.o ? r.r(childAt) + t.getTopInset() : Math.round(childAt.getHeight() * this.p)));
            } else if (pendingAction != 0) {
                boolean z = (pendingAction & 4) != 0;
                if ((pendingAction & 2) != 0) {
                    int i3 = -t.getUpNestedPreScrollRange();
                    if (z) {
                        R(coordinatorLayout, t, i3, 0.0f);
                    } else {
                        O(coordinatorLayout, t, i3);
                    }
                } else if ((pendingAction & 1) != 0) {
                    if (z) {
                        R(coordinatorLayout, t, 0, 0.0f);
                    } else {
                        O(coordinatorLayout, t, 0);
                    }
                }
            }
            t.k();
            this.n = -1;
            F(a.f.g.a.a(D(), -t.getTotalScrollRange(), 0));
            p0(coordinatorLayout, t, D(), 0, true);
            t.a(D());
            return l;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: e0 */
        public boolean m(CoordinatorLayout coordinatorLayout, T t, int i, int i2, int i3, int i4) {
            if (((ViewGroup.MarginLayoutParams) ((CoordinatorLayout.f) t.getLayoutParams())).height == -2) {
                coordinatorLayout.I(t, i, i2, View.MeasureSpec.makeMeasureSpec(0, 0), i4);
                return true;
            }
            return super.m(coordinatorLayout, t, i, i2, i3, i4);
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: f0 */
        public void q(CoordinatorLayout coordinatorLayout, T t, View view, int i, int i2, int[] iArr, int i3) {
            int i4;
            int i5;
            if (i2 != 0) {
                if (i2 < 0) {
                    i4 = -t.getTotalScrollRange();
                    i5 = t.getDownNestedPreScrollRange() + i4;
                } else {
                    i4 = -t.getUpNestedPreScrollRange();
                    i5 = 0;
                }
                int i6 = i4;
                int i7 = i5;
                if (i6 != i7) {
                    iArr[1] = N(coordinatorLayout, t, i2, i6, i7);
                    o0(i2, t, view, i3);
                }
            }
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: g0 */
        public void s(CoordinatorLayout coordinatorLayout, T t, View view, int i, int i2, int i3, int i4, int i5) {
            if (i4 < 0) {
                N(coordinatorLayout, t, i4, -t.getDownNestedScrollRange(), 0);
                o0(i4, t, view, i5);
            }
            if (t.i()) {
                t.o(view.getScrollY() > 0);
            }
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: h0 */
        public void w(CoordinatorLayout coordinatorLayout, T t, Parcelable parcelable) {
            if (!(parcelable instanceof SavedState)) {
                super.w(coordinatorLayout, t, parcelable);
                this.n = -1;
                return;
            }
            SavedState savedState = (SavedState) parcelable;
            super.w(coordinatorLayout, t, savedState.a());
            this.n = savedState.f2270d;
            this.p = savedState.e;
            this.o = savedState.f;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: i0 */
        public Parcelable x(CoordinatorLayout coordinatorLayout, T t) {
            Parcelable x = super.x(coordinatorLayout, t);
            int D = D();
            int childCount = t.getChildCount();
            for (int i = 0; i < childCount; i++) {
                View childAt = t.getChildAt(i);
                int bottom = childAt.getBottom() + D;
                if (childAt.getTop() + D <= 0 && bottom >= 0) {
                    SavedState savedState = new SavedState(x);
                    savedState.f2270d = i;
                    savedState.f = bottom == r.r(childAt) + t.getTopInset();
                    savedState.e = bottom / childAt.getHeight();
                    return savedState;
                }
            }
            return x;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: j0 */
        public boolean z(CoordinatorLayout coordinatorLayout, T t, View view, View view2, int i, int i2) {
            ValueAnimator valueAnimator;
            boolean z = (i & 2) != 0 && (t.i() || U(coordinatorLayout, t, view));
            if (z && (valueAnimator = this.m) != null) {
                valueAnimator.cancel();
            }
            this.q = null;
            this.l = i2;
            return z;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: k0 */
        public void B(CoordinatorLayout coordinatorLayout, T t, View view, int i) {
            if (this.l == 0 || i == 1) {
                n0(coordinatorLayout, t);
            }
            this.q = new WeakReference<>(view);
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.a
        /* renamed from: l0 */
        public int P(CoordinatorLayout coordinatorLayout, T t, int i, int i2, int i3) {
            int L = L();
            int i4 = 0;
            if (i2 == 0 || L < i2 || L > i3) {
                this.k = 0;
            } else {
                int a2 = a.f.g.a.a(i, i2, i3);
                if (L != a2) {
                    int b0 = t.e() ? b0(t, a2) : a2;
                    boolean F = F(b0);
                    i4 = L - a2;
                    this.k = a2 - b0;
                    if (!F && t.e()) {
                        coordinatorLayout.f(t);
                    }
                    t.a(D());
                    p0(coordinatorLayout, t, a2, a2 < L ? -1 : 1, false);
                }
            }
            return i4;
        }
    }

    /* loaded from: classes.dex */
    public static class Behavior extends BaseBehavior<AppBarLayout> {
        public Behavior() {
        }

        public Behavior(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
        }
    }

    /* loaded from: classes.dex */
    public static class ScrollingViewBehavior extends com.google.android.material.appbar.b {
        public ScrollingViewBehavior() {
        }

        public ScrollingViewBehavior(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, b.d.a.a.j.ScrollingViewBehavior_Layout);
            N(obtainStyledAttributes.getDimensionPixelSize(b.d.a.a.j.ScrollingViewBehavior_Layout_behavior_overlapTop, 0));
            obtainStyledAttributes.recycle();
        }

        private static int P(AppBarLayout appBarLayout) {
            CoordinatorLayout.c f = ((CoordinatorLayout.f) appBarLayout.getLayoutParams()).f();
            if (f instanceof BaseBehavior) {
                return ((BaseBehavior) f).L();
            }
            return 0;
        }

        private void Q(View view, View view2) {
            CoordinatorLayout.c f = ((CoordinatorLayout.f) view2.getLayoutParams()).f();
            if (f instanceof BaseBehavior) {
                r.I(view, (((view2.getBottom() - view.getTop()) + ((BaseBehavior) f).k) + L()) - H(view2));
            }
        }

        private void R(View view, View view2) {
            if (view2 instanceof AppBarLayout) {
                AppBarLayout appBarLayout = (AppBarLayout) view2;
                if (appBarLayout.i()) {
                    appBarLayout.o(view.getScrollY() > 0);
                }
            }
        }

        @Override // com.google.android.material.appbar.b
        float I(View view) {
            int i;
            if (view instanceof AppBarLayout) {
                AppBarLayout appBarLayout = (AppBarLayout) view;
                int totalScrollRange = appBarLayout.getTotalScrollRange();
                int downNestedPreScrollRange = appBarLayout.getDownNestedPreScrollRange();
                int P = P(appBarLayout);
                if ((downNestedPreScrollRange == 0 || totalScrollRange + P > downNestedPreScrollRange) && (i = totalScrollRange - downNestedPreScrollRange) != 0) {
                    return (P / i) + 1.0f;
                }
            }
            return 0.0f;
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.b
        public int K(View view) {
            return view instanceof AppBarLayout ? ((AppBarLayout) view).getTotalScrollRange() : super.K(view);
        }

        /* JADX INFO: Access modifiers changed from: package-private */
        @Override // com.google.android.material.appbar.b
        /* renamed from: O */
        public AppBarLayout G(List<View> list) {
            int size = list.size();
            for (int i = 0; i < size; i++) {
                View view = list.get(i);
                if (view instanceof AppBarLayout) {
                    return (AppBarLayout) view;
                }
            }
            return null;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        public boolean e(CoordinatorLayout coordinatorLayout, View view, View view2) {
            return view2 instanceof AppBarLayout;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        public boolean h(CoordinatorLayout coordinatorLayout, View view, View view2) {
            Q(view, view2);
            R(view, view2);
            return false;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        public boolean v(CoordinatorLayout coordinatorLayout, View view, Rect rect, boolean z) {
            AppBarLayout G = G(coordinatorLayout.q(view));
            if (G != null) {
                rect.offset(view.getLeft(), view.getTop());
                Rect rect2 = this.f2281d;
                rect2.set(0, 0, coordinatorLayout.getWidth(), coordinatorLayout.getHeight());
                if (!rect2.contains(rect)) {
                    G.l(false, !z);
                    return true;
                }
            }
            return false;
        }
    }

    /* loaded from: classes.dex */
    class a implements o {
        a() {
        }

        @Override // a.f.l.o
        public z a(View view, z zVar) {
            AppBarLayout.this.j(zVar);
            return zVar;
        }
    }

    /* loaded from: classes.dex */
    public interface b<T extends AppBarLayout> {
        void a(T t, int i);
    }

    /* loaded from: classes.dex */
    public static class c extends LinearLayout.LayoutParams {

        /* renamed from: a  reason: collision with root package name */
        int f2275a;

        /* renamed from: b  reason: collision with root package name */
        Interpolator f2276b;

        public c(int i, int i2) {
            super(i, i2);
            this.f2275a = 1;
        }

        public c(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f2275a = 1;
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, b.d.a.a.j.AppBarLayout_Layout);
            this.f2275a = obtainStyledAttributes.getInt(b.d.a.a.j.AppBarLayout_Layout_layout_scrollFlags, 0);
            int i = b.d.a.a.j.AppBarLayout_Layout_layout_scrollInterpolator;
            if (obtainStyledAttributes.hasValue(i)) {
                this.f2276b = AnimationUtils.loadInterpolator(context, obtainStyledAttributes.getResourceId(i, 0));
            }
            obtainStyledAttributes.recycle();
        }

        public c(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.f2275a = 1;
        }

        public c(ViewGroup.MarginLayoutParams marginLayoutParams) {
            super(marginLayoutParams);
            this.f2275a = 1;
        }

        public c(LinearLayout.LayoutParams layoutParams) {
            super(layoutParams);
            this.f2275a = 1;
        }

        public int a() {
            return this.f2275a;
        }

        public Interpolator b() {
            return this.f2276b;
        }

        boolean c() {
            int i = this.f2275a;
            return (i & 1) == 1 && (i & 10) != 0;
        }
    }

    public AppBarLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2267b = -1;
        this.f2268c = -1;
        this.f2269d = -1;
        this.f = 0;
        setOrientation(1);
        int i = Build.VERSION.SDK_INT;
        if (i >= 21) {
            e.a(this);
            e.c(this, attributeSet, 0, i.Widget_Design_AppBarLayout);
        }
        TypedArray h = f.h(context, attributeSet, b.d.a.a.j.AppBarLayout, 0, i.Widget_Design_AppBarLayout, new int[0]);
        r.Q(this, h.getDrawable(b.d.a.a.j.AppBarLayout_android_background));
        int i2 = b.d.a.a.j.AppBarLayout_expanded;
        if (h.hasValue(i2)) {
            m(h.getBoolean(i2, false), false, false);
        }
        if (i >= 21) {
            int i3 = b.d.a.a.j.AppBarLayout_elevation;
            if (h.hasValue(i3)) {
                e.b(this, h.getDimensionPixelSize(i3, 0));
            }
        }
        if (i >= 26) {
            int i4 = b.d.a.a.j.AppBarLayout_android_keyboardNavigationCluster;
            if (h.hasValue(i4)) {
                setKeyboardNavigationCluster(h.getBoolean(i4, false));
            }
            int i5 = b.d.a.a.j.AppBarLayout_android_touchscreenBlocksFocus;
            if (h.hasValue(i5)) {
                setTouchscreenBlocksFocus(h.getBoolean(i5, false));
            }
        }
        this.l = h.getBoolean(b.d.a.a.j.AppBarLayout_liftOnScroll, false);
        h.recycle();
        r.b0(this, new a());
    }

    private boolean f() {
        int childCount = getChildCount();
        for (int i = 0; i < childCount; i++) {
            if (((c) getChildAt(i).getLayoutParams()).c()) {
                return true;
            }
        }
        return false;
    }

    private void h() {
        this.f2267b = -1;
        this.f2268c = -1;
        this.f2269d = -1;
    }

    private void m(boolean z, boolean z2, boolean z3) {
        this.f = (z ? 1 : 2) | (z2 ? 4 : 0) | (z3 ? 8 : 0);
        requestLayout();
    }

    private boolean n(boolean z) {
        if (this.j != z) {
            this.j = z;
            refreshDrawableState();
            return true;
        }
        return false;
    }

    void a(int i) {
        List<b> list = this.h;
        if (list != null) {
            int size = list.size();
            for (int i2 = 0; i2 < size; i2++) {
                b bVar = this.h.get(i2);
                if (bVar != null) {
                    bVar.a(this, i);
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.widget.LinearLayout, android.view.ViewGroup
    /* renamed from: b */
    public c generateDefaultLayoutParams() {
        return new c(-1, -2);
    }

    @Override // android.widget.LinearLayout, android.view.ViewGroup
    /* renamed from: c */
    public c generateLayoutParams(AttributeSet attributeSet) {
        return new c(getContext(), attributeSet);
    }

    @Override // android.widget.LinearLayout, android.view.ViewGroup
    protected boolean checkLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return layoutParams instanceof c;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.widget.LinearLayout, android.view.ViewGroup
    /* renamed from: d */
    public c generateLayoutParams(ViewGroup.LayoutParams layoutParams) {
        return (Build.VERSION.SDK_INT < 19 || !(layoutParams instanceof LinearLayout.LayoutParams)) ? layoutParams instanceof ViewGroup.MarginLayoutParams ? new c((ViewGroup.MarginLayoutParams) layoutParams) : new c(layoutParams) : new c((LinearLayout.LayoutParams) layoutParams);
    }

    boolean e() {
        return this.e;
    }

    boolean g() {
        return getTotalScrollRange() != 0;
    }

    int getDownNestedPreScrollRange() {
        int i = this.f2268c;
        if (i != -1) {
            return i;
        }
        int i2 = 0;
        for (int childCount = getChildCount() - 1; childCount >= 0; childCount--) {
            View childAt = getChildAt(childCount);
            c cVar = (c) childAt.getLayoutParams();
            int measuredHeight = childAt.getMeasuredHeight();
            int i3 = cVar.f2275a;
            if ((i3 & 5) == 5) {
                int i4 = i2 + ((LinearLayout.LayoutParams) cVar).topMargin + ((LinearLayout.LayoutParams) cVar).bottomMargin;
                i2 = (i3 & 8) != 0 ? i4 + r.r(childAt) : i4 + (measuredHeight - ((i3 & 2) != 0 ? r.r(childAt) : getTopInset()));
            } else if (i2 > 0) {
                break;
            }
        }
        int max = Math.max(0, i2);
        this.f2268c = max;
        return max;
    }

    int getDownNestedScrollRange() {
        int i = this.f2269d;
        if (i != -1) {
            return i;
        }
        int childCount = getChildCount();
        int i2 = 0;
        int i3 = 0;
        while (true) {
            if (i2 >= childCount) {
                break;
            }
            View childAt = getChildAt(i2);
            c cVar = (c) childAt.getLayoutParams();
            int measuredHeight = childAt.getMeasuredHeight() + ((LinearLayout.LayoutParams) cVar).topMargin + ((LinearLayout.LayoutParams) cVar).bottomMargin;
            int i4 = cVar.f2275a;
            if ((i4 & 1) == 0) {
                break;
            }
            i3 += measuredHeight;
            if ((i4 & 2) != 0) {
                i3 -= r.r(childAt) + getTopInset();
                break;
            }
            i2++;
        }
        int max = Math.max(0, i3);
        this.f2269d = max;
        return max;
    }

    public final int getMinimumHeightForVisibleOverlappingContent() {
        int topInset = getTopInset();
        int r = r.r(this);
        if (r == 0) {
            int childCount = getChildCount();
            r = childCount >= 1 ? r.r(getChildAt(childCount - 1)) : 0;
            if (r == 0) {
                return getHeight() / 3;
            }
        }
        return (r * 2) + topInset;
    }

    int getPendingAction() {
        return this.f;
    }

    @Deprecated
    public float getTargetElevation() {
        return 0.0f;
    }

    final int getTopInset() {
        z zVar = this.g;
        if (zVar != null) {
            return zVar.d();
        }
        return 0;
    }

    public final int getTotalScrollRange() {
        int i = this.f2267b;
        if (i != -1) {
            return i;
        }
        int childCount = getChildCount();
        int i2 = 0;
        int i3 = 0;
        while (true) {
            if (i2 >= childCount) {
                break;
            }
            View childAt = getChildAt(i2);
            c cVar = (c) childAt.getLayoutParams();
            int measuredHeight = childAt.getMeasuredHeight();
            int i4 = cVar.f2275a;
            if ((i4 & 1) == 0) {
                break;
            }
            i3 += measuredHeight + ((LinearLayout.LayoutParams) cVar).topMargin + ((LinearLayout.LayoutParams) cVar).bottomMargin;
            if ((i4 & 2) != 0) {
                i3 -= r.r(childAt);
                break;
            }
            i2++;
        }
        int max = Math.max(0, i3 - getTopInset());
        this.f2267b = max;
        return max;
    }

    int getUpNestedPreScrollRange() {
        return getTotalScrollRange();
    }

    public boolean i() {
        return this.l;
    }

    z j(z zVar) {
        z zVar2 = r.n(this) ? zVar : null;
        if (!a.f.k.c.a(this.g, zVar2)) {
            this.g = zVar2;
            h();
        }
        return zVar;
    }

    void k() {
        this.f = 0;
    }

    public void l(boolean z, boolean z2) {
        m(z, z2, true);
    }

    boolean o(boolean z) {
        if (this.k != z) {
            this.k = z;
            refreshDrawableState();
            return true;
        }
        return false;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected int[] onCreateDrawableState(int i) {
        if (this.m == null) {
            this.m = new int[4];
        }
        int[] iArr = this.m;
        int[] onCreateDrawableState = super.onCreateDrawableState(i + iArr.length);
        boolean z = this.j;
        int i2 = b.d.a.a.b.state_liftable;
        if (!z) {
            i2 = -i2;
        }
        iArr[0] = i2;
        iArr[1] = (z && this.k) ? b.d.a.a.b.state_lifted : -b.d.a.a.b.state_lifted;
        int i3 = b.d.a.a.b.state_collapsible;
        if (!z) {
            i3 = -i3;
        }
        iArr[2] = i3;
        iArr[3] = (z && this.k) ? b.d.a.a.b.state_collapsed : -b.d.a.a.b.state_collapsed;
        return LinearLayout.mergeDrawableStates(onCreateDrawableState, iArr);
    }

    @Override // android.widget.LinearLayout, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        h();
        boolean z2 = false;
        this.e = false;
        int childCount = getChildCount();
        int i5 = 0;
        while (true) {
            if (i5 >= childCount) {
                break;
            } else if (((c) getChildAt(i5).getLayoutParams()).b() != null) {
                this.e = true;
                break;
            } else {
                i5++;
            }
        }
        if (this.i) {
            return;
        }
        if (this.l || f()) {
            z2 = true;
        }
        n(z2);
    }

    @Override // android.widget.LinearLayout, android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        h();
    }

    public void setExpanded(boolean z) {
        l(z, r.E(this));
    }

    public void setLiftOnScroll(boolean z) {
        this.l = z;
    }

    @Override // android.widget.LinearLayout
    public void setOrientation(int i) {
        if (i != 1) {
            throw new IllegalArgumentException("AppBarLayout is always vertical and does not support horizontal orientation");
        }
        super.setOrientation(i);
    }

    @Deprecated
    public void setTargetElevation(float f) {
        if (Build.VERSION.SDK_INT >= 21) {
            e.b(this, f);
        }
    }
}
