package androidx.appcompat.widget;

import android.content.Context;
import android.graphics.drawable.Drawable;
import android.view.Menu;
import android.view.ViewGroup;
import android.view.Window;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.view.menu.o;
/* loaded from: classes.dex */
public interface y {
    void a(Menu menu, o.a aVar);

    boolean b();

    boolean c();

    void collapseActionView();

    boolean d();

    boolean e();

    void f();

    boolean g();

    CharSequence getTitle();

    void h();

    void i(o.a aVar, h.a aVar2);

    int j();

    void k(int i);

    Menu l();

    void m(int i);

    void n(j0 j0Var);

    ViewGroup o();

    void p(boolean z);

    Context q();

    int r();

    a.f.l.v s(int i, long j);

    void setIcon(int i);

    void setIcon(Drawable drawable);

    void setWindowCallback(Window.Callback callback);

    void setWindowTitle(CharSequence charSequence);

    void t();

    boolean u();

    void v();

    void w(boolean z);

    void x(int i);
}
