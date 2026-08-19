package a.b.a.b;

import a.b.a.b.b;
import java.util.HashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class a<K, V> extends b<K, V> {
    private HashMap<K, b.c<K, V>> f = new HashMap<>();

    @Override // a.b.a.b.b
    protected b.c<K, V> c(K k) {
        return this.f.get(k);
    }

    public boolean contains(K k) {
        return this.f.containsKey(k);
    }

    @Override // a.b.a.b.b
    public V g(K k, V v) {
        b.c<K, V> c2 = c(k);
        if (c2 != null) {
            return c2.f65c;
        }
        this.f.put(k, f(k, v));
        return null;
    }

    @Override // a.b.a.b.b
    public V h(K k) {
        V v = (V) super.h(k);
        this.f.remove(k);
        return v;
    }

    public Map.Entry<K, V> i(K k) {
        if (contains(k)) {
            return this.f.get(k).e;
        }
        return null;
    }
}
