package d.r.g;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
/* loaded from: classes.dex */
class a {

    /* renamed from: b  reason: collision with root package name */
    private int f2704b = 0;

    /* renamed from: c  reason: collision with root package name */
    private int f2705c = 0;

    /* renamed from: d  reason: collision with root package name */
    private int f2706d = 0;
    private boolean e = false;

    /* renamed from: a  reason: collision with root package name */
    private final List<d.p.b> f2703a = new ArrayList();

    private void d(d.e eVar) {
        if (this.f2704b == 0) {
            return;
        }
        int i = 0;
        while (i < this.f2704b) {
            if (!j(this.f2703a.get(i), eVar)) {
                i--;
            }
            i++;
        }
    }

    private boolean j(d.p.b bVar, d.e eVar) {
        if (bVar.Q0(eVar)) {
            if (!eVar.j()) {
                bVar.B0();
            }
            return true;
        }
        List<d.p.b> list = this.f2703a;
        Collections.swap(list, list.indexOf(bVar), this.f2704b - 1);
        this.f2704b--;
        List<d.p.b> list2 = this.f2703a;
        Collections.swap(list2, list2.indexOf(bVar), this.f2705c - 1);
        int i = this.f2705c - 1;
        this.f2705c = i;
        Collections.swap(this.f2703a, i, this.f2706d - 1);
        this.f2706d--;
        return false;
    }

    public void a(d.p.b bVar) {
        List<d.p.b> list = this.f2703a;
        Collections.swap(list, list.indexOf(bVar), this.f2706d);
        int i = this.f2706d + 1;
        this.f2706d = i;
        if (this.e) {
            return;
        }
        Collections.swap(this.f2703a, i - 1, this.f2705c);
        this.f2705c++;
    }

    public void b(d.p.b bVar) {
        List<d.p.b> list;
        List<d.p.b> list2;
        if (this.e) {
            this.f2703a.add(bVar);
            Collections.swap(this.f2703a, this.f2706d, list2.size() - 1);
        } else {
            this.f2703a.add(bVar);
            Collections.swap(this.f2703a, this.f2705c, list.size() - 1);
            this.f2705c++;
        }
        this.f2706d++;
    }

    public boolean c() {
        for (int i = 0; i < this.f2704b; i++) {
            if (!this.f2703a.get(i).x0()) {
                return false;
            }
        }
        return true;
    }

    public void e(d.p.b bVar) {
        int indexOf = this.f2703a.indexOf(bVar);
        int i = this.f2704b;
        if (indexOf >= i && indexOf < this.f2706d) {
            Collections.swap(this.f2703a, indexOf, i);
            this.f2704b++;
        }
    }

    public boolean f(d.e eVar) {
        this.f2704b = this.f2705c;
        return g(eVar);
    }

    public boolean g(d.e eVar) {
        boolean j = eVar.j();
        d(eVar);
        if (!j) {
            this.f2705c = this.f2706d;
        }
        this.e = j;
        return true;
    }

    public void h(d.p.b bVar) {
        if (this.f2703a.indexOf(bVar) < this.f2704b) {
            List<d.p.b> list = this.f2703a;
            Collections.swap(list, list.indexOf(bVar), this.f2704b - 1);
            this.f2704b--;
        }
        if (this.f2703a.indexOf(bVar) < this.f2705c) {
            List<d.p.b> list2 = this.f2703a;
            Collections.swap(list2, list2.indexOf(bVar), this.f2705c - 1);
            this.f2705c--;
        }
        if (this.f2703a.indexOf(bVar) < this.f2706d) {
            List<d.p.b> list3 = this.f2703a;
            Collections.swap(list3, list3.indexOf(bVar), this.f2706d - 1);
            this.f2706d--;
        }
        this.f2703a.remove(bVar);
    }

    public void i() {
        this.f2704b = 0;
    }
}
