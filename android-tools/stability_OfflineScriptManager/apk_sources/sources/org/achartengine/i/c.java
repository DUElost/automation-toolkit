package org.achartengine.i;

import java.util.ArrayList;
import java.util.List;
import org.achartengine.f.i;
/* loaded from: classes.dex */
public class c extends a {

    /* renamed from: c  reason: collision with root package name */
    private List<d> f2813c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f2814d;
    private boolean e;

    public c(org.achartengine.f.a aVar) {
        super(aVar);
        this.f2813c = new ArrayList();
        this.f2814d = false;
        this.e = false;
    }

    private double f(double[] dArr) {
        return Math.abs(dArr[1] - dArr[0]) / Math.abs(dArr[3] - dArr[2]);
    }

    private synchronized void g() {
        for (d dVar : this.f2813c) {
            dVar.a();
        }
    }

    public void e(float f, float f2, float f3, float f4) {
        int i;
        double[] dArr;
        i iVar;
        int i2;
        boolean z;
        boolean z2;
        char c2;
        org.achartengine.f.a aVar = this.f2811a;
        if (aVar instanceof i) {
            double[] k0 = this.f2812b.k0();
            char c3 = 0;
            boolean z3 = k0 != null && k0.length == 4;
            i iVar2 = (i) this.f2811a;
            int i3 = 0;
            boolean z4 = true;
            boolean z5 = true;
            boolean z6 = true;
            boolean z7 = true;
            for (int m0 = this.f2812b.m0(); i3 < m0; m0 = i2) {
                double[] b2 = b(i3);
                double[] x = iVar2.x(i3);
                if (this.f2814d && this.e) {
                    if (b2[c3] == b2[1] && x[c3] == x[1]) {
                        return;
                    }
                    if (b2[2] == b2[3] && x[2] == x[3]) {
                        return;
                    }
                }
                a(b2, i3);
                double[] I = iVar2.I(f, f2, i3);
                double[] I2 = iVar2.I(f3, f4, i3);
                double d2 = I[c3] - I2[c3];
                double d3 = I[1] - I2[1];
                double f5 = f(b2);
                if (iVar2.o(this.f2812b)) {
                    double d4 = (-d3) * f5;
                    d3 = d2 / f5;
                    d2 = d4;
                }
                if (this.f2812b.V0()) {
                    if (k0 != null) {
                        if (z4) {
                            z4 = k0[0] <= b2[0] + d2;
                        }
                        if (z5) {
                            z5 = k0[1] >= b2[1] + d2;
                        }
                    }
                    z = z4;
                    z2 = z5;
                    if (!z3 || (z && z2)) {
                        double d5 = b2[0] + d2;
                        double d6 = b2[1] + d2;
                        i2 = m0;
                        i = i3;
                        dArr = b2;
                        iVar = iVar2;
                        c(d5, d6, i);
                        this.f2814d = false;
                    } else {
                        this.f2814d = true;
                        i = i3;
                        dArr = b2;
                        iVar = iVar2;
                        i2 = m0;
                    }
                } else {
                    i = i3;
                    dArr = b2;
                    iVar = iVar2;
                    i2 = m0;
                    z = z4;
                    z2 = z5;
                }
                if (this.f2812b.W0()) {
                    if (k0 != null) {
                        if (z6) {
                            z6 = k0[2] <= dArr[2] + d3;
                        }
                        if (z7) {
                            z7 = k0[3] >= dArr[3] + d3;
                        }
                    }
                    if (!z3 || (z6 && z7)) {
                        d(dArr[2] + d3, dArr[3] + d3, i);
                        c2 = 0;
                        this.e = false;
                    } else {
                        this.e = true;
                        c2 = 0;
                    }
                } else {
                    c2 = 0;
                }
                i3 = i + 1;
                c3 = c2;
                iVar2 = iVar;
                z4 = z;
                z5 = z2;
            }
        } else {
            org.achartengine.f.e eVar = (org.achartengine.f.e) aVar;
            eVar.s(eVar.p() + ((int) (f3 - f)));
            eVar.t(eVar.q() + ((int) (f4 - f2)));
        }
        g();
    }
}
