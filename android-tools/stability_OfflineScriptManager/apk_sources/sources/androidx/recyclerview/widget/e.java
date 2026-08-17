package androidx.recyclerview.widget;

import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ValueAnimator;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.view.MotionEvent;
import androidx.recyclerview.widget.RecyclerView;
import jxl.SheetSettings;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class e extends RecyclerView.n implements RecyclerView.s {
    private static final int[] D = {16842919};
    private static final int[] E = new int[0];
    int A;
    private final Runnable B;
    private final RecyclerView.t C;

    /* renamed from: a  reason: collision with root package name */
    private final int f1235a;

    /* renamed from: b  reason: collision with root package name */
    private final int f1236b;

    /* renamed from: c  reason: collision with root package name */
    final StateListDrawable f1237c;

    /* renamed from: d  reason: collision with root package name */
    final Drawable f1238d;
    private final int e;
    private final int f;
    private final StateListDrawable g;
    private final Drawable h;
    private final int i;
    private final int j;
    int k;
    int l;
    float m;
    int n;
    int o;
    float p;
    private RecyclerView s;
    final ValueAnimator z;
    private int q = 0;
    private int r = 0;
    private boolean t = false;
    private boolean u = false;
    private int v = 0;
    private int w = 0;
    private final int[] x = new int[2];
    private final int[] y = new int[2];

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            e.this.q(500);
        }
    }

    /* loaded from: classes.dex */
    class b extends RecyclerView.t {
        b() {
        }

        @Override // androidx.recyclerview.widget.RecyclerView.t
        public void b(RecyclerView recyclerView, int i, int i2) {
            e.this.B(recyclerView.computeHorizontalScrollOffset(), recyclerView.computeVerticalScrollOffset());
        }
    }

    /* loaded from: classes.dex */
    private class c extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        private boolean f1241a = false;

        c() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f1241a = true;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            if (this.f1241a) {
                this.f1241a = false;
            } else if (((Float) e.this.z.getAnimatedValue()).floatValue() == 0.0f) {
                e eVar = e.this;
                eVar.A = 0;
                eVar.y(0);
            } else {
                e eVar2 = e.this;
                eVar2.A = 2;
                eVar2.v();
            }
        }
    }

    /* loaded from: classes.dex */
    private class d implements ValueAnimator.AnimatorUpdateListener {
        d() {
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            int floatValue = (int) (((Float) valueAnimator.getAnimatedValue()).floatValue() * 255.0f);
            e.this.f1237c.setAlpha(floatValue);
            e.this.f1238d.setAlpha(floatValue);
            e.this.v();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public e(RecyclerView recyclerView, StateListDrawable stateListDrawable, Drawable drawable, StateListDrawable stateListDrawable2, Drawable drawable2, int i, int i2, int i3) {
        ValueAnimator ofFloat = ValueAnimator.ofFloat(0.0f, 1.0f);
        this.z = ofFloat;
        this.A = 0;
        this.B = new a();
        this.C = new b();
        this.f1237c = stateListDrawable;
        this.f1238d = drawable;
        this.g = stateListDrawable2;
        this.h = drawable2;
        this.e = Math.max(i, stateListDrawable.getIntrinsicWidth());
        this.f = Math.max(i, drawable.getIntrinsicWidth());
        this.i = Math.max(i, stateListDrawable2.getIntrinsicWidth());
        this.j = Math.max(i, drawable2.getIntrinsicWidth());
        this.f1235a = i2;
        this.f1236b = i3;
        stateListDrawable.setAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
        drawable.setAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT);
        ofFloat.addListener(new c());
        ofFloat.addUpdateListener(new d());
        j(recyclerView);
    }

    private void C(float f) {
        int[] p = p();
        float max = Math.max(p[0], Math.min(p[1], f));
        if (Math.abs(this.l - max) < 2.0f) {
            return;
        }
        int x = x(this.m, max, p, this.s.computeVerticalScrollRange(), this.s.computeVerticalScrollOffset(), this.r);
        if (x != 0) {
            this.s.scrollBy(0, x);
        }
        this.m = max;
    }

    private void k() {
        this.s.removeCallbacks(this.B);
    }

    private void l() {
        this.s.W0(this);
        this.s.X0(this);
        this.s.Y0(this.C);
        k();
    }

    private void m(Canvas canvas) {
        int i = this.r;
        int i2 = this.i;
        int i3 = i - i2;
        int i4 = this.o;
        int i5 = this.n;
        int i6 = i4 - (i5 / 2);
        this.g.setBounds(0, 0, i5, i2);
        this.h.setBounds(0, 0, this.q, this.j);
        canvas.translate(0.0f, i3);
        this.h.draw(canvas);
        canvas.translate(i6, 0.0f);
        this.g.draw(canvas);
        canvas.translate(-i6, -i3);
    }

    private void n(Canvas canvas) {
        int i = this.q;
        int i2 = this.e;
        int i3 = i - i2;
        int i4 = this.l;
        int i5 = this.k;
        int i6 = i4 - (i5 / 2);
        this.f1237c.setBounds(0, 0, i2, i5);
        this.f1238d.setBounds(0, 0, this.f, this.r);
        if (s()) {
            this.f1238d.draw(canvas);
            canvas.translate(this.e, i6);
            canvas.scale(-1.0f, 1.0f);
            this.f1237c.draw(canvas);
            canvas.scale(1.0f, 1.0f);
            i3 = this.e;
        } else {
            canvas.translate(i3, 0.0f);
            this.f1238d.draw(canvas);
            canvas.translate(0.0f, i6);
            this.f1237c.draw(canvas);
        }
        canvas.translate(-i3, -i6);
    }

    private int[] o() {
        int[] iArr = this.y;
        int i = this.f1236b;
        iArr[0] = i;
        iArr[1] = this.q - i;
        return iArr;
    }

    private int[] p() {
        int[] iArr = this.x;
        int i = this.f1236b;
        iArr[0] = i;
        iArr[1] = this.r - i;
        return iArr;
    }

    private void r(float f) {
        int[] o = o();
        float max = Math.max(o[0], Math.min(o[1], f));
        if (Math.abs(this.o - max) < 2.0f) {
            return;
        }
        int x = x(this.p, max, o, this.s.computeHorizontalScrollRange(), this.s.computeHorizontalScrollOffset(), this.q);
        if (x != 0) {
            this.s.scrollBy(x, 0);
        }
        this.p = max;
    }

    private boolean s() {
        return r.q(this.s) == 1;
    }

    private void w(int i) {
        k();
        this.s.postDelayed(this.B, i);
    }

    private int x(float f, float f2, int[] iArr, int i, int i2, int i3) {
        int i4 = iArr[1] - iArr[0];
        if (i4 == 0) {
            return 0;
        }
        int i5 = i - i3;
        int i6 = (int) (((f2 - f) / i4) * i5);
        int i7 = i2 + i6;
        if (i7 >= i5 || i7 < 0) {
            return 0;
        }
        return i6;
    }

    private void z() {
        this.s.i(this);
        this.s.k(this);
        this.s.l(this.C);
    }

    public void A() {
        int i = this.A;
        if (i != 0) {
            if (i != 3) {
                return;
            }
            this.z.cancel();
        }
        this.A = 1;
        ValueAnimator valueAnimator = this.z;
        valueAnimator.setFloatValues(((Float) valueAnimator.getAnimatedValue()).floatValue(), 1.0f);
        this.z.setDuration(500L);
        this.z.setStartDelay(0L);
        this.z.start();
    }

    void B(int i, int i2) {
        int computeVerticalScrollRange = this.s.computeVerticalScrollRange();
        int i3 = this.r;
        this.t = computeVerticalScrollRange - i3 > 0 && i3 >= this.f1235a;
        int computeHorizontalScrollRange = this.s.computeHorizontalScrollRange();
        int i4 = this.q;
        boolean z = computeHorizontalScrollRange - i4 > 0 && i4 >= this.f1235a;
        this.u = z;
        boolean z2 = this.t;
        if (!z2 && !z) {
            if (this.v != 0) {
                y(0);
                return;
            }
            return;
        }
        if (z2) {
            float f = i3;
            this.l = (int) ((f * (i2 + (f / 2.0f))) / computeVerticalScrollRange);
            this.k = Math.min(i3, (i3 * i3) / computeVerticalScrollRange);
        }
        if (this.u) {
            float f2 = i4;
            this.o = (int) ((f2 * (i + (f2 / 2.0f))) / computeHorizontalScrollRange);
            this.n = Math.min(i4, (i4 * i4) / computeHorizontalScrollRange);
        }
        int i5 = this.v;
        if (i5 == 0 || i5 == 1) {
            y(1);
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.s
    public boolean a(RecyclerView recyclerView, MotionEvent motionEvent) {
        int i = this.v;
        if (i == 1) {
            boolean u = u(motionEvent.getX(), motionEvent.getY());
            boolean t = t(motionEvent.getX(), motionEvent.getY());
            if (motionEvent.getAction() != 0) {
                return false;
            }
            if (!u && !t) {
                return false;
            }
            if (t) {
                this.w = 1;
                this.p = (int) motionEvent.getX();
            } else if (u) {
                this.w = 2;
                this.m = (int) motionEvent.getY();
            }
            y(2);
        } else if (i != 2) {
            return false;
        }
        return true;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.s
    public void b(RecyclerView recyclerView, MotionEvent motionEvent) {
        if (this.v == 0) {
            return;
        }
        if (motionEvent.getAction() == 0) {
            boolean u = u(motionEvent.getX(), motionEvent.getY());
            boolean t = t(motionEvent.getX(), motionEvent.getY());
            if (u || t) {
                if (t) {
                    this.w = 1;
                    this.p = (int) motionEvent.getX();
                } else if (u) {
                    this.w = 2;
                    this.m = (int) motionEvent.getY();
                }
                y(2);
            }
        } else if (motionEvent.getAction() == 1 && this.v == 2) {
            this.m = 0.0f;
            this.p = 0.0f;
            y(1);
            this.w = 0;
        } else if (motionEvent.getAction() == 2 && this.v == 2) {
            A();
            if (this.w == 1) {
                r(motionEvent.getX());
            }
            if (this.w == 2) {
                C(motionEvent.getY());
            }
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.s
    public void c(boolean z) {
    }

    @Override // androidx.recyclerview.widget.RecyclerView.n
    public void i(Canvas canvas, RecyclerView recyclerView, RecyclerView.z zVar) {
        if (this.q != this.s.getWidth() || this.r != this.s.getHeight()) {
            this.q = this.s.getWidth();
            this.r = this.s.getHeight();
            y(0);
        } else if (this.A != 0) {
            if (this.t) {
                n(canvas);
            }
            if (this.u) {
                m(canvas);
            }
        }
    }

    public void j(RecyclerView recyclerView) {
        RecyclerView recyclerView2 = this.s;
        if (recyclerView2 == recyclerView) {
            return;
        }
        if (recyclerView2 != null) {
            l();
        }
        this.s = recyclerView;
        if (recyclerView != null) {
            z();
        }
    }

    void q(int i) {
        int i2 = this.A;
        if (i2 == 1) {
            this.z.cancel();
        } else if (i2 != 2) {
            return;
        }
        this.A = 3;
        ValueAnimator valueAnimator = this.z;
        valueAnimator.setFloatValues(((Float) valueAnimator.getAnimatedValue()).floatValue(), 0.0f);
        this.z.setDuration(i);
        this.z.start();
    }

    boolean t(float f, float f2) {
        if (f2 >= this.r - this.i) {
            int i = this.o;
            int i2 = this.n;
            if (f >= i - (i2 / 2) && f <= i + (i2 / 2)) {
                return true;
            }
        }
        return false;
    }

    boolean u(float f, float f2) {
        if (!s() ? f >= this.q - this.e : f <= this.e / 2) {
            int i = this.l;
            int i2 = this.k;
            if (f2 >= i - (i2 / 2) && f2 <= i + (i2 / 2)) {
                return true;
            }
        }
        return false;
    }

    void v() {
        this.s.invalidate();
    }

    void y(int i) {
        int i2;
        if (i == 2 && this.v != 2) {
            this.f1237c.setState(D);
            k();
        }
        if (i == 0) {
            v();
        } else {
            A();
        }
        if (this.v != 2 || i == 2) {
            i2 = i == 1 ? 1500 : 1500;
            this.v = i;
        }
        this.f1237c.setState(E);
        i2 = 1200;
        w(i2);
        this.v = i;
    }
}
