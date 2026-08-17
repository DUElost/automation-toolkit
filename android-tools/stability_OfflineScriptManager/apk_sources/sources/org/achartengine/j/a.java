package org.achartengine.j;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.TreeMap;
/* loaded from: classes.dex */
public class a<K, V> extends TreeMap<K, V> {

    /* renamed from: b  reason: collision with root package name */
    private final List<K> f2817b = new ArrayList();

    /* renamed from: c  reason: collision with root package name */
    private double f2818c = 0.0d;

    private void d() {
        if (this.f2817b.size() < 2) {
            this.f2818c = 0.0d;
            return;
        }
        List<K> list = this.f2817b;
        double doubleValue = ((Double) list.get(list.size() - 1)).doubleValue();
        List<K> list2 = this.f2817b;
        if (Math.abs(doubleValue - ((Double) list2.get(list2.size() - 2)).doubleValue()) > this.f2818c) {
            List<K> list3 = this.f2817b;
            double doubleValue2 = ((Double) list3.get(list3.size() - 1)).doubleValue();
            List<K> list4 = this.f2817b;
            this.f2818c = Math.abs(doubleValue2 - ((Double) list4.get(list4.size() - 2)).doubleValue());
        }
    }

    public int a(K k) {
        return Collections.binarySearch(this.f2817b, k, null);
    }

    public K b(int i) {
        return this.f2817b.get(i);
    }

    public V c(int i) {
        return get(this.f2817b.get(i));
    }

    @Override // java.util.TreeMap, java.util.AbstractMap, java.util.Map
    public void clear() {
        d();
        super.clear();
        this.f2817b.clear();
    }

    @Override // java.util.TreeMap, java.util.AbstractMap, java.util.Map
    public V put(K k, V v) {
        this.f2817b.add(k);
        d();
        return (V) super.put(k, v);
    }
}
