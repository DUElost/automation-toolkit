package com.jude.easyrecyclerview.swipe;

import a.f.l.r;
import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RadialGradient;
import android.graphics.Shader;
import android.graphics.drawable.ShapeDrawable;
import android.graphics.drawable.shapes.OvalShape;
import android.os.Build;
import android.view.animation.Animation;
import android.widget.ImageView;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class a extends ImageView {

    /* renamed from: b  reason: collision with root package name */
    private Animation.AnimationListener f2494b;

    /* renamed from: c  reason: collision with root package name */
    private int f2495c;

    /* renamed from: com.jude.easyrecyclerview.swipe.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private class C0101a extends OvalShape {

        /* renamed from: b  reason: collision with root package name */
        private RadialGradient f2496b;

        /* renamed from: c  reason: collision with root package name */
        private Paint f2497c = new Paint();

        /* renamed from: d  reason: collision with root package name */
        private int f2498d;

        public C0101a(int i, int i2) {
            a.this.f2495c = i;
            this.f2498d = i2;
            int i3 = this.f2498d;
            RadialGradient radialGradient = new RadialGradient(i3 / 2, i3 / 2, a.this.f2495c, new int[]{1023410176, 0}, (float[]) null, Shader.TileMode.CLAMP);
            this.f2496b = radialGradient;
            this.f2497c.setShader(radialGradient);
        }

        @Override // android.graphics.drawable.shapes.OvalShape, android.graphics.drawable.shapes.RectShape, android.graphics.drawable.shapes.Shape
        public void draw(Canvas canvas, Paint paint) {
            float width = a.this.getWidth() / 2;
            float height = a.this.getHeight() / 2;
            canvas.drawCircle(width, height, (this.f2498d / 2) + a.this.f2495c, this.f2497c);
            canvas.drawCircle(width, height, this.f2498d / 2, paint);
        }
    }

    public a(Context context, int i, float f) {
        super(context);
        ShapeDrawable shapeDrawable;
        float f2 = getContext().getResources().getDisplayMetrics().density;
        int i2 = (int) (f * f2 * 2.0f);
        int i3 = (int) (1.75f * f2);
        int i4 = (int) (0.0f * f2);
        this.f2495c = (int) (3.5f * f2);
        if (c()) {
            shapeDrawable = new ShapeDrawable(new OvalShape());
            r.V(this, f2 * 4.0f);
        } else {
            shapeDrawable = new ShapeDrawable(new C0101a(this.f2495c, i2));
            r.a0(this, 1, shapeDrawable.getPaint());
            shapeDrawable.getPaint().setShadowLayer(this.f2495c, i4, i3, 503316480);
            int i5 = this.f2495c;
            setPadding(i5, i5, i5, i5);
        }
        shapeDrawable.getPaint().setColor(i);
        setBackgroundDrawable(shapeDrawable);
    }

    private boolean c() {
        return Build.VERSION.SDK_INT >= 21;
    }

    public void d(Animation.AnimationListener animationListener) {
        this.f2494b = animationListener;
    }

    @Override // android.view.View
    public void onAnimationEnd() {
        super.onAnimationEnd();
        Animation.AnimationListener animationListener = this.f2494b;
        if (animationListener != null) {
            animationListener.onAnimationEnd(getAnimation());
        }
    }

    @Override // android.view.View
    public void onAnimationStart() {
        super.onAnimationStart();
        Animation.AnimationListener animationListener = this.f2494b;
        if (animationListener != null) {
            animationListener.onAnimationStart(getAnimation());
        }
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onMeasure(int i, int i2) {
        super.onMeasure(i, i2);
        if (c()) {
            return;
        }
        setMeasuredDimension(getMeasuredWidth() + (this.f2495c * 2), getMeasuredHeight() + (this.f2495c * 2));
    }

    @Override // android.view.View
    public void setBackgroundColor(int i) {
        if (getBackground() instanceof ShapeDrawable) {
            ((ShapeDrawable) getBackground()).getPaint().setColor(i);
        }
    }
}
