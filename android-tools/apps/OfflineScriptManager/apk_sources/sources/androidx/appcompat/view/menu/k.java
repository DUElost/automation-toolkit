package androidx.appcompat.view.menu;

import android.content.Context;
import android.content.Intent;
import android.content.res.ColorStateList;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.util.Log;
import android.view.ActionProvider;
import android.view.CollapsibleActionView;
import android.view.ContextMenu;
import android.view.MenuItem;
import android.view.SubMenu;
import android.view.View;
import android.widget.FrameLayout;
import java.lang.reflect.Method;
/* loaded from: classes.dex */
public class k extends androidx.appcompat.view.menu.c<a.f.f.a.b> implements MenuItem {
    private Method e;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends a.f.l.b {

        /* renamed from: b  reason: collision with root package name */
        final ActionProvider f569b;

        public a(Context context, ActionProvider actionProvider) {
            super(context);
            this.f569b = actionProvider;
        }

        @Override // a.f.l.b
        public boolean a() {
            return this.f569b.hasSubMenu();
        }

        @Override // a.f.l.b
        public View c() {
            return this.f569b.onCreateActionView();
        }

        @Override // a.f.l.b
        public boolean e() {
            return this.f569b.onPerformDefaultAction();
        }

        @Override // a.f.l.b
        public void f(SubMenu subMenu) {
            this.f569b.onPrepareSubMenu(k.this.d(subMenu));
        }
    }

    /* loaded from: classes.dex */
    static class b extends FrameLayout implements a.a.m.c {

        /* renamed from: b  reason: collision with root package name */
        final CollapsibleActionView f571b;

        b(View view) {
            super(view.getContext());
            this.f571b = (CollapsibleActionView) view;
            addView(view);
        }

        View a() {
            return (View) this.f571b;
        }

        @Override // a.a.m.c
        public void c() {
            this.f571b.onActionViewExpanded();
        }

        @Override // a.a.m.c
        public void f() {
            this.f571b.onActionViewCollapsed();
        }
    }

    /* loaded from: classes.dex */
    private class c extends androidx.appcompat.view.menu.d<MenuItem.OnActionExpandListener> implements MenuItem.OnActionExpandListener {
        c(MenuItem.OnActionExpandListener onActionExpandListener) {
            super(onActionExpandListener);
        }

        @Override // android.view.MenuItem.OnActionExpandListener
        public boolean onMenuItemActionCollapse(MenuItem menuItem) {
            return ((MenuItem.OnActionExpandListener) this.f537a).onMenuItemActionCollapse(k.this.c(menuItem));
        }

        @Override // android.view.MenuItem.OnActionExpandListener
        public boolean onMenuItemActionExpand(MenuItem menuItem) {
            return ((MenuItem.OnActionExpandListener) this.f537a).onMenuItemActionExpand(k.this.c(menuItem));
        }
    }

    /* loaded from: classes.dex */
    private class d extends androidx.appcompat.view.menu.d<MenuItem.OnMenuItemClickListener> implements MenuItem.OnMenuItemClickListener {
        d(MenuItem.OnMenuItemClickListener onMenuItemClickListener) {
            super(onMenuItemClickListener);
        }

        @Override // android.view.MenuItem.OnMenuItemClickListener
        public boolean onMenuItemClick(MenuItem menuItem) {
            return ((MenuItem.OnMenuItemClickListener) this.f537a).onMenuItemClick(k.this.c(menuItem));
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public k(Context context, a.f.f.a.b bVar) {
        super(context, bVar);
    }

    @Override // android.view.MenuItem
    public boolean collapseActionView() {
        return ((a.f.f.a.b) this.f537a).collapseActionView();
    }

    @Override // android.view.MenuItem
    public boolean expandActionView() {
        return ((a.f.f.a.b) this.f537a).expandActionView();
    }

    @Override // android.view.MenuItem
    public ActionProvider getActionProvider() {
        a.f.l.b b2 = ((a.f.f.a.b) this.f537a).b();
        if (b2 instanceof a) {
            return ((a) b2).f569b;
        }
        return null;
    }

    @Override // android.view.MenuItem
    public View getActionView() {
        View actionView = ((a.f.f.a.b) this.f537a).getActionView();
        return actionView instanceof b ? ((b) actionView).a() : actionView;
    }

    @Override // android.view.MenuItem
    public int getAlphabeticModifiers() {
        return ((a.f.f.a.b) this.f537a).getAlphabeticModifiers();
    }

    @Override // android.view.MenuItem
    public char getAlphabeticShortcut() {
        return ((a.f.f.a.b) this.f537a).getAlphabeticShortcut();
    }

    @Override // android.view.MenuItem
    public CharSequence getContentDescription() {
        return ((a.f.f.a.b) this.f537a).getContentDescription();
    }

    @Override // android.view.MenuItem
    public int getGroupId() {
        return ((a.f.f.a.b) this.f537a).getGroupId();
    }

    @Override // android.view.MenuItem
    public Drawable getIcon() {
        return ((a.f.f.a.b) this.f537a).getIcon();
    }

    @Override // android.view.MenuItem
    public ColorStateList getIconTintList() {
        return ((a.f.f.a.b) this.f537a).getIconTintList();
    }

    @Override // android.view.MenuItem
    public PorterDuff.Mode getIconTintMode() {
        return ((a.f.f.a.b) this.f537a).getIconTintMode();
    }

    @Override // android.view.MenuItem
    public Intent getIntent() {
        return ((a.f.f.a.b) this.f537a).getIntent();
    }

    @Override // android.view.MenuItem
    public int getItemId() {
        return ((a.f.f.a.b) this.f537a).getItemId();
    }

    @Override // android.view.MenuItem
    public ContextMenu.ContextMenuInfo getMenuInfo() {
        return ((a.f.f.a.b) this.f537a).getMenuInfo();
    }

    @Override // android.view.MenuItem
    public int getNumericModifiers() {
        return ((a.f.f.a.b) this.f537a).getNumericModifiers();
    }

    @Override // android.view.MenuItem
    public char getNumericShortcut() {
        return ((a.f.f.a.b) this.f537a).getNumericShortcut();
    }

    @Override // android.view.MenuItem
    public int getOrder() {
        return ((a.f.f.a.b) this.f537a).getOrder();
    }

    @Override // android.view.MenuItem
    public SubMenu getSubMenu() {
        return d(((a.f.f.a.b) this.f537a).getSubMenu());
    }

    @Override // android.view.MenuItem
    public CharSequence getTitle() {
        return ((a.f.f.a.b) this.f537a).getTitle();
    }

    @Override // android.view.MenuItem
    public CharSequence getTitleCondensed() {
        return ((a.f.f.a.b) this.f537a).getTitleCondensed();
    }

    @Override // android.view.MenuItem
    public CharSequence getTooltipText() {
        return ((a.f.f.a.b) this.f537a).getTooltipText();
    }

    a h(ActionProvider actionProvider) {
        return new a(this.f534b, actionProvider);
    }

    @Override // android.view.MenuItem
    public boolean hasSubMenu() {
        return ((a.f.f.a.b) this.f537a).hasSubMenu();
    }

    public void i(boolean z) {
        try {
            if (this.e == null) {
                this.e = ((a.f.f.a.b) this.f537a).getClass().getDeclaredMethod("setExclusiveCheckable", Boolean.TYPE);
            }
            this.e.invoke(this.f537a, Boolean.valueOf(z));
        } catch (Exception e) {
            Log.w("MenuItemWrapper", "Error while calling setExclusiveCheckable", e);
        }
    }

    @Override // android.view.MenuItem
    public boolean isActionViewExpanded() {
        return ((a.f.f.a.b) this.f537a).isActionViewExpanded();
    }

    @Override // android.view.MenuItem
    public boolean isCheckable() {
        return ((a.f.f.a.b) this.f537a).isCheckable();
    }

    @Override // android.view.MenuItem
    public boolean isChecked() {
        return ((a.f.f.a.b) this.f537a).isChecked();
    }

    @Override // android.view.MenuItem
    public boolean isEnabled() {
        return ((a.f.f.a.b) this.f537a).isEnabled();
    }

    @Override // android.view.MenuItem
    public boolean isVisible() {
        return ((a.f.f.a.b) this.f537a).isVisible();
    }

    @Override // android.view.MenuItem
    public MenuItem setActionProvider(ActionProvider actionProvider) {
        ((a.f.f.a.b) this.f537a).a(actionProvider != null ? h(actionProvider) : null);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setActionView(int i) {
        ((a.f.f.a.b) this.f537a).setActionView(i);
        View actionView = ((a.f.f.a.b) this.f537a).getActionView();
        if (actionView instanceof CollapsibleActionView) {
            ((a.f.f.a.b) this.f537a).setActionView(new b(actionView));
        }
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setActionView(View view) {
        if (view instanceof CollapsibleActionView) {
            view = new b(view);
        }
        ((a.f.f.a.b) this.f537a).setActionView(view);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setAlphabeticShortcut(char c2) {
        ((a.f.f.a.b) this.f537a).setAlphabeticShortcut(c2);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setAlphabeticShortcut(char c2, int i) {
        ((a.f.f.a.b) this.f537a).setAlphabeticShortcut(c2, i);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setCheckable(boolean z) {
        ((a.f.f.a.b) this.f537a).setCheckable(z);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setChecked(boolean z) {
        ((a.f.f.a.b) this.f537a).setChecked(z);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setContentDescription(CharSequence charSequence) {
        ((a.f.f.a.b) this.f537a).setContentDescription(charSequence);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setEnabled(boolean z) {
        ((a.f.f.a.b) this.f537a).setEnabled(z);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setIcon(int i) {
        ((a.f.f.a.b) this.f537a).setIcon(i);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setIcon(Drawable drawable) {
        ((a.f.f.a.b) this.f537a).setIcon(drawable);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setIconTintList(ColorStateList colorStateList) {
        ((a.f.f.a.b) this.f537a).setIconTintList(colorStateList);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setIconTintMode(PorterDuff.Mode mode) {
        ((a.f.f.a.b) this.f537a).setIconTintMode(mode);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setIntent(Intent intent) {
        ((a.f.f.a.b) this.f537a).setIntent(intent);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setNumericShortcut(char c2) {
        ((a.f.f.a.b) this.f537a).setNumericShortcut(c2);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setNumericShortcut(char c2, int i) {
        ((a.f.f.a.b) this.f537a).setNumericShortcut(c2, i);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setOnActionExpandListener(MenuItem.OnActionExpandListener onActionExpandListener) {
        ((a.f.f.a.b) this.f537a).setOnActionExpandListener(onActionExpandListener != null ? new c(onActionExpandListener) : null);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setOnMenuItemClickListener(MenuItem.OnMenuItemClickListener onMenuItemClickListener) {
        ((a.f.f.a.b) this.f537a).setOnMenuItemClickListener(onMenuItemClickListener != null ? new d(onMenuItemClickListener) : null);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setShortcut(char c2, char c3) {
        ((a.f.f.a.b) this.f537a).setShortcut(c2, c3);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setShortcut(char c2, char c3, int i, int i2) {
        ((a.f.f.a.b) this.f537a).setShortcut(c2, c3, i, i2);
        return this;
    }

    @Override // android.view.MenuItem
    public void setShowAsAction(int i) {
        ((a.f.f.a.b) this.f537a).setShowAsAction(i);
    }

    @Override // android.view.MenuItem
    public MenuItem setShowAsActionFlags(int i) {
        ((a.f.f.a.b) this.f537a).setShowAsActionFlags(i);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setTitle(int i) {
        ((a.f.f.a.b) this.f537a).setTitle(i);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setTitle(CharSequence charSequence) {
        ((a.f.f.a.b) this.f537a).setTitle(charSequence);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setTitleCondensed(CharSequence charSequence) {
        ((a.f.f.a.b) this.f537a).setTitleCondensed(charSequence);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setTooltipText(CharSequence charSequence) {
        ((a.f.f.a.b) this.f537a).setTooltipText(charSequence);
        return this;
    }

    @Override // android.view.MenuItem
    public MenuItem setVisible(boolean z) {
        return ((a.f.f.a.b) this.f537a).setVisible(z);
    }
}
