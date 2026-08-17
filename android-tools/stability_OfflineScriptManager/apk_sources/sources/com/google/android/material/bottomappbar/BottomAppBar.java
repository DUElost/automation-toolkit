package com.google.android.material.bottomappbar;

import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Rect;
import android.os.Parcel;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.view.View;
import androidx.appcompat.widget.ActionMenuView;
import androidx.appcompat.widget.Toolbar;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import androidx.customview.view.AbsSavedState;
import com.google.android.material.behavior.HideBottomViewOnScrollBehavior;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class BottomAppBar extends Toolbar implements CoordinatorLayout.b {
    private final int Q;
    private final b.d.a.a.s.b R;
    private final com.google.android.material.bottomappbar.a S;
    private Animator T;
    private Animator U;
    private Animator V;
    private int W;
    private boolean a0;
    private boolean b0;
    AnimatorListenerAdapter c0;

    /* loaded from: classes.dex */
    public static class Behavior extends HideBottomViewOnScrollBehavior<BottomAppBar> {

        /* renamed from: d  reason: collision with root package name */
        private final Rect f2304d;

        public Behavior() {
            this.f2304d = new Rect();
        }

        public Behavior(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f2304d = new Rect();
        }

        private boolean L(FloatingActionButton floatingActionButton, BottomAppBar bottomAppBar) {
            ((CoordinatorLayout.f) floatingActionButton.getLayoutParams()).f822d = 17;
            bottomAppBar.W(floatingActionButton);
            return true;
        }

        @Override // com.google.android.material.behavior.HideBottomViewOnScrollBehavior, androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: H */
        public boolean l(CoordinatorLayout coordinatorLayout, BottomAppBar bottomAppBar, int i) {
            FloatingActionButton b0 = bottomAppBar.b0();
            if (b0 != null) {
                L(b0, bottomAppBar);
                b0.i(this.f2304d);
                bottomAppBar.setFabDiameter(this.f2304d.height());
            }
            if (bottomAppBar.e0()) {
                coordinatorLayout.H(bottomAppBar, i);
                return super.l(coordinatorLayout, bottomAppBar, i);
            }
            BottomAppBar.S(bottomAppBar);
            throw null;
        }

        @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
        /* renamed from: I */
        public boolean z(CoordinatorLayout coordinatorLayout, BottomAppBar bottomAppBar, View view, View view2, int i, int i2) {
            return bottomAppBar.getHideOnScroll() && super.z(coordinatorLayout, bottomAppBar, view, view2, i, i2);
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // com.google.android.material.behavior.HideBottomViewOnScrollBehavior
        /* renamed from: J */
        public void F(BottomAppBar bottomAppBar) {
            super.F(bottomAppBar);
            FloatingActionButton b0 = bottomAppBar.b0();
            if (b0 != null) {
                b0.h(this.f2304d);
                b0.clearAnimation();
                b0.animate().translationY((-b0.getPaddingBottom()) + (b0.getMeasuredHeight() - this.f2304d.height())).setInterpolator(b.d.a.a.k.a.f1468b).setDuration(175L);
            }
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // com.google.android.material.behavior.HideBottomViewOnScrollBehavior
        /* renamed from: K */
        public void G(BottomAppBar bottomAppBar) {
            super.G(bottomAppBar);
            FloatingActionButton b0 = bottomAppBar.b0();
            if (b0 != null) {
                b0.clearAnimation();
                b0.animate().translationY(bottomAppBar.getFabTranslationY()).setInterpolator(b.d.a.a.k.a.f1469c).setDuration(225L);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class SavedState extends AbsSavedState {
        public static final Parcelable.Creator<SavedState> CREATOR = new a();

        /* renamed from: d  reason: collision with root package name */
        int f2305d;
        boolean e;

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
            this.f2305d = parcel.readInt();
            this.e = parcel.readInt() != 0;
        }

        public SavedState(Parcelable parcelable) {
            super(parcelable);
        }

        @Override // androidx.customview.view.AbsSavedState, android.os.Parcelable
        public void writeToParcel(Parcel parcel, int i) {
            super.writeToParcel(parcel, i);
            parcel.writeInt(this.f2305d);
            parcel.writeInt(this.e ? 1 : 0);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends AnimatorListenerAdapter {
        a() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            BottomAppBar.this.U = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends AnimatorListenerAdapter {
        b() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            BottomAppBar.this.V = null;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        public boolean f2308a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ActionMenuView f2309b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ int f2310c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ boolean f2311d;

        c(ActionMenuView actionMenuView, int i, boolean z) {
            this.f2309b = actionMenuView;
            this.f2310c = i;
            this.f2311d = z;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f2308a = true;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            if (this.f2308a) {
                return;
            }
            BottomAppBar.this.k0(this.f2309b, this.f2310c, this.f2311d);
        }
    }

    static /* synthetic */ void S(BottomAppBar bottomAppBar) {
        bottomAppBar.j0();
        throw null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void W(FloatingActionButton floatingActionButton) {
        i0(floatingActionButton);
        floatingActionButton.e(this.c0);
        floatingActionButton.f(this.c0);
    }

    private void X() {
        Animator animator = this.T;
        if (animator != null) {
            animator.cancel();
        }
        Animator animator2 = this.V;
        if (animator2 != null) {
            animator2.cancel();
        }
        Animator animator3 = this.U;
        if (animator3 != null) {
            animator3.cancel();
        }
    }

    private void Y(int i, List<Animator> list) {
        if (this.b0) {
            this.S.e();
            throw null;
        }
    }

    private void Z(int i, List<Animator> list) {
        ObjectAnimator ofFloat = ObjectAnimator.ofFloat(b0(), "translationX", c0(i));
        ofFloat.setDuration(300L);
        list.add(ofFloat);
    }

    private void a0(int i, boolean z, List<Animator> list) {
        ActionMenuView actionMenuView = getActionMenuView();
        if (actionMenuView == null) {
            return;
        }
        Animator ofFloat = ObjectAnimator.ofFloat(actionMenuView, "alpha", 1.0f);
        if ((!this.b0 && (!z || !f0())) || (this.W != 1 && i != 1)) {
            if (actionMenuView.getAlpha() < 1.0f) {
                list.add(ofFloat);
                return;
            }
            return;
        }
        ObjectAnimator ofFloat2 = ObjectAnimator.ofFloat(actionMenuView, "alpha", 0.0f);
        ofFloat2.addListener(new c(actionMenuView, i, z));
        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.setDuration(150L);
        animatorSet.playSequentially(ofFloat2, ofFloat);
        list.add(animatorSet);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public FloatingActionButton b0() {
        if (getParent() instanceof CoordinatorLayout) {
            for (View view : ((CoordinatorLayout) getParent()).r(this)) {
                if (view instanceof FloatingActionButton) {
                    return (FloatingActionButton) view;
                }
            }
            return null;
        }
        return null;
    }

    private int c0(int i) {
        boolean z = r.q(this) == 1;
        if (i == 1) {
            return ((getMeasuredWidth() / 2) - this.Q) * (z ? -1 : 1);
        }
        return 0;
    }

    private float d0(boolean z) {
        FloatingActionButton b0 = b0();
        if (b0 == null) {
            return 0.0f;
        }
        Rect rect = new Rect();
        b0.h(rect);
        float height = rect.height();
        if (height == 0.0f) {
            height = b0.getMeasuredHeight();
        }
        float height2 = b0.getHeight() - rect.height();
        float height3 = (-getCradleVerticalOffset()) + (height / 2.0f) + (b0.getHeight() - rect.bottom);
        float paddingBottom = height2 - b0.getPaddingBottom();
        float f = -getMeasuredHeight();
        if (!z) {
            height3 = paddingBottom;
        }
        return f + height3;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public boolean e0() {
        Animator animator;
        Animator animator2;
        Animator animator3 = this.T;
        return (animator3 != null && animator3.isRunning()) || ((animator = this.V) != null && animator.isRunning()) || ((animator2 = this.U) != null && animator2.isRunning());
    }

    private boolean f0() {
        FloatingActionButton b0 = b0();
        return b0 != null && b0.n();
    }

    private void g0(int i, boolean z) {
        if (r.E(this)) {
            Animator animator = this.V;
            if (animator != null) {
                animator.cancel();
            }
            ArrayList arrayList = new ArrayList();
            if (!f0()) {
                i = 0;
                z = false;
            }
            a0(i, z, arrayList);
            AnimatorSet animatorSet = new AnimatorSet();
            animatorSet.playTogether(arrayList);
            this.V = animatorSet;
            animatorSet.addListener(new b());
            this.V.start();
        }
    }

    private ActionMenuView getActionMenuView() {
        for (int i = 0; i < getChildCount(); i++) {
            View childAt = getChildAt(i);
            if (childAt instanceof ActionMenuView) {
                return (ActionMenuView) childAt;
            }
        }
        return null;
    }

    private float getFabTranslationX() {
        return c0(this.W);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public float getFabTranslationY() {
        return d0(this.b0);
    }

    private void h0(int i) {
        if (this.W == i || !r.E(this)) {
            return;
        }
        Animator animator = this.U;
        if (animator != null) {
            animator.cancel();
        }
        ArrayList arrayList = new ArrayList();
        Y(i, arrayList);
        Z(i, arrayList);
        AnimatorSet animatorSet = new AnimatorSet();
        animatorSet.playTogether(arrayList);
        this.U = animatorSet;
        animatorSet.addListener(new a());
        this.U.start();
    }

    private void i0(FloatingActionButton floatingActionButton) {
        floatingActionButton.q(this.c0);
        floatingActionButton.r(this.c0);
    }

    private void j0() {
        this.S.j(getFabTranslationX());
        throw null;
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void k0(ActionMenuView actionMenuView, int i, boolean z) {
        boolean z2 = r.q(this) == 1;
        int i2 = 0;
        for (int i3 = 0; i3 < getChildCount(); i3++) {
            View childAt = getChildAt(i3);
            if ((childAt.getLayoutParams() instanceof Toolbar.e) && (((Toolbar.e) childAt.getLayoutParams()).f479a & 8388615) == 8388611) {
                i2 = Math.max(i2, z2 ? childAt.getLeft() : childAt.getRight());
            }
        }
        actionMenuView.setTranslationX((i == 1 && z) ? i2 - (z2 ? actionMenuView.getRight() : actionMenuView.getLeft()) : 0.0f);
    }

    public ColorStateList getBackgroundTint() {
        return this.R.a();
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.b
    public CoordinatorLayout.c<BottomAppBar> getBehavior() {
        return new Behavior();
    }

    public float getCradleVerticalOffset() {
        return this.S.a();
    }

    public int getFabAlignmentMode() {
        return this.W;
    }

    public float getFabCradleMargin() {
        return this.S.b();
    }

    public float getFabCradleRoundedCornerRadius() {
        return this.S.c();
    }

    public boolean getHideOnScroll() {
        return this.a0;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.widget.Toolbar, android.view.ViewGroup, android.view.View
    public void onLayout(boolean z, int i, int i2, int i3, int i4) {
        super.onLayout(z, i, i2, i3, i4);
        X();
        j0();
        throw null;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.widget.Toolbar, android.view.View
    public void onRestoreInstanceState(Parcelable parcelable) {
        if (!(parcelable instanceof SavedState)) {
            super.onRestoreInstanceState(parcelable);
            return;
        }
        SavedState savedState = (SavedState) parcelable;
        super.onRestoreInstanceState(savedState.a());
        this.W = savedState.f2305d;
        this.b0 = savedState.e;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.appcompat.widget.Toolbar, android.view.View
    public Parcelable onSaveInstanceState() {
        SavedState savedState = new SavedState(super.onSaveInstanceState());
        savedState.f2305d = this.W;
        savedState.e = this.b0;
        return savedState;
    }

    public void setBackgroundTint(ColorStateList colorStateList) {
        androidx.core.graphics.drawable.a.o(this.R, colorStateList);
    }

    public void setCradleVerticalOffset(float f) {
        if (f != getCradleVerticalOffset()) {
            this.S.f(f);
            this.R.invalidateSelf();
        }
    }

    public void setFabAlignmentMode(int i) {
        h0(i);
        g0(i, this.b0);
        this.W = i;
    }

    public void setFabCradleMargin(float f) {
        if (f != getFabCradleMargin()) {
            this.S.g(f);
            this.R.invalidateSelf();
        }
    }

    public void setFabCradleRoundedCornerRadius(float f) {
        if (f != getFabCradleRoundedCornerRadius()) {
            this.S.h(f);
            this.R.invalidateSelf();
        }
    }

    void setFabDiameter(int i) {
        float f = i;
        if (f != this.S.d()) {
            this.S.i(f);
            this.R.invalidateSelf();
        }
    }

    public void setHideOnScroll(boolean z) {
        this.a0 = z;
    }

    @Override // androidx.appcompat.widget.Toolbar
    public void setSubtitle(CharSequence charSequence) {
    }

    @Override // androidx.appcompat.widget.Toolbar
    public void setTitle(CharSequence charSequence) {
    }
}
