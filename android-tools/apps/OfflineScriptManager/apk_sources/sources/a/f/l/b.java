package a.f.l;

import android.content.Context;
import android.util.Log;
import android.view.MenuItem;
import android.view.SubMenu;
import android.view.View;
/* loaded from: classes.dex */
public abstract class b {

    /* renamed from: a  reason: collision with root package name */
    private InterfaceC0012b f179a;

    /* loaded from: classes.dex */
    public interface a {
    }

    /* renamed from: a.f.l.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0012b {
        void onActionProviderVisibilityChanged(boolean z);
    }

    public b(Context context) {
    }

    public boolean a() {
        return false;
    }

    public boolean b() {
        return true;
    }

    public abstract View c();

    public View d(MenuItem menuItem) {
        return c();
    }

    public boolean e() {
        return false;
    }

    public void f(SubMenu subMenu) {
    }

    public boolean g() {
        return false;
    }

    public void h() {
        this.f179a = null;
    }

    public void i(a aVar) {
    }

    public void j(InterfaceC0012b interfaceC0012b) {
        if (this.f179a != null && interfaceC0012b != null) {
            Log.w("ActionProvider(support)", "setVisibilityListener: Setting a new ActionProvider.VisibilityListener when one is already set. Are you reusing this " + getClass().getSimpleName() + " instance while it is still in use somewhere else?");
        }
        this.f179a = interfaceC0012b;
    }
}
