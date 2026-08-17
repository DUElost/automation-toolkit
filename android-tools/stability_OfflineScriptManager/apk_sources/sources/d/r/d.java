package d.r;

import d.r.h.c;
import java.util.Arrays;
import java.util.List;
/* loaded from: classes.dex */
public enum d {
    PAIR("PAIR") { // from class: d.r.d.d
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.c(cVar, i, i2);
        }
    },
    PUB("SUB", "XSUB") { // from class: d.r.d.e
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.g.c(cVar, i, i2);
        }
    },
    SUB("PUB", "XPUB") { // from class: d.r.d.f
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.g.d(cVar, i, i2);
        }
    },
    REQ("REP", "ROUTER") { // from class: d.r.d.g
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.h.c(cVar, i, i2);
        }

        @Override // d.r.d
        public d.n.f d(d.n.d dVar, boolean z, d.j jVar, d.f fVar, d.n.j.a aVar) {
            return new c.a(dVar, z, jVar, fVar, aVar);
        }
    },
    REP("REQ", "DEALER") { // from class: d.r.d.h
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.h.b(cVar, i, i2);
        }
    },
    DEALER("REP", "DEALER", "ROUTER") { // from class: d.r.d.i
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.h.a(cVar, i, i2);
        }
    },
    ROUTER("REQ", "DEALER", "ROUTER") { // from class: d.r.d.j
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.h.d(cVar, i, i2);
        }
    },
    PULL("PUSH") { // from class: d.r.d.k
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.f.a(cVar, i, i2);
        }
    },
    PUSH("PULL") { // from class: d.r.d.l
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.f.b(cVar, i, i2);
        }
    },
    XPUB("SUB", "XSUB") { // from class: d.r.d.a
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.g.f(cVar, i, i2);
        }
    },
    XSUB("PUB", "XPUB") { // from class: d.r.d.b
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.g.g(cVar, i, i2);
        }
    },
    STREAM(new String[0]) { // from class: d.r.d.c
        @Override // d.r.d
        d.j c(d.c cVar, int i, int i2) {
            return new d.r.e(cVar, i, i2);
        }
    };
    

    /* renamed from: b  reason: collision with root package name */
    private final List<String> f2700b;

    d(String... strArr) {
        this.f2700b = Arrays.asList(strArr);
    }

    /* synthetic */ d(String[] strArr, d dVar) {
        this(strArr);
    }

    public static boolean a(int i2, String str) {
        return valuesCustom()[i2].f2700b.contains(str);
    }

    public static d.j b(int i2, d.c cVar, int i3, int i4) {
        return valuesCustom()[i2].c(cVar, i3, i4);
    }

    public static d.n.f e(d.n.d dVar, boolean z, d.j jVar, d.f fVar, d.n.j.a aVar) {
        return valuesCustom()[fVar.j].d(dVar, z, jVar, fVar, aVar);
    }

    public static d f(int i2) {
        return valuesCustom()[i2];
    }

    public static String g(int i2) {
        return valuesCustom()[i2].name();
    }

    /* renamed from: values  reason: to resolve conflict with enum method */
    public static d[] valuesCustom() {
        d[] valuesCustom = values();
        int length = valuesCustom.length;
        d[] dVarArr = new d[length];
        System.arraycopy(valuesCustom, 0, dVarArr, 0, length);
        return dVarArr;
    }

    abstract d.j c(d.c cVar, int i2, int i3);

    public d.n.f d(d.n.d dVar, boolean z, d.j jVar, d.f fVar, d.n.j.a aVar) {
        return new d.n.f(dVar, z, jVar, fVar, aVar);
    }
}
