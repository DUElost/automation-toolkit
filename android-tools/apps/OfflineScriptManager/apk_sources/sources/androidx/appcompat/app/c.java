package androidx.appcompat.app;

import a.a.m.b;
import android.content.Intent;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Build;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import androidx.appcompat.widget.Toolbar;
import androidx.appcompat.widget.v0;
import androidx.core.app.l;
/* loaded from: classes.dex */
public class c extends androidx.fragment.app.b implements d, l.a {
    private e n;
    private int o = 0;
    private Resources p;

    private boolean H(int i, KeyEvent keyEvent) {
        Window window;
        return (Build.VERSION.SDK_INT >= 26 || keyEvent.isCtrlPressed() || KeyEvent.metaStateHasNoModifiers(keyEvent.getMetaState()) || keyEvent.getRepeatCount() != 0 || KeyEvent.isModifierKey(keyEvent.getKeyCode()) || (window = getWindow()) == null || window.getDecorView() == null || !window.getDecorView().dispatchKeyShortcutEvent(keyEvent)) ? false : true;
    }

    @Override // androidx.fragment.app.b
    public void A() {
        B().l();
    }

    public e B() {
        if (this.n == null) {
            this.n = e.e(this, this);
        }
        return this.n;
    }

    public a C() {
        return B().j();
    }

    public void D(l lVar) {
        lVar.b(this);
    }

    public void E(l lVar) {
    }

    @Deprecated
    public void F() {
    }

    public boolean G() {
        Intent h = h();
        if (h != null) {
            if (!K(h)) {
                J(h);
                return true;
            }
            l d2 = l.d(this);
            D(d2);
            E(d2);
            d2.e();
            try {
                androidx.core.app.a.h(this);
                return true;
            } catch (IllegalStateException unused) {
                finish();
                return true;
            }
        }
        return false;
    }

    public void I(Toolbar toolbar) {
        B().y(toolbar);
    }

    public void J(Intent intent) {
        androidx.core.app.e.e(this, intent);
    }

    public boolean K(Intent intent) {
        return androidx.core.app.e.f(this, intent);
    }

    @Override // android.app.Activity
    public void addContentView(View view, ViewGroup.LayoutParams layoutParams) {
        B().c(view, layoutParams);
    }

    @Override // android.app.Activity
    public void closeOptionsMenu() {
        a C = C();
        if (getWindow().hasFeature(0)) {
            if (C == null || !C.g()) {
                super.closeOptionsMenu();
            }
        }
    }

    @Override // androidx.core.app.d, android.app.Activity, android.view.Window.Callback
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        int keyCode = keyEvent.getKeyCode();
        a C = C();
        if (keyCode == 82 && C != null && C.p(keyEvent)) {
            return true;
        }
        return super.dispatchKeyEvent(keyEvent);
    }

    @Override // android.app.Activity
    public <T extends View> T findViewById(int i) {
        return (T) B().g(i);
    }

    @Override // android.app.Activity
    public MenuInflater getMenuInflater() {
        return B().i();
    }

    @Override // android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public Resources getResources() {
        if (this.p == null && v0.b()) {
            this.p = new v0(this, super.getResources());
        }
        Resources resources = this.p;
        return resources == null ? super.getResources() : resources;
    }

    @Override // androidx.core.app.l.a
    public Intent h() {
        return androidx.core.app.e.a(this);
    }

    @Override // androidx.appcompat.app.d
    public void i(a.a.m.b bVar) {
    }

    @Override // android.app.Activity
    public void invalidateOptionsMenu() {
        B().l();
    }

    @Override // androidx.appcompat.app.d
    public void n(a.a.m.b bVar) {
    }

    @Override // androidx.appcompat.app.d
    public a.a.m.b o(b.a aVar) {
        return null;
    }

    @Override // androidx.fragment.app.b, android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        B().m(configuration);
        if (this.p != null) {
            this.p.updateConfiguration(configuration, super.getResources().getDisplayMetrics());
        }
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onContentChanged() {
        F();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        int i;
        e B = B();
        B.k();
        B.n(bundle);
        if (B.d() && (i = this.o) != 0) {
            if (Build.VERSION.SDK_INT >= 23) {
                onApplyThemeResource(getTheme(), this.o, false);
            } else {
                setTheme(i);
            }
        }
        super.onCreate(bundle);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, android.app.Activity
    public void onDestroy() {
        super.onDestroy();
        B().o();
    }

    @Override // android.app.Activity, android.view.KeyEvent.Callback
    public boolean onKeyDown(int i, KeyEvent keyEvent) {
        if (H(i, keyEvent)) {
            return true;
        }
        return super.onKeyDown(i, keyEvent);
    }

    @Override // androidx.fragment.app.b, android.app.Activity, android.view.Window.Callback
    public final boolean onMenuItemSelected(int i, MenuItem menuItem) {
        if (super.onMenuItemSelected(i, menuItem)) {
            return true;
        }
        a C = C();
        if (menuItem.getItemId() != 16908332 || C == null || (C.j() & 4) == 0) {
            return false;
        }
        return G();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onMenuOpened(int i, Menu menu) {
        return super.onMenuOpened(i, menu);
    }

    @Override // androidx.fragment.app.b, android.app.Activity, android.view.Window.Callback
    public void onPanelClosed(int i, Menu menu) {
        super.onPanelClosed(i, menu);
    }

    @Override // android.app.Activity
    protected void onPostCreate(Bundle bundle) {
        super.onPostCreate(bundle);
        B().p(bundle);
    }

    @Override // androidx.fragment.app.b, android.app.Activity
    protected void onPostResume() {
        super.onPostResume();
        B().q();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, androidx.core.app.d, android.app.Activity
    public void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        B().r(bundle);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, android.app.Activity
    public void onStart() {
        super.onStart();
        B().s();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.fragment.app.b, android.app.Activity
    public void onStop() {
        super.onStop();
        B().t();
    }

    @Override // android.app.Activity
    protected void onTitleChanged(CharSequence charSequence, int i) {
        super.onTitleChanged(charSequence, i);
        B().z(charSequence);
    }

    @Override // android.app.Activity
    public void openOptionsMenu() {
        a C = C();
        if (getWindow().hasFeature(0)) {
            if (C == null || !C.q()) {
                super.openOptionsMenu();
            }
        }
    }

    @Override // android.app.Activity
    public void setContentView(int i) {
        B().v(i);
    }

    @Override // android.app.Activity
    public void setContentView(View view) {
        B().w(view);
    }

    @Override // android.app.Activity
    public void setContentView(View view, ViewGroup.LayoutParams layoutParams) {
        B().x(view, layoutParams);
    }

    @Override // android.app.Activity, android.view.ContextThemeWrapper, android.content.ContextWrapper, android.content.Context
    public void setTheme(int i) {
        super.setTheme(i);
        this.o = i;
    }
}
