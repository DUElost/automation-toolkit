package a.m;

import android.graphics.drawable.Drawable;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewGroupOverlay;
/* loaded from: classes.dex */
class v implements w {

    /* renamed from: a  reason: collision with root package name */
    private final ViewGroupOverlay f322a;

    /* JADX INFO: Access modifiers changed from: package-private */
    public v(ViewGroup viewGroup) {
        this.f322a = viewGroup.getOverlay();
    }

    @Override // a.m.w
    public void a(View view) {
        this.f322a.add(view);
    }

    @Override // a.m.c0
    public void b(Drawable drawable) {
        this.f322a.add(drawable);
    }

    @Override // a.m.w
    public void c(View view) {
        this.f322a.remove(view);
    }

    @Override // a.m.c0
    public void d(Drawable drawable) {
        this.f322a.remove(drawable);
    }
}
