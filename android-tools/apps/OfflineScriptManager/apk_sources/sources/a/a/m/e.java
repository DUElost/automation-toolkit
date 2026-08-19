package a.a.m;

import a.a.m.b;
import android.content.Context;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.widget.ActionBarContextView;
import java.lang.ref.WeakReference;
/* loaded from: classes.dex */
public class e extends b implements h.a {

    /* renamed from: d  reason: collision with root package name */
    private Context f29d;
    private ActionBarContextView e;
    private b.a f;
    private WeakReference<View> g;
    private boolean h;
    private androidx.appcompat.view.menu.h i;

    public e(Context context, ActionBarContextView actionBarContextView, b.a aVar, boolean z) {
        this.f29d = context;
        this.e = actionBarContextView;
        this.f = aVar;
        androidx.appcompat.view.menu.h hVar = new androidx.appcompat.view.menu.h(actionBarContextView.getContext());
        hVar.S(1);
        this.i = hVar;
        hVar.R(this);
    }

    @Override // androidx.appcompat.view.menu.h.a
    public boolean a(androidx.appcompat.view.menu.h hVar, MenuItem menuItem) {
        return this.f.b(this, menuItem);
    }

    @Override // androidx.appcompat.view.menu.h.a
    public void b(androidx.appcompat.view.menu.h hVar) {
        k();
        this.e.l();
    }

    @Override // a.a.m.b
    public void c() {
        if (this.h) {
            return;
        }
        this.h = true;
        this.e.sendAccessibilityEvent(32);
        this.f.d(this);
    }

    @Override // a.a.m.b
    public View d() {
        WeakReference<View> weakReference = this.g;
        if (weakReference != null) {
            return weakReference.get();
        }
        return null;
    }

    @Override // a.a.m.b
    public Menu e() {
        return this.i;
    }

    @Override // a.a.m.b
    public MenuInflater f() {
        return new g(this.e.getContext());
    }

    @Override // a.a.m.b
    public CharSequence g() {
        return this.e.getSubtitle();
    }

    @Override // a.a.m.b
    public CharSequence i() {
        return this.e.getTitle();
    }

    @Override // a.a.m.b
    public void k() {
        this.f.a(this, this.i);
    }

    @Override // a.a.m.b
    public boolean l() {
        return this.e.j();
    }

    @Override // a.a.m.b
    public void m(View view) {
        this.e.setCustomView(view);
        this.g = view != null ? new WeakReference<>(view) : null;
    }

    @Override // a.a.m.b
    public void n(int i) {
        o(this.f29d.getString(i));
    }

    @Override // a.a.m.b
    public void o(CharSequence charSequence) {
        this.e.setSubtitle(charSequence);
    }

    @Override // a.a.m.b
    public void q(int i) {
        r(this.f29d.getString(i));
    }

    @Override // a.a.m.b
    public void r(CharSequence charSequence) {
        this.e.setTitle(charSequence);
    }

    @Override // a.a.m.b
    public void s(boolean z) {
        super.s(z);
        this.e.setTitleOptional(z);
    }
}
