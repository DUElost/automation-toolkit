package com.jude.easyrecyclerview.d;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Objects;
/* loaded from: classes.dex */
public abstract class d<T> extends RecyclerView.g<com.jude.easyrecyclerview.d.a> {

    /* renamed from: c  reason: collision with root package name */
    private List<T> f2475c;

    /* renamed from: d  reason: collision with root package name */
    private com.jude.easyrecyclerview.d.c f2476d;
    private InterfaceC0100d g;
    private e h;
    private Context k;
    ArrayList<c> e = new ArrayList<>();
    ArrayList<c> f = new ArrayList<>();
    private final Object i = new Object();
    private boolean j = true;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a implements View.OnClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ com.jude.easyrecyclerview.d.a f2477b;

        a(com.jude.easyrecyclerview.d.a aVar) {
            this.f2477b = aVar;
        }

        @Override // android.view.View.OnClickListener
        public void onClick(View view) {
            d.this.g.a(this.f2477b.j() - d.this.e.size());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b implements View.OnLongClickListener {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ com.jude.easyrecyclerview.d.a f2479b;

        b(com.jude.easyrecyclerview.d.a aVar) {
            this.f2479b = aVar;
        }

        @Override // android.view.View.OnLongClickListener
        public boolean onLongClick(View view) {
            return d.this.h.a(this.f2479b.j() - d.this.e.size());
        }
    }

    /* loaded from: classes.dex */
    public interface c {
        View a(ViewGroup viewGroup);

        void b(View view);
    }

    /* renamed from: com.jude.easyrecyclerview.d.d$d  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public interface InterfaceC0100d {
        void a(int i);
    }

    /* loaded from: classes.dex */
    public interface e {
        boolean a(int i);
    }

    /* loaded from: classes.dex */
    public interface f {
        void a();
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class g extends com.jude.easyrecyclerview.d.a {
        public g(d dVar, View view) {
            super(view);
        }
    }

    public d(Context context) {
        J(context, new ArrayList());
    }

    /* JADX WARN: Code restructure failed: missing block: B:8:0x0026, code lost:
        r6.g(true);
        r5.setLayoutParams(r6);
     */
    /* JADX WARN: Code restructure failed: missing block: B:9:0x002c, code lost:
        return r5;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private android.view.View D(android.view.ViewGroup r5, int r6) {
        /*
            r4 = this;
            java.util.ArrayList<com.jude.easyrecyclerview.d.d$c> r0 = r4.e
            java.util.Iterator r0 = r0.iterator()
        L6:
            boolean r1 = r0.hasNext()
            r2 = 1
            if (r1 == 0) goto L2d
            java.lang.Object r1 = r0.next()
            com.jude.easyrecyclerview.d.d$c r1 = (com.jude.easyrecyclerview.d.d.c) r1
            int r3 = r1.hashCode()
            if (r3 != r6) goto L6
            android.view.View r5 = r1.a(r5)
            androidx.recyclerview.widget.StaggeredGridLayoutManager$c r6 = new androidx.recyclerview.widget.StaggeredGridLayoutManager$c
            android.view.ViewGroup$LayoutParams r0 = r5.getLayoutParams()
            r6.<init>(r0)
        L26:
            r6.g(r2)
            r5.setLayoutParams(r6)
            return r5
        L2d:
            java.util.ArrayList<com.jude.easyrecyclerview.d.d$c> r0 = r4.f
            java.util.Iterator r0 = r0.iterator()
        L33:
            boolean r1 = r0.hasNext()
            if (r1 == 0) goto L53
            java.lang.Object r1 = r0.next()
            com.jude.easyrecyclerview.d.d$c r1 = (com.jude.easyrecyclerview.d.d.c) r1
            int r3 = r1.hashCode()
            if (r3 != r6) goto L33
            android.view.View r5 = r1.a(r5)
            androidx.recyclerview.widget.StaggeredGridLayoutManager$c r6 = new androidx.recyclerview.widget.StaggeredGridLayoutManager$c
            android.view.ViewGroup$LayoutParams r0 = r5.getLayoutParams()
            r6.<init>(r0)
            goto L26
        L53:
            r5 = 0
            return r5
        */
        throw new UnsupportedOperationException("Method not decompiled: com.jude.easyrecyclerview.d.d.D(android.view.ViewGroup, int):android.view.View");
    }

    private void J(Context context, List<T> list) {
        this.k = context;
        this.f2475c = list;
    }

    public void A(Collection<? extends T> collection) {
        com.jude.easyrecyclerview.d.c cVar = this.f2476d;
        if (cVar != null) {
            cVar.a(collection == null ? 0 : collection.size());
        }
        if (collection != null && collection.size() != 0) {
            synchronized (this.i) {
                this.f2475c.addAll(collection);
            }
        }
        if (this.j) {
            g();
        }
    }

    public void B(c cVar) {
        Objects.requireNonNull(cVar, "ItemView can't be null");
        this.f.add(cVar);
    }

    public void C() {
        com.jude.easyrecyclerview.d.c cVar = this.f2476d;
        if (cVar != null) {
            cVar.clear();
        }
        synchronized (this.i) {
            this.f2475c.clear();
        }
        if (this.j) {
            g();
        }
    }

    public Context E() {
        return this.k;
    }

    public int F() {
        return this.f2475c.size();
    }

    com.jude.easyrecyclerview.d.c G() {
        if (this.f2476d == null) {
            this.f2476d = new com.jude.easyrecyclerview.d.b(this);
        }
        return this.f2476d;
    }

    public T H(int i) {
        return this.f2475c.get(i);
    }

    public int I(int i) {
        return 0;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: K */
    public final void l(com.jude.easyrecyclerview.d.a aVar, int i) {
        aVar.f1123b.setId(i);
        if (this.e.size() != 0 && i < this.e.size()) {
            this.e.get(i).b(aVar.f1123b);
            return;
        }
        int size = (i - this.e.size()) - this.f2475c.size();
        if (this.f.size() == 0 || size < 0) {
            v(aVar, i - this.e.size());
        } else {
            this.f.get(size).b(aVar.f1123b);
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    /* renamed from: L */
    public final com.jude.easyrecyclerview.d.a n(ViewGroup viewGroup, int i) {
        View D = D(viewGroup, i);
        if (D != null) {
            return new g(this, D);
        }
        com.jude.easyrecyclerview.d.a w = w(viewGroup, i);
        if (this.g != null) {
            w.f1123b.setOnClickListener(new a(w));
        }
        if (this.h != null) {
            w.f1123b.setOnLongClickListener(new b(w));
        }
        return w;
    }

    public void M() {
        com.jude.easyrecyclerview.d.c cVar = this.f2476d;
        Objects.requireNonNull(cVar, "You should invoking setLoadMore() first");
        cVar.e();
    }

    public void N(int i) {
        synchronized (this.i) {
            this.f2475c.remove(i);
        }
        if (this.j) {
            g();
        }
    }

    public void O() {
        com.jude.easyrecyclerview.d.c cVar = this.f2476d;
        Objects.requireNonNull(cVar, "You should invoking setLoadMore() first");
        cVar.d();
    }

    public View P(int i) {
        FrameLayout frameLayout = new FrameLayout(E());
        frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
        LayoutInflater.from(E()).inflate(i, frameLayout);
        G().c(frameLayout);
        return frameLayout;
    }

    public View Q(int i, f fVar) {
        FrameLayout frameLayout = new FrameLayout(E());
        frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
        LayoutInflater.from(E()).inflate(i, frameLayout);
        G().f(frameLayout, fVar);
        return frameLayout;
    }

    public View R(int i) {
        FrameLayout frameLayout = new FrameLayout(E());
        frameLayout.setLayoutParams(new ViewGroup.LayoutParams(-1, -2));
        LayoutInflater.from(E()).inflate(i, frameLayout);
        G().b(frameLayout);
        return frameLayout;
    }

    public void S(InterfaceC0100d interfaceC0100d) {
        this.g = interfaceC0100d;
    }

    public void T(e eVar) {
        this.h = eVar;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    @Deprecated
    public final int c() {
        return this.f2475c.size() + this.e.size() + this.f.size();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    public long d(int i) {
        return i;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.g
    @Deprecated
    public final int e(int i) {
        int size;
        return (this.e.size() == 0 || i >= this.e.size()) ? (this.f.size() == 0 || (size = (i - this.e.size()) - this.f2475c.size()) < 0) ? I(i - this.e.size()) : this.f.get(size).hashCode() : this.e.get(i).hashCode();
    }

    public void v(com.jude.easyrecyclerview.d.a aVar, int i) {
        aVar.N(H(i));
    }

    public abstract com.jude.easyrecyclerview.d.a w(ViewGroup viewGroup, int i);

    public void z(T t) {
        com.jude.easyrecyclerview.d.c cVar = this.f2476d;
        if (cVar != null) {
            cVar.a(t == null ? 0 : 1);
        }
        if (t != null) {
            synchronized (this.i) {
                this.f2475c.add(t);
            }
        }
        if (this.j) {
            g();
        }
    }
}
