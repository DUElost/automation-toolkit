package androidx.appcompat.view.menu;

import android.content.Context;
import android.view.MenuItem;
import android.view.SubMenu;
import java.util.Iterator;
import java.util.Map;
/* loaded from: classes.dex */
abstract class c<T> extends d<T> {

    /* renamed from: b  reason: collision with root package name */
    final Context f534b;

    /* renamed from: c  reason: collision with root package name */
    private Map<a.f.f.a.b, MenuItem> f535c;

    /* renamed from: d  reason: collision with root package name */
    private Map<a.f.f.a.c, SubMenu> f536d;

    /* JADX INFO: Access modifiers changed from: package-private */
    public c(Context context, T t) {
        super(t);
        this.f534b = context;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final MenuItem c(MenuItem menuItem) {
        if (menuItem instanceof a.f.f.a.b) {
            a.f.f.a.b bVar = (a.f.f.a.b) menuItem;
            if (this.f535c == null) {
                this.f535c = new a.d.a();
            }
            MenuItem menuItem2 = this.f535c.get(menuItem);
            if (menuItem2 == null) {
                MenuItem b2 = q.b(this.f534b, bVar);
                this.f535c.put(bVar, b2);
                return b2;
            }
            return menuItem2;
        }
        return menuItem;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final SubMenu d(SubMenu subMenu) {
        if (subMenu instanceof a.f.f.a.c) {
            a.f.f.a.c cVar = (a.f.f.a.c) subMenu;
            if (this.f536d == null) {
                this.f536d = new a.d.a();
            }
            SubMenu subMenu2 = this.f536d.get(cVar);
            if (subMenu2 == null) {
                SubMenu c2 = q.c(this.f534b, cVar);
                this.f536d.put(cVar, c2);
                return c2;
            }
            return subMenu2;
        }
        return subMenu;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void e() {
        Map<a.f.f.a.b, MenuItem> map = this.f535c;
        if (map != null) {
            map.clear();
        }
        Map<a.f.f.a.c, SubMenu> map2 = this.f536d;
        if (map2 != null) {
            map2.clear();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void f(int i) {
        Map<a.f.f.a.b, MenuItem> map = this.f535c;
        if (map == null) {
            return;
        }
        Iterator<a.f.f.a.b> it = map.keySet().iterator();
        while (it.hasNext()) {
            if (i == it.next().getGroupId()) {
                it.remove();
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void g(int i) {
        Map<a.f.f.a.b, MenuItem> map = this.f535c;
        if (map == null) {
            return;
        }
        Iterator<a.f.f.a.b> it = map.keySet().iterator();
        while (it.hasNext()) {
            if (i == it.next().getItemId()) {
                it.remove();
                return;
            }
        }
    }
}
