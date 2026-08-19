package androidx.appcompat.view.menu;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.view.menu.p;
import java.util.ArrayList;
/* loaded from: classes.dex */
public abstract class b implements o {

    /* renamed from: b  reason: collision with root package name */
    protected Context f531b;

    /* renamed from: c  reason: collision with root package name */
    protected Context f532c;

    /* renamed from: d  reason: collision with root package name */
    protected h f533d;
    protected LayoutInflater e;
    private o.a f;
    private int g;
    private int h;
    protected p i;

    public b(Context context, int i, int i2) {
        this.f531b = context;
        this.e = LayoutInflater.from(context);
        this.g = i;
        this.h = i2;
    }

    protected void a(View view, int i) {
        ViewGroup viewGroup = (ViewGroup) view.getParent();
        if (viewGroup != null) {
            viewGroup.removeView(view);
        }
        ((ViewGroup) this.i).addView(view, i);
    }

    @Override // androidx.appcompat.view.menu.o
    public void b(h hVar, boolean z) {
        o.a aVar = this.f;
        if (aVar != null) {
            aVar.b(hVar, z);
        }
    }

    @Override // androidx.appcompat.view.menu.o
    public void d(Context context, h hVar) {
        this.f532c = context;
        LayoutInflater.from(context);
        this.f533d = hVar;
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean e(h hVar, j jVar) {
        return false;
    }

    public abstract void f(j jVar, p.a aVar);

    public p.a g(ViewGroup viewGroup) {
        return (p.a) this.e.inflate(this.h, viewGroup, false);
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean h(h hVar, j jVar) {
        return false;
    }

    @Override // androidx.appcompat.view.menu.o
    public void i(o.a aVar) {
        this.f = aVar;
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean j(u uVar) {
        o.a aVar = this.f;
        if (aVar != null) {
            return aVar.c(uVar);
        }
        return false;
    }

    @Override // androidx.appcompat.view.menu.o
    public void k(boolean z) {
        ViewGroup viewGroup = (ViewGroup) this.i;
        if (viewGroup == null) {
            return;
        }
        h hVar = this.f533d;
        int i = 0;
        if (hVar != null) {
            hVar.r();
            ArrayList<j> E = this.f533d.E();
            int size = E.size();
            int i2 = 0;
            for (int i3 = 0; i3 < size; i3++) {
                j jVar = E.get(i3);
                if (q(i2, jVar)) {
                    View childAt = viewGroup.getChildAt(i2);
                    j itemData = childAt instanceof p.a ? ((p.a) childAt).getItemData() : null;
                    View n = n(jVar, childAt, viewGroup);
                    if (jVar != itemData) {
                        n.setPressed(false);
                        n.jumpDrawablesToCurrentState();
                    }
                    if (n != childAt) {
                        a(n, i2);
                    }
                    i2++;
                }
            }
            i = i2;
        }
        while (i < viewGroup.getChildCount()) {
            if (!l(viewGroup, i)) {
                i++;
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public boolean l(ViewGroup viewGroup, int i) {
        viewGroup.removeViewAt(i);
        return true;
    }

    public o.a m() {
        return this.f;
    }

    public View n(j jVar, View view, ViewGroup viewGroup) {
        p.a g = view instanceof p.a ? (p.a) view : g(viewGroup);
        f(jVar, g);
        return (View) g;
    }

    public p o(ViewGroup viewGroup) {
        if (this.i == null) {
            p pVar = (p) this.e.inflate(this.g, viewGroup, false);
            this.i = pVar;
            pVar.b(this.f533d);
            k(true);
        }
        return this.i;
    }

    public void p(int i) {
    }

    public abstract boolean q(int i, j jVar);
}
