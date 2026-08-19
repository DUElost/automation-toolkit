package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/* loaded from: classes.dex */
public class h extends c {
    private String l;
    private Double m;

    public h(org.achartengine.g.d dVar, org.achartengine.h.d dVar2) {
        super(dVar, dVar2);
    }

    private DateFormat L(double d2, double d3) {
        if (this.l != null) {
            try {
                return new SimpleDateFormat(this.l);
            } catch (Exception unused) {
            }
        }
        double d4 = d3 - d2;
        return (d4 <= 8.64E7d || d4 >= 4.32E8d) ? d4 < 8.64E7d ? SimpleDateFormat.getTimeInstance(2) : SimpleDateFormat.getDateInstance(2) : SimpleDateFormat.getDateTimeInstance(3, 3);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // org.achartengine.f.i
    public List<Double> D(double d2, double d3, int i) {
        int i2 = i;
        ArrayList arrayList = new ArrayList();
        int i3 = 0;
        if (this.f2788c.X0()) {
            double d4 = 8.64E7d;
            if (this.m == null) {
                this.m = Double.valueOf((d2 - (d2 % 8.64E7d)) + 8.64E7d + (new Date(Math.round(d2)).getTimezoneOffset() * 60 * 1000));
            }
            if (i2 > 25) {
                i2 = 25;
            }
            double d5 = (d3 - d2) / i2;
            if (d5 <= 0.0d) {
                return arrayList;
            }
            if (d5 <= 8.64E7d) {
                while (true) {
                    double d6 = d4 / 2.0d;
                    if (d5 >= d6) {
                        break;
                    }
                    d4 = d6;
                }
            } else {
                while (d5 > d4) {
                    d4 *= 2.0d;
                }
            }
            double doubleValue = this.m.doubleValue() - (Math.floor((this.m.doubleValue() - d2) / d4) * d4);
            while (doubleValue < d3) {
                int i4 = i3 + 1;
                if (i3 > i2) {
                    break;
                }
                arrayList.add(Double.valueOf(doubleValue));
                doubleValue += d4;
                i3 = i4;
            }
            return arrayList;
        } else if (this.f2787b.d() > 0) {
            org.achartengine.g.e c2 = this.f2787b.c(0);
            int h = c2.h();
            int i5 = -1;
            int i6 = 0;
            for (int i7 = 0; i7 < h; i7++) {
                double q = c2.q(i7);
                if (d2 <= q && q <= d3) {
                    i6++;
                    if (i5 < 0) {
                        i5 = i7;
                    }
                }
            }
            if (i6 < i2) {
                for (int i8 = i5; i8 < i5 + i6; i8++) {
                    arrayList.add(Double.valueOf(c2.q(i8)));
                }
            } else {
                float f = i6 / i2;
                int i9 = 0;
                while (i3 < h && i9 < i2) {
                    double q2 = c2.q(Math.round(i3 * f));
                    if (d2 <= q2 && q2 <= d3) {
                        arrayList.add(Double.valueOf(q2));
                        i9++;
                    }
                    i3++;
                }
            }
            return arrayList;
        } else {
            return super.D(d2, d3, i);
        }
    }

    public void M(String str) {
        this.l = str;
    }

    @Override // org.achartengine.f.i
    protected void u(List<Double> list, Double[] dArr, Canvas canvas, Paint paint, int i, int i2, int i3, double d2, double d3, double d4) {
        int i4;
        boolean z;
        DateFormat dateFormat;
        float f;
        long j;
        int size = list.size();
        if (size > 0) {
            boolean G = this.f2788c.G();
            boolean F = this.f2788c.F();
            boolean I = this.f2788c.I();
            DateFormat L = L(list.get(0).doubleValue(), list.get(size - 1).doubleValue());
            int i5 = 0;
            while (i5 < size) {
                long round = Math.round(list.get(i5).doubleValue());
                int i6 = i5;
                DateFormat dateFormat2 = L;
                float f2 = (float) (i + ((round - d3) * d2));
                if (G) {
                    paint.setColor(this.f2788c.s0());
                    if (I) {
                        float f3 = i3;
                        i4 = size;
                        z = G;
                        j = round;
                        canvas.drawLine(f2, f3, f2, f3 + (this.f2788c.f() / 3.0f), paint);
                    } else {
                        i4 = size;
                        z = G;
                        j = round;
                    }
                    Date date = new Date(j);
                    dateFormat = dateFormat2;
                    f = f2;
                    t(canvas, dateFormat.format(date), f2, i3 + ((this.f2788c.f() * 4.0f) / 3.0f) + this.f2788c.t0(), paint, this.f2788c.r0());
                } else {
                    i4 = size;
                    z = G;
                    dateFormat = dateFormat2;
                    f = f2;
                }
                if (F) {
                    paint.setColor(this.f2788c.f0(0));
                    canvas.drawLine(f, i3, f, i2, paint);
                }
                i5 = i6 + 1;
                L = dateFormat;
                size = i4;
                G = z;
            }
        }
        v(dArr, canvas, paint, true, i, i2, i3, d2, d3, d4);
    }
}
