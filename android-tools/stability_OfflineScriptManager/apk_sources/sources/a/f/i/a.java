package a.f.i;

import a.f.k.g;
import android.util.Base64;
import java.util.List;
/* loaded from: classes.dex */
public final class a {

    /* renamed from: a  reason: collision with root package name */
    private final String f119a;

    /* renamed from: b  reason: collision with root package name */
    private final String f120b;

    /* renamed from: c  reason: collision with root package name */
    private final String f121c;

    /* renamed from: d  reason: collision with root package name */
    private final List<List<byte[]>> f122d;
    private final int e;
    private final String f;

    public a(String str, String str2, String str3, List<List<byte[]>> list) {
        g.b(str);
        String str4 = str;
        this.f119a = str4;
        g.b(str2);
        String str5 = str2;
        this.f120b = str5;
        g.b(str3);
        String str6 = str3;
        this.f121c = str6;
        g.b(list);
        this.f122d = list;
        this.e = 0;
        this.f = str4 + "-" + str5 + "-" + str6;
    }

    public List<List<byte[]>> a() {
        return this.f122d;
    }

    public int b() {
        return this.e;
    }

    public String c() {
        return this.f;
    }

    public String d() {
        return this.f119a;
    }

    public String e() {
        return this.f120b;
    }

    public String f() {
        return this.f121c;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("FontRequest {mProviderAuthority: " + this.f119a + ", mProviderPackage: " + this.f120b + ", mQuery: " + this.f121c + ", mCertificates:");
        for (int i = 0; i < this.f122d.size(); i++) {
            sb.append(" [");
            List<byte[]> list = this.f122d.get(i);
            for (int i2 = 0; i2 < list.size(); i2++) {
                sb.append(" \"");
                sb.append(Base64.encodeToString(list.get(i2), 0));
                sb.append("\"");
            }
            sb.append(" ]");
        }
        sb.append("}");
        sb.append("mCertificatesArray: " + this.e);
        return sb.toString();
    }
}
