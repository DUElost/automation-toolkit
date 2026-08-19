package androidx.recyclerview.widget;

import a.f.l.r;
import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.TimeInterpolator;
import android.animation.ValueAnimator;
import android.view.View;
import android.view.ViewPropertyAnimator;
import androidx.recyclerview.widget.RecyclerView;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
/* loaded from: classes.dex */
public class c extends l {
    private static TimeInterpolator s;
    private ArrayList<RecyclerView.c0> h = new ArrayList<>();
    private ArrayList<RecyclerView.c0> i = new ArrayList<>();
    private ArrayList<j> j = new ArrayList<>();
    private ArrayList<i> k = new ArrayList<>();
    ArrayList<ArrayList<RecyclerView.c0>> l = new ArrayList<>();
    ArrayList<ArrayList<j>> m = new ArrayList<>();
    ArrayList<ArrayList<i>> n = new ArrayList<>();
    ArrayList<RecyclerView.c0> o = new ArrayList<>();
    ArrayList<RecyclerView.c0> p = new ArrayList<>();
    ArrayList<RecyclerView.c0> q = new ArrayList<>();
    ArrayList<RecyclerView.c0> r = new ArrayList<>();

    /* loaded from: classes.dex */
    class a implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayList f1197b;

        a(ArrayList arrayList) {
            this.f1197b = arrayList;
        }

        @Override // java.lang.Runnable
        public void run() {
            Iterator it = this.f1197b.iterator();
            while (it.hasNext()) {
                j jVar = (j) it.next();
                c.this.S(jVar.f1227a, jVar.f1228b, jVar.f1229c, jVar.f1230d, jVar.e);
            }
            this.f1197b.clear();
            c.this.m.remove(this.f1197b);
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayList f1199b;

        b(ArrayList arrayList) {
            this.f1199b = arrayList;
        }

        @Override // java.lang.Runnable
        public void run() {
            Iterator it = this.f1199b.iterator();
            while (it.hasNext()) {
                c.this.R((i) it.next());
            }
            this.f1199b.clear();
            c.this.n.remove(this.f1199b);
        }
    }

    /* renamed from: androidx.recyclerview.widget.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class RunnableC0041c implements Runnable {

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ArrayList f1201b;

        RunnableC0041c(ArrayList arrayList) {
            this.f1201b = arrayList;
        }

        @Override // java.lang.Runnable
        public void run() {
            Iterator it = this.f1201b.iterator();
            while (it.hasNext()) {
                c.this.Q((RecyclerView.c0) it.next());
            }
            this.f1201b.clear();
            c.this.l.remove(this.f1201b);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ RecyclerView.c0 f1203a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ViewPropertyAnimator f1204b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ View f1205c;

        d(RecyclerView.c0 c0Var, ViewPropertyAnimator viewPropertyAnimator, View view) {
            this.f1203a = c0Var;
            this.f1204b = viewPropertyAnimator;
            this.f1205c = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f1204b.setListener(null);
            this.f1205c.setAlpha(1.0f);
            c.this.G(this.f1203a);
            c.this.q.remove(this.f1203a);
            c.this.V();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            c.this.H(this.f1203a);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ RecyclerView.c0 f1207a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ View f1208b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ ViewPropertyAnimator f1209c;

        e(RecyclerView.c0 c0Var, View view, ViewPropertyAnimator viewPropertyAnimator) {
            this.f1207a = c0Var;
            this.f1208b = view;
            this.f1209c = viewPropertyAnimator;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            this.f1208b.setAlpha(1.0f);
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f1209c.setListener(null);
            c.this.A(this.f1207a);
            c.this.o.remove(this.f1207a);
            c.this.V();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            c.this.B(this.f1207a);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ RecyclerView.c0 f1211a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ int f1212b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ View f1213c;

        /* renamed from: d  reason: collision with root package name */
        final /* synthetic */ int f1214d;
        final /* synthetic */ ViewPropertyAnimator e;

        f(RecyclerView.c0 c0Var, int i, View view, int i2, ViewPropertyAnimator viewPropertyAnimator) {
            this.f1211a = c0Var;
            this.f1212b = i;
            this.f1213c = view;
            this.f1214d = i2;
            this.e = viewPropertyAnimator;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationCancel(Animator animator) {
            if (this.f1212b != 0) {
                this.f1213c.setTranslationX(0.0f);
            }
            if (this.f1214d != 0) {
                this.f1213c.setTranslationY(0.0f);
            }
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.e.setListener(null);
            c.this.E(this.f1211a);
            c.this.p.remove(this.f1211a);
            c.this.V();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            c.this.F(this.f1211a);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ i f1215a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ViewPropertyAnimator f1216b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ View f1217c;

        g(i iVar, ViewPropertyAnimator viewPropertyAnimator, View view) {
            this.f1215a = iVar;
            this.f1216b = viewPropertyAnimator;
            this.f1217c = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f1216b.setListener(null);
            this.f1217c.setAlpha(1.0f);
            this.f1217c.setTranslationX(0.0f);
            this.f1217c.setTranslationY(0.0f);
            c.this.C(this.f1215a.f1223a, true);
            c.this.r.remove(this.f1215a.f1223a);
            c.this.V();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            c.this.D(this.f1215a.f1223a, true);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class h extends AnimatorListenerAdapter {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ i f1219a;

        /* renamed from: b  reason: collision with root package name */
        final /* synthetic */ ViewPropertyAnimator f1220b;

        /* renamed from: c  reason: collision with root package name */
        final /* synthetic */ View f1221c;

        h(i iVar, ViewPropertyAnimator viewPropertyAnimator, View view) {
            this.f1219a = iVar;
            this.f1220b = viewPropertyAnimator;
            this.f1221c = view;
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationEnd(Animator animator) {
            this.f1220b.setListener(null);
            this.f1221c.setAlpha(1.0f);
            this.f1221c.setTranslationX(0.0f);
            this.f1221c.setTranslationY(0.0f);
            c.this.C(this.f1219a.f1224b, false);
            c.this.r.remove(this.f1219a.f1224b);
            c.this.V();
        }

        @Override // android.animation.AnimatorListenerAdapter, android.animation.Animator.AnimatorListener
        public void onAnimationStart(Animator animator) {
            c.this.D(this.f1219a.f1224b, false);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class i {

        /* renamed from: a  reason: collision with root package name */
        public RecyclerView.c0 f1223a;

        /* renamed from: b  reason: collision with root package name */
        public RecyclerView.c0 f1224b;

        /* renamed from: c  reason: collision with root package name */
        public int f1225c;

        /* renamed from: d  reason: collision with root package name */
        public int f1226d;
        public int e;
        public int f;

        private i(RecyclerView.c0 c0Var, RecyclerView.c0 c0Var2) {
            this.f1223a = c0Var;
            this.f1224b = c0Var2;
        }

        i(RecyclerView.c0 c0Var, RecyclerView.c0 c0Var2, int i, int i2, int i3, int i4) {
            this(c0Var, c0Var2);
            this.f1225c = i;
            this.f1226d = i2;
            this.e = i3;
            this.f = i4;
        }

        public String toString() {
            return "ChangeInfo{oldHolder=" + this.f1223a + ", newHolder=" + this.f1224b + ", fromX=" + this.f1225c + ", fromY=" + this.f1226d + ", toX=" + this.e + ", toY=" + this.f + '}';
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static class j {

        /* renamed from: a  reason: collision with root package name */
        public RecyclerView.c0 f1227a;

        /* renamed from: b  reason: collision with root package name */
        public int f1228b;

        /* renamed from: c  reason: collision with root package name */
        public int f1229c;

        /* renamed from: d  reason: collision with root package name */
        public int f1230d;
        public int e;

        j(RecyclerView.c0 c0Var, int i, int i2, int i3, int i4) {
            this.f1227a = c0Var;
            this.f1228b = i;
            this.f1229c = i2;
            this.f1230d = i3;
            this.e = i4;
        }
    }

    private void T(RecyclerView.c0 c0Var) {
        View view = c0Var.f1123b;
        ViewPropertyAnimator animate = view.animate();
        this.q.add(c0Var);
        animate.setDuration(o()).alpha(0.0f).setListener(new d(c0Var, animate, view)).start();
    }

    private void W(List<i> list, RecyclerView.c0 c0Var) {
        for (int size = list.size() - 1; size >= 0; size--) {
            i iVar = list.get(size);
            if (Y(iVar, c0Var) && iVar.f1223a == null && iVar.f1224b == null) {
                list.remove(iVar);
            }
        }
    }

    private void X(i iVar) {
        RecyclerView.c0 c0Var = iVar.f1223a;
        if (c0Var != null) {
            Y(iVar, c0Var);
        }
        RecyclerView.c0 c0Var2 = iVar.f1224b;
        if (c0Var2 != null) {
            Y(iVar, c0Var2);
        }
    }

    private boolean Y(i iVar, RecyclerView.c0 c0Var) {
        boolean z = false;
        if (iVar.f1224b == c0Var) {
            iVar.f1224b = null;
        } else if (iVar.f1223a != c0Var) {
            return false;
        } else {
            iVar.f1223a = null;
            z = true;
        }
        c0Var.f1123b.setAlpha(1.0f);
        c0Var.f1123b.setTranslationX(0.0f);
        c0Var.f1123b.setTranslationY(0.0f);
        C(c0Var, z);
        return true;
    }

    private void Z(RecyclerView.c0 c0Var) {
        if (s == null) {
            s = new ValueAnimator().getInterpolator();
        }
        c0Var.f1123b.animate().setInterpolator(s);
        j(c0Var);
    }

    void Q(RecyclerView.c0 c0Var) {
        View view = c0Var.f1123b;
        ViewPropertyAnimator animate = view.animate();
        this.o.add(c0Var);
        animate.alpha(1.0f).setDuration(l()).setListener(new e(c0Var, view, animate)).start();
    }

    void R(i iVar) {
        RecyclerView.c0 c0Var = iVar.f1223a;
        View view = c0Var == null ? null : c0Var.f1123b;
        RecyclerView.c0 c0Var2 = iVar.f1224b;
        View view2 = c0Var2 != null ? c0Var2.f1123b : null;
        if (view != null) {
            ViewPropertyAnimator duration = view.animate().setDuration(m());
            this.r.add(iVar.f1223a);
            duration.translationX(iVar.e - iVar.f1225c);
            duration.translationY(iVar.f - iVar.f1226d);
            duration.alpha(0.0f).setListener(new g(iVar, duration, view)).start();
        }
        if (view2 != null) {
            ViewPropertyAnimator animate = view2.animate();
            this.r.add(iVar.f1224b);
            animate.translationX(0.0f).translationY(0.0f).setDuration(m()).alpha(1.0f).setListener(new h(iVar, animate, view2)).start();
        }
    }

    void S(RecyclerView.c0 c0Var, int i2, int i3, int i4, int i5) {
        View view = c0Var.f1123b;
        int i6 = i4 - i2;
        int i7 = i5 - i3;
        if (i6 != 0) {
            view.animate().translationX(0.0f);
        }
        if (i7 != 0) {
            view.animate().translationY(0.0f);
        }
        ViewPropertyAnimator animate = view.animate();
        this.p.add(c0Var);
        animate.setDuration(n()).setListener(new f(c0Var, i6, view, i7, animate)).start();
    }

    void U(List<RecyclerView.c0> list) {
        for (int size = list.size() - 1; size >= 0; size--) {
            list.get(size).f1123b.animate().cancel();
        }
    }

    void V() {
        if (p()) {
            return;
        }
        i();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.l
    public boolean g(RecyclerView.c0 c0Var, List<Object> list) {
        return !list.isEmpty() || super.g(c0Var, list);
    }

    @Override // androidx.recyclerview.widget.RecyclerView.l
    public void j(RecyclerView.c0 c0Var) {
        View view = c0Var.f1123b;
        view.animate().cancel();
        int size = this.j.size();
        while (true) {
            size--;
            if (size < 0) {
                break;
            } else if (this.j.get(size).f1227a == c0Var) {
                view.setTranslationY(0.0f);
                view.setTranslationX(0.0f);
                E(c0Var);
                this.j.remove(size);
            }
        }
        W(this.k, c0Var);
        if (this.h.remove(c0Var)) {
            view.setAlpha(1.0f);
            G(c0Var);
        }
        if (this.i.remove(c0Var)) {
            view.setAlpha(1.0f);
            A(c0Var);
        }
        for (int size2 = this.n.size() - 1; size2 >= 0; size2--) {
            ArrayList<i> arrayList = this.n.get(size2);
            W(arrayList, c0Var);
            if (arrayList.isEmpty()) {
                this.n.remove(size2);
            }
        }
        for (int size3 = this.m.size() - 1; size3 >= 0; size3--) {
            ArrayList<j> arrayList2 = this.m.get(size3);
            int size4 = arrayList2.size() - 1;
            while (true) {
                if (size4 < 0) {
                    break;
                } else if (arrayList2.get(size4).f1227a == c0Var) {
                    view.setTranslationY(0.0f);
                    view.setTranslationX(0.0f);
                    E(c0Var);
                    arrayList2.remove(size4);
                    if (arrayList2.isEmpty()) {
                        this.m.remove(size3);
                    }
                } else {
                    size4--;
                }
            }
        }
        for (int size5 = this.l.size() - 1; size5 >= 0; size5--) {
            ArrayList<RecyclerView.c0> arrayList3 = this.l.get(size5);
            if (arrayList3.remove(c0Var)) {
                view.setAlpha(1.0f);
                A(c0Var);
                if (arrayList3.isEmpty()) {
                    this.l.remove(size5);
                }
            }
        }
        this.q.remove(c0Var);
        this.o.remove(c0Var);
        this.r.remove(c0Var);
        this.p.remove(c0Var);
        V();
    }

    @Override // androidx.recyclerview.widget.RecyclerView.l
    public void k() {
        int size = this.j.size();
        while (true) {
            size--;
            if (size < 0) {
                break;
            }
            j jVar = this.j.get(size);
            View view = jVar.f1227a.f1123b;
            view.setTranslationY(0.0f);
            view.setTranslationX(0.0f);
            E(jVar.f1227a);
            this.j.remove(size);
        }
        for (int size2 = this.h.size() - 1; size2 >= 0; size2--) {
            G(this.h.get(size2));
            this.h.remove(size2);
        }
        int size3 = this.i.size();
        while (true) {
            size3--;
            if (size3 < 0) {
                break;
            }
            RecyclerView.c0 c0Var = this.i.get(size3);
            c0Var.f1123b.setAlpha(1.0f);
            A(c0Var);
            this.i.remove(size3);
        }
        for (int size4 = this.k.size() - 1; size4 >= 0; size4--) {
            X(this.k.get(size4));
        }
        this.k.clear();
        if (p()) {
            for (int size5 = this.m.size() - 1; size5 >= 0; size5--) {
                ArrayList<j> arrayList = this.m.get(size5);
                for (int size6 = arrayList.size() - 1; size6 >= 0; size6--) {
                    j jVar2 = arrayList.get(size6);
                    View view2 = jVar2.f1227a.f1123b;
                    view2.setTranslationY(0.0f);
                    view2.setTranslationX(0.0f);
                    E(jVar2.f1227a);
                    arrayList.remove(size6);
                    if (arrayList.isEmpty()) {
                        this.m.remove(arrayList);
                    }
                }
            }
            for (int size7 = this.l.size() - 1; size7 >= 0; size7--) {
                ArrayList<RecyclerView.c0> arrayList2 = this.l.get(size7);
                for (int size8 = arrayList2.size() - 1; size8 >= 0; size8--) {
                    RecyclerView.c0 c0Var2 = arrayList2.get(size8);
                    c0Var2.f1123b.setAlpha(1.0f);
                    A(c0Var2);
                    arrayList2.remove(size8);
                    if (arrayList2.isEmpty()) {
                        this.l.remove(arrayList2);
                    }
                }
            }
            for (int size9 = this.n.size() - 1; size9 >= 0; size9--) {
                ArrayList<i> arrayList3 = this.n.get(size9);
                for (int size10 = arrayList3.size() - 1; size10 >= 0; size10--) {
                    X(arrayList3.get(size10));
                    if (arrayList3.isEmpty()) {
                        this.n.remove(arrayList3);
                    }
                }
            }
            U(this.q);
            U(this.p);
            U(this.o);
            U(this.r);
            i();
        }
    }

    @Override // androidx.recyclerview.widget.RecyclerView.l
    public boolean p() {
        return (this.i.isEmpty() && this.k.isEmpty() && this.j.isEmpty() && this.h.isEmpty() && this.p.isEmpty() && this.q.isEmpty() && this.o.isEmpty() && this.r.isEmpty() && this.m.isEmpty() && this.l.isEmpty() && this.n.isEmpty()) ? false : true;
    }

    @Override // androidx.recyclerview.widget.RecyclerView.l
    public void u() {
        boolean z = !this.h.isEmpty();
        boolean z2 = !this.j.isEmpty();
        boolean z3 = !this.k.isEmpty();
        boolean z4 = !this.i.isEmpty();
        if (z || z2 || z4 || z3) {
            Iterator<RecyclerView.c0> it = this.h.iterator();
            while (it.hasNext()) {
                T(it.next());
            }
            this.h.clear();
            if (z2) {
                ArrayList<j> arrayList = new ArrayList<>();
                arrayList.addAll(this.j);
                this.m.add(arrayList);
                this.j.clear();
                a aVar = new a(arrayList);
                if (z) {
                    r.M(arrayList.get(0).f1227a.f1123b, aVar, o());
                } else {
                    aVar.run();
                }
            }
            if (z3) {
                ArrayList<i> arrayList2 = new ArrayList<>();
                arrayList2.addAll(this.k);
                this.n.add(arrayList2);
                this.k.clear();
                b bVar = new b(arrayList2);
                if (z) {
                    r.M(arrayList2.get(0).f1223a.f1123b, bVar, o());
                } else {
                    bVar.run();
                }
            }
            if (z4) {
                ArrayList<RecyclerView.c0> arrayList3 = new ArrayList<>();
                arrayList3.addAll(this.i);
                this.l.add(arrayList3);
                this.i.clear();
                RunnableC0041c runnableC0041c = new RunnableC0041c(arrayList3);
                if (z || z2 || z3) {
                    r.M(arrayList3.get(0).f1123b, runnableC0041c, (z ? o() : 0L) + Math.max(z2 ? n() : 0L, z3 ? m() : 0L));
                } else {
                    runnableC0041c.run();
                }
            }
        }
    }

    @Override // androidx.recyclerview.widget.l
    public boolean w(RecyclerView.c0 c0Var) {
        Z(c0Var);
        c0Var.f1123b.setAlpha(0.0f);
        this.i.add(c0Var);
        return true;
    }

    @Override // androidx.recyclerview.widget.l
    public boolean x(RecyclerView.c0 c0Var, RecyclerView.c0 c0Var2, int i2, int i3, int i4, int i5) {
        if (c0Var == c0Var2) {
            return y(c0Var, i2, i3, i4, i5);
        }
        float translationX = c0Var.f1123b.getTranslationX();
        float translationY = c0Var.f1123b.getTranslationY();
        float alpha = c0Var.f1123b.getAlpha();
        Z(c0Var);
        int i6 = (int) ((i4 - i2) - translationX);
        int i7 = (int) ((i5 - i3) - translationY);
        c0Var.f1123b.setTranslationX(translationX);
        c0Var.f1123b.setTranslationY(translationY);
        c0Var.f1123b.setAlpha(alpha);
        if (c0Var2 != null) {
            Z(c0Var2);
            c0Var2.f1123b.setTranslationX(-i6);
            c0Var2.f1123b.setTranslationY(-i7);
            c0Var2.f1123b.setAlpha(0.0f);
        }
        this.k.add(new i(c0Var, c0Var2, i2, i3, i4, i5));
        return true;
    }

    @Override // androidx.recyclerview.widget.l
    public boolean y(RecyclerView.c0 c0Var, int i2, int i3, int i4, int i5) {
        View view = c0Var.f1123b;
        int translationX = i2 + ((int) view.getTranslationX());
        int translationY = i3 + ((int) c0Var.f1123b.getTranslationY());
        Z(c0Var);
        int i6 = i4 - translationX;
        int i7 = i5 - translationY;
        if (i6 == 0 && i7 == 0) {
            E(c0Var);
            return false;
        }
        if (i6 != 0) {
            view.setTranslationX(-i6);
        }
        if (i7 != 0) {
            view.setTranslationY(-i7);
        }
        this.j.add(new j(c0Var, translationX, translationY, i4, i5));
        return true;
    }

    @Override // androidx.recyclerview.widget.l
    public boolean z(RecyclerView.c0 c0Var) {
        Z(c0Var);
        this.h.add(c0Var);
        return true;
    }
}
