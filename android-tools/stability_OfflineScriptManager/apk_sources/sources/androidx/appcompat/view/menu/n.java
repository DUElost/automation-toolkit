package androidx.appcompat.view.menu;

import android.content.Context;
import android.graphics.Point;
import android.graphics.Rect;
import android.os.Build;
import android.view.Display;
import android.view.View;
import android.view.WindowManager;
import android.widget.PopupWindow;
import androidx.appcompat.view.menu.o;
/* loaded from: classes.dex */
public class n {

    /* renamed from: a  reason: collision with root package name */
    private final Context f576a;

    /* renamed from: b  reason: collision with root package name */
    private final h f577b;

    /* renamed from: c  reason: collision with root package name */
    private final boolean f578c;

    /* renamed from: d  reason: collision with root package name */
    private final int f579d;
    private final int e;
    private View f;
    private int g;
    private boolean h;
    private o.a i;
    private m j;
    private PopupWindow.OnDismissListener k;
    private final PopupWindow.OnDismissListener l;

    /* loaded from: classes.dex */
    class a implements PopupWindow.OnDismissListener {
        a() {
        }

        @Override // android.widget.PopupWindow.OnDismissListener
        public void onDismiss() {
            n.this.e();
        }
    }

    public n(Context context, h hVar, View view, boolean z, int i) {
        this(context, hVar, view, z, i, 0);
    }

    public n(Context context, h hVar, View view, boolean z, int i, int i2) {
        this.g = 8388611;
        this.l = new a();
        this.f576a = context;
        this.f577b = hVar;
        this.f = view;
        this.f578c = z;
        this.f579d = i;
        this.e = i2;
    }

    private m a() {
        Display defaultDisplay = ((WindowManager) this.f576a.getSystemService("window")).getDefaultDisplay();
        Point point = new Point();
        if (Build.VERSION.SDK_INT >= 17) {
            defaultDisplay.getRealSize(point);
        } else {
            defaultDisplay.getSize(point);
        }
        m eVar = Math.min(point.x, point.y) >= this.f576a.getResources().getDimensionPixelSize(a.a.d.abc_cascading_menus_min_smallest_width) ? new e(this.f576a, this.f, this.f579d, this.e, this.f578c) : new t(this.f576a, this.f577b, this.f, this.f579d, this.e, this.f578c);
        eVar.l(this.f577b);
        eVar.u(this.l);
        eVar.p(this.f);
        eVar.i(this.i);
        eVar.r(this.h);
        eVar.s(this.g);
        return eVar;
    }

    private void l(int i, int i2, boolean z, boolean z2) {
        m c2 = c();
        c2.v(z2);
        if (z) {
            if ((a.f.l.c.b(this.g, a.f.l.r.q(this.f)) & 7) == 5) {
                i -= this.f.getWidth();
            }
            c2.t(i);
            c2.w(i2);
            int i3 = (int) ((this.f576a.getResources().getDisplayMetrics().density * 48.0f) / 2.0f);
            c2.q(new Rect(i - i3, i2 - i3, i + i3, i2 + i3));
        }
        c2.a();
    }

    public void b() {
        if (d()) {
            this.j.dismiss();
        }
    }

    public m c() {
        if (this.j == null) {
            this.j = a();
        }
        return this.j;
    }

    public boolean d() {
        m mVar = this.j;
        return mVar != null && mVar.f();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    public void e() {
        this.j = null;
        PopupWindow.OnDismissListener onDismissListener = this.k;
        if (onDismissListener != null) {
            onDismissListener.onDismiss();
        }
    }

    public void f(View view) {
        this.f = view;
    }

    public void g(boolean z) {
        this.h = z;
        m mVar = this.j;
        if (mVar != null) {
            mVar.r(z);
        }
    }

    public void h(int i) {
        this.g = i;
    }

    public void i(PopupWindow.OnDismissListener onDismissListener) {
        this.k = onDismissListener;
    }

    public void j(o.a aVar) {
        this.i = aVar;
        m mVar = this.j;
        if (mVar != null) {
            mVar.i(aVar);
        }
    }

    public void k() {
        if (!m()) {
            throw new IllegalStateException("MenuPopupHelper cannot be used without an anchor");
        }
    }

    public boolean m() {
        if (d()) {
            return true;
        }
        if (this.f == null) {
            return false;
        }
        l(0, 0, false, false);
        return true;
    }

    public boolean n(int i, int i2) {
        if (d()) {
            return true;
        }
        if (this.f == null) {
            return false;
        }
        l(i, i2, true, true);
        return true;
    }
}
