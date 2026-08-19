package b.b.a.a.e;

import java.util.LinkedHashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class d {

    /* renamed from: a  reason: collision with root package name */
    private String f1416a;

    /* renamed from: b  reason: collision with root package name */
    private String f1417b;

    /* renamed from: c  reason: collision with root package name */
    Map<String, a> f1418c = new LinkedHashMap();

    public d() {
    }

    public d(String str) {
        e(str);
    }

    public void a(a aVar) {
        Map<String, a> map = this.f1418c;
        if (map != null) {
            map.put(aVar.b(), aVar);
        }
    }

    public String b() {
        return this.f1416a;
    }

    public String c() {
        return this.f1417b;
    }

    public Map<String, a> d() {
        return this.f1418c;
    }

    public void e(String str) {
        this.f1416a = str;
    }

    public void f(String str) {
        this.f1417b = str;
    }
}
