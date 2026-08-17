package com.google.android.material.floatingactionbutton;

import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.animation.TimeInterpolator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Matrix;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.GradientDrawable;
import android.graphics.drawable.LayerDrawable;
import android.os.Build;
import android.view.View;
import android.view.ViewTreeObserver;
import java.util.ArrayList;
import java.util.Iterator;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class a {
    static final TimeInterpolator B = b.d.a.a.k.a.f1468b;
    static final int[] C = {16842919, 16842910};
    static final int[] D = {16843623, 16842908, 16842910};
    static final int[] E = {16842908, 16842910};
    static final int[] F = {16843623, 16842910};
    static final int[] G = {16842910};
    static final int[] H = new int[0];
    private ViewTreeObserver.OnPreDrawListener A;

    /* renamed from: b  reason: collision with root package name */
    Animator f2332b;

    /* renamed from: c  reason: collision with root package name */
    b.d.a.a.k.h f2333c;

    /* renamed from: d  reason: collision with root package name */
    b.d.a.a.k.h f2334d;
    private b.d.a.a.k.h e;
    private b.d.a.a.k.h f;
    private final com.google.android.material.internal.e g;
    b.d.a.a.r.a h;
    private float i;
    Drawable j;
    Drawable k;
    com.google.android.material.internal.a l;
    Drawable m;
    float n;
    float o;
    float p;
    int q;
    private ArrayList<Animator.AnimatorListener> s;
    private ArrayList<Animator.AnimatorListener> t;
    final com.google.android.material.internal.h u;
    final b.d.a.a.r.b v;

    /* renamed from: a  reason: collision with root package name */
    int f2331a = 0;
    float r = 1.0f;
    private final Rect w = new Rect();
    private final RectF x = new RectF();
    private final RectF y = new RectF();
    private final Matrix z = new Matrix();

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: com.google.android.material.floatingactionbutton.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0097a extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        private boolean f2335a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ boolean f2336b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ g f2337c;

        C0097a(boolean z, g gVar) {
            this.f2336b = z;
            this.f2337c = gVar;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f2335a = true;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            a aVar = a.this;
            aVar.f2331a = 0;
            aVar.f2332b = null;
            if (this.f2335a) {
                return;
            }
            com.google.android.material.internal.h hVar = aVar.u;
            boolean z = this.f2336b;
            hVar.b(z ? 8 : 4, z);
            g gVar = this.f2337c;
            if (gVar != null) {
                gVar.b();
            }
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            a.this.u.b(0, this.f2336b);
            a aVar = a.this;
            aVar.f2331a = 1;
            aVar.f2332b = animator;
            this.f2335a = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ boolean f2339a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ g f2340b;

        b(boolean z, g gVar) {
            this.f2339a = z;
            this.f2340b = gVar;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            a aVar = a.this;
            aVar.f2331a = 0;
            aVar.f2332b = null;
            g gVar = this.f2340b;
            if (gVar != null) {
                gVar.a();
            }
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            a.this.u.b(0, this.f2339a);
            a aVar = a.this;
            aVar.f2331a = 2;
            aVar.f2332b = animator;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements ViewTreeObserver.OnPreDrawListener {
        c() {
        }

        @Override // android.view.ViewTreeObserver.OnPreDrawListener
        public boolean onPreDraw() {
            a.this.D();
            return true;
        }
    }

    /* loaded from: classes.dex */
    private class d extends i {
        d(a aVar) {
            super(aVar, null);
        }

        @Override // com.google.android.material.floatingactionbutton.a.i
        protected float a() {
            return 0.0f;
        }
    }

    /* loaded from: classes.dex */
    private class e extends i {
        e() {
            super(a.this, null);
        }

        @Override // com.google.android.material.floatingactionbutton.a.i
        protected float a() {
            a aVar = a.this;
            return aVar.n + aVar.o;
        }
    }

    /* loaded from: classes.dex */
    private class f extends i {
        f() {
            super(a.this, null);
        }

        @Override // com.google.android.material.floatingactionbutton.a.i
        protected float a() {
            a aVar = a.this;
            return aVar.n + aVar.p;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public interface g {
        void a();

        void b();
    }

    /* loaded from: classes.dex */
    private class h extends i {
        h() {
            super(a.this, null);
        }

        @Override // com.google.android.material.floatingactionbutton.a.i
        protected float a() {
            return a.this.n;
        }
    }

    /* loaded from: classes.dex */
    private abstract class i extends AnimatorListenerAdapter implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        private boolean f2343a;

        /* renamed from: b  reason: collision with root package name */
        private float f2344b;

        /* renamed from: c  reason: collision with root package name */
        private float f2345c;

        private i() {
        }

        /* synthetic */ i(a aVar, C0097a c0097a) {
            this();
        }

        protected abstract float a();

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            a.this.h.k(this.f2345c);
            this.f2343a = false;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            if (!this.f2343a) {
                this.f2344b = a.this.h.h();
                this.f2345c = a();
                this.f2343a = true;
            }
            b.d.a.a.r.a aVar = a.this.h;
            float f = this.f2344b;
            aVar.k(f + ((this.f2345c - f) * valueAnimator.getAnimatedFraction()));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public a(com.google.android.material.internal.h hVar, b.d.a.a.r.b bVar) {
        this.u = hVar;
        this.v = bVar;
        com.google.android.material.internal.e eVar = new com.google.android.material.internal.e();
        this.g = eVar;
        eVar.a(C, f(new f()));
        eVar.a(D, f(new e()));
        eVar.a(E, f(new e()));
        eVar.a(F, f(new e()));
        eVar.a(G, f(new h()));
        eVar.a(H, f(new d(this)));
        this.i = hVar.getRotation();
    }

    private boolean S() {
        return r.E(this.u) && !this.u.isInEditMode();
    }

    private void U() {
        com.google.android.material.internal.h hVar;
        int i2;
        if (Build.VERSION.SDK_INT == 19) {
            if (this.i % 90.0f != 0.0f) {
                i2 = 1;
                if (this.u.getLayerType() != 1) {
                    hVar = this.u;
                    hVar.setLayerType(i2, null);
                }
            } else if (this.u.getLayerType() != 0) {
                hVar = this.u;
                i2 = 0;
                hVar.setLayerType(i2, null);
            }
        }
        b.d.a.a.r.a aVar = this.h;
        if (aVar != null) {
            aVar.j(-this.i);
        }
        com.google.android.material.internal.a aVar2 = this.l;
        if (aVar2 != null) {
            aVar2.e(-this.i);
        }
    }

    private void c(float f2, Matrix matrix) {
        matrix.reset();
        Drawable drawable = this.u.getDrawable();
        if (drawable == null || this.q == 0) {
            return;
        }
        RectF rectF = this.x;
        RectF rectF2 = this.y;
        rectF.set(0.0f, 0.0f, drawable.getIntrinsicWidth(), drawable.getIntrinsicHeight());
        int i2 = this.q;
        rectF2.set(0.0f, 0.0f, i2, i2);
        matrix.setRectToRect(rectF, rectF2, Matrix.ScaleToFit.CENTER);
        int i3 = this.q;
        matrix.postScale(f2, f2, i3 / 2.0f, i3 / 2.0f);
    }

    private AnimatorSet d(b.d.a.a.k.h hVar, float f2, float f3, float f4) {
        ArrayList arrayList = new ArrayList();
        ObjectAnimator ofFloat = ObjectAnimator.ofFloat(this.u, View.ALPHA, f2);
        hVar.e("opacity").a(ofFloat);
        arrayList.add(ofFloat);
        ObjectAnimator ofFloat2 = ObjectAnimator.ofFloat(this.u, View.SCALE_X, f3);
        hVar.e("scale").a(ofFloat2);
        arrayList.add(ofFloat2);
        ObjectAnimator ofFloat3 = ObjectAnimator.ofFloat(this.u, View.SCALE_Y, f3);
        hVar.e("scale").a(ofFloat3);
        arrayList.add(ofFloat3);
        c(f4, this.z);
        ObjectAnimator ofObject = ObjectAnimator.ofObject(this.u, new b.d.a.a.k.f(), new b.d.a.a.k.g(), new Matrix(this.z));
        hVar.e("iconScale").a(ofObject);
        arrayList.add(ofObject);
        AnimatorSet animatorSet = new AnimatorSet();
        b.d.a.a.k.b.a(animatorSet, arrayList);
        return animatorSet;
    }

    private ValueAnimator f(i iVar) {
        ValueAnimator valueAnimator = new ValueAnimator();
        valueAnimator.setInterpolator(B);
        valueAnimator.setDuration(100L);
        valueAnimator.addListener(iVar);
        valueAnimator.addUpdateListener(iVar);
        valueAnimator.setFloatValues(0.0f, 1.0f);
        return valueAnimator;
    }

    private void h() {
        if (this.A == null) {
            this.A = new c();
        }
    }

    private b.d.a.a.k.h j() {
        if (this.f == null) {
            this.f = b.d.a.a.k.h.c(this.u.getContext(), b.d.a.a.a.design_fab_hide_motion_spec);
        }
        return this.f;
    }

    private b.d.a.a.k.h k() {
        if (this.e == null) {
            this.e = b.d.a.a.k.h.c(this.u.getContext(), b.d.a.a.a.design_fab_show_motion_spec);
        }
        return this.e;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void A(int[] iArr) {
        this.g.d(iArr);
    }

    void B(float f2, float f3, float f4) {
        b.d.a.a.r.a aVar = this.h;
        if (aVar != null) {
            aVar.l(f2, this.p + f2);
            W();
        }
    }

    void C(Rect rect) {
    }

    void D() {
        float rotation = this.u.getRotation();
        if (this.i != rotation) {
            this.i = rotation;
            U();
        }
    }

    public void E(Animator.AnimatorListener animatorListener) {
        ArrayList<Animator.AnimatorListener> arrayList = this.t;
        if (arrayList == null) {
            return;
        }
        arrayList.remove(animatorListener);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void F(Animator.AnimatorListener animatorListener) {
        ArrayList<Animator.AnimatorListener> arrayList = this.s;
        if (arrayList == null) {
            return;
        }
        arrayList.remove(animatorListener);
    }

    boolean G() {
        return true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void H(ColorStateList colorStateList, PorterDuff.Mode mode, ColorStateList colorStateList2, int i2) {
        Drawable[] drawableArr;
        Drawable q = androidx.core.graphics.drawable.a.q(g());
        this.j = q;
        androidx.core.graphics.drawable.a.o(q, colorStateList);
        if (mode != null) {
            androidx.core.graphics.drawable.a.p(this.j, mode);
        }
        Drawable q2 = androidx.core.graphics.drawable.a.q(g());
        this.k = q2;
        androidx.core.graphics.drawable.a.o(q2, b.d.a.a.q.a.a(colorStateList2));
        if (i2 > 0) {
            com.google.android.material.internal.a e2 = e(i2, colorStateList);
            this.l = e2;
            drawableArr = new Drawable[]{e2, this.j, this.k};
        } else {
            this.l = null;
            drawableArr = new Drawable[]{this.j, this.k};
        }
        this.m = new LayerDrawable(drawableArr);
        Context context = this.u.getContext();
        Drawable drawable = this.m;
        float b2 = this.v.b();
        float f2 = this.n;
        b.d.a.a.r.a aVar = new b.d.a.a.r.a(context, drawable, b2, f2, f2 + this.p);
        this.h = aVar;
        aVar.i(false);
        this.v.c(this.h);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void I(ColorStateList colorStateList) {
        Drawable drawable = this.j;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.o(drawable, colorStateList);
        }
        com.google.android.material.internal.a aVar = this.l;
        if (aVar != null) {
            aVar.b(colorStateList);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void J(PorterDuff.Mode mode) {
        Drawable drawable = this.j;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.p(drawable, mode);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void K(float f2) {
        if (this.n != f2) {
            this.n = f2;
            B(f2, this.o, this.p);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void L(b.d.a.a.k.h hVar) {
        this.f2334d = hVar;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void M(float f2) {
        if (this.o != f2) {
            this.o = f2;
            B(this.n, f2, this.p);
        }
    }

    final void N(float f2) {
        this.r = f2;
        Matrix matrix = this.z;
        c(f2, matrix);
        this.u.setImageMatrix(matrix);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void O(int i2) {
        if (this.q != i2) {
            this.q = i2;
            V();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void P(float f2) {
        if (this.p != f2) {
            this.p = f2;
            B(this.n, this.o, f2);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void Q(ColorStateList colorStateList) {
        Drawable drawable = this.k;
        if (drawable != null) {
            androidx.core.graphics.drawable.a.o(drawable, b.d.a.a.q.a.a(colorStateList));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void R(b.d.a.a.k.h hVar) {
        this.f2333c = hVar;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void T(g gVar, boolean z) {
        if (t()) {
            return;
        }
        Animator animator = this.f2332b;
        if (animator != null) {
            animator.cancel();
        }
        if (!S()) {
            this.u.b(0, z);
            this.u.setAlpha(1.0f);
            this.u.setScaleY(1.0f);
            this.u.setScaleX(1.0f);
            N(1.0f);
            if (gVar != null) {
                gVar.a();
                return;
            }
            return;
        }
        if (this.u.getVisibility() != 0) {
            this.u.setAlpha(0.0f);
            this.u.setScaleY(0.0f);
            this.u.setScaleX(0.0f);
            N(0.0f);
        }
        b.d.a.a.k.h hVar = this.f2333c;
        if (hVar == null) {
            hVar = k();
        }
        AnimatorSet d2 = d(hVar, 1.0f, 1.0f, 1.0f);
        d2.addListener(new b(z, gVar));
        ArrayList<Animator.AnimatorListener> arrayList = this.s;
        if (arrayList != null) {
            Iterator<Animator.AnimatorListener> it = arrayList.iterator();
            while (it.hasNext()) {
                d2.addListener(it.next());
            }
        }
        d2.start();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void V() {
        N(this.r);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void W() {
        Rect rect = this.w;
        o(rect);
        C(rect);
        this.v.a(rect.left, rect.top, rect.right, rect.bottom);
    }

    public void a(Animator.AnimatorListener animatorListener) {
        if (this.t == null) {
            this.t = new ArrayList<>();
        }
        this.t.add(animatorListener);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b(Animator.AnimatorListener animatorListener) {
        if (this.s == null) {
            this.s = new ArrayList<>();
        }
        this.s.add(animatorListener);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public com.google.android.material.internal.a e(int i2, ColorStateList colorStateList) {
        Context context = this.u.getContext();
        com.google.android.material.internal.a v = v();
        v.d(androidx.core.content.a.b(context, b.d.a.a.c.design_fab_stroke_top_outer_color), androidx.core.content.a.b(context, b.d.a.a.c.design_fab_stroke_top_inner_color), androidx.core.content.a.b(context, b.d.a.a.c.design_fab_stroke_end_inner_color), androidx.core.content.a.b(context, b.d.a.a.c.design_fab_stroke_end_outer_color));
        v.c(i2);
        v.b(colorStateList);
        return v;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public GradientDrawable g() {
        GradientDrawable w = w();
        w.setShape(1);
        w.setColor(-1);
        return w;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final Drawable i() {
        return this.m;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public float l() {
        return this.n;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final b.d.a.a.k.h m() {
        return this.f2334d;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public float n() {
        return this.o;
    }

    void o(Rect rect) {
        this.h.getPadding(rect);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public float p() {
        return this.p;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final b.d.a.a.k.h q() {
        return this.f2333c;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void r(g gVar, boolean z) {
        if (s()) {
            return;
        }
        Animator animator = this.f2332b;
        if (animator != null) {
            animator.cancel();
        }
        if (!S()) {
            this.u.b(z ? 8 : 4, z);
            if (gVar != null) {
                gVar.b();
                return;
            }
            return;
        }
        b.d.a.a.k.h hVar = this.f2334d;
        if (hVar == null) {
            hVar = j();
        }
        AnimatorSet d2 = d(hVar, 0.0f, 0.0f, 0.0f);
        d2.addListener(new C0097a(z, gVar));
        ArrayList<Animator.AnimatorListener> arrayList = this.t;
        if (arrayList != null) {
            Iterator<Animator.AnimatorListener> it = arrayList.iterator();
            while (it.hasNext()) {
                d2.addListener(it.next());
            }
        }
        d2.start();
    }

    boolean s() {
        return this.u.getVisibility() == 0 ? this.f2331a == 1 : this.f2331a != 2;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean t() {
        return this.u.getVisibility() != 0 ? this.f2331a == 2 : this.f2331a != 1;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void u() {
        this.g.c();
    }

    com.google.android.material.internal.a v() {
        return new com.google.android.material.internal.a();
    }

    GradientDrawable w() {
        return new GradientDrawable();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void x() {
        if (G()) {
            h();
            this.u.getViewTreeObserver().addOnPreDrawListener(this.A);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void y() {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void z() {
        if (this.A != null) {
            this.u.getViewTreeObserver().removeOnPreDrawListener(this.A);
            this.A = null;
        }
    }
}
