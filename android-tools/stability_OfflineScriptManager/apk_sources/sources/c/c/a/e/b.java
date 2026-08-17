package c.c.a.e;

import c.c.a.j.f;
import c.c.a.k.e;
import c.c.a.k.i;
import java.util.ArrayList;
import java.util.EnumMap;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
/* loaded from: classes.dex */
public abstract class b {

    /* renamed from: a  reason: collision with root package name */
    protected final Map<e, Object> f1733a = new EnumMap(e.class);

    /* renamed from: b  reason: collision with root package name */
    protected final Map<i, Object> f1734b = new HashMap();

    /* renamed from: c  reason: collision with root package name */
    private f f1735c;

    /* renamed from: d  reason: collision with root package name */
    private boolean f1736d;

    public b() {
        new HashMap();
        new HashMap();
        new HashSet();
        new ArrayList();
        new ArrayList();
        this.f1736d = false;
    }

    public final f a() {
        if (this.f1735c == null) {
            this.f1735c = new f();
        }
        return this.f1735c;
    }

    public final boolean b() {
        return this.f1736d;
    }

    public void c(f fVar) {
        this.f1735c = fVar;
        this.f1736d = true;
    }
}
