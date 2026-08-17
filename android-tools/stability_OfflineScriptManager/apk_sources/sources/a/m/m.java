package a.m;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.TimeInterpolator;
import android.graphics.Path;
import android.util.SparseArray;
import android.util.SparseIntArray;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import me.zhanghai.android.materialprogressbar.BuildConfig;
/* loaded from: classes.dex */
public abstract class m implements Cloneable {
    private static final int[] H = {2, 1, 3, 4};
    private static final g I = new a();
    private static ThreadLocal<a.d.a<Animator, d>> J = new ThreadLocal<>();
    p D;
    private e E;
    private a.d.a<String, String> F;
    private ArrayList<s> u;
    private ArrayList<s> v;

    /* renamed from: b  reason: collision with root package name */
    private String f293b = getClass().getName();

    /* renamed from: c  reason: collision with root package name */
    private long f294c = -1;

    /* renamed from: d  reason: collision with root package name */
    long f295d = -1;
    private TimeInterpolator e = null;
    ArrayList<Integer> f = new ArrayList<>();
    ArrayList<View> g = new ArrayList<>();
    private ArrayList<String> h = null;
    private ArrayList<Class> i = null;
    private ArrayList<Integer> j = null;
    private ArrayList<View> k = null;
    private ArrayList<Class> l = null;
    private ArrayList<String> m = null;
    private ArrayList<Integer> n = null;
    private ArrayList<View> o = null;
    private ArrayList<Class> p = null;
    private t q = new t();
    private t r = new t();
    q s = null;
    private int[] t = H;
    boolean w = false;
    ArrayList<Animator> x = new ArrayList<>();
    private int y = 0;
    private boolean z = false;
    private boolean A = false;
    private ArrayList<f> B = null;
    private ArrayList<Animator> C = new ArrayList<>();
    private g G = I;

    /* loaded from: classes.dex */
    static class a extends g {
        a() {
        }

        @Override // a.m.g
        public Path a(float f, float f2, float f3, float f4) {
            Path path = new Path();
            path.moveTo(f, f2);
            path.lineTo(f3, f4);
            return path;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class b extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ a.d.a f296a;

        b(a.d.a aVar) {
            this.f296a = aVar;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f296a.remove(animator);
            m.this.x.remove(animator);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            m.this.x.add(animator);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c extends AnimatorListenerAdapter {
        c() {
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            m.this.o();
            animator.removeListener(this);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class d {

        /* renamed from: a  reason: collision with root package name */
        View f299a;

        /* renamed from: b  reason: collision with root package name */
        String f300b;

        /* renamed from: c  reason: collision with root package name */
        s f301c;

        /* renamed from: d  reason: collision with root package name */
        l0 f302d;
        m e;

        d(View view, String str, m mVar, l0 l0Var, s sVar) {
            this.f299a = view;
            this.f300b = str;
            this.f301c = sVar;
            this.f302d = l0Var;
            this.e = mVar;
        }
    }

    /* loaded from: classes.dex */
    public static abstract class e {
    }

    /* loaded from: classes.dex */
    public interface f {
        void a(m mVar);

        void b(m mVar);

        void c(m mVar);

        void d(m mVar);
    }

    private static boolean G(s sVar, s sVar2, String str) {
        Object obj = sVar.f315a.get(str);
        Object obj2 = sVar2.f315a.get(str);
        if (obj == null && obj2 == null) {
            return false;
        }
        if (obj == null || obj2 == null) {
            return true;
        }
        return true ^ obj.equals(obj2);
    }

    private void H(a.d.a<View, s> aVar, a.d.a<View, s> aVar2, SparseArray<View> sparseArray, SparseArray<View> sparseArray2) {
        View view;
        int size = sparseArray.size();
        for (int i = 0; i < size; i++) {
            View valueAt = sparseArray.valueAt(i);
            if (valueAt != null && F(valueAt) && (view = sparseArray2.get(sparseArray.keyAt(i))) != null && F(view)) {
                s sVar = aVar.get(valueAt);
                s sVar2 = aVar2.get(view);
                if (sVar != null && sVar2 != null) {
                    this.u.add(sVar);
                    this.v.add(sVar2);
                    aVar.remove(valueAt);
                    aVar2.remove(view);
                }
            }
        }
    }

    private void I(a.d.a<View, s> aVar, a.d.a<View, s> aVar2) {
        s remove;
        View view;
        for (int size = aVar.size() - 1; size >= 0; size--) {
            View i = aVar.i(size);
            if (i != null && F(i) && (remove = aVar2.remove(i)) != null && (view = remove.f316b) != null && F(view)) {
                this.u.add(aVar.k(size));
                this.v.add(remove);
            }
        }
    }

    private void J(a.d.a<View, s> aVar, a.d.a<View, s> aVar2, a.d.d<View> dVar, a.d.d<View> dVar2) {
        View f2;
        int l = dVar.l();
        for (int i = 0; i < l; i++) {
            View m = dVar.m(i);
            if (m != null && F(m) && (f2 = dVar2.f(dVar.i(i))) != null && F(f2)) {
                s sVar = aVar.get(m);
                s sVar2 = aVar2.get(f2);
                if (sVar != null && sVar2 != null) {
                    this.u.add(sVar);
                    this.v.add(sVar2);
                    aVar.remove(m);
                    aVar2.remove(f2);
                }
            }
        }
    }

    private void K(a.d.a<View, s> aVar, a.d.a<View, s> aVar2, a.d.a<String, View> aVar3, a.d.a<String, View> aVar4) {
        View view;
        int size = aVar3.size();
        for (int i = 0; i < size; i++) {
            View m = aVar3.m(i);
            if (m != null && F(m) && (view = aVar4.get(aVar3.i(i))) != null && F(view)) {
                s sVar = aVar.get(m);
                s sVar2 = aVar2.get(view);
                if (sVar != null && sVar2 != null) {
                    this.u.add(sVar);
                    this.v.add(sVar2);
                    aVar.remove(m);
                    aVar2.remove(view);
                }
            }
        }
    }

    private void L(t tVar, t tVar2) {
        a.d.a<View, s> aVar = new a.d.a<>(tVar.f318a);
        a.d.a<View, s> aVar2 = new a.d.a<>(tVar2.f318a);
        int i = 0;
        while (true) {
            int[] iArr = this.t;
            if (i >= iArr.length) {
                c(aVar, aVar2);
                return;
            }
            int i2 = iArr[i];
            if (i2 == 1) {
                I(aVar, aVar2);
            } else if (i2 == 2) {
                K(aVar, aVar2, tVar.f321d, tVar2.f321d);
            } else if (i2 == 3) {
                H(aVar, aVar2, tVar.f319b, tVar2.f319b);
            } else if (i2 == 4) {
                J(aVar, aVar2, tVar.f320c, tVar2.f320c);
            }
            i++;
        }
    }

    private void R(Animator animator, a.d.a<Animator, d> aVar) {
        if (animator != null) {
            animator.addListener(new b(aVar));
            e(animator);
        }
    }

    private void c(a.d.a<View, s> aVar, a.d.a<View, s> aVar2) {
        for (int i = 0; i < aVar.size(); i++) {
            s m = aVar.m(i);
            if (F(m.f316b)) {
                this.u.add(m);
                this.v.add(null);
            }
        }
        for (int i2 = 0; i2 < aVar2.size(); i2++) {
            s m2 = aVar2.m(i2);
            if (F(m2.f316b)) {
                this.v.add(m2);
                this.u.add(null);
            }
        }
    }

    private static void d(t tVar, View view, s sVar) {
        tVar.f318a.put(view, sVar);
        int id = view.getId();
        if (id >= 0) {
            if (tVar.f319b.indexOfKey(id) >= 0) {
                tVar.f319b.put(id, null);
            } else {
                tVar.f319b.put(id, view);
            }
        }
        String w = a.f.l.r.w(view);
        if (w != null) {
            if (tVar.f321d.containsKey(w)) {
                tVar.f321d.put(w, null);
            } else {
                tVar.f321d.put(w, view);
            }
        }
        if (view.getParent() instanceof ListView) {
            ListView listView = (ListView) view.getParent();
            if (listView.getAdapter().hasStableIds()) {
                long itemIdAtPosition = listView.getItemIdAtPosition(listView.getPositionForView(view));
                if (tVar.f320c.h(itemIdAtPosition) < 0) {
                    a.f.l.r.X(view, true);
                    tVar.f320c.j(itemIdAtPosition, view);
                    return;
                }
                View f2 = tVar.f320c.f(itemIdAtPosition);
                if (f2 != null) {
                    a.f.l.r.X(f2, false);
                    tVar.f320c.j(itemIdAtPosition, null);
                }
            }
        }
    }

    private void g(View view, boolean z) {
        if (view == null) {
            return;
        }
        int id = view.getId();
        ArrayList<Integer> arrayList = this.j;
        if (arrayList == null || !arrayList.contains(Integer.valueOf(id))) {
            ArrayList<View> arrayList2 = this.k;
            if (arrayList2 == null || !arrayList2.contains(view)) {
                ArrayList<Class> arrayList3 = this.l;
                if (arrayList3 != null) {
                    int size = arrayList3.size();
                    for (int i = 0; i < size; i++) {
                        if (this.l.get(i).isInstance(view)) {
                            return;
                        }
                    }
                }
                if (view.getParent() instanceof ViewGroup) {
                    s sVar = new s();
                    sVar.f316b = view;
                    if (z) {
                        i(sVar);
                    } else {
                        f(sVar);
                    }
                    sVar.f317c.add(this);
                    h(sVar);
                    d(z ? this.q : this.r, view, sVar);
                }
                if (view instanceof ViewGroup) {
                    ArrayList<Integer> arrayList4 = this.n;
                    if (arrayList4 == null || !arrayList4.contains(Integer.valueOf(id))) {
                        ArrayList<View> arrayList5 = this.o;
                        if (arrayList5 == null || !arrayList5.contains(view)) {
                            ArrayList<Class> arrayList6 = this.p;
                            if (arrayList6 != null) {
                                int size2 = arrayList6.size();
                                for (int i2 = 0; i2 < size2; i2++) {
                                    if (this.p.get(i2).isInstance(view)) {
                                        return;
                                    }
                                }
                            }
                            ViewGroup viewGroup = (ViewGroup) view;
                            for (int i3 = 0; i3 < viewGroup.getChildCount(); i3++) {
                                g(viewGroup.getChildAt(i3), z);
                            }
                        }
                    }
                }
            }
        }
    }

    private static a.d.a<Animator, d> w() {
        a.d.a<Animator, d> aVar = J.get();
        if (aVar == null) {
            a.d.a<Animator, d> aVar2 = new a.d.a<>();
            J.set(aVar2);
            return aVar2;
        }
        return aVar;
    }

    public List<Class> A() {
        return this.i;
    }

    public List<View> B() {
        return this.g;
    }

    public String[] C() {
        return null;
    }

    public s D(View view, boolean z) {
        q qVar = this.s;
        if (qVar != null) {
            return qVar.D(view, z);
        }
        return (z ? this.q : this.r).f318a.get(view);
    }

    public boolean E(s sVar, s sVar2) {
        if (sVar == null || sVar2 == null) {
            return false;
        }
        String[] C = C();
        if (C == null) {
            for (String str : sVar.f315a.keySet()) {
                if (G(sVar, sVar2, str)) {
                }
            }
            return false;
        }
        for (String str2 : C) {
            if (!G(sVar, sVar2, str2)) {
            }
        }
        return false;
        return true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean F(View view) {
        ArrayList<Class> arrayList;
        ArrayList<String> arrayList2;
        int id = view.getId();
        ArrayList<Integer> arrayList3 = this.j;
        if (arrayList3 == null || !arrayList3.contains(Integer.valueOf(id))) {
            ArrayList<View> arrayList4 = this.k;
            if (arrayList4 == null || !arrayList4.contains(view)) {
                ArrayList<Class> arrayList5 = this.l;
                if (arrayList5 != null) {
                    int size = arrayList5.size();
                    for (int i = 0; i < size; i++) {
                        if (this.l.get(i).isInstance(view)) {
                            return false;
                        }
                    }
                }
                if (this.m == null || a.f.l.r.w(view) == null || !this.m.contains(a.f.l.r.w(view))) {
                    if ((this.f.size() == 0 && this.g.size() == 0 && (((arrayList = this.i) == null || arrayList.isEmpty()) && ((arrayList2 = this.h) == null || arrayList2.isEmpty()))) || this.f.contains(Integer.valueOf(id)) || this.g.contains(view)) {
                        return true;
                    }
                    ArrayList<String> arrayList6 = this.h;
                    if (arrayList6 == null || !arrayList6.contains(a.f.l.r.w(view))) {
                        if (this.i != null) {
                            for (int i2 = 0; i2 < this.i.size(); i2++) {
                                if (this.i.get(i2).isInstance(view)) {
                                    return true;
                                }
                            }
                        }
                        return false;
                    }
                    return true;
                }
                return false;
            }
            return false;
        }
        return false;
    }

    public void M(View view) {
        if (this.A) {
            return;
        }
        a.d.a<Animator, d> w = w();
        int size = w.size();
        l0 e2 = d0.e(view);
        for (int i = size - 1; i >= 0; i--) {
            d m = w.m(i);
            if (m.f299a != null && e2.equals(m.f302d)) {
                a.m.a.b(w.i(i));
            }
        }
        ArrayList<f> arrayList = this.B;
        if (arrayList != null && arrayList.size() > 0) {
            ArrayList arrayList2 = (ArrayList) this.B.clone();
            int size2 = arrayList2.size();
            for (int i2 = 0; i2 < size2; i2++) {
                ((f) arrayList2.get(i2)).a(this);
            }
        }
        this.z = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void N(ViewGroup viewGroup) {
        d dVar;
        this.u = new ArrayList<>();
        this.v = new ArrayList<>();
        L(this.q, this.r);
        a.d.a<Animator, d> w = w();
        int size = w.size();
        l0 e2 = d0.e(viewGroup);
        for (int i = size - 1; i >= 0; i--) {
            Animator i2 = w.i(i);
            if (i2 != null && (dVar = w.get(i2)) != null && dVar.f299a != null && e2.equals(dVar.f302d)) {
                s sVar = dVar.f301c;
                View view = dVar.f299a;
                s D = D(view, true);
                s s = s(view, true);
                if (!(D == null && s == null) && dVar.e.E(sVar, s)) {
                    if (i2.isRunning() || i2.isStarted()) {
                        i2.cancel();
                    } else {
                        w.remove(i2);
                    }
                }
            }
        }
        n(viewGroup, this.q, this.r, this.u, this.v);
        S();
    }

    public m O(f fVar) {
        ArrayList<f> arrayList = this.B;
        if (arrayList == null) {
            return this;
        }
        arrayList.remove(fVar);
        if (this.B.size() == 0) {
            this.B = null;
        }
        return this;
    }

    public m P(View view) {
        this.g.remove(view);
        return this;
    }

    public void Q(View view) {
        if (this.z) {
            if (!this.A) {
                a.d.a<Animator, d> w = w();
                int size = w.size();
                l0 e2 = d0.e(view);
                for (int i = size - 1; i >= 0; i--) {
                    d m = w.m(i);
                    if (m.f299a != null && e2.equals(m.f302d)) {
                        a.m.a.c(w.i(i));
                    }
                }
                ArrayList<f> arrayList = this.B;
                if (arrayList != null && arrayList.size() > 0) {
                    ArrayList arrayList2 = (ArrayList) this.B.clone();
                    int size2 = arrayList2.size();
                    for (int i2 = 0; i2 < size2; i2++) {
                        ((f) arrayList2.get(i2)).b(this);
                    }
                }
            }
            this.z = false;
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void S() {
        Z();
        a.d.a<Animator, d> w = w();
        Iterator<Animator> it = this.C.iterator();
        while (it.hasNext()) {
            Animator next = it.next();
            if (w.containsKey(next)) {
                Z();
                R(next, w);
            }
        }
        this.C.clear();
        o();
    }

    public m T(long j) {
        this.f295d = j;
        return this;
    }

    public void U(e eVar) {
        this.E = eVar;
    }

    public m V(TimeInterpolator timeInterpolator) {
        this.e = timeInterpolator;
        return this;
    }

    public void W(g gVar) {
        if (gVar == null) {
            gVar = I;
        }
        this.G = gVar;
    }

    public void X(p pVar) {
    }

    public m Y(long j) {
        this.f294c = j;
        return this;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void Z() {
        if (this.y == 0) {
            ArrayList<f> arrayList = this.B;
            if (arrayList != null && arrayList.size() > 0) {
                ArrayList arrayList2 = (ArrayList) this.B.clone();
                int size = arrayList2.size();
                for (int i = 0; i < size; i++) {
                    ((f) arrayList2.get(i)).c(this);
                }
            }
            this.A = false;
        }
        this.y++;
    }

    public m a(f fVar) {
        if (this.B == null) {
            this.B = new ArrayList<>();
        }
        this.B.add(fVar);
        return this;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public String a0(String str) {
        String str2 = str + getClass().getSimpleName() + "@" + Integer.toHexString(hashCode()) + ": ";
        if (this.f295d != -1) {
            str2 = str2 + "dur(" + this.f295d + ") ";
        }
        if (this.f294c != -1) {
            str2 = str2 + "dly(" + this.f294c + ") ";
        }
        if (this.e != null) {
            str2 = str2 + "interp(" + this.e + ") ";
        }
        if (this.f.size() > 0 || this.g.size() > 0) {
            String str3 = str2 + "tgts(";
            if (this.f.size() > 0) {
                for (int i = 0; i < this.f.size(); i++) {
                    if (i > 0) {
                        str3 = str3 + ", ";
                    }
                    str3 = str3 + this.f.get(i);
                }
            }
            if (this.g.size() > 0) {
                for (int i2 = 0; i2 < this.g.size(); i2++) {
                    if (i2 > 0) {
                        str3 = str3 + ", ";
                    }
                    str3 = str3 + this.g.get(i2);
                }
            }
            return str3 + ")";
        }
        return str2;
    }

    public m b(View view) {
        this.g.add(view);
        return this;
    }

    protected void e(Animator animator) {
        if (animator == null) {
            o();
            return;
        }
        if (p() >= 0) {
            animator.setDuration(p());
        }
        if (x() >= 0) {
            animator.setStartDelay(x());
        }
        if (r() != null) {
            animator.setInterpolator(r());
        }
        animator.addListener(new c());
        animator.start();
    }

    public abstract void f(s sVar);

    /* JADX INFO: Access modifiers changed from: package-private */
    public void h(s sVar) {
        String[] b2;
        if (this.D == null || sVar.f315a.isEmpty() || (b2 = this.D.b()) == null) {
            return;
        }
        boolean z = false;
        int i = 0;
        while (true) {
            if (i >= b2.length) {
                z = true;
                break;
            } else if (!sVar.f315a.containsKey(b2[i])) {
                break;
            } else {
                i++;
            }
        }
        if (z) {
            return;
        }
        this.D.a(sVar);
    }

    public abstract void i(s sVar);

    /* JADX INFO: Access modifiers changed from: package-private */
    public void j(ViewGroup viewGroup, boolean z) {
        ArrayList<String> arrayList;
        ArrayList<Class> arrayList2;
        a.d.a<String, String> aVar;
        k(z);
        if ((this.f.size() > 0 || this.g.size() > 0) && (((arrayList = this.h) == null || arrayList.isEmpty()) && ((arrayList2 = this.i) == null || arrayList2.isEmpty()))) {
            for (int i = 0; i < this.f.size(); i++) {
                View findViewById = viewGroup.findViewById(this.f.get(i).intValue());
                if (findViewById != null) {
                    s sVar = new s();
                    sVar.f316b = findViewById;
                    if (z) {
                        i(sVar);
                    } else {
                        f(sVar);
                    }
                    sVar.f317c.add(this);
                    h(sVar);
                    d(z ? this.q : this.r, findViewById, sVar);
                }
            }
            for (int i2 = 0; i2 < this.g.size(); i2++) {
                View view = this.g.get(i2);
                s sVar2 = new s();
                sVar2.f316b = view;
                if (z) {
                    i(sVar2);
                } else {
                    f(sVar2);
                }
                sVar2.f317c.add(this);
                h(sVar2);
                d(z ? this.q : this.r, view, sVar2);
            }
        } else {
            g(viewGroup, z);
        }
        if (z || (aVar = this.F) == null) {
            return;
        }
        int size = aVar.size();
        ArrayList arrayList3 = new ArrayList(size);
        for (int i3 = 0; i3 < size; i3++) {
            arrayList3.add(this.q.f321d.remove(this.F.i(i3)));
        }
        for (int i4 = 0; i4 < size; i4++) {
            View view2 = (View) arrayList3.get(i4);
            if (view2 != null) {
                this.q.f321d.put(this.F.m(i4), view2);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void k(boolean z) {
        t tVar;
        if (z) {
            this.q.f318a.clear();
            this.q.f319b.clear();
            tVar = this.q;
        } else {
            this.r.f318a.clear();
            this.r.f319b.clear();
            tVar = this.r;
        }
        tVar.f320c.b();
    }

    @Override // 
    /* renamed from: l */
    public m clone() {
        try {
            m mVar = (m) super.clone();
            mVar.C = new ArrayList<>();
            mVar.q = new t();
            mVar.r = new t();
            mVar.u = null;
            mVar.v = null;
            return mVar;
        } catch (CloneNotSupportedException unused) {
            return null;
        }
    }

    public Animator m(ViewGroup viewGroup, s sVar, s sVar2) {
        return null;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void n(ViewGroup viewGroup, t tVar, t tVar2, ArrayList<s> arrayList, ArrayList<s> arrayList2) {
        Animator m;
        int i;
        int i2;
        View view;
        Animator animator;
        s sVar;
        Animator animator2;
        s sVar2;
        a.d.a<Animator, d> w = w();
        SparseIntArray sparseIntArray = new SparseIntArray();
        int size = arrayList.size();
        long j = Long.MAX_VALUE;
        int i3 = 0;
        while (i3 < size) {
            s sVar3 = arrayList.get(i3);
            s sVar4 = arrayList2.get(i3);
            if (sVar3 != null && !sVar3.f317c.contains(this)) {
                sVar3 = null;
            }
            if (sVar4 != null && !sVar4.f317c.contains(this)) {
                sVar4 = null;
            }
            if (sVar3 != null || sVar4 != null) {
                if ((sVar3 == null || sVar4 == null || E(sVar3, sVar4)) && (m = m(viewGroup, sVar3, sVar4)) != null) {
                    if (sVar4 != null) {
                        view = sVar4.f316b;
                        String[] C = C();
                        if (view == null || C == null || C.length <= 0) {
                            i = size;
                            i2 = i3;
                            animator2 = m;
                            sVar2 = null;
                        } else {
                            sVar2 = new s();
                            sVar2.f316b = view;
                            i = size;
                            s sVar5 = tVar2.f318a.get(view);
                            if (sVar5 != null) {
                                int i4 = 0;
                                while (i4 < C.length) {
                                    sVar2.f315a.put(C[i4], sVar5.f315a.get(C[i4]));
                                    i4++;
                                    i3 = i3;
                                    sVar5 = sVar5;
                                }
                            }
                            i2 = i3;
                            int size2 = w.size();
                            int i5 = 0;
                            while (true) {
                                if (i5 >= size2) {
                                    animator2 = m;
                                    break;
                                }
                                d dVar = w.get(w.i(i5));
                                if (dVar.f301c != null && dVar.f299a == view && dVar.f300b.equals(t()) && dVar.f301c.equals(sVar2)) {
                                    animator2 = null;
                                    break;
                                }
                                i5++;
                            }
                        }
                        animator = animator2;
                        sVar = sVar2;
                    } else {
                        i = size;
                        i2 = i3;
                        view = sVar3.f316b;
                        animator = m;
                        sVar = null;
                    }
                    if (animator != null) {
                        p pVar = this.D;
                        if (pVar != null) {
                            long c2 = pVar.c(viewGroup, this, sVar3, sVar4);
                            sparseIntArray.put(this.C.size(), (int) c2);
                            j = Math.min(c2, j);
                        }
                        w.put(animator, new d(view, t(), this, d0.e(viewGroup), sVar));
                        this.C.add(animator);
                        j = j;
                    }
                    i3 = i2 + 1;
                    size = i;
                }
            }
            i = size;
            i2 = i3;
            i3 = i2 + 1;
            size = i;
        }
        if (j != 0) {
            for (int i6 = 0; i6 < sparseIntArray.size(); i6++) {
                Animator animator3 = this.C.get(sparseIntArray.keyAt(i6));
                animator3.setStartDelay((sparseIntArray.valueAt(i6) - j) + animator3.getStartDelay());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void o() {
        int i = this.y - 1;
        this.y = i;
        if (i == 0) {
            ArrayList<f> arrayList = this.B;
            if (arrayList != null && arrayList.size() > 0) {
                ArrayList arrayList2 = (ArrayList) this.B.clone();
                int size = arrayList2.size();
                for (int i2 = 0; i2 < size; i2++) {
                    ((f) arrayList2.get(i2)).d(this);
                }
            }
            for (int i3 = 0; i3 < this.q.f320c.l(); i3++) {
                View m = this.q.f320c.m(i3);
                if (m != null) {
                    a.f.l.r.X(m, false);
                }
            }
            for (int i4 = 0; i4 < this.r.f320c.l(); i4++) {
                View m2 = this.r.f320c.m(i4);
                if (m2 != null) {
                    a.f.l.r.X(m2, false);
                }
            }
            this.A = true;
        }
    }

    public long p() {
        return this.f295d;
    }

    public e q() {
        return this.E;
    }

    public TimeInterpolator r() {
        return this.e;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public s s(View view, boolean z) {
        q qVar = this.s;
        if (qVar != null) {
            return qVar.s(view, z);
        }
        ArrayList<s> arrayList = z ? this.u : this.v;
        if (arrayList == null) {
            return null;
        }
        int size = arrayList.size();
        int i = -1;
        int i2 = 0;
        while (true) {
            if (i2 >= size) {
                break;
            }
            s sVar = arrayList.get(i2);
            if (sVar == null) {
                return null;
            }
            if (sVar.f316b == view) {
                i = i2;
                break;
            }
            i2++;
        }
        if (i >= 0) {
            return (z ? this.v : this.u).get(i);
        }
        return null;
    }

    public String t() {
        return this.f293b;
    }

    public String toString() {
        return a0(BuildConfig.FLAVOR);
    }

    public g u() {
        return this.G;
    }

    public p v() {
        return this.D;
    }

    public long x() {
        return this.f294c;
    }

    public List<Integer> y() {
        return this.f;
    }

    public List<String> z() {
        return this.h;
    }
}
