package androidx.appcompat.app;

import a.a.m.b;
import a.a.m.f;
import a.f.l.d;
import a.f.l.r;
import a.f.l.v;
import a.f.l.z;
import android.app.Activity;
import android.app.UiModeManager;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.pm.PackageManager;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.content.res.TypedArray;
import android.graphics.Rect;
import android.graphics.drawable.Drawable;
import android.media.AudioManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Parcel;
import android.os.Parcelable;
import android.text.TextUtils;
import android.util.AndroidRuntimeException;
import android.util.AttributeSet;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.TypedValue;
import android.view.ActionMode;
import android.view.KeyCharacterMap;
import android.view.KeyEvent;
import android.view.KeyboardShortcutGroup;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewConfiguration;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.Window;
import android.view.WindowManager;
import android.widget.FrameLayout;
import android.widget.PopupWindow;
import android.widget.TextView;
import androidx.appcompat.view.menu.h;
import androidx.appcompat.view.menu.o;
import androidx.appcompat.view.menu.p;
import androidx.appcompat.widget.ActionBarContextView;
import androidx.appcompat.widget.ContentFrameLayout;
import androidx.appcompat.widget.Toolbar;
import androidx.appcompat.widget.b0;
import androidx.appcompat.widget.q0;
import androidx.appcompat.widget.v0;
import androidx.appcompat.widget.w0;
import androidx.appcompat.widget.x;
import java.lang.Thread;
import java.util.List;
import org.xmlpull.v1.XmlPullParser;
/* JADX INFO: Access modifiers changed from: package-private */
/* loaded from: classes.dex */
public class AppCompatDelegateImpl extends androidx.appcompat.app.e implements h.a, LayoutInflater.Factory2 {
    private static final boolean T;
    private static final int[] U;
    private static boolean V;
    boolean A;
    boolean B;
    boolean C;
    boolean D;
    private boolean E;
    private PanelFeatureState[] F;
    private PanelFeatureState G;
    private boolean H;
    boolean I;
    private boolean K;
    private k L;
    boolean M;
    int N;
    private boolean P;
    private Rect Q;
    private Rect R;
    private AppCompatViewInflater S;

    /* renamed from: c  reason: collision with root package name */
    final Context f448c;

    /* renamed from: d  reason: collision with root package name */
    final Window f449d;
    final Window.Callback e;
    final Window.Callback f;
    final androidx.appcompat.app.d g;
    androidx.appcompat.app.a h;
    MenuInflater i;
    private CharSequence j;
    private x k;
    private h l;
    private m m;
    a.a.m.b n;
    ActionBarContextView o;
    PopupWindow p;
    Runnable q;
    private boolean t;
    private ViewGroup u;
    private TextView v;
    private View w;
    private boolean x;
    private boolean y;
    boolean z;
    v r = null;
    private boolean s = true;
    private int J = -100;
    private final Runnable O = new b();

    /* JADX INFO: Access modifiers changed from: protected */
    /* loaded from: classes.dex */
    public static final class PanelFeatureState {

        /* renamed from: a  reason: collision with root package name */
        int f450a;

        /* renamed from: b  reason: collision with root package name */
        int f451b;

        /* renamed from: c  reason: collision with root package name */
        int f452c;

        /* renamed from: d  reason: collision with root package name */
        int f453d;
        int e;
        int f;
        ViewGroup g;
        View h;
        View i;
        androidx.appcompat.view.menu.h j;
        androidx.appcompat.view.menu.f k;
        Context l;
        boolean m;
        boolean n;
        boolean o;
        public boolean p;
        boolean q = false;
        boolean r;
        Bundle s;

        /* JADX INFO: Access modifiers changed from: private */
        /* loaded from: classes.dex */
        public static class SavedState implements Parcelable {
            public static final Parcelable.Creator<SavedState> CREATOR = new a();

            /* renamed from: b  reason: collision with root package name */
            int f454b;

            /* renamed from: c  reason: collision with root package name */
            boolean f455c;

            /* renamed from: d  reason: collision with root package name */
            Bundle f456d;

            /* loaded from: classes.dex */
            static class a implements Parcelable.ClassLoaderCreator<SavedState> {
                a() {
                }

                @Override // android.os.Parcelable.Creator
                /* renamed from: a */
                public SavedState createFromParcel(Parcel parcel) {
                    return SavedState.a(parcel, null);
                }

                @Override // android.os.Parcelable.ClassLoaderCreator
                /* renamed from: b */
                public SavedState createFromParcel(Parcel parcel, ClassLoader classLoader) {
                    return SavedState.a(parcel, classLoader);
                }

                @Override // android.os.Parcelable.Creator
                /* renamed from: c */
                public SavedState[] newArray(int i) {
                    return new SavedState[i];
                }
            }

            SavedState() {
            }

            static SavedState a(Parcel parcel, ClassLoader classLoader) {
                SavedState savedState = new SavedState();
                savedState.f454b = parcel.readInt();
                boolean z = parcel.readInt() == 1;
                savedState.f455c = z;
                if (z) {
                    savedState.f456d = parcel.readBundle(classLoader);
                }
                return savedState;
            }

            @Override // android.os.Parcelable
            public int describeContents() {
                return 0;
            }

            @Override // android.os.Parcelable
            public void writeToParcel(Parcel parcel, int i) {
                parcel.writeInt(this.f454b);
                parcel.writeInt(this.f455c ? 1 : 0);
                if (this.f455c) {
                    parcel.writeBundle(this.f456d);
                }
            }
        }

        PanelFeatureState(int i) {
            this.f450a = i;
        }

        p a(o.a aVar) {
            if (this.j == null) {
                return null;
            }
            if (this.k == null) {
                androidx.appcompat.view.menu.f fVar = new androidx.appcompat.view.menu.f(this.l, a.a.g.abc_list_menu_item_layout);
                this.k = fVar;
                fVar.i(aVar);
                this.j.b(this.k);
            }
            return this.k.f(this.g);
        }

        public boolean b() {
            if (this.h == null) {
                return false;
            }
            return this.i != null || this.k.a().getCount() > 0;
        }

        void c(androidx.appcompat.view.menu.h hVar) {
            androidx.appcompat.view.menu.f fVar;
            androidx.appcompat.view.menu.h hVar2 = this.j;
            if (hVar == hVar2) {
                return;
            }
            if (hVar2 != null) {
                hVar2.O(this.k);
            }
            this.j = hVar;
            if (hVar == null || (fVar = this.k) == null) {
                return;
            }
            hVar.b(fVar);
        }

        void d(Context context) {
            TypedValue typedValue = new TypedValue();
            Resources.Theme newTheme = context.getResources().newTheme();
            newTheme.setTo(context.getTheme());
            newTheme.resolveAttribute(a.a.a.actionBarPopupTheme, typedValue, true);
            int i = typedValue.resourceId;
            if (i != 0) {
                newTheme.applyStyle(i, true);
            }
            newTheme.resolveAttribute(a.a.a.panelMenuListTheme, typedValue, true);
            int i2 = typedValue.resourceId;
            if (i2 == 0) {
                i2 = a.a.i.Theme_AppCompat_CompactMenu;
            }
            newTheme.applyStyle(i2, true);
            a.a.m.d dVar = new a.a.m.d(context, 0);
            dVar.getTheme().setTo(newTheme);
            this.l = dVar;
            TypedArray obtainStyledAttributes = dVar.obtainStyledAttributes(a.a.j.AppCompatTheme);
            this.f451b = obtainStyledAttributes.getResourceId(a.a.j.AppCompatTheme_panelBackground, 0);
            this.f = obtainStyledAttributes.getResourceId(a.a.j.AppCompatTheme_android_windowAnimationStyle, 0);
            obtainStyledAttributes.recycle();
        }
    }

    /* loaded from: classes.dex */
    static class a implements Thread.UncaughtExceptionHandler {

        /* renamed from: a  reason: collision with root package name */
        final /* synthetic */ Thread.UncaughtExceptionHandler f457a;

        a(Thread.UncaughtExceptionHandler uncaughtExceptionHandler) {
            this.f457a = uncaughtExceptionHandler;
        }

        private boolean a(Throwable th) {
            String message;
            if (!(th instanceof Resources.NotFoundException) || (message = th.getMessage()) == null) {
                return false;
            }
            return message.contains("drawable") || message.contains("Drawable");
        }

        @Override // java.lang.Thread.UncaughtExceptionHandler
        public void uncaughtException(Thread thread, Throwable th) {
            if (!a(th)) {
                this.f457a.uncaughtException(thread, th);
                return;
            }
            Resources.NotFoundException notFoundException = new Resources.NotFoundException(th.getMessage() + ". If the resource you are trying to use is a vector resource, you may be referencing it in an unsupported way. See AppCompatDelegate.setCompatVectorFromResourcesEnabled() for more info.");
            notFoundException.initCause(th.getCause());
            notFoundException.setStackTrace(th.getStackTrace());
            this.f457a.uncaughtException(thread, notFoundException);
        }
    }

    /* loaded from: classes.dex */
    class b implements Runnable {
        b() {
        }

        @Override // java.lang.Runnable
        public void run() {
            AppCompatDelegateImpl appCompatDelegateImpl = AppCompatDelegateImpl.this;
            if ((appCompatDelegateImpl.N & 1) != 0) {
                appCompatDelegateImpl.J(0);
            }
            AppCompatDelegateImpl appCompatDelegateImpl2 = AppCompatDelegateImpl.this;
            if ((appCompatDelegateImpl2.N & 4096) != 0) {
                appCompatDelegateImpl2.J(108);
            }
            AppCompatDelegateImpl appCompatDelegateImpl3 = AppCompatDelegateImpl.this;
            appCompatDelegateImpl3.M = false;
            appCompatDelegateImpl3.N = 0;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class c implements a.f.l.o {
        c() {
        }

        @Override // a.f.l.o
        public z a(View view, z zVar) {
            int d2 = zVar.d();
            int w0 = AppCompatDelegateImpl.this.w0(d2);
            if (d2 != w0) {
                zVar = zVar.f(zVar.b(), w0, zVar.c(), zVar.a());
            }
            return r.J(view, zVar);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class d implements b0.a {
        d() {
        }

        @Override // androidx.appcompat.widget.b0.a
        public void a(Rect rect) {
            rect.top = AppCompatDelegateImpl.this.w0(rect.top);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class e implements ContentFrameLayout.a {
        e() {
        }

        @Override // androidx.appcompat.widget.ContentFrameLayout.a
        public void a() {
        }

        @Override // androidx.appcompat.widget.ContentFrameLayout.a
        public void onDetachedFromWindow() {
            AppCompatDelegateImpl.this.H();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class f implements Runnable {

        /* loaded from: classes.dex */
        class a extends a.f.l.x {
            a() {
            }

            @Override // a.f.l.w
            public void a(View view) {
                AppCompatDelegateImpl.this.o.setAlpha(1.0f);
                AppCompatDelegateImpl.this.r.f(null);
                AppCompatDelegateImpl.this.r = null;
            }

            @Override // a.f.l.x, a.f.l.w
            public void b(View view) {
                AppCompatDelegateImpl.this.o.setVisibility(0);
            }
        }

        f() {
        }

        @Override // java.lang.Runnable
        public void run() {
            AppCompatDelegateImpl appCompatDelegateImpl = AppCompatDelegateImpl.this;
            appCompatDelegateImpl.p.showAtLocation(appCompatDelegateImpl.o, 55, 0, 0);
            AppCompatDelegateImpl.this.K();
            if (!AppCompatDelegateImpl.this.p0()) {
                AppCompatDelegateImpl.this.o.setAlpha(1.0f);
                AppCompatDelegateImpl.this.o.setVisibility(0);
                return;
            }
            AppCompatDelegateImpl.this.o.setAlpha(0.0f);
            AppCompatDelegateImpl appCompatDelegateImpl2 = AppCompatDelegateImpl.this;
            v a2 = r.a(appCompatDelegateImpl2.o);
            a2.a(1.0f);
            appCompatDelegateImpl2.r = a2;
            AppCompatDelegateImpl.this.r.f(new a());
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class g extends a.f.l.x {
        g() {
        }

        @Override // a.f.l.w
        public void a(View view) {
            AppCompatDelegateImpl.this.o.setAlpha(1.0f);
            AppCompatDelegateImpl.this.r.f(null);
            AppCompatDelegateImpl.this.r = null;
        }

        @Override // a.f.l.x, a.f.l.w
        public void b(View view) {
            AppCompatDelegateImpl.this.o.setVisibility(0);
            AppCompatDelegateImpl.this.o.sendAccessibilityEvent(32);
            if (AppCompatDelegateImpl.this.o.getParent() instanceof View) {
                r.N((View) AppCompatDelegateImpl.this.o.getParent());
            }
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public final class h implements o.a {
        h() {
        }

        @Override // androidx.appcompat.view.menu.o.a
        public void b(androidx.appcompat.view.menu.h hVar, boolean z) {
            AppCompatDelegateImpl.this.C(hVar);
        }

        @Override // androidx.appcompat.view.menu.o.a
        public boolean c(androidx.appcompat.view.menu.h hVar) {
            Window.Callback S = AppCompatDelegateImpl.this.S();
            if (S != null) {
                S.onMenuOpened(108, hVar);
                return true;
            }
            return true;
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public class i implements b.a {

        /* renamed from: a  reason: collision with root package name */
        private b.a f466a;

        /* loaded from: classes.dex */
        class a extends a.f.l.x {
            a() {
            }

            @Override // a.f.l.w
            public void a(View view) {
                AppCompatDelegateImpl.this.o.setVisibility(8);
                AppCompatDelegateImpl appCompatDelegateImpl = AppCompatDelegateImpl.this;
                PopupWindow popupWindow = appCompatDelegateImpl.p;
                if (popupWindow != null) {
                    popupWindow.dismiss();
                } else if (appCompatDelegateImpl.o.getParent() instanceof View) {
                    r.N((View) AppCompatDelegateImpl.this.o.getParent());
                }
                AppCompatDelegateImpl.this.o.removeAllViews();
                AppCompatDelegateImpl.this.r.f(null);
                AppCompatDelegateImpl.this.r = null;
            }
        }

        public i(b.a aVar) {
            this.f466a = aVar;
        }

        @Override // a.a.m.b.a
        public boolean a(a.a.m.b bVar, Menu menu) {
            return this.f466a.a(bVar, menu);
        }

        @Override // a.a.m.b.a
        public boolean b(a.a.m.b bVar, MenuItem menuItem) {
            return this.f466a.b(bVar, menuItem);
        }

        @Override // a.a.m.b.a
        public boolean c(a.a.m.b bVar, Menu menu) {
            return this.f466a.c(bVar, menu);
        }

        @Override // a.a.m.b.a
        public void d(a.a.m.b bVar) {
            this.f466a.d(bVar);
            AppCompatDelegateImpl appCompatDelegateImpl = AppCompatDelegateImpl.this;
            if (appCompatDelegateImpl.p != null) {
                appCompatDelegateImpl.f449d.getDecorView().removeCallbacks(AppCompatDelegateImpl.this.q);
            }
            AppCompatDelegateImpl appCompatDelegateImpl2 = AppCompatDelegateImpl.this;
            if (appCompatDelegateImpl2.o != null) {
                appCompatDelegateImpl2.K();
                AppCompatDelegateImpl appCompatDelegateImpl3 = AppCompatDelegateImpl.this;
                v a2 = r.a(appCompatDelegateImpl3.o);
                a2.a(0.0f);
                appCompatDelegateImpl3.r = a2;
                AppCompatDelegateImpl.this.r.f(new a());
            }
            AppCompatDelegateImpl appCompatDelegateImpl4 = AppCompatDelegateImpl.this;
            androidx.appcompat.app.d dVar = appCompatDelegateImpl4.g;
            if (dVar != null) {
                dVar.n(appCompatDelegateImpl4.n);
            }
            AppCompatDelegateImpl.this.n = null;
        }
    }

    /* loaded from: classes.dex */
    class j extends a.a.m.i {
        j(Window.Callback callback) {
            super(callback);
        }

        final ActionMode a(ActionMode.Callback callback) {
            f.a aVar = new f.a(AppCompatDelegateImpl.this.f448c, callback);
            a.a.m.b s0 = AppCompatDelegateImpl.this.s0(aVar);
            if (s0 != null) {
                return aVar.e(s0);
            }
            return null;
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public boolean dispatchKeyEvent(KeyEvent keyEvent) {
            return AppCompatDelegateImpl.this.I(keyEvent) || super.dispatchKeyEvent(keyEvent);
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public boolean dispatchKeyShortcutEvent(KeyEvent keyEvent) {
            return super.dispatchKeyShortcutEvent(keyEvent) || AppCompatDelegateImpl.this.d0(keyEvent.getKeyCode(), keyEvent);
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public void onContentChanged() {
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public boolean onCreatePanelMenu(int i, Menu menu) {
            if (i != 0 || (menu instanceof androidx.appcompat.view.menu.h)) {
                return super.onCreatePanelMenu(i, menu);
            }
            return false;
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public boolean onMenuOpened(int i, Menu menu) {
            super.onMenuOpened(i, menu);
            AppCompatDelegateImpl.this.g0(i);
            return true;
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public void onPanelClosed(int i, Menu menu) {
            super.onPanelClosed(i, menu);
            AppCompatDelegateImpl.this.h0(i);
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public boolean onPreparePanel(int i, View view, Menu menu) {
            androidx.appcompat.view.menu.h hVar = menu instanceof androidx.appcompat.view.menu.h ? (androidx.appcompat.view.menu.h) menu : null;
            if (i == 0 && hVar == null) {
                return false;
            }
            if (hVar != null) {
                hVar.a0(true);
            }
            boolean onPreparePanel = super.onPreparePanel(i, view, menu);
            if (hVar != null) {
                hVar.a0(false);
            }
            return onPreparePanel;
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public void onProvideKeyboardShortcuts(List<KeyboardShortcutGroup> list, Menu menu, int i) {
            androidx.appcompat.view.menu.h hVar;
            PanelFeatureState Q = AppCompatDelegateImpl.this.Q(0, true);
            if (Q == null || (hVar = Q.j) == null) {
                super.onProvideKeyboardShortcuts(list, menu, i);
            } else {
                super.onProvideKeyboardShortcuts(list, hVar, i);
            }
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public ActionMode onWindowStartingActionMode(ActionMode.Callback callback) {
            if (Build.VERSION.SDK_INT >= 23) {
                return null;
            }
            return AppCompatDelegateImpl.this.Y() ? a(callback) : super.onWindowStartingActionMode(callback);
        }

        @Override // a.a.m.i, android.view.Window.Callback
        public ActionMode onWindowStartingActionMode(ActionMode.Callback callback, int i) {
            return (AppCompatDelegateImpl.this.Y() && i == 0) ? a(callback) : super.onWindowStartingActionMode(callback, i);
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public final class k {

        /* renamed from: a  reason: collision with root package name */
        private androidx.appcompat.app.j f470a;

        /* renamed from: b  reason: collision with root package name */
        private boolean f471b;

        /* renamed from: c  reason: collision with root package name */
        private BroadcastReceiver f472c;

        /* renamed from: d  reason: collision with root package name */
        private IntentFilter f473d;

        /* JADX INFO: Access modifiers changed from: package-private */
        /* loaded from: classes.dex */
        public class a extends BroadcastReceiver {
            a() {
            }

            @Override // android.content.BroadcastReceiver
            public void onReceive(Context context, Intent intent) {
                k.this.b();
            }
        }

        k(androidx.appcompat.app.j jVar) {
            this.f470a = jVar;
            this.f471b = jVar.d();
        }

        void a() {
            BroadcastReceiver broadcastReceiver = this.f472c;
            if (broadcastReceiver != null) {
                AppCompatDelegateImpl.this.f448c.unregisterReceiver(broadcastReceiver);
                this.f472c = null;
            }
        }

        void b() {
            boolean d2 = this.f470a.d();
            if (d2 != this.f471b) {
                this.f471b = d2;
                AppCompatDelegateImpl.this.d();
            }
        }

        int c() {
            boolean d2 = this.f470a.d();
            this.f471b = d2;
            return d2 ? 2 : 1;
        }

        void d() {
            a();
            if (this.f472c == null) {
                this.f472c = new a();
            }
            if (this.f473d == null) {
                IntentFilter intentFilter = new IntentFilter();
                this.f473d = intentFilter;
                intentFilter.addAction("android.intent.action.TIME_SET");
                this.f473d.addAction("android.intent.action.TIMEZONE_CHANGED");
                this.f473d.addAction("android.intent.action.TIME_TICK");
            }
            AppCompatDelegateImpl.this.f448c.registerReceiver(this.f472c, this.f473d);
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public class l extends ContentFrameLayout {
        public l(Context context) {
            super(context);
        }

        private boolean c(int i, int i2) {
            return i < -5 || i2 < -5 || i > getWidth() + 5 || i2 > getHeight() + 5;
        }

        @Override // android.view.ViewGroup, android.view.View
        public boolean dispatchKeyEvent(KeyEvent keyEvent) {
            return AppCompatDelegateImpl.this.I(keyEvent) || super.dispatchKeyEvent(keyEvent);
        }

        @Override // android.view.ViewGroup
        public boolean onInterceptTouchEvent(MotionEvent motionEvent) {
            if (motionEvent.getAction() == 0 && c((int) motionEvent.getX(), (int) motionEvent.getY())) {
                AppCompatDelegateImpl.this.D(0);
                return true;
            }
            return super.onInterceptTouchEvent(motionEvent);
        }

        @Override // android.view.View
        public void setBackgroundResource(int i) {
            setBackgroundDrawable(a.a.k.a.a.d(getContext(), i));
        }
    }

    /* JADX INFO: Access modifiers changed from: private */
    /* loaded from: classes.dex */
    public final class m implements o.a {
        m() {
        }

        @Override // androidx.appcompat.view.menu.o.a
        public void b(androidx.appcompat.view.menu.h hVar, boolean z) {
            androidx.appcompat.view.menu.h D = hVar.D();
            boolean z2 = D != hVar;
            AppCompatDelegateImpl appCompatDelegateImpl = AppCompatDelegateImpl.this;
            if (z2) {
                hVar = D;
            }
            PanelFeatureState N = appCompatDelegateImpl.N(hVar);
            if (N != null) {
                if (!z2) {
                    AppCompatDelegateImpl.this.E(N, z);
                    return;
                }
                AppCompatDelegateImpl.this.B(N.f450a, N, D);
                AppCompatDelegateImpl.this.E(N, true);
            }
        }

        @Override // androidx.appcompat.view.menu.o.a
        public boolean c(androidx.appcompat.view.menu.h hVar) {
            Window.Callback S;
            if (hVar == null) {
                AppCompatDelegateImpl appCompatDelegateImpl = AppCompatDelegateImpl.this;
                if (!appCompatDelegateImpl.z || (S = appCompatDelegateImpl.S()) == null || AppCompatDelegateImpl.this.I) {
                    return true;
                }
                S.onMenuOpened(108, hVar);
                return true;
            }
            return true;
        }
    }

    static {
        boolean z = Build.VERSION.SDK_INT < 21;
        T = z;
        U = new int[]{16842836};
        if (!z || V) {
            return;
        }
        Thread.setDefaultUncaughtExceptionHandler(new a(Thread.getDefaultUncaughtExceptionHandler()));
        V = true;
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    public AppCompatDelegateImpl(Context context, Window window, androidx.appcompat.app.d dVar) {
        this.f448c = context;
        this.f449d = window;
        this.g = dVar;
        Window.Callback callback = window.getCallback();
        this.e = callback;
        if (callback instanceof j) {
            throw new IllegalStateException("AppCompat has already installed itself into the Window");
        }
        j jVar = new j(callback);
        this.f = jVar;
        window.setCallback(jVar);
        q0 s = q0.s(context, null, U);
        Drawable g2 = s.g(0);
        if (g2 != null) {
            window.setBackgroundDrawable(g2);
        }
        s.u();
    }

    private void A() {
        ContentFrameLayout contentFrameLayout = (ContentFrameLayout) this.u.findViewById(16908290);
        View decorView = this.f449d.getDecorView();
        contentFrameLayout.b(decorView.getPaddingLeft(), decorView.getPaddingTop(), decorView.getPaddingRight(), decorView.getPaddingBottom());
        TypedArray obtainStyledAttributes = this.f448c.obtainStyledAttributes(a.a.j.AppCompatTheme);
        obtainStyledAttributes.getValue(a.a.j.AppCompatTheme_windowMinWidthMajor, contentFrameLayout.getMinWidthMajor());
        obtainStyledAttributes.getValue(a.a.j.AppCompatTheme_windowMinWidthMinor, contentFrameLayout.getMinWidthMinor());
        int i2 = a.a.j.AppCompatTheme_windowFixedWidthMajor;
        if (obtainStyledAttributes.hasValue(i2)) {
            obtainStyledAttributes.getValue(i2, contentFrameLayout.getFixedWidthMajor());
        }
        int i3 = a.a.j.AppCompatTheme_windowFixedWidthMinor;
        if (obtainStyledAttributes.hasValue(i3)) {
            obtainStyledAttributes.getValue(i3, contentFrameLayout.getFixedWidthMinor());
        }
        int i4 = a.a.j.AppCompatTheme_windowFixedHeightMajor;
        if (obtainStyledAttributes.hasValue(i4)) {
            obtainStyledAttributes.getValue(i4, contentFrameLayout.getFixedHeightMajor());
        }
        int i5 = a.a.j.AppCompatTheme_windowFixedHeightMinor;
        if (obtainStyledAttributes.hasValue(i5)) {
            obtainStyledAttributes.getValue(i5, contentFrameLayout.getFixedHeightMinor());
        }
        obtainStyledAttributes.recycle();
        contentFrameLayout.requestLayout();
    }

    private ViewGroup F() {
        ViewGroup viewGroup;
        TypedArray obtainStyledAttributes = this.f448c.obtainStyledAttributes(a.a.j.AppCompatTheme);
        int i2 = a.a.j.AppCompatTheme_windowActionBar;
        if (!obtainStyledAttributes.hasValue(i2)) {
            obtainStyledAttributes.recycle();
            throw new IllegalStateException("You need to use a Theme.AppCompat theme (or descendant) with this activity.");
        }
        if (obtainStyledAttributes.getBoolean(a.a.j.AppCompatTheme_windowNoTitle, false)) {
            u(1);
        } else if (obtainStyledAttributes.getBoolean(i2, false)) {
            u(108);
        }
        if (obtainStyledAttributes.getBoolean(a.a.j.AppCompatTheme_windowActionBarOverlay, false)) {
            u(109);
        }
        if (obtainStyledAttributes.getBoolean(a.a.j.AppCompatTheme_windowActionModeOverlay, false)) {
            u(10);
        }
        this.C = obtainStyledAttributes.getBoolean(a.a.j.AppCompatTheme_android_windowIsFloating, false);
        obtainStyledAttributes.recycle();
        this.f449d.getDecorView();
        LayoutInflater from = LayoutInflater.from(this.f448c);
        if (this.D) {
            viewGroup = (ViewGroup) from.inflate(this.B ? a.a.g.abc_screen_simple_overlay_action_mode : a.a.g.abc_screen_simple, (ViewGroup) null);
            if (Build.VERSION.SDK_INT >= 21) {
                r.b0(viewGroup, new c());
            } else {
                ((b0) viewGroup).setOnFitSystemWindowsListener(new d());
            }
        } else if (this.C) {
            viewGroup = (ViewGroup) from.inflate(a.a.g.abc_dialog_title_material, (ViewGroup) null);
            this.A = false;
            this.z = false;
        } else if (this.z) {
            TypedValue typedValue = new TypedValue();
            this.f448c.getTheme().resolveAttribute(a.a.a.actionBarTheme, typedValue, true);
            viewGroup = (ViewGroup) LayoutInflater.from(typedValue.resourceId != 0 ? new a.a.m.d(this.f448c, typedValue.resourceId) : this.f448c).inflate(a.a.g.abc_screen_toolbar, (ViewGroup) null);
            x xVar = (x) viewGroup.findViewById(a.a.f.decor_content_parent);
            this.k = xVar;
            xVar.setWindowCallback(S());
            if (this.A) {
                this.k.k(109);
            }
            if (this.x) {
                this.k.k(2);
            }
            if (this.y) {
                this.k.k(5);
            }
        } else {
            viewGroup = null;
        }
        if (viewGroup == null) {
            throw new IllegalArgumentException("AppCompat does not support the current theme features: { windowActionBar: " + this.z + ", windowActionBarOverlay: " + this.A + ", android:windowIsFloating: " + this.C + ", windowActionModeOverlay: " + this.B + ", windowNoTitle: " + this.D + " }");
        }
        if (this.k == null) {
            this.v = (TextView) viewGroup.findViewById(a.a.f.title);
        }
        w0.c(viewGroup);
        ContentFrameLayout contentFrameLayout = (ContentFrameLayout) viewGroup.findViewById(a.a.f.action_bar_activity_content);
        ViewGroup viewGroup2 = (ViewGroup) this.f449d.findViewById(16908290);
        if (viewGroup2 != null) {
            while (viewGroup2.getChildCount() > 0) {
                View childAt = viewGroup2.getChildAt(0);
                viewGroup2.removeViewAt(0);
                contentFrameLayout.addView(childAt);
            }
            viewGroup2.setId(-1);
            contentFrameLayout.setId(16908290);
            if (viewGroup2 instanceof FrameLayout) {
                ((FrameLayout) viewGroup2).setForeground(null);
            }
        }
        this.f449d.setContentView(viewGroup);
        contentFrameLayout.setAttachListener(new e());
        return viewGroup;
    }

    private void L() {
        if (this.L == null) {
            this.L = new k(androidx.appcompat.app.j.a(this.f448c));
        }
    }

    private void M() {
        if (this.t) {
            return;
        }
        this.u = F();
        CharSequence R = R();
        if (!TextUtils.isEmpty(R)) {
            x xVar = this.k;
            if (xVar != null) {
                xVar.setWindowTitle(R);
            } else if (k0() != null) {
                k0().v(R);
            } else {
                TextView textView = this.v;
                if (textView != null) {
                    textView.setText(R);
                }
            }
        }
        A();
        i0(this.u);
        this.t = true;
        PanelFeatureState Q = Q(0, false);
        if (this.I) {
            return;
        }
        if (Q == null || Q.j == null) {
            X(108);
        }
    }

    private int P() {
        int i2 = this.J;
        return i2 != -100 ? i2 : androidx.appcompat.app.e.h();
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x0032  */
    /* JADX WARN: Removed duplicated region for block: B:19:? A[RETURN, SYNTHETIC] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private void T() {
        /*
            r3 = this;
            r3.M()
            boolean r0 = r3.z
            if (r0 == 0) goto L37
            androidx.appcompat.app.a r0 = r3.h
            if (r0 == 0) goto Lc
            goto L37
        Lc:
            android.view.Window$Callback r0 = r3.e
            boolean r1 = r0 instanceof android.app.Activity
            if (r1 == 0) goto L20
            androidx.appcompat.app.k r0 = new androidx.appcompat.app.k
            android.view.Window$Callback r1 = r3.e
            android.app.Activity r1 = (android.app.Activity) r1
            boolean r2 = r3.A
            r0.<init>(r1, r2)
        L1d:
            r3.h = r0
            goto L2e
        L20:
            boolean r0 = r0 instanceof android.app.Dialog
            if (r0 == 0) goto L2e
            androidx.appcompat.app.k r0 = new androidx.appcompat.app.k
            android.view.Window$Callback r1 = r3.e
            android.app.Dialog r1 = (android.app.Dialog) r1
            r0.<init>(r1)
            goto L1d
        L2e:
            androidx.appcompat.app.a r0 = r3.h
            if (r0 == 0) goto L37
            boolean r1 = r3.P
            r0.r(r1)
        L37:
            return
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.app.AppCompatDelegateImpl.T():void");
    }

    private boolean U(PanelFeatureState panelFeatureState) {
        View view = panelFeatureState.i;
        if (view != null) {
            panelFeatureState.h = view;
            return true;
        } else if (panelFeatureState.j == null) {
            return false;
        } else {
            if (this.m == null) {
                this.m = new m();
            }
            View view2 = (View) panelFeatureState.a(this.m);
            panelFeatureState.h = view2;
            return view2 != null;
        }
    }

    private boolean V(PanelFeatureState panelFeatureState) {
        panelFeatureState.d(O());
        panelFeatureState.g = new l(panelFeatureState.l);
        panelFeatureState.f452c = 81;
        return true;
    }

    private boolean W(PanelFeatureState panelFeatureState) {
        Context context = this.f448c;
        int i2 = panelFeatureState.f450a;
        if ((i2 == 0 || i2 == 108) && this.k != null) {
            TypedValue typedValue = new TypedValue();
            Resources.Theme theme = context.getTheme();
            theme.resolveAttribute(a.a.a.actionBarTheme, typedValue, true);
            Resources.Theme theme2 = null;
            if (typedValue.resourceId != 0) {
                theme2 = context.getResources().newTheme();
                theme2.setTo(theme);
                theme2.applyStyle(typedValue.resourceId, true);
                theme2.resolveAttribute(a.a.a.actionBarWidgetTheme, typedValue, true);
            } else {
                theme.resolveAttribute(a.a.a.actionBarWidgetTheme, typedValue, true);
            }
            if (typedValue.resourceId != 0) {
                if (theme2 == null) {
                    theme2 = context.getResources().newTheme();
                    theme2.setTo(theme);
                }
                theme2.applyStyle(typedValue.resourceId, true);
            }
            if (theme2 != null) {
                a.a.m.d dVar = new a.a.m.d(context, 0);
                dVar.getTheme().setTo(theme2);
                context = dVar;
            }
        }
        androidx.appcompat.view.menu.h hVar = new androidx.appcompat.view.menu.h(context);
        hVar.R(this);
        panelFeatureState.c(hVar);
        return true;
    }

    private void X(int i2) {
        this.N = (1 << i2) | this.N;
        if (this.M) {
            return;
        }
        r.L(this.f449d.getDecorView(), this.O);
        this.M = true;
    }

    private boolean c0(int i2, KeyEvent keyEvent) {
        if (keyEvent.getRepeatCount() == 0) {
            PanelFeatureState Q = Q(i2, true);
            if (Q.o) {
                return false;
            }
            return m0(Q, keyEvent);
        }
        return false;
    }

    private boolean f0(int i2, KeyEvent keyEvent) {
        boolean z;
        x xVar;
        if (this.n != null) {
            return false;
        }
        boolean z2 = true;
        PanelFeatureState Q = Q(i2, true);
        if (i2 != 0 || (xVar = this.k) == null || !xVar.g() || ViewConfiguration.get(this.f448c).hasPermanentMenuKey()) {
            boolean z3 = Q.o;
            if (z3 || Q.n) {
                E(Q, true);
                z2 = z3;
            } else {
                if (Q.m) {
                    if (Q.r) {
                        Q.m = false;
                        z = m0(Q, keyEvent);
                    } else {
                        z = true;
                    }
                    if (z) {
                        j0(Q, keyEvent);
                    }
                }
                z2 = false;
            }
        } else if (this.k.c()) {
            z2 = this.k.d();
        } else {
            if (!this.I && m0(Q, keyEvent)) {
                z2 = this.k.e();
            }
            z2 = false;
        }
        if (z2) {
            AudioManager audioManager = (AudioManager) this.f448c.getSystemService("audio");
            if (audioManager != null) {
                audioManager.playSoundEffect(0);
            } else {
                Log.w("AppCompatDelegate", "Couldn't get audio manager");
            }
        }
        return z2;
    }

    private void j0(PanelFeatureState panelFeatureState, KeyEvent keyEvent) {
        int i2;
        ViewGroup.LayoutParams layoutParams;
        if (panelFeatureState.o || this.I) {
            return;
        }
        if (panelFeatureState.f450a == 0) {
            if ((this.f448c.getResources().getConfiguration().screenLayout & 15) == 4) {
                return;
            }
        }
        Window.Callback S = S();
        if (S != null && !S.onMenuOpened(panelFeatureState.f450a, panelFeatureState.j)) {
            E(panelFeatureState, true);
            return;
        }
        WindowManager windowManager = (WindowManager) this.f448c.getSystemService("window");
        if (windowManager != null && m0(panelFeatureState, keyEvent)) {
            ViewGroup viewGroup = panelFeatureState.g;
            if (viewGroup == null || panelFeatureState.q) {
                if (viewGroup == null) {
                    if (!V(panelFeatureState) || panelFeatureState.g == null) {
                        return;
                    }
                } else if (panelFeatureState.q && viewGroup.getChildCount() > 0) {
                    panelFeatureState.g.removeAllViews();
                }
                if (!U(panelFeatureState) || !panelFeatureState.b()) {
                    return;
                }
                ViewGroup.LayoutParams layoutParams2 = panelFeatureState.h.getLayoutParams();
                if (layoutParams2 == null) {
                    layoutParams2 = new ViewGroup.LayoutParams(-2, -2);
                }
                panelFeatureState.g.setBackgroundResource(panelFeatureState.f451b);
                ViewParent parent = panelFeatureState.h.getParent();
                if (parent != null && (parent instanceof ViewGroup)) {
                    ((ViewGroup) parent).removeView(panelFeatureState.h);
                }
                panelFeatureState.g.addView(panelFeatureState.h, layoutParams2);
                if (!panelFeatureState.h.hasFocus()) {
                    panelFeatureState.h.requestFocus();
                }
            } else {
                View view = panelFeatureState.i;
                if (view != null && (layoutParams = view.getLayoutParams()) != null && layoutParams.width == -1) {
                    i2 = -1;
                    panelFeatureState.n = false;
                    WindowManager.LayoutParams layoutParams3 = new WindowManager.LayoutParams(i2, -2, panelFeatureState.f453d, panelFeatureState.e, 1002, 8519680, -3);
                    layoutParams3.gravity = panelFeatureState.f452c;
                    layoutParams3.windowAnimations = panelFeatureState.f;
                    windowManager.addView(panelFeatureState.g, layoutParams3);
                    panelFeatureState.o = true;
                }
            }
            i2 = -2;
            panelFeatureState.n = false;
            WindowManager.LayoutParams layoutParams32 = new WindowManager.LayoutParams(i2, -2, panelFeatureState.f453d, panelFeatureState.e, 1002, 8519680, -3);
            layoutParams32.gravity = panelFeatureState.f452c;
            layoutParams32.windowAnimations = panelFeatureState.f;
            windowManager.addView(panelFeatureState.g, layoutParams32);
            panelFeatureState.o = true;
        }
    }

    private boolean l0(PanelFeatureState panelFeatureState, int i2, KeyEvent keyEvent, int i3) {
        androidx.appcompat.view.menu.h hVar;
        boolean z = false;
        if (keyEvent.isSystem()) {
            return false;
        }
        if ((panelFeatureState.m || m0(panelFeatureState, keyEvent)) && (hVar = panelFeatureState.j) != null) {
            z = hVar.performShortcut(i2, keyEvent, i3);
        }
        if (z && (i3 & 1) == 0 && this.k == null) {
            E(panelFeatureState, true);
        }
        return z;
    }

    private boolean m0(PanelFeatureState panelFeatureState, KeyEvent keyEvent) {
        x xVar;
        x xVar2;
        x xVar3;
        x xVar4;
        if (this.I) {
            return false;
        }
        if (panelFeatureState.m) {
            return true;
        }
        PanelFeatureState panelFeatureState2 = this.G;
        if (panelFeatureState2 != null && panelFeatureState2 != panelFeatureState) {
            E(panelFeatureState2, false);
        }
        Window.Callback S = S();
        if (S != null) {
            panelFeatureState.i = S.onCreatePanelView(panelFeatureState.f450a);
        }
        int i2 = panelFeatureState.f450a;
        boolean z = i2 == 0 || i2 == 108;
        if (z && (xVar4 = this.k) != null) {
            xVar4.f();
        }
        if (panelFeatureState.i == null && (!z || !(k0() instanceof androidx.appcompat.app.h))) {
            androidx.appcompat.view.menu.h hVar = panelFeatureState.j;
            if (hVar == null || panelFeatureState.r) {
                if (hVar == null && (!W(panelFeatureState) || panelFeatureState.j == null)) {
                    return false;
                }
                if (z && (xVar2 = this.k) != null) {
                    if (this.l == null) {
                        this.l = new h();
                    }
                    xVar2.a(panelFeatureState.j, this.l);
                }
                panelFeatureState.j.d0();
                if (!S.onCreatePanelMenu(panelFeatureState.f450a, panelFeatureState.j)) {
                    panelFeatureState.c(null);
                    if (z && (xVar = this.k) != null) {
                        xVar.a(null, this.l);
                    }
                    return false;
                }
                panelFeatureState.r = false;
            }
            panelFeatureState.j.d0();
            Bundle bundle = panelFeatureState.s;
            if (bundle != null) {
                panelFeatureState.j.P(bundle);
                panelFeatureState.s = null;
            }
            if (!S.onPreparePanel(0, panelFeatureState.i, panelFeatureState.j)) {
                if (z && (xVar3 = this.k) != null) {
                    xVar3.a(null, this.l);
                }
                panelFeatureState.j.c0();
                return false;
            }
            boolean z2 = KeyCharacterMap.load(keyEvent != null ? keyEvent.getDeviceId() : -1).getKeyboardType() != 1;
            panelFeatureState.p = z2;
            panelFeatureState.j.setQwertyMode(z2);
            panelFeatureState.j.c0();
        }
        panelFeatureState.m = true;
        panelFeatureState.n = false;
        this.G = panelFeatureState;
        return true;
    }

    private void n0(androidx.appcompat.view.menu.h hVar, boolean z) {
        x xVar = this.k;
        if (xVar == null || !xVar.g() || (ViewConfiguration.get(this.f448c).hasPermanentMenuKey() && !this.k.b())) {
            PanelFeatureState Q = Q(0, true);
            Q.q = true;
            E(Q, false);
            j0(Q, null);
            return;
        }
        Window.Callback S = S();
        if (this.k.c() && z) {
            this.k.d();
            if (this.I) {
                return;
            }
            S.onPanelClosed(108, Q(0, true).j);
        } else if (S == null || this.I) {
        } else {
            if (this.M && (this.N & 1) != 0) {
                this.f449d.getDecorView().removeCallbacks(this.O);
                this.O.run();
            }
            PanelFeatureState Q2 = Q(0, true);
            androidx.appcompat.view.menu.h hVar2 = Q2.j;
            if (hVar2 == null || Q2.r || !S.onPreparePanel(0, Q2.i, hVar2)) {
                return;
            }
            S.onMenuOpened(108, Q2.j);
            this.k.e();
        }
    }

    private int o0(int i2) {
        if (i2 == 8) {
            Log.i("AppCompatDelegate", "You should now use the AppCompatDelegate.FEATURE_SUPPORT_ACTION_BAR id when requesting this feature.");
            return 108;
        } else if (i2 == 9) {
            Log.i("AppCompatDelegate", "You should now use the AppCompatDelegate.FEATURE_SUPPORT_ACTION_BAR_OVERLAY id when requesting this feature.");
            return 109;
        } else {
            return i2;
        }
    }

    private boolean q0(ViewParent viewParent) {
        if (viewParent == null) {
            return false;
        }
        View decorView = this.f449d.getDecorView();
        while (viewParent != null) {
            if (viewParent == decorView || !(viewParent instanceof View) || r.D((View) viewParent)) {
                return false;
            }
            viewParent = viewParent.getParent();
        }
        return true;
    }

    private boolean r0() {
        if (this.K) {
            Context context = this.f448c;
            if (context instanceof Activity) {
                PackageManager packageManager = context.getPackageManager();
                try {
                    Context context2 = this.f448c;
                    return (packageManager.getActivityInfo(new ComponentName(context2, context2.getClass()), 0).configChanges & 512) == 0;
                } catch (PackageManager.NameNotFoundException e2) {
                    Log.d("AppCompatDelegate", "Exception while getting ActivityInfo", e2);
                    return true;
                }
            }
        }
        return false;
    }

    private void u0() {
        if (this.t) {
            throw new AndroidRuntimeException("Window feature must be requested before adding content");
        }
    }

    private boolean v0(int i2) {
        Resources resources = this.f448c.getResources();
        Configuration configuration = resources.getConfiguration();
        int i3 = configuration.uiMode & 48;
        int i4 = i2 == 2 ? 32 : 16;
        if (i3 != i4) {
            if (r0()) {
                ((Activity) this.f448c).recreate();
                return true;
            }
            Configuration configuration2 = new Configuration(configuration);
            DisplayMetrics displayMetrics = resources.getDisplayMetrics();
            configuration2.uiMode = i4 | (configuration2.uiMode & (-49));
            resources.updateConfiguration(configuration2, displayMetrics);
            if (Build.VERSION.SDK_INT < 26) {
                androidx.appcompat.app.g.a(resources);
                return true;
            }
            return true;
        }
        return false;
    }

    void B(int i2, PanelFeatureState panelFeatureState, Menu menu) {
        if (menu == null) {
            if (panelFeatureState == null && i2 >= 0) {
                PanelFeatureState[] panelFeatureStateArr = this.F;
                if (i2 < panelFeatureStateArr.length) {
                    panelFeatureState = panelFeatureStateArr[i2];
                }
            }
            if (panelFeatureState != null) {
                menu = panelFeatureState.j;
            }
        }
        if ((panelFeatureState == null || panelFeatureState.o) && !this.I) {
            this.e.onPanelClosed(i2, menu);
        }
    }

    void C(androidx.appcompat.view.menu.h hVar) {
        if (this.E) {
            return;
        }
        this.E = true;
        this.k.l();
        Window.Callback S = S();
        if (S != null && !this.I) {
            S.onPanelClosed(108, hVar);
        }
        this.E = false;
    }

    void D(int i2) {
        E(Q(i2, true), true);
    }

    void E(PanelFeatureState panelFeatureState, boolean z) {
        ViewGroup viewGroup;
        x xVar;
        if (z && panelFeatureState.f450a == 0 && (xVar = this.k) != null && xVar.c()) {
            C(panelFeatureState.j);
            return;
        }
        WindowManager windowManager = (WindowManager) this.f448c.getSystemService("window");
        if (windowManager != null && panelFeatureState.o && (viewGroup = panelFeatureState.g) != null) {
            windowManager.removeView(viewGroup);
            if (z) {
                B(panelFeatureState.f450a, panelFeatureState, null);
            }
        }
        panelFeatureState.m = false;
        panelFeatureState.n = false;
        panelFeatureState.o = false;
        panelFeatureState.h = null;
        panelFeatureState.q = true;
        if (this.G == panelFeatureState) {
            this.G = null;
        }
    }

    public View G(View view, String str, Context context, AttributeSet attributeSet) {
        AppCompatViewInflater appCompatViewInflater;
        boolean z = false;
        if (this.S == null) {
            String string = this.f448c.obtainStyledAttributes(a.a.j.AppCompatTheme).getString(a.a.j.AppCompatTheme_viewInflaterClass);
            if (string == null || AppCompatViewInflater.class.getName().equals(string)) {
                appCompatViewInflater = new AppCompatViewInflater();
            } else {
                try {
                    this.S = (AppCompatViewInflater) Class.forName(string).getDeclaredConstructor(new Class[0]).newInstance(new Object[0]);
                } catch (Throwable th) {
                    Log.i("AppCompatDelegate", "Failed to instantiate custom view inflater " + string + ". Falling back to default.", th);
                    appCompatViewInflater = new AppCompatViewInflater();
                }
            }
            this.S = appCompatViewInflater;
        }
        boolean z2 = T;
        if (z2) {
            if (!(attributeSet instanceof XmlPullParser)) {
                z = q0((ViewParent) view);
            } else if (((XmlPullParser) attributeSet).getDepth() > 1) {
                z = true;
            }
        }
        return this.S.createView(view, str, context, attributeSet, z, z2, true, v0.b());
    }

    void H() {
        androidx.appcompat.view.menu.h hVar;
        x xVar = this.k;
        if (xVar != null) {
            xVar.l();
        }
        if (this.p != null) {
            this.f449d.getDecorView().removeCallbacks(this.q);
            if (this.p.isShowing()) {
                try {
                    this.p.dismiss();
                } catch (IllegalArgumentException unused) {
                }
            }
            this.p = null;
        }
        K();
        PanelFeatureState Q = Q(0, false);
        if (Q == null || (hVar = Q.j) == null) {
            return;
        }
        hVar.close();
    }

    boolean I(KeyEvent keyEvent) {
        View decorView;
        Window.Callback callback = this.e;
        if (((callback instanceof d.a) || (callback instanceof androidx.appcompat.app.f)) && (decorView = this.f449d.getDecorView()) != null && a.f.l.d.d(decorView, keyEvent)) {
            return true;
        }
        if (keyEvent.getKeyCode() == 82 && this.e.dispatchKeyEvent(keyEvent)) {
            return true;
        }
        int keyCode = keyEvent.getKeyCode();
        return keyEvent.getAction() == 0 ? b0(keyCode, keyEvent) : e0(keyCode, keyEvent);
    }

    void J(int i2) {
        PanelFeatureState Q;
        PanelFeatureState Q2 = Q(i2, true);
        if (Q2.j != null) {
            Bundle bundle = new Bundle();
            Q2.j.Q(bundle);
            if (bundle.size() > 0) {
                Q2.s = bundle;
            }
            Q2.j.d0();
            Q2.j.clear();
        }
        Q2.r = true;
        Q2.q = true;
        if ((i2 != 108 && i2 != 0) || this.k == null || (Q = Q(0, false)) == null) {
            return;
        }
        Q.m = false;
        m0(Q, null);
    }

    void K() {
        v vVar = this.r;
        if (vVar != null) {
            vVar.b();
        }
    }

    PanelFeatureState N(Menu menu) {
        PanelFeatureState[] panelFeatureStateArr = this.F;
        int length = panelFeatureStateArr != null ? panelFeatureStateArr.length : 0;
        for (int i2 = 0; i2 < length; i2++) {
            PanelFeatureState panelFeatureState = panelFeatureStateArr[i2];
            if (panelFeatureState != null && panelFeatureState.j == menu) {
                return panelFeatureState;
            }
        }
        return null;
    }

    final Context O() {
        androidx.appcompat.app.a j2 = j();
        Context k2 = j2 != null ? j2.k() : null;
        return k2 == null ? this.f448c : k2;
    }

    protected PanelFeatureState Q(int i2, boolean z) {
        PanelFeatureState[] panelFeatureStateArr = this.F;
        if (panelFeatureStateArr == null || panelFeatureStateArr.length <= i2) {
            PanelFeatureState[] panelFeatureStateArr2 = new PanelFeatureState[i2 + 1];
            if (panelFeatureStateArr != null) {
                System.arraycopy(panelFeatureStateArr, 0, panelFeatureStateArr2, 0, panelFeatureStateArr.length);
            }
            this.F = panelFeatureStateArr2;
            panelFeatureStateArr = panelFeatureStateArr2;
        }
        PanelFeatureState panelFeatureState = panelFeatureStateArr[i2];
        if (panelFeatureState == null) {
            PanelFeatureState panelFeatureState2 = new PanelFeatureState(i2);
            panelFeatureStateArr[i2] = panelFeatureState2;
            return panelFeatureState2;
        }
        return panelFeatureState;
    }

    final CharSequence R() {
        Window.Callback callback = this.e;
        return callback instanceof Activity ? ((Activity) callback).getTitle() : this.j;
    }

    final Window.Callback S() {
        return this.f449d.getCallback();
    }

    public boolean Y() {
        return this.s;
    }

    int Z(int i2) {
        if (i2 != -100) {
            if (i2 != 0) {
                return i2;
            }
            if (Build.VERSION.SDK_INT < 23 || ((UiModeManager) this.f448c.getSystemService(UiModeManager.class)).getNightMode() != 0) {
                L();
                return this.L.c();
            }
            return -1;
        }
        return -1;
    }

    @Override // androidx.appcompat.view.menu.h.a
    public boolean a(androidx.appcompat.view.menu.h hVar, MenuItem menuItem) {
        PanelFeatureState N;
        Window.Callback S = S();
        if (S == null || this.I || (N = N(hVar.D())) == null) {
            return false;
        }
        return S.onMenuItemSelected(N.f450a, menuItem);
    }

    boolean a0() {
        a.a.m.b bVar = this.n;
        if (bVar != null) {
            bVar.c();
            return true;
        }
        androidx.appcompat.app.a j2 = j();
        return j2 != null && j2.h();
    }

    @Override // androidx.appcompat.view.menu.h.a
    public void b(androidx.appcompat.view.menu.h hVar) {
        n0(hVar, true);
    }

    boolean b0(int i2, KeyEvent keyEvent) {
        if (i2 == 4) {
            this.H = (keyEvent.getFlags() & 128) != 0;
        } else if (i2 == 82) {
            c0(0, keyEvent);
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.app.e
    public void c(View view, ViewGroup.LayoutParams layoutParams) {
        M();
        ((ViewGroup) this.u.findViewById(16908290)).addView(view, layoutParams);
        this.e.onContentChanged();
    }

    @Override // androidx.appcompat.app.e
    public boolean d() {
        int P = P();
        int Z = Z(P);
        boolean v0 = Z != -1 ? v0(Z) : false;
        if (P == 0) {
            L();
            this.L.d();
        }
        this.K = true;
        return v0;
    }

    boolean d0(int i2, KeyEvent keyEvent) {
        androidx.appcompat.app.a j2 = j();
        if (j2 == null || !j2.o(i2, keyEvent)) {
            PanelFeatureState panelFeatureState = this.G;
            if (panelFeatureState != null && l0(panelFeatureState, keyEvent.getKeyCode(), keyEvent, 1)) {
                PanelFeatureState panelFeatureState2 = this.G;
                if (panelFeatureState2 != null) {
                    panelFeatureState2.n = true;
                }
                return true;
            }
            if (this.G == null) {
                PanelFeatureState Q = Q(0, true);
                m0(Q, keyEvent);
                boolean l0 = l0(Q, keyEvent.getKeyCode(), keyEvent, 1);
                Q.m = false;
                if (l0) {
                    return true;
                }
            }
            return false;
        }
        return true;
    }

    boolean e0(int i2, KeyEvent keyEvent) {
        if (i2 == 4) {
            boolean z = this.H;
            this.H = false;
            PanelFeatureState Q = Q(0, false);
            if (Q != null && Q.o) {
                if (!z) {
                    E(Q, true);
                }
                return true;
            } else if (a0()) {
                return true;
            }
        } else if (i2 == 82) {
            f0(0, keyEvent);
            return true;
        }
        return false;
    }

    @Override // androidx.appcompat.app.e
    public <T extends View> T g(int i2) {
        M();
        return (T) this.f449d.findViewById(i2);
    }

    void g0(int i2) {
        androidx.appcompat.app.a j2;
        if (i2 != 108 || (j2 = j()) == null) {
            return;
        }
        j2.i(true);
    }

    void h0(int i2) {
        if (i2 == 108) {
            androidx.appcompat.app.a j2 = j();
            if (j2 != null) {
                j2.i(false);
            }
        } else if (i2 == 0) {
            PanelFeatureState Q = Q(i2, true);
            if (Q.o) {
                E(Q, false);
            }
        }
    }

    @Override // androidx.appcompat.app.e
    public MenuInflater i() {
        if (this.i == null) {
            T();
            androidx.appcompat.app.a aVar = this.h;
            this.i = new a.a.m.g(aVar != null ? aVar.k() : this.f448c);
        }
        return this.i;
    }

    void i0(ViewGroup viewGroup) {
    }

    @Override // androidx.appcompat.app.e
    public androidx.appcompat.app.a j() {
        T();
        return this.h;
    }

    @Override // androidx.appcompat.app.e
    public void k() {
        LayoutInflater from = LayoutInflater.from(this.f448c);
        if (from.getFactory() == null) {
            a.f.l.e.b(from, this);
        } else if (from.getFactory2() instanceof AppCompatDelegateImpl) {
        } else {
            Log.i("AppCompatDelegate", "The Activity's LayoutInflater already has a Factory installed so we can not install AppCompat's");
        }
    }

    final androidx.appcompat.app.a k0() {
        return this.h;
    }

    @Override // androidx.appcompat.app.e
    public void l() {
        androidx.appcompat.app.a j2 = j();
        if (j2 == null || !j2.l()) {
            X(0);
        }
    }

    @Override // androidx.appcompat.app.e
    public void m(Configuration configuration) {
        androidx.appcompat.app.a j2;
        if (this.z && this.t && (j2 = j()) != null) {
            j2.m(configuration);
        }
        androidx.appcompat.widget.h.n().y(this.f448c);
        d();
    }

    @Override // androidx.appcompat.app.e
    public void n(Bundle bundle) {
        Window.Callback callback = this.e;
        if (callback instanceof Activity) {
            String str = null;
            try {
                str = androidx.core.app.e.c((Activity) callback);
            } catch (IllegalArgumentException unused) {
            }
            if (str != null) {
                androidx.appcompat.app.a k0 = k0();
                if (k0 == null) {
                    this.P = true;
                } else {
                    k0.r(true);
                }
            }
        }
        if (bundle == null || this.J != -100) {
            return;
        }
        this.J = bundle.getInt("appcompat:local_night_mode", -100);
    }

    @Override // androidx.appcompat.app.e
    public void o() {
        if (this.M) {
            this.f449d.getDecorView().removeCallbacks(this.O);
        }
        this.I = true;
        androidx.appcompat.app.a aVar = this.h;
        if (aVar != null) {
            aVar.n();
        }
        k kVar = this.L;
        if (kVar != null) {
            kVar.a();
        }
    }

    @Override // android.view.LayoutInflater.Factory2
    public final View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        return G(view, str, context, attributeSet);
    }

    @Override // android.view.LayoutInflater.Factory
    public View onCreateView(String str, Context context, AttributeSet attributeSet) {
        return onCreateView(null, str, context, attributeSet);
    }

    @Override // androidx.appcompat.app.e
    public void p(Bundle bundle) {
        M();
    }

    final boolean p0() {
        ViewGroup viewGroup;
        return this.t && (viewGroup = this.u) != null && r.E(viewGroup);
    }

    @Override // androidx.appcompat.app.e
    public void q() {
        androidx.appcompat.app.a j2 = j();
        if (j2 != null) {
            j2.u(true);
        }
    }

    @Override // androidx.appcompat.app.e
    public void r(Bundle bundle) {
        int i2 = this.J;
        if (i2 != -100) {
            bundle.putInt("appcompat:local_night_mode", i2);
        }
    }

    @Override // androidx.appcompat.app.e
    public void s() {
        d();
    }

    public a.a.m.b s0(b.a aVar) {
        androidx.appcompat.app.d dVar;
        if (aVar != null) {
            a.a.m.b bVar = this.n;
            if (bVar != null) {
                bVar.c();
            }
            i iVar = new i(aVar);
            androidx.appcompat.app.a j2 = j();
            if (j2 != null) {
                a.a.m.b w = j2.w(iVar);
                this.n = w;
                if (w != null && (dVar = this.g) != null) {
                    dVar.i(w);
                }
            }
            if (this.n == null) {
                this.n = t0(iVar);
            }
            return this.n;
        }
        throw new IllegalArgumentException("ActionMode callback can not be null.");
    }

    @Override // androidx.appcompat.app.e
    public void t() {
        androidx.appcompat.app.a j2 = j();
        if (j2 != null) {
            j2.u(false);
        }
        k kVar = this.L;
        if (kVar != null) {
            kVar.a();
        }
    }

    /* JADX WARN: Removed duplicated region for block: B:16:0x0025  */
    /* JADX WARN: Removed duplicated region for block: B:17:0x0029  */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    a.a.m.b t0(a.a.m.b.a r8) {
        /*
            Method dump skipped, instructions count: 367
            To view this dump add '--comments-level debug' option
        */
        throw new UnsupportedOperationException("Method not decompiled: androidx.appcompat.app.AppCompatDelegateImpl.t0(a.a.m.b$a):a.a.m.b");
    }

    @Override // androidx.appcompat.app.e
    public boolean u(int i2) {
        int o0 = o0(i2);
        if (this.D && o0 == 108) {
            return false;
        }
        if (this.z && o0 == 1) {
            this.z = false;
        }
        if (o0 == 1) {
            u0();
            this.D = true;
            return true;
        } else if (o0 == 2) {
            u0();
            this.x = true;
            return true;
        } else if (o0 == 5) {
            u0();
            this.y = true;
            return true;
        } else if (o0 == 10) {
            u0();
            this.B = true;
            return true;
        } else if (o0 == 108) {
            u0();
            this.z = true;
            return true;
        } else if (o0 != 109) {
            return this.f449d.requestFeature(o0);
        } else {
            u0();
            this.A = true;
            return true;
        }
    }

    @Override // androidx.appcompat.app.e
    public void v(int i2) {
        M();
        ViewGroup viewGroup = (ViewGroup) this.u.findViewById(16908290);
        viewGroup.removeAllViews();
        LayoutInflater.from(this.f448c).inflate(i2, viewGroup);
        this.e.onContentChanged();
    }

    @Override // androidx.appcompat.app.e
    public void w(View view) {
        M();
        ViewGroup viewGroup = (ViewGroup) this.u.findViewById(16908290);
        viewGroup.removeAllViews();
        viewGroup.addView(view);
        this.e.onContentChanged();
    }

    int w0(int i2) {
        boolean z;
        boolean z2;
        ActionBarContextView actionBarContextView = this.o;
        if (actionBarContextView == null || !(actionBarContextView.getLayoutParams() instanceof ViewGroup.MarginLayoutParams)) {
            z = false;
        } else {
            ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) this.o.getLayoutParams();
            if (this.o.isShown()) {
                if (this.Q == null) {
                    this.Q = new Rect();
                    this.R = new Rect();
                }
                Rect rect = this.Q;
                Rect rect2 = this.R;
                rect.set(0, i2, 0, 0);
                w0.a(this.u, rect, rect2);
                if (marginLayoutParams.topMargin != (rect2.top == 0 ? i2 : 0)) {
                    marginLayoutParams.topMargin = i2;
                    View view = this.w;
                    if (view == null) {
                        View view2 = new View(this.f448c);
                        this.w = view2;
                        view2.setBackgroundColor(this.f448c.getResources().getColor(a.a.c.abc_input_method_navigation_guard));
                        this.u.addView(this.w, -1, new ViewGroup.LayoutParams(-1, i2));
                    } else {
                        ViewGroup.LayoutParams layoutParams = view.getLayoutParams();
                        if (layoutParams.height != i2) {
                            layoutParams.height = i2;
                            this.w.setLayoutParams(layoutParams);
                        }
                    }
                    z2 = true;
                } else {
                    z2 = false;
                }
                r3 = this.w != null;
                if (!this.B && r3) {
                    i2 = 0;
                }
                boolean z3 = r3;
                r3 = z2;
                z = z3;
            } else if (marginLayoutParams.topMargin != 0) {
                marginLayoutParams.topMargin = 0;
                z = false;
            } else {
                z = false;
                r3 = false;
            }
            if (r3) {
                this.o.setLayoutParams(marginLayoutParams);
            }
        }
        View view3 = this.w;
        if (view3 != null) {
            view3.setVisibility(z ? 0 : 8);
        }
        return i2;
    }

    @Override // androidx.appcompat.app.e
    public void x(View view, ViewGroup.LayoutParams layoutParams) {
        M();
        ViewGroup viewGroup = (ViewGroup) this.u.findViewById(16908290);
        viewGroup.removeAllViews();
        viewGroup.addView(view, layoutParams);
        this.e.onContentChanged();
    }

    @Override // androidx.appcompat.app.e
    public void y(Toolbar toolbar) {
        Window window;
        Window.Callback callback;
        if (this.e instanceof Activity) {
            androidx.appcompat.app.a j2 = j();
            if (j2 instanceof androidx.appcompat.app.k) {
                throw new IllegalStateException("This Activity already has an action bar supplied by the window decor. Do not request Window.FEATURE_SUPPORT_ACTION_BAR and set windowActionBar to false in your theme to use a Toolbar instead.");
            }
            this.i = null;
            if (j2 != null) {
                j2.n();
            }
            if (toolbar != null) {
                androidx.appcompat.app.h hVar = new androidx.appcompat.app.h(toolbar, ((Activity) this.e).getTitle(), this.f);
                this.h = hVar;
                window = this.f449d;
                callback = hVar.y();
            } else {
                this.h = null;
                window = this.f449d;
                callback = this.f;
            }
            window.setCallback(callback);
            l();
        }
    }

    @Override // androidx.appcompat.app.e
    public final void z(CharSequence charSequence) {
        this.j = charSequence;
        x xVar = this.k;
        if (xVar != null) {
            xVar.setWindowTitle(charSequence);
        } else if (k0() != null) {
            k0().v(charSequence);
        } else {
            TextView textView = this.v;
            if (textView != null) {
                textView.setText(charSequence);
            }
        }
    }
}
