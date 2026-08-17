package com.jude.easyrecyclerview.swipe;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.Canvas;
import android.graphics.ColorFilter;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Animatable;
import android.graphics.drawable.Drawable;
import android.view.View;
import android.view.animation.Animation;
import android.view.animation.Interpolator;
import android.view.animation.LinearInterpolator;
import android.view.animation.Transformation;
import java.util.ArrayList;
import jxl.SheetSettings;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class b extends Drawable implements Animatable {
    private static final Interpolator n = new LinearInterpolator();
    private static final Interpolator o = new a.i.a.a.b();

    /* renamed from: b  reason: collision with root package name */
    private final int[] f2499b;

    /* renamed from: c  reason: collision with root package name */
    private final ArrayList<Animation> f2500c = new ArrayList<>();

    /* renamed from: d  reason: collision with root package name */
    private final d f2501d;
    private float e;
    private Resources f;
    private View g;
    private Animation h;
    private float i;
    private double j;
    private double k;
    boolean l;
    private final Drawable.Callback m;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends Animation {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ d f2502b;

        a(d dVar) {
            this.f2502b = dVar;
        }

        @Override // android.view.animation.Animation
        public void applyTransformation(float f, Transformation transformation) {
            b bVar = b.this;
            if (bVar.l) {
                bVar.g(f, this.f2502b);
                return;
            }
            float i = bVar.i(this.f2502b);
            float j = this.f2502b.j();
            float l = this.f2502b.l();
            float k = this.f2502b.k();
            b.this.s(f, this.f2502b);
            if (f <= 0.5f) {
                Interpolator interpolator = b.o;
                this.f2502b.D(l + ((0.8f - i) * interpolator.getInterpolation(f / 0.5f)));
            }
            if (f > 0.5f) {
                Interpolator interpolator2 = b.o;
                this.f2502b.z(j + ((0.8f - i) * interpolator2.getInterpolation((f - 0.5f) / 0.5f)));
            }
            this.f2502b.B(k + (0.25f * f));
            b.this.n((f * 216.0f) + ((b.this.i / 5.0f) * 1080.0f));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.jude.easyrecyclerview.swipe.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class animation.Animation$AnimationListenerC0102b implements Animation.AnimationListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ d f2504a;

        animation.Animation$AnimationListenerC0102b(d dVar) {
            this.f2504a = dVar;
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationEnd(Animation animation) {
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationRepeat(Animation animation) {
            this.f2504a.F();
            this.f2504a.n();
            d dVar = this.f2504a;
            dVar.D(dVar.e());
            b bVar = b.this;
            if (!bVar.l) {
                bVar.i = (bVar.i + 1.0f) % 5.0f;
                return;
            }
            bVar.l = false;
            animation.setDuration(1332L);
            this.f2504a.C(false);
        }

        @Override // android.view.animation.Animation.AnimationListener
        public void onAnimationStart(Animation animation) {
            b.this.i = 0.0f;
        }
    }

    /* loaded from: classes.dex */
    class c implements Drawable.Callback {
        c() {
        }

        @Override // android.graphics.drawable.Drawable.Callback
        public void invalidateDrawable(Drawable drawable) {
            b.this.invalidateSelf();
        }

        @Override // android.graphics.drawable.Drawable.Callback
        public void scheduleDrawable(Drawable drawable, Runnable runnable, long j) {
            b.this.scheduleSelf(runnable, j);
        }

        @Override // android.graphics.drawable.Drawable.Callback
        public void unscheduleDrawable(Drawable drawable, Runnable runnable) {
            b.this.unscheduleSelf(runnable);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class d {

        /* renamed from: a  reason: collision with root package name */
        private final RectF f2507a = new RectF();

        /* renamed from: b  reason: collision with root package name */
        private final Paint f2508b;

        /* renamed from: c  reason: collision with root package name */
        private final Paint f2509c;

        /* renamed from: d  reason: collision with root package name */
        private final Drawable.Callback f2510d;
        private float e;
        private float f;
        private float g;
        private float h;
        private float i;
        private int[] j;
        private int k;
        private float l;
        private float m;
        private float n;
        private boolean o;
        private Path p;
        private float q;
        private double r;
        private int s;
        private int t;
        private int u;
        private final Paint v;
        private int w;
        private int x;

        public d(Drawable.Callback callback) {
            Paint paint = new Paint();
            this.f2508b = paint;
            Paint paint2 = new Paint();
            this.f2509c = paint2;
            this.e = 0.0f;
            this.f = 0.0f;
            this.g = 0.0f;
            this.h = 5.0f;
            this.i = 2.5f;
            this.v = new Paint(1);
            this.f2510d = callback;
            paint.setStrokeCap(Paint.Cap.SQUARE);
            paint.setAntiAlias(true);
            paint.setStyle(Paint.Style.STROKE);
            paint2.setStyle(Paint.Style.FILL);
            paint2.setAntiAlias(true);
        }

        private void b(Canvas canvas, float f, float f2, Rect rect) {
            if (this.o) {
                Path path = this.p;
                if (path == null) {
                    Path path2 = new Path();
                    this.p = path2;
                    path2.setFillType(Path.FillType.EVEN_ODD);
                } else {
                    path.reset();
                }
                float f3 = (((int) this.i) / 2) * this.q;
                float sin = (float) ((this.r * Math.sin(0.0d)) + rect.exactCenterY());
                this.p.moveTo(0.0f, 0.0f);
                this.p.lineTo(this.s * this.q, 0.0f);
                Path path3 = this.p;
                float f4 = this.q;
                path3.lineTo((this.s * f4) / 2.0f, this.t * f4);
                this.p.offset(((float) ((this.r * Math.cos(0.0d)) + rect.exactCenterX())) - f3, sin);
                this.p.close();
                this.f2509c.setColor(this.x);
                canvas.rotate((f + f2) - 5.0f, rect.exactCenterX(), rect.exactCenterY());
                canvas.drawPath(this.p, this.f2509c);
            }
        }

        private int g() {
            return (this.k + 1) % this.j.length;
        }

        private void o() {
            this.f2510d.invalidateDrawable(null);
        }

        public void A(int i, int i2) {
            float min = Math.min(i, i2);
            double d2 = this.r;
            this.i = (float) ((d2 <= 0.0d || min < 0.0f) ? Math.ceil(this.h / 2.0f) : (min / 2.0f) - d2);
        }

        public void B(float f) {
            this.g = f;
            o();
        }

        public void C(boolean z) {
            if (this.o != z) {
                this.o = z;
                o();
            }
        }

        public void D(float f) {
            this.e = f;
            o();
        }

        public void E(float f) {
            this.h = f;
            this.f2508b.setStrokeWidth(f);
            o();
        }

        public void F() {
            this.l = this.e;
            this.m = this.f;
            this.n = this.g;
        }

        public void a(Canvas canvas, Rect rect) {
            RectF rectF = this.f2507a;
            rectF.set(rect);
            float f = this.i;
            rectF.inset(f, f);
            float f2 = this.e;
            float f3 = this.g;
            float f4 = (f2 + f3) * 360.0f;
            float f5 = ((this.f + f3) * 360.0f) - f4;
            this.f2508b.setColor(this.x);
            canvas.drawArc(rectF, f4, f5, false, this.f2508b);
            b(canvas, f4, f5, rect);
            if (this.u < 255) {
                this.v.setColor(this.w);
                this.v.setAlpha(SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT - this.u);
                canvas.drawCircle(rect.exactCenterX(), rect.exactCenterY(), rect.width() / 2, this.v);
            }
        }

        public int c() {
            return this.u;
        }

        public double d() {
            return this.r;
        }

        public float e() {
            return this.f;
        }

        public int f() {
            return this.j[g()];
        }

        public float h() {
            return this.e;
        }

        public int i() {
            return this.j[this.k];
        }

        public float j() {
            return this.m;
        }

        public float k() {
            return this.n;
        }

        public float l() {
            return this.l;
        }

        public float m() {
            return this.h;
        }

        public void n() {
            x(g());
        }

        public void p() {
            this.l = 0.0f;
            this.m = 0.0f;
            this.n = 0.0f;
            D(0.0f);
            z(0.0f);
            B(0.0f);
        }

        public void q(int i) {
            this.u = i;
        }

        public void r(float f, float f2) {
            this.s = (int) f;
            this.t = (int) f2;
        }

        public void s(float f) {
            if (f != this.q) {
                this.q = f;
                o();
            }
        }

        public void t(int i) {
            this.w = i;
        }

        public void u(double d2) {
            this.r = d2;
        }

        public void v(int i) {
            this.x = i;
        }

        public void w(ColorFilter colorFilter) {
            this.f2508b.setColorFilter(colorFilter);
            o();
        }

        public void x(int i) {
            this.k = i;
            this.x = this.j[i];
        }

        public void y(int[] iArr) {
            this.j = iArr;
            x(0);
        }

        public void z(float f) {
            this.f = f;
            o();
        }
    }

    public b(Context context, View view) {
        int[] iArr = {-16777216};
        this.f2499b = iArr;
        c cVar = new c();
        this.m = cVar;
        this.g = view;
        this.f = context.getResources();
        d dVar = new d(cVar);
        this.f2501d = dVar;
        dVar.y(iArr);
        t(1);
        q();
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void g(float f, d dVar) {
        s(f, dVar);
        dVar.D(dVar.l() + (((dVar.j() - i(dVar)) - dVar.l()) * f));
        dVar.z(dVar.j());
        dVar.B(dVar.k() + ((((float) (Math.floor(dVar.k() / 0.8f) + 1.0d)) - dVar.k()) * f));
    }

    private int h(float f, int i, int i2) {
        int intValue = Integer.valueOf(i).intValue();
        int i3 = (intValue >> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
        int i4 = (intValue >> 16) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
        int i5 = (intValue >> 8) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
        int i6 = intValue & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT;
        int intValue2 = Integer.valueOf(i2).intValue();
        return ((i3 + ((int) ((((intValue2 >> 24) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) - i3) * f))) << 24) | ((i4 + ((int) ((((intValue2 >> 16) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) - i4) * f))) << 16) | ((i5 + ((int) ((((intValue2 >> 8) & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) - i5) * f))) << 8) | (i6 + ((int) (f * ((intValue2 & SheetSettings.DEFAULT_DEFAULT_ROW_HEIGHT) - i6))));
    }

    /* JADX INFO: Access modifiers changed from: private */
    public float i(d dVar) {
        return (float) Math.toRadians(dVar.m() / (dVar.d() * 6.283185307179586d));
    }

    private void o(double d2, double d3, double d4, double d5, float f, float f2) {
        d dVar = this.f2501d;
        float f3 = this.f.getDisplayMetrics().density;
        double d6 = f3;
        this.j = d2 * d6;
        this.k = d3 * d6;
        dVar.E(((float) d5) * f3);
        dVar.u(d4 * d6);
        dVar.x(0);
        dVar.r(f * f3, f2 * f3);
        dVar.A((int) this.j, (int) this.k);
    }

    private void q() {
        d dVar = this.f2501d;
        a aVar = new a(dVar);
        aVar.setRepeatCount(-1);
        aVar.setRepeatMode(1);
        aVar.setInterpolator(n);
        aVar.setAnimationListener(new animation.Animation$AnimationListenerC0102b(dVar));
        this.h = aVar;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void s(float f, d dVar) {
        if (f > 0.75f) {
            dVar.v(h((f - 0.75f) / 0.25f, dVar.i(), dVar.f()));
        }
    }

    @Override // android.graphics.drawable.Drawable
    public void draw(Canvas canvas) {
        Rect bounds = getBounds();
        int save = canvas.save();
        canvas.rotate(this.e, bounds.exactCenterX(), bounds.exactCenterY());
        this.f2501d.a(canvas, bounds);
        canvas.restoreToCount(save);
    }

    @Override // android.graphics.drawable.Drawable
    public int getAlpha() {
        return this.f2501d.c();
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicHeight() {
        return (int) this.k;
    }

    @Override // android.graphics.drawable.Drawable
    public int getIntrinsicWidth() {
        return (int) this.j;
    }

    @Override // android.graphics.drawable.Drawable
    public int getOpacity() {
        return -3;
    }

    @Override // android.graphics.drawable.Animatable
    public boolean isRunning() {
        ArrayList<Animation> arrayList = this.f2500c;
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            Animation animation = arrayList.get(i);
            if (animation.hasStarted() && !animation.hasEnded()) {
                return true;
            }
        }
        return false;
    }

    public void j(float f) {
        this.f2501d.s(f);
    }

    public void k(int i) {
        this.f2501d.t(i);
    }

    public void l(int... iArr) {
        this.f2501d.y(iArr);
        this.f2501d.x(0);
    }

    public void m(float f) {
        this.f2501d.B(f);
    }

    void n(float f) {
        this.e = f;
        invalidateSelf();
    }

    public void p(float f, float f2) {
        this.f2501d.D(f);
        this.f2501d.z(f2);
    }

    public void r(boolean z) {
        this.f2501d.C(z);
    }

    @Override // android.graphics.drawable.Drawable
    public void setAlpha(int i) {
        this.f2501d.q(i);
    }

    @Override // android.graphics.drawable.Drawable
    public void setColorFilter(ColorFilter colorFilter) {
        this.f2501d.w(colorFilter);
    }

    @Override // android.graphics.drawable.Animatable
    public void start() {
        Animation animation;
        long j;
        this.h.reset();
        this.f2501d.F();
        if (this.f2501d.e() != this.f2501d.h()) {
            this.l = true;
            animation = this.h;
            j = 666;
        } else {
            this.f2501d.x(0);
            this.f2501d.p();
            animation = this.h;
            j = 1332;
        }
        animation.setDuration(j);
        this.g.startAnimation(this.h);
    }

    @Override // android.graphics.drawable.Animatable
    public void stop() {
        this.g.clearAnimation();
        n(0.0f);
        this.f2501d.C(false);
        this.f2501d.x(0);
        this.f2501d.p();
    }

    public void t(int i) {
        if (i == 0) {
            o(56.0d, 56.0d, 12.5d, 3.0d, 12.0f, 6.0f);
        } else {
            o(40.0d, 40.0d, 8.75d, 2.5d, 10.0f, 5.0f);
        }
    }
}
