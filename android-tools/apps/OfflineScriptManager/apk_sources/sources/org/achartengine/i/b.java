package org.achartengine.i;

import org.achartengine.f.i;
/* loaded from: classes.dex */
public class b extends a {
    public b(org.achartengine.f.a aVar) {
        super(aVar);
    }

    public void e() {
        org.achartengine.f.a aVar = this.f2811a;
        if (!(aVar instanceof i)) {
            org.achartengine.h.b r = ((org.achartengine.f.e) aVar).r();
            r.U(r.j());
        } else if (((i) aVar).y() != null) {
            int m0 = this.f2812b.m0();
            if (this.f2812b.P0()) {
                for (int i = 0; i < m0; i++) {
                    if (this.f2812b.Q0(i)) {
                        org.achartengine.h.d dVar = this.f2812b;
                        dVar.g1(dVar.g0(i), i);
                    }
                }
                return;
            }
            org.achartengine.g.e[] b2 = ((i) this.f2811a).y().b();
            int length = b2.length;
            if (length > 0) {
                for (int i2 = 0; i2 < m0; i2++) {
                    double[] dArr = {Double.MAX_VALUE, -1.7976931348623157E308d, Double.MAX_VALUE, -1.7976931348623157E308d};
                    for (int i3 = 0; i3 < length; i3++) {
                        if (i2 == b2[i3].o()) {
                            dArr[0] = Math.min(dArr[0], b2[i3].k());
                            dArr[1] = Math.max(dArr[1], b2[i3].i());
                            dArr[2] = Math.min(dArr[2], b2[i3].l());
                            dArr[3] = Math.max(dArr[3], b2[i3].j());
                        }
                    }
                    double abs = Math.abs(dArr[1] - dArr[0]) / 40.0d;
                    double abs2 = Math.abs(dArr[3] - dArr[2]) / 40.0d;
                    this.f2812b.g1(new double[]{dArr[0] - abs, dArr[1] + abs, dArr[2] - abs2, dArr[3] + abs2}, i2);
                }
            }
        }
    }
}
