package b.d.a.a.k;

import android.animation.TimeInterpolator;
import android.view.animation.DecelerateInterpolator;
import android.view.animation.LinearInterpolator;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    public static final TimeInterpolator f1467a;

    /* renamed from: b  reason: collision with root package name */
    public static final TimeInterpolator f1468b;

    /* renamed from: c  reason: collision with root package name */
    public static final TimeInterpolator f1469c;

    /* renamed from: d  reason: collision with root package name */
    public static final TimeInterpolator f1470d;

    static {
        new LinearInterpolator();
        f1467a = new a.i.a.a.b();
        f1468b = new a.i.a.a.a();
        f1469c = new a.i.a.a.c();
        f1470d = new DecelerateInterpolator();
    }

    public static float a(float f, float f2, float f3) {
        return f + (f3 * (f2 - f));
    }

    public static int b(int i, int i2, float f) {
        return i + Math.round(f * (i2 - i));
    }
}
