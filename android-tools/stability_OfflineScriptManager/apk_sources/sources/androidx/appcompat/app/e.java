package androidx.appcompat.app;

import android.app.Activity;
import android.app.Dialog;
import android.content.res.Configuration;
import android.os.Bundle;
import android.view.MenuInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.appcompat.widget.Toolbar;
/* loaded from: classes.dex */
public abstract class e {

    /* renamed from: b  reason: collision with root package name */
    private static int f483b = -1;

    public static e e(Activity activity, d dVar) {
        return new AppCompatDelegateImpl(activity, activity.getWindow(), dVar);
    }

    public static e f(Dialog dialog, d dVar) {
        return new AppCompatDelegateImpl(dialog.getContext(), dialog.getWindow(), dVar);
    }

    public static int h() {
        return f483b;
    }

    public abstract void c(View view, ViewGroup.LayoutParams layoutParams);

    public abstract boolean d();

    public abstract <T extends View> T g(int i);

    public abstract MenuInflater i();

    public abstract a j();

    public abstract void k();

    public abstract void l();

    public abstract void m(Configuration configuration);

    public abstract void n(Bundle bundle);

    public abstract void o();

    public abstract void p(Bundle bundle);

    public abstract void q();

    public abstract void r(Bundle bundle);

    public abstract void s();

    public abstract void t();

    public abstract boolean u(int i);

    public abstract void v(int i);

    public abstract void w(View view);

    public abstract void x(View view, ViewGroup.LayoutParams layoutParams);

    public abstract void y(Toolbar toolbar);

    public abstract void z(CharSequence charSequence);
}
