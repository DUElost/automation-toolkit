package b.b.a.a.c;

import java.util.List;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    public String f1370a;

    /* renamed from: b  reason: collision with root package name */
    public String f1371b;

    /* renamed from: c  reason: collision with root package name */
    public String f1372c = null;

    public a() {
    }

    public a(String str, String str2) {
        this.f1370a = str;
        this.f1371b = str2;
    }

    public static String a(List<a> list, String str) {
        for (a aVar : list) {
            if (aVar.f1370a.equalsIgnoreCase(str)) {
                String str2 = aVar.f1372c;
                return str2 != null ? str2 : aVar.f1371b;
            }
        }
        return null;
    }
}
