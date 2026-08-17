package androidx.appcompat.view.menu;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.BaseAdapter;
import android.widget.ListAdapter;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.view.menu.p;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class f implements o, AdapterView.OnItemClickListener {

    /* renamed from: b  reason: collision with root package name */
    Context f549b;

    /* renamed from: c  reason: collision with root package name */
    LayoutInflater f550c;

    /* renamed from: d  reason: collision with root package name */
    h f551d;
    ExpandedMenuView e;
    int f;
    int g;
    int h;
    private o.a i;
    a j;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class a extends BaseAdapter {

        /* renamed from: b  reason: collision with root package name */
        private int f552b = -1;

        public a() {
            a();
        }

        void a() {
            j v = f.this.f551d.v();
            if (v != null) {
                ArrayList<j> z = f.this.f551d.z();
                int size = z.size();
                for (int i = 0; i < size; i++) {
                    if (z.get(i) == v) {
                        this.f552b = i;
                        return;
                    }
                }
            }
            this.f552b = -1;
        }

        @Override // android.widget.Adapter
        /* renamed from: b */
        public j getItem(int i) {
            ArrayList<j> z = f.this.f551d.z();
            int i2 = i + f.this.f;
            int i3 = this.f552b;
            if (i3 >= 0 && i2 >= i3) {
                i2++;
            }
            return z.get(i2);
        }

        @Override // android.widget.Adapter
        public int getCount() {
            int size = f.this.f551d.z().size() - f.this.f;
            return this.f552b < 0 ? size : size - 1;
        }

        @Override // android.widget.Adapter
        public long getItemId(int i) {
            return i;
        }

        @Override // android.widget.Adapter
        public View getView(int i, View view, ViewGroup viewGroup) {
            if (view == null) {
                f fVar = f.this;
                view = fVar.f550c.inflate(fVar.h, viewGroup, false);
            }
            ((p.a) view).e(getItem(i), 0);
            return view;
        }

        @Override // android.widget.BaseAdapter
        public void notifyDataSetChanged() {
            a();
            super.notifyDataSetChanged();
        }
    }

    public f(int i, int i2) {
        this.h = i;
        this.g = i2;
    }

    public f(Context context, int i) {
        this(i, 0);
        this.f549b = context;
        this.f550c = LayoutInflater.from(context);
    }

    public ListAdapter a() {
        if (this.j == null) {
            this.j = new a();
        }
        return this.j;
    }

    @Override // androidx.appcompat.view.menu.o
    public void b(h hVar, boolean z) {
        o.a aVar = this.i;
        if (aVar != null) {
            aVar.b(hVar, z);
        }
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean c() {
        return false;
    }

    /* JADX WARN: Removed duplicated region for block: B:13:0x0029  */
    /* JADX WARN: Removed duplicated region for block: B:15:? A[RETURN, SYNTHETIC] */
    @Override // androidx.appcompat.view.menu.o
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void d(android.content.Context r3, androidx.appcompat.view.menu.h r4) {
        /*
            r2 = this;
            int r0 = r2.g
            if (r0 == 0) goto L14
            android.view.ContextThemeWrapper r0 = new android.view.ContextThemeWrapper
            int r1 = r2.g
            r0.<init>(r3, r1)
            r2.f549b = r0
            android.view.LayoutInflater r3 = android.view.LayoutInflater.from(r0)
        L11:
            r2.f550c = r3
            goto L23
        L14:
            android.content.Context r0 = r2.f549b
            if (r0 == 0) goto L23
            r2.f549b = r3
            android.view.LayoutInflater r0 = r2.f550c
            if (r0 != 0) goto L23
            android.view.LayoutInflater r3 = android.view.LayoutInflater.from(r3)
            goto L11
        L23:
            r2.f551d = r4
            androidx.appcompat.view.menu.f$a r3 = r2.j
            if (r3 == 0) goto L2c
            r3.notifyDataSetChanged()
        L2c:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.view.menu.f.d(android.content.Context, androidx.appcompat.view.menu.h):void");
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean e(h hVar, j jVar) {
        return false;
    }

    public p f(ViewGroup viewGroup) {
        if (this.e == null) {
            this.e = (ExpandedMenuView) this.f550c.inflate(a.a.g.abc_expanded_menu_layout, viewGroup, false);
            if (this.j == null) {
                this.j = new a();
            }
            this.e.setAdapter((ListAdapter) this.j);
            this.e.setOnItemClickListener(this);
        }
        return this.e;
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean h(h hVar, j jVar) {
        return false;
    }

    @Override // androidx.appcompat.view.menu.o
    public void i(o.a aVar) {
        this.i = aVar;
    }

    @Override // androidx.appcompat.view.menu.o
    public boolean j(u uVar) {
        if (uVar.hasVisibleItems()) {
            new i(uVar).d(null);
            o.a aVar = this.i;
            if (aVar != null) {
                aVar.c(uVar);
                return true;
            }
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.view.menu.o
    public void k(boolean z) {
        a aVar = this.j;
        if (aVar != null) {
            aVar.notifyDataSetChanged();
        }
    }

    @Override // android.widget.AdapterView.OnItemClickListener
    public void onItemClick(AdapterView<?> adapterView, View view, int i, long j) {
        this.f551d.M(this.j.getItem(i), this, 0);
    }
}
