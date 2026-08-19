package androidx.lifecycle;

import androidx.lifecycle.a;
import androidx.lifecycle.e;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class ReflectiveGenericLifecycleObserver implements d {

    /* renamed from: a  reason: collision with root package name */
    private final Object f1062a;

    /* renamed from: b  reason: collision with root package name */
    private final a.C0038a f1063b;

    /* JADX INFO: Access modifiers changed from: package-private */
    public ReflectiveGenericLifecycleObserver(Object obj) {
        this.f1062a = obj;
        this.f1063b = a.f1065c.c(obj.getClass());
    }

    @Override // androidx.lifecycle.d
    public void d(g gVar, e.a aVar) {
        this.f1063b.a(gVar, aVar, this.f1062a);
    }
}
