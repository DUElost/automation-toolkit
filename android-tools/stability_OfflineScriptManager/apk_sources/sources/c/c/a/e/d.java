package c.c.a.e;

import java.util.HashMap;
import java.util.Map;
import java.util.regex.Pattern;
/* loaded from: classes.dex */
public class d extends c.c.a.e.b {
    public static a e = new a();
    private static final Map<String, Boolean> f;

    /* loaded from: classes.dex */
    public static final class a extends c.c.a.e.a {
    }

    /* loaded from: classes.dex */
    public class b extends c.c.a.e.a {
        public b(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class c extends c.c.a.e.a {
        public c(d dVar) {
        }
    }

    /* renamed from: c.c.a.e.d$d  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public class C0060d extends c.c.a.e.a {
        public C0060d(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class e extends c.c.a.e.a {
        public e(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class f {
        public f(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class g extends c.c.a.e.a {
        public g(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class h extends c.c.a.e.a {
        public h(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class i extends c.c.a.e.a {
        public i(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class j {
        public j(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class k {
        public k(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class l extends c.c.a.e.a {
        public l(d dVar) {
        }
    }

    /* loaded from: classes.dex */
    public class m extends c.c.a.e.a {
        public m(d dVar) {
        }
    }

    static {
        HashMap hashMap = new HashMap();
        f = hashMap;
        Boolean bool = Boolean.TRUE;
        hashMap.put("yes", bool);
        Boolean bool2 = Boolean.FALSE;
        hashMap.put("no", bool2);
        hashMap.put("true", bool);
        hashMap.put("false", bool2);
        hashMap.put("on", bool);
        hashMap.put("off", bool2);
        Pattern.compile("^([0-9][0-9][0-9][0-9])-([0-9][0-9]?)-([0-9][0-9]?)(?:(?:[Tt]|[ \t]+)([0-9][0-9]?):([0-9][0-9]):([0-9][0-9])(?:\\.([0-9]*))?(?:[ \t]*(?:Z|([-+][0-9][0-9]?)(?::([0-9][0-9])?)?))?)?$");
        Pattern.compile("^([0-9][0-9][0-9][0-9])-([0-9][0-9]?)-([0-9][0-9]?)$");
    }

    public d() {
        this.f1734b.put(c.c.a.k.i.n, new g(this));
        this.f1734b.put(c.c.a.k.i.m, new c(this));
        this.f1734b.put(c.c.a.k.i.j, new e(this));
        this.f1734b.put(c.c.a.k.i.k, new C0060d(this));
        this.f1734b.put(c.c.a.k.i.i, new b(this));
        this.f1734b.put(c.c.a.k.i.l, new m(this));
        this.f1734b.put(c.c.a.k.i.h, new h(this));
        this.f1734b.put(c.c.a.k.i.g, new i(this));
        this.f1734b.put(c.c.a.k.i.f, new k(this));
        this.f1734b.put(c.c.a.k.i.o, new l(this));
        this.f1734b.put(c.c.a.k.i.p, new j(this));
        this.f1734b.put(c.c.a.k.i.q, new f(this));
        this.f1734b.put(null, e);
        this.f1733a.put(c.c.a.k.e.scalar, e);
        this.f1733a.put(c.c.a.k.e.sequence, e);
        this.f1733a.put(c.c.a.k.e.mapping, e);
    }
}
