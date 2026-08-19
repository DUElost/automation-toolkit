package b.h.a.a.c;

import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private int f1659a;

    /* renamed from: b  reason: collision with root package name */
    private int f1660b;

    /* renamed from: c  reason: collision with root package name */
    private a f1661c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f1662d;
    private boolean e = true;
    private final List<a> f = new ArrayList();
    private AbstractC0055a g;
    private b h;
    private c i;
    private Object j;
    private boolean k;

    /* renamed from: b.h.a.a.c.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static abstract class AbstractC0055a<E> {

        /* renamed from: a  reason: collision with root package name */
        protected b.h.a.a.d.a f1663a;

        /* renamed from: b  reason: collision with root package name */
        protected a f1664b;

        /* renamed from: c  reason: collision with root package name */
        private View f1665c;

        /* renamed from: d  reason: collision with root package name */
        protected int f1666d;
        protected Context e;

        public AbstractC0055a(Context context) {
            this.e = context;
        }

        public abstract View c(a aVar, E e);

        public int d() {
            return this.f1666d;
        }

        public ViewGroup e() {
            return (ViewGroup) h().findViewById(b.h.a.a.a.node_items);
        }

        /* JADX WARN: Multi-variable type inference failed */
        public View f() {
            a aVar = this.f1664b;
            return c(aVar, aVar.i());
        }

        public b.h.a.a.d.a g() {
            return this.f1663a;
        }

        public View h() {
            View view = this.f1665c;
            if (view != null) {
                return view;
            }
            View f = f();
            b.h.a.a.d.b bVar = new b.h.a.a.d.b(f.getContext(), d());
            bVar.b(f);
            this.f1665c = bVar;
            return bVar;
        }

        public boolean i() {
            return this.f1665c != null;
        }

        public void j(int i) {
            this.f1666d = i;
        }

        public void k(b.h.a.a.d.a aVar) {
            this.f1663a = aVar;
        }

        public void l(boolean z) {
        }

        public void m(boolean z) {
        }
    }

    /* loaded from: classes.dex */
    public interface b {
        void a(a aVar, Object obj);
    }

    /* loaded from: classes.dex */
    public interface c {
        boolean a(a aVar, Object obj);
    }

    public a(Object obj) {
        this.j = obj;
    }

    private int c() {
        int i = this.f1660b + 1;
        this.f1660b = i;
        return i;
    }

    public static a p() {
        a aVar = new a(null);
        aVar.s(false);
        return aVar;
    }

    public a a(a aVar) {
        aVar.f1661c = this;
        aVar.f1659a = c();
        this.f.add(aVar);
        return this;
    }

    public a b(a... aVarArr) {
        for (a aVar : aVarArr) {
            a(aVar);
        }
        return this;
    }

    public List<a> d() {
        return Collections.unmodifiableList(this.f);
    }

    public b e() {
        return this.h;
    }

    public int f() {
        return this.f1659a;
    }

    public c g() {
        return this.i;
    }

    public a h() {
        return this.f1661c;
    }

    public Object i() {
        return this.j;
    }

    public AbstractC0055a j() {
        return this.g;
    }

    public boolean k() {
        return this.k;
    }

    public boolean l() {
        int size;
        return !n() && (size = this.f1661c.f.size()) > 0 && this.f1661c.f.get(size - 1).f1659a == this.f1659a;
    }

    public boolean m() {
        return v() == 0;
    }

    public boolean n() {
        return this.f1661c == null;
    }

    public boolean o() {
        return this.e && this.f1662d;
    }

    public a q(boolean z) {
        this.k = z;
        return this;
    }

    public a r(c cVar) {
        this.i = cVar;
        return this;
    }

    public void s(boolean z) {
        this.e = z;
    }

    public void t(boolean z) {
        this.f1662d = z;
    }

    public a u(AbstractC0055a abstractC0055a) {
        this.g = abstractC0055a;
        if (abstractC0055a != null) {
            abstractC0055a.f1664b = this;
        }
        return this;
    }

    public int v() {
        return this.f.size();
    }
}
