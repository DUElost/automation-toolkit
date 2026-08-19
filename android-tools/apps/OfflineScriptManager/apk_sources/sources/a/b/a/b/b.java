package a.b.a.b;

import java.util.Iterator;
import java.util.Map;
import java.util.WeakHashMap;
/* loaded from: classes.dex */
public class b<K, V> implements Iterable<Map.Entry<K, V>> {

    /* renamed from: b  reason: collision with root package name */
    c<K, V> f61b;

    /* renamed from: c  reason: collision with root package name */
    private c<K, V> f62c;

    /* renamed from: d  reason: collision with root package name */
    private WeakHashMap<f<K, V>, Boolean> f63d = new WeakHashMap<>();
    private int e = 0;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class a<K, V> extends e<K, V> {
        a(c<K, V> cVar, c<K, V> cVar2) {
            super(cVar, cVar2);
        }

        @Override // a.b.a.b.b.e
        c<K, V> b(c<K, V> cVar) {
            return cVar.e;
        }

        @Override // a.b.a.b.b.e
        c<K, V> c(c<K, V> cVar) {
            return cVar.f66d;
        }
    }

    /* renamed from: a.b.a.b.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    private static class C0003b<K, V> extends e<K, V> {
        C0003b(c<K, V> cVar, c<K, V> cVar2) {
            super(cVar, cVar2);
        }

        @Override // a.b.a.b.b.e
        c<K, V> b(c<K, V> cVar) {
            return cVar.f66d;
        }

        @Override // a.b.a.b.b.e
        c<K, V> c(c<K, V> cVar) {
            return cVar.e;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static class c<K, V> implements Map.Entry<K, V> {

        /* renamed from: b  reason: collision with root package name */
        final K f64b;

        /* renamed from: c  reason: collision with root package name */
        final V f65c;

        /* renamed from: d  reason: collision with root package name */
        c<K, V> f66d;
        c<K, V> e;

        c(K k, V v) {
            this.f64b = k;
            this.f65c = v;
        }

        @Override // java.util.Map.Entry
        public boolean equals(Object obj) {
            if (obj == this) {
                return true;
            }
            if (obj instanceof c) {
                c cVar = (c) obj;
                return this.f64b.equals(cVar.f64b) && this.f65c.equals(cVar.f65c);
            }
            return false;
        }

        @Override // java.util.Map.Entry
        public K getKey() {
            return this.f64b;
        }

        @Override // java.util.Map.Entry
        public V getValue() {
            return this.f65c;
        }

        @Override // java.util.Map.Entry
        public int hashCode() {
            return this.f64b.hashCode() ^ this.f65c.hashCode();
        }

        @Override // java.util.Map.Entry
        public V setValue(V v) {
            throw new UnsupportedOperationException("An entry modification is not supported");
        }

        public String toString() {
            return this.f64b + "=" + this.f65c;
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class d implements Iterator<Map.Entry<K, V>>, f<K, V> {

        /* renamed from: b  reason: collision with root package name */
        private c<K, V> f67b;

        /* renamed from: c  reason: collision with root package name */
        private boolean f68c = true;

        d() {
        }

        @Override // a.b.a.b.b.f
        public void a(c<K, V> cVar) {
            c<K, V> cVar2 = this.f67b;
            if (cVar == cVar2) {
                c<K, V> cVar3 = cVar2.e;
                this.f67b = cVar3;
                this.f68c = cVar3 == null;
            }
        }

        @Override // java.util.Iterator
        /* renamed from: b */
        public Map.Entry<K, V> next() {
            c<K, V> cVar;
            if (this.f68c) {
                this.f68c = false;
                cVar = b.this.f61b;
            } else {
                c<K, V> cVar2 = this.f67b;
                cVar = cVar2 != null ? cVar2.f66d : null;
            }
            this.f67b = cVar;
            return this.f67b;
        }

        @Override // java.util.Iterator
        public boolean hasNext() {
            if (this.f68c) {
                return b.this.f61b != null;
            }
            c<K, V> cVar = this.f67b;
            return (cVar == null || cVar.f66d == null) ? false : true;
        }
    }

    /* loaded from: classes.dex */
    private static abstract class e<K, V> implements Iterator<Map.Entry<K, V>>, f<K, V> {

        /* renamed from: b  reason: collision with root package name */
        c<K, V> f70b;

        /* renamed from: c  reason: collision with root package name */
        c<K, V> f71c;

        e(c<K, V> cVar, c<K, V> cVar2) {
            this.f70b = cVar2;
            this.f71c = cVar;
        }

        private c<K, V> e() {
            c<K, V> cVar = this.f71c;
            c<K, V> cVar2 = this.f70b;
            if (cVar == cVar2 || cVar2 == null) {
                return null;
            }
            return c(cVar);
        }

        @Override // a.b.a.b.b.f
        public void a(c<K, V> cVar) {
            if (this.f70b == cVar && cVar == this.f71c) {
                this.f71c = null;
                this.f70b = null;
            }
            c<K, V> cVar2 = this.f70b;
            if (cVar2 == cVar) {
                this.f70b = b(cVar2);
            }
            if (this.f71c == cVar) {
                this.f71c = e();
            }
        }

        abstract c<K, V> b(c<K, V> cVar);

        abstract c<K, V> c(c<K, V> cVar);

        @Override // java.util.Iterator
        /* renamed from: d */
        public Map.Entry<K, V> next() {
            c<K, V> cVar = this.f71c;
            this.f71c = e();
            return cVar;
        }

        @Override // java.util.Iterator
        public boolean hasNext() {
            return this.f71c != null;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public interface f<K, V> {
        void a(c<K, V> cVar);
    }

    public Iterator<Map.Entry<K, V>> a() {
        C0003b c0003b = new C0003b(this.f62c, this.f61b);
        this.f63d.put(c0003b, Boolean.FALSE);
        return c0003b;
    }

    public Map.Entry<K, V> b() {
        return this.f61b;
    }

    protected c<K, V> c(K k) {
        c<K, V> cVar = this.f61b;
        while (cVar != null && !cVar.f64b.equals(k)) {
            cVar = cVar.f66d;
        }
        return cVar;
    }

    public b<K, V>.d d() {
        b<K, V>.d dVar = new d();
        this.f63d.put(dVar, Boolean.FALSE);
        return dVar;
    }

    public Map.Entry<K, V> e() {
        return this.f62c;
    }

    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (obj instanceof b) {
            b bVar = (b) obj;
            if (size() != bVar.size()) {
                return false;
            }
            Iterator<Map.Entry<K, V>> it = iterator();
            Iterator<Map.Entry<K, V>> it2 = bVar.iterator();
            while (it.hasNext() && it2.hasNext()) {
                Map.Entry<K, V> next = it.next();
                Map.Entry<K, V> next2 = it2.next();
                if ((next == null && next2 != null) || (next != null && !next.equals(next2))) {
                    return false;
                }
            }
            return (it.hasNext() || it2.hasNext()) ? false : true;
        }
        return false;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public c<K, V> f(K k, V v) {
        c<K, V> cVar = new c<>(k, v);
        this.e++;
        c<K, V> cVar2 = this.f62c;
        if (cVar2 == null) {
            this.f61b = cVar;
        } else {
            cVar2.f66d = cVar;
            cVar.e = cVar2;
        }
        this.f62c = cVar;
        return cVar;
    }

    public V g(K k, V v) {
        c<K, V> c2 = c(k);
        if (c2 != null) {
            return c2.f65c;
        }
        f(k, v);
        return null;
    }

    public V h(K k) {
        c<K, V> c2 = c(k);
        if (c2 == null) {
            return null;
        }
        this.e--;
        if (!this.f63d.isEmpty()) {
            for (f<K, V> fVar : this.f63d.keySet()) {
                fVar.a(c2);
            }
        }
        c<K, V> cVar = c2.e;
        c<K, V> cVar2 = c2.f66d;
        if (cVar != null) {
            cVar.f66d = cVar2;
        } else {
            this.f61b = cVar2;
        }
        c<K, V> cVar3 = c2.f66d;
        if (cVar3 != null) {
            cVar3.e = cVar;
        } else {
            this.f62c = cVar;
        }
        c2.f66d = null;
        c2.e = null;
        return c2.f65c;
    }

    public int hashCode() {
        Iterator<Map.Entry<K, V>> it = iterator();
        int i = 0;
        while (it.hasNext()) {
            i += it.next().hashCode();
        }
        return i;
    }

    @Override // java.lang.Iterable
    public Iterator<Map.Entry<K, V>> iterator() {
        a aVar = new a(this.f61b, this.f62c);
        this.f63d.put(aVar, Boolean.FALSE);
        return aVar;
    }

    public int size() {
        return this.e;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        Iterator<Map.Entry<K, V>> it = iterator();
        while (it.hasNext()) {
            sb.append(it.next().toString());
            if (it.hasNext()) {
                sb.append(", ");
            }
        }
        sb.append("]");
        return sb.toString();
    }
}
