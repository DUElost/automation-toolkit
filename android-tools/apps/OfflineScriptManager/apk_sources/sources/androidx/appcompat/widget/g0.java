package androidx.appcompat.widget;

import android.content.Context;
import android.content.res.Configuration;
import android.graphics.drawable.Drawable;
import android.os.Build;
import android.transition.Transition;
import android.util.AttributeSet;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.widget.HeaderViewListAdapter;
import android.widget.ListAdapter;
import android.widget.PopupWindow;
import androidx.appcompat.view.menu.ListMenuItemView;
import java.lang.reflect.Method;
/* loaded from: classes.dex */
public class g0 extends e0 implements f0 {
    private static Method K;
    private f0 J;

    /* loaded from: classes.dex */
    public static class a extends a0 {
        final int p;
        final int q;
        private f0 r;
        private MenuItem s;

        public a(Context context, boolean z) {
            super(context, z);
            Configuration configuration = context.getResources().getConfiguration();
            if (Build.VERSION.SDK_INT < 17 || 1 != configuration.getLayoutDirection()) {
                this.p = 22;
                this.q = 21;
                return;
            }
            this.p = 21;
            this.q = 22;
        }

        @Override // androidx.appcompat.widget.a0, android.view.View
        public boolean onHoverEvent(MotionEvent motionEvent) {
            int i;
            int pointToPosition;
            int i2;
            if (this.r != null) {
                ListAdapter adapter = getAdapter();
                if (adapter instanceof HeaderViewListAdapter) {
                    HeaderViewListAdapter headerViewListAdapter = (HeaderViewListAdapter) adapter;
                    i = headerViewListAdapter.getHeadersCount();
                    adapter = headerViewListAdapter.getWrappedAdapter();
                } else {
                    i = 0;
                }
                androidx.appcompat.view.menu.g gVar = (androidx.appcompat.view.menu.g) adapter;
                androidx.appcompat.view.menu.j jVar = null;
                if (motionEvent.getAction() != 10 && (pointToPosition = pointToPosition((int) motionEvent.getX(), (int) motionEvent.getY())) != -1 && (i2 = pointToPosition - i) >= 0 && i2 < gVar.getCount()) {
                    jVar = gVar.getItem(i2);
                }
                MenuItem menuItem = this.s;
                if (menuItem != jVar) {
                    androidx.appcompat.view.menu.h b2 = gVar.b();
                    if (menuItem != null) {
                        this.r.c(b2, menuItem);
                    }
                    this.s = jVar;
                    if (jVar != null) {
                        this.r.b(b2, jVar);
                    }
                }
            }
            return super.onHoverEvent(motionEvent);
        }

        @Override // android.widget.ListView, android.widget.AbsListView, android.view.View, android.view.KeyEvent.Callback
        public boolean onKeyDown(int i, KeyEvent keyEvent) {
            ListMenuItemView listMenuItemView = (ListMenuItemView) getSelectedView();
            if (listMenuItemView != null && i == this.p) {
                if (listMenuItemView.isEnabled() && listMenuItemView.getItemData().hasSubMenu()) {
                    performItemClick(listMenuItemView, getSelectedItemPosition(), getSelectedItemId());
                }
                return true;
            } else if (listMenuItemView == null || i != this.q) {
                return super.onKeyDown(i, keyEvent);
            } else {
                setSelection(-1);
                ((androidx.appcompat.view.menu.g) getAdapter()).b().e(false);
                return true;
            }
        }

        public void setHoverListener(f0 f0Var) {
            this.r = f0Var;
        }

        @Override // androidx.appcompat.widget.a0, android.widget.AbsListView
        public /* bridge */ /* synthetic */ void setSelector(Drawable drawable) {
            super.setSelector(drawable);
        }
    }

    static {
        try {
            K = PopupWindow.class.getDeclaredMethod("setTouchModal", Boolean.TYPE);
        } catch (NoSuchMethodException unused) {
            Log.i("MenuPopupWindow", "Could not find method setTouchModal() on PopupWindow. Oh well.");
        }
    }

    public g0(Context context, AttributeSet attributeSet, int i, int i2) {
        super(context, attributeSet, i, i2);
    }

    public void J(Object obj) {
        if (Build.VERSION.SDK_INT >= 23) {
            this.F.setEnterTransition((Transition) obj);
        }
    }

    public void K(Object obj) {
        if (Build.VERSION.SDK_INT >= 23) {
            this.F.setExitTransition((Transition) obj);
        }
    }

    public void L(f0 f0Var) {
        this.J = f0Var;
    }

    public void M(boolean z) {
        Method method = K;
        if (method != null) {
            try {
                method.invoke(this.F, Boolean.valueOf(z));
            } catch (Exception unused) {
                Log.i("MenuPopupWindow", "Could not invoke setTouchModal() on PopupWindow. Oh well.");
            }
        }
    }

    @Override // androidx.appcompat.widget.f0
    public void b(androidx.appcompat.view.menu.h hVar, MenuItem menuItem) {
        f0 f0Var = this.J;
        if (f0Var != null) {
            f0Var.b(hVar, menuItem);
        }
    }

    @Override // androidx.appcompat.widget.f0
    public void c(androidx.appcompat.view.menu.h hVar, MenuItem menuItem) {
        f0 f0Var = this.J;
        if (f0Var != null) {
            f0Var.c(hVar, menuItem);
        }
    }

    @Override // androidx.appcompat.widget.e0
    a0 h(Context context, boolean z) {
        a aVar = new a(context, z);
        aVar.setHoverListener(this);
        return aVar;
    }
}
