package org.achartengine.g;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
/* loaded from: classes.dex */
public class d implements Serializable {

    /* renamed from: b  reason: collision with root package name */
    private List<e> f2792b = new ArrayList();

    public synchronized void a(e eVar) {
        this.f2792b.add(eVar);
    }

    public synchronized e[] b() {
        return (e[]) this.f2792b.toArray(new e[0]);
    }

    public synchronized e c(int i) {
        return this.f2792b.get(i);
    }

    public synchronized int d() {
        return this.f2792b.size();
    }

    public synchronized void e(e eVar) {
        this.f2792b.remove(eVar);
    }
}
