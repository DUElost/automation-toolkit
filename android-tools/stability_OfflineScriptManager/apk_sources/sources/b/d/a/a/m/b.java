package b.d.a.a.m;

import android.annotation.SuppressLint;
import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import android.widget.FrameLayout;
import b.d.a.a.m.d;
/* loaded from: classes.dex */
public class b extends FrameLayout implements d {

    /* renamed from: b  reason: collision with root package name */
    private final c f1493b;

    @Override // b.d.a.a.m.d
    public void a() {
        this.f1493b.a();
    }

    @Override // b.d.a.a.m.d
    public void b() {
        this.f1493b.b();
    }

    @Override // android.view.View
    @SuppressLint({"MissingSuperCall"})
    public void draw(Canvas canvas) {
        c cVar = this.f1493b;
        if (cVar != null) {
            cVar.c(canvas);
        } else {
            super.draw(canvas);
        }
    }

    public Drawable getCircularRevealOverlayDrawable() {
        return this.f1493b.d();
    }

    @Override // b.d.a.a.m.d
    public int getCircularRevealScrimColor() {
        return this.f1493b.e();
    }

    @Override // b.d.a.a.m.d
    public d.e getRevealInfo() {
        return this.f1493b.f();
    }

    @Override // android.view.View
    public boolean isOpaque() {
        c cVar = this.f1493b;
        return cVar != null ? cVar.g() : super.isOpaque();
    }

    @Override // b.d.a.a.m.d
    public void setCircularRevealOverlayDrawable(Drawable drawable) {
        this.f1493b.h(drawable);
    }

    @Override // b.d.a.a.m.d
    public void setCircularRevealScrimColor(int i) {
        this.f1493b.i(i);
    }

    @Override // b.d.a.a.m.d
    public void setRevealInfo(d.e eVar) {
        this.f1493b.j(eVar);
    }
}
