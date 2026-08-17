package com.google.android.material.appbar;

import a.f.l.r;
import android.content.Context;
import android.util.AttributeSet;
import android.view.VelocityTracker;
import android.view.View;
import android.widget.OverScroller;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
/* loaded from: classes.dex */
abstract class a<V extends View> extends c<V> {

    /* renamed from: d  reason: collision with root package name */
    private Runnable f2277d;
    OverScroller e;
    private boolean f;
    private int g;
    private int h;
    private int i;
    private VelocityTracker j;

    /* JADX INFO: Access modifiers changed from: private */
    /* JADX WARN: Field signature parse error: c
    jadx.core.utils.exceptions.JadxRuntimeException: Can't parse type: TV at position 1 ('V'), unexpected: T
    	at jadx.core.dex.nodes.parser.SignatureParser.consumeType(SignatureParser.java:169)
    	at jadx.core.dex.visitors.SignatureProcessor.parseFieldSignature(SignatureProcessor.java:128)
    	at jadx.core.dex.visitors.SignatureProcessor.visit(SignatureProcessor.java:36)
     */
    /* renamed from: com.google.android.material.appbar.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class RunnableC0096a implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        private final CoordinatorLayout f2278b;

        /* renamed from: c  reason: collision with root package name */
        private final View f2279c;

        RunnableC0096a(CoordinatorLayout coordinatorLayout, V v) {
            this.f2278b = coordinatorLayout;
            this.f2279c = v;
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Override // java.lang.Runnable
        public void run() {
            OverScroller overScroller;
            if (this.f2279c == null || (overScroller = a.this.e) == null) {
                return;
            }
            if (!overScroller.computeScrollOffset()) {
                a.this.M(this.f2278b, this.f2279c);
                return;
            }
            a aVar = a.this;
            aVar.O(this.f2278b, this.f2279c, aVar.e.getCurrY());
            r.L(this.f2279c, this);
        }
    }

    public a() {
        this.g = -1;
        this.i = -1;
    }

    public a(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.g = -1;
        this.i = -1;
    }

    private void H() {
        if (this.j == null) {
            this.j = VelocityTracker.obtain();
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:12:0x0021, code lost:
        if (r0 != 3) goto L15;
     */
    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean C(androidx.coordinatorlayout.widget.CoordinatorLayout r12, V r13, android.view.MotionEvent r14) {
        /*
            r11 = this;
            int r0 = r11.i
            if (r0 >= 0) goto L12
            android.content.Context r0 = r12.getContext()
            android.view.ViewConfiguration r0 = android.view.ViewConfiguration.get(r0)
            int r0 = r0.getScaledTouchSlop()
            r11.i = r0
        L12:
            int r0 = r14.getActionMasked()
            r1 = 1
            r2 = 0
            if (r0 == 0) goto L8d
            r3 = -1
            if (r0 == r1) goto L5c
            r4 = 2
            if (r0 == r4) goto L25
            r12 = 3
            if (r0 == r12) goto L7e
            goto Lae
        L25:
            int r0 = r11.g
            int r0 = r14.findPointerIndex(r0)
            if (r0 != r3) goto L2e
            return r2
        L2e:
            float r0 = r14.getY(r0)
            int r0 = (int) r0
            int r2 = r11.h
            int r2 = r2 - r0
            boolean r3 = r11.f
            if (r3 != 0) goto L49
            int r3 = java.lang.Math.abs(r2)
            int r4 = r11.i
            if (r3 <= r4) goto L49
            r11.f = r1
            if (r2 <= 0) goto L48
            int r2 = r2 - r4
            goto L49
        L48:
            int r2 = r2 + r4
        L49:
            r6 = r2
            boolean r2 = r11.f
            if (r2 == 0) goto Lae
            r11.h = r0
            int r7 = r11.J(r13)
            r8 = 0
            r3 = r11
            r4 = r12
            r5 = r13
            r3.N(r4, r5, r6, r7, r8)
            goto Lae
        L5c:
            android.view.VelocityTracker r0 = r11.j
            if (r0 == 0) goto L7e
            r0.addMovement(r14)
            android.view.VelocityTracker r0 = r11.j
            r4 = 1000(0x3e8, float:1.401E-42)
            r0.computeCurrentVelocity(r4)
            android.view.VelocityTracker r0 = r11.j
            int r4 = r11.g
            float r10 = r0.getYVelocity(r4)
            int r0 = r11.K(r13)
            int r8 = -r0
            r9 = 0
            r5 = r11
            r6 = r12
            r7 = r13
            r5.I(r6, r7, r8, r9, r10)
        L7e:
            r11.f = r2
            r11.g = r3
            android.view.VelocityTracker r12 = r11.j
            if (r12 == 0) goto Lae
            r12.recycle()
            r12 = 0
            r11.j = r12
            goto Lae
        L8d:
            float r0 = r14.getX()
            int r0 = (int) r0
            float r3 = r14.getY()
            int r3 = (int) r3
            boolean r12 = r12.A(r13, r0, r3)
            if (r12 == 0) goto Lb6
            boolean r12 = r11.G(r13)
            if (r12 == 0) goto Lb6
            r11.h = r3
            int r12 = r14.getPointerId(r2)
            r11.g = r12
            r11.H()
        Lae:
            android.view.VelocityTracker r12 = r11.j
            if (r12 == 0) goto Lb5
            r12.addMovement(r14)
        Lb5:
            return r1
        Lb6:
            return r2
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.appbar.a.C(androidx.coordinatorlayout.widget.CoordinatorLayout, android.view.View, android.view.MotionEvent):boolean");
    }

    abstract boolean G(V v);

    final boolean I(CoordinatorLayout coordinatorLayout, V v, int i, int i2, float f) {
        Runnable runnable = this.f2277d;
        if (runnable != null) {
            v.removeCallbacks(runnable);
            this.f2277d = null;
        }
        if (this.e == null) {
            this.e = new OverScroller(v.getContext());
        }
        this.e.fling(0, D(), 0, Math.round(f), 0, 0, i, i2);
        if (!this.e.computeScrollOffset()) {
            M(coordinatorLayout, v);
            return false;
        }
        RunnableC0096a runnableC0096a = new RunnableC0096a(coordinatorLayout, v);
        this.f2277d = runnableC0096a;
        r.L(v, runnableC0096a);
        return true;
    }

    abstract int J(V v);

    abstract int K(V v);

    abstract int L();

    abstract void M(CoordinatorLayout coordinatorLayout, V v);

    /* JADX INFO: Access modifiers changed from: package-private */
    public final int N(CoordinatorLayout coordinatorLayout, V v, int i, int i2, int i3) {
        return P(coordinatorLayout, v, L() - i, i2, i3);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int O(CoordinatorLayout coordinatorLayout, V v, int i) {
        return P(coordinatorLayout, v, i, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    abstract int P(CoordinatorLayout coordinatorLayout, V v, int i, int i2, int i3);

    /* JADX WARN: Code restructure failed: missing block: B:16:0x002c, code lost:
        if (r0 != 3) goto L17;
     */
    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public boolean k(androidx.coordinatorlayout.widget.CoordinatorLayout r5, V r6, android.view.MotionEvent r7) {
        /*
            r4 = this;
            int r0 = r4.i
            if (r0 >= 0) goto L12
            android.content.Context r0 = r5.getContext()
            android.view.ViewConfiguration r0 = android.view.ViewConfiguration.get(r0)
            int r0 = r0.getScaledTouchSlop()
            r4.i = r0
        L12:
            int r0 = r7.getAction()
            r1 = 2
            r2 = 1
            if (r0 != r1) goto L1f
            boolean r0 = r4.f
            if (r0 == 0) goto L1f
            return r2
        L1f:
            int r0 = r7.getActionMasked()
            r3 = 0
            if (r0 == 0) goto L60
            r5 = -1
            if (r0 == r2) goto L51
            if (r0 == r1) goto L2f
            r6 = 3
            if (r0 == r6) goto L51
            goto L83
        L2f:
            int r6 = r4.g
            if (r6 != r5) goto L34
            goto L83
        L34:
            int r6 = r7.findPointerIndex(r6)
            if (r6 != r5) goto L3b
            goto L83
        L3b:
            float r5 = r7.getY(r6)
            int r5 = (int) r5
            int r6 = r4.h
            int r6 = r5 - r6
            int r6 = java.lang.Math.abs(r6)
            int r0 = r4.i
            if (r6 <= r0) goto L83
            r4.f = r2
            r4.h = r5
            goto L83
        L51:
            r4.f = r3
            r4.g = r5
            android.view.VelocityTracker r5 = r4.j
            if (r5 == 0) goto L83
            r5.recycle()
            r5 = 0
            r4.j = r5
            goto L83
        L60:
            r4.f = r3
            float r0 = r7.getX()
            int r0 = (int) r0
            float r1 = r7.getY()
            int r1 = (int) r1
            boolean r2 = r4.G(r6)
            if (r2 == 0) goto L83
            boolean r5 = r5.A(r6, r0, r1)
            if (r5 == 0) goto L83
            r4.h = r1
            int r5 = r7.getPointerId(r3)
            r4.g = r5
            r4.H()
        L83:
            android.view.VelocityTracker r5 = r4.j
            if (r5 == 0) goto L8a
            r5.addMovement(r7)
        L8a:
            boolean r5 = r4.f
            return r5
        */
        throw new UnsupportedOperationException("Method not decompiled: com.google.android.material.appbar.a.k(androidx.coordinatorlayout.widget.CoordinatorLayout, android.view.View, android.view.MotionEvent):boolean");
    }
}
