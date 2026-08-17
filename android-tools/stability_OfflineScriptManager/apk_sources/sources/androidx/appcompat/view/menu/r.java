package androidx.appcompat.view.menu;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.SubMenu;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class r extends c<a.f.f.a.a> implements Menu {
    /* JADX INFO: Access modifiers changed from: package-private */
    public r(Context context, a.f.f.a.a aVar) {
        super(context, aVar);
    }

    @Override // android.view.Menu
    public MenuItem add(int i) {
        return c(((a.f.f.a.a) this.f537a).add(i));
    }

    @Override // android.view.Menu
    public MenuItem add(int i, int i2, int i3, int i4) {
        return c(((a.f.f.a.a) this.f537a).add(i, i2, i3, i4));
    }

    @Override // android.view.Menu
    public MenuItem add(int i, int i2, int i3, CharSequence charSequence) {
        return c(((a.f.f.a.a) this.f537a).add(i, i2, i3, charSequence));
    }

    @Override // android.view.Menu
    public MenuItem add(CharSequence charSequence) {
        return c(((a.f.f.a.a) this.f537a).add(charSequence));
    }

    @Override // android.view.Menu
    public int addIntentOptions(int i, int i2, int i3, ComponentName componentName, Intent[] intentArr, Intent intent, int i4, MenuItem[] menuItemArr) {
        MenuItem[] menuItemArr2 = menuItemArr != null ? new MenuItem[menuItemArr.length] : null;
        int addIntentOptions = ((a.f.f.a.a) this.f537a).addIntentOptions(i, i2, i3, componentName, intentArr, intent, i4, menuItemArr2);
        if (menuItemArr2 != null) {
            int length = menuItemArr2.length;
            for (int i5 = 0; i5 < length; i5++) {
                menuItemArr[i5] = c(menuItemArr2[i5]);
            }
        }
        return addIntentOptions;
    }

    @Override // android.view.Menu
    public SubMenu addSubMenu(int i) {
        return d(((a.f.f.a.a) this.f537a).addSubMenu(i));
    }

    @Override // android.view.Menu
    public SubMenu addSubMenu(int i, int i2, int i3, int i4) {
        return d(((a.f.f.a.a) this.f537a).addSubMenu(i, i2, i3, i4));
    }

    @Override // android.view.Menu
    public SubMenu addSubMenu(int i, int i2, int i3, CharSequence charSequence) {
        return d(((a.f.f.a.a) this.f537a).addSubMenu(i, i2, i3, charSequence));
    }

    @Override // android.view.Menu
    public SubMenu addSubMenu(CharSequence charSequence) {
        return d(((a.f.f.a.a) this.f537a).addSubMenu(charSequence));
    }

    @Override // android.view.Menu
    public void clear() {
        e();
        ((a.f.f.a.a) this.f537a).clear();
    }

    @Override // android.view.Menu
    public void close() {
        ((a.f.f.a.a) this.f537a).close();
    }

    @Override // android.view.Menu
    public MenuItem findItem(int i) {
        return c(((a.f.f.a.a) this.f537a).findItem(i));
    }

    @Override // android.view.Menu
    public MenuItem getItem(int i) {
        return c(((a.f.f.a.a) this.f537a).getItem(i));
    }

    @Override // android.view.Menu
    public boolean hasVisibleItems() {
        return ((a.f.f.a.a) this.f537a).hasVisibleItems();
    }

    @Override // android.view.Menu
    public boolean isShortcutKey(int i, KeyEvent keyEvent) {
        return ((a.f.f.a.a) this.f537a).isShortcutKey(i, keyEvent);
    }

    @Override // android.view.Menu
    public boolean performIdentifierAction(int i, int i2) {
        return ((a.f.f.a.a) this.f537a).performIdentifierAction(i, i2);
    }

    @Override // android.view.Menu
    public boolean performShortcut(int i, KeyEvent keyEvent, int i2) {
        return ((a.f.f.a.a) this.f537a).performShortcut(i, keyEvent, i2);
    }

    @Override // android.view.Menu
    public void removeGroup(int i) {
        f(i);
        ((a.f.f.a.a) this.f537a).removeGroup(i);
    }

    @Override // android.view.Menu
    public void removeItem(int i) {
        g(i);
        ((a.f.f.a.a) this.f537a).removeItem(i);
    }

    @Override // android.view.Menu
    public void setGroupCheckable(int i, boolean z, boolean z2) {
        ((a.f.f.a.a) this.f537a).setGroupCheckable(i, z, z2);
    }

    @Override // android.view.Menu
    public void setGroupEnabled(int i, boolean z) {
        ((a.f.f.a.a) this.f537a).setGroupEnabled(i, z);
    }

    @Override // android.view.Menu
    public void setGroupVisible(int i, boolean z) {
        ((a.f.f.a.a) this.f537a).setGroupVisible(i, z);
    }

    @Override // android.view.Menu
    public void setQwertyMode(boolean z) {
        ((a.f.f.a.a) this.f537a).setQwertyMode(z);
    }

    @Override // android.view.Menu
    public int size() {
        return ((a.f.f.a.a) this.f537a).size();
    }
}
