package c.c.a.l;

import c.c.a.a;
import c.c.a.j.f;
import c.c.a.k.g;
import c.c.a.k.h;
import c.c.a.k.i;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.IdentityHashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public abstract class a {

    /* renamed from: b  reason: collision with root package name */
    protected b f1811b;

    /* renamed from: d  reason: collision with root package name */
    private Character f1813d;
    protected Object g;
    private f h;

    /* renamed from: a  reason: collision with root package name */
    protected final Map<Class<?>, b> f1810a = new HashMap();

    /* renamed from: c  reason: collision with root package name */
    protected final Map<Class<?>, b> f1812c = new LinkedHashMap();
    protected a.EnumC0058a e = a.EnumC0058a.AUTO;
    protected final Map<Object, c.c.a.k.d> f = new C0062a(this);
    private boolean i = false;

    /* renamed from: c.c.a.l.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class C0062a extends IdentityHashMap<Object, c.c.a.k.d> {
        C0062a(a aVar) {
        }

        @Override // java.util.IdentityHashMap, java.util.AbstractMap, java.util.Map
        /* renamed from: a */
        public c.c.a.k.d put(Object obj, c.c.a.k.d dVar) {
            return (c.c.a.k.d) super.put(obj, new c.c.a.k.a(dVar));
        }
    }

    public final f a() {
        if (this.h == null) {
            this.h = new f();
        }
        return this.h;
    }

    public final boolean b() {
        return this.i;
    }

    public c.c.a.k.d c(Object obj) {
        c.c.a.k.d d2 = d(obj);
        this.f.clear();
        this.g = null;
        return d2;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public final c.c.a.k.d d(Object obj) {
        b bVar;
        this.g = obj;
        if (this.f.containsKey(obj)) {
            return this.f.get(this.g);
        }
        if (obj == null) {
            return this.f1811b.a(obj);
        }
        Class<?> cls = obj.getClass();
        if (this.f1810a.containsKey(cls)) {
            bVar = this.f1810a.get(cls);
        } else {
            for (Class<?> cls2 : this.f1812c.keySet()) {
                if (cls2.isInstance(obj)) {
                    return this.f1812c.get(cls2).a(obj);
                }
            }
            if (cls.isArray()) {
                throw new c.c.a.g.b("Arrays of primitives are not fully supported.");
            }
            bVar = (this.f1812c.containsKey(null) ? this.f1812c : this.f1810a).get(null);
        }
        return bVar.a(obj);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c.c.a.k.d e(i iVar, Map<? extends Object, Object> map, Boolean bool) {
        ArrayList arrayList = new ArrayList(map.size());
        c.c.a.k.c cVar = new c.c.a.k.c(iVar, arrayList, bool);
        this.f.put(this.g, cVar);
        boolean z = true;
        for (Object obj : map.keySet()) {
            Object obj2 = map.get(obj);
            c.c.a.k.d d2 = d(obj);
            c.c.a.k.d d3 = d(obj2);
            z = ((d2 instanceof g) && ((g) d2).f() == null) ? false : false;
            if (!(d3 instanceof g) || ((g) d3).f() != null) {
                z = false;
            }
            arrayList.add(new c.c.a.k.f(d2, d3));
        }
        if (bool == null) {
            a.EnumC0058a enumC0058a = this.e;
            cVar.g(enumC0058a != a.EnumC0058a.AUTO ? enumC0058a.a() : Boolean.valueOf(z));
        }
        return cVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c.c.a.k.d f(i iVar, String str) {
        return g(iVar, str, null);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c.c.a.k.d g(i iVar, String str, Character ch) {
        if (ch == null) {
            ch = this.f1813d;
        }
        return new g(iVar, str, null, null, ch);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c.c.a.k.d h(i iVar, Iterable<? extends Object> iterable, Boolean bool) {
        ArrayList arrayList = new ArrayList(iterable instanceof List ? ((List) iterable).size() : 10);
        h hVar = new h(iVar, arrayList, bool);
        this.f.put(this.g, hVar);
        boolean z = true;
        for (Object obj : iterable) {
            c.c.a.k.d d2 = d(obj);
            if (!(d2 instanceof g) || ((g) d2).f() != null) {
                z = false;
            }
            arrayList.add(d2);
        }
        if (bool == null) {
            a.EnumC0058a enumC0058a = this.e;
            hVar.g(enumC0058a != a.EnumC0058a.AUTO ? enumC0058a.a() : Boolean.valueOf(z));
        }
        return hVar;
    }

    public void i(a.EnumC0058a enumC0058a) {
        this.e = enumC0058a;
    }

    public void j(a.c cVar) {
        this.f1813d = cVar.b();
    }

    public void k(f fVar) {
        this.h = fVar;
        this.i = true;
    }
}
