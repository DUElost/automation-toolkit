package c.c.a.n;

import java.util.Arrays;
/* loaded from: classes.dex */
public final class a {

    /* renamed from: d  reason: collision with root package name */
    public static final a f1835d = new a("\n\u0085\u2028\u2029");
    public static final a e;
    public static final a f;

    /* renamed from: a  reason: collision with root package name */
    private String f1836a;

    /* renamed from: b  reason: collision with root package name */
    boolean[] f1837b;

    /* renamed from: c  reason: collision with root package name */
    boolean f1838c;

    static {
        new a("\r\n\u0085\u2028\u2029");
        new a("\u0000\r\n\u0085\u2028\u2029");
        new a(" \u0000\r\n\u0085\u2028\u2029");
        e = new a("\t \u0000\r\n\u0085\u2028\u2029");
        f = new a("\u0000 \t");
        new a("abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-_-;/?:@&=+$,_.!~*'()[]%");
        new a("abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ-_");
    }

    private a(String str) {
        boolean[] zArr = new boolean[128];
        this.f1837b = zArr;
        this.f1838c = false;
        Arrays.fill(zArr, false);
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < str.length(); i++) {
            char charAt = str.charAt(i);
            if (charAt < 128) {
                this.f1837b[charAt] = true;
            } else {
                sb.append(charAt);
            }
        }
        if (sb.length() > 0) {
            this.f1838c = true;
            this.f1836a = sb.toString();
        }
    }

    public boolean a(char c2) {
        return c2 < 128 ? this.f1837b[c2] : this.f1838c && this.f1836a.indexOf(c2, 0) != -1;
    }

    public boolean b(char c2, String str) {
        return a(c2) || str.indexOf(c2, 0) != -1;
    }

    public boolean c(char c2) {
        return !a(c2);
    }
}
