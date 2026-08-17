package androidx.lifecycle;

import java.util.HashMap;
/* loaded from: classes.dex */
public class r {

    /* renamed from: a  reason: collision with root package name */
    private final HashMap<String, p> f1088a = new HashMap<>();

    public final void a() {
        for (p pVar : this.f1088a.values()) {
            pVar.a();
        }
        this.f1088a.clear();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final p b(String str) {
        return this.f1088a.get(str);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public final void c(String str, p pVar) {
        p put = this.f1088a.put(str, pVar);
        if (put != null) {
            put.a();
        }
    }
}
