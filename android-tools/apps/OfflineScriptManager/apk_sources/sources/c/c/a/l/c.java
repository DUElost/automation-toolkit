package c.c.a.l;

import c.c.a.a;
import c.c.a.j.e;
import c.c.a.k.f;
import c.c.a.k.g;
import c.c.a.k.h;
import c.c.a.k.i;
import java.beans.IntrospectionException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
/* loaded from: classes.dex */
public class c extends d {

    /* loaded from: classes.dex */
    protected class a implements b {
        protected a() {
        }

        /* JADX WARN: Multi-variable type inference failed */
        @Override // c.c.a.l.b
        public c.c.a.k.d a(Object obj) {
            try {
                c cVar = c.this;
                return cVar.o(cVar.n(obj.getClass()), obj);
            } catch (IntrospectionException e) {
                throw new c.c.a.g.b((Throwable) e);
            }
        }
    }

    public c() {
        this.f1810a.put(null, new a());
    }

    private void q(Class<? extends Object> cls, c.c.a.k.d dVar) {
        if (dVar.d().c(cls)) {
            dVar.e(Enum.class.isAssignableFrom(cls) ? i.o : i.q);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    protected void m(e eVar, c.c.a.k.d dVar, Object obj) {
        Class<?>[] c2 = eVar.c();
        if (c2 != null) {
            if (dVar.b() == c.c.a.k.e.sequence) {
                Class<?> cls = c2[0];
                h hVar = (h) dVar;
                Iterator it = (obj.getClass().isArray() ? Arrays.asList((Object[]) obj) : (Iterable) obj).iterator();
                for (c.c.a.k.d dVar2 : hVar.h()) {
                    Object next = it.next();
                    if (next != null && cls.equals(next.getClass()) && dVar2.b() == c.c.a.k.e.mapping) {
                        dVar2.e(i.q);
                    }
                }
            } else if (obj instanceof Set) {
                Class<?> cls2 = c2[0];
                Iterator<f> it2 = ((c.c.a.k.c) dVar).h().iterator();
                for (Object obj2 : (Set) obj) {
                    c.c.a.k.d a2 = it2.next().a();
                    if (cls2.equals(obj2.getClass()) && a2.b() == c.c.a.k.e.mapping) {
                        a2.e(i.q);
                    }
                }
            } else if (obj instanceof Map) {
                Class<?> cls3 = c2[0];
                Class<?> cls4 = c2[1];
                for (f fVar : ((c.c.a.k.c) dVar).h()) {
                    q(cls3, fVar.a());
                    q(cls4, fVar.b());
                }
            }
        }
    }

    protected Set<e> n(Class<? extends Object> cls) {
        return a().b(cls);
    }

    protected c.c.a.k.c o(Set<e> set, Object obj) {
        ArrayList arrayList = new ArrayList(set.size());
        i iVar = this.j.get(obj.getClass());
        if (iVar == null) {
            iVar = new i((Class<? extends Object>) obj.getClass());
        }
        c.c.a.k.c cVar = new c.c.a.k.c(iVar, arrayList, null);
        this.f.put(obj, cVar);
        boolean z = true;
        for (e eVar : set) {
            Object b2 = eVar.b(obj);
            f p = p(obj, eVar, b2, b2 == null ? null : this.j.get(b2.getClass()));
            if (p != null) {
                if (((g) p.a()).f() != null) {
                    z = false;
                }
                c.c.a.k.d b3 = p.b();
                z = ((b3 instanceof g) && ((g) b3).f() == null) ? false : false;
                arrayList.add(p);
            }
        }
        a.EnumC0058a enumC0058a = this.e;
        cVar.g(enumC0058a != a.EnumC0058a.AUTO ? enumC0058a.a() : Boolean.valueOf(z));
        return cVar;
    }

    protected f p(Object obj, e eVar, Object obj2, i iVar) {
        g gVar = (g) d(eVar.d());
        boolean containsKey = this.f.containsKey(obj2);
        c.c.a.k.d d2 = d(obj2);
        if (obj2 != null && !containsKey) {
            c.c.a.k.e b2 = d2.b();
            if (iVar == null) {
                if (b2 != c.c.a.k.e.scalar) {
                    if (b2 == c.c.a.k.e.mapping && eVar.e() == obj2.getClass() && !(obj2 instanceof Map) && !d2.d().equals(i.f)) {
                        d2.e(i.q);
                    }
                    m(eVar, d2, obj2);
                } else if (obj2 instanceof Enum) {
                    d2.e(i.o);
                }
            }
        }
        return new f(gVar, d2);
    }
}
