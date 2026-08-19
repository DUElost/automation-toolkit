package com.afollestad.materialdialogs.internal;

import android.annotation.SuppressLint;
import android.content.Context;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.util.AttributeSet;
import android.widget.TextView;
import b.a.a.e;
import b.a.a.i;
@SuppressLint({"AppCompatCustomView"})
/* loaded from: classes.dex */
public class MDButton extends TextView {

    /* renamed from: b  reason: collision with root package name */
    private boolean f1853b;

    /* renamed from: c  reason: collision with root package name */
    private e f1854c;

    /* renamed from: d  reason: collision with root package name */
    private int f1855d;
    private Drawable e;
    private Drawable f;

    public MDButton(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        this.f1853b = false;
        a(context);
    }

    private void a(Context context) {
        this.f1855d = context.getResources().getDimensionPixelSize(i.md_dialog_frame_margin);
        this.f1854c = e.END;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b(boolean z, boolean z2) {
        if (this.f1853b != z || z2) {
            setGravity(z ? this.f1854c.a() | 16 : 17);
            if (Build.VERSION.SDK_INT >= 17) {
                setTextAlignment(z ? this.f1854c.b() : 4);
            }
            b.a.a.q.a.t(this, z ? this.e : this.f);
            if (z) {
                setPadding(this.f1855d, getPaddingTop(), this.f1855d, getPaddingBottom());
            }
            this.f1853b = z;
        }
    }

    public void setAllCapsCompat(boolean z) {
        if (Build.VERSION.SDK_INT >= 14) {
            setAllCaps(z);
        } else {
            setTransformationMethod(z ? new a(getContext()) : null);
        }
    }

    public void setDefaultSelector(Drawable drawable) {
        this.f = drawable;
        if (this.f1853b) {
            return;
        }
        b(false, true);
    }

    public void setStackedGravity(e eVar) {
        this.f1854c = eVar;
    }

    public void setStackedSelector(Drawable drawable) {
        this.e = drawable;
        if (this.f1853b) {
            b(true, true);
        }
    }
}
