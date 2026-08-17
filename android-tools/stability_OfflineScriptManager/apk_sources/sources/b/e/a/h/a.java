package b.e.a.h;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
/* loaded from: classes.dex */
public abstract class a implements g {

    /* renamed from: b  reason: collision with root package name */
    String f1521b;

    /* renamed from: c  reason: collision with root package name */
    List<c> f1522c = new ArrayList();

    /* renamed from: d  reason: collision with root package name */
    Map<b.e.a.i.d.d.b, long[]> f1523d = new HashMap();

    public a(String str) {
        this.f1521b = str;
    }

    @Override // b.e.a.h.g
    public List<c> c() {
        return this.f1522c;
    }

    @Override // b.e.a.h.g
    public String getName() {
        return this.f1521b;
    }

    @Override // b.e.a.h.g
    public long k() {
        long j = 0;
        for (long j2 : w()) {
            j += j2;
        }
        return j;
    }

    @Override // b.e.a.h.g
    public Map<b.e.a.i.d.d.b, long[]> o() {
        return this.f1523d;
    }
}
