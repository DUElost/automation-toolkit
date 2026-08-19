package org.achartengine.f;

import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Path;
import java.io.PrintStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
/* loaded from: classes.dex */
public class g extends c {
    private String l;
    private Double m;
    private float n;
    private float o;
    private org.achartengine.g.a p;
    private org.achartengine.g.a q;
    private org.achartengine.g.a r;

    public g(org.achartengine.g.d dVar, org.achartengine.h.d dVar2) {
        super(dVar, dVar2);
        this.p = new org.achartengine.g.a();
        this.q = new org.achartengine.g.a();
        this.r = new org.achartengine.g.a();
        this.n = 0.35f;
        this.o = 1.0f - 0.35f;
    }

    private void L(List<Float> list, org.achartengine.g.a aVar, int i, int i2, float f) {
        float floatValue = list.get(i).floatValue();
        float floatValue2 = list.get(i + 1).floatValue();
        aVar.c(floatValue + ((list.get(i2).floatValue() - floatValue) * f));
        aVar.d(floatValue2 + ((list.get(i2 + 1).floatValue() - floatValue2) * f));
    }

    private DateFormat M(double d2, double d3) {
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
        ArrayList arrayList = new ArrayList();
        int i2 = 0;
        if (!this.f2788c.X0()) {
            if (this.f2787b.d() <= 0) {
                System.out.println("viking flag -----------------------super");
                return super.D(d2, d3, i);
            }
            org.achartengine.g.e c2 = this.f2787b.c(0);
            int h = c2.h();
            PrintStream printStream = System.out;
            printStream.println("viking flag ---------length : " + h);
            while (i2 < h) {
                if (i2 == 0 || i2 == h - 1) {
                    PrintStream printStream2 = System.out;
                    printStream2.println("viking flag ---------: " + c2.q(i2));
                    arrayList.add(Double.valueOf(c2.q(i2)));
                }
                i2++;
            }
            return arrayList;
        }
        double d4 = 8.64E7d;
        if (this.m == null) {
            this.m = Double.valueOf((d2 - (d2 % 8.64E7d)) + 8.64E7d + (new Date(Math.round(d2)).getTimezoneOffset() * 60 * 1000));
        }
        int i3 = i <= 25 ? i : 25;
        double d5 = (d3 - d2) / i3;
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
            int i4 = i2 + 1;
            if (i2 > i3) {
                break;
            }
            arrayList.add(Double.valueOf(doubleValue));
            doubleValue += d4;
            i2 = i4;
        }
        return arrayList;
    }

    public void N(String str) {
        this.l = str;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // org.achartengine.f.a
    public void f(Canvas canvas, List<Float> list, Paint paint, boolean z) {
        System.out.println("viking flag --------------------circular : " + z);
        Path path = new Path();
        int i = 0;
        int i2 = 1;
        path.moveTo(list.get(0).floatValue(), list.get(1).floatValue());
        int size = list.size();
        if (z) {
            size -= 4;
        }
        int i3 = size;
        System.out.println("viking flag --------------------length : " + i3);
        int i4 = 0;
        while (i4 < i3) {
            int i5 = i4 + 2;
            int i6 = i5 < i3 ? i5 : i4;
            int i7 = i4 + 4;
            int i8 = i7 < i3 ? i7 : i6;
            int i9 = i6;
            L(list, this.p, i4, i6, this.o);
            this.q.c(list.get(i9).floatValue());
            this.q.d(list.get(i9 + 1).floatValue());
            L(list, this.r, i9, i8, this.n);
            path.cubicTo(this.p.a(), this.p.b(), this.q.a(), this.q.b(), this.r.a(), this.r.b());
            i3 = i3;
            i2 = 1;
            i = i;
            path = path;
            i4 = i5;
        }
        if (z) {
            for (int i10 = i3; i10 < i3 + 4; i10 += 2) {
                path.lineTo(list.get(i10).floatValue(), list.get(i10 + 1).floatValue());
            }
            path.lineTo(list.get(i).floatValue(), list.get(i2).floatValue());
        }
        canvas.drawPath(path, paint);
    }

    @Override // org.achartengine.f.i
    protected void u(List<Double> list, Double[] dArr, Canvas canvas, Paint paint, int i, int i2, int i3, double d2, double d3, double d4) {
        int i4;
        boolean z;
        DateFormat dateFormat;
        float f;
        long j;
        int size = list.size();
        System.out.println("viking flag -------------------length label: " + size);
        if (size > 0) {
            boolean G = this.f2788c.G();
            boolean F = this.f2788c.F();
            boolean I = this.f2788c.I();
            DateFormat M = M(list.get(0).doubleValue(), list.get(size - 1).doubleValue());
            int i5 = 0;
            while (i5 < size) {
                long round = Math.round(list.get(i5).doubleValue());
                int i6 = i5;
                DateFormat dateFormat2 = M;
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
                M = dateFormat;
                size = i4;
                G = z;
            }
        }
        v(dArr, canvas, paint, true, i, i2, i3, d2, d3, d4);
    }
}
