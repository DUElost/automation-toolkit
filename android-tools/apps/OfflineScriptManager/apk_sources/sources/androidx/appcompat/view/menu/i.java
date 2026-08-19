package androidx.appcompat.view.menu;

import android.content.DialogInterface;
import android.os.IBinder;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import androidx.appcompat.app.b;
import androidx.appcompat.view.menu.o;
/* loaded from: classes.dex */
class i implements DialogInterface.OnKeyListener, DialogInterface.OnClickListener, DialogInterface.OnDismissListener, o.a {

    /* renamed from: b  reason: collision with root package name */
    private h f561b;

    /* renamed from: c  reason: collision with root package name */
    private androidx.appcompat.app.b f562c;

    /* renamed from: d  reason: collision with root package name */
    f f563d;
    private o.a e;

    public i(h hVar) {
        this.f561b = hVar;
    }

    public void a() {
        androidx.appcompat.app.b bVar = this.f562c;
        if (bVar != null) {
            bVar.dismiss();
        }
    }

    @Override // androidx.appcompat.view.menu.o.a
    public void b(h hVar, boolean z) {
        if (z || hVar == this.f561b) {
            a();
        }
        o.a aVar = this.e;
        if (aVar != null) {
            aVar.b(hVar, z);
        }
    }

    @Override // androidx.appcompat.view.menu.o.a
    public boolean c(h hVar) {
        o.a aVar = this.e;
        if (aVar != null) {
            return aVar.c(hVar);
        }
        return false;
    }

    public void d(IBinder iBinder) {
        h hVar = this.f561b;
        b.a aVar = new b.a(hVar.u());
        f fVar = new f(aVar.b(), a.a.g.abc_list_menu_item_layout);
        this.f563d = fVar;
        fVar.i(this);
        this.f561b.b(this.f563d);
        aVar.c(this.f563d.a(), this);
        View y = hVar.y();
        if (y != null) {
            aVar.d(y);
        } else {
            aVar.e(hVar.w());
            aVar.g(hVar.x());
        }
        aVar.f(this);
        androidx.appcompat.app.b a2 = aVar.a();
        this.f562c = a2;
        a2.setOnDismissListener(this);
        WindowManager.LayoutParams attributes = this.f562c.getWindow().getAttributes();
        attributes.type = 1003;
        if (iBinder != null) {
            attributes.token = iBinder;
        }
        attributes.flags |= 131072;
        this.f562c.show();
    }

    @Override // android.content.DialogInterface.OnClickListener
    public void onClick(DialogInterface dialogInterface, int i) {
        this.f561b.L((j) this.f563d.a().getItem(i), 0);
    }

    @Override // android.content.DialogInterface.OnDismissListener
    public void onDismiss(DialogInterface dialogInterface) {
        this.f563d.b(this.f561b, true);
    }

    @Override // android.content.DialogInterface.OnKeyListener
    public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
        Window window;
        View decorView;
        KeyEvent.DispatcherState keyDispatcherState;
        View decorView2;
        KeyEvent.DispatcherState keyDispatcherState2;
        if (i == 82 || i == 4) {
            if (keyEvent.getAction() == 0 && keyEvent.getRepeatCount() == 0) {
                Window window2 = this.f562c.getWindow();
                if (window2 != null && (decorView2 = window2.getDecorView()) != null && (keyDispatcherState2 = decorView2.getKeyDispatcherState()) != null) {
                    keyDispatcherState2.startTracking(keyEvent, this);
                    return true;
                }
            } else if (keyEvent.getAction() == 1 && !keyEvent.isCanceled() && (window = this.f562c.getWindow()) != null && (decorView = window.getDecorView()) != null && (keyDispatcherState = decorView.getKeyDispatcherState()) != null && keyDispatcherState.isTracking(keyEvent)) {
                this.f561b.e(true);
                dialogInterface.dismiss();
                return true;
            }
        }
        return this.f561b.performShortcut(i, keyEvent, 0);
    }
}
