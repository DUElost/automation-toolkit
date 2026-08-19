package com.jude.easyrecyclerview.swipe;

import a.f.l.r;
import android.content.Context;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.os.Build;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.animation.Animation;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.Transformation;
import android.widget.AbsListView;
import android.widget.FrameLayout;
import androidx.recyclerview.widget.RecyclerView;
import jxl.SheetSettings;
/* loaded from: classes.dex */
public class SwipeRefreshLayout extends FrameLayout {
    private static final String J = SwipeRefreshLayout.class.getSimpleName();
    private static final int[] K = {16842766};
    private Animation A;
    private float B;
    private boolean C;
    private int D;
    private int E;
    private boolean F;
    private Animation.AnimationListener G;
    private final Animation H;
    private final Animation I;

    /* renamed from: b  reason: collision with root package name */
    private View f2481b;

    /* renamed from: c  reason: collision with root package name */
    private a.l.a.a f2482c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2483d;
    private int e;
    private float f;
    private int g;
    private int h;
    private boolean i;
    private float j;
    private float k;
    private boolean l;
    private int m;
    private boolean n;
    private boolean o;
    private final DecelerateInterpolator p;
    private com.jude.easyrecyclerview.swipe.a q;
    private int r;
    protected int s;
    private float t;
    protected int u;
    private com.jude.easyrecyclerview.swipe.b v;
    private Animation w;
    private Animation x;
    private Animation y;
    private Animation z;

    /* loaded from: classes.dex */
    class a implements Animation.AnimationListener {
        a() {
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationEnd(Animation animation) {
            if (SwipeRefreshLayout.this.f2483d) {
                SwipeRefreshLayout.this.v.setAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
                SwipeRefreshLayout.this.v.start();
                if (SwipeRefreshLayout.this.C && SwipeRefreshLayout.this.f2482c != null) {
                    SwipeRefreshLayout.this.f2482c.a();
                }
            } else {
                SwipeRefreshLayout.this.v.stop();
                SwipeRefreshLayout.this.q.setVisibility(8);
                SwipeRefreshLayout.this.setColorViewAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
                if (SwipeRefreshLayout.this.n) {
                    SwipeRefreshLayout.this.setAnimationProgress(0.0f);
                } else {
                    SwipeRefreshLayout swipeRefreshLayout = SwipeRefreshLayout.this;
                    swipeRefreshLayout.B(swipeRefreshLayout.u - swipeRefreshLayout.h, true);
                }
            }
            SwipeRefreshLayout swipeRefreshLayout2 = SwipeRefreshLayout.this;
            swipeRefreshLayout2.h = swipeRefreshLayout2.q.getTop();
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationRepeat(Animation animation) {
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationStart(Animation animation) {
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends Animation {
        b() {
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            SwipeRefreshLayout.this.setAnimationProgress(f);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends Animation {
        c() {
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            SwipeRefreshLayout.this.setAnimationProgress(1.0f - f);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d extends Animation {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f2487b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f2488c;

        d(int i, int i2) {
            this.f2487b = i;
            this.f2488c = i2;
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            com.jude.easyrecyclerview.swipe.b bVar = SwipeRefreshLayout.this.v;
            int i = this.f2487b;
            bVar.setAlpha((int) (i + ((this.f2488c - i) * f)));
        }
    }

    /* loaded from: classes.dex */
    class e implements Animation.AnimationListener {
        e() {
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationEnd(Animation animation) {
            if (SwipeRefreshLayout.this.n) {
                return;
            }
            SwipeRefreshLayout.this.F(null);
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationRepeat(Animation animation) {
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationStart(Animation animation) {
        }
    }

    /* loaded from: classes.dex */
    class f extends Animation {
        f() {
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            float abs = !SwipeRefreshLayout.this.F ? SwipeRefreshLayout.this.B - Math.abs(SwipeRefreshLayout.this.u) : SwipeRefreshLayout.this.B;
            SwipeRefreshLayout swipeRefreshLayout = SwipeRefreshLayout.this;
            int i = swipeRefreshLayout.s;
            SwipeRefreshLayout.this.B((i + ((int) ((((int) abs) - i) * f))) - swipeRefreshLayout.q.getTop(), false);
            SwipeRefreshLayout.this.v.j(1.0f - f);
        }
    }

    /* loaded from: classes.dex */
    class g extends Animation {
        g() {
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            SwipeRefreshLayout.this.y(f);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h extends Animation {
        h() {
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            SwipeRefreshLayout.this.setAnimationProgress(SwipeRefreshLayout.this.t + ((-SwipeRefreshLayout.this.t) * f));
            SwipeRefreshLayout.this.y(f);
        }
    }

    public SwipeRefreshLayout(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f2483d = false;
        this.f = -1.0f;
        this.i = false;
        this.m = -1;
        this.r = -1;
        this.G = new a();
        this.H = new f();
        this.I = new g();
        this.e = ViewConfiguration.get(context).getScaledTouchSlop();
        this.g = getResources().getInteger(17694721);
        setWillNotDraw(false);
        this.p = new DecelerateInterpolator(2.0f);
        TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, K);
        setEnabled(obtainStyledAttributes.getBoolean(0, true));
        obtainStyledAttributes.recycle();
        DisplayMetrics displayMetrics = getResources().getDisplayMetrics();
        float f2 = displayMetrics.density;
        this.D = (int) (f2 * 40.0f);
        this.E = (int) (f2 * 40.0f);
        t();
        r.T(this, true);
        float f3 = displayMetrics.density * 64.0f;
        this.B = f3;
        this.f = f3;
        requestDisallowInterceptTouchEvent(true);
    }

    private void A(boolean z, boolean z2) {
        if (this.f2483d != z) {
            this.C = z2;
            u();
            this.f2483d = z;
            if (z) {
                q(this.h, this.G);
            } else {
                F(this.G);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void B(int i, boolean z) {
        this.q.bringToFront();
        this.q.offsetTopAndBottom(i);
        this.h = this.q.getTop();
        if (!z || Build.VERSION.SDK_INT >= 11) {
            return;
        }
        invalidate();
    }

    private Animation C(int i, int i2) {
        if (this.n && w()) {
            return null;
        }
        d dVar = new d(i, i2);
        dVar.setDuration(300L);
        this.q.d(null);
        this.q.clearAnimation();
        this.q.startAnimation(dVar);
        return dVar;
    }

    private void D() {
        this.z = C(this.v.getAlpha(), SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
    }

    private void E() {
        this.y = C(this.v.getAlpha(), 76);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void F(Animation.AnimationListener animationListener) {
        c cVar = new c();
        this.x = cVar;
        cVar.setDuration(150L);
        this.q.d(animationListener);
        this.q.clearAnimation();
        this.q.startAnimation(this.x);
    }

    private void G(int i, Animation.AnimationListener animationListener) {
        this.s = i;
        this.t = w() ? this.v.getAlpha() : r.v(this.q);
        h hVar = new h();
        this.A = hVar;
        hVar.setDuration(150L);
        if (animationListener != null) {
            this.q.d(animationListener);
        }
        this.q.clearAnimation();
        this.q.startAnimation(this.A);
    }

    private void H(Animation.AnimationListener animationListener) {
        this.q.setVisibility(0);
        if (Build.VERSION.SDK_INT >= 11) {
            this.v.setAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
        }
        b bVar = new b();
        this.w = bVar;
        bVar.setDuration(this.g);
        if (animationListener != null) {
            this.q.d(animationListener);
        }
        this.q.clearAnimation();
        this.q.startAnimation(this.w);
    }

    private void q(int i, Animation.AnimationListener animationListener) {
        this.s = i;
        this.H.reset();
        this.H.setDuration(200L);
        this.H.setInterpolator(this.p);
        if (animationListener != null) {
            this.q.d(animationListener);
        }
        this.q.clearAnimation();
        this.q.startAnimation(this.H);
    }

    private void r(int i, Animation.AnimationListener animationListener) {
        if (this.n) {
            G(i, animationListener);
            return;
        }
        this.s = i;
        this.I.reset();
        this.I.setDuration(200L);
        this.I.setInterpolator(this.p);
        if (animationListener != null) {
            this.q.d(animationListener);
        }
        this.q.clearAnimation();
        this.q.startAnimation(this.I);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setAnimationProgress(float f2) {
        if (w()) {
            setColorViewAlpha((int) (f2 * 255.0f));
            return;
        }
        r.e0(this.q, f2);
        r.f0(this.q, f2);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void setColorViewAlpha(int i) {
        this.q.getBackground().setAlpha(i);
        this.v.setAlpha(i);
    }

    private void t() {
        this.q = new com.jude.easyrecyclerview.swipe.a(getContext(), -328966, 20.0f);
        com.jude.easyrecyclerview.swipe.b bVar = new com.jude.easyrecyclerview.swipe.b(getContext(), this);
        this.v = bVar;
        bVar.k(-328966);
        this.q.setImageDrawable(this.v);
        this.q.setVisibility(8);
        addView(this.q);
    }

    private void u() {
        if (this.f2481b == null) {
            for (int i = 0; i < getChildCount(); i++) {
                View childAt = getChildAt(i);
                if (childAt.getClass().isAssignableFrom(RecyclerView.class)) {
                    this.f2481b = childAt;
                    return;
                }
            }
        }
    }

    private float v(MotionEvent motionEvent, int i) {
        int a2 = a.f.l.h.a(motionEvent, i);
        if (a2 < 0) {
            return -1.0f;
        }
        return a.f.l.h.e(motionEvent, a2);
    }

    private boolean w() {
        return Build.VERSION.SDK_INT < 11;
    }

    private boolean x(Animation animation) {
        return (animation == null || !animation.hasStarted() || animation.hasEnded()) ? false : true;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void y(float f2) {
        int i = this.s;
        B((i + ((int) ((this.u - i) * f2))) - this.q.getTop(), false);
    }

    private void z(MotionEvent motionEvent) {
        int b2 = a.f.l.h.b(motionEvent);
        if (a.f.l.h.d(motionEvent, b2) == this.m) {
            this.m = a.f.l.h.d(motionEvent, b2 == 0 ? 1 : 0);
        }
    }

    @Override // android.view.ViewGroup, android.view.View
    public boolean dispatchTouchEvent(MotionEvent motionEvent) {
        return super.dispatchTouchEvent(motionEvent);
    }

    @Override // android.view.ViewGroup
    protected int getChildDrawingOrder(int i, int i2) {
        int i3 = this.r;
        return i3 < 0 ? i2 : i2 == i + (-1) ? i3 : i2 >= i3 ? i2 + 1 : i2;
    }

    public int getProgressCircleDiameter() {
        com.jude.easyrecyclerview.swipe.a aVar = this.q;
        if (aVar != null) {
            return aVar.getMeasuredHeight();
        }
        return 0;
    }

    @Override // android.view.ViewGroup
    public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
        u();
        int c2 = a.f.l.h.c(motionEvent);
        if (this.o && c2 == 0) {
            this.o = false;
        }
        if (!isEnabled() || this.o || s() || this.f2483d) {
            return false;
        }
        if (c2 != 0) {
            if (c2 != 1) {
                if (c2 == 2) {
                    int i = this.m;
                    if (i == -1) {
                        Log.e(J, "Got ACTION_MOVE event but don't have an active pointer id.");
                        return false;
                    }
                    float v = v(motionEvent, i);
                    if (v == -1.0f) {
                        return false;
                    }
                    float f2 = this.k;
                    int i2 = this.e;
                    if (v - f2 > i2 && !this.l) {
                        this.j = f2 + i2;
                        this.l = true;
                        this.v.setAlpha(76);
                    }
                } else if (c2 != 3) {
                    if (c2 == 6) {
                        z(motionEvent);
                    }
                }
            }
            this.l = false;
            this.m = -1;
        } else {
            B(this.u - this.q.getTop(), true);
            int d2 = a.f.l.h.d(motionEvent, 0);
            this.m = d2;
            this.l = false;
            float v2 = v(motionEvent, d2);
            if (v2 == -1.0f) {
                return false;
            }
            this.k = v2;
        }
        return this.l;
    }

    @Override // android.widget.FrameLayout, android.view.ViewGroup, android.view.View
    protected void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        int measuredWidth = getMeasuredWidth();
        int measuredHeight = getMeasuredHeight();
        if (getChildCount() == 0) {
            return;
        }
        if (this.f2481b == null) {
            u();
        }
        View view = this.f2481b;
        if (view == null) {
            return;
        }
        int paddingLeft = getPaddingLeft();
        int paddingTop = getPaddingTop();
        view.layout(paddingLeft, paddingTop, ((measuredWidth - getPaddingLeft()) - getPaddingRight()) + paddingLeft, ((measuredHeight - getPaddingTop()) - getPaddingBottom()) + paddingTop);
        int measuredWidth2 = this.q.getMeasuredWidth();
        int measuredHeight2 = this.q.getMeasuredHeight();
        int i5 = measuredWidth / 2;
        int i6 = measuredWidth2 / 2;
        int i7 = this.h;
        this.q.layout(i5 - i6, i7, i5 + i6, measuredHeight2 + i7);
    }

    @Override // android.widget.FrameLayout, android.view.View
    public void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        if (this.f2481b == null) {
            u();
        }
        View view = this.f2481b;
        if (view == null) {
            return;
        }
        view.measure(View.MeasureSpec.makeMeasureSpec((getMeasuredWidth() - getPaddingLeft()) - getPaddingRight(), 1073741824), View.MeasureSpec.makeMeasureSpec((getMeasuredHeight() - getPaddingTop()) - getPaddingBottom(), 1073741824));
        this.q.measure(View.MeasureSpec.makeMeasureSpec(this.D, 1073741824), View.MeasureSpec.makeMeasureSpec(this.E, 1073741824));
        if (!this.F && !this.i) {
            this.i = true;
            int i3 = -this.q.getMeasuredHeight();
            this.u = i3;
            this.h = i3;
        }
        this.r = -1;
        for (int i4 = 0; i4 < getChildCount(); i4++) {
            if (getChildAt(i4) == this.q) {
                this.r = i4;
                return;
            }
        }
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        int c2 = a.f.l.h.c(motionEvent);
        if (this.o && c2 == 0) {
            this.o = false;
        }
        if (!isEnabled() || this.o || s()) {
            return false;
        }
        if (c2 != 0) {
            if (c2 != 1) {
                if (c2 == 2) {
                    int a2 = a.f.l.h.a(motionEvent, this.m);
                    if (a2 < 0) {
                        Log.e(J, "Got ACTION_MOVE event but have an invalid active pointer id.");
                        return false;
                    }
                    float e2 = (a.f.l.h.e(motionEvent, a2) - this.j) * 0.5f;
                    if (this.l) {
                        this.v.r(true);
                        float f2 = e2 / this.f;
                        if (f2 < 0.0f) {
                            return false;
                        }
                        float min = Math.min(1.0f, Math.abs(f2));
                        float max = (((float) Math.max(min - 0.4d, 0.0d)) * 5.0f) / 3.0f;
                        float abs = Math.abs(e2) - this.f;
                        float f3 = this.F ? this.B - this.u : this.B;
                        double max2 = Math.max(0.0f, Math.min(abs, f3 * 2.0f) / f3) / 4.0f;
                        float pow = ((float) (max2 - Math.pow(max2, 2.0d))) * 2.0f;
                        int i = this.u + ((int) ((f3 * min) + (f3 * pow * 2.0f)));
                        if (this.q.getVisibility() != 0) {
                            this.q.setVisibility(0);
                        }
                        if (!this.n) {
                            r.e0(this.q, 1.0f);
                            r.f0(this.q, 1.0f);
                        }
                        float f4 = this.f;
                        if (e2 < f4) {
                            if (this.n) {
                                setAnimationProgress(e2 / f4);
                            }
                            if (this.v.getAlpha() > 76 && !x(this.y)) {
                                E();
                            }
                            this.v.p(0.0f, Math.min(0.8f, max * 0.8f));
                            this.v.j(Math.min(1.0f, max));
                        } else if (this.v.getAlpha() < 255 && !x(this.z)) {
                            D();
                        }
                        this.v.m((((max * 0.4f) - 0.25f) + (pow * 2.0f)) * 0.5f);
                        B(i - this.h, true);
                    }
                } else if (c2 != 3) {
                    if (c2 == 5) {
                        this.m = a.f.l.h.d(motionEvent, a.f.l.h.b(motionEvent));
                    } else if (c2 == 6) {
                        z(motionEvent);
                    }
                }
            }
            int i2 = this.m;
            if (i2 == -1) {
                if (c2 == 1) {
                    Log.e(J, "Got ACTION_UP event but don't have an active pointer id.");
                }
                return false;
            }
            this.l = false;
            if ((a.f.l.h.e(motionEvent, a.f.l.h.a(motionEvent, i2)) - this.j) * 0.5f > this.f) {
                A(true, true);
            } else {
                this.f2483d = false;
                this.v.p(0.0f, 0.0f);
                r(this.h, this.n ? null : new e());
                this.v.r(false);
            }
            this.m = -1;
            return false;
        }
        this.m = a.f.l.h.d(motionEvent, 0);
        this.l = false;
        return true;
    }

    @Override // android.view.ViewGroup, android.view.ViewParent
    public void requestDisallowInterceptTouchEvent(boolean z) {
        super.requestDisallowInterceptTouchEvent(z);
    }

    public boolean s() {
        if (Build.VERSION.SDK_INT < 14) {
            View view = this.f2481b;
            if (!(view instanceof AbsListView)) {
                return r.b(view, -1) || this.f2481b.getScrollY() > 0;
            }
            AbsListView absListView = (AbsListView) view;
            return absListView.getChildCount() > 0 && (absListView.getFirstVisiblePosition() > 0 || absListView.getChildAt(0).getTop() < absListView.getPaddingTop());
        }
        return r.b(this.f2481b, -1);
    }

    @Deprecated
    public void setColorScheme(int... iArr) {
        setColorSchemeResources(iArr);
    }

    public void setColorSchemeColors(int... iArr) {
        u();
        this.v.l(iArr);
    }

    public void setColorSchemeResources(int... iArr) {
        Resources resources = getResources();
        int[] iArr2 = new int[iArr.length];
        for (int i = 0; i < iArr.length; i++) {
            iArr2[i] = resources.getColor(iArr[i]);
        }
        setColorSchemeColors(iArr2);
    }

    public void setDistanceToTriggerSync(int i) {
        this.f = i;
    }

    public void setOnRefreshListener(a.l.a.a aVar) {
        this.f2482c = aVar;
    }

    @Deprecated
    public void setProgressBackgroundColor(int i) {
        setProgressBackgroundColorSchemeResource(i);
    }

    public void setProgressBackgroundColorSchemeColor(int i) {
        this.q.setBackgroundColor(i);
        this.v.k(i);
    }

    public void setProgressBackgroundColorSchemeResource(int i) {
        setProgressBackgroundColorSchemeColor(getResources().getColor(i));
    }

    public void setRefreshing(boolean z) {
        if (!z || this.f2483d == z) {
            A(z, false);
            return;
        }
        this.f2483d = z;
        B(((int) (!this.F ? this.B + this.u : this.B)) - this.h, true);
        this.C = false;
        H(this.G);
    }

    public void setSize(int i) {
        if (i == 0 || i == 1) {
            int i2 = (int) (getResources().getDisplayMetrics().density * (i == 0 ? 56.0f : 40.0f));
            this.D = i2;
            this.E = i2;
            this.q.setImageDrawable(null);
            this.v.t(i);
            this.q.setImageDrawable(this.v);
        }
    }
}
