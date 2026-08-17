package b.e.a.h.i;

import b.e.a.h.g;
import b.e.a.j.i;
import java.util.Arrays;
/* loaded from: classes.dex */
public class a implements c {

    /* renamed from: a  reason: collision with root package name */
    private double f1536a;

    public a(double d2) {
        this.f1536a = d2;
    }

    @Override // b.e.a.h.i.c
    public long[] a(g gVar) {
        int i;
        double g = gVar.z().g();
        long j = (long) (this.f1536a * g);
        int i2 = 0;
        long[] jArr = new long[0];
        long[] f = gVar.f();
        long[] w = gVar.w();
        if (f == null) {
            long[] jArr2 = {1};
            double d2 = 0.0d;
            for (int i3 = 0; i3 < w.length; i3++) {
                d2 += w[i3] / g;
                if (d2 >= this.f1536a) {
                    if (i3 > 0) {
                        jArr2 = i.a(jArr2, i3 + 1);
                    }
                    d2 = 0.0d;
                }
            }
            if (d2 >= this.f1536a || jArr2.length <= 1) {
                return jArr2;
            }
            long[] jArr3 = new long[jArr2.length - 1];
            System.arraycopy(jArr2, 0, jArr3, 0, jArr2.length - 1);
            return jArr3;
        }
        int length = f.length;
        long[] jArr4 = new long[length];
        long k = gVar.k();
        long j2 = 0;
        int i4 = 0;
        long j3 = 0;
        while (i4 < w.length) {
            long[] jArr5 = jArr;
            int binarySearch = Arrays.binarySearch(f, i4 + 1);
            if (binarySearch >= 0) {
                jArr4[binarySearch] = j3;
            }
            j3 += w[i4];
            i4++;
            jArr = jArr5;
            i2 = 0;
        }
        int i5 = i2;
        while (true) {
            i = length - 1;
            if (i5 >= i) {
                break;
            }
            long j4 = jArr4[i5];
            int i6 = i5 + 1;
            long j5 = jArr4[i6];
            if (j2 <= j5 && Math.abs(j4 - j2) < Math.abs(j5 - j2)) {
                long[] jArr6 = new long[1];
                jArr6[i2] = f[i5];
                jArr = i.a(jArr, jArr6);
                j2 = jArr4[i5] + j;
            }
            i5 = i6;
        }
        if (k - jArr4[i] > j / 2) {
            long[] jArr7 = new long[1];
            jArr7[i2] = f[i];
            return i.a(jArr, jArr7);
        }
        return jArr;
    }
}
