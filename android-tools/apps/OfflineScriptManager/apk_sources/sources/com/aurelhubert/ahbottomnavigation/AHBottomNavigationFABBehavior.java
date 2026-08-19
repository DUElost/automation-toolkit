package com.aurelhubert.ahbottomnavigation;

import android.view.View;
import android.view.ViewGroup;
import androidx.coordinatorlayout.widget.CoordinatorLayout;
import com.google.android.material.floatingactionbutton.FloatingActionButton;
import com.google.android.material.snackbar.Snackbar;
/* loaded from: classes.dex */
public class AHBottomNavigationFABBehavior extends CoordinatorLayout.c<FloatingActionButton> {

    /* renamed from: a  reason: collision with root package name */
    private long f2233a;

    private void F(FloatingActionButton floatingActionButton, View view) {
        if (floatingActionButton != null && view != null && (view instanceof Snackbar.SnackbarLayout)) {
            this.f2233a = System.currentTimeMillis();
        } else if (floatingActionButton == null || view == null || !(view instanceof AHBottomNavigation) || System.currentTimeMillis() - this.f2233a < 30) {
            return;
        }
        floatingActionButton.setY(view.getY() - ((ViewGroup.MarginLayoutParams) floatingActionButton.getLayoutParams()).bottomMargin);
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    /* renamed from: D */
    public boolean e(CoordinatorLayout coordinatorLayout, FloatingActionButton floatingActionButton, View view) {
        if (view == null || !(view instanceof Snackbar.SnackbarLayout)) {
            if (view == null || !(view instanceof AHBottomNavigation)) {
                return super.e(coordinatorLayout, floatingActionButton, view);
            }
            return true;
        }
        return true;
    }

    @Override // androidx.coordinatorlayout.widget.CoordinatorLayout.c
    /* renamed from: E */
    public boolean h(CoordinatorLayout coordinatorLayout, FloatingActionButton floatingActionButton, View view) {
        F(floatingActionButton, view);
        return super.h(coordinatorLayout, floatingActionButton, view);
    }
}
