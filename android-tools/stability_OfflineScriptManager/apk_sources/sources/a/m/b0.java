package a.m;

import android.graphics.drawable.Drawable;
import android.view.View;
import android.view.ViewOverlay;
/* loaded from: classes.dex */
class b0 implements c0 {

    /* renamed from: a  reason: collision with root package name */
    private final ViewOverlay f240a;

    /* JADX INFO: Access modifiers changed from: package-private */
    public b0(View view) {
        this.f240a = view.getOverlay();
    }

    @Override // a.m.c0
    public void b(Drawable drawable) {
        this.f240a.add(drawable);
    }

    @Override // a.m.c0
    public void d(Drawable drawable) {
        this.f240a.remove(drawable);
    }
}
