package androidx.appcompat.widget;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.os.Build;
import java.lang.ref.WeakReference;
import java.util.ArrayList;
/* loaded from: classes.dex */
public class n0 extends ContextWrapper {

    /* renamed from: c  reason: collision with root package name */
    private static final Object f735c = new Object();

    /* renamed from: d  reason: collision with root package name */
    private static ArrayList<WeakReference<n0>> f736d;

    /* renamed from: a  reason: collision with root package name */
    private final Resources f737a;

    /* renamed from: b  reason: collision with root package name */
    private final Resources.Theme f738b;

    private n0(Context context) {
        super(context);
        if (!v0.b()) {
            this.f737a = new p0(this, context.getResources());
            this.f738b = null;
            return;
        }
        v0 v0Var = new v0(this, context.getResources());
        this.f737a = v0Var;
        Resources.Theme newTheme = v0Var.newTheme();
        this.f738b = newTheme;
        newTheme.setTo(context.getTheme());
    }

    private static boolean a(Context context) {
        if ((context instanceof n0) || (context.getResources() instanceof p0) || (context.getResources() instanceof v0)) {
            return false;
        }
        return Build.VERSION.SDK_INT < 21 || v0.b();
    }

    public static Context b(Context context) {
        if (a(context)) {
            synchronized (f735c) {
                ArrayList<WeakReference<n0>> arrayList = f736d;
                if (arrayList == null) {
                    f736d = new ArrayList<>();
                } else {
                    for (int size = arrayList.size() - 1; size >= 0; size--) {
                        WeakReference<n0> weakReference = f736d.get(size);
                        if (weakReference == null || weakReference.get() == null) {
                            f736d.remove(size);
                        }
                    }
                    for (int size2 = f736d.size() - 1; size2 >= 0; size2--) {
                        WeakReference<n0> weakReference2 = f736d.get(size2);
                        n0 n0Var = weakReference2 != null ? weakReference2.get() : null;
                        if (n0Var != null && n0Var.getBaseContext() == context) {
                            return n0Var;
                        }
                    }
                }
                n0 n0Var2 = new n0(context);
                f736d.add(new WeakReference<>(n0Var2));
                return n0Var2;
            }
        }
        return context;
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public AssetManager getAssets() {
        return this.f737a.getAssets();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Resources getResources() {
        return this.f737a;
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Resources.Theme getTheme() {
        Resources.Theme theme = this.f738b;
        return theme == null ? super.getTheme() : theme;
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void setTheme(int i) {
        Resources.Theme theme = this.f738b;
        if (theme == null) {
            super.setTheme(i);
        } else {
            theme.applyStyle(i, true);
        }
    }
}
