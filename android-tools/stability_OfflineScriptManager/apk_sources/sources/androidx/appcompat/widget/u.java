package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.ColorStateList;
import android.content.res.Resources;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.widget.TextView;
import androidx.core.content.c.f;
import java.lang.ref.WeakReference;
/* loaded from: classes.dex */
class u {

    /* renamed from: a  reason: collision with root package name */
    private final TextView f778a;

    /* renamed from: b  reason: collision with root package name */
    private o0 f779b;

    /* renamed from: c  reason: collision with root package name */
    private o0 f780c;

    /* renamed from: d  reason: collision with root package name */
    private o0 f781d;
    private o0 e;
    private o0 f;
    private o0 g;
    private final w h;
    private int i = 0;
    private Typeface j;
    private boolean k;

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class a extends f.a {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ WeakReference f782a;

        a(WeakReference weakReference) {
            this.f782a = weakReference;
        }

        @Override // androidx.core.content.c.f.a
        public void c(int i) {
        }

        @Override // androidx.core.content.c.f.a
        public void d(Typeface typeface) {
            u.this.l(this.f782a, typeface);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public u(TextView textView) {
        this.f778a = textView;
        this.h = new w(textView);
    }

    private void a(Drawable drawable, o0 o0Var) {
        if (drawable == null || o0Var == null) {
            return;
        }
        h.C(drawable, o0Var, this.f778a.getDrawableState());
    }

    private static o0 d(Context context, h hVar, int i) {
        ColorStateList s = hVar.s(context, i);
        if (s != null) {
            o0 o0Var = new o0();
            o0Var.f744d = true;
            o0Var.f741a = s;
            return o0Var;
        }
        return null;
    }

    private void t(int i, float f) {
        this.h.t(i, f);
    }

    private void u(Context context, q0 q0Var) {
        String n;
        Typeface typeface;
        this.i = q0Var.j(a.a.j.TextAppearance_android_textStyle, this.i);
        int i = a.a.j.TextAppearance_android_fontFamily;
        if (q0Var.q(i) || q0Var.q(a.a.j.TextAppearance_fontFamily)) {
            this.j = null;
            int i2 = a.a.j.TextAppearance_fontFamily;
            if (q0Var.q(i2)) {
                i = i2;
            }
            if (!context.isRestricted()) {
                try {
                    Typeface i3 = q0Var.i(i, this.i, new a(new WeakReference(this.f778a)));
                    this.j = i3;
                    this.k = i3 == null;
                } catch (Resources.NotFoundException | UnsupportedOperationException unused) {
                }
            }
            if (this.j != null || (n = q0Var.n(i)) == null) {
                return;
            }
            this.j = Typeface.create(n, this.i);
            return;
        }
        int i4 = a.a.j.TextAppearance_android_typeface;
        if (q0Var.q(i4)) {
            this.k = false;
            int j = q0Var.j(i4, 1);
            if (j == 1) {
                typeface = Typeface.SANS_SERIF;
            } else if (j == 2) {
                typeface = Typeface.SERIF;
            } else if (j != 3) {
                return;
            } else {
                typeface = Typeface.MONOSPACE;
            }
            this.j = typeface;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void b() {
        if (this.f779b != null || this.f780c != null || this.f781d != null || this.e != null) {
            Drawable[] compoundDrawables = this.f778a.getCompoundDrawables();
            a(compoundDrawables[0], this.f779b);
            a(compoundDrawables[1], this.f780c);
            a(compoundDrawables[2], this.f781d);
            a(compoundDrawables[3], this.e);
        }
        if (Build.VERSION.SDK_INT >= 17) {
            if (this.f == null && this.g == null) {
                return;
            }
            Drawable[] compoundDrawablesRelative = this.f778a.getCompoundDrawablesRelative();
            a(compoundDrawablesRelative[0], this.f);
            a(compoundDrawablesRelative[2], this.g);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void c() {
        this.h.a();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int e() {
        return this.h.g();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int f() {
        return this.h.h();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int g() {
        return this.h.i();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int[] h() {
        return this.h.j();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public int i() {
        return this.h.k();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public boolean j() {
        return this.h.n();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* JADX WARN: Removed duplicated region for block: B:32:0x00bd  */
    /* JADX WARN: Removed duplicated region for block: B:45:0x00e9  */
    @android.annotation.SuppressLint({"NewApi"})
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    public void k(android.util.AttributeSet r19, int r20) {
        /*
            Method dump skipped, instructions count: 488
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.widget.u.k(android.util.AttributeSet, int):void");
    }

    void l(WeakReference<TextView> weakReference, Typeface typeface) {
        if (this.k) {
            this.j = typeface;
            TextView textView = weakReference.get();
            if (textView != null) {
                textView.setTypeface(typeface, this.i);
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void m(boolean z, int i, int i2, int i3, int i4) {
        if (androidx.core.widget.b.f905a) {
            return;
        }
        c();
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void n(Context context, int i) {
        ColorStateList c2;
        q0 r = q0.r(context, i, a.a.j.TextAppearance);
        int i2 = a.a.j.TextAppearance_textAllCaps;
        if (r.q(i2)) {
            o(r.a(i2, false));
        }
        if (Build.VERSION.SDK_INT < 23) {
            int i3 = a.a.j.TextAppearance_android_textColor;
            if (r.q(i3) && (c2 = r.c(i3)) != null) {
                this.f778a.setTextColor(c2);
            }
        }
        int i4 = a.a.j.TextAppearance_android_textSize;
        if (r.q(i4) && r.e(i4, -1) == 0) {
            this.f778a.setTextSize(0, 0.0f);
        }
        u(context, r);
        r.u();
        Typeface typeface = this.j;
        if (typeface != null) {
            this.f778a.setTypeface(typeface, this.i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void o(boolean z) {
        this.f778a.setAllCaps(z);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void p(int i, int i2, int i3, int i4) {
        this.h.p(i, i2, i3, i4);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void q(int[] iArr, int i) {
        this.h.q(iArr, i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void r(int i) {
        this.h.r(i);
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void s(int i, float f) {
        if (androidx.core.widget.b.f905a || j()) {
            return;
        }
        t(i, f);
    }
}
