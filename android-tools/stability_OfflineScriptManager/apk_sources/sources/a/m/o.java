package a.m;

import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
import java.util.Iterator;
/* loaded from: classes.dex */
public class o {

    /* renamed from: a  reason: collision with root package name */
    private static m f303a = new b();

    /* renamed from: b  reason: collision with root package name */
    private static ThreadLocal<WeakReference<a.d.a<ViewGroup, ArrayList<m>>>> f304b = new ThreadLocal<>();

    /* renamed from: c  reason: collision with root package name */
    static ArrayList<ViewGroup> f305c = new ArrayList<>();

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class a implements ViewTreeObserver.OnPreDrawListener, View.OnAttachStateChangeListener {

        /* renamed from: b  reason: collision with root package name */
        m f306b;

        /* renamed from: c  reason: collision with root package name */
        ViewGroup f307c;

        /* renamed from: a.m.o$a$a  reason: collision with other inner class name */
        /* loaded from: classes.dex */
        class C0018a extends n {

            /* renamed from: a  reason: collision with root package name */
            final /* synthetic */ a.d.a f308a;

            C0018a(a.d.a aVar) {
                this.f308a = aVar;
            }

            @Override // a.m.m.f
            public void d(m mVar) {
                ((ArrayList) this.f308a.get(a.this.f307c)).remove(mVar);
            }
        }

        a(m mVar, ViewGroup viewGroup) {
            this.f306b = mVar;
            this.f307c = viewGroup;
        }

        private void a() {
            this.f307c.getViewTreeObserver().removeOnPreDrawListener(this);
            this.f307c.removeOnAttachStateChangeListener(this);
        }

        @Override // android.view.ViewTreeObserver.OnPreDrawListener
        public boolean onPreDraw() {
            a();
            if (o.f305c.remove(this.f307c)) {
                a.d.a<ViewGroup, ArrayList<m>> b2 = o.b();
                ArrayList<m> arrayList = b2.get(this.f307c);
                ArrayList arrayList2 = null;
                if (arrayList == null) {
                    arrayList = new ArrayList<>();
                    b2.put(this.f307c, arrayList);
                } else if (arrayList.size() > 0) {
                    arrayList2 = new ArrayList(arrayList);
                }
                arrayList.add(this.f306b);
                this.f306b.a(new C0018a(b2));
                this.f306b.j(this.f307c, false);
                if (arrayList2 != null) {
                    Iterator it = arrayList2.iterator();
                    while (it.hasNext()) {
                        ((m) it.next()).Q(this.f307c);
                    }
                }
                this.f306b.N(this.f307c);
                return true;
            }
            return true;
        }

        @Override // android.view.View.OnAttachStateChangeListener
        public void onViewAttachedToWindow(View view) {
        }

        @Override // android.view.View.OnAttachStateChangeListener
        public void onViewDetachedFromWindow(View view) {
            a();
            o.f305c.remove(this.f307c);
            ArrayList<m> arrayList = o.b().get(this.f307c);
            if (arrayList != null && arrayList.size() > 0) {
                Iterator<m> it = arrayList.iterator();
                while (it.hasNext()) {
                    it.next().Q(this.f307c);
                }
            }
            this.f306b.k(true);
        }
    }

    public static void a(ViewGroup viewGroup, m mVar) {
        if (f305c.contains(viewGroup) || !a.f.l.r.E(viewGroup)) {
            return;
        }
        f305c.add(viewGroup);
        if (mVar == null) {
            mVar = f303a;
        }
        m clone = mVar.clone();
        d(viewGroup, clone);
        l.c(viewGroup, null);
        c(viewGroup, clone);
    }

    static a.d.a<ViewGroup, ArrayList<m>> b() {
        a.d.a<ViewGroup, ArrayList<m>> aVar;
        WeakReference<a.d.a<ViewGroup, ArrayList<m>>> weakReference = f304b.get();
        if (weakReference == null || (aVar = weakReference.get()) == null) {
            a.d.a<ViewGroup, ArrayList<m>> aVar2 = new a.d.a<>();
            f304b.set(new WeakReference<>(aVar2));
            return aVar2;
        }
        return aVar;
    }

    private static void c(ViewGroup viewGroup, m mVar) {
        if (mVar == null || viewGroup == null) {
            return;
        }
        a aVar = new a(mVar, viewGroup);
        viewGroup.addOnAttachStateChangeListener(aVar);
        viewGroup.getViewTreeObserver().addOnPreDrawListener(aVar);
    }

    private static void d(ViewGroup viewGroup, m mVar) {
        ArrayList<m> arrayList = b().get(viewGroup);
        if (arrayList != null && arrayList.size() > 0) {
            Iterator<m> it = arrayList.iterator();
            while (it.hasNext()) {
                it.next().M(viewGroup);
            }
        }
        if (mVar != null) {
            mVar.j(viewGroup, true);
        }
        l b2 = l.b(viewGroup);
        if (b2 != null) {
            b2.a();
        }
    }
}
