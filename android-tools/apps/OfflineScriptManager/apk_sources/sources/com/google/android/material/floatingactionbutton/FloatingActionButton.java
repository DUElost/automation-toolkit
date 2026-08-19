package com.google.android.material.floatingactionbutton;

import a.f.l.q;
import a.f.l.r;
import android.animation.Animator;
import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.PorterDuff;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.Log;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import androidx.appcompat.widget.l;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.core.widget.k;
import b.d.a.a.d;
import b.d.a.a.i;
import b.d.a.a.j;
import com.google.android.material.appbar.AppBarLayout;
import com.google.android.material.bottomsheet.BottomSheetBehavior;
import com.google.android.material.floatingactionbutton.a;
import com.google.android.material.internal.f;
import com.google.android.material.internal.g;
import com.google.android.material.internal.h;
import com.google.android.material.stateful.ExtendableSavedState;
import java.util.List;
@CoordinatorLayout.d(Behavior.class)
/* loaded from: classes.dex */
public class FloatingActionButton extends h implements q, k, b.d.a.a.n.a {

    /* renamed from: c  reason: collision with root package name */
    private ColorStateList f2323c;

    /* renamed from: d  reason: collision with root package name */
    private PorterDuff.Mode f2324d;
    private ColorStateList e;
    private PorterDuff.Mode f;
    private int g;
    private ColorStateList h;
    private int i;
    private int j;
    private int k;
    private int l;
    boolean m;
    final Rect n;
    private final Rect o;
    private final l p;
    private final b.d.a.a.n.b q;
    private com.google.android.material.floatingactionbutton.a r;

    /* loaded from: classes.dex */
    protected static class BaseBehavior<T extends FloatingActionButton> extends CoordinatorLayout.c<T> {

        /* renamed from: a  reason: collision with root package name */
        private Rect f2325a;

        /* renamed from: b  reason: collision with root package name */
        private b f2326b;

        /* renamed from: c  reason: collision with root package name */
        private boolean f2327c;

        public BaseBehavior() {
            this.f2327c = true;
        }

        public BaseBehavior(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, j.FloatingActionButton_Behavior_Layout);
            this.f2327c = obtainStyledAttributes.getBoolean(j.FloatingActionButton_Behavior_Layout_behavior_autoHide, true);
            obtainStyledAttributes.recycle();
        }

        private static boolean E(View view) {
            ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
            if (layoutParams instanceof CoordinatorLayout.f) {
                return ((CoordinatorLayout.f) layoutParams).f() instanceof BottomSheetBehavior;
            }
            return false;
        }

        private void F(CoordinatorLayout coordinatorLayout, FloatingActionButton floatingActionButton) {
            Rect rect = floatingActionButton.n;
            if (rect == null || rect.centerX() <= 0 || rect.centerY() <= 0) {
                return;
            }
            CoordinatorLayout.f fVar = (CoordinatorLayout.f) floatingActionButton.getLayoutParams();
            int i = 0;
            int i2 = floatingActionButton.getRight() >= coordinatorLayout.getWidth() - ((ViewGroup.MarginLayoutParams) fVar).rightMargin ? rect.right : floatingActionButton.getLeft() <= ((ViewGroup.MarginLayoutParams) fVar).leftMargin ? -rect.left : 0;
            if (floatingActionButton.getBottom() >= coordinatorLayout.getHeight() - ((ViewGroup.MarginLayoutParams) fVar).bottomMargin) {
                i = rect.bottom;
            } else if (floatingActionButton.getTop() <= ((ViewGroup.MarginLayoutParams) fVar).topMargin) {
                i = -rect.top;
            }
            if (i != 0) {
                r.I(floatingActionButton, i);
            }
            if (i2 != 0) {
                r.H(floatingActionButton, i2);
            }
        }

        private boolean I(View view, FloatingActionButton floatingActionButton) {
            return this.f2327c && ((CoordinatorLayout.f) floatingActionButton.getLayoutParams()).e() == view.getId() && floatingActionButton.getUserSetVisibility() == 0;
        }

        private boolean J(CoordinatorLayout coordinatorLayout, AppBarLayout appBarLayout, FloatingActionButton floatingActionButton) {
            if (I(appBarLayout, floatingActionButton)) {
                if (this.f2325a == null) {
                    this.f2325a = new Rect();
                }
                Rect rect = this.f2325a;
                com.google.android.material.internal.c.a(coordinatorLayout, appBarLayout, rect);
                if (rect.bottom <= appBarLayout.getMinimumHeightForVisibleOverlappingContent()) {
                    floatingActionButton.m(this.f2326b, false);
                    return true;
                }
                floatingActionButton.v(this.f2326b, false);
                return true;
            }
            return false;
        }

        private boolean K(View view, FloatingActionButton floatingActionButton) {
            if (I(view, floatingActionButton)) {
                if (view.getTop() < (floatingActionButton.getHeight() / 2) + ((ViewGroup.MarginLayoutParams) ((CoordinatorLayout.f) floatingActionButton.getLayoutParams())).topMargin) {
                    floatingActionButton.m(this.f2326b, false);
                    return true;
                }
                floatingActionButton.v(this.f2326b, false);
                return true;
            }
            return false;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: D */
        public boolean b(CoordinatorLayout coordinatorLayout, FloatingActionButton floatingActionButton, Rect rect) {
            Rect rect2 = floatingActionButton.n;
            rect.set(floatingActionButton.getLeft() + rect2.left, floatingActionButton.getTop() + rect2.top, floatingActionButton.getRight() - rect2.right, floatingActionButton.getBottom() - rect2.bottom);
            return true;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: G */
        public boolean h(CoordinatorLayout coordinatorLayout, FloatingActionButton floatingActionButton, View view) {
            if (view instanceof AppBarLayout) {
                J(coordinatorLayout, (AppBarLayout) view, floatingActionButton);
                return false;
            } else if (E(view)) {
                K(view, floatingActionButton);
                return false;
            } else {
                return false;
            }
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: H */
        public boolean l(CoordinatorLayout coordinatorLayout, FloatingActionButton floatingActionButton, int i) {
            List<View> q = coordinatorLayout.q(floatingActionButton);
            int size = q.size();
            for (int i2 = 0; i2 < size; i2++) {
                View view = q.get(i2);
                if (!(view instanceof AppBarLayout)) {
                    if (E(view) && K(view, floatingActionButton)) {
                        break;
                    }
                } else if (J(coordinatorLayout, (AppBarLayout) view, floatingActionButton)) {
                    break;
                }
            }
            coordinatorLayout.H(floatingActionButton, i);
            F(coordinatorLayout, floatingActionButton);
            return true;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        public void g(CoordinatorLayout.f fVar) {
            if (fVar.h == 0) {
                fVar.h = 80;
            }
        }
    }

    /* loaded from: classes.dex */
    public static class Behavior extends BaseBehavior<FloatingActionButton> {
        public Behavior() {
        }

        public Behavior(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements a.g {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ b f2328a;

        a(b bVar) {
        }

        @Override // com.google.android.material.floatingactionbutton.a.g
        public void a() {
            this.f2328a.b(FloatingActionButton.this);
        }

        @Override // com.google.android.material.floatingactionbutton.a.g
        public void b() {
            this.f2328a.a(FloatingActionButton.this);
        }
    }

    /* loaded from: classes.dex */
    public static abstract class b {
        public abstract void a(FloatingActionButton floatingActionButton);

        public abstract void b(FloatingActionButton floatingActionButton);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class c implements b.d.a.a.r.b {
        c() {
        }

        @Override // b.d.a.a.r.b
        public void a(int i, int i2, int i3, int i4) {
            FloatingActionButton.this.n.set(i, i2, i3, i4);
            FloatingActionButton floatingActionButton = FloatingActionButton.this;
            floatingActionButton.setPadding(i + floatingActionButton.k, i2 + FloatingActionButton.this.k, i3 + FloatingActionButton.this.k, i4 + FloatingActionButton.this.k);
        }

        @Override // b.d.a.a.r.b
        public float b() {
            return FloatingActionButton.this.getSizeDimension() / 2.0f;
        }

        @Override // b.d.a.a.r.b
        public void c(Drawable drawable) {
            FloatingActionButton.super.setBackgroundDrawable(drawable);
        }

        @Override // b.d.a.a.r.b
        public boolean d() {
            return FloatingActionButton.this.m;
        }
    }

    public FloatingActionButton(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, b.d.a.a.b.floatingActionButtonStyle);
    }

    public FloatingActionButton(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        this.n = new Rect();
        this.o = new Rect();
        TypedArray h = f.h(context, attributeSet, j.FloatingActionButton, i, i.Widget_Design_FloatingActionButton, new int[0]);
        this.f2323c = b.d.a.a.p.a.a(context, h, j.FloatingActionButton_backgroundTint);
        this.f2324d = g.a(h.getInt(j.FloatingActionButton_backgroundTintMode, -1), null);
        this.h = b.d.a.a.p.a.a(context, h, j.FloatingActionButton_rippleColor);
        this.i = h.getInt(j.FloatingActionButton_fabSize, -1);
        this.j = h.getDimensionPixelSize(j.FloatingActionButton_fabCustomSize, 0);
        this.g = h.getDimensionPixelSize(j.FloatingActionButton_borderWidth, 0);
        float dimension = h.getDimension(j.FloatingActionButton_elevation, 0.0f);
        float dimension2 = h.getDimension(j.FloatingActionButton_hoveredFocusedTranslationZ, 0.0f);
        float dimension3 = h.getDimension(j.FloatingActionButton_pressedTranslationZ, 0.0f);
        this.m = h.getBoolean(j.FloatingActionButton_useCompatPadding, false);
        this.l = h.getDimensionPixelSize(j.FloatingActionButton_maxImageSize, 0);
        b.d.a.a.k.h b2 = b.d.a.a.k.h.b(context, h, j.FloatingActionButton_showMotionSpec);
        b.d.a.a.k.h b3 = b.d.a.a.k.h.b(context, h, j.FloatingActionButton_hideMotionSpec);
        h.recycle();
        l lVar = new l(this);
        this.p = lVar;
        lVar.f(attributeSet, i);
        this.q = new b.d.a.a.n.b(this);
        getImpl().H(this.f2323c, this.f2324d, this.h, this.g);
        getImpl().K(dimension);
        getImpl().M(dimension2);
        getImpl().P(dimension3);
        getImpl().O(this.l);
        getImpl().R(b2);
        getImpl().L(b3);
        setScaleType(ImageView.ScaleType.MATRIX);
    }

    private com.google.android.material.floatingactionbutton.a g() {
        return Build.VERSION.SDK_INT >= 21 ? new com.google.android.material.floatingactionbutton.b(this, new c()) : new com.google.android.material.floatingactionbutton.a(this, new c());
    }

    private com.google.android.material.floatingactionbutton.a getImpl() {
        if (this.r == null) {
            this.r = g();
        }
        return this.r;
    }

    private int j(int i) {
        int i2 = this.j;
        if (i2 != 0) {
            return i2;
        }
        Resources resources = getResources();
        if (i != -1) {
            return resources.getDimensionPixelSize(i != 1 ? d.design_fab_size_normal : d.design_fab_size_mini);
        }
        return Math.max(resources.getConfiguration().screenWidthDp, resources.getConfiguration().screenHeightDp) < 470 ? j(1) : j(0);
    }

    private void o(Rect rect) {
        int i = rect.left;
        Rect rect2 = this.n;
        rect.left = i + rect2.left;
        rect.top += rect2.top;
        rect.right -= rect2.right;
        rect.bottom -= rect2.bottom;
    }

    private void p() {
        Drawable drawable = getDrawable();
        if (drawable == null) {
            return;
        }
        ColorStateList colorStateList = this.e;
        if (colorStateList == null) {
            androidx.core.graphics.drawable.a.c(drawable);
            return;
        }
        int colorForState = colorStateList.getColorForState(getDrawableState(), 0);
        PorterDuff.Mode mode = this.f;
        if (mode == null) {
            mode = PorterDuff.Mode.SRC_IN;
        }
        drawable.mutate().setColorFilter(androidx.appcompat.widget.h.r(colorForState, mode));
    }

    private static int s(int i, int i2) {
        int mode = View.MeasureSpec.getMode(i2);
        int size = View.MeasureSpec.getSize(i2);
        if (mode != Integer.MIN_VALUE) {
            if (mode != 0) {
                if (mode == 1073741824) {
                    return size;
                }
                throw new IllegalArgumentException();
            }
            return i;
        }
        return Math.min(i, size);
    }

    private a.g w(b bVar) {
        if (bVar == null) {
            return null;
        }
        return new a(bVar);
    }

    @Override // b.d.a.a.n.a
    public boolean a() {
        return this.q.c();
    }

    @Override // android.widget.ImageView, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        getImpl().A(getDrawableState());
    }

    public void e(Animator.AnimatorListener animatorListener) {
        getImpl().a(animatorListener);
    }

    public void f(Animator.AnimatorListener animatorListener) {
        getImpl().b(animatorListener);
    }

    @Override // android.view.View
    public ColorStateList getBackgroundTintList() {
        return this.f2323c;
    }

    @Override // android.view.View
    public PorterDuff.Mode getBackgroundTintMode() {
        return this.f2324d;
    }

    public float getCompatElevation() {
        return getImpl().l();
    }

    public float getCompatHoveredFocusedTranslationZ() {
        return getImpl().n();
    }

    public float getCompatPressedTranslationZ() {
        return getImpl().p();
    }

    public Drawable getContentBackground() {
        return getImpl().i();
    }

    public int getCustomSize() {
        return this.j;
    }

    public int getExpandedComponentIdHint() {
        return this.q.b();
    }

    public b.d.a.a.k.h getHideMotionSpec() {
        return getImpl().m();
    }

    @Deprecated
    public int getRippleColor() {
        ColorStateList colorStateList = this.h;
        if (colorStateList != null) {
            return colorStateList.getDefaultColor();
        }
        return 0;
    }

    public ColorStateList getRippleColorStateList() {
        return this.h;
    }

    public b.d.a.a.k.h getShowMotionSpec() {
        return getImpl().q();
    }

    public int getSize() {
        return this.i;
    }

    int getSizeDimension() {
        return j(this.i);
    }

    @Override // a.f.l.q
    public ColorStateList getSupportBackgroundTintList() {
        return getBackgroundTintList();
    }

    @Override // a.f.l.q
    public PorterDuff.Mode getSupportBackgroundTintMode() {
        return getBackgroundTintMode();
    }

    @Override // androidx.core.widget.k
    public ColorStateList getSupportImageTintList() {
        return this.e;
    }

    @Override // androidx.core.widget.k
    public PorterDuff.Mode getSupportImageTintMode() {
        return this.f;
    }

    public boolean getUseCompatPadding() {
        return this.m;
    }

    @Deprecated
    public boolean h(Rect rect) {
        if (r.E(this)) {
            rect.set(0, 0, getWidth(), getHeight());
            o(rect);
            return true;
        }
        return false;
    }

    public void i(Rect rect) {
        rect.set(0, 0, getMeasuredWidth(), getMeasuredHeight());
        o(rect);
    }

    @Override // android.widget.ImageView, android.view.View
    public void jumpDrawablesToCurrentState() {
        super.jumpDrawablesToCurrentState();
        getImpl().u();
    }

    public void k() {
        l(null);
    }

    public void l(b bVar) {
        m(bVar, true);
    }

    void m(b bVar, boolean z) {
        getImpl().r(w(bVar), z);
    }

    public boolean n() {
        return getImpl().t();
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();
        getImpl().x();
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onDetachedFromWindow() {
        super.onDetachedFromWindow();
        getImpl().z();
    }

    @Override // android.widget.ImageView, android.view.View
    protected void onMeasure(int i, int i2) {
        int sizeDimension = getSizeDimension();
        this.k = (sizeDimension - this.l) / 2;
        getImpl().W();
        int min = Math.min(s(sizeDimension, i), s(sizeDimension, i2));
        Rect rect = this.n;
        setMeasuredDimension(rect.left + min + rect.right, min + rect.top + rect.bottom);
    }

    @Override // android.view.View
    protected void onRestoreInstanceState(Parcelable parcelable) {
        if (!(parcelable instanceof ExtendableSavedState)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        ExtendableSavedState extendableSavedState = (ExtendableSavedState) parcelable;
        super.onRestoreInstanceState(extendableSavedState.a());
        this.q.d(extendableSavedState.f2405d.get("expandableWidgetHelper"));
    }

    @Override // android.view.View
    protected Parcelable onSaveInstanceState() {
        ExtendableSavedState extendableSavedState = new ExtendableSavedState(super.onSaveInstanceState());
        extendableSavedState.f2405d.put("expandableWidgetHelper", this.q.e());
        return extendableSavedState;
    }

    @Override // android.view.View
    public boolean onTouchEvent(MotionEvent motionEvent) {
        if (motionEvent.getAction() == 0 && h(this.o) && !this.o.contains((int) motionEvent.getX(), (int) motionEvent.getY())) {
            return false;
        }
        return super.onTouchEvent(motionEvent);
    }

    public void q(Animator.AnimatorListener animatorListener) {
        getImpl().E(animatorListener);
    }

    public void r(Animator.AnimatorListener animatorListener) {
        getImpl().F(animatorListener);
    }

    @Override // android.view.View
    public void setBackgroundColor(int i) {
        Log.i("FloatingActionButton", "Setting a custom background is not supported.");
    }

    @Override // android.view.View
    public void setBackgroundDrawable(Drawable drawable) {
        Log.i("FloatingActionButton", "Setting a custom background is not supported.");
    }

    @Override // android.view.View
    public void setBackgroundResource(int i) {
        Log.i("FloatingActionButton", "Setting a custom background is not supported.");
    }

    @Override // android.view.View
    public void setBackgroundTintList(ColorStateList colorStateList) {
        if (this.f2323c != colorStateList) {
            this.f2323c = colorStateList;
            getImpl().I(colorStateList);
        }
    }

    @Override // android.view.View
    public void setBackgroundTintMode(PorterDuff.Mode mode) {
        if (this.f2324d != mode) {
            this.f2324d = mode;
            getImpl().J(mode);
        }
    }

    public void setCompatElevation(float f) {
        getImpl().K(f);
    }

    public void setCompatElevationResource(int i) {
        setCompatElevation(getResources().getDimension(i));
    }

    public void setCompatHoveredFocusedTranslationZ(float f) {
        getImpl().M(f);
    }

    public void setCompatHoveredFocusedTranslationZResource(int i) {
        setCompatHoveredFocusedTranslationZ(getResources().getDimension(i));
    }

    public void setCompatPressedTranslationZ(float f) {
        getImpl().P(f);
    }

    public void setCompatPressedTranslationZResource(int i) {
        setCompatPressedTranslationZ(getResources().getDimension(i));
    }

    public void setCustomSize(int i) {
        if (i < 0) {
            throw new IllegalArgumentException("Custom size must be non-negative");
        }
        this.j = i;
    }

    public void setExpandedComponentIdHint(int i) {
        this.q.f(i);
    }

    public void setHideMotionSpec(b.d.a.a.k.h hVar) {
        getImpl().L(hVar);
    }

    public void setHideMotionSpecResource(int i) {
        setHideMotionSpec(b.d.a.a.k.h.c(getContext(), i));
    }

    @Override // android.widget.ImageView
    public void setImageDrawable(Drawable drawable) {
        super.setImageDrawable(drawable);
        getImpl().V();
    }

    @Override // android.widget.ImageView
    public void setImageResource(int i) {
        this.p.g(i);
    }

    public void setRippleColor(int i) {
        setRippleColor(ColorStateList.valueOf(i));
    }

    public void setRippleColor(ColorStateList colorStateList) {
        if (this.h != colorStateList) {
            this.h = colorStateList;
            getImpl().Q(this.h);
        }
    }

    public void setShowMotionSpec(b.d.a.a.k.h hVar) {
        getImpl().R(hVar);
    }

    public void setShowMotionSpecResource(int i) {
        setShowMotionSpec(b.d.a.a.k.h.c(getContext(), i));
    }

    public void setSize(int i) {
        this.j = 0;
        if (i != this.i) {
            this.i = i;
            requestLayout();
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintList(ColorStateList colorStateList) {
        setBackgroundTintList(colorStateList);
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintMode(PorterDuff.Mode mode) {
        setBackgroundTintMode(mode);
    }

    @Override // androidx.core.widget.k
    public void setSupportImageTintList(ColorStateList colorStateList) {
        if (this.e != colorStateList) {
            this.e = colorStateList;
            p();
        }
    }

    @Override // androidx.core.widget.k
    public void setSupportImageTintMode(PorterDuff.Mode mode) {
        if (this.f != mode) {
            this.f = mode;
            p();
        }
    }

    public void setUseCompatPadding(boolean z) {
        if (this.m != z) {
            this.m = z;
            getImpl().y();
        }
    }

    public void t() {
        u(null);
    }

    public void u(b bVar) {
        v(bVar, true);
    }

    void v(b bVar, boolean z) {
        getImpl().T(w(bVar), z);
    }
}
