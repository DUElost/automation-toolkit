package c.c.a.i.b.a.a.a.a.a;
/* loaded from: classes.dex */
public class b extends c {

    /* renamed from: d  reason: collision with root package name */
    private static final char[] f1781d = {'+'};
    private static final char[] e = "0123456789ABCDEF".toCharArray();

    /* renamed from: b  reason: collision with root package name */
    private final boolean f1782b;

    /* renamed from: c  reason: collision with root package name */
    private final boolean[] f1783c;

    public b(String str, boolean z) {
        if (str.matches(".*[0-9A-Za-z].*")) {
            throw new IllegalArgumentException("Alphanumeric characters are always 'safe' and should not be explicitly specified");
        }
        if (z && str.contains(" ")) {
            throw new IllegalArgumentException("plusForSpace cannot be specified when space is a 'safe' character");
        }
        if (str.contains("%")) {
            throw new IllegalArgumentException("The '%' character cannot be specified as 'safe'");
        }
        this.f1782b = z;
        this.f1783c = g(str);
    }

    private static boolean[] g(String str) {
        char[] charArray = str.toCharArray();
        int i = 122;
        for (char c2 : charArray) {
            i = Math.max((int) c2, i);
        }
        boolean[] zArr = new boolean[i + 1];
        for (int i2 = 48; i2 <= 57; i2++) {
            zArr[i2] = true;
        }
        for (int i3 = 65; i3 <= 90; i3++) {
            zArr[i3] = true;
        }
        for (int i4 = 97; i4 <= 122; i4++) {
            zArr[i4] = true;
        }
        for (char c3 : charArray) {
            zArr[c3] = true;
        }
        return zArr;
    }

    @Override // c.c.a.i.b.a.a.a.a.a.a
    public String a(String str) {
        int length = str.length();
        for (int i = 0; i < length; i++) {
            char charAt = str.charAt(i);
            boolean[] zArr = this.f1783c;
            if (charAt >= zArr.length || !zArr[charAt]) {
                return d(str, i);
            }
        }
        return str;
    }

    @Override // c.c.a.i.b.a.a.a.a.a.c
    protected char[] c(int i) {
        boolean[] zArr = this.f1783c;
        if (i >= zArr.length || !zArr[i]) {
            if (i == 32 && this.f1782b) {
                return f1781d;
            }
            if (i <= 127) {
                char[] cArr = e;
                return new char[]{'%', cArr[i >>> 4], cArr[i & 15]};
            } else if (i <= 2047) {
                char[] cArr2 = e;
                char[] cArr3 = {'%', cArr2[(r14 >>> 4) | 12], cArr2[r14 & 15], '%', cArr2[(r14 & 3) | 8], cArr2[i & 15]};
                int i2 = i >>> 4;
                int i3 = i2 >>> 2;
                return cArr3;
            } else if (i <= 65535) {
                char[] cArr4 = e;
                char[] cArr5 = {'%', 'E', cArr4[r14 >>> 2], '%', cArr4[(r14 & 3) | 8], cArr4[r14 & 15], '%', cArr4[(r14 & 3) | 8], cArr4[i & 15]};
                int i4 = i >>> 4;
                int i5 = i4 >>> 2;
                int i6 = i5 >>> 4;
                return cArr5;
            } else if (i > 1114111) {
                throw new IllegalArgumentException("Invalid unicode character value " + i);
            } else {
                char[] cArr6 = e;
                char[] cArr7 = {'%', 'F', cArr6[(r14 >>> 2) & 7], '%', cArr6[(r14 & 3) | 8], cArr6[r14 & 15], '%', cArr6[(r14 & 3) | 8], cArr6[r14 & 15], '%', cArr6[(r14 & 3) | 8], cArr6[i & 15]};
                int i7 = i >>> 4;
                int i8 = i7 >>> 2;
                int i9 = i8 >>> 4;
                int i10 = i9 >>> 2;
                int i11 = i10 >>> 4;
                return cArr7;
            }
        }
        return null;
    }

    @Override // c.c.a.i.b.a.a.a.a.a.c
    protected int f(CharSequence charSequence, int i, int i2) {
        while (i < i2) {
            char charAt = charSequence.charAt(i);
            boolean[] zArr = this.f1783c;
            if (charAt >= zArr.length || !zArr[charAt]) {
                break;
            }
            i++;
        }
        return i;
    }
}
