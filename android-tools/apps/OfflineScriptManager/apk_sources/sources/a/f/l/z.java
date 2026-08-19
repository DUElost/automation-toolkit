package a.f.l;

import android.os.Build;
import android.view.WindowInsets;
/* loaded from: classes.dex */
public class z {

    /* renamed from: a  reason: collision with root package name */
    private final Object f214a;

    private z(Object obj) {
        this.f214a = obj;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static Object g(z zVar) {
        if (zVar == null) {
            return null;
        }
        return zVar.f214a;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static z h(Object obj) {
        if (obj == null) {
            return null;
        }
        return new z(obj);
    }

    public int a() {
        if (Build.VERSION.SDK_INT >= 20) {
            return ((WindowInsets) this.f214a).getSystemWindowInsetBottom();
        }
        return 0;
    }

    public int b() {
        if (Build.VERSION.SDK_INT >= 20) {
            return ((WindowInsets) this.f214a).getSystemWindowInsetLeft();
        }
        return 0;
    }

    public int c() {
        if (Build.VERSION.SDK_INT >= 20) {
            return ((WindowInsets) this.f214a).getSystemWindowInsetRight();
        }
        return 0;
    }

    public int d() {
        if (Build.VERSION.SDK_INT >= 20) {
            return ((WindowInsets) this.f214a).getSystemWindowInsetTop();
        }
        return 0;
    }

    public boolean e() {
        if (Build.VERSION.SDK_INT >= 21) {
            return ((WindowInsets) this.f214a).isConsumed();
        }
        return false;
    }

    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null || z.class != obj.getClass()) {
            return false;
        }
        Object obj2 = this.f214a;
        Object obj3 = ((z) obj).f214a;
        return obj2 == null ? obj3 == null : obj2.equals(obj3);
    }

    public z f(int i, int i2, int i3, int i4) {
        if (Build.VERSION.SDK_INT >= 20) {
            return new z(((WindowInsets) this.f214a).replaceSystemWindowInsets(i, i2, i3, i4));
        }
        return null;
    }

    public int hashCode() {
        Object obj = this.f214a;
        if (obj == null) {
            return 0;
        }
        return obj.hashCode();
    }
}
