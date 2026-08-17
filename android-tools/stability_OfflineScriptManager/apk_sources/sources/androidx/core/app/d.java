package androidx.core.app;

import a.f.l.d;
import android.app.Activity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import androidx.lifecycle.e;
import androidx.lifecycle.o;
/* loaded from: classes.dex */
public class d extends Activity implements androidx.lifecycle.g, d.a {

    /* renamed from: b  reason: collision with root package name */
    private androidx.lifecycle.h f836b;

    public d() {
        new a.d.g();
        this.f836b = new androidx.lifecycle.h(this);
    }

    @Override // androidx.lifecycle.g
    public androidx.lifecycle.e a() {
        return this.f836b;
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchKeyEvent(KeyEvent keyEvent) {
        View decorView = getWindow().getDecorView();
        if (decorView == null || !a.f.l.d.d(decorView, keyEvent)) {
            return a.f.l.d.e(this, decorView, this, keyEvent);
        }
        return true;
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean dispatchKeyShortcutEvent(KeyEvent keyEvent) {
        View decorView = getWindow().getDecorView();
        if (decorView == null || !a.f.l.d.d(decorView, keyEvent)) {
            return super.dispatchKeyShortcutEvent(keyEvent);
        }
        return true;
    }

    @Override // a.f.l.d.a
    public boolean g(KeyEvent keyEvent) {
        return super.dispatchKeyEvent(keyEvent);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onCreate(Bundle bundle) {
        super.onCreate(bundle);
        o.e(this);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onSaveInstanceState(Bundle bundle) {
        this.f836b.k(e.b.CREATED);
        super.onSaveInstanceState(bundle);
    }
}
