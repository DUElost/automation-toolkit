package androidx.appcompat.view.menu;

import android.content.Context;
import android.os.Build;
import android.view.Menu;
import android.view.MenuItem;
import android.view.SubMenu;
/* loaded from: classes.dex */
public final class q {
    public static Menu a(Context context, a.f.f.a.a aVar) {
        return new r(context, aVar);
    }

    public static MenuItem b(Context context, a.f.f.a.b bVar) {
        return Build.VERSION.SDK_INT >= 16 ? new l(context, bVar) : new k(context, bVar);
    }

    public static SubMenu c(Context context, a.f.f.a.c cVar) {
        return new v(context, cVar);
    }
}
