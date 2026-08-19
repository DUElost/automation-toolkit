package a.a.m;

import android.content.Context;
import android.content.ContextWrapper;
import android.content.res.AssetManager;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.os.Build;
import android.view.LayoutInflater;
/* loaded from: classes.dex */
public class d extends ContextWrapper {

    /* renamed from: a  reason: collision with root package name */
    private int f25a;

    /* renamed from: b  reason: collision with root package name */
    private Resources.Theme f26b;

    /* renamed from: c  reason: collision with root package name */
    private LayoutInflater f27c;

    /* renamed from: d  reason: collision with root package name */
    private Configuration f28d;
    private Resources e;

    public d() {
        super(null);
    }

    public d(Context context, int i) {
        super(context);
        this.f25a = i;
    }

    public d(Context context, Resources.Theme theme) {
        super(context);
        this.f26b = theme;
    }

    private Resources a() {
        Resources resources;
        if (this.e == null) {
            Configuration configuration = this.f28d;
            if (configuration == null) {
                resources = super.getResources();
            } else if (Build.VERSION.SDK_INT >= 17) {
                resources = createConfigurationContext(configuration).getResources();
            }
            this.e = resources;
        }
        return this.e;
    }

    private void c() {
        boolean z = this.f26b == null;
        if (z) {
            this.f26b = getResources().newTheme();
            Resources.Theme theme = getBaseContext().getTheme();
            if (theme != null) {
                this.f26b.setTo(theme);
            }
        }
        d(this.f26b, this.f25a, z);
    }

    @Override // android.content.ContextWrapper
    protected void attachBaseContext(Context context) {
        super.attachBaseContext(context);
    }

    public int b() {
        return this.f25a;
    }

    protected void d(Resources.Theme theme, int i, boolean z) {
        theme.applyStyle(i, true);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public AssetManager getAssets() {
        return getResources().getAssets();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Resources getResources() {
        return a();
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Object getSystemService(String str) {
        if ("layout_inflater".equals(str)) {
            if (this.f27c == null) {
                this.f27c = LayoutInflater.from(getBaseContext()).cloneInContext(this);
            }
            return this.f27c;
        }
        return getBaseContext().getSystemService(str);
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public Resources.Theme getTheme() {
        Resources.Theme theme = this.f26b;
        if (theme != null) {
            return theme;
        }
        if (this.f25a == 0) {
            this.f25a = a.a.i.Theme_AppCompat_Light;
        }
        c();
        return this.f26b;
    }

    @Override // android.content.ContextWrapper, android.content.Context
    public void setTheme(int i) {
        if (this.f25a != i) {
            this.f25a = i;
            c();
        }
    }
}
