package c.c.a.e;

import c.c.a.k.e;
import c.c.a.k.i;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;
/* loaded from: classes.dex */
public class c extends c.c.a.e.d {
    private final Map<i, Class<? extends Object>> g;
    private final Map<Class<? extends Object>, c.c.a.c> h;

    /* loaded from: classes.dex */
    protected class a {
        protected a(c cVar) {
        }
    }

    /* loaded from: classes.dex */
    protected class b extends c.c.a.e.a {
        protected b(c cVar) {
        }
    }

    /* renamed from: c.c.a.e.c$c  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    protected class C0059c {
        protected C0059c(c cVar) {
        }
    }

    /* loaded from: classes.dex */
    protected class d {
        protected d(c cVar) {
        }
    }

    public c() {
        this(Object.class);
    }

    public c(c.c.a.c cVar) {
        Objects.requireNonNull(cVar, "Root type must be provided.");
        this.f1734b.put(null, new d(this));
        if (!Object.class.equals(cVar.b())) {
            new i(cVar.b());
        }
        this.g = new HashMap();
        this.h = new HashMap();
        this.f1733a.put(e.scalar, new b(this));
        this.f1733a.put(e.mapping, new a(this));
        this.f1733a.put(e.sequence, new C0059c(this));
        d(cVar);
    }

    /* JADX WARN: 'this' call moved to the top of the method (can break code semantics) */
    public c(Class<? extends Object> cls) {
        this(new c.c.a.c(cls));
        e(cls);
    }

    private static Class<? extends Object> e(Class<? extends Object> cls) {
        Objects.requireNonNull(cls, "Root class must be provided.");
        return cls;
    }

    public c.c.a.c d(c.c.a.c cVar) {
        Objects.requireNonNull(cVar, "TypeDescription is required.");
        this.g.put(cVar.a(), cVar.b());
        return this.h.put(cVar.b(), cVar);
    }
}
