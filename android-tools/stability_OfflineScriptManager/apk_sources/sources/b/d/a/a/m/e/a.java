package b.d.a.a.m.e;

import android.graphics.Canvas;
import android.graphics.drawable.Drawable;
import androidx.cardview.widget.CardView;
import b.d.a.a.m.c;
import b.d.a.a.m.d;
/* loaded from: classes.dex */
public class a extends CardView implements d {
    private final c k;

    @Override // b.d.a.a.m.d
    public void a() {
        this.k.a();
    }

    @Override // b.d.a.a.m.d
    public void b() {
        this.k.b();
    }

    @Override // android.view.View
    public void draw(Canvas canvas) {
        c cVar = this.k;
        if (cVar != null) {
            cVar.c(canvas);
        } else {
            super.draw(canvas);
        }
    }

    public Drawable getCircularRevealOverlayDrawable() {
        return this.k.d();
    }

    @Override // b.d.a.a.m.d
    public int getCircularRevealScrimColor() {
        return this.k.e();
    }

    @Override // b.d.a.a.m.d
    public d.e getRevealInfo() {
        return this.k.f();
    }

    @Override // android.view.View
    public boolean isOpaque() {
        c cVar = this.k;
        return cVar != null ? cVar.g() : super.isOpaque();
    }

    @Override // b.d.a.a.m.d
    public void setCircularRevealOverlayDrawable(Drawable drawable) {
        this.k.h(drawable);
    }

    @Override // b.d.a.a.m.d
    public void setCircularRevealScrimColor(int i) {
        this.k.i(i);
    }

    @Override // b.d.a.a.m.d
    public void setRevealInfo(d.e eVar) {
        this.k.j(eVar);
    }
}
