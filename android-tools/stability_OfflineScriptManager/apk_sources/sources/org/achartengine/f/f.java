package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.RectF;
import java.util.List;
/* loaded from: classes.dex */
public class f extends i {
    private static /* synthetic */ int[] k;
    private float j;

    public f(org.achartengine.g.d dVar, org.achartengine.h.d dVar2) {
        super(dVar, dVar2);
        this.j = 3.0f;
        this.j = dVar2.l0();
    }

    static /* synthetic */ int[] K() {
        int[] iArr = k;
        if (iArr != null) {
            return iArr;
        }
        int[] iArr2 = new int[d.valuesCustom().length];
        try {
            iArr2[d.CIRCLE.ordinal()] = 2;
        } catch (NoSuchFieldError unused) {
        }
        try {
            iArr2[d.DIAMOND.ordinal()] = 5;
        } catch (NoSuchFieldError unused2) {
        }
        try {
            iArr2[d.POINT.ordinal()] = 6;
        } catch (NoSuchFieldError unused3) {
        }
        try {
            iArr2[d.SQUARE.ordinal()] = 4;
        } catch (NoSuchFieldError unused4) {
        }
        try {
            iArr2[d.TRIANGLE.ordinal()] = 3;
        } catch (NoSuchFieldError unused5) {
        }
        try {
            iArr2[d.X.ordinal()] = 1;
        } catch (NoSuchFieldError unused6) {
        }
        k = iArr2;
        return iArr2;
    }

    private void L(Canvas canvas, Paint paint, float f, float f2) {
        canvas.drawCircle(f, f2, this.j, paint);
    }

    private void M(Canvas canvas, Paint paint, float[] fArr, float f, float f2) {
        fArr[0] = f;
        float f3 = this.j;
        fArr[1] = f2 - f3;
        fArr[2] = f - f3;
        fArr[3] = f2;
        fArr[4] = f;
        fArr[5] = f2 + f3;
        fArr[6] = f + f3;
        fArr[7] = f2;
        g(canvas, fArr, paint, true);
    }

    private void N(Canvas canvas, Paint paint, float f, float f2) {
        float f3 = this.j;
        canvas.drawRect(f - f3, f2 - f3, f + f3, f2 + f3, paint);
    }

    private void O(Canvas canvas, Paint paint, float[] fArr, float f, float f2) {
        fArr[0] = f;
        float f3 = this.j;
        fArr[1] = (f2 - f3) - (f3 / 2.0f);
        fArr[2] = f - f3;
        fArr[3] = f2 + f3;
        fArr[4] = f + f3;
        fArr[5] = fArr[3];
        g(canvas, fArr, paint, true);
    }

    private void P(Canvas canvas, Paint paint, float f, float f2) {
        float f3 = this.j;
        canvas.drawLine(f - f3, f2 - f3, f + f3, f2 + f3, paint);
        float f4 = this.j;
        canvas.drawLine(f + f4, f2 - f4, f - f4, f2 + f4, paint);
    }

    @Override // org.achartengine.f.a
    public void e(Canvas canvas, org.achartengine.h.c cVar, float f, float f2, int i, Paint paint) {
        org.achartengine.h.e eVar = (org.achartengine.h.e) cVar;
        paint.setStyle(eVar.u() ? Paint.Style.FILL : Paint.Style.STROKE);
        switch (K()[eVar.s().ordinal()]) {
            case 1:
                P(canvas, paint, f + 10.0f, f2);
                return;
            case 2:
                L(canvas, paint, f + 10.0f, f2);
                return;
            case 3:
                O(canvas, paint, new float[6], f + 10.0f, f2);
                return;
            case 4:
                N(canvas, paint, f + 10.0f, f2);
                return;
            case 5:
                M(canvas, paint, new float[8], f + 10.0f, f2);
                return;
            case 6:
                canvas.drawPoint(f + 10.0f, f2, paint);
                return;
            default:
                return;
        }
    }

    @Override // org.achartengine.f.a
    public int k(int i) {
        return 10;
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

    /* JADX WARN: Can't fix incorrect switch cases order, some code will duplicate */
    @Override // org.achartengine.f.i
    public void r(Canvas canvas, Paint paint, List<Float> list, org.achartengine.h.e eVar, float f, int i, int i2) {
        Paint.Style style;
        paint.setColor(eVar.b());
        float strokeWidth = paint.getStrokeWidth();
        if (eVar.u()) {
            style = Paint.Style.FILL;
        } else {
            paint.setStrokeWidth(eVar.r());
            style = Paint.Style.STROKE;
        }
        paint.setStyle(style);
        int size = list.size();
        int i3 = 0;
        switch (K()[eVar.s().ordinal()]) {
            case 1:
                paint.setStrokeWidth(eVar.r());
                while (i3 < size) {
                    P(canvas, paint, list.get(i3).floatValue(), list.get(i3 + 1).floatValue());
                    i3 += 2;
                }
                break;
            case 2:
                while (i3 < size) {
                    L(canvas, paint, list.get(i3).floatValue(), list.get(i3 + 1).floatValue());
                    i3 += 2;
                }
                break;
            case 3:
                float[] fArr = new float[6];
                while (i3 < size) {
                    O(canvas, paint, fArr, list.get(i3).floatValue(), list.get(i3 + 1).floatValue());
                    i3 += 2;
                }
                break;
            case 4:
                while (i3 < size) {
                    N(canvas, paint, list.get(i3).floatValue(), list.get(i3 + 1).floatValue());
                    i3 += 2;
                }
                break;
            case 5:
                float[] fArr2 = new float[8];
                while (i3 < size) {
                    M(canvas, paint, fArr2, list.get(i3).floatValue(), list.get(i3 + 1).floatValue());
                    i3 += 2;
                }
                break;
            case 6:
                while (i3 < size) {
                    canvas.drawPoint(list.get(i3).floatValue(), list.get(i3 + 1).floatValue(), paint);
                    i3 += 2;
                }
                break;
        }
        paint.setStrokeWidth(strokeWidth);
    }
}
