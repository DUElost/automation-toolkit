package com.google.android.material.bottomsheet;

import a.f.l.r;
import a.h.a.a;
import android.content.Context;
import android.content.res.TypedArray;
import android.os.Build;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.MotionEvent;
import android.view.VelocityTracker;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.customview.view.AbsSavedState;
import b.d.a.a.j;
import java.lang.ref.WeakReference;
import java.util.HashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class BottomSheetBehavior<V extends View> extends CoordinatorLayout.c<V> {

    /* renamed from: a  reason: collision with root package name */
    private boolean f2314a;

    /* renamed from: b  reason: collision with root package name */
    private float f2315b;

    /* renamed from: c  reason: collision with root package name */
    private int f2316c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2317d;
    private int e;
    private int f;
    int g;
    int h;
    int i;
    boolean j;
    private boolean k;
    int l;
    a.h.a.a m;
    private boolean n;
    private int o;
    private boolean p;
    int q;
    WeakReference<V> r;
    WeakReference<View> s;
    private b t;
    private VelocityTracker u;
    int v;
    private int w;
    boolean x;
    private Map<View, Integer> y;
    private final a.c z;

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static class SavedState extends AbsSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: d  reason: collision with root package name */
        final int f2318d;

        /* loaded from: classes.dex */
        static class a implements Parcelable.ClassLoaderCreator<SavedState> {
            a() {
            }

            @Override // android.os.Parcelable.Creator
            /* renamed from: a */
            public SavedState createFromParcel(Parcel parcel) {
                return new SavedState(parcel, (ClassLoader) null);
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
            this.f2318d = parcel.readInt();
        }

        public SavedState(Parcelable parcelable, int i) {
            super(parcelable);
            this.f2318d = i;
        }

        @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeInt(this.f2318d);
        }
    }

    /* loaded from: classes.dex */
    class a extends a.c {
        a() {
        }

        @Override // a.h.a.a.c
        public int a(View view, int i, int i2) {
            return view.getLeft();
        }

        @Override // a.h.a.a.c
        public int b(View view, int i, int i2) {
            int I = BottomSheetBehavior.this.I();
            BottomSheetBehavior bottomSheetBehavior = BottomSheetBehavior.this;
            return a.f.g.a.a(i, I, bottomSheetBehavior.j ? bottomSheetBehavior.q : bottomSheetBehavior.i);
        }

        @Override // a.h.a.a.c
        public int e(View view) {
            BottomSheetBehavior bottomSheetBehavior = BottomSheetBehavior.this;
            return bottomSheetBehavior.j ? bottomSheetBehavior.q : bottomSheetBehavior.i;
        }

        @Override // a.h.a.a.c
        public void j(int i) {
            if (i == 1) {
                BottomSheetBehavior.this.P(1);
            }
        }

        @Override // a.h.a.a.c
        public void k(View view, int i, int i2, int i3, int i4) {
            BottomSheetBehavior.this.G(i2);
        }

        /* JADX WARN: Code restructure failed: missing block: B:37:0x00a0, code lost:
            if (r9 < java.lang.Math.abs(r9 - r10.i)) goto L18;
         */
        /* JADX WARN: Code restructure failed: missing block: B:40:0x00b2, code lost:
            if (java.lang.Math.abs(r9 - r0) < java.lang.Math.abs(r9 - r7.f2319a.i)) goto L43;
         */
        /* JADX WARN: Removed duplicated region for block: B:44:0x00c8  */
        /* JADX WARN: Removed duplicated region for block: B:45:0x00d9  */
        @Override // a.h.a.a.c
        /*
            Code decompiled incorrectly, please refer to instructions dump.
            To view partially-correct add '--show-bad-code' argument
        */
        public void l(android.view.View r8, float r9, float r10) {
            /*
                Method dump skipped, instructions count: 223
                To view this dump add '--comments-level debug' option
            */
            throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.bottomsheet.BottomSheetBehavior.a.l(android.view.View, float, float):void");
        }

        @Override // a.h.a.a.c
        public boolean m(View view, int i) {
            View view2;
            BottomSheetBehavior bottomSheetBehavior = BottomSheetBehavior.this;
            int i2 = bottomSheetBehavior.l;
            if (i2 == 1 || bottomSheetBehavior.x) {
                return false;
            }
            if (i2 == 3 && bottomSheetBehavior.v == i && (view2 = bottomSheetBehavior.s.get()) != null && view2.canScrollVertically(-1)) {
                return false;
            }
            WeakReference<V> weakReference = BottomSheetBehavior.this.r;
            return weakReference != null && weakReference.get() == view;
        }
    }

    /* loaded from: classes.dex */
    public static abstract class b {
        public abstract void a(View view, float f);

        public abstract void b(View view, int i);
    }

    /* loaded from: classes.dex */
    private class c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private final View f2320b;

        /* renamed from: c  reason: collision with root package name */
        private final int f2321c;

        c(View view, int i) {
            this.f2320b = view;
            this.f2321c = i;
        }

        @Override // java.lang.Runnable
        public void run() {
            a.h.a.a aVar = BottomSheetBehavior.this.m;
            if (aVar == null || !aVar.k(true)) {
                BottomSheetBehavior.this.P(this.f2321c);
            } else {
                r.L(this.f2320b, this);
            }
        }
    }

    public BottomSheetBehavior() {
        this.f2314a = true;
        this.l = 4;
        this.z = new a();
    }

    public BottomSheetBehavior(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        int i;
        this.f2314a = true;
        this.l = 4;
        this.z = new a();
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, j.BottomSheetBehavior_Layout);
        int i2 = j.BottomSheetBehavior_Layout_behavior_peekHeight;
        TypedValue peekValue = obtainStyledAttributes.peekValue(i2);
        if (peekValue == null || (i = peekValue.data) != -1) {
            N(obtainStyledAttributes.getDimensionPixelSize(i2, -1));
        } else {
            N(i);
        }
        M(obtainStyledAttributes.getBoolean(j.BottomSheetBehavior_Layout_behavior_hideable, false));
        L(obtainStyledAttributes.getBoolean(j.BottomSheetBehavior_Layout_behavior_fitToContents, true));
        O(obtainStyledAttributes.getBoolean(j.BottomSheetBehavior_Layout_behavior_skipCollapsed, false));
        obtainStyledAttributes.recycle();
        this.f2315b = ViewConfiguration.get(context).getScaledMaximumFlingVelocity();
    }

    private void F() {
        this.i = this.f2314a ? Math.max(this.q - this.f, this.g) : this.q - this.f;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public int I() {
        if (this.f2314a) {
            return this.g;
        }
        return 0;
    }

    private float J() {
        VelocityTracker velocityTracker = this.u;
        if (velocityTracker == null) {
            return 0.0f;
        }
        velocityTracker.computeCurrentVelocity(1000, this.f2315b);
        return this.u.getYVelocity(this.v);
    }

    private void K() {
        this.v = -1;
        VelocityTracker velocityTracker = this.u;
        if (velocityTracker != null) {
            velocityTracker.recycle();
            this.u = null;
        }
    }

    private void R(boolean z) {
        int intValue;
        WeakReference<V> weakReference = this.r;
        if (weakReference == null) {
            return;
        }
        ViewParent parent = weakReference.get().getParent();
        if (parent instanceof CoordinatorLayout) {
            CoordinatorLayout coordinatorLayout = (CoordinatorLayout) parent;
            int childCount = coordinatorLayout.getChildCount();
            if (Build.VERSION.SDK_INT >= 16 && z) {
                if (this.y != null) {
                    return;
                }
                this.y = new HashMap(childCount);
            }
            for (int i = 0; i < childCount; i++) {
                View childAt = coordinatorLayout.getChildAt(i);
                if (childAt != this.r.get()) {
                    if (!z) {
                        Map<View, Integer> map = this.y;
                        intValue = (map != null && map.containsKey(childAt)) ? this.y.get(childAt).intValue() : 4;
                    } else if (Build.VERSION.SDK_INT >= 16) {
                        this.y.put(childAt, Integer.valueOf(childAt.getImportantForAccessibility()));
                    }
                    r.Y(childAt, intValue);
                }
            }
            if (z) {
                return;
            }
            this.y = null;
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:32:0x0078, code lost:
        if (java.lang.Math.abs(r4 - r1) < java.lang.Math.abs(r4 - r3.i)) goto L36;
     */
    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void B(androidx.coordinatorlayout.widget.CoordinatorLayout r4, V r5, android.view.View r6, int r7) {
        /*
            r3 = this;
            int r4 = r5.getTop()
            int r7 = r3.I()
            r0 = 3
            if (r4 != r7) goto Lf
            r3.P(r0)
            return
        Lf:
            java.lang.ref.WeakReference<android.view.View> r4 = r3.s
            java.lang.Object r4 = r4.get()
            if (r6 != r4) goto L9f
            boolean r4 = r3.p
            if (r4 != 0) goto L1d
            goto L9f
        L1d:
            int r4 = r3.o
            r6 = 0
            r7 = 4
            if (r4 <= 0) goto L28
            int r4 = r3.I()
            goto L81
        L28:
            boolean r4 = r3.j
            if (r4 == 0) goto L3a
            float r4 = r3.J()
            boolean r4 = r3.Q(r5, r4)
            if (r4 == 0) goto L3a
            int r4 = r3.q
            r0 = 5
            goto L81
        L3a:
            int r4 = r3.o
            if (r4 != 0) goto L7e
            int r4 = r5.getTop()
            boolean r1 = r3.f2314a
            r2 = 6
            if (r1 == 0) goto L5b
            int r1 = r3.g
            int r1 = r4 - r1
            int r1 = java.lang.Math.abs(r1)
            int r2 = r3.i
            int r4 = r4 - r2
            int r4 = java.lang.Math.abs(r4)
            if (r1 >= r4) goto L7e
            int r4 = r3.g
            goto L81
        L5b:
            int r1 = r3.h
            if (r4 >= r1) goto L6b
            int r7 = r3.i
            int r7 = r4 - r7
            int r7 = java.lang.Math.abs(r7)
            if (r4 >= r7) goto L7a
            r4 = r6
            goto L81
        L6b:
            int r0 = r4 - r1
            int r0 = java.lang.Math.abs(r0)
            int r1 = r3.i
            int r4 = r4 - r1
            int r4 = java.lang.Math.abs(r4)
            if (r0 >= r4) goto L7e
        L7a:
            int r4 = r3.h
            r0 = r2
            goto L81
        L7e:
            int r4 = r3.i
            r0 = r7
        L81:
            a.h.a.a r7 = r3.m
            int r1 = r5.getLeft()
            boolean r4 = r7.H(r5, r1, r4)
            if (r4 == 0) goto L9a
            r4 = 2
            r3.P(r4)
            com.google.android.material.bottomsheet.BottomSheetBehavior$c r4 = new com.google.android.material.bottomsheet.BottomSheetBehavior$c
            r4.<init>(r5, r0)
            a.f.l.r.L(r5, r4)
            goto L9d
        L9a:
            r3.P(r0)
        L9d:
            r3.p = r6
        L9f:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.bottomsheet.BottomSheetBehavior.B(androidx.coordinatorlayout.widget.CoordinatorLayout, android.view.View, android.view.View, int):void");
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean C(CoordinatorLayout coordinatorLayout, V v, MotionEvent motionEvent) {
        if (v.isShown()) {
            int actionMasked = motionEvent.getActionMasked();
            if (this.l == 1 && actionMasked == 0) {
                return true;
            }
            a.h.a.a aVar = this.m;
            if (aVar != null) {
                aVar.z(motionEvent);
            }
            if (actionMasked == 0) {
                K();
            }
            if (this.u == null) {
                this.u = VelocityTracker.obtain();
            }
            this.u.addMovement(motionEvent);
            if (actionMasked == 2 && !this.n && Math.abs(this.w - motionEvent.getY()) > this.m.u()) {
                this.m.b(v, motionEvent.getPointerId(motionEvent.getActionIndex()));
            }
            return !this.n;
        }
        return false;
    }

    void G(int i) {
        b bVar;
        float f;
        float I;
        V v = this.r.get();
        if (v == null || (bVar = this.t) == null) {
            return;
        }
        int i2 = this.i;
        if (i > i2) {
            f = i2 - i;
            I = this.q - i2;
        } else {
            f = i2 - i;
            I = i2 - I();
        }
        bVar.a(v, f / I);
    }

    View H(View view) {
        if (r.F(view)) {
            return view;
        }
        if (view instanceof ViewGroup) {
            ViewGroup viewGroup = (ViewGroup) view;
            int childCount = viewGroup.getChildCount();
            for (int i = 0; i < childCount; i++) {
                View H = H(viewGroup.getChildAt(i));
                if (H != null) {
                    return H;
                }
            }
            return null;
        }
        return null;
    }

    public void L(boolean z) {
        if (this.f2314a == z) {
            return;
        }
        this.f2314a = z;
        if (this.r != null) {
            F();
        }
        P((this.f2314a && this.l == 6) ? 3 : this.l);
    }

    public void M(boolean z) {
        this.j = z;
    }

    public final void N(int i) {
        WeakReference<V> weakReference;
        V v;
        boolean z = true;
        if (i == -1) {
            if (!this.f2317d) {
                this.f2317d = true;
            }
            z = false;
        } else {
            if (this.f2317d || this.f2316c != i) {
                this.f2317d = false;
                this.f2316c = Math.max(0, i);
                this.i = this.q - i;
            }
            z = false;
        }
        if (!z || this.l != 4 || (weakReference = this.r) == null || (v = weakReference.get()) == null) {
            return;
        }
        v.requestLayout();
    }

    public void O(boolean z) {
        this.k = z;
    }

    void P(int i) {
        boolean z;
        V v;
        b bVar;
        if (this.l == i) {
            return;
        }
        this.l = i;
        if (i != 6 && i != 3) {
            z = (i == 5 || i == 4) ? false : true;
            v = this.r.get();
            if (v != null || (bVar = this.t) == null) {
            }
            bVar.b(v, i);
            return;
        }
        R(z);
        v = this.r.get();
        if (v != null) {
        }
    }

    boolean Q(View view, float f) {
        if (this.k) {
            return true;
        }
        return view.getTop() >= this.i && Math.abs((((float) view.getTop()) + (f * 0.1f)) - ((float) this.i)) / ((float) this.f2316c) > 0.5f;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean k(CoordinatorLayout coordinatorLayout, V v, MotionEvent motionEvent) {
        a.h.a.a aVar;
        if (!v.isShown()) {
            this.n = true;
            return false;
        }
        int actionMasked = motionEvent.getActionMasked();
        if (actionMasked == 0) {
            K();
        }
        if (this.u == null) {
            this.u = VelocityTracker.obtain();
        }
        this.u.addMovement(motionEvent);
        if (actionMasked == 0) {
            int x = (int) motionEvent.getX();
            this.w = (int) motionEvent.getY();
            WeakReference<View> weakReference = this.s;
            View view = weakReference != null ? weakReference.get() : null;
            if (view != null && coordinatorLayout.A(view, x, this.w)) {
                this.v = motionEvent.getPointerId(motionEvent.getActionIndex());
                this.x = true;
            }
            this.n = this.v == -1 && !coordinatorLayout.A(v, x, this.w);
        } else if (actionMasked == 1 || actionMasked == 3) {
            this.x = false;
            this.v = -1;
            if (this.n) {
                this.n = false;
                return false;
            }
        }
        if (this.n || (aVar = this.m) == null || !aVar.G(motionEvent)) {
            WeakReference<View> weakReference2 = this.s;
            View view2 = weakReference2 != null ? weakReference2.get() : null;
            return (actionMasked != 2 || view2 == null || this.n || this.l == 1 || coordinatorLayout.A(view2, (int) motionEvent.getX(), (int) motionEvent.getY()) || this.m == null || Math.abs(((float) this.w) - motionEvent.getY()) <= ((float) this.m.u())) ? false : true;
        }
        return true;
    }

    /* JADX WARN: Removed duplicated region for block: B:34:0x0091  */
    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean l(androidx.coordinatorlayout.widget.CoordinatorLayout r5, V r6, int r7) {
        /*
            r4 = this;
            boolean r0 = a.f.l.r.n(r5)
            r1 = 1
            if (r0 == 0) goto L10
            boolean r0 = a.f.l.r.n(r6)
            if (r0 != 0) goto L10
            r6.setFitsSystemWindows(r1)
        L10:
            int r0 = r6.getTop()
            r5.H(r6, r7)
            int r7 = r5.getHeight()
            r4.q = r7
            boolean r7 = r4.f2317d
            if (r7 == 0) goto L43
            int r7 = r4.e
            if (r7 != 0) goto L31
            android.content.res.Resources r7 = r5.getResources()
            int r2 = b.d.a.a.d.design_bottom_sheet_peek_height_min
            int r7 = r7.getDimensionPixelSize(r2)
            r4.e = r7
        L31:
            int r7 = r4.e
            int r2 = r4.q
            int r3 = r5.getWidth()
            int r3 = r3 * 9
            int r3 = r3 / 16
            int r2 = r2 - r3
            int r7 = java.lang.Math.max(r7, r2)
            goto L45
        L43:
            int r7 = r4.f2316c
        L45:
            r4.f = r7
            r7 = 0
            int r2 = r4.q
            int r3 = r6.getHeight()
            int r2 = r2 - r3
            int r7 = java.lang.Math.max(r7, r2)
            r4.g = r7
            int r7 = r4.q
            r2 = 2
            int r7 = r7 / r2
            r4.h = r7
            r4.F()
            int r7 = r4.l
            r3 = 3
            if (r7 != r3) goto L6b
            int r7 = r4.I()
        L67:
            a.f.l.r.I(r6, r7)
            goto L8d
        L6b:
            r3 = 6
            if (r7 != r3) goto L71
            int r7 = r4.h
            goto L67
        L71:
            boolean r3 = r4.j
            if (r3 == 0) goto L7b
            r3 = 5
            if (r7 != r3) goto L7b
            int r7 = r4.q
            goto L67
        L7b:
            r3 = 4
            if (r7 != r3) goto L81
            int r7 = r4.i
            goto L67
        L81:
            if (r7 == r1) goto L85
            if (r7 != r2) goto L8d
        L85:
            int r7 = r6.getTop()
            int r0 = r0 - r7
            a.f.l.r.I(r6, r0)
        L8d:
            a.h.a.a r7 = r4.m
            if (r7 != 0) goto L99
            a.h.a.a$c r7 = r4.z
            a.h.a.a r5 = a.h.a.a.m(r5, r7)
            r4.m = r5
        L99:
            java.lang.ref.WeakReference r5 = new java.lang.ref.WeakReference
            r5.<init>(r6)
            r4.r = r5
            java.lang.ref.WeakReference r5 = new java.lang.ref.WeakReference
            android.view.View r6 = r4.H(r6)
            r5.<init>(r6)
            r4.s = r5
            return r1
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.bottomsheet.BottomSheetBehavior.l(androidx.coordinatorlayout.widget.CoordinatorLayout, android.view.View, int):boolean");
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean o(CoordinatorLayout coordinatorLayout, V v, View view, float f, float f2) {
        return view == this.s.get() && (this.l != 3 || super.o(coordinatorLayout, v, view, f, f2));
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void q(CoordinatorLayout coordinatorLayout, V v, View view, int i, int i2, int[] iArr, int i3) {
        int i4;
        if (i3 != 1 && view == this.s.get()) {
            int top = v.getTop();
            int i5 = top - i2;
            if (i2 > 0) {
                if (i5 < I()) {
                    iArr[1] = top - I();
                    r.I(v, -iArr[1]);
                    i4 = 3;
                    P(i4);
                } else {
                    iArr[1] = i2;
                    r.I(v, -i2);
                    P(1);
                }
            } else if (i2 < 0 && !view.canScrollVertically(-1)) {
                int i6 = this.i;
                if (i5 <= i6 || this.j) {
                    iArr[1] = i2;
                    r.I(v, -i2);
                    P(1);
                } else {
                    iArr[1] = top - i6;
                    r.I(v, -iArr[1]);
                    i4 = 4;
                    P(i4);
                }
            }
            G(v.getTop());
            this.o = i2;
            this.p = true;
        }
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public void w(CoordinatorLayout coordinatorLayout, V v, Parcelable parcelable) {
        SavedState savedState = (SavedState) parcelable;
        super.w(coordinatorLayout, v, savedState.a());
        int i = savedState.f2318d;
        this.l = (i == 1 || i == 2) ? 4 : 4;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public Parcelable x(CoordinatorLayout coordinatorLayout, V v) {
        return new SavedState(super.x(coordinatorLayout, v), this.l);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    public boolean z(CoordinatorLayout coordinatorLayout, V v, View view, View view2, int i, int i2) {
        this.o = 0;
        this.p = false;
        return (i & 2) != 0;
    }
}
