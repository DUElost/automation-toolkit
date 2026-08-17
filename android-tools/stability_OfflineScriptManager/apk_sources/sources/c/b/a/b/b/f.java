package c.b.a.b.b;

import java.lang.ref.SoftReference;
import java.util.StringTokenizer;
/* loaded from: classes.dex */
abstract class f implements c.b.a.a.c {
    private static boolean h = true;

    /* renamed from: a  reason: collision with root package name */
    int f1700a;

    /* renamed from: b  reason: collision with root package name */
    String f1701b;

    /* renamed from: c  reason: collision with root package name */
    String f1702c;

    /* renamed from: d  reason: collision with root package name */
    Class f1703d;
    a e;
    private String f;
    ClassLoader g = null;

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public interface a {
        void a(int i, String str);

        String get(int i);
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public static final class b implements a {

        /* renamed from: a  reason: collision with root package name */
        private SoftReference f1704a;

        public b() {
            c();
        }

        private String[] b() {
            return (String[]) this.f1704a.get();
        }

        private String[] c() {
            String[] strArr = new String[3];
            this.f1704a = new SoftReference(strArr);
            return strArr;
        }

        @Override // c.b.a.b.b.f.a
        public void a(int i, String str) {
            String[] b2 = b();
            if (b2 == null) {
                b2 = c();
            }
            b2[i] = str;
        }

        @Override // c.b.a.b.b.f.a
        public String get(int i) {
            String[] b2 = b();
            if (b2 == null) {
                return null;
            }
            return b2[i];
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public f(int i, String str, Class cls) {
        this.f1700a = -1;
        this.f1700a = i;
        this.f1701b = str;
        this.f1703d = cls;
    }

    private ClassLoader h() {
        if (this.g == null) {
            this.g = getClass().getClassLoader();
        }
        return this.g;
    }

    protected abstract String a(h hVar);

    int b(int i) {
        return Integer.parseInt(c(i), 16);
    }

    String c(int i) {
        int indexOf = this.f.indexOf(45);
        int i2 = 0;
        while (true) {
            int i3 = i - 1;
            if (i <= 0) {
                break;
            }
            i2 = indexOf + 1;
            indexOf = this.f.indexOf(45, i2);
            i = i3;
        }
        if (indexOf == -1) {
            indexOf = this.f.length();
        }
        return this.f.substring(i2, indexOf);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Class d(int i) {
        return c.b.a.b.b.b.b(c(i), h());
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public Class[] e(int i) {
        StringTokenizer stringTokenizer = new StringTokenizer(c(i), ":");
        int countTokens = stringTokenizer.countTokens();
        Class[] clsArr = new Class[countTokens];
        for (int i2 = 0; i2 < countTokens; i2++) {
            clsArr[i2] = c.b.a.b.b.b.b(stringTokenizer.nextToken(), h());
        }
        return clsArr;
    }

    public Class f() {
        if (this.f1703d == null) {
            this.f1703d = d(2);
        }
        return this.f1703d;
    }

    public String g() {
        if (this.f1702c == null) {
            this.f1702c = f().getName();
        }
        return this.f1702c;
    }

    public int i() {
        if (this.f1700a == -1) {
            this.f1700a = b(0);
        }
        return this.f1700a;
    }

    public String j() {
        if (this.f1701b == null) {
            this.f1701b = c(1);
        }
        return this.f1701b;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Removed duplicated region for block: B:12:0x001e  */
    /* JADX WARN: Removed duplicated region for block: B:15:0x0026  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public java.lang.String k(c.b.a.b.b.h r3) {
        /*
            r2 = this;
            boolean r0 = c.b.a.b.b.f.h
            if (r0 == 0) goto L1b
            c.b.a.b.b.f$a r0 = r2.e
            if (r0 != 0) goto L14
            c.b.a.b.b.f$b r0 = new c.b.a.b.b.f$b     // Catch: java.lang.Throwable -> L10
            r0.<init>()     // Catch: java.lang.Throwable -> L10
            r2.e = r0     // Catch: java.lang.Throwable -> L10
            goto L1b
        L10:
            r0 = 0
            c.b.a.b.b.f.h = r0
            goto L1b
        L14:
            int r1 = r3.f
            java.lang.String r0 = r0.get(r1)
            goto L1c
        L1b:
            r0 = 0
        L1c:
            if (r0 != 0) goto L22
            java.lang.String r0 = r2.a(r3)
        L22:
            boolean r1 = c.b.a.b.b.f.h
            if (r1 == 0) goto L2d
            c.b.a.b.b.f$a r1 = r2.e
            int r3 = r3.f
            r1.a(r3, r0)
        L2d:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: c.b.a.b.b.f.k(c.b.a.b.b.h):java.lang.String");
    }

    public final String toString() {
        return k(h.h);
    }
}
