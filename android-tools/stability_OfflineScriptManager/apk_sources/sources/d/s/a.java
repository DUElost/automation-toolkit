package d.s;

import java.util.Arrays;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private final byte[] f2721a;

    private a(byte[] bArr) {
        this.f2721a = bArr;
    }

    public static a a(d.e eVar) {
        return c(eVar.c(), true);
    }

    public static a b(byte[] bArr) {
        return c(bArr, false);
    }

    private static a c(byte[] bArr, boolean z) {
        if (z) {
            byte[] bArr2 = new byte[bArr.length];
            System.arraycopy(bArr, 0, bArr2, 0, bArr.length);
            return new a(bArr2);
        }
        return new a(bArr);
    }

    public byte[] d() {
        return this.f2721a;
    }

    public int e() {
        return this.f2721a.length;
    }

    public boolean equals(Object obj) {
        if (obj instanceof a) {
            return Arrays.equals(this.f2721a, ((a) obj).f2721a);
        }
        return false;
    }

    public int hashCode() {
        return Arrays.hashCode(this.f2721a);
    }
}
