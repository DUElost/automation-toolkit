package b.b.a.a.b;

import android.util.ArrayMap;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public class h {
    private g e;
    private String f;

    /* renamed from: a  reason: collision with root package name */
    private int f1362a = 0;

    /* renamed from: b  reason: collision with root package name */
    private long f1363b = 0;

    /* renamed from: c  reason: collision with root package name */
    private long f1364c = 0;

    /* renamed from: d  reason: collision with root package name */
    private long f1365d = 0;
    private List<c> g = new ArrayList();
    private Map<String, String> h = new ArrayMap();

    public void a(String str, String str2) {
        this.h.put(str, str2);
    }

    public void b(c cVar) {
        this.g.add(cVar);
    }

    public void c() {
        this.f1365d = this.f1364c - this.f1363b;
    }

    public long d() {
        c();
        return this.f1365d;
    }

    public long e() {
        return this.f1364c;
    }

    public int f() {
        return this.f1362a;
    }

    public String g() {
        return this.f;
    }

    public Map<String, String> h() {
        return this.h;
    }

    public long i() {
        return this.f1363b;
    }

    public g j() {
        return this.e;
    }

    public List<c> k() {
        return this.g;
    }

    public void l(long j) {
        this.f1364c = j;
    }

    public void m(String str) {
        this.f = str;
    }

    public void n(long j) {
        this.f1363b = j;
    }

    public void o(g gVar) {
        this.e = gVar;
    }
}
