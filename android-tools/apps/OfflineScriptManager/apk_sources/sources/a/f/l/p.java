package a.f.l;

import android.content.Context;
import android.os.Build;
import android.view.PointerIcon;
/* loaded from: classes.dex */
public final class p {

    /* renamed from: a  reason: collision with root package name */
    private Object f193a;

    private p(Object obj) {
        this.f193a = obj;
    }

    public static p b(Context context, int i) {
        return Build.VERSION.SDK_INT >= 24 ? new p(PointerIcon.getSystemIcon(context, i)) : new p(null);
    }

    public Object a() {
        return this.f193a;
    }
}
