package c.c.a;

import c.c.a.k.i;
import java.util.HashMap;
/* loaded from: classes.dex */
public final class c {

    /* renamed from: a  reason: collision with root package name */
    private final Class<? extends Object> f1727a;

    /* renamed from: b  reason: collision with root package name */
    private i f1728b;

    public c(Class<? extends Object> cls) {
        this(cls, null);
    }

    public c(Class<? extends Object> cls, i iVar) {
        this.f1727a = cls;
        this.f1728b = iVar;
        new HashMap();
        new HashMap();
        new HashMap();
    }

    public i a() {
        return this.f1728b;
    }

    public Class<? extends Object> b() {
        return this.f1727a;
    }

    public String toString() {
        return "TypeDescription for " + b() + " (tag='" + a() + "')";
    }
}
