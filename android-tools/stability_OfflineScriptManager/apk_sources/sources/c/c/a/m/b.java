package c.c.a.m;

import c.c.a.k.i;
import java.util.regex.Pattern;
/* loaded from: classes.dex */
final class b {

    /* renamed from: a  reason: collision with root package name */
    private final i f1833a;

    /* renamed from: b  reason: collision with root package name */
    private final Pattern f1834b;

    public b(i iVar, Pattern pattern) {
        this.f1833a = iVar;
        this.f1834b = pattern;
    }

    public Pattern a() {
        return this.f1834b;
    }

    public i b() {
        return this.f1833a;
    }

    public String toString() {
        return "Tuple tag=" + this.f1833a + " regexp=" + this.f1834b;
    }
}
