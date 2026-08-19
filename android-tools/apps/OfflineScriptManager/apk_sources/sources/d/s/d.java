package d.s;

import java.lang.Comparable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public final class d<K extends Comparable<? super K>, V> {

    /* renamed from: a  reason: collision with root package name */
    private final Comparator<? super Map.Entry<V, K>> f2723a = new a(this, null);

    /* renamed from: b  reason: collision with root package name */
    private final Map<K, List<V>> f2724b = new HashMap();

    /* renamed from: c  reason: collision with root package name */
    private final Map<V, K> f2725c = new HashMap();

    /* loaded from: classes.dex */
    private final class a implements Comparator<Map.Entry<V, K>> {
        private a(d dVar) {
        }

        /* synthetic */ a(d dVar, a aVar) {
            this(dVar);
        }

        @Override // java.util.Comparator
        /* renamed from: a */
        public int compare(Map.Entry<V, K> entry, Map.Entry<V, K> entry2) {
            return entry.getValue().compareTo(entry2.getValue());
        }
    }

    private List<V> c(K k) {
        List<V> list = this.f2724b.get(k);
        if (list == null) {
            ArrayList arrayList = new ArrayList();
            this.f2724b.put(k, arrayList);
            return arrayList;
        }
        return list;
    }

    private boolean i(K k, V v) {
        List<V> list = this.f2724b.get(k);
        if (list != null) {
            boolean remove = list.remove(v);
            if (list.isEmpty()) {
                this.f2724b.remove(k);
                return remove;
            }
            return remove;
        }
        return false;
    }

    public Collection<Map.Entry<V, K>> a() {
        ArrayList arrayList = new ArrayList(this.f2725c.entrySet());
        Collections.sort(arrayList, this.f2723a);
        return arrayList;
    }

    public V b(V v) {
        K k = this.f2725c.get(v);
        if (k != null) {
            List<V> list = this.f2724b.get(k);
            return list.get(list.indexOf(v));
        }
        return null;
    }

    public boolean d(K k) {
        List<V> list = this.f2724b.get(k);
        if (list == null) {
            return false;
        }
        return !list.isEmpty();
    }

    public boolean e(K k, V v) {
        K k2 = this.f2725c.get(v);
        if (k2 != null) {
            i(k2, v);
        }
        boolean add = c(k).add(v);
        if (add) {
            this.f2725c.put(v, k);
        }
        return add;
    }

    public boolean f() {
        return this.f2725c.isEmpty();
    }

    public boolean g(K k, V v) {
        boolean i = i(k, v);
        if (i) {
            this.f2725c.remove(v);
        }
        return i;
    }

    public boolean h(V v) {
        K remove = this.f2725c.remove(v);
        if (remove != null) {
            return i(remove, v);
        }
        return false;
    }

    public String toString() {
        return this.f2724b.toString();
    }
}
