package androidx.appcompat.view.menu;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.Menu;
import android.view.MenuItem;
import android.view.SubMenu;
import android.view.View;
import androidx.appcompat.view.menu.h;
/* loaded from: classes.dex */
public class u extends h implements SubMenu {
    private h B;
    private j C;

    public u(Context context, h hVar, j jVar) {
        super(context);
        this.B = hVar;
        this.C = jVar;
    }

    @Override // androidx.appcompat.view.menu.h
    public h D() {
        return this.B.D();
    }

    @Override // androidx.appcompat.view.menu.h
    public boolean F() {
        return this.B.F();
    }

    @Override // androidx.appcompat.view.menu.h
    public boolean G() {
        return this.B.G();
    }

    @Override // androidx.appcompat.view.menu.h
    public boolean H() {
        return this.B.H();
    }

    @Override // androidx.appcompat.view.menu.h
    public void R(h.a aVar) {
        this.B.R(aVar);
    }

    public Menu e0() {
        return this.B;
    }

    @Override // androidx.appcompat.view.menu.h
    public boolean f(j jVar) {
        return this.B.f(jVar);
    }

    @Override // android.view.SubMenu
    public MenuItem getItem() {
        return this.C;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    @Override // androidx.appcompat.view.menu.h
    public boolean h(h hVar, MenuItem menuItem) {
        return super.h(hVar, menuItem) || this.B.h(hVar, menuItem);
    }

    @Override // androidx.appcompat.view.menu.h
    public boolean k(j jVar) {
        return this.B.k(jVar);
    }

    @Override // androidx.appcompat.view.menu.h, android.view.Menu
    public void setGroupDividerEnabled(boolean z) {
        this.B.setGroupDividerEnabled(z);
    }

    @Override // android.view.SubMenu
    public SubMenu setHeaderIcon(int i) {
        super.U(i);
        return this;
    }

    @Override // android.view.SubMenu
    public SubMenu setHeaderIcon(Drawable drawable) {
        super.V(drawable);
        return this;
    }

    @Override // android.view.SubMenu
    public SubMenu setHeaderTitle(int i) {
        super.X(i);
        return this;
    }

    @Override // android.view.SubMenu
    public SubMenu setHeaderTitle(CharSequence charSequence) {
        super.Y(charSequence);
        return this;
    }

    @Override // android.view.SubMenu
    public SubMenu setHeaderView(View view) {
        super.Z(view);
        return this;
    }

    @Override // android.view.SubMenu
    public SubMenu setIcon(int i) {
        this.C.setIcon(i);
        return this;
    }

    @Override // android.view.SubMenu
    public SubMenu setIcon(Drawable drawable) {
        this.C.setIcon(drawable);
        return this;
    }

    @Override // androidx.appcompat.view.menu.h, android.view.Menu
    public void setQwertyMode(boolean z) {
        this.B.setQwertyMode(z);
    }

    @Override // androidx.appcompat.view.menu.h
    public String t() {
        j jVar = this.C;
        int itemId = jVar != null ? jVar.getItemId() : 0;
        if (itemId == 0) {
            return null;
        }
        return super.t() + ":" + itemId;
    }
}
