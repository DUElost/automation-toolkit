package d.o;

import d.e;
/* loaded from: classes.dex */
public class d implements a {

    /* renamed from: b  reason: collision with root package name */
    private static final a f2657b = new b();

    /* renamed from: c  reason: collision with root package name */
    private static final a f2658c = new c();

    /* renamed from: a  reason: collision with root package name */
    public final int f2659a;

    public d(int i) {
        this.f2659a = i;
    }

    @Override // d.o.a
    public e a(int i) {
        int i2 = this.f2659a;
        return ((i2 <= 0 || i <= i2) ? f2658c : f2657b).a(i);
    }
}
