package d.r;

import d.s.f;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
/* loaded from: classes.dex */
public class b {

    /* renamed from: b  reason: collision with root package name */
    private int f2695b = 0;

    /* renamed from: c  reason: collision with root package name */
    private int f2696c = 0;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2697d = false;
    private boolean e = false;

    /* renamed from: a  reason: collision with root package name */
    private final List<d.p.b> f2694a = new ArrayList();

    public void a(d.p.b bVar) {
        List<d.p.b> list = this.f2694a;
        Collections.swap(list, list.indexOf(bVar), this.f2695b);
        this.f2695b++;
    }

    public void b(d.p.b bVar) {
        this.f2694a.add(bVar);
        a(bVar);
    }

    public boolean c(d.e eVar, d.s.c cVar, f<d.p.b> fVar) {
        if (this.e) {
            boolean j = eVar.j();
            this.f2697d = j;
            this.e = j;
            return true;
        }
        while (true) {
            if (this.f2695b <= 0) {
                break;
            } else if (!this.f2694a.get(this.f2696c).Q0(eVar)) {
                int i = this.f2695b - 1;
                this.f2695b = i;
                int i2 = this.f2696c;
                if (i2 < i) {
                    Collections.swap(this.f2694a, i2, i);
                } else {
                    this.f2696c = 0;
                }
            } else if (fVar != null) {
                fVar.b(this.f2694a.get(this.f2696c));
            }
        }
        if (this.f2695b == 0) {
            cVar.c(35);
            return false;
        }
        boolean j2 = eVar.j();
        this.f2697d = j2;
        if (!j2) {
            this.f2694a.get(this.f2696c).B0();
            int i3 = this.f2696c + 1;
            this.f2696c = i3;
            if (i3 >= this.f2695b) {
                this.f2696c = 0;
            }
        }
        return true;
    }

    public void d(d.p.b bVar) {
        int indexOf = this.f2694a.indexOf(bVar);
        if (indexOf == this.f2696c && this.f2697d) {
            this.e = true;
        }
        int i = this.f2695b;
        if (indexOf < i) {
            int i2 = i - 1;
            this.f2695b = i2;
            Collections.swap(this.f2694a, indexOf, i2);
            if (this.f2696c == this.f2695b) {
                this.f2696c = 0;
            }
        }
        this.f2694a.remove(bVar);
    }
}
