package c.c.a.i.a.a;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private static char[] f1779a;

    /* renamed from: b  reason: collision with root package name */
    private static byte[] f1780b;

    static {
        System.getProperty("line.separator");
        f1779a = new char[64];
        char c2 = 'A';
        int i = 0;
        while (c2 <= 'Z') {
            f1779a[i] = c2;
            c2 = (char) (c2 + 1);
            i++;
        }
        char c3 = 'a';
        while (c3 <= 'z') {
            f1779a[i] = c3;
            c3 = (char) (c3 + 1);
            i++;
        }
        char c4 = '0';
        while (c4 <= '9') {
            f1779a[i] = c4;
            c4 = (char) (c4 + 1);
            i++;
        }
        char[] cArr = f1779a;
        cArr[i] = '+';
        cArr[i + 1] = '/';
        f1780b = new byte[128];
        int i2 = 0;
        while (true) {
            byte[] bArr = f1780b;
            if (i2 >= bArr.length) {
                break;
            }
            bArr[i2] = -1;
            i2++;
        }
        for (int i3 = 0; i3 < 64; i3++) {
            f1780b[f1779a[i3]] = (byte) i3;
        }
    }

    public static char[] a(byte[] bArr) {
        return b(bArr, 0, bArr.length);
    }

    public static char[] b(byte[] bArr, int i, int i2) {
        int i3;
        int i4;
        int i5;
        int i6 = ((i2 * 4) + 2) / 3;
        char[] cArr = new char[((i2 + 2) / 3) * 4];
        int i7 = i2 + i;
        int i8 = 0;
        while (i < i7) {
            int i9 = i + 1;
            int i10 = bArr[i] & 255;
            if (i9 < i7) {
                i3 = i9 + 1;
                i4 = bArr[i9] & 255;
            } else {
                i3 = i9;
                i4 = 0;
            }
            if (i3 < i7) {
                i5 = bArr[i3] & 255;
                i3++;
            } else {
                i5 = 0;
            }
            int i11 = i10 >>> 2;
            int i12 = ((i10 & 3) << 4) | (i4 >>> 4);
            int i13 = ((i4 & 15) << 2) | (i5 >>> 6);
            int i14 = i5 & 63;
            int i15 = i8 + 1;
            char[] cArr2 = f1779a;
            cArr[i8] = cArr2[i11];
            int i16 = i15 + 1;
            cArr[i15] = cArr2[i12];
            char c2 = '=';
            cArr[i16] = i16 < i6 ? cArr2[i13] : '=';
            int i17 = i16 + 1;
            if (i17 < i6) {
                c2 = cArr2[i14];
            }
            cArr[i17] = c2;
            i8 = i17 + 1;
            i = i3;
        }
        return cArr;
    }
}
