package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import android.graphics.Rect;
import java.io.Serializable;
import java.text.NumberFormat;
import java.util.List;
import org.achartengine.h.d;
/* loaded from: classes.dex */
public abstract class a implements Serializable {
    private static float[] a(float f, float f2, float f3, float f4, int i, int i2) {
        float f5;
        float f6;
        float f7;
        float f8;
        float f9;
        float f10;
        float f11 = i;
        if (f2 > f11) {
            f7 = (f4 - f2) / (f3 - f);
            f8 = f7 * f;
            f5 = ((f11 - f2) + f8) / f7;
            if (f5 >= 0.0f) {
                f9 = i2;
                if (f5 <= f9) {
                    f6 = f11;
                }
                f6 = ((f7 * f9) + f2) - f8;
                f5 = f9;
            }
            f6 = f2 - f8;
            f5 = 0.0f;
        } else if (f2 < 0.0f) {
            f7 = (f4 - f2) / (f3 - f);
            f8 = f7 * f;
            f5 = ((-f2) + f8) / f7;
            if (f5 >= 0.0f) {
                f9 = i2;
                if (f5 <= f9) {
                    f6 = 0.0f;
                }
                f6 = ((f7 * f9) + f2) - f8;
                f5 = f9;
            }
            f6 = f2 - f8;
            f5 = 0.0f;
        } else {
            f5 = f;
            f6 = f2;
        }
        if (f4 > f11) {
            float f12 = (f4 - f2) / (f3 - f);
            f10 = f * f12;
            f3 = ((f11 - f2) + f10) / f12;
            if (f3 >= 0.0f) {
                float f13 = i2;
                if (f3 > f13) {
                    f4 = ((f12 * f13) + f2) - f10;
                    f3 = f13;
                } else {
                    f4 = f11;
                }
            }
            f4 = f2 - f10;
            f3 = 0.0f;
        } else if (f4 < 0.0f) {
            float f14 = (f4 - f2) / (f3 - f);
            f10 = f * f14;
            f3 = ((-f2) + f10) / f14;
            if (f3 >= 0.0f) {
                float f15 = i2;
                if (f3 > f15) {
                    f4 = ((f14 * f15) + f2) - f10;
                    f3 = f15;
                } else {
                    f4 = 0.0f;
                }
            }
            f4 = f2 - f10;
            f3 = 0.0f;
        }
        return new float[]{f5, f6, f3, f4};
    }

    public abstract void b(Canvas canvas, int i, int i2, int i3, int i4, Paint paint);

    /* JADX INFO: Access modifiers changed from: protected */
    public void c(org.achartengine.h.b bVar, Canvas canvas, int i, int i2, int i3, int i4, Paint paint, boolean z, int i5) {
        if (bVar.v() || z) {
            if (z) {
                paint.setColor(i5);
            } else {
                paint.setColor(bVar.b());
            }
            paint.setStyle(Paint.Style.FILL);
            canvas.drawRect(i, i2, i + i3, i2 + i4, paint);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public int d(Canvas canvas, org.achartengine.h.b bVar, String[] strArr, int i, int i2, int i3, int i4, int i5, int i6, Paint paint, boolean z) {
        int i7;
        int i8;
        float f;
        float f2;
        boolean z2;
        String str;
        String[] strArr2 = strArr;
        float f3 = 32.0f;
        if (bVar.H()) {
            float f4 = i;
            float f5 = ((i3 + i5) - i6) + 32.0f;
            paint.setTextAlign(Paint.Align.LEFT);
            paint.setTextSize(bVar.h());
            int min = Math.min(strArr2.length, bVar.n());
            float f6 = f4;
            int i9 = 0;
            while (i9 < min) {
                org.achartengine.h.c m = bVar.m(i9);
                float k = k(i9);
                if (m.e()) {
                    String str2 = strArr2[i9];
                    paint.setColor(strArr2.length == bVar.n() ? m.b() : -3355444);
                    int length = str2.length();
                    float[] fArr = new float[length];
                    paint.getTextWidths(str2, fArr);
                    float f7 = 0.0f;
                    i8 = min;
                    int i10 = 0;
                    while (i10 < length) {
                        f7 += fArr[i10];
                        i10++;
                        k = k;
                        i9 = i9;
                    }
                    float f8 = k + 10.0f + f7;
                    float f9 = f6 + f8;
                    if (i9 <= 0 || !i(f9, bVar, i2, i4)) {
                        f = f3;
                        f2 = f6;
                    } else {
                        f5 += bVar.h();
                        f9 = f4 + f8;
                        f = f3 + bVar.h();
                        f2 = f4;
                    }
                    float f10 = f9;
                    float f11 = f5;
                    if (i(f10, bVar, i2, i4)) {
                        float f12 = ((i2 - f2) - k) - 10.0f;
                        if (o(bVar)) {
                            f12 = ((i4 - f2) - k) - 10.0f;
                        }
                        int breakText = paint.breakText(str2, true, f12, fArr);
                        z2 = false;
                        str = String.valueOf(str2.substring(0, breakText)) + "...";
                    } else {
                        z2 = false;
                        str = str2;
                    }
                    if (z) {
                        i7 = i9;
                    } else {
                        i7 = i9;
                        e(canvas, m, f2, f11, i9, paint);
                        h(canvas, str, f2 + k + 5.0f, f11 + 5.0f, paint);
                    }
                    f6 = f2 + f8;
                    f5 = f11;
                    f3 = f;
                } else {
                    i7 = i9;
                    i8 = min;
                }
                i9 = i7 + 1;
                strArr2 = strArr;
                min = i8;
            }
        }
        return Math.round(f3 + bVar.h());
    }

    public abstract void e(Canvas canvas, org.achartengine.h.c cVar, float f, float f2, int i, Paint paint);

    /* JADX INFO: Access modifiers changed from: protected */
    public void f(Canvas canvas, List<Float> list, Paint paint, boolean z) {
        Path path = new Path();
        int height = canvas.getHeight();
        int width = canvas.getWidth();
        if (list.size() < 4) {
            return;
        }
        float[] a2 = a(list.get(0).floatValue(), list.get(1).floatValue(), list.get(2).floatValue(), list.get(3).floatValue(), height, width);
        path.moveTo(a2[0], a2[1]);
        path.lineTo(a2[2], a2[3]);
        int size = list.size();
        for (int i = 4; i < size; i += 2) {
            int i2 = i - 1;
            if (list.get(i2).floatValue() >= 0.0f || list.get(i + 1).floatValue() >= 0.0f) {
                float f = height;
                if (list.get(i2).floatValue() <= f || list.get(i + 1).floatValue() <= f) {
                    float[] a3 = a(list.get(i - 2).floatValue(), list.get(i2).floatValue(), list.get(i).floatValue(), list.get(i + 1).floatValue(), height, width);
                    if (!z) {
                        path.moveTo(a3[0], a3[1]);
                    }
                    path.lineTo(a3[2], a3[3]);
                }
            }
        }
        if (z) {
            path.lineTo(list.get(0).floatValue(), list.get(1).floatValue());
        }
        canvas.drawPath(path, paint);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void g(Canvas canvas, float[] fArr, Paint paint, boolean z) {
        Path path = new Path();
        int height = canvas.getHeight();
        int width = canvas.getWidth();
        if (fArr.length < 4) {
            return;
        }
        float[] a2 = a(fArr[0], fArr[1], fArr[2], fArr[3], height, width);
        path.moveTo(a2[0], a2[1]);
        path.lineTo(a2[2], a2[3]);
        int length = fArr.length;
        for (int i = 4; i < length; i += 2) {
            int i2 = i - 1;
            if (fArr[i2] >= 0.0f || fArr[i + 1] >= 0.0f) {
                float f = height;
                if (fArr[i2] <= f || fArr[i + 1] <= f) {
                    float[] a3 = a(fArr[i - 2], fArr[i2], fArr[i], fArr[i + 1], height, width);
                    if (!z) {
                        path.moveTo(a3[0], a3[1]);
                    }
                    path.lineTo(a3[2], a3[3]);
                }
            }
        }
        if (z) {
            path.lineTo(fArr[0], fArr[1]);
        }
        canvas.drawPath(path, paint);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void h(Canvas canvas, String str, float f, float f2, Paint paint) {
        if (str != null) {
            String[] split = str.split("\n");
            Rect rect = new Rect();
            int i = 0;
            for (int i2 = 0; i2 < split.length; i2++) {
                canvas.drawText(split[i2], f, i + f2, paint);
                paint.getTextBounds(split[i2], 0, split[i2].length(), rect);
                i = i + rect.height() + 5;
            }
        }
    }

    protected boolean i(float f, org.achartengine.h.b bVar, int i, int i2) {
        boolean z = f > ((float) i);
        if (o(bVar)) {
            return f > ((float) i2);
        }
        return z;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public String j(NumberFormat numberFormat, double d2) {
        if (numberFormat != null) {
            return numberFormat.format(d2);
        }
        return (d2 == ((double) Math.round(d2)) ? new StringBuilder(String.valueOf(Math.round(d2))) : new StringBuilder(String.valueOf(d2))).toString();
    }

    public abstract int k(int i);

    /* JADX INFO: Access modifiers changed from: protected */
    public int l(org.achartengine.h.b bVar, int i, float f) {
        int g = bVar.g();
        if (!bVar.H() || g != 0) {
            i = g;
        }
        return (bVar.H() || !bVar.G()) ? i : (int) (((bVar.f() * 4.0f) / 3.0f) + f);
    }

    public org.achartengine.g.b m(org.achartengine.g.a aVar) {
        return null;
    }

    public boolean n(double d2) {
        return Double.isNaN(d2) || Double.isInfinite(d2) || d2 == Double.MAX_VALUE;
    }

    public boolean o(org.achartengine.h.b bVar) {
        return (bVar instanceof org.achartengine.h.d) && ((org.achartengine.h.d) bVar).j0() == d.a.VERTICAL;
    }
}
