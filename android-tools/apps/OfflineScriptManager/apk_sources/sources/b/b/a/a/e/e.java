package b.b.a.a.e;

import java.util.LinkedHashMap;
import java.util.Map;
/* loaded from: classes.dex */
public class e {

    /* renamed from: a  reason: collision with root package name */
    private String f1419a;

    /* renamed from: b  reason: collision with root package name */
    private String f1420b;

    /* renamed from: c  reason: collision with root package name */
    Map<String, String> f1421c = new LinkedHashMap();

    /* renamed from: d  reason: collision with root package name */
    Map<String, d> f1422d = new LinkedHashMap();

    public void a(String str, String str2) {
        Map<String, String> map = this.f1421c;
        if (map != null) {
            map.put(str, str2);
        }
    }

    public void b(d dVar) {
        Map<String, d> map = this.f1422d;
        if (map != null) {
            map.put(dVar.b(), dVar);
        }
    }

    public String c() {
        return this.f1419a;
    }

    public Map<String, String> d() {
        return this.f1421c;
    }

    public String e() {
        return this.f1420b;
    }

    public Map<String, d> f() {
        return this.f1422d;
    }

    public void g(String str) {
        this.f1419a = str;
    }

    public void h(String str) {
        this.f1420b = str;
    }

    public void i(Map<String, d> map) {
        this.f1422d = map;
    }
}
