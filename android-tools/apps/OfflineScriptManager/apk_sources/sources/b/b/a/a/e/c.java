package b.b.a.a.e;

import java.util.LinkedHashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class c {

    /* renamed from: a  reason: collision with root package name */
    private String f1414a;

    /* renamed from: b  reason: collision with root package name */
    Map<String, b> f1415b = new LinkedHashMap();

    public c() {
    }

    public c(String str) {
        d(str);
    }

    public void a(b bVar) {
        Map<String, b> map = this.f1415b;
        if (map != null) {
            map.put(bVar.a(), bVar);
        }
    }

    public String b() {
        return this.f1414a;
    }

    public Map<String, b> c() {
        return this.f1415b;
    }

    public void d(String str) {
        this.f1414a = str;
    }
}
