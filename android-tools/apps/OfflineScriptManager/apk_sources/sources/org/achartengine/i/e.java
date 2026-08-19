package org.achartengine.i;

import java.util.ArrayList;
import java.util.List;
import org.achartengine.f.i;
/* loaded from: classes.dex */
public class e extends a {

    /* renamed from: c  reason: collision with root package name */
    private boolean f2815c;

    /* renamed from: d  reason: collision with root package name */
    private float f2816d;
    private List<g> e;
    private boolean f;
    private boolean g;

    public e(org.achartengine.f.a aVar, boolean z, float f) {
        super(aVar);
        this.e = new ArrayList();
        this.f = false;
        this.g = false;
        this.f2815c = z;
        h(f);
    }

    private synchronized void f(f fVar) {
        for (g gVar : this.e) {
            gVar.a(fVar);
        }
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r9v0 */
    /* JADX WARN: Type inference failed for: r9v1 */
    /* JADX WARN: Type inference failed for: r9v5 */
    public void e(int i) {
        int i2;
        double d2;
        double K0;
        double L0;
        org.achartengine.f.a aVar = this.f2811a;
        if (aVar instanceof i) {
            int m0 = this.f2812b.m0();
            ?? r9 = 0;
            int i3 = 0;
            while (i3 < m0) {
                double[] b2 = b(i3);
                a(b2, i3);
                double[] M0 = this.f2812b.M0();
                double d3 = (b2[r9] + b2[1]) / 2.0d;
                double d4 = (b2[2] + b2[3]) / 2.0d;
                double d5 = b2[1] - b2[r9];
                double d6 = b2[3] - b2[2];
                double d7 = d5 / 2.0d;
                double d8 = d3 - d7;
                double d9 = d3 + d7;
                double d10 = d6 / 2.0d;
                double d11 = d4 - d10;
                double d12 = d4 + d10;
                if (i3 == 0) {
                    this.f = (M0 == null || (d8 > M0[r9] && d9 < M0[1])) ? r9 : true;
                    this.g = (M0 == null || (d11 > M0[2] && d12 < M0[3])) ? r9 : true;
                }
                if (this.f2815c) {
                    if (this.f2812b.Y0() && ((i == 1 || i == 0) && (!this.f || this.f2816d >= 1.0f))) {
                        d5 /= this.f2816d;
                    }
                    if (this.f2812b.Z0() && ((i == 2 || i == 0) && (!this.g || this.f2816d >= 1.0f))) {
                        d6 /= this.f2816d;
                    }
                } else {
                    if (this.f2812b.Y0() && !this.f && (i == 1 || i == 0)) {
                        d5 *= this.f2816d;
                    }
                    if (this.f2812b.Z0() && !this.g && (i == 2 || i == 0)) {
                        d6 *= this.f2816d;
                    }
                }
                double d13 = d5;
                double d14 = d6;
                if (M0 != null) {
                    d2 = d4;
                    i2 = i3;
                    K0 = Math.min(this.f2812b.K0(), M0[1] - M0[r9]);
                    L0 = Math.min(this.f2812b.L0(), M0[3] - M0[2]);
                } else {
                    i2 = i3;
                    d2 = d4;
                    K0 = this.f2812b.K0();
                    L0 = this.f2812b.L0();
                }
                double max = Math.max(d13, K0);
                double max2 = Math.max(d14, L0);
                if (this.f2812b.Y0() && (i == 1 || i == 0)) {
                    double d15 = max / 2.0d;
                    c(d3 - d15, d15 + d3, i2);
                }
                if (this.f2812b.Z0() && (i == 2 || i == 0)) {
                    double d16 = max2 / 2.0d;
                    d(d2 - d16, d2 + d16, i2);
                }
                i3 = i2 + 1;
                r9 = 0;
            }
        } else {
            org.achartengine.h.b r = ((org.achartengine.f.e) aVar).r();
            r.U(this.f2815c ? r.k() * this.f2816d : r.k() / this.f2816d);
        }
        f(new f(this.f2815c, this.f2816d));
    }

    public synchronized void g() {
        for (g gVar : this.e) {
            gVar.b();
        }
    }

    public void h(float f) {
        this.f2816d = f;
    }
}
