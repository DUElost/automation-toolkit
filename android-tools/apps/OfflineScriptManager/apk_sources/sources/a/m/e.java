package a.m;

import a.m.m;
import android.graphics.Rect;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class e extends androidx.fragment.app.m {

    /* loaded from: classes.dex */
    class a extends m.e {
        a(e eVar, Rect rect) {
        }
    }

    /* loaded from: classes.dex */
    class b implements m.f {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ View f264a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayList f265b;

        b(e eVar, View view, ArrayList arrayList) {
            this.f264a = view;
            this.f265b = arrayList;
        }

        @Override // a.m.m.f
        public void a(m mVar) {
        }

        @Override // a.m.m.f
        public void b(m mVar) {
        }

        @Override // a.m.m.f
        public void c(m mVar) {
        }

        @Override // a.m.m.f
        public void d(m mVar) {
            mVar.O(this);
            this.f264a.setVisibility(8);
            int size = this.f265b.size();
            for (int i = 0; i < size; i++) {
                ((View) this.f265b.get(i)).setVisibility(0);
            }
        }
    }

    /* loaded from: classes.dex */
    class c implements m.f {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ Object f266a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayList f267b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Object f268c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ ArrayList f269d;
        final /* synthetic */ Object e;
        final /* synthetic */ ArrayList f;

        c(Object obj, ArrayList arrayList, Object obj2, ArrayList arrayList2, Object obj3, ArrayList arrayList3) {
            this.f266a = obj;
            this.f267b = arrayList;
            this.f268c = obj2;
            this.f269d = arrayList2;
            this.e = obj3;
            this.f = arrayList3;
        }

        @Override // a.m.m.f
        public void a(m mVar) {
        }

        @Override // a.m.m.f
        public void b(m mVar) {
        }

        @Override // a.m.m.f
        public void c(m mVar) {
            Object obj = this.f266a;
            if (obj != null) {
                e.this.q(obj, this.f267b, null);
            }
            Object obj2 = this.f268c;
            if (obj2 != null) {
                e.this.q(obj2, this.f269d, null);
            }
            Object obj3 = this.e;
            if (obj3 != null) {
                e.this.q(obj3, this.f, null);
            }
        }

        @Override // a.m.m.f
        public void d(m mVar) {
        }
    }

    /* loaded from: classes.dex */
    class d extends m.e {
        d(e eVar, Rect rect) {
        }
    }

    private static boolean B(m mVar) {
        return (androidx.fragment.app.m.l(mVar.y()) && androidx.fragment.app.m.l(mVar.z()) && androidx.fragment.app.m.l(mVar.A())) ? false : true;
    }

    @Override // androidx.fragment.app.m
    public Object A(Object obj) {
        if (obj == null) {
            return null;
        }
        q qVar = new q();
        qVar.d0((m) obj);
        return qVar;
    }

    @Override // androidx.fragment.app.m
    public void a(Object obj, View view) {
        if (obj != null) {
            ((m) obj).b(view);
        }
    }

    @Override // androidx.fragment.app.m
    public void b(Object obj, ArrayList<View> arrayList) {
        m mVar = (m) obj;
        if (mVar == null) {
            return;
        }
        int i = 0;
        if (mVar instanceof q) {
            q qVar = (q) mVar;
            int f0 = qVar.f0();
            while (i < f0) {
                b(qVar.e0(i), arrayList);
                i++;
            }
        } else if (B(mVar) || !androidx.fragment.app.m.l(mVar.B())) {
        } else {
            int size = arrayList.size();
            while (i < size) {
                mVar.b(arrayList.get(i));
                i++;
            }
        }
    }

    @Override // androidx.fragment.app.m
    public void c(ViewGroup viewGroup, Object obj) {
        o.a(viewGroup, (m) obj);
    }

    @Override // androidx.fragment.app.m
    public boolean e(Object obj) {
        return obj instanceof m;
    }

    @Override // androidx.fragment.app.m
    public Object g(Object obj) {
        if (obj != null) {
            return ((m) obj).clone();
        }
        return null;
    }

    @Override // androidx.fragment.app.m
    public Object m(Object obj, Object obj2, Object obj3) {
        m mVar = (m) obj;
        m mVar2 = (m) obj2;
        m mVar3 = (m) obj3;
        if (mVar != null && mVar2 != null) {
            q qVar = new q();
            qVar.d0(mVar);
            qVar.d0(mVar2);
            qVar.k0(1);
            mVar = qVar;
        } else if (mVar == null) {
            mVar = mVar2 != null ? mVar2 : null;
        }
        if (mVar3 != null) {
            q qVar2 = new q();
            if (mVar != null) {
                qVar2.d0(mVar);
            }
            qVar2.d0(mVar3);
            return qVar2;
        }
        return mVar;
    }

    @Override // androidx.fragment.app.m
    public Object n(Object obj, Object obj2, Object obj3) {
        q qVar = new q();
        if (obj != null) {
            qVar.d0((m) obj);
        }
        if (obj2 != null) {
            qVar.d0((m) obj2);
        }
        if (obj3 != null) {
            qVar.d0((m) obj3);
        }
        return qVar;
    }

    @Override // androidx.fragment.app.m
    public void p(Object obj, View view) {
        if (obj != null) {
            ((m) obj).P(view);
        }
    }

    @Override // androidx.fragment.app.m
    public void q(Object obj, ArrayList<View> arrayList, ArrayList<View> arrayList2) {
        m mVar = (m) obj;
        int i = 0;
        if (mVar instanceof q) {
            q qVar = (q) mVar;
            int f0 = qVar.f0();
            while (i < f0) {
                q(qVar.e0(i), arrayList, arrayList2);
                i++;
            }
        } else if (!B(mVar)) {
            List<View> B = mVar.B();
            if (B.size() == arrayList.size() && B.containsAll(arrayList)) {
                int size = arrayList2 == null ? 0 : arrayList2.size();
                while (i < size) {
                    mVar.b(arrayList2.get(i));
                    i++;
                }
                for (int size2 = arrayList.size() - 1; size2 >= 0; size2--) {
                    mVar.P(arrayList.get(size2));
                }
            }
        }
    }

    @Override // androidx.fragment.app.m
    public void r(Object obj, View view, ArrayList<View> arrayList) {
        ((m) obj).a(new b(this, view, arrayList));
    }

    @Override // androidx.fragment.app.m
    public void t(Object obj, Object obj2, ArrayList<View> arrayList, Object obj3, ArrayList<View> arrayList2, Object obj4, ArrayList<View> arrayList3) {
        ((m) obj).a(new c(obj2, arrayList, obj3, arrayList2, obj4, arrayList3));
    }

    @Override // androidx.fragment.app.m
    public void u(Object obj, Rect rect) {
        if (obj != null) {
            ((m) obj).U(new d(this, rect));
        }
    }

    @Override // androidx.fragment.app.m
    public void v(Object obj, View view) {
        if (view != null) {
            Rect rect = new Rect();
            k(view, rect);
            ((m) obj).U(new a(this, rect));
        }
    }

    @Override // androidx.fragment.app.m
    public void y(Object obj, View view, ArrayList<View> arrayList) {
        q qVar = (q) obj;
        List<View> B = qVar.B();
        B.clear();
        int size = arrayList.size();
        for (int i = 0; i < size; i++) {
            androidx.fragment.app.m.d(B, arrayList.get(i));
        }
        B.add(view);
        arrayList.add(view);
        b(qVar, arrayList);
    }

    @Override // androidx.fragment.app.m
    public void z(Object obj, ArrayList<View> arrayList, ArrayList<View> arrayList2) {
        q qVar = (q) obj;
        if (qVar != null) {
            qVar.B().clear();
            qVar.B().addAll(arrayList2);
            q(qVar, arrayList, arrayList2);
        }
    }
}
