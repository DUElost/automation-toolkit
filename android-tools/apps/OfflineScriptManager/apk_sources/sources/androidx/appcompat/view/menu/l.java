package androidx.appcompat.view.menu;

import a.f.l.b;
import android.content.Context;
import android.view.ActionProvider;
import android.view.MenuItem;
import android.view.View;
import androidx.appcompat.view.menu.k;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class l extends k {

    /* loaded from: classes.dex */
    class a extends k.a implements ActionProvider.VisibilityListener {

        /* renamed from: d  reason: collision with root package name */
        b.InterfaceC0012b f574d;

        public a(l lVar, Context context, ActionProvider actionProvider) {
            super(context, actionProvider);
        }

        @Override // a.f.l.b
        public boolean b() {
            return this.f569b.isVisible();
        }

        @Override // a.f.l.b
        public View d(MenuItem menuItem) {
            return this.f569b.onCreateActionView(menuItem);
        }

        @Override // a.f.l.b
        public boolean g() {
            return this.f569b.overridesItemVisibility();
        }

        @Override // a.f.l.b
        public void j(b.InterfaceC0012b interfaceC0012b) {
            this.f574d = interfaceC0012b;
            this.f569b.setVisibilityListener(interfaceC0012b != null ? this : null);
        }

        @Override // android.view.ActionProvider.VisibilityListener
        public void onActionProviderVisibilityChanged(boolean z) {
            b.InterfaceC0012b interfaceC0012b = this.f574d;
            if (interfaceC0012b != null) {
                interfaceC0012b.onActionProviderVisibilityChanged(z);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public l(Context context, a.f.f.a.b bVar) {
        super(context, bVar);
    }

    @Override // androidx.appcompat.view.menu.k
    k.a h(ActionProvider actionProvider) {
        return new a(this, this.f534b, actionProvider);
    }
}
