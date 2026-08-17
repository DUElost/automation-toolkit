package c.c.a.i.b.a.a.a.a.a;
/* loaded from: classes.dex */
public abstract class c implements c.c.a.i.b.a.a.a.a.a.a {

    /* renamed from: a  reason: collision with root package name */
    private static final ThreadLocal<char[]> f1784a = new a();

    /* loaded from: classes.dex */
    static class a extends ThreadLocal<char[]> {
        a() {
        }

        /* JADX INFO: Access modifiers changed from: protected */
        @Override // java.lang.ThreadLocal
        /* renamed from: a */
        public char[] initialValue() {
            return new char[1024];
        }
    }

    protected static final int b(CharSequence charSequence, int i, int i2) {
        if (i < i2) {
            int i3 = i + 1;
            char charAt = charSequence.charAt(i);
            if (charAt < 55296 || charAt > 57343) {
                return charAt;
            }
            if (charAt > 56319) {
                StringBuilder sb = new StringBuilder();
                sb.append("Unexpected low surrogate character '");
                sb.append(charAt);
                sb.append("' with value ");
                sb.append((int) charAt);
                sb.append(" at index ");
                sb.append(i3 - 1);
                throw new IllegalArgumentException(sb.toString());
            } else if (i3 == i2) {
                return -charAt;
            } else {
                char charAt2 = charSequence.charAt(i3);
                if (Character.isLowSurrogate(charAt2)) {
                    return Character.toCodePoint(charAt, charAt2);
                }
                throw new IllegalArgumentException("Expected low surrogate but got char '" + charAt2 + "' with value " + ((int) charAt2) + " at index " + i3);
            }
        }
        throw new IndexOutOfBoundsException("Index exceeds specified range");
    }

    private static final char[] e(char[] cArr, int i, int i2) {
        char[] cArr2 = new char[i2];
        if (i > 0) {
            System.arraycopy(cArr, 0, cArr2, 0, i);
        }
        return cArr2;
    }

    protected abstract char[] c(int i);

    /* JADX INFO: Access modifiers changed from: protected */
    public final String d(String str, int i) {
        int length = str.length();
        char[] cArr = f1784a.get();
        int i2 = 0;
        int i3 = 0;
        while (i < length) {
            int b2 = b(str, i, length);
            if (b2 < 0) {
                throw new IllegalArgumentException("Trailing high surrogate at end of input");
            }
            char[] c2 = c(b2);
            if (c2 != null) {
                int i4 = i - i2;
                int i5 = i3 + i4;
                int length2 = c2.length + i5;
                if (cArr.length < length2) {
                    cArr = e(cArr, i3, length2 + (length - i) + 32);
                }
                if (i4 > 0) {
                    str.getChars(i2, i, cArr, i3);
                    i3 = i5;
                }
                if (c2.length > 0) {
                    System.arraycopy(c2, 0, cArr, i3, c2.length);
                    i3 += c2.length;
                }
            }
            i2 = (Character.isSupplementaryCodePoint(b2) ? 2 : 1) + i;
            i = f(str, i2, length);
        }
        int i6 = length - i2;
        if (i6 > 0) {
            int i7 = i6 + i3;
            if (cArr.length < i7) {
                cArr = e(cArr, i3, i7);
            }
            str.getChars(i2, length, cArr, i3);
            i3 = i7;
        }
        return new String(cArr, 0, i3);
    }

    protected abstract int f(CharSequence charSequence, int i, int i2);
}
