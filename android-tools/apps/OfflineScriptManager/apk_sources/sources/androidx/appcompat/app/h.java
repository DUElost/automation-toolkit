package androidx.appcompat.app;

import a.f.l.r;
import android.content.Context;
import android.content.res.Configuration;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import androidx.appcompat.app.a;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.widget.Toolbar;
import androidx.appcompat.widget.r0;
import androidx.appcompat.widget.y;
import java.util.ArrayList;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class h extends androidx.appcompat.app.a {

    /* renamed from: a  reason: collision with root package name */
    y f491a;

    /* renamed from: b  reason: collision with root package name */
    boolean f492b;

    /* renamed from: c  reason: collision with root package name */
    Window.Callback f493c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f494d;
    private boolean e;
    private ArrayList<a.b> f = new ArrayList<>();
    private final Runnable g = new a();
    private final Toolbar.f h;

    /* loaded from: classes.dex */
    class a implements Runnable {
        a() {
        }

        @Override // java.lang.Runnable
        public void run() {
            h.this.z();
        }
    }

    /* loaded from: classes.dex */
    class b implements Toolbar.f {
        b() {
        }

        @Override // androidx.appcompat.widget.Toolbar.f
        public boolean onMenuItemClick(MenuItem menuItem) {
            return h.this.f493c.onMenuItemSelected(0, menuItem);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public final class c implements o.a {

        /* renamed from: b  reason: collision with root package name */
        private boolean f497b;

        c() {
        }

        @Override // androidx.appcompat.view.menu.o.a
        public void b(androidx.appcompat.view.menu.h hVar, boolean z) {
            if (this.f497b) {
                return;
            }
            this.f497b = true;
            h.this.f491a.h();
            Window.Callback callback = h.this.f493c;
            if (callback != null) {
                callback.onPanelClosed(108, hVar);
            }
            this.f497b = false;
        }

        @Override // androidx.appcompat.view.menu.o.a
        public boolean c(androidx.appcompat.view.menu.h hVar) {
            Window.Callback callback = h.this.f493c;
            if (callback != null) {
                callback.onMenuOpened(108, hVar);
                return true;
            }
            return false;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public final class d implements h.a {
        d() {
        }

        @Override // androidx.appcompat.view.menu.h.a
        public boolean a(androidx.appcompat.view.menu.h hVar, MenuItem menuItem) {
            return false;
        }

        @Override // androidx.appcompat.view.menu.h.a
        public void b(androidx.appcompat.view.menu.h hVar) {
            h hVar2 = h.this;
            if (hVar2.f493c != null) {
                if (hVar2.f491a.c()) {
                    h.this.f493c.onPanelClosed(108, hVar);
                } else if (h.this.f493c.onPreparePanel(0, null, hVar)) {
                    h.this.f493c.onMenuOpened(108, hVar);
                }
            }
        }
    }

    /* loaded from: classes.dex */
    private class e extends a.a.m.i {
        public e(Window.Callback callback) {
            super(callback);
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public View onCreatePanelView(int i) {
            return i == 0 ? new View(h.this.f491a.q()) : super.onCreatePanelView(i);
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public boolean onPreparePanel(int i, View view, Menu menu) {
            boolean onPreparePanel = super.onPreparePanel(i, view, menu);
            if (onPreparePanel) {
                h hVar = h.this;
                if (!hVar.f492b) {
                    hVar.f491a.f();
                    h.this.f492b = true;
                }
            }
            return onPreparePanel;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public h(Toolbar toolbar, CharSequence charSequence, Window.Callback callback) {
        b bVar = new b();
        this.h = bVar;
        this.f491a = new r0(toolbar, false);
        e eVar = new e(callback);
        this.f493c = eVar;
        this.f491a.setWindowCallback(eVar);
        toolbar.setOnMenuItemClickListener(bVar);
        this.f491a.setWindowTitle(charSequence);
    }

    private Menu x() {
        if (!this.f494d) {
            this.f491a.i(new c(), new d());
            this.f494d = true;
        }
        return this.f491a.l();
    }

    public void A(int i, int i2) {
        this.f491a.x((i & i2) | ((~i2) & this.f491a.j()));
    }

    @Override // androidx.appcompat.app.a
    public boolean g() {
        return this.f491a.d();
    }

    @Override // androidx.appcompat.app.a
    public boolean h() {
        if (this.f491a.u()) {
            this.f491a.collapseActionView();
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.app.a
    public void i(boolean z) {
        if (z == this.e) {
            return;
        }
        this.e = z;
        int size = this.f.size();
        for (int i = 0; i < size; i++) {
            this.f.get(i).a(z);
        }
    }

    @Override // androidx.appcompat.app.a
    public int j() {
        return this.f491a.j();
    }

    @Override // androidx.appcompat.app.a
    public Context k() {
        return this.f491a.q();
    }

    @Override // androidx.appcompat.app.a
    public boolean l() {
        this.f491a.o().removeCallbacks(this.g);
        r.L(this.f491a.o(), this.g);
        return true;
    }

    @Override // androidx.appcompat.app.a
    public void m(Configuration configuration) {
        super.m(configuration);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // androidx.appcompat.app.a
    public void n() {
        this.f491a.o().removeCallbacks(this.g);
    }

    @Override // androidx.appcompat.app.a
    public boolean o(int i, KeyEvent keyEvent) {
        Menu x = x();
        if (x != null) {
            x.setQwertyMode(KeyCharacterMap.load(keyEvent != null ? keyEvent.getDeviceId() : -1).getKeyboardType() != 1);
            return x.performShortcut(i, keyEvent, 0);
        }
        return false;
    }

    @Override // androidx.appcompat.app.a
    public boolean p(KeyEvent keyEvent) {
        if (keyEvent.getAction() == 1) {
            q();
        }
        return true;
    }

    @Override // androidx.appcompat.app.a
    public boolean q() {
        return this.f491a.e();
    }

    @Override // androidx.appcompat.app.a
    public void r(boolean z) {
    }

    @Override // androidx.appcompat.app.a
    public void s(boolean z) {
        A(z ? 4 : 0, 4);
    }

    @Override // androidx.appcompat.app.a
    public void t(boolean z) {
    }

    @Override // androidx.appcompat.app.a
    public void u(boolean z) {
    }

    @Override // androidx.appcompat.app.a
    public void v(CharSequence charSequence) {
        this.f491a.setWindowTitle(charSequence);
    }

    public Window.Callback y() {
        return this.f493c;
    }

    void z() {
        Menu x = x();
        androidx.appcompat.view.menu.h hVar = x instanceof androidx.appcompat.view.menu.h ? (androidx.appcompat.view.menu.h) x : null;
        if (hVar != null) {
            hVar.d0();
        }
        try {
            x.clear();
            if (!this.f493c.onCreatePanelMenu(0, x) || !this.f493c.onPreparePanel(0, null, x)) {
                x.clear();
            }
        } finally {
            if (hVar != null) {
                hVar.c0();
            }
        }
    }
}
