package androidx.appcompat.widget;

import android.content.Context;
import android.os.Build;
import android.util.AttributeSet;
import android.view.View;
import android.widget.PopupWindow;
/* loaded from: classes.dex */
class o extends PopupWindow {

    /* renamed from: b  reason: collision with root package name */
    private static final boolean f739b;

    /* renamed from: a  reason: collision with root package name */
    private boolean f740a;

    static {
        f739b = Build.VERSION.SDK_INT < 21;
    }

    public o(Context context, AttributeSet attributeSet, int i, int i2) {
        super(context, attributeSet, i, i2);
        a(context, attributeSet, i, i2);
    }

    private void a(Context context, AttributeSet attributeSet, int i, int i2) {
        q0 t = q0.t(context, attributeSet, a.a.j.PopupWindow, i, i2);
        int i3 = a.a.j.PopupWindow_overlapAnchor;
        if (t.q(i3)) {
            b(t.a(i3, false));
        }
        setBackgroundDrawable(t.f(a.a.j.PopupWindow_android_popupBackground));
        t.u();
    }

    private void b(boolean z) {
        if (f739b) {
            this.f740a = z;
        } else {
            androidx.core.widget.h.a(this, z);
        }
    }

    @Override // android.widget.PopupWindow
    public void showAsDropDown(View view, int i, int i2) {
        if (f739b && this.f740a) {
            i2 -= view.getHeight();
        }
        super.showAsDropDown(view, i, i2);
    }

    @Override // android.widget.PopupWindow
    public void showAsDropDown(View view, int i, int i2, int i3) {
        if (f739b && this.f740a) {
            i2 -= view.getHeight();
        }
        super.showAsDropDown(view, i, i2, i3);
    }

    @Override // android.widget.PopupWindow
    public void update(View view, int i, int i2, int i3, int i4) {
        if (f739b && this.f740a) {
            i2 -= view.getHeight();
        }
        super.update(view, i, i2, i3, i4);
    }
}
