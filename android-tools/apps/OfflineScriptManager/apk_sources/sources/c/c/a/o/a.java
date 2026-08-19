package c.c.a.o;

import c.c.a.h.k;
import c.c.a.h.l;
import c.c.a.h.m;
import c.c.a.h.n;
import c.c.a.h.o;
import c.c.a.k.c;
import c.c.a.k.d;
import c.c.a.k.e;
import c.c.a.k.f;
import c.c.a.k.g;
import c.c.a.k.h;
import c.c.a.k.i;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
/* loaded from: classes.dex */
public final class a {

    /* renamed from: a  reason: collision with root package name */
    private final c.c.a.f.a f1839a;

    /* renamed from: b  reason: collision with root package name */
    private final c.c.a.m.a f1840b;

    /* renamed from: c  reason: collision with root package name */
    private boolean f1841c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f1842d;
    private Integer[] e;
    private Map<String, String> f;
    private Set<d> g;
    private Map<d, String> h;
    private int i;
    private Boolean j;
    private i k;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* renamed from: c.c.a.o.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static /* synthetic */ class C0065a {

        /* renamed from: a  reason: collision with root package name */
        static final /* synthetic */ int[] f1843a;

        static {
            int[] iArr = new int[e.values().length];
            f1843a = iArr;
            try {
                iArr[e.sequence.ordinal()] = 1;
            } catch (NoSuchFieldError unused) {
            }
            try {
                f1843a[e.mapping.ordinal()] = 2;
            } catch (NoSuchFieldError unused2) {
            }
            try {
                f1843a[e.scalar.ordinal()] = 3;
            } catch (NoSuchFieldError unused3) {
            }
        }
    }

    public a(c.c.a.f.a aVar, c.c.a.m.a aVar2, c.c.a.a aVar3, i iVar) {
        this.f1839a = aVar;
        this.f1840b = aVar2;
        this.f1841c = aVar3.n();
        this.f1842d = aVar3.m();
        if (aVar3.h() != null) {
            this.e = aVar3.h().a();
        }
        this.f = aVar3.g();
        this.g = new HashSet();
        this.h = new HashMap();
        this.i = 0;
        this.j = null;
        this.k = iVar;
    }

    private void a(d dVar) {
        if (dVar.b() == e.anchor) {
            dVar = ((c.c.a.k.a) dVar).f();
        }
        if (this.h.containsKey(dVar)) {
            if (this.h.get(dVar) == null) {
                this.h.put(dVar, c());
                return;
            }
            return;
        }
        this.h.put(dVar, null);
        int i = C0065a.f1843a[dVar.b().ordinal()];
        if (i == 1) {
            for (d dVar2 : ((h) dVar).h()) {
                a(dVar2);
            }
        } else if (i == 2) {
            for (f fVar : ((c) dVar).h()) {
                d a2 = fVar.a();
                d b2 = fVar.b();
                a(a2);
                a(b2);
            }
        }
    }

    private String c() {
        this.i++;
        NumberFormat numberInstance = NumberFormat.getNumberInstance();
        numberInstance.setMinimumIntegerDigits(3);
        numberInstance.setGroupingUsed(false);
        return "id" + numberInstance.format(this.i);
    }

    private void f(d dVar, d dVar2, Object obj) {
        c.c.a.f.a aVar;
        c.c.a.h.f lVar;
        if (dVar.b() == e.anchor) {
            dVar = ((c.c.a.k.a) dVar).f();
        }
        String str = this.h.get(dVar);
        if (this.g.contains(dVar)) {
            aVar = this.f1839a;
            lVar = new c.c.a.h.a(str, null, null);
        } else {
            this.g.add(dVar);
            int i = C0065a.f1843a[dVar.b().ordinal()];
            int i2 = 0;
            if (i == 1) {
                h hVar = (h) dVar;
                this.f1839a.a(new m(str, dVar.d().b(), dVar.d().equals(this.f1840b.c(e.sequence, null, true)), null, null, hVar.f()));
                for (d dVar3 : hVar.h()) {
                    f(dVar3, dVar, Integer.valueOf(i2));
                    i2++;
                }
                aVar = this.f1839a;
                lVar = new l(null, null);
            } else if (i == 3) {
                g gVar = (g) dVar;
                c.c.a.m.a aVar2 = this.f1840b;
                e eVar = e.scalar;
                this.f1839a.a(new k(str, dVar.d().b(), new c.c.a.h.g(dVar.d().equals(aVar2.c(eVar, gVar.g(), true)), dVar.d().equals(this.f1840b.c(eVar, gVar.g(), false))), gVar.g(), null, null, gVar.f()));
                return;
            } else {
                this.f1839a.a(new c.c.a.h.i(str, dVar.d().b(), dVar.d().equals(this.f1840b.c(e.mapping, null, true)), null, null, ((c.c.a.k.b) dVar).f()));
                c cVar = (c) dVar;
                for (f fVar : cVar.h()) {
                    d a2 = fVar.a();
                    d b2 = fVar.b();
                    f(a2, cVar, null);
                    f(b2, cVar, a2);
                }
                aVar = this.f1839a;
                lVar = new c.c.a.h.h(null, null);
            }
        }
        aVar.a(lVar);
    }

    public void b() {
        Boolean bool = this.j;
        if (bool == null) {
            throw new b("serializer is not opened");
        }
        Boolean bool2 = Boolean.TRUE;
        if (bool2.equals(bool)) {
            return;
        }
        this.f1839a.a(new n(null, null));
        this.j = bool2;
    }

    public void d() {
        Boolean bool = this.j;
        if (bool == null) {
            this.f1839a.a(new o(null, null));
            this.j = Boolean.FALSE;
        } else if (!Boolean.TRUE.equals(bool)) {
            throw new b("serializer is already opened");
        } else {
            throw new b("serializer is closed");
        }
    }

    public void e(d dVar) {
        Boolean bool = this.j;
        if (bool == null) {
            throw new b("serializer is not opened");
        }
        if (bool.booleanValue()) {
            throw new b("serializer is closed");
        }
        this.f1839a.a(new c.c.a.h.e(null, null, this.f1841c, this.e, this.f));
        a(dVar);
        i iVar = this.k;
        if (iVar != null) {
            dVar.e(iVar);
        }
        f(dVar, null, null);
        this.f1839a.a(new c.c.a.h.d(null, null, this.f1842d));
        this.g.clear();
        this.h.clear();
        this.i = 0;
    }
}
