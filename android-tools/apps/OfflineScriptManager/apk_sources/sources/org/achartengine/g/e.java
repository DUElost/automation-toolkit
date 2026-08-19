package org.achartengine.g;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.SortedMap;
/* loaded from: classes.dex */
public class e implements Serializable {

    /* renamed from: b  reason: collision with root package name */
    private String f2793b;

    /* renamed from: c  reason: collision with root package name */
    private final org.achartengine.j.a<Double, Double> f2794c;

    /* renamed from: d  reason: collision with root package name */
    private double f2795d;
    private double e;
    private double f;
    private double g;
    private final int h;
    private List<String> i;
    private final org.achartengine.j.a<Double, Double> j;

    public e(String str) {
        this(str, 0);
    }

    public e(String str, int i) {
        this.f2794c = new org.achartengine.j.a<>();
        this.f2795d = Double.MAX_VALUE;
        this.e = -1.7976931348623157E308d;
        this.f = Double.MAX_VALUE;
        this.g = -1.7976931348623157E308d;
        this.i = new ArrayList();
        this.j = new org.achartengine.j.a<>();
        this.f2793b = str;
        this.h = i;
        s();
    }

    private void s() {
        this.f2795d = Double.MAX_VALUE;
        this.e = -1.7976931348623157E308d;
        this.f = Double.MAX_VALUE;
        this.g = -1.7976931348623157E308d;
        int h = h();
        for (int i = 0; i < h; i++) {
            t(q(i), r(i));
        }
    }

    private void t(double d2, double d3) {
        this.f2795d = Math.min(this.f2795d, d2);
        this.e = Math.max(this.e, d2);
        this.f = Math.min(this.f, d3);
        this.g = Math.max(this.g, d3);
    }

    public synchronized void a(double d2, double d3) {
        while (this.f2794c.get(Double.valueOf(d2)) != null) {
            d2 += m();
        }
        this.f2794c.put(Double.valueOf(d2), Double.valueOf(d3));
        t(d2, d3);
    }

    public synchronized void b() {
        this.f2794c.clear();
        this.j.clear();
        s();
    }

    public String c(int i) {
        return this.i.get(i);
    }

    public int d() {
        return this.i.size();
    }

    public double e(int i) {
        return this.j.b(i).doubleValue();
    }

    public double f(int i) {
        return this.j.c(i).doubleValue();
    }

    public int g(double d2) {
        return this.f2794c.a(Double.valueOf(d2));
    }

    public synchronized int h() {
        return this.f2794c.size();
    }

    public double i() {
        return this.e;
    }

    public double j() {
        return this.g;
    }

    public double k() {
        return this.f2795d;
    }

    public double l() {
        return this.f;
    }

    protected double m() {
        return 1.0E-12d;
    }

    public synchronized SortedMap<Double, Double> n(double d2, double d3, boolean z) {
        if (z) {
            SortedMap<Double, Double> headMap = this.f2794c.headMap(Double.valueOf(d2));
            if (!headMap.isEmpty()) {
                d2 = headMap.lastKey().doubleValue();
            }
            SortedMap<Double, Double> tailMap = this.f2794c.tailMap(Double.valueOf(d3));
            if (!tailMap.isEmpty()) {
                Iterator<Double> it = tailMap.keySet().iterator();
                d3 = it.hasNext() ? it.next().doubleValue() : d3 + it.next().doubleValue();
            }
        }
        return this.f2794c.subMap(Double.valueOf(d2), Double.valueOf(d3));
    }

    public int o() {
        return this.h;
    }

    public String p() {
        return this.f2793b;
    }

    public synchronized double q(int i) {
        return this.f2794c.b(i).doubleValue();
    }

    public synchronized double r(int i) {
        return this.f2794c.c(i).doubleValue();
    }
}
