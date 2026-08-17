package a.f.l;

import android.os.Build;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public final class t {
    public static boolean a(ViewGroup viewGroup) {
        if (Build.VERSION.SDK_INT >= 21) {
            return viewGroup.isTransitionGroup();
        }
        Boolean bool = (Boolean) viewGroup.getTag(a.f.c.tag_transition_group);
        return ((bool == null || !bool.booleanValue()) && viewGroup.getBackground() == null && r.w(viewGroup) == null) ? false : true;
    }
}
