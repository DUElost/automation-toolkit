package b.b.a.a.e;

import java.util.LinkedHashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private String f1410a;

    /* renamed from: b  reason: collision with root package name */
    Map<String, c> f1411b = new LinkedHashMap();

    public a() {
    }

    public a(String str) {
        d(str);
    }

    public void a(c cVar) {
        Map<String, c> map = this.f1411b;
        if (map != null) {
            map.put(cVar.b(), cVar);
        }
    }

    public String b() {
        return this.f1410a;
    }

    public Map<String, c> c() {
        return this.f1411b;
    }

    public void d(String str) {
        this.f1410a = str;
    }
}
