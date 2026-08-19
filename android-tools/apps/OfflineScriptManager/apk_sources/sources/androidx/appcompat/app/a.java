package androidx.appcompat.app;

import a.a.m.b;
import android.content.Context;
import android.content.res.Configuration;
import android.content.res.TypedArray;
import android.graphics.drawable.Drawable;
import android.util.AttributeSet;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public abstract class a {

    /* renamed from: androidx.appcompat.app.a$a  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    public static class C0026a extends ViewGroup.MarginLayoutParams {

        /* renamed from: a  reason: collision with root package name */
        public int f479a;

        public C0026a(int i, int i2) {
            super(i, i2);
            this.f479a = 0;
            this.f479a = 8388627;
        }

        public C0026a(Context context, AttributeSet attributeSet) {
            super(context, attributeSet);
            this.f479a = 0;
            TypedArray obtainStyledAttributes = context.obtainStyledAttributes(attributeSet, a.a.j.ActionBarLayout);
            this.f479a = obtainStyledAttributes.getInt(a.a.j.ActionBarLayout_android_layout_gravity, 0);
            obtainStyledAttributes.recycle();
        }

        public C0026a(ViewGroup.LayoutParams layoutParams) {
            super(layoutParams);
            this.f479a = 0;
        }

        public C0026a(C0026a c0026a) {
            super((ViewGroup.MarginLayoutParams) c0026a);
            this.f479a = 0;
            this.f479a = c0026a.f479a;
        }
    }

    /* loaded from: classes.dex */
    public interface b {
        void a(boolean z);
    }

    @Deprecated
    /* loaded from: classes.dex */
    public static abstract class c {
        public abstract CharSequence a();

        public abstract View b();

        public abstract Drawable c();

        public abstract CharSequence d();

        public abstract void e();
    }

    public boolean g() {
        return false;
    }

    public abstract boolean h();

    public abstract void i(boolean z);

    public abstract int j();

    public abstract Context k();

    public boolean l() {
        return false;
    }

    public void m(Configuration configuration) {
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public void n() {
    }

    public abstract boolean o(int i, KeyEvent keyEvent);

    public boolean p(KeyEvent keyEvent) {
        return false;
    }

    public boolean q() {
        return false;
    }

    public abstract void r(boolean z);

    public abstract void s(boolean z);

    public abstract void t(boolean z);

    public abstract void u(boolean z);

    public abstract void v(CharSequence charSequence);

    public a.a.m.b w(b.a aVar) {
        return null;
    }
}
