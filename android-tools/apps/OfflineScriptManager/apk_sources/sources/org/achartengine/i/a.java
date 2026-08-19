package org.achartengine.i;

import org.achartengine.f.i;
/* loaded from: classes.dex */
public abstract class a {

    /* renamed from: a  reason: collision with root package name */
    protected org.achartengine.f.a f2811a;

    /* renamed from: b  reason: collision with root package name */
    protected org.achartengine.h.d f2812b;

    public a(org.achartengine.f.a aVar) {
        this.f2811a = aVar;
        if (aVar instanceof i) {
            this.f2812b = ((i) aVar).B();
        }
    }

    public void a(double[] dArr, int i) {
        double[] x;
        org.achartengine.f.a aVar = this.f2811a;
        if (!(aVar instanceof i) || (x = ((i) aVar).x(i)) == null) {
            return;
        }
        if (!this.f2812b.T0(i)) {
            dArr[0] = x[0];
            this.f2812b.k1(dArr[0], i);
        }
        if (!this.f2812b.R0(i)) {
            dArr[1] = x[1];
            this.f2812b.i1(dArr[1], i);
        }
        if (!this.f2812b.U0(i)) {
            dArr[2] = x[2];
            this.f2812b.s1(dArr[2], i);
        }
        if (this.f2812b.S0(i)) {
            return;
        }
        dArr[3] = x[3];
        this.f2812b.q1(dArr[3], i);
    }

    public double[] b(int i) {
        return new double[]{this.f2812b.o0(i), this.f2812b.n0(i), this.f2812b.z0(i), this.f2812b.y0(i)};
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void c(double d2, double d3, int i) {
        this.f2812b.k1(d2, i);
        this.f2812b.i1(d3, i);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void d(double d2, double d3, int i) {
        this.f2812b.s1(d2, i);
        this.f2812b.q1(d3, i);
    }
}
