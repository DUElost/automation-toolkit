package b.f.a;

import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import com.leon.lfilepickerlibrary.ui.LFilePickerActivity;
/* loaded from: classes.dex */
public class a {

    /* renamed from: a  reason: collision with root package name */
    private Activity f1609a;

    /* renamed from: b  reason: collision with root package name */
    private Fragment f1610b;

    /* renamed from: c  reason: collision with root package name */
    private androidx.fragment.app.Fragment f1611c;

    /* renamed from: d  reason: collision with root package name */
    private String f1612d;
    private String e;
    private String f;
    private int g;
    private int h;
    private boolean i = true;
    private boolean j = true;
    private String k;
    private int l;
    private String[] m;
    private String n;
    private int o;

    private Bundle a() {
        b.f.a.i.a aVar = new b.f.a.i.a();
        aVar.u(this.f1612d);
        aVar.v(this.e);
        aVar.n(this.f);
        aVar.m(this.g);
        aVar.s(this.i);
        aVar.l(this.k);
        aVar.q(this.l);
        aVar.p(this.m);
        aVar.t(this.n);
        aVar.r(this.o);
        aVar.o(this.j);
        Bundle bundle = new Bundle();
        bundle.putSerializable("param", aVar);
        return bundle;
    }

    private Intent b() {
        return this.f1609a != null ? new Intent(this.f1609a, LFilePickerActivity.class) : this.f1610b != null ? new Intent(this.f1610b.getActivity(), LFilePickerActivity.class) : new Intent(this.f1611c.f(), LFilePickerActivity.class);
    }

    public void c() {
        if (this.f1609a == null && this.f1610b == null && this.f1611c == null) {
            throw new RuntimeException("You must pass Activity or Fragment by withActivity or withFragment or withSupportFragment method");
        }
        Intent b2 = b();
        b2.putExtras(a());
        Activity activity = this.f1609a;
        if (activity != null) {
            activity.startActivityForResult(b2, this.h);
            return;
        }
        Fragment fragment = this.f1610b;
        if (fragment != null) {
            fragment.startActivityForResult(b2, this.h);
        } else {
            this.f1611c.i1(b2, this.h);
        }
    }

    public a d(Activity activity) {
        this.f1609a = activity;
        return this;
    }

    public a e(String[] strArr) {
        this.m = strArr;
        return this;
    }

    public a f(boolean z) {
        this.i = z;
        return this;
    }

    public a g(int i) {
        this.h = i;
        return this;
    }

    public a h(String str) {
        this.f1612d = str;
        return this;
    }
}
