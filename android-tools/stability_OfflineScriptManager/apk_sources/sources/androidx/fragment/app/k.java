package androidx.fragment.app;

import a.f.l.r;
import android.graphics.Rect;
import android.os.Build;
import android.util.SparseArray;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class k {

    /* renamed from: a  reason: collision with root package name */
    private static final int[] f1011a = {0, 3, 0, 1, 5, 4, 7, 6, 9, 8};

    /* renamed from: b  reason: collision with root package name */
    private static final m f1012b;

    /* renamed from: c  reason: collision with root package name */
    private static final m f1013c;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayList f1014b;

        a(ArrayList arrayList) {
            this.f1014b = arrayList;
        }

        @Override // java.lang.Runnable
        public void run() {
            k.B(this.f1014b, 4);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class b implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Object f1015b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ m f1016c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ View f1017d;
        final /* synthetic */ Fragment e;
        final /* synthetic */ ArrayList f;
        final /* synthetic */ ArrayList g;
        final /* synthetic */ ArrayList h;
        final /* synthetic */ Object i;

        b(Object obj, m mVar, View view, Fragment fragment, ArrayList arrayList, ArrayList arrayList2, ArrayList arrayList3, Object obj2) {
            this.f1015b = obj;
            this.f1016c = mVar;
            this.f1017d = view;
            this.e = fragment;
            this.f = arrayList;
            this.g = arrayList2;
            this.h = arrayList3;
            this.i = obj2;
        }

        @Override // java.lang.Runnable
        public void run() {
            Object obj = this.f1015b;
            if (obj != null) {
                this.f1016c.p(obj, this.f1017d);
                this.g.addAll(k.k(this.f1016c, this.f1015b, this.e, this.f, this.f1017d));
            }
            if (this.h != null) {
                if (this.i != null) {
                    ArrayList<View> arrayList = new ArrayList<>();
                    arrayList.add(this.f1017d);
                    this.f1016c.q(this.i, this.h, arrayList);
                }
                this.h.clear();
                this.h.add(this.f1017d);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ Fragment f1018b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ Fragment f1019c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ boolean f1020d;
        final /* synthetic */ a.d.a e;
        final /* synthetic */ View f;
        final /* synthetic */ m g;
        final /* synthetic */ Rect h;

        c(Fragment fragment, Fragment fragment2, boolean z, a.d.a aVar, View view, m mVar, Rect rect) {
            this.f1018b = fragment;
            this.f1019c = fragment2;
            this.f1020d = z;
            this.e = aVar;
            this.f = view;
            this.g = mVar;
            this.h = rect;
        }

        @Override // java.lang.Runnable
        public void run() {
            k.f(this.f1018b, this.f1019c, this.f1020d, this.e, false);
            View view = this.f;
            if (view != null) {
                this.g.k(view, this.h);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class d implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ m f1021b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ a.d.a f1022c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ Object f1023d;
        final /* synthetic */ e e;
        final /* synthetic */ ArrayList f;
        final /* synthetic */ View g;
        final /* synthetic */ Fragment h;
        final /* synthetic */ Fragment i;
        final /* synthetic */ boolean j;
        final /* synthetic */ ArrayList k;
        final /* synthetic */ Object l;
        final /* synthetic */ Rect m;

        d(m mVar, a.d.a aVar, Object obj, e eVar, ArrayList arrayList, View view, Fragment fragment, Fragment fragment2, boolean z, ArrayList arrayList2, Object obj2, Rect rect) {
            this.f1021b = mVar;
            this.f1022c = aVar;
            this.f1023d = obj;
            this.e = eVar;
            this.f = arrayList;
            this.g = view;
            this.h = fragment;
            this.i = fragment2;
            this.j = z;
            this.k = arrayList2;
            this.l = obj2;
            this.m = rect;
        }

        @Override // java.lang.Runnable
        public void run() {
            a.d.a<String, View> h = k.h(this.f1021b, this.f1022c, this.f1023d, this.e);
            if (h != null) {
                this.f.addAll(h.values());
                this.f.add(this.g);
            }
            k.f(this.h, this.i, this.j, h, false);
            Object obj = this.f1023d;
            if (obj != null) {
                this.f1021b.z(obj, this.k, this.f);
                View t = k.t(h, this.e, this.l, this.j);
                if (t != null) {
                    this.f1021b.k(t, this.m);
                }
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class e {

        /* renamed from: a  reason: collision with root package name */
        public Fragment f1024a;

        /* renamed from: b  reason: collision with root package name */
        public boolean f1025b;

        /* renamed from: c  reason: collision with root package name */
        public androidx.fragment.app.a f1026c;

        /* renamed from: d  reason: collision with root package name */
        public Fragment f1027d;
        public boolean e;
        public androidx.fragment.app.a f;

        e() {
        }
    }

    static {
        f1012b = Build.VERSION.SDK_INT >= 21 ? new l() : null;
        f1013c = x();
    }

    private static void A(m mVar, Object obj, Object obj2, a.d.a<String, View> aVar, boolean z, androidx.fragment.app.a aVar2) {
        ArrayList<String> arrayList = aVar2.r;
        if (arrayList == null || arrayList.isEmpty()) {
            return;
        }
        View view = aVar.get((z ? aVar2.s : aVar2.r).get(0));
        mVar.v(obj, view);
        if (obj2 != null) {
            mVar.v(obj2, view);
        }
    }

    static void B(ArrayList<View> arrayList, int i) {
        if (arrayList == null) {
            return;
        }
        for (int size = arrayList.size() - 1; size >= 0; size--) {
            arrayList.get(size).setVisibility(i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void C(g gVar, ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2, int i, int i2, boolean z) {
        if (gVar.m < 1) {
            return;
        }
        SparseArray sparseArray = new SparseArray();
        for (int i3 = i; i3 < i2; i3++) {
            androidx.fragment.app.a aVar = arrayList.get(i3);
            if (arrayList2.get(i3).booleanValue()) {
                e(aVar, sparseArray, z);
            } else {
                c(aVar, sparseArray, z);
            }
        }
        if (sparseArray.size() != 0) {
            View view = new View(gVar.n.e());
            int size = sparseArray.size();
            for (int i4 = 0; i4 < size; i4++) {
                int keyAt = sparseArray.keyAt(i4);
                a.d.a<String, String> d2 = d(keyAt, arrayList, arrayList2, i, i2);
                e eVar = (e) sparseArray.valueAt(i4);
                if (z) {
                    o(gVar, keyAt, eVar, view, d2);
                } else {
                    n(gVar, keyAt, eVar, view, d2);
                }
            }
        }
    }

    private static void a(ArrayList<View> arrayList, a.d.a<String, View> aVar, Collection<String> collection) {
        for (int size = aVar.size() - 1; size >= 0; size--) {
            View m = aVar.m(size);
            if (collection.contains(r.w(m))) {
                arrayList.add(m);
            }
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:30:0x0041, code lost:
        if (r10.l != false) goto L63;
     */
    /* JADX WARN: Code restructure failed: missing block: B:55:0x0076, code lost:
        r1 = true;
     */
    /* JADX WARN: Code restructure failed: missing block: B:67:0x0090, code lost:
        if (r10.B == false) goto L63;
     */
    /* JADX WARN: Code restructure failed: missing block: B:68:0x0092, code lost:
        r1 = true;
     */
    /* JADX WARN: Removed duplicated region for block: B:100:? A[ADDED_TO_REGION, RETURN, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:73:0x00a1  */
    /* JADX WARN: Removed duplicated region for block: B:76:0x00af A[ADDED_TO_REGION] */
    /* JADX WARN: Removed duplicated region for block: B:89:0x00d4 A[ADDED_TO_REGION] */
    /* JADX WARN: Removed duplicated region for block: B:94:0x00e6 A[ADDED_TO_REGION] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static void b(androidx.fragment.app.a r16, androidx.fragment.app.a.C0034a r17, android.util.SparseArray<androidx.fragment.app.k.e> r18, boolean r19, boolean r20) {
        /*
            Method dump skipped, instructions count: 241
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.fragment.app.k.b(androidx.fragment.app.a, androidx.fragment.app.a$a, android.util.SparseArray, boolean, boolean):void");
    }

    public static void c(androidx.fragment.app.a aVar, SparseArray<e> sparseArray, boolean z) {
        int size = aVar.f953b.size();
        for (int i = 0; i < size; i++) {
            b(aVar, aVar.f953b.get(i), sparseArray, false, z);
        }
    }

    private static a.d.a<String, String> d(int i, ArrayList<androidx.fragment.app.a> arrayList, ArrayList<Boolean> arrayList2, int i2, int i3) {
        ArrayList<String> arrayList3;
        ArrayList<String> arrayList4;
        a.d.a<String, String> aVar = new a.d.a<>();
        for (int i4 = i3 - 1; i4 >= i2; i4--) {
            androidx.fragment.app.a aVar2 = arrayList.get(i4);
            if (aVar2.u(i)) {
                boolean booleanValue = arrayList2.get(i4).booleanValue();
                ArrayList<String> arrayList5 = aVar2.r;
                if (arrayList5 != null) {
                    int size = arrayList5.size();
                    if (booleanValue) {
                        arrayList3 = aVar2.r;
                        arrayList4 = aVar2.s;
                    } else {
                        ArrayList<String> arrayList6 = aVar2.r;
                        arrayList3 = aVar2.s;
                        arrayList4 = arrayList6;
                    }
                    for (int i5 = 0; i5 < size; i5++) {
                        String str = arrayList4.get(i5);
                        String str2 = arrayList3.get(i5);
                        String remove = aVar.remove(str2);
                        if (remove != null) {
                            aVar.put(str, remove);
                        } else {
                            aVar.put(str, str2);
                        }
                    }
                }
            }
        }
        return aVar;
    }

    public static void e(androidx.fragment.app.a aVar, SparseArray<e> sparseArray, boolean z) {
        if (aVar.f952a.o.c()) {
            for (int size = aVar.f953b.size() - 1; size >= 0; size--) {
                b(aVar, aVar.f953b.get(size), sparseArray, true, z);
            }
        }
    }

    static void f(Fragment fragment, Fragment fragment2, boolean z, a.d.a<String, View> aVar, boolean z2) {
        androidx.core.app.k p = z ? fragment2.p() : fragment.p();
        if (p != null) {
            ArrayList arrayList = new ArrayList();
            ArrayList arrayList2 = new ArrayList();
            int size = aVar == null ? 0 : aVar.size();
            for (int i = 0; i < size; i++) {
                arrayList2.add(aVar.i(i));
                arrayList.add(aVar.m(i));
            }
            if (z2) {
                p.c(arrayList2, arrayList, null);
            } else {
                p.b(arrayList2, arrayList, null);
            }
        }
    }

    private static boolean g(m mVar, List<Object> list) {
        int size = list.size();
        for (int i = 0; i < size; i++) {
            if (!mVar.e(list.get(i))) {
                return false;
            }
        }
        return true;
    }

    static a.d.a<String, View> h(m mVar, a.d.a<String, String> aVar, Object obj, e eVar) {
        androidx.core.app.k p;
        ArrayList<String> arrayList;
        String q;
        Fragment fragment = eVar.f1024a;
        View F = fragment.F();
        if (aVar.isEmpty() || obj == null || F == null) {
            aVar.clear();
            return null;
        }
        a.d.a<String, View> aVar2 = new a.d.a<>();
        mVar.j(aVar2, F);
        androidx.fragment.app.a aVar3 = eVar.f1026c;
        if (eVar.f1025b) {
            p = fragment.r();
            arrayList = aVar3.r;
        } else {
            p = fragment.p();
            arrayList = aVar3.s;
        }
        if (arrayList != null) {
            aVar2.o(arrayList);
            aVar2.o(aVar.values());
        }
        if (p != null) {
            p.a(arrayList, aVar2);
            for (int size = arrayList.size() - 1; size >= 0; size--) {
                String str = arrayList.get(size);
                View view = aVar2.get(str);
                if (view == null) {
                    String q2 = q(aVar, str);
                    if (q2 != null) {
                        aVar.remove(q2);
                    }
                } else if (!str.equals(r.w(view)) && (q = q(aVar, str)) != null) {
                    aVar.put(q, r.w(view));
                }
            }
        } else {
            y(aVar, aVar2);
        }
        return aVar2;
    }

    private static a.d.a<String, View> i(m mVar, a.d.a<String, String> aVar, Object obj, e eVar) {
        androidx.core.app.k r;
        ArrayList<String> arrayList;
        if (aVar.isEmpty() || obj == null) {
            aVar.clear();
            return null;
        }
        Fragment fragment = eVar.f1027d;
        a.d.a<String, View> aVar2 = new a.d.a<>();
        mVar.j(aVar2, fragment.F());
        androidx.fragment.app.a aVar3 = eVar.f;
        if (eVar.e) {
            r = fragment.p();
            arrayList = aVar3.s;
        } else {
            r = fragment.r();
            arrayList = aVar3.r;
        }
        aVar2.o(arrayList);
        if (r != null) {
            r.a(arrayList, aVar2);
            for (int size = arrayList.size() - 1; size >= 0; size--) {
                String str = arrayList.get(size);
                View view = aVar2.get(str);
                if (view == null) {
                    aVar.remove(str);
                } else if (!str.equals(r.w(view))) {
                    aVar.put(r.w(view), aVar.remove(str));
                }
            }
        } else {
            aVar.o(aVar2.keySet());
        }
        return aVar2;
    }

    private static m j(Fragment fragment, Fragment fragment2) {
        ArrayList arrayList = new ArrayList();
        if (fragment != null) {
            Object q = fragment.q();
            if (q != null) {
                arrayList.add(q);
            }
            Object z = fragment.z();
            if (z != null) {
                arrayList.add(z);
            }
            Object B = fragment.B();
            if (B != null) {
                arrayList.add(B);
            }
        }
        if (fragment2 != null) {
            Object o = fragment2.o();
            if (o != null) {
                arrayList.add(o);
            }
            Object x = fragment2.x();
            if (x != null) {
                arrayList.add(x);
            }
            Object A = fragment2.A();
            if (A != null) {
                arrayList.add(A);
            }
        }
        if (arrayList.isEmpty()) {
            return null;
        }
        m mVar = f1012b;
        if (mVar == null || !g(mVar, arrayList)) {
            m mVar2 = f1013c;
            if (mVar2 == null || !g(mVar2, arrayList)) {
                if (mVar == null && mVar2 == null) {
                    return null;
                }
                throw new IllegalArgumentException("Invalid Transition types");
            }
            return mVar2;
        }
        return mVar;
    }

    static ArrayList<View> k(m mVar, Object obj, Fragment fragment, ArrayList<View> arrayList, View view) {
        if (obj != null) {
            ArrayList<View> arrayList2 = new ArrayList<>();
            View F = fragment.F();
            if (F != null) {
                mVar.f(arrayList2, F);
            }
            if (arrayList != null) {
                arrayList2.removeAll(arrayList);
            }
            if (arrayList2.isEmpty()) {
                return arrayList2;
            }
            arrayList2.add(view);
            mVar.b(obj, arrayList2);
            return arrayList2;
        }
        return null;
    }

    private static Object l(m mVar, ViewGroup viewGroup, View view, a.d.a<String, String> aVar, e eVar, ArrayList<View> arrayList, ArrayList<View> arrayList2, Object obj, Object obj2) {
        Object u;
        a.d.a<String, String> aVar2;
        Object obj3;
        Rect rect;
        Fragment fragment = eVar.f1024a;
        Fragment fragment2 = eVar.f1027d;
        if (fragment == null || fragment2 == null) {
            return null;
        }
        boolean z = eVar.f1025b;
        if (aVar.isEmpty()) {
            aVar2 = aVar;
            u = null;
        } else {
            u = u(mVar, fragment, fragment2, z);
            aVar2 = aVar;
        }
        a.d.a<String, View> i = i(mVar, aVar2, u, eVar);
        if (aVar.isEmpty()) {
            obj3 = null;
        } else {
            arrayList.addAll(i.values());
            obj3 = u;
        }
        if (obj == null && obj2 == null && obj3 == null) {
            return null;
        }
        f(fragment, fragment2, z, i, true);
        if (obj3 != null) {
            rect = new Rect();
            mVar.y(obj3, view, arrayList);
            A(mVar, obj3, obj2, i, eVar.e, eVar.f);
            if (obj != null) {
                mVar.u(obj, rect);
            }
        } else {
            rect = null;
        }
        n.a(viewGroup, new d(mVar, aVar, obj3, eVar, arrayList2, view, fragment, fragment2, z, arrayList, obj, rect));
        return obj3;
    }

    private static Object m(m mVar, ViewGroup viewGroup, View view, a.d.a<String, String> aVar, e eVar, ArrayList<View> arrayList, ArrayList<View> arrayList2, Object obj, Object obj2) {
        Object obj3;
        View view2;
        Rect rect;
        Fragment fragment = eVar.f1024a;
        Fragment fragment2 = eVar.f1027d;
        if (fragment != null) {
            fragment.F().setVisibility(0);
        }
        if (fragment == null || fragment2 == null) {
            return null;
        }
        boolean z = eVar.f1025b;
        Object u = aVar.isEmpty() ? null : u(mVar, fragment, fragment2, z);
        a.d.a<String, View> i = i(mVar, aVar, u, eVar);
        a.d.a<String, View> h = h(mVar, aVar, u, eVar);
        if (aVar.isEmpty()) {
            if (i != null) {
                i.clear();
            }
            if (h != null) {
                h.clear();
            }
            obj3 = null;
        } else {
            a(arrayList, i, aVar.keySet());
            a(arrayList2, h, aVar.values());
            obj3 = u;
        }
        if (obj == null && obj2 == null && obj3 == null) {
            return null;
        }
        f(fragment, fragment2, z, i, true);
        if (obj3 != null) {
            arrayList2.add(view);
            mVar.y(obj3, view, arrayList);
            A(mVar, obj3, obj2, i, eVar.e, eVar.f);
            Rect rect2 = new Rect();
            View t = t(h, eVar, obj, z);
            if (t != null) {
                mVar.u(obj, rect2);
            }
            rect = rect2;
            view2 = t;
        } else {
            view2 = null;
            rect = null;
        }
        n.a(viewGroup, new c(fragment, fragment2, z, h, view2, mVar, rect));
        return obj3;
    }

    private static void n(g gVar, int i, e eVar, View view, a.d.a<String, String> aVar) {
        Fragment fragment;
        Fragment fragment2;
        m j;
        Object obj;
        ViewGroup viewGroup = gVar.o.c() ? (ViewGroup) gVar.o.b(i) : null;
        if (viewGroup == null || (j = j((fragment2 = eVar.f1027d), (fragment = eVar.f1024a))) == null) {
            return;
        }
        boolean z = eVar.f1025b;
        boolean z2 = eVar.e;
        Object r = r(j, fragment, z);
        Object s = s(j, fragment2, z2);
        ArrayList arrayList = new ArrayList();
        ArrayList<View> arrayList2 = new ArrayList<>();
        Object l = l(j, viewGroup, view, aVar, eVar, arrayList, arrayList2, r, s);
        if (r == null && l == null) {
            obj = s;
            if (obj == null) {
                return;
            }
        } else {
            obj = s;
        }
        ArrayList<View> k = k(j, obj, fragment2, arrayList, view);
        Object obj2 = (k == null || k.isEmpty()) ? null : obj;
        j.a(r, view);
        Object v = v(j, r, obj2, l, fragment, eVar.f1025b);
        if (v != null) {
            ArrayList<View> arrayList3 = new ArrayList<>();
            j.t(v, r, arrayList3, obj2, k, l, arrayList2);
            z(j, viewGroup, fragment, view, arrayList2, r, arrayList3, obj2, k);
            j.w(viewGroup, arrayList2, aVar);
            j.c(viewGroup, v);
            j.s(viewGroup, arrayList2, aVar);
        }
    }

    private static void o(g gVar, int i, e eVar, View view, a.d.a<String, String> aVar) {
        Fragment fragment;
        Fragment fragment2;
        m j;
        Object obj;
        ViewGroup viewGroup = gVar.o.c() ? (ViewGroup) gVar.o.b(i) : null;
        if (viewGroup == null || (j = j((fragment2 = eVar.f1027d), (fragment = eVar.f1024a))) == null) {
            return;
        }
        boolean z = eVar.f1025b;
        boolean z2 = eVar.e;
        ArrayList<View> arrayList = new ArrayList<>();
        ArrayList<View> arrayList2 = new ArrayList<>();
        Object r = r(j, fragment, z);
        Object s = s(j, fragment2, z2);
        Object m = m(j, viewGroup, view, aVar, eVar, arrayList2, arrayList, r, s);
        if (r == null && m == null) {
            obj = s;
            if (obj == null) {
                return;
            }
        } else {
            obj = s;
        }
        ArrayList<View> k = k(j, obj, fragment2, arrayList2, view);
        ArrayList<View> k2 = k(j, r, fragment, arrayList, view);
        B(k2, 4);
        Object v = v(j, r, obj, m, fragment, z);
        if (v != null) {
            w(j, obj, fragment2, k);
            ArrayList<String> o = j.o(arrayList);
            j.t(v, r, k2, obj, k, m, arrayList);
            j.c(viewGroup, v);
            j.x(viewGroup, arrayList2, arrayList, o, aVar);
            B(k2, 0);
            j.z(m, arrayList2, arrayList);
        }
    }

    private static e p(e eVar, SparseArray<e> sparseArray, int i) {
        if (eVar == null) {
            e eVar2 = new e();
            sparseArray.put(i, eVar2);
            return eVar2;
        }
        return eVar;
    }

    private static String q(a.d.a<String, String> aVar, String str) {
        int size = aVar.size();
        for (int i = 0; i < size; i++) {
            if (str.equals(aVar.m(i))) {
                return aVar.i(i);
            }
        }
        return null;
    }

    private static Object r(m mVar, Fragment fragment, boolean z) {
        if (fragment == null) {
            return null;
        }
        return mVar.g(z ? fragment.x() : fragment.o());
    }

    private static Object s(m mVar, Fragment fragment, boolean z) {
        if (fragment == null) {
            return null;
        }
        return mVar.g(z ? fragment.z() : fragment.q());
    }

    static View t(a.d.a<String, View> aVar, e eVar, Object obj, boolean z) {
        ArrayList<String> arrayList;
        androidx.fragment.app.a aVar2 = eVar.f1026c;
        if (obj == null || aVar == null || (arrayList = aVar2.r) == null || arrayList.isEmpty()) {
            return null;
        }
        return aVar.get((z ? aVar2.r : aVar2.s).get(0));
    }

    private static Object u(m mVar, Fragment fragment, Fragment fragment2, boolean z) {
        if (fragment == null || fragment2 == null) {
            return null;
        }
        return mVar.A(mVar.g(z ? fragment2.B() : fragment.A()));
    }

    private static Object v(m mVar, Object obj, Object obj2, Object obj3, Fragment fragment, boolean z) {
        return (obj == null || obj2 == null || fragment == null) ? true : z ? fragment.h() : fragment.g() ? mVar.n(obj2, obj, obj3) : mVar.m(obj2, obj, obj3);
    }

    private static void w(m mVar, Object obj, Fragment fragment, ArrayList<View> arrayList) {
        if (fragment != null && obj != null && fragment.l && fragment.B && fragment.P) {
            fragment.a1(true);
            mVar.r(obj, fragment.F(), arrayList);
            n.a(fragment.I, new a(arrayList));
        }
    }

    private static m x() {
        try {
            return (m) Class.forName("a.m.e").getDeclaredConstructor(new Class[0]).newInstance(new Object[0]);
        } catch (Exception unused) {
            return null;
        }
    }

    private static void y(a.d.a<String, String> aVar, a.d.a<String, View> aVar2) {
        for (int size = aVar.size() - 1; size >= 0; size--) {
            if (!aVar2.containsKey(aVar.m(size))) {
                aVar.k(size);
            }
        }
    }

    private static void z(m mVar, ViewGroup viewGroup, Fragment fragment, View view, ArrayList<View> arrayList, Object obj, ArrayList<View> arrayList2, Object obj2, ArrayList<View> arrayList3) {
        n.a(viewGroup, new b(obj, mVar, view, fragment, arrayList, arrayList2, arrayList3, obj2));
    }
}
