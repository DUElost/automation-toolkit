package c.a.a;

import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import me.zhanghai.android.materialprogressbar.BuildConfig;
import org.xmlpull.v1.b;
/* loaded from: classes.dex */
public class a implements b {

    /* renamed from: a  reason: collision with root package name */
    private Writer f1685a;

    /* renamed from: b  reason: collision with root package name */
    private boolean f1686b;

    /* renamed from: c  reason: collision with root package name */
    private int f1687c;

    /* renamed from: d  reason: collision with root package name */
    private int f1688d;
    private String[] e = new String[12];
    private int[] f = new int[4];
    private String[] g = new String[8];
    private boolean[] h = new boolean[4];
    private boolean i;
    private String j;

    private final void b(boolean z) {
        if (!this.f1686b) {
            return;
        }
        int i = this.f1688d + 1;
        this.f1688d = i;
        this.f1686b = false;
        boolean[] zArr = this.h;
        if (zArr.length <= i) {
            boolean[] zArr2 = new boolean[i + 4];
            System.arraycopy(zArr, 0, zArr2, 0, i);
            this.h = zArr2;
        }
        boolean[] zArr3 = this.h;
        int i2 = this.f1688d;
        zArr3[i2] = zArr3[i2 - 1];
        int i3 = this.f[i2 - 1];
        while (true) {
            int[] iArr = this.f;
            int i4 = this.f1688d;
            if (i3 >= iArr[i4]) {
                if (iArr.length <= i4 + 1) {
                    int[] iArr2 = new int[i4 + 8];
                    System.arraycopy(iArr, 0, iArr2, 0, i4 + 1);
                    this.f = iArr2;
                }
                int[] iArr3 = this.f;
                int i5 = this.f1688d;
                iArr3[i5 + 1] = iArr3[i5];
                this.f1685a.write(z ? " />" : ">");
                return;
            }
            this.f1685a.write(32);
            this.f1685a.write("xmlns");
            int i6 = i3 * 2;
            if (!BuildConfig.FLAVOR.equals(this.g[i6])) {
                this.f1685a.write(58);
                this.f1685a.write(this.g[i6]);
            } else if (BuildConfig.FLAVOR.equals(g()) && !BuildConfig.FLAVOR.equals(this.g[i6 + 1])) {
                throw new IllegalStateException("Cannot set default namespace for elements in no namespace");
            }
            this.f1685a.write("=\"");
            o(this.g[i6 + 1], 34);
            this.f1685a.write(34);
            i3++;
        }
    }

    private final String h(String str, boolean z, boolean z2) {
        int i = this.f[this.f1688d + 1] * 2;
        while (true) {
            i -= 2;
            String str2 = null;
            String str3 = BuildConfig.FLAVOR;
            if (i < 0) {
                if (z2) {
                    if (BuildConfig.FLAVOR.equals(str)) {
                        boolean z3 = this.f1686b;
                        this.f1686b = false;
                        l(str3, str);
                        this.f1686b = z3;
                        return str3;
                    }
                    do {
                        StringBuffer stringBuffer = new StringBuffer();
                        stringBuffer.append("n");
                        int i2 = this.f1687c;
                        this.f1687c = i2 + 1;
                        stringBuffer.append(i2);
                        String stringBuffer2 = stringBuffer.toString();
                        int i3 = (this.f[this.f1688d + 1] * 2) - 2;
                        while (true) {
                            if (i3 < 0) {
                                str3 = stringBuffer2;
                                continue;
                                break;
                            } else if (stringBuffer2.equals(this.g[i3])) {
                                str3 = null;
                                continue;
                                break;
                            } else {
                                i3 -= 2;
                            }
                        }
                    } while (str3 == null);
                    boolean z32 = this.f1686b;
                    this.f1686b = false;
                    l(str3, str);
                    this.f1686b = z32;
                    return str3;
                }
                return null;
            } else if (this.g[i + 1].equals(str) && (z || !this.g[i].equals(BuildConfig.FLAVOR))) {
                String str4 = this.g[i];
                int i4 = i + 2;
                while (true) {
                    if (i4 >= this.f[this.f1688d + 1] * 2) {
                        str2 = str4;
                        break;
                    } else if (this.g[i4].equals(str4)) {
                        break;
                    } else {
                        i4++;
                    }
                }
                if (str2 != null) {
                    return str2;
                }
            }
        }
    }

    /* JADX WARN: Code restructure failed: missing block: B:20:0x002b, code lost:
        if (r1 != '\'') goto L20;
     */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private final void o(java.lang.String r6, int r7) {
        /*
            r5 = this;
            r0 = 0
        L1:
            int r1 = r6.length()
            if (r0 >= r1) goto L9a
            char r1 = r6.charAt(r0)
            r2 = 9
            java.lang.String r3 = "&#"
            if (r1 == r2) goto L7a
            r2 = 10
            if (r1 == r2) goto L7a
            r2 = 13
            if (r1 == r2) goto L7a
            r2 = 34
            if (r1 == r2) goto L40
            r4 = 60
            if (r1 == r4) goto L3b
            r4 = 62
            if (r1 == r4) goto L36
            r4 = 38
            if (r1 == r4) goto L2e
            r4 = 39
            if (r1 == r4) goto L40
            goto L4f
        L2e:
            java.io.Writer r1 = r5.f1685a
            java.lang.String r2 = "&amp;"
        L32:
            r1.write(r2)
            goto L96
        L36:
            java.io.Writer r1 = r5.f1685a
            java.lang.String r2 = "&gt;"
            goto L32
        L3b:
            java.io.Writer r1 = r5.f1685a
            java.lang.String r2 = "&lt;"
            goto L32
        L40:
            if (r1 != r7) goto L4f
            java.io.Writer r3 = r5.f1685a
            if (r1 != r2) goto L49
            java.lang.String r1 = "&quot;"
            goto L4b
        L49:
            java.lang.String r1 = "&apos;"
        L4b:
            r3.write(r1)
            goto L96
        L4f:
            r2 = 32
            if (r1 < r2) goto L60
            r2 = 64
            if (r1 == r2) goto L60
            r2 = 127(0x7f, float:1.78E-43)
            if (r1 < r2) goto L7d
            boolean r2 = r5.i
            if (r2 == 0) goto L60
            goto L7d
        L60:
            java.io.Writer r2 = r5.f1685a
            java.lang.StringBuffer r4 = new java.lang.StringBuffer
            r4.<init>()
            r4.append(r3)
            r4.append(r1)
            java.lang.String r1 = ";"
            r4.append(r1)
        L72:
            java.lang.String r1 = r4.toString()
            r2.write(r1)
            goto L96
        L7a:
            r2 = -1
            if (r7 != r2) goto L83
        L7d:
            java.io.Writer r2 = r5.f1685a
            r2.write(r1)
            goto L96
        L83:
            java.io.Writer r2 = r5.f1685a
            java.lang.StringBuffer r4 = new java.lang.StringBuffer
            r4.<init>()
            r4.append(r3)
            r4.append(r1)
            r1 = 59
            r4.append(r1)
            goto L72
        L96:
            int r0 = r0 + 1
            goto L1
        L9a:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: c.a.a.a.o(java.lang.String, int):void");
    }

    public b a(String str, String str2, String str3) {
        if (this.f1686b) {
            if (str == null) {
                str = BuildConfig.FLAVOR;
            }
            String h = BuildConfig.FLAVOR.equals(str) ? BuildConfig.FLAVOR : h(str, false, true);
            this.f1685a.write(32);
            if (!BuildConfig.FLAVOR.equals(h)) {
                this.f1685a.write(h);
                this.f1685a.write(58);
            }
            this.f1685a.write(str2);
            this.f1685a.write(61);
            int i = str3.indexOf(34) != -1 ? 39 : 34;
            this.f1685a.write(i);
            o(str3, i);
            this.f1685a.write(i);
            return this;
        }
        throw new IllegalStateException("illegal position for attribute");
    }

    public void c() {
        while (true) {
            int i = this.f1688d;
            if (i <= 0) {
                e();
                return;
            } else {
                String[] strArr = this.e;
                d(strArr[(i * 3) - 3], strArr[(i * 3) - 1]);
            }
        }
    }

    public b d(String str, String str2) {
        if (!this.f1686b) {
            this.f1688d--;
        }
        if ((str == null && this.e[this.f1688d * 3] != null) || ((str != null && !str.equals(this.e[this.f1688d * 3])) || !this.e[(this.f1688d * 3) + 2].equals(str2))) {
            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("</{");
            stringBuffer.append(str);
            stringBuffer.append("}");
            stringBuffer.append(str2);
            stringBuffer.append("> does not match start");
            throw new IllegalArgumentException(stringBuffer.toString());
        }
        if (this.f1686b) {
            b(true);
            this.f1688d--;
        } else {
            if (this.h[this.f1688d + 1]) {
                this.f1685a.write("\r\n");
                for (int i = 0; i < this.f1688d; i++) {
                    this.f1685a.write("  ");
                }
            }
            this.f1685a.write("</");
            String str3 = this.e[(this.f1688d * 3) + 1];
            if (!BuildConfig.FLAVOR.equals(str3)) {
                this.f1685a.write(str3);
                this.f1685a.write(58);
            }
            this.f1685a.write(str2);
            this.f1685a.write(62);
        }
        int[] iArr = this.f;
        int i2 = this.f1688d;
        iArr[i2 + 1] = iArr[i2];
        return this;
    }

    public void e() {
        b(false);
        this.f1685a.flush();
    }

    public int f() {
        return this.f1686b ? this.f1688d + 1 : this.f1688d;
    }

    public String g() {
        if (f() == 0) {
            return null;
        }
        return this.e[(f() * 3) - 3];
    }

    public void i(String str, boolean z) {
        if (!"http://xmlpull.org/v1/doc/features.html#indent-output".equals(str)) {
            throw new RuntimeException("Unsupported Feature");
        }
        this.h[this.f1688d] = z;
    }

    public void j(OutputStream outputStream, String str) {
        if (outputStream == null) {
            throw new IllegalArgumentException();
        }
        k(str == null ? new OutputStreamWriter(outputStream) : new OutputStreamWriter(outputStream, str));
        this.j = str;
        if (str == null || !str.toLowerCase().startsWith("utf")) {
            return;
        }
        this.i = true;
    }

    public void k(Writer writer) {
        this.f1685a = writer;
        int[] iArr = this.f;
        iArr[0] = 2;
        iArr[1] = 2;
        String[] strArr = this.g;
        strArr[0] = BuildConfig.FLAVOR;
        strArr[1] = BuildConfig.FLAVOR;
        strArr[2] = "xml";
        strArr[3] = "http://www.w3.org/XML/1998/namespace";
        this.f1686b = false;
        this.f1687c = 0;
        this.f1688d = 0;
        this.i = false;
    }

    public void l(String str, String str2) {
        b(false);
        if (str == null) {
            str = BuildConfig.FLAVOR;
        }
        if (str2 == null) {
            str2 = BuildConfig.FLAVOR;
        }
        if (str.equals(h(str2, true, false))) {
            return;
        }
        int[] iArr = this.f;
        int i = this.f1688d + 1;
        int i2 = iArr[i];
        iArr[i] = i2 + 1;
        int i3 = i2 << 1;
        String[] strArr = this.g;
        int i4 = i3 + 1;
        if (strArr.length < i4) {
            String[] strArr2 = new String[strArr.length + 16];
            System.arraycopy(strArr, 0, strArr2, 0, i3);
            this.g = strArr2;
        }
        String[] strArr3 = this.g;
        strArr3[i3] = str;
        strArr3[i4] = str2;
    }

    public void m(String str, Boolean bool) {
        this.f1685a.write("<?xml version='1.0' ");
        if (str != null) {
            this.j = str;
            if (str.toLowerCase().startsWith("utf")) {
                this.i = true;
            }
        }
        if (this.j != null) {
            this.f1685a.write("encoding='");
            this.f1685a.write(this.j);
            this.f1685a.write("' ");
        }
        if (bool != null) {
            this.f1685a.write("standalone='");
            this.f1685a.write(bool.booleanValue() ? "yes" : "no");
            this.f1685a.write("' ");
        }
        this.f1685a.write("?>");
    }

    public b n(String str, String str2) {
        b(false);
        if (this.h[this.f1688d]) {
            this.f1685a.write("\r\n");
            for (int i = 0; i < this.f1688d; i++) {
                this.f1685a.write("  ");
            }
        }
        int i2 = this.f1688d * 3;
        String[] strArr = this.e;
        if (strArr.length < i2 + 3) {
            String[] strArr2 = new String[strArr.length + 12];
            System.arraycopy(strArr, 0, strArr2, 0, i2);
            this.e = strArr2;
        }
        String h = str == null ? BuildConfig.FLAVOR : h(str, true, true);
        if (BuildConfig.FLAVOR.equals(str)) {
            for (int i3 = this.f[this.f1688d]; i3 < this.f[this.f1688d + 1]; i3++) {
                int i4 = i3 * 2;
                if (BuildConfig.FLAVOR.equals(this.g[i4]) && !BuildConfig.FLAVOR.equals(this.g[i4 + 1])) {
                    throw new IllegalStateException("Cannot set default namespace for elements in no namespace");
                }
            }
        }
        String[] strArr3 = this.e;
        int i5 = i2 + 1;
        strArr3[i2] = str;
        strArr3[i5] = h;
        strArr3[i5 + 1] = str2;
        this.f1685a.write(60);
        if (!BuildConfig.FLAVOR.equals(h)) {
            this.f1685a.write(h);
            this.f1685a.write(58);
        }
        this.f1685a.write(str2);
        this.f1686b = true;
        return this;
    }
}
