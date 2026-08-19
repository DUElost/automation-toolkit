package a.m;

import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public class l {

    /* renamed from: a  reason: collision with root package name */
    private ViewGroup f291a;

    /* renamed from: b  reason: collision with root package name */
    private Runnable f292b;

    /* JADX INFO: Access modifiers changed from: package-private */
    public static l b(View view) {
        return (l) view.getTag(j.transition_current_scene);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public static void c(View view, l lVar) {
        view.setTag(j.transition_current_scene, lVar);
    }

    public void a() {
        Runnable runnable;
        if (b(this.f291a) != this || (runnable = this.f292b) == null) {
            return;
        }
        runnable.run();
    }
}
