package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.Resources;
import android.graphics.drawable.Drawable;
import java.lang.ref.WeakReference;
/* loaded from: classes.dex */
class p0 extends h0 {

    /* renamed from: b  reason: collision with root package name */
    private final WeakReference<Context> f748b;

    public p0(Context context, Resources resources) {
        super(resources);
        this.f748b = new WeakReference<>(context);
    }

    @Override // androidx.appcompat.widget.h0, android.content.res.Resources
    public Drawable getDrawable(int i) {
        Drawable drawable = super.getDrawable(i);
        Context context = this.f748b.get();
        if (drawable != null && context != null) {
            h.n();
            h.D(context, i, drawable);
        }
        return drawable;
    }
}
