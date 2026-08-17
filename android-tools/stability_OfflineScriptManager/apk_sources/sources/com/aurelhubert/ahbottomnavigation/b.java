package com.aurelhubert.ahbottomnavigation;

import android.animation.ArgbEvaluator;
import android.animation.ValueAnimator;
import android.content.Context;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
/* loaded from: classes.dex */
public class b {

    /* loaded from: classes.dex */
    static class a implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2242a;

        a(View view) {
            this.f2242a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            float floatValue = ((Float) valueAnimator.getAnimatedValue()).floatValue();
            if (this.f2242a.getLayoutParams() instanceof ViewGroup.MarginLayoutParams) {
                ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) this.f2242a.getLayoutParams();
                marginLayoutParams.setMargins(marginLayoutParams.leftMargin, (int) floatValue, marginLayoutParams.rightMargin, marginLayoutParams.bottomMargin);
                this.f2242a.requestLayout();
            }
        }
    }

    /* renamed from: com.aurelhubert.ahbottomnavigation.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    static class C0094b implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2243a;

        C0094b(View view) {
            this.f2243a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            float floatValue = ((Float) valueAnimator.getAnimatedValue()).floatValue();
            if (this.f2243a.getLayoutParams() instanceof ViewGroup.MarginLayoutParams) {
                ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) this.f2243a.getLayoutParams();
                marginLayoutParams.setMargins((int) floatValue, marginLayoutParams.topMargin, marginLayoutParams.rightMargin, marginLayoutParams.bottomMargin);
                this.f2243a.requestLayout();
            }
        }
    }

    /* loaded from: classes.dex */
    static class c implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ TextView f2244a;

        c(TextView textView) {
            this.f2244a = textView;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f2244a.setTextSize(0, ((Float) valueAnimator.getAnimatedValue()).floatValue());
        }
    }

    /* loaded from: classes.dex */
    static class d implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2245a;

        d(View view) {
            this.f2245a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f2245a.setAlpha(((Float) valueAnimator.getAnimatedValue()).floatValue());
        }
    }

    /* loaded from: classes.dex */
    static class e implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ TextView f2246a;

        e(TextView textView) {
            this.f2246a = textView;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f2246a.setTextColor(((Integer) valueAnimator.getAnimatedValue()).intValue());
        }
    }

    /* loaded from: classes.dex */
    static class f implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2247a;

        f(View view) {
            this.f2247a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f2247a.setBackgroundColor(((Integer) valueAnimator.getAnimatedValue()).intValue());
        }
    }

    /* loaded from: classes.dex */
    static class g implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ ImageView f2248a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Drawable f2249b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ boolean f2250c;

        g(ImageView imageView, Drawable drawable, boolean z) {
            this.f2248a = imageView;
            this.f2249b = drawable;
            this.f2250c = z;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            this.f2248a.setImageDrawable(b.a(this.f2249b, ((Integer) valueAnimator.getAnimatedValue()).intValue(), this.f2250c));
            this.f2248a.requestLayout();
        }
    }

    /* loaded from: classes.dex */
    static class h implements ValueAnimator.AnimatorUpdateListener {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f2251a;

        h(View view) {
            this.f2251a = view;
        }

        @Override // android.animation.ValueAnimator.AnimatorUpdateListener
        public void onAnimationUpdate(ValueAnimator valueAnimator) {
            ViewGroup.LayoutParams layoutParams = this.f2251a.getLayoutParams();
            layoutParams.width = Math.round(((Float) valueAnimator.getAnimatedValue()).floatValue());
            this.f2251a.setLayoutParams(layoutParams);
        }
    }

    public static Drawable a(Drawable drawable, int i, boolean z) {
        if (!z) {
            Drawable mutate = androidx.core.graphics.drawable.a.q(drawable).mutate();
            androidx.core.graphics.drawable.a.n(mutate, i);
            return mutate;
        }
        drawable.clearColorFilter();
        drawable.setColorFilter(i, PorterDuff.Mode.SRC_IN);
        drawable.invalidateSelf();
        return drawable;
    }

    public static void b(View view, float f2, float f3) {
        ValueAnimator ofFloat = ValueAnimator.ofFloat(f2, f3);
        ofFloat.setDuration(150L);
        ofFloat.addUpdateListener(new d(view));
        ofFloat.start();
    }

    public static void c(Context context, Drawable drawable, ImageView imageView, int i, int i2, boolean z) {
        ValueAnimator ofObject = ValueAnimator.ofObject(new ArgbEvaluator(), Integer.valueOf(i), Integer.valueOf(i2));
        ofObject.setDuration(150L);
        ofObject.addUpdateListener(new g(imageView, drawable, z));
        ofObject.start();
    }

    public static void d(View view, int i, int i2) {
        ValueAnimator ofFloat = ValueAnimator.ofFloat(i, i2);
        ofFloat.setDuration(150L);
        ofFloat.addUpdateListener(new C0094b(view));
        ofFloat.start();
    }

    public static void e(TextView textView, int i, int i2) {
        ValueAnimator ofObject = ValueAnimator.ofObject(new ArgbEvaluator(), Integer.valueOf(i), Integer.valueOf(i2));
        ofObject.setDuration(150L);
        ofObject.addUpdateListener(new e(textView));
        ofObject.start();
    }

    public static void f(TextView textView, float f2, float f3) {
        ValueAnimator ofFloat = ValueAnimator.ofFloat(f2, f3);
        ofFloat.setDuration(150L);
        ofFloat.addUpdateListener(new c(textView));
        ofFloat.start();
    }

    public static void g(View view, int i, int i2) {
        ValueAnimator ofFloat = ValueAnimator.ofFloat(i, i2);
        ofFloat.setDuration(150L);
        ofFloat.addUpdateListener(new a(view));
        ofFloat.start();
    }

    public static void h(View view, int i, int i2) {
        ValueAnimator ofObject = ValueAnimator.ofObject(new ArgbEvaluator(), Integer.valueOf(i), Integer.valueOf(i2));
        ofObject.setDuration(150L);
        ofObject.addUpdateListener(new f(view));
        ofObject.start();
    }

    public static void i(View view, float f2, float f3) {
        ValueAnimator ofFloat = ValueAnimator.ofFloat(f2, f3);
        ofFloat.setDuration(150L);
        ofFloat.addUpdateListener(new h(view));
        ofFloat.start();
    }
}
