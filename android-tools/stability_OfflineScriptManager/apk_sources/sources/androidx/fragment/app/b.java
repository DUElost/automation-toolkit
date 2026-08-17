package androidx.fragment.app;

import android.content.Context;
import android.content.Intent;
import android.content.IntentSender;
import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.Parcelable;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import androidx.core.app.a;
import androidx.lifecycle.e;
import androidx.lifecycle.r;
import androidx.lifecycle.s;
import java.io.FileDescriptor;
import java.io.PrintWriter;
/* loaded from: classes.dex */
public class b extends androidx.core.app.d implements s, a.b, a.d {
    private r e;
    boolean f;
    boolean g;
    boolean i;
    boolean j;
    boolean k;
    int l;
    a.d.h<String> m;

    /* renamed from: c  reason: collision with root package name */
    final Handler f960c = new a();

    /* renamed from: d  reason: collision with root package name */
    final d f961d = d.b(new C0035b());
    boolean h = true;

    /* loaded from: classes.dex */
    class a extends Handler {
        a() {
        }

        @Override // android.os.Handler
        public void handleMessage(Message message) {
            if (message.what != 2) {
                super.handleMessage(message);
                return;
            }
            b.this.x();
            b.this.f961d.s();
        }
    }

    /* renamed from: androidx.fragment.app.b$b  reason: collision with other inner class name */
    /* loaded from: classes.dex */
    class C0035b extends e<b> {
        public C0035b() {
            super(b.this);
        }

        @Override // androidx.fragment.app.c
        public View b(int i) {
            return b.this.findViewById(i);
        }

        @Override // androidx.fragment.app.c
        public boolean c() {
            Window window = b.this.getWindow();
            return (window == null || window.peekDecorView() == null) ? false : true;
        }

        @Override // androidx.fragment.app.e
        public void h(Fragment fragment) {
            b.this.v(fragment);
        }

        @Override // androidx.fragment.app.e
        public void i(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
            b.this.dump(str, fileDescriptor, printWriter, strArr);
        }

        @Override // androidx.fragment.app.e
        public LayoutInflater j() {
            return b.this.getLayoutInflater().cloneInContext(b.this);
        }

        @Override // androidx.fragment.app.e
        public int k() {
            Window window = b.this.getWindow();
            if (window == null) {
                return 0;
            }
            return window.getAttributes().windowAnimations;
        }

        @Override // androidx.fragment.app.e
        public boolean l() {
            return b.this.getWindow() != null;
        }

        @Override // androidx.fragment.app.e
        public boolean m(Fragment fragment) {
            return !b.this.isFinishing();
        }

        @Override // androidx.fragment.app.e
        public void n(Fragment fragment, Intent intent, int i, Bundle bundle) {
            b.this.z(fragment, intent, i, bundle);
        }

        @Override // androidx.fragment.app.e
        public void o() {
            b.this.A();
        }
    }

    /* JADX INFO: Access modifiers changed from: package-private */
    /* loaded from: classes.dex */
    public static final class c {

        /* renamed from: a  reason: collision with root package name */
        Object f963a;

        /* renamed from: b  reason: collision with root package name */
        r f964b;

        /* renamed from: c  reason: collision with root package name */
        h f965c;

        c() {
        }
    }

    private int p(Fragment fragment) {
        if (this.m.l() < 65534) {
            while (this.m.h(this.l) >= 0) {
                this.l = (this.l + 1) % 65534;
            }
            int i = this.l;
            this.m.j(i, fragment.g);
            this.l = (this.l + 1) % 65534;
            return i;
        }
        throw new IllegalStateException("Too many pending Fragment activity results.");
    }

    static void q(int i) {
        if ((i & (-65536)) != 0) {
            throw new IllegalArgumentException("Can only use lower 16 bits for requestCode");
        }
    }

    private void t() {
        do {
        } while (u(s(), e.b.CREATED));
    }

    private static boolean u(f fVar, e.b bVar) {
        boolean z = false;
        for (Fragment fragment : fVar.f()) {
            if (fragment != null) {
                if (fragment.a().b().a(e.b.STARTED)) {
                    fragment.T.k(bVar);
                    z = true;
                }
                f y0 = fragment.y0();
                if (y0 != null) {
                    z |= u(y0, bVar);
                }
            }
        }
        return z;
    }

    @Deprecated
    public void A() {
        invalidateOptionsMenu();
    }

    @Override // androidx.core.app.d, androidx.lifecycle.g
    public androidx.lifecycle.e a() {
        return super.a();
    }

    @Override // androidx.core.app.a.d
    public final void b(int i) {
        if (this.i || i == -1) {
            return;
        }
        q(i);
    }

    @Override // android.app.Activity
    public void dump(String str, FileDescriptor fileDescriptor, PrintWriter printWriter, String[] strArr) {
        super.dump(str, fileDescriptor, printWriter, strArr);
        printWriter.print(str);
        printWriter.print("Local FragmentActivity ");
        printWriter.print(Integer.toHexString(System.identityHashCode(this)));
        printWriter.println(" State:");
        String str2 = str + "  ";
        printWriter.print(str2);
        printWriter.print("mCreated=");
        printWriter.print(this.f);
        printWriter.print(" mResumed=");
        printWriter.print(this.g);
        printWriter.print(" mStopped=");
        printWriter.print(this.h);
        if (getApplication() != null) {
            a.j.a.a.b(this).a(str2, fileDescriptor, printWriter, strArr);
        }
        this.f961d.u().b(str, fileDescriptor, printWriter, strArr);
    }

    @Override // androidx.lifecycle.s
    public r k() {
        if (getApplication() != null) {
            if (this.e == null) {
                c cVar = (c) getLastNonConfigurationInstance();
                if (cVar != null) {
                    this.e = cVar.f964b;
                }
                if (this.e == null) {
                    this.e = new r();
                }
            }
            return this.e;
        }
        throw new IllegalStateException("Your activity is not yet attached to the Application instance. You can't request ViewModel before onCreate call.");
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onActivityResult(int i, int i2, Intent intent) {
        this.f961d.v();
        int i3 = i >> 16;
        if (i3 == 0) {
            a.c i4 = androidx.core.app.a.i();
            if (i4 == null || !i4.b(this, i, i2, intent)) {
                super.onActivityResult(i, i2, intent);
                return;
            }
            return;
        }
        int i5 = i3 - 1;
        String f = this.m.f(i5);
        this.m.k(i5);
        if (f == null) {
            Log.w("FragmentActivity", "Activity result delivered for unknown Fragment.");
            return;
        }
        Fragment t = this.f961d.t(f);
        if (t != null) {
            t.T(i & 65535, i2, intent);
            return;
        }
        Log.w("FragmentActivity", "Activity result no fragment exists for who: " + f);
    }

    @Override // android.app.Activity
    public void onBackPressed() {
        f u = this.f961d.u();
        boolean g = u.g();
        if (!g || Build.VERSION.SDK_INT > 25) {
            if (g || !u.i()) {
                super.onBackPressed();
            }
        }
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onConfigurationChanged(Configuration configuration) {
        super.onConfigurationChanged(configuration);
        this.f961d.v();
        this.f961d.d(configuration);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.core.app.d, android.app.Activity
    public void onCreate(Bundle bundle) {
        r rVar;
        this.f961d.a(null);
        super.onCreate(bundle);
        c cVar = (c) getLastNonConfigurationInstance();
        if (cVar != null && (rVar = cVar.f964b) != null && this.e == null) {
            this.e = rVar;
        }
        if (bundle != null) {
            this.f961d.x(bundle.getParcelable("android:support:fragments"), cVar != null ? cVar.f965c : null);
            if (bundle.containsKey("android:support:next_request_index")) {
                this.l = bundle.getInt("android:support:next_request_index");
                int[] intArray = bundle.getIntArray("android:support:request_indicies");
                String[] stringArray = bundle.getStringArray("android:support:request_fragment_who");
                if (intArray == null || stringArray == null || intArray.length != stringArray.length) {
                    Log.w("FragmentActivity", "Invalid requestCode mapping in savedInstanceState.");
                } else {
                    this.m = new a.d.h<>(intArray.length);
                    for (int i = 0; i < intArray.length; i++) {
                        this.m.j(intArray[i], stringArray[i]);
                    }
                }
            }
        }
        if (this.m == null) {
            this.m = new a.d.h<>();
            this.l = 0;
        }
        this.f961d.f();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onCreatePanelMenu(int i, Menu menu) {
        return i == 0 ? super.onCreatePanelMenu(i, menu) | this.f961d.g(menu, getMenuInflater()) : super.onCreatePanelMenu(i, menu);
    }

    @Override // android.app.Activity, android.view.LayoutInflater.Factory2
    public View onCreateView(View view, String str, Context context, AttributeSet attributeSet) {
        View r = r(view, str, context, attributeSet);
        return r == null ? super.onCreateView(view, str, context, attributeSet) : r;
    }

    @Override // android.app.Activity, android.view.LayoutInflater.Factory
    public View onCreateView(String str, Context context, AttributeSet attributeSet) {
        View r = r(null, str, context, attributeSet);
        return r == null ? super.onCreateView(str, context, attributeSet) : r;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onDestroy() {
        super.onDestroy();
        if (this.e != null && !isChangingConfigurations()) {
            this.e.a();
        }
        this.f961d.h();
    }

    @Override // android.app.Activity, android.content.ComponentCallbacks
    public void onLowMemory() {
        super.onLowMemory();
        this.f961d.i();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onMenuItemSelected(int i, MenuItem menuItem) {
        if (super.onMenuItemSelected(i, menuItem)) {
            return true;
        }
        if (i != 0) {
            if (i != 6) {
                return false;
            }
            return this.f961d.e(menuItem);
        }
        return this.f961d.k(menuItem);
    }

    @Override // android.app.Activity
    public void onMultiWindowModeChanged(boolean z) {
        this.f961d.j(z);
    }

    @Override // android.app.Activity
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        this.f961d.v();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public void onPanelClosed(int i, Menu menu) {
        if (i == 0) {
            this.f961d.l(menu);
        }
        super.onPanelClosed(i, menu);
    }

    @Override // android.app.Activity
    protected void onPause() {
        super.onPause();
        this.g = false;
        if (this.f960c.hasMessages(2)) {
            this.f960c.removeMessages(2);
            x();
        }
        this.f961d.m();
    }

    @Override // android.app.Activity
    public void onPictureInPictureModeChanged(boolean z) {
        this.f961d.n(z);
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onPostResume() {
        super.onPostResume();
        this.f960c.removeMessages(2);
        x();
        this.f961d.s();
    }

    @Override // android.app.Activity, android.view.Window.Callback
    public boolean onPreparePanel(int i, View view, Menu menu) {
        return (i != 0 || menu == null) ? super.onPreparePanel(i, view, menu) : w(view, menu) | this.f961d.o(menu);
    }

    @Override // android.app.Activity, androidx.core.app.a.b
    public void onRequestPermissionsResult(int i, String[] strArr, int[] iArr) {
        this.f961d.v();
        int i2 = (i >> 16) & 65535;
        if (i2 != 0) {
            int i3 = i2 - 1;
            String f = this.m.f(i3);
            this.m.k(i3);
            if (f == null) {
                Log.w("FragmentActivity", "Activity result delivered for unknown Fragment.");
                return;
            }
            Fragment t = this.f961d.t(f);
            if (t != null) {
                t.r0(i & 65535, strArr, iArr);
                return;
            }
            Log.w("FragmentActivity", "Activity result no fragment exists for who: " + f);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onResume() {
        super.onResume();
        this.f960c.sendEmptyMessage(2);
        this.g = true;
        this.f961d.s();
    }

    @Override // android.app.Activity
    public final Object onRetainNonConfigurationInstance() {
        Object y = y();
        h y2 = this.f961d.y();
        if (y2 == null && this.e == null && y == null) {
            return null;
        }
        c cVar = new c();
        cVar.f963a = y;
        cVar.f964b = this.e;
        cVar.f965c = y2;
        return cVar;
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // androidx.core.app.d, android.app.Activity
    public void onSaveInstanceState(Bundle bundle) {
        super.onSaveInstanceState(bundle);
        t();
        Parcelable z = this.f961d.z();
        if (z != null) {
            bundle.putParcelable("android:support:fragments", z);
        }
        if (this.m.l() > 0) {
            bundle.putInt("android:support:next_request_index", this.l);
            int[] iArr = new int[this.m.l()];
            String[] strArr = new String[this.m.l()];
            for (int i = 0; i < this.m.l(); i++) {
                iArr[i] = this.m.i(i);
                strArr[i] = this.m.m(i);
            }
            bundle.putIntArray("android:support:request_indicies", iArr);
            bundle.putStringArray("android:support:request_fragment_who", strArr);
        }
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onStart() {
        super.onStart();
        this.h = false;
        if (!this.f) {
            this.f = true;
            this.f961d.c();
        }
        this.f961d.v();
        this.f961d.s();
        this.f961d.q();
    }

    @Override // android.app.Activity
    public void onStateNotSaved() {
        this.f961d.v();
    }

    /* JADX INFO: Access modifiers changed from: protected */
    @Override // android.app.Activity
    public void onStop() {
        super.onStop();
        this.h = true;
        t();
        this.f961d.r();
    }

    final View r(View view, String str, Context context, AttributeSet attributeSet) {
        return this.f961d.w(view, str, context, attributeSet);
    }

    public f s() {
        return this.f961d.u();
    }

    @Override // android.app.Activity
    public void startActivityForResult(Intent intent, int i) {
        if (!this.k && i != -1) {
            q(i);
        }
        super.startActivityForResult(intent, i);
    }

    @Override // android.app.Activity
    public void startActivityForResult(Intent intent, int i, Bundle bundle) {
        if (!this.k && i != -1) {
            q(i);
        }
        super.startActivityForResult(intent, i, bundle);
    }

    @Override // android.app.Activity
    public void startIntentSenderForResult(IntentSender intentSender, int i, Intent intent, int i2, int i3, int i4) {
        if (!this.j && i != -1) {
            q(i);
        }
        super.startIntentSenderForResult(intentSender, i, intent, i2, i3, i4);
    }

    @Override // android.app.Activity
    public void startIntentSenderForResult(IntentSender intentSender, int i, Intent intent, int i2, int i3, int i4, Bundle bundle) {
        if (!this.j && i != -1) {
            q(i);
        }
        super.startIntentSenderForResult(intentSender, i, intent, i2, i3, i4, bundle);
    }

    public void v(Fragment fragment) {
    }

    protected boolean w(View view, Menu menu) {
        return super.onPreparePanel(0, view, menu);
    }

    protected void x() {
        this.f961d.p();
    }

    public Object y() {
        return null;
    }

    public void z(Fragment fragment, Intent intent, int i, Bundle bundle) {
        this.k = true;
        try {
            if (i == -1) {
                androidx.core.app.a.k(this, intent, -1, bundle);
                return;
            }
            q(i);
            androidx.core.app.a.k(this, intent, ((p(fragment) + 1) << 16) + (i & 65535), bundle);
        } finally {
            this.k = false;
        }
    }
}
