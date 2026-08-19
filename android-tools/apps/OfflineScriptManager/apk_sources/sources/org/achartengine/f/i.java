package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.PathEffect;
import android.graphics.Rect;
import android.graphics.RectF;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.achartengine.h.d;
/* loaded from: classes.dex */
public abstract class i extends a {

    /* renamed from: b  reason: collision with root package name */
    protected org.achartengine.g.d f2787b;

    /* renamed from: c  reason: collision with root package name */
    protected org.achartengine.h.d f2788c;

    /* renamed from: d  reason: collision with root package name */
    private float f2789d;
    private float e;
    private org.achartengine.g.a f;
    private Rect g;
    private final Map<Integer, double[]> h = new HashMap();
    private Map<Integer, List<b>> i = new HashMap();

    protected i() {
    }

    public i(org.achartengine.g.d dVar, org.achartengine.h.d dVar2) {
        this.f2787b = dVar;
        this.f2788c = dVar2;
    }

    private List<Double> C(List<Double> list) {
        ArrayList arrayList = new ArrayList(list);
        for (Double d2 : list) {
            if (d2.isNaN()) {
                arrayList.remove(d2);
            }
        }
        return arrayList;
    }

    private void H(Paint.Cap cap, Paint.Join join, float f, Paint.Style style, PathEffect pathEffect, Paint paint) {
        paint.setStrokeCap(cap);
        paint.setStrokeJoin(join);
        paint.setStrokeMiter(f);
        paint.setPathEffect(pathEffect);
        paint.setStyle(style);
    }

    private void J(Canvas canvas, float f, boolean z) {
        if (z) {
            float f2 = this.f2789d;
            canvas.scale(1.0f / f2, f2);
            float f3 = this.e;
            canvas.translate(f3, -f3);
            canvas.rotate(-f, this.f.a(), this.f.b());
            return;
        }
        canvas.rotate(f, this.f.a(), this.f.b());
        float f4 = this.e;
        canvas.translate(-f4, f4);
        float f5 = this.f2789d;
        canvas.scale(f5, 1.0f / f5);
    }

    private int z(Paint.Align align) {
        return align == Paint.Align.LEFT ? -4 : 4;
    }

    public f A() {
        return null;
    }

    public org.achartengine.h.d B() {
        return this.f2788c;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public List<Double> D(double d2, double d3, int i) {
        return org.achartengine.j.b.b(d2, d3, i);
    }

    protected Map<Integer, List<Double>> E(double[] dArr, double[] dArr2, int i) {
        HashMap hashMap = new HashMap();
        for (int i2 = 0; i2 < i; i2++) {
            hashMap.put(Integer.valueOf(i2), C(org.achartengine.j.b.b(dArr[i2], dArr2[i2], this.f2788c.A0())));
        }
        return hashMap;
    }

    protected boolean F() {
        return false;
    }

    public boolean G(org.achartengine.h.c cVar) {
        return false;
    }

    public double[] I(float f, float f2, int i) {
        double o0 = this.f2788c.o0(i);
        double n0 = this.f2788c.n0(i);
        double z0 = this.f2788c.z0(i);
        double y0 = this.f2788c.y0(i);
        if (!this.f2788c.T0(i) || !this.f2788c.R0(i) || !this.f2788c.T0(i) || !this.f2788c.S0(i)) {
            double[] x = x(i);
            o0 = x[0];
            n0 = x[1];
            z0 = x[2];
            y0 = x[3];
        }
        Rect rect = this.g;
        if (rect != null) {
            Rect rect2 = this.g;
            return new double[]{(((f - rect.left) * (n0 - o0)) / rect.width()) + o0, ((((rect2.top + rect2.height()) - f2) * (y0 - z0)) / this.g.height()) + z0};
        }
        return new double[]{f, f2};
    }

    /* JADX WARN: Multi-variable type inference failed */
    /* JADX WARN: Removed duplicated region for block: B:116:0x04c6  */
    /* JADX WARN: Removed duplicated region for block: B:131:0x05f4  */
    /* JADX WARN: Removed duplicated region for block: B:134:0x05fc  */
    /* JADX WARN: Removed duplicated region for block: B:135:0x0628  */
    /* JADX WARN: Removed duplicated region for block: B:142:0x067e  */
    /* JADX WARN: Removed duplicated region for block: B:161:0x06e7  */
    /* JADX WARN: Removed duplicated region for block: B:290:? A[RETURN, SYNTHETIC] */
    /* JADX WARN: Removed duplicated region for block: B:77:0x02e0  */
    /* JADX WARN: Removed duplicated region for block: B:78:0x02fe  */
    /* JADX WARN: Removed duplicated region for block: B:81:0x0347  */
    /* JADX WARN: Type inference failed for: r10v47 */
    /* JADX WARN: Type inference failed for: r50v0, types: [org.achartengine.f.a, org.achartengine.f.i] */
    /* JADX WARN: Unsupported multi-entry loop pattern (BACK_EDGE: B:251:? -> B:216:0x09f1). Please submit an issue!!! */
    @Override // org.achartengine.f.a
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void b(android.graphics.Canvas r51, int r52, int r53, int r54, int r55, android.graphics.Paint r56) {
        /*
            Method dump skipped, instructions count: 3156
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: org.achartengine.f.i.b(android.graphics.Canvas, int, int, int, int, android.graphics.Paint):void");
    }

    @Override // org.achartengine.f.a
    public org.achartengine.g.b m(org.achartengine.g.a aVar) {
        RectF a2;
        Map<Integer, List<b>> map = this.i;
        if (map != null) {
            for (int size = map.size() - 1; size >= 0; size--) {
                if (this.i.get(Integer.valueOf(size)) != null) {
                    int i = 0;
                    for (b bVar : this.i.get(Integer.valueOf(size))) {
                        if (bVar != null && (a2 = bVar.a()) != null && a2.contains(aVar.a(), aVar.b())) {
                            return new org.achartengine.g.b(size, i, bVar.b(), bVar.c());
                        }
                        i++;
                    }
                    continue;
                }
            }
        }
        return super.m(aVar);
    }

    protected abstract b[] p(List<Float> list, List<Double> list2, float f, int i, int i2);

    protected void q(Canvas canvas, org.achartengine.g.e eVar, org.achartengine.h.e eVar2, Paint paint, List<Float> list, int i, int i2) {
        Float f;
        if (list.size() <= 1) {
            for (int i3 = 0; i3 < list.size(); i3 += 2) {
                t(canvas, j(eVar2.a(), eVar.r((i3 / 2) + i2)), list.get(i3).floatValue(), list.get(i3 + 1).floatValue() - eVar2.l(), paint, 0.0f);
            }
            return;
        }
        float floatValue = list.get(0).floatValue();
        float floatValue2 = list.get(1).floatValue();
        for (int i4 = 0; i4 < list.size(); i4 += 2) {
            if (i4 == 2) {
                if (Math.abs(list.get(2).floatValue() - list.get(0).floatValue()) > eVar2.o() || Math.abs(list.get(3).floatValue() - list.get(1).floatValue()) > eVar2.o()) {
                    t(canvas, j(eVar2.a(), eVar.r(i2)), list.get(0).floatValue(), list.get(1).floatValue() - eVar2.l(), paint, 0.0f);
                    t(canvas, j(eVar2.a(), eVar.r(i2 + 1)), list.get(2).floatValue(), list.get(3).floatValue() - eVar2.l(), paint, 0.0f);
                    floatValue = list.get(2).floatValue();
                    f = list.get(3);
                    floatValue2 = f.floatValue();
                }
            } else if (i4 > 2 && (Math.abs(list.get(i4).floatValue() - floatValue) > eVar2.o() || Math.abs(list.get(i4 + 1).floatValue() - floatValue2) > eVar2.o())) {
                int i5 = i4 + 1;
                t(canvas, j(eVar2.a(), eVar.r((i4 / 2) + i2)), list.get(i4).floatValue(), list.get(i5).floatValue() - eVar2.l(), paint, 0.0f);
                floatValue = list.get(i4).floatValue();
                f = list.get(i5);
                floatValue2 = f.floatValue();
            }
        }
    }

    public abstract void r(Canvas canvas, Paint paint, List<Float> list, org.achartengine.h.e eVar, float f, int i, int i2);

    protected void s(org.achartengine.g.e eVar, Canvas canvas, Paint paint, List<Float> list, org.achartengine.h.e eVar2, float f, int i, d.a aVar, int i2) {
        f A;
        org.achartengine.h.a c2 = eVar2.c();
        Paint.Cap strokeCap = paint.getStrokeCap();
        Paint.Join strokeJoin = paint.getStrokeJoin();
        float strokeMiter = paint.getStrokeMiter();
        PathEffect pathEffect = paint.getPathEffect();
        Paint.Style style = paint.getStyle();
        if (c2 != null) {
            c2.a();
            throw null;
        }
        r(canvas, paint, list, eVar2, f, i, i2);
        if (G(eVar2) && (A = A()) != null) {
            A.r(canvas, paint, list, eVar2, f, i, i2);
        }
        paint.setTextSize(eVar2.n());
        paint.setTextAlign(aVar == d.a.HORIZONTAL ? Paint.Align.CENTER : Paint.Align.LEFT);
        if (eVar2.t()) {
            paint.setTextAlign(eVar2.m());
            q(canvas, eVar, eVar2, paint, list, i, i2);
        }
        if (c2 != null) {
            H(strokeCap, strokeJoin, strokeMiter, style, pathEffect, paint);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void t(Canvas canvas, String str, float f, float f2, Paint paint, float f3) {
        float f4 = (-this.f2788c.j0().a()) + f3;
        int i = (f4 > 0.0f ? 1 : (f4 == 0.0f ? 0 : -1));
        if (i != 0) {
            canvas.rotate(f4, f, f2);
        }
        h(canvas, str, f, f2, paint);
        if (i != 0) {
            canvas.rotate(-f4, f, f2);
        }
    }

    protected void u(List<Double> list, Double[] dArr, Canvas canvas, Paint paint, int i, int i2, int i3, double d2, double d3, double d4) {
        float f;
        double d5;
        int size = list.size();
        boolean G = this.f2788c.G();
        boolean F = this.f2788c.F();
        boolean I = this.f2788c.I();
        for (int i4 = 0; i4 < size; i4++) {
            double doubleValue = list.get(i4).doubleValue();
            float f2 = (float) (i + ((doubleValue - d3) * d2));
            if (G) {
                paint.setColor(this.f2788c.s0());
                if (I) {
                    float f3 = i3;
                    f = f2;
                    d5 = doubleValue;
                    canvas.drawLine(f2, f3, f, f3 + (this.f2788c.f() / 3.0f), paint);
                } else {
                    f = f2;
                    d5 = doubleValue;
                }
                t(canvas, j(this.f2788c.h0(), d5), f, i3 + ((this.f2788c.f() * 4.0f) / 3.0f) + this.f2788c.t0(), paint, this.f2788c.r0());
            } else {
                f = f2;
            }
            if (F) {
                paint.setColor(this.f2788c.f0(0));
                canvas.drawLine(f, i3, f, i2, paint);
            }
        }
        v(dArr, canvas, paint, G, i, i2, i3, d2, d3, d4);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void v(Double[] dArr, Canvas canvas, Paint paint, boolean z, int i, int i2, int i3, double d2, double d3, double d4) {
        float f;
        boolean C = this.f2788c.C();
        boolean I = this.f2788c.I();
        if (z) {
            paint.setColor(this.f2788c.s0());
            for (Double d5 : dArr) {
                if (d3 <= d5.doubleValue() && d5.doubleValue() <= d4) {
                    float doubleValue = (float) (i + ((d5.doubleValue() - d3) * d2));
                    paint.setColor(this.f2788c.s0());
                    if (I) {
                        float f2 = i3;
                        f = doubleValue;
                        canvas.drawLine(doubleValue, f2, doubleValue, f2 + (this.f2788c.f() / 3.0f), paint);
                    } else {
                        f = doubleValue;
                    }
                    String u0 = this.f2788c.u0(d5);
                    float f3 = i3;
                    t(canvas, u0, f, f3 + ((this.f2788c.f() * 4.0f) / 3.0f), paint, this.f2788c.r0());
                    if (C) {
                        paint.setColor(this.f2788c.f0(0));
                        canvas.drawLine(f, f3, f, i2, paint);
                    }
                }
            }
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:29:0x013d  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    protected void w(java.util.Map<java.lang.Integer, java.util.List<java.lang.Double>> r23, android.graphics.Canvas r24, android.graphics.Paint r25, int r26, int r27, int r28, int r29, double[] r30, double[] r31) {
        /*
            Method dump skipped, instructions count: 493
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: org.achartengine.f.i.w(java.util.Map, android.graphics.Canvas, android.graphics.Paint, int, int, int, int, double[], double[]):void");
    }

    public double[] x(int i) {
        return this.h.get(Integer.valueOf(i));
    }

    public org.achartengine.g.d y() {
        return this.f2787b;
    }
}
