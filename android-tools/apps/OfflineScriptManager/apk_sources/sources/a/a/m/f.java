package a.a.m;

import a.a.m.b;
import android.content.Context;
import android.view.ActionMode;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import androidx.appcompat.view.menu.q;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class f extends ActionMode {

    /* renamed from: a  reason: collision with root package name */
    final Context f30a;

    /* renamed from: b  reason: collision with root package name */
    final b f31b;

    /* loaded from: classes.dex */
    public static class a implements b.a {

        /* renamed from: a  reason: collision with root package name */
        final ActionMode.Callback f32a;

        /* renamed from: b  reason: collision with root package name */
        final Context f33b;

        /* renamed from: c  reason: collision with root package name */
        final ArrayList<f> f34c = new ArrayList<>();

        /* renamed from: d  reason: collision with root package name */
        final a.d.g<Menu, Menu> f35d = new a.d.g<>();

        public a(Context context, ActionMode.Callback callback) {
            this.f33b = context;
            this.f32a = callback;
        }

        private Menu f(Menu menu) {
            Menu menu2 = this.f35d.get(menu);
            if (menu2 == null) {
                Menu a2 = q.a(this.f33b, (a.f.f.a.a) menu);
                this.f35d.put(menu, a2);
                return a2;
            }
            return menu2;
        }

        @Override // a.a.m.b.a
        public boolean a(b bVar, Menu menu) {
            return this.f32a.onPrepareActionMode(e(bVar), f(menu));
        }

        @Override // a.a.m.b.a
        public boolean b(b bVar, MenuItem menuItem) {
            return this.f32a.onActionItemClicked(e(bVar), q.b(this.f33b, (a.f.f.a.b) menuItem));
        }

        @Override // a.a.m.b.a
        public boolean c(b bVar, Menu menu) {
            return this.f32a.onCreateActionMode(e(bVar), f(menu));
        }

        @Override // a.a.m.b.a
        public void d(b bVar) {
            this.f32a.onDestroyActionMode(e(bVar));
        }

        public ActionMode e(b bVar) {
            int size = this.f34c.size();
            for (int i = 0; i < size; i++) {
                f fVar = this.f34c.get(i);
                if (fVar != null && fVar.f31b == bVar) {
                    return fVar;
                }
            }
            f fVar2 = new f(this.f33b, bVar);
            this.f34c.add(fVar2);
            return fVar2;
        }
    }

    public f(Context context, b bVar) {
        this.f30a = context;
        this.f31b = bVar;
    }

    @Override // android.view.ActionMode
    public void finish() {
        this.f31b.c();
    }

    @Override // android.view.ActionMode
    public View getCustomView() {
        return this.f31b.d();
    }

    @Override // android.view.ActionMode
    public Menu getMenu() {
        return q.a(this.f30a, (a.f.f.a.a) this.f31b.e());
    }

    @Override // android.view.ActionMode
    public MenuInflater getMenuInflater() {
        return this.f31b.f();
    }

    @Override // android.view.ActionMode
    public CharSequence getSubtitle() {
        return this.f31b.g();
    }

    @Override // android.view.ActionMode
    public Object getTag() {
        return this.f31b.h();
    }

    @Override // android.view.ActionMode
    public CharSequence getTitle() {
        return this.f31b.i();
    }

    @Override // android.view.ActionMode
    public boolean getTitleOptionalHint() {
        return this.f31b.j();
    }

    @Override // android.view.ActionMode
    public void invalidate() {
        this.f31b.k();
    }

    @Override // android.view.ActionMode
    public boolean isTitleOptional() {
        return this.f31b.l();
    }

    @Override // android.view.ActionMode
    public void setCustomView(View view) {
        this.f31b.m(view);
    }

    @Override // android.view.ActionMode
    public void setSubtitle(int i) {
        this.f31b.n(i);
    }

    @Override // android.view.ActionMode
    public void setSubtitle(CharSequence charSequence) {
        this.f31b.o(charSequence);
    }

    @Override // android.view.ActionMode
    public void setTag(Object obj) {
        this.f31b.p(obj);
    }

    @Override // android.view.ActionMode
    public void setTitle(int i) {
        this.f31b.q(i);
    }

    @Override // android.view.ActionMode
    public void setTitle(CharSequence charSequence) {
        this.f31b.r(charSequence);
    }

    @Override // android.view.ActionMode
    public void setTitleOptionalHint(boolean z) {
        this.f31b.s(z);
    }
}
