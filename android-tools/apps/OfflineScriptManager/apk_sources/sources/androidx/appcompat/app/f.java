package androidx.appcompat.app;

import a.a.m.b;
import a.f.l.d;
import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import android.util.TypedValue;
import android.view.KeyEvent;
import android.view.View;
import android.view.ViewGroup;
/* loaded from: classes.dex */
public class f extends Dialog implements d {

    /* renamed from: b  reason: collision with root package name */
    private e f484b;

    /* renamed from: c  reason: collision with root package name */
    private final d.a f485c;

    /* loaded from: classes.dex */
    class a implements d.a {
        a() {
        }

        @Override // a.f.l.d.a
        public boolean g(KeyEvent keyEvent) {
            return f.this.c(keyEvent);
        }
    }

    public f(Context context, int i) {
        super(context, b(context, i));
        this.f485c = new a();
        a().n(null);
        a().d();
    }

    private static int b(Context context, int i) {
        if (i == 0) {
            TypedValue typedValue = new TypedValue();
            context.getTheme().resolveAttribute(a.a.a.dialogTheme, typedValue, true);
            return typedValue.resourceId;
        }
        return i;
    }

    public e a() {
        if (this.f484b == null) {
            this.f484b = e.f(this, this);
        }
        return this.f484b;
    }

    @Override // android.app.Dialog
    public void addContentView(View view, ViewGroup.LayoutParams layoutParams) {
        a().c(view, layoutParams);
    }

    boolean c(KeyEvent keyEvent) {
        return super.dispatchKeyEvent(keyEvent);
    }

    public boolean d(int i) {
        return a().u(i);
    }

    @Override // android.app.Dialog, android.view.Window.Callback
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        return a.f.l.d.e(this.f485c, getWindow().getDecorView(), this, keyEvent);
    }

    @Override // android.app.Dialog
    public <T extends View> T findViewById(int i) {
        return (T) a().g(i);
    }

    @Override // androidx.appcompat.app.d
    public void i(a.a.m.b bVar) {
    }

    @Override // android.app.Dialog
    public void invalidateOptionsMenu() {
        a().l();
    }

    @Override // androidx.appcompat.app.d
    public void n(a.a.m.b bVar) {
    }

    @Override // androidx.appcompat.app.d
    public a.a.m.b o(b.a aVar) {
        return null;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Dialog
    public void onCreate(Bundle bundle) {
        a().k();
        super.onCreate(bundle);
        a().n(bundle);
    }

    @Override // android.app.Dialog
    protected void onStop() {
        super.onStop();
        a().t();
    }

    @Override // android.app.Dialog
    public void setContentView(int i) {
        a().v(i);
    }

    @Override // android.app.Dialog
    public void setContentView(View view) {
        a().w(view);
    }

    @Override // android.app.Dialog
    public void setContentView(View view, ViewGroup.LayoutParams layoutParams) {
        a().x(view, layoutParams);
    }

    @Override // android.app.Dialog
    public void setTitle(int i) {
        super.setTitle(i);
        a().z(getContext().getString(i));
    }

    @Override // android.app.Dialog
    public void setTitle(CharSequence charSequence) {
        super.setTitle(charSequence);
        a().z(charSequence);
    }
}
