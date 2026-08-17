package com.google.android.material.internal;

import a.f.l.r;
import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.drawable.ColorDrawable;
import android.graphics.drawable.Drawable;
import android.graphics.drawable.StateListDrawable;
import android.util.AttributeSet;
import android.util.TypedValue;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewStub;
import android.widget.CheckedTextView;
import android.widget.FrameLayout;
import androidx.appcompat.view.menu.j;
import androidx.appcompat.view.menu.p;
import androidx.appcompat.widget.d0;
import androidx.appcompat.widget.s0;
import androidx.core.widget.i;
/* loaded from: classes.dex */
public class NavigationMenuItemView extends d implements p.a {
    private static final int[] G = {16842912};
    private FrameLayout A;
    private j B;
    private ColorStateList C;
    private boolean D;
    private Drawable E;
    private final a.f.l.a F;
    private final int w;
    private boolean x;
    boolean y;
    private final CheckedTextView z;

    /* loaded from: classes.dex */
    class a extends a.f.l.a {
        a() {
        }

        @Override // a.f.l.a
        public void e(View view, a.f.l.a0.c cVar) {
            super.e(view, cVar);
            cVar.u(NavigationMenuItemView.this.y);
        }
    }

    public NavigationMenuItemView(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, 0);
    }

    public NavigationMenuItemView(Context context, AttributeSet attributeSet, int i) {
        super(context, attributeSet, i);
        a aVar = new a();
        this.F = aVar;
        setOrientation(0);
        LayoutInflater.from(context).inflate(b.d.a.a.h.design_navigation_menu_item, (ViewGroup) this, true);
        this.w = context.getResources().getDimensionPixelSize(b.d.a.a.d.design_navigation_icon_size);
        CheckedTextView checkedTextView = (CheckedTextView) findViewById(b.d.a.a.f.design_menu_item_text);
        this.z = checkedTextView;
        checkedTextView.setDuplicateParentStateEnabled(true);
        r.O(checkedTextView, aVar);
    }

    private void B() {
        d0.a aVar;
        int i;
        if (D()) {
            this.z.setVisibility(8);
            FrameLayout frameLayout = this.A;
            if (frameLayout == null) {
                return;
            }
            aVar = (d0.a) frameLayout.getLayoutParams();
            i = -1;
        } else {
            this.z.setVisibility(0);
            FrameLayout frameLayout2 = this.A;
            if (frameLayout2 == null) {
                return;
            }
            aVar = (d0.a) frameLayout2.getLayoutParams();
            i = -2;
        }
        ((ViewGroup.MarginLayoutParams) aVar).width = i;
        this.A.setLayoutParams(aVar);
    }

    private StateListDrawable C() {
        TypedValue typedValue = new TypedValue();
        if (getContext().getTheme().resolveAttribute(a.a.a.colorControlHighlight, typedValue, true)) {
            StateListDrawable stateListDrawable = new StateListDrawable();
            stateListDrawable.addState(G, new ColorDrawable(typedValue.data));
            stateListDrawable.addState(ViewGroup.EMPTY_STATE_SET, new ColorDrawable(0));
            return stateListDrawable;
        }
        return null;
    }

    private boolean D() {
        return this.B.getTitle() == null && this.B.getIcon() == null && this.B.getActionView() != null;
    }

    private void setActionView(View view) {
        if (view != null) {
            if (this.A == null) {
                this.A = (FrameLayout) ((ViewStub) findViewById(b.d.a.a.f.design_menu_item_action_area_stub)).inflate();
            }
            this.A.removeAllViews();
            this.A.addView(view);
        }
    }

    @Override // androidx.appcompat.view.menu.p.a
    public boolean d() {
        return false;
    }

    @Override // androidx.appcompat.view.menu.p.a
    public void e(j jVar, int i) {
        this.B = jVar;
        setVisibility(jVar.isVisible() ? 0 : 8);
        if (getBackground() == null) {
            r.Q(this, C());
        }
        setCheckable(jVar.isCheckable());
        setChecked(jVar.isChecked());
        setEnabled(jVar.isEnabled());
        setTitle(jVar.getTitle());
        setIcon(jVar.getIcon());
        setActionView(jVar.getActionView());
        setContentDescription(jVar.getContentDescription());
        s0.a(this, jVar.getTooltipText());
        B();
    }

    @Override // androidx.appcompat.view.menu.p.a
    public j getItemData() {
        return this.B;
    }

    @Override // android.view.ViewGroup, android.view.View
    protected int[] onCreateDrawableState(int i) {
        int[] onCreateDrawableState = super.onCreateDrawableState(i + 1);
        j jVar = this.B;
        if (jVar != null && jVar.isCheckable() && this.B.isChecked()) {
            ViewGroup.mergeDrawableStates(onCreateDrawableState, G);
        }
        return onCreateDrawableState;
    }

    public void setCheckable(boolean z) {
        refreshDrawableState();
        if (this.y != z) {
            this.y = z;
            this.F.i(this.z, 2048);
        }
    }

    public void setChecked(boolean z) {
        refreshDrawableState();
        this.z.setChecked(z);
    }

    public void setHorizontalPadding(int i) {
        setPadding(i, 0, i, 0);
    }

    public void setIcon(Drawable drawable) {
        if (drawable != null) {
            if (this.D) {
                Drawable.ConstantState constantState = drawable.getConstantState();
                if (constantState != null) {
                    drawable = constantState.newDrawable();
                }
                drawable = androidx.core.graphics.drawable.a.q(drawable).mutate();
                androidx.core.graphics.drawable.a.o(drawable, this.C);
            }
            int i = this.w;
            drawable.setBounds(0, 0, i, i);
        } else if (this.x) {
            if (this.E == null) {
                Drawable a2 = androidx.core.content.c.f.a(getResources(), b.d.a.a.e.navigation_empty_icon, getContext().getTheme());
                this.E = a2;
                if (a2 != null) {
                    int i2 = this.w;
                    a2.setBounds(0, 0, i2, i2);
                }
            }
            drawable = this.E;
        }
        i.i(this.z, drawable, null, null, null);
    }

    public void setIconPadding(int i) {
        this.z.setCompoundDrawablePadding(i);
    }

    void setIconTintList(ColorStateList colorStateList) {
        this.C = colorStateList;
        this.D = colorStateList != null;
        j jVar = this.B;
        if (jVar != null) {
            setIcon(jVar.getIcon());
        }
    }

    public void setNeedsEmptyIcon(boolean z) {
        this.x = z;
    }

    public void setTextAppearance(int i) {
        i.n(this.z, i);
    }

    public void setTextColor(ColorStateList colorStateList) {
        this.z.setTextColor(colorStateList);
    }

    public void setTitle(CharSequence charSequence) {
        this.z.setText(charSequence);
    }
}
