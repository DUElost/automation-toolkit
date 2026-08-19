package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.graphics.Bitmap;
import android.graphics.PorterDuff;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.util.AttributeSet;
import android.widget.ImageButton;
/* loaded from: classes.dex */
public class k extends ImageButton implements a.f.l.q, androidx.core.widget.k {

    /* renamed from: b  reason: collision with root package name */
    private final d f716b;

    /* renamed from: c  reason: collision with root package name */
    private final l f717c;

    public k(Context context, AttributeSet attributeSet) {
        this(context, attributeSet, a.a.a.imageButtonStyle);
    }

    public k(Context context, AttributeSet attributeSet, int i) {
        super(n0.b(context), attributeSet, i);
        d dVar = new d(this);
        this.f716b = dVar;
        dVar.e(attributeSet, i);
        l lVar = new l(this);
        this.f717c = lVar;
        lVar.f(attributeSet, i);
    }

    @Override // android.widget.ImageView, android.view.View
    protected void drawableStateChanged() {
        super.drawableStateChanged();
        d dVar = this.f716b;
        if (dVar != null) {
            dVar.b();
        }
        l lVar = this.f717c;
        if (lVar != null) {
            lVar.b();
        }
    }

    @Override // a.f.l.q
    public ColorStateList getSupportBackgroundTintList() {
        d dVar = this.f716b;
        if (dVar != null) {
            return dVar.c();
        }
        return null;
    }

    @Override // a.f.l.q
    public PorterDuff.Mode getSupportBackgroundTintMode() {
        d dVar = this.f716b;
        if (dVar != null) {
            return dVar.d();
        }
        return null;
    }

    @Override // androidx.core.widget.k
    public ColorStateList getSupportImageTintList() {
        l lVar = this.f717c;
        if (lVar != null) {
            return lVar.c();
        }
        return null;
    }

    @Override // androidx.core.widget.k
    public PorterDuff.Mode getSupportImageTintMode() {
        l lVar = this.f717c;
        if (lVar != null) {
            return lVar.d();
        }
        return null;
    }

    @Override // android.widget.ImageView, android.view.View
    public boolean hasOverlappingRendering() {
        return this.f717c.e() && super.hasOverlappingRendering();
    }

    @Override // android.view.View
    public void setBackgroundDrawable(Drawable drawable) {
        super.setBackgroundDrawable(drawable);
        d dVar = this.f716b;
        if (dVar != null) {
            dVar.f(drawable);
        }
    }

    @Override // android.view.View
    public void setBackgroundResource(int i) {
        super.setBackgroundResource(i);
        d dVar = this.f716b;
        if (dVar != null) {
            dVar.g(i);
        }
    }

    @Override // android.widget.ImageView
    public void setImageBitmap(Bitmap bitmap) {
        super.setImageBitmap(bitmap);
        l lVar = this.f717c;
        if (lVar != null) {
            lVar.b();
        }
    }

    @Override // android.widget.ImageView
    public void setImageDrawable(Drawable drawable) {
        super.setImageDrawable(drawable);
        l lVar = this.f717c;
        if (lVar != null) {
            lVar.b();
        }
    }

    @Override // android.widget.ImageView
    public void setImageResource(int i) {
        this.f717c.g(i);
    }

    @Override // android.widget.ImageView
    public void setImageURI(Uri uri) {
        super.setImageURI(uri);
        l lVar = this.f717c;
        if (lVar != null) {
            lVar.b();
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintList(ColorStateList colorStateList) {
        d dVar = this.f716b;
        if (dVar != null) {
            dVar.i(colorStateList);
        }
    }

    @Override // a.f.l.q
    public void setSupportBackgroundTintMode(PorterDuff.Mode mode) {
        d dVar = this.f716b;
        if (dVar != null) {
            dVar.j(mode);
        }
    }

    @Override // androidx.core.widget.k
    public void setSupportImageTintList(ColorStateList colorStateList) {
        l lVar = this.f717c;
        if (lVar != null) {
            lVar.h(colorStateList);
        }
    }

    @Override // androidx.core.widget.k
    public void setSupportImageTintMode(PorterDuff.Mode mode) {
        l lVar = this.f717c;
        if (lVar != null) {
            lVar.i(mode);
        }
    }
}
