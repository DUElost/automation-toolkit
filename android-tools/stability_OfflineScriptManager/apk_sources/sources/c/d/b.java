package c.d;

import d.k;
/* loaded from: classes.dex */
public class b extends RuntimeException {

    /* renamed from: b  reason: collision with root package name */
    private final int f1852b;

    public b(int i) {
        super("Errno " + i);
        this.f1852b = i;
    }

    @Override // java.lang.Throwable
    public String toString() {
        return String.valueOf(super.toString()) + " : " + k.b(this.f1852b);
    }
}
