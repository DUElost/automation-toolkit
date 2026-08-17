package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RectF;
import java.util.List;
import org.achartengine.h.e;
/* loaded from: classes.dex */
public class c extends i {
    private static /* synthetic */ int[] k;
    private f j;

    public c(org.achartengine.g.d dVar, org.achartengine.h.d dVar2) {
        super(dVar, dVar2);
        this.j = new f(dVar, dVar2);
    }

    static /* synthetic */ int[] K() {
        int[] iArr = k;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[e.a.EnumC0120a.valuesCustom().length];
        try {
            iArr2[e.a.EnumC0120a.ABOVE.ordinal()] = 6;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[e.a.EnumC0120a.BELOW.ordinal()] = 5;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[e.a.EnumC0120a.BOUNDS_ABOVE.ordinal()] = 4;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[e.a.EnumC0120a.BOUNDS_ALL.ordinal()] = 2;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[e.a.EnumC0120a.BOUNDS_BELOW.ordinal()] = 3;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[e.a.EnumC0120a.NONE.ordinal()] = 1;
        } catch (NoSuchFieldError unused6) {
        }
        k = iArr2;
        return iArr2;
    }

    @Override // org.achartengine.f.i
    public f A() {
        return this.j;
    }

    @Override // org.achartengine.f.i
    public boolean G(org.achartengine.h.c cVar) {
        return ((org.achartengine.h.e) cVar).s() != d.POINT;
    }

    @Override // org.achartengine.f.a
    public void e(Canvas canvas, org.achartengine.h.c cVar, float f, float f2, int i, Paint paint) {
        canvas.drawLine(f, f2, f + 30.0f, f2, paint);
        if (G(cVar)) {
            this.j.e(canvas, cVar, f + 5.0f, f2, i, paint);
        }
    }

    @Override // org.achartengine.f.a
    public int k(int i) {
        return 30;
    }

    @Override // org.achartengine.f.i
    protected b[] p(List<Float> list, List<Double> list2, float f, int i, int i2) {
        int size = list.size();
        b[] bVarArr = new b[size / 2];
        for (int i3 = 0; i3 < size; i3 += 2) {
            float l = this.f2788c.l();
            int i4 = i3 + 1;
            bVarArr[i3 / 2] = new b(new RectF(list.get(i3).floatValue() - l, list.get(i4).floatValue() - l, list.get(i3).floatValue() + l, list.get(i4).floatValue() + l), list2.get(i3).doubleValue(), list2.get(i4).doubleValue());
        }
        return bVarArr;
    }

    /* JADX WARN: Code restructure failed: missing block: B:29:0x009a, code lost:
        if (r9.c() == org.achartengine.h.e.a.EnumC0120a.BOUNDS_BELOW) goto L35;
     */
    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Type inference failed for: r10v2, types: [java.util.List, java.util.ArrayList] */
    /* JADX WARN: Type inference failed for: r21v0, types: [org.achartengine.f.a, org.achartengine.f.c] */
    /* JADX WARN: Type inference failed for: r7v22, types: [int] */
    /* JADX WARN: Type inference failed for: r7v26 */
    /* JADX WARN: Type inference failed for: r7v27 */
    @Override // org.achartengine.f.i
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void r(android.graphics.Canvas r22, android.graphics.Paint r23, java.util.List<java.lang.Float> r24, org.achartengine.h.e r25, float r26, int r27, int r28) {
        /*
            Method dump skipped, instructions count: 536
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: org.achartengine.f.c.r(android.graphics.Canvas, android.graphics.Paint, java.util.List, org.achartengine.h.e, float, int, int):void");
    }
}
