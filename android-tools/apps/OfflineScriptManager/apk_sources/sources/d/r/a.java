package d.r;

import d.s.f;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
/* loaded from: classes.dex */
public class a {

    /* renamed from: c  reason: collision with root package name */
    private d.p.b f2692c;

    /* renamed from: b  reason: collision with root package name */
    private int f2691b = 0;

    /* renamed from: d  reason: collision with root package name */
    private int f2693d = 0;
    private boolean e = false;

    /* renamed from: a  reason: collision with root package name */
    private final List<d.p.b> f2690a = new ArrayList();

    public void a(d.p.b bVar) {
        List<d.p.b> list = this.f2690a;
        Collections.swap(list, list.indexOf(bVar), this.f2691b);
        this.f2691b++;
    }

    public void b(d.p.b bVar) {
        List<d.p.b> list;
        this.f2690a.add(bVar);
        Collections.swap(this.f2690a, this.f2691b, list.size() - 1);
        this.f2691b++;
    }

    public d.e c(d.s.c cVar, f<d.p.b> fVar) {
        while (this.f2691b > 0) {
            d.p.b bVar = this.f2690a.get(this.f2693d);
            d.e I0 = bVar.I0();
            if (I0 != null) {
                if (fVar != null) {
                    fVar.b(bVar);
                }
                boolean j = I0.j();
                this.e = j;
                if (!j) {
                    this.f2692c = bVar;
                    this.f2693d = (this.f2693d + 1) % this.f2691b;
                }
                return I0;
            }
            int i = this.f2691b - 1;
            this.f2691b = i;
            Collections.swap(this.f2690a, this.f2693d, i);
            if (this.f2693d == this.f2691b) {
                this.f2693d = 0;
            }
        }
        cVar.c(35);
        return null;
    }

    public void d(d.p.b bVar) {
        int indexOf = this.f2690a.indexOf(bVar);
        int i = this.f2691b;
        if (indexOf < i) {
            int i2 = i - 1;
            this.f2691b = i2;
            Collections.swap(this.f2690a, indexOf, i2);
            if (this.f2693d == this.f2691b) {
                this.f2693d = 0;
            }
        }
        this.f2690a.remove(bVar);
        d.p.b bVar2 = this.f2692c;
        if (bVar2 == bVar) {
            bVar2.C0();
            this.f2692c = null;
        }
    }
}
