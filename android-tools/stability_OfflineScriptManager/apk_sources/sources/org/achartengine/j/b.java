package org.achartengine.j;

import java.text.NumberFormat;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class b {

    /* renamed from: a  reason: collision with root package name */
    private static final NumberFormat f2819a = NumberFormat.getNumberInstance();

    private static double[] a(double d2, double d3, int i) {
        boolean z;
        if (Math.abs(d2 - d3) < 1.0000000116860974E-7d) {
            return new double[]{d2, d2, 0.0d};
        }
        if (d2 > d3) {
            z = true;
            d2 = d3;
            d3 = d2;
        } else {
            z = false;
        }
        double c2 = c(Math.abs(d2 - d3) / i);
        double ceil = Math.ceil(d2 / c2) * c2;
        double floor = Math.floor(d3 / c2) * c2;
        double[] dArr = new double[3];
        if (z) {
            dArr[0] = floor;
            dArr[1] = ceil;
            dArr[2] = c2 * (-1.0d);
            return dArr;
        }
        dArr[0] = ceil;
        dArr[1] = floor;
        dArr[2] = c2;
        return dArr;
    }

    public static List<Double> b(double d2, double d3, int i) {
        ArrayList arrayList = new ArrayList();
        if (i <= 0) {
            return arrayList;
        }
        f2819a.setMaximumFractionDigits(5);
        double[] a2 = a(d2, d3, i);
        int i2 = ((int) ((a2[1] - a2[0]) / a2[2])) + 1;
        for (int i3 = 0; i3 < i2; i3++) {
            double d4 = a2[0] + (i3 * a2[2]);
            try {
                NumberFormat numberFormat = f2819a;
                d4 = numberFormat.parse(numberFormat.format(d4)).doubleValue();
            } catch (ParseException unused) {
            }
            arrayList.add(Double.valueOf(d4));
        }
        return arrayList;
    }

    private static double c(double d2) {
        int floor = (int) Math.floor(Math.log10(d2));
        double pow = d2 * Math.pow(10.0d, -floor);
        if (pow > 5.0d) {
            pow = 10.0d;
        } else if (pow > 2.0d) {
            pow = 5.0d;
        } else if (pow > 1.0d) {
            pow = 2.0d;
        }
        return pow * Math.pow(10.0d, floor);
    }
}
